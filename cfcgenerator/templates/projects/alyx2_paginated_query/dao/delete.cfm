﻿
	<%cffunction name="delete" output="no"%>
		<%cfargument name="bean"/%>

		<%cfquery%><cfif request.templateUtils.hasRecordStatus(root.bean.dbtable.xmlChildren)>
			UPDATE     #root.bean.dbTable.xmlAttributes.name#
			SET        recordStatus = 0
			WHERE      <cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey eq "Yes"><cfif displayed gt 0>
			AND        </cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.bean.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"/%></cfif></cfloop>
			<cfelse>DELETE
			FROM       #root.bean.dbTable.xmlAttributes.name#
			WHERE      <cfset displayed = 0/><cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey eq "Yes"><cfif displayed gt 0>
			AND        </cfif><cfset ++displayed/>#root.bean.dbtable.xmlChildren[i].xmlAttributes.name# = <%cfqueryparam value="%arguments.bean.get#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#()%" CFSQLType="#root.bean.dbtable.xmlChildren[i].xmlAttributes.cfSqlType#"/%></cfif></cfloop>
			</cfif>
		<%/cfquery%>
	<%/cffunction%>
