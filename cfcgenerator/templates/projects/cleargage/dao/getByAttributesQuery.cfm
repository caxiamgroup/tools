
	<%cffunction name="getByAttributesQuery" access="public" output="false" returntype="query"%>
		<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "status"><%cfargument name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" default=""/%>
		</cfif></cfloop><%cfargument name="orderBy" required="false"/%>

		<%cfset var data = ""/%>

		<%cfquery name="data" datasource="%variables.dsn%"%>
			SELECT     <cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.identity neq true and root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "status"><cfif displayed gt 0>,
			           </cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#</cfif></cfloop>
			FROM       #root.bean.dbTable.xmlAttributes.name#
			WHERE      <cfif request.templateUtils.hasStatus(root.bean.dbtable.xmlChildren)>status = <%cfqueryparam value="%variables.STATUS_ACTIVE%"/%>
		<cfelse>1 = 1
		</cfif><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "status"><%cfif Len(arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#)%>
			AND        #root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"/%>
		<%/cfif%>
		</cfif></cfloop><%cfif StructKeyExists(arguments, "orderBy") and Len(arguments.orderBy)%>
			ORDER BY   %arguments.orderBy%
		<%/cfif%>
		<%/cfquery%>

		<%cfreturn data/%>
	<%/cffunction%>