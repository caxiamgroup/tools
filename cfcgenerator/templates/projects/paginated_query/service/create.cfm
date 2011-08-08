	package function create()
	{
		return new #request.templateUtils.formatName(root.bean.xmlAttributes.name)#();
	}
