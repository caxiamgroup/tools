	<%cffunction name="executeReadHQL" access="public" output="false"%>
		<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus"><%cfargument name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" default=""/%>
		</cfif></cfloop><%cfargument name="orderBy" required="false"/%>

		<%cfset var data = ""/%>
		<%cfset local.queryOptions = {}%>

		<%cfif StructKeyExists(arguments, "maxResults") and Len(arguments.maxResults)%>
			<%cfset local.queryOptions.maxResults = arguments.maxResults%>
		<%/cfif%>

		<%cfif StructKeyExists(arguments, "offset") and Len(arguments.offset)%>
			<%cfset local.queryOptions.offset = arguments.offset%>
		<%/cfif%>

		<%cfquery name="data" dbtype="hql" ormoptions="%local.queryOptions%"%>
		<%cfif StructKeyExists(arguments, "selectList") and Len(arguments.selectList)%>
			SELECT     %arguments.selectList%
		<%/cfif%>
			FROM       #request.templateUtils.formatName(root.bean.xmlAttributes.name)#
			WHERE      <cfif request.templateUtils.hasRecordStatus(root.bean.dbtable.xmlChildren)>recordStatus = <%cfqueryparam value="%variables.RECORDSTATUS_ACTIVE%"/%>
		<cfelse>1 = 1
		</cfif><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus"><%cfif Len(arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#)%>
			AND        #root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"/%>
		<%/cfif%>
		</cfif></cfloop><%cfif StructKeyExists(arguments, "orderBy") and Len(arguments.orderBy)%>
			ORDER BY   %arguments.orderBy%
		<%/cfif%>
		<%/cfquery%>

		<%cfreturn data/%>
	<%/cffunction%>
