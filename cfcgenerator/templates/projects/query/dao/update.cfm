
	<%cffunction name="update" output="false"%>
		<%cfargument name="bean"/%>

		<%cfquery%>
			UPDATE     #root.bean.dbTable.xmlAttributes.name#
			SET        <cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.identity neq true and root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey neq true and root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus"><cfif displayed gt 0>,
			           </cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.bean.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"<cfif IsNumeric(root.bean.dbtable.xmlChildren[i].xmlAttributes.scale)> scale="#root.bean.dbtable.xmlChildren[i].xmlAttributes.scale#"</cfif><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.required neq "Yes"> null="%not Len(arguments.bean.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#())%"</cfif>/%></cfif></cfloop>
			WHERE      <cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey eq "Yes"><cfif displayed gt 0>
			AND        </cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.bean.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"/%></cfif></cfloop>
			<cfif request.templateUtils.hasRecordStatus(root.bean.dbtable.xmlChildren)>
			AND        recordStatus = <%cfqueryparam value="%variables.RECORDSTATUS_ACTIVE%"/%></cfif>
		<%/cfquery%>
	<%/cffunction%>
