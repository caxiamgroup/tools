<cfoutput>
component accessors="true"
{
	<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i"><cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus">property name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#" type="<cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.type eq "uuid">string<cfelse>#root.bean.dbtable.xmlChildren[i].xmlAttributes.type#</cfif>";
	</cfif></cfloop>
}
</cfoutput>