<cfcomponent extends="generatorService" output="false">

	<cffunction name="setAdminPassword" access="public" returntype="boolean" output="false">
		<cfargument name="adminPass" type="string" required="true" />
		<cfargument name="datasource" type="string" default="" />

		<cfset var success = true />
		<cfset var dsns = "" />
		<cfset var objDatasource = "" />
		<cfset var thisType = "" />

		<cfset variables.adminPass = arguments.adminPass/>
		<cfset variables.arrDSNs = ArrayNew(1)/>

		<cftry>
			<cfadmin action="getDatasources" returnVariable="dsns" password="#arguments.adminPass#" type="web" />

			<cfloop query="dsns">
				<cfset thisType = classToType(classname) />
				<cfif len(thisType)>
					<cfset objDatasource = createObject("component","datasource.datasource").init(name,thisType) />
					<cfset arrayAppend(variables.arrDSNs, objDatasource) />
				</cfif>
			</cfloop>

			<cfcatch type="any">
				<cfset success = false />
			</cfcatch>
		</cftry>
		<cfreturn success />
	</cffunction>

	<cffunction name="getDSNs" access="public" returntype="array" output="false">
		<cfreturn variables.arrDSNs/>
	</cffunction>
	
	<cffunction name="getDSN" access="public" returntype="cfcgenerator.com.cf.model.datasource.datasource" output="false">
		<cfargument name="dsn" type="string" required="yes" />
		
		<cfset var returnDSN = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#arrayLen(variables.arrDSNs)#" index="i">
			<cfif variables.arrDSNs[i].getDsnName() EQ arguments.dsn>
				<cfset returnDSN = variables.arrDSNs[i] />
			</cfif>
		</cfloop>
		<cfreturn returnDSN />
	</cffunction>
	
	<cffunction name="getTables" access="public" returntype="array" output="false">
		<cfargument name="dsn" type="string" required="yes" />
		<cfreturn getDbms(arguments.dsn).getTables() />
	</cffunction>

	<cffunction name="getDbms" access="private" output="no">
		<cfargument name="dsn" type="string" required="yes" />
		<cfreturn getDSN(arguments.dsn).getDbms()/>
	</cffunction>

	<cffunction name="classToType" access="private" output="false" returntype="string">
		<cfargument name="classname" required="true" type="string" />
		
		<cfif arguments.classname contains "mySQL">
			<cfreturn "mysql" />
		<cfelseif arguments.classname contains "Oracle">
			<cfreturn "oracle" />
		<cfelseif arguments.classname contains "Informix">
			<cfreturn "informix" />
		<cfelseif arguments.classname contains "postgresql">
			<cfreturn "postgresql" />
		<cfelseif arguments.classname contains "MSSQLServer" or arguments.classname contains "sqlserver" or arguments.classname contains "jtds">
			<cfreturn "mssql" />
		<cfelse><!--- not a supported type --->
			<cfreturn "" />
		</cfif>
	</cffunction>

</cfcomponent>