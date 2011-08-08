<cfoutput>
<%cfcomponent name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#DAO" extends="models.baseDAO" output="false"%>

	<%cffunction name="init" output="false"%>
		<%cfreturn this/%>
	<%/cffunction%>

	<!-- custom code -->

<%/cfcomponent%>
</cfoutput>