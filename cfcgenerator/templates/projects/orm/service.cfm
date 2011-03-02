<cfoutput>
component name="#request.templateUtils.formatName(root.bean.xmlAttributes.name)#Service" extends="models.baseService" output="false"
{
	public function init()
	{
		variables.dao = new #request.templateUtils.formatName(root.bean.xmlAttributes.name)#DAO("#request.templateUtils.formatName(root.bean.xmlAttributes.name)#", "#root.bean.dbtable.xmlAttributes.name#");
		super.init(argumentCollection = arguments);
		return this;
	}

	<!-- custom code -->

}
</cfoutput>