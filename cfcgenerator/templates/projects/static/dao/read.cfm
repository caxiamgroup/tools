
	<%cffunction name="read" output="no"%>
		<%cfquery name="local.data" dbtype="query"%>
			SELECT
			*
			FROM       variables.data
			WHERE      <cfif request.templateUtils.hasRecordStatus(root.bean.dbtable.xmlChildren)>recordStatus = <%cfqueryparam value="%variables.RECORDSTATUS_ACTIVE%"/%>
		<cfelse>1 = 1
		</cfif><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus"><%cfif StructKeyExists(arguments, "#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#")%>
			AND        #root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"<cfif IsNumeric(root.bean.dbtable.xmlChildren[i].xmlAttributes.scale)> scale="#root.bean.dbtable.xmlChildren[i].xmlAttributes.scale#"</cfif><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.required neq "Yes"> null="%not Len(arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#)%"</cfif>/%>
		<%/cfif%>
		</cfif></cfloop><%cfif StructKeyExists(arguments, "orderBy") and Len(arguments.orderBy)%>
			ORDER BY   %arguments.orderBy%
		<%/cfif%>
		<%cfif StructKeyExists(arguments, "pageIndex") && StructKeyExists(arguments, "pageSize")%>
			LIMIT %VAL((arguments.pageIndex - 1) * arguments.pageSize)%, %VAL(arguments.pageSize)%
		<%/cfif%>
		<%/cfquery%>

		<%cfreturn local.data/%>
	<%/cffunction%>


	<%cffunction name="getResultRecordCount" output="false"%>
		<%cfquery name="local.data" dbtype="query"%>
			SELECT COUNT(*) as myCount
			FROM       variables.data
			WHERE      <cfif request.templateUtils.hasRecordStatus(root.bean.dbtable.xmlChildren)>recordStatus = <%cfqueryparam value="%variables.RECORDSTATUS_ACTIVE%"/%>
		<cfelse>1 = 1
		</cfif><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus"><%cfif StructKeyExists(arguments, "#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#")%>
			AND        #root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"<cfif IsNumeric(root.bean.dbtable.xmlChildren[i].xmlAttributes.scale)> scale="#root.bean.dbtable.xmlChildren[i].xmlAttributes.scale#"</cfif><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.required neq "Yes"> null="%not Len(arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#)%"</cfif>/%>
		<%/cfif%>
		</cfif></cfloop>
		<%/cfquery%>

		<%cfreturn local.data.myCount/%>
	<%/cffunction%>

