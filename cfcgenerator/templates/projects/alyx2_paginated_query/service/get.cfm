	public function get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#()
	{
		return read(argumentCollection = arguments);
	}


	public function get#request.templateUtils.pluralize(request.templateUtils.camelCase(root.bean.xmlAttributes.name))#()
	{
		return queryToArray(data = variables.dao.read(argumentCollection = arguments), queryArguments = arguments);
	}

