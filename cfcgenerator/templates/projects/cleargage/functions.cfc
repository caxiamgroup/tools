<cfcomponent extends="cfcgenerator.templates.projects.functions">

	<cffunction name="hasStatus" output="false">
		<cfargument name="columns" required="yes"/>
		<cfset var local = StructNew()/>
		<cfloop array="#arguments.columns#" index="local.column">
			<cfif local.column.XmlAttributes.name eq "status">
				<cfreturn true/>
			</cfif>
		</cfloop>
		<cfreturn false/>
	</cffunction>

	<cffunction name="hasPriPhone" output="false">
		<cfargument name="columns" required="yes"/>
		<cfset var local = StructNew()/>
		<cfloop array="#arguments.columns#" index="local.column">
			<cfif local.column.XmlAttributes.name eq "priPhoneArea">
				<cfreturn true/>
			</cfif>
		</cfloop>
		<cfreturn false/>
	</cffunction>

</cfcomponent>