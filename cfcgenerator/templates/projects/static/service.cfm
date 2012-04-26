<cfoutput>
component name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#Service" extends="models.baseService"
{
	public function init()
	{
		variables.dao = new #request.templateUtils.formatName(root.bean.xmlAttributes.name)#DAO();
		super.init(argumentCollection = arguments);
		return this;
	}

	<!-- custom code -->

	public function add#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#FieldsToForm( required form )
	{
	<cfloop from="1" to="#ArrayLen(root.bean.dbtable.xmlChildren)#" index="i">
		<cfif root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "recordStatus" and
			  root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "ts_created" and
			  root.bean.dbtable.xmlChildren[i].xmlAttributes.name neq "ts_updated" and
			  Right(root.bean.dbtable.xmlChildren[i].xmlAttributes.name, 2) neq "Id"
		>
		arguments.form.addField(
			name = "#root.bean.dbtable.xmlChildren[i].xmlAttributes.name#",
			label = "#request.templateUtils.formatLabel(root.bean.dbtable.xmlChildren[i].xmlAttributes.name)#",
			type = "#root.bean.dbtable.xmlChildren[i].xmlAttributes.type#",
			required = "true",
			maxLength = #root.bean.dbtable.xmlChildren[i].xmlAttributes.length#
		);
		</cfif>
	</cfloop>
		return arguments.form;
	}
}
</cfoutput>