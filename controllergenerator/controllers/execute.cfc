<cfcomponent>

	<cffunction name="init">
		<cfset test = {}/>
		<cfset StructAppend(test, arguments)/>

		<cfexecute attributecollection ="#test#" />
	</cffunction>

</cfcomponent>