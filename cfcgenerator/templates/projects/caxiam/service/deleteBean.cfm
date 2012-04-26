
	<%cffunction name="delete#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#" access="public" output="false" returntype="void"%>
		<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey eq "Yes"><%cfargument name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" required="true"/%>
		</cfif></cfloop>
		<%cfset delete(arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#Id)/%>
	<%/cffunction%>
