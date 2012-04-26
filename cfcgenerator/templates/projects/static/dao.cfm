<cfoutput>
<%cfcomponent name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#DAO" extends="models.baseDAO" output="false"%>

	<%cffunction name="init" output="false"%>
		<%cfset cacheStatic()/%>
		<%cfreturn this/%>
	<%/cffunction%>

	<!-- custom code -->

<%/cfcomponent%>
</cfoutput>