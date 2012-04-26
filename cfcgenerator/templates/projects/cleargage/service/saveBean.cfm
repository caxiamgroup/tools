
	<%cffunction name="save#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#" access="public" output="false" returntype="void"%>
		<%cfargument name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#" required="true"/%>

		<%cfset save(arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#)/%>
	<%/cffunction%>
