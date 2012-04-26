<cfoutput>
<%?xml version="1.0" encoding="UTF-8"?%>

<%beans%>

	<%bean id="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#DAO" class="models.#request.templateUtils.formatName(root.bean.xmlAttributes.path)#.#request.templateUtils.formatName(root.bean.xmlAttributes.path)#DAO"%>
		<%constructor-arg name="dsn"%><%value%>${DSN}<%/value%><%/constructor-arg%>
		<%constructor-arg name="table"%><%value%>#root.bean.xmlAttributes.name#<%/value%><%/constructor-arg%>
		<%constructor-arg name="type"%><%value%>#request.templateUtils.formatName(root.bean.xmlAttributes.name)#<%/value%><%/constructor-arg%>
	<%/bean%>
	<%bean id="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#Service" class="models.#request.templateUtils.formatName(root.bean.xmlAttributes.path)#.#request.templateUtils.formatName(root.bean.xmlAttributes.path)#Service" lazy-init="false"%>  
		<%constructor-arg name="dao"%><%ref bean="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#DAO"/%><%/constructor-arg%>
	<%/bean%>  

<%/beans%>
</cfoutput>
