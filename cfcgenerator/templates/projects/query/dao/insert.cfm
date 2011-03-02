	<%cffunction name="insert" access="public" output="false"%>
		<%cfargument name="bean"/%>

		<%cfif not Len(arguments.bean.get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#Id())%>
			<%cfset arguments.bean.set#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#Id(CreateUuid())/%>
		<%/cfif%>

		<%cfquery%>
			INSERT INTO #root.bean.dbtable.xmlAttributes.name#
			(
				<cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.identity neq true><cfif displayed gt 0>,
				</cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#</cfif></cfloop>
			)
			VALUES
			(
				<cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.identity neq true><cfif displayed gt 0>,
				</cfif><cfset ++displayed/><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name eq "recordStatus"><%cfqueryparam value="%variables.RECORDSTATUS_ACTIVE%"/%><cfelse><%cfqueryparam value="%arguments.bean.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"<cfif IsNumeric(root.bean.dbtable.xmlChildren[i].xmlAttributes.scale)> scale="#root.bean.dbtable.xmlChildren[i].xmlAttributes.scale#"</cfif><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.required neq "Yes"> null="%not Len(arguments.bean.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#())%"</cfif>/%></cfif></cfif></cfloop>
			)
		<%/cfquery%>
	<%/cffunction%>
