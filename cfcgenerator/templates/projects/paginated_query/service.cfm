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
}
</cfoutput>