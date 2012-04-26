	<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus">
	<%cffunction name="set#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#" access="public" returntype="void" output="false"%>
		<%cfargument name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" required="true"/%>
		<%cfset variables.instance.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#/%>
	<%/cffunction%>
	<%cffunction name="get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#" access="public" returntype="string" output="false"%>
		<%cfreturn variables.instance.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#/%>
	<%/cffunction%>
</cfif></cfloop>
