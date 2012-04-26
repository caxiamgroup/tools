<cfoutput>
<%cfcomponent displayname="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#" output="false"%>
	<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus"><%cfproperty name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" type="<cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.type eq "uuid">string<cfelse>#root.bean.dbtable.xmlChildren[i].xmlAttributes.type#</cfif>" default=""/%>
	</cfif></cfloop>
	<%cfset variables.instance = StructNew()/%>

	<%cffunction name="init" access="public" returntype="#request.templateUtils.formatName(root.bean.xmlAttributes.path)#" output="false"%>
		<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus"><%cfargument name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" default=""/%>
		</cfif></cfloop>
		<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus">
		<%cfset set#request.templateUtils.camelCase(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#(arguments.#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#)/%></cfif></cfloop>

		<%cfreturn this/%>
 	<%/cffunction%>
	<!-- custom code -->
<%/cfcomponent%>
</cfoutput>