<cfoutput>
component mappedSuperClass="true" output="false"
{
	<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i">property name="#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#"<cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.primaryKey> fieldtype="id" generator="assigned"</cfif>;
	</cfloop>

	public function init()
	{
		return this;
	}
	<cfif request.templateUtils.hasColumn(root.bean.dbtable.xmlChildren, "created")>
	function preInsert()
	{
		setCreated(Now());
	}
	</cfif>
	<cfif request.templateUtils.hasColumn(root.bean.dbtable.xmlChildren, "updated")>
	function preUpdate()
	{
		setUpdated(Now());
	}
	</cfif>
}
</cfoutput>