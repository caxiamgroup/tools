<cfoutput>
<%cfcomponent name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#Service" extends="models.baseService" output="false"%>

	<%cffunction name="init" access="public" output="false"%>
		<%cfset super.init(argumentCollection = arguments)/%>

		<%cfreturn this/%>
	<%/cffunction%>

	<!-- custom code -->
<%/cfcomponent%>
</cfoutput>