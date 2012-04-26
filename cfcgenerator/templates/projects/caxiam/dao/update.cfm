
	<%cffunction name="update" access="public" output="false" returntype="void"%>
		<%cfargument name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#" type="#request.templateUtils.formatName(root.bean.xmlAttributes.path)#" required="true"/%>

		<%cfquery datasource="%variables.dsn%"%>
				UPDATE  #root.bean.dbTable.xmlAttributes.name#
				SET     <cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.identity neq true and root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey neq true and root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus"><cfif displayed gt 0>,
				        </cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"<cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.required neq "Yes"> null="%not Len(arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#())%"</cfif>/%></cfif></cfloop>
				WHERE   <cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey eq "Yes"><cfif displayed gt 0>
				AND     </cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"/%></cfif></cfloop>
				<cfif request.templateUtils.hasRecordStatus(root.bean.dbtable.xmlChildren)>
				AND     recordStatus = <%cfqueryparam value="%variables.RECORDSTATUS_ACTIVE%"/%></cfif>
			<%/cfquery%>
		<%cfreturn/%>
	<%/cffunction%>
