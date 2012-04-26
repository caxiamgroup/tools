<cfcomponent output="false">

	<cffunction name="init" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="capFirst" output="false">
		<cfargument name="value" required="yes"/>
		<cfreturn UCase(Left(arguments.value, 1)) & Right(arguments.value, Len(arguments.value) - 1)/>
	</cffunction>

	<cffunction name="camelCase" output="false">
		<cfargument name="value" required="yes"/>
		<cfset var results = ""/>
		<cfset var word = ""/>
		<cfloop array="#ListToArray(arguments.value, "_")#" index="word">
			<cfset results &= capFirst(word)/>
		</cfloop>
		<cfreturn results/>
	</cffunction>

	<cffunction name="formatName" output="false">
		<cfargument name="value" required="yes"/>
		<cfset var results = ""/>
		<cfset var word = ""/>
		<cfloop array="#ListToArray(arguments.value, "_")#" index="word">
			<cfif Len(results)>
				<cfset results &= capFirst(word)/>
			<cfelse>
				<cfset results &= word/>
			</cfif>
		</cfloop>
		<cfreturn results/>
	</cffunction>
</cfcomponent>