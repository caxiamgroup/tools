
	<%cffunction name="get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#s" access="public" output="false" returntype="array"%>
		<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "status"><%cfargument name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" required="false"/%>
		</cfif></cfloop>
		<%cfreturn variables.dao.getByAttributes(argumentCollection = arguments)/%>
	<%/cffunction%>
