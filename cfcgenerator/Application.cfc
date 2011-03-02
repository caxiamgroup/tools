<cfcomponent>
	<cfset this.name = Hash(GetCurrentTemplatePath())/>
	<cfset this.mappings['/cfcgenerator'] = ExpandPath(".")/>
	<cfset this.sessionManagement = true/>
	<cfset this.sessionTimeout = CreateTimeSpan(0, 4, 0, 0)/>

	<cffunction name="onApplicationStart">
		<cfset var templateBasePath = ExpandPath("/cfcgenerator/templates/")/>
		<cfset var servicePath = "cfcgenerator.com.cf.model.generatorService"/>

		<cfif IsDefined("server.railo.version")>
			<cfset servicePath &= "Railo"/>
		</cfif>

		<cfset application.utils = createObject("component", "cfcgenerator.com.cf.utils").init()/>
		<cfset application.generatorService = createObject("component", servicePath).init(templateBasePath)/>
		<cfset application.directoryService = createObject("component", "cfcgenerator.com.cf.model.directory.directoryService").init()/>
	</cffunction>

	<cffunction name="onRequestStart" returnType="void">
		<cfif StructKeyExists(url, "restart")>
			<cfset onApplicationStart()/>
			<cfset StructDelete(session, "adminPassword")/>
		</cfif>

		<!--- Uncomment to have generatorService rebuilt on every request --->
		<!---
		<cfif StructKeyExists(session, "adminPassword")>
			<cfset onApplicationStart()/>
			<cfset application.generatorService.setAdminPassword(session.adminPassword)/>
		</cfif>
		--->
	</cffunction>

	<cffunction name="onError">
		<cfargument name="Except" required="true"/>

		<cfif IsDefined("arguments.Except.RootCause.Type") and arguments.Except.RootCause.Type eq "coldfusion.runtime.AbortException">
			<cfreturn>
		</cfif>

		<cfdump var="#arguments.Except#"/>
		<cfabort/>
	</cffunction>
</cfcomponent>
