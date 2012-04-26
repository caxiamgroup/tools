
	<%cffunction name="read" access="public" output="false" returntype="#request.templateUtils.formatName(root.bean.xmlAttributes.path)#"%>
		<%cfargument name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#" type="#request.templateUtils.formatName(root.bean.xmlAttributes.path)#" required="true"/%>

		<%cfset var data = ""/%>

		<%cfquery name="data" datasource="%variables.dsn%"%>
			SELECT     <cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.identity neq true and root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "status"><cfif displayed gt 0>,
			           </cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#</cfif></cfloop>
			FROM       #root.bean.dbTable.xmlAttributes.name#
			WHERE      <cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey eq "Yes">#root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"/%></cfif></cfloop><cfif request.templateUtils.hasStatus(root.bean.dbtable.xmlChildren)>
			AND        status = <%cfqueryparam value="%variables.STATUS_ACTIVE%"/%></cfif>
		<%/cfquery%>

		<%cfreturn arguments.#request.templateUtils.formatName(root.bean.xmlAttributes.name)#.init(argumentCollection = queryRowToStruct(data))/%>
	<%/cffunction%>
