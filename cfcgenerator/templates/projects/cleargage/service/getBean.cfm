
	<%cffunction name="get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#" access="public" output="false" returntype="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#"%>
		<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey eq "Yes"><%cfargument name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" required="true"/%>
		</cfif></cfloop>
		<%cfset var #request.templateUtils.formatName(root.bean.xmlAttributes.name)# = create#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#(argumentCollection = arguments)/%>
		<%cfset variables.dao.read(#request.templateUtils.formatName(root.bean.xmlAttributes.name)#)/%>
		<%cfreturn #request.templateUtils.formatName(root.bean.xmlAttributes.name)#/%>
	<%/cffunction%>
