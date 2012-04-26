	<%cffunction name="create#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#" access="public" output="false" returntype="#request.templateUtils.formatName(root.bean.xmlAttributes.path)#"%>
		<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "status"><%cfargument name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" required="false"/%>
		</cfif></cfloop>
		<%cfreturn CreateObject("component", "#request.templateUtils.formatName(root.bean.xmlAttributes.path)#").init(argumentCollection = arguments)/%>
	<%/cffunction%>
