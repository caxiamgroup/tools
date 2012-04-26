	<%cffunction name="create" access="public" output="false" returntype="void"%>
		<%cfargument name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#" type="#request.templateUtils.formatName(root.bean.xmlAttributes.path)#" required="true"/%>

		<%cfset var uniqueId = CreateUuid()/%>
		<%cfset arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#.set#request.templateUtils.camelCase(root.bean.dbtable.xmlAttributes.name)#Id(uniqueId)/%>

		<%cfquery datasource="%variables.dsn%"%>
			INSERT INTO #root.bean.dbtable.xmlAttributes.name#
			(
				<cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.identity neq true><cfif displayed gt 0>,
				</cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#</cfif></cfloop>
			)
			VALUES
			(
				<cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.identity neq true><cfif displayed gt 0>,
				</cfif><cfset ++displayed/><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name eq "recordStatus"><%cfqueryparam value="%variables.RECORDSTATUS_ACTIVE%"/%><cfelse><%cfqueryparam value="%arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"<cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.required neq "Yes"> null="%not Len(arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#())%"</cfif>/%></cfif></cfif></cfloop>
			)
		<%/cfquery%>
	<%/cffunction%>
