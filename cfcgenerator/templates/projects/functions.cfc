<cfcomponent>

	<cffunction name="init" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="capFirst" output="false">
		<cfargument name="value" required="yes"/>

		<cfif Len(arguments.value) eq 1>
			<cfreturn UCase(arguments.value) />
		<cfelse>
			<cfreturn UCase(Left(arguments.value, 1)) & Right(arguments.value, Len(arguments.value) - 1)/>
		</cfif>
	</cffunction>

	<cffunction name="camelCase" output="false">
		<cfargument name="value" required="yes"/>
		<cfset var results = ""/>
		<cfset var word = ""/>
		<cfloop array="#ListToArray(arguments.value, "_")#" index="word">
			<cfset results &= request.templateUtils.capFirst(word)/>
		</cfloop>
		<cfreturn results/>
	</cffunction>

	<cffunction name="formatName" output="false">
		<cfargument name="value" required="yes"/>
		<cfset var results = ""/>
		<cfset var word = ""/>
		<cfloop array="#ListToArray(arguments.value, "_")#" index="word">
			<cfif Len(results)>
				<cfset results &= request.templateUtils.capFirst(word)/>
			<cfelse>
				<cfset results &= word/>
			</cfif>
		</cfloop>
		<cfreturn results/>
	</cffunction>

	<cffunction name="hasRecordStatus" output="false">
		<cfargument name="columns" required="yes"/>
		<cfreturn hasColumn(arguments.columns, "recordStatus")/>
	</cffunction>

	<cffunction name="hasColumn" output="false">
		<cfargument name="columns" required="yes"/>
		<cfargument name="column" required="yes"/>
		<cfset var local = StructNew()/>
		<cfloop array="#arguments.columns#" index="local.column">
			<cfif local.column.XmlAttributes.name eq arguments.column>
				<cfreturn true/>
			</cfif>
		</cfloop>
		<cfreturn false/>
	</cffunction>

	<cffunction name="getColumns" output="false">
		<cfargument name="columns" required="yes"/>
		<cfargument name="exclude" default=""/>
		<cfset var local = StructNew()/>
		<cfset local.columns = ArrayNew(1)/>
		<cfloop array="#arguments.columns#" index="local.column">
			<cfif not Len(arguments.exclude) or not ListFindNoCase(arguments.exclude, local.column.XmlAttributes.name)>
				<cfset ArrayAppend(local.columns, local.column)/>
			</cfif>
		</cfloop>
		<cfreturn local.columns/>
	</cffunction>

</cfcomponent>