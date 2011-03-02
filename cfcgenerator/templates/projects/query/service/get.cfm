	public function get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#()
	{
		return read(argumentCollection = arguments);
	}


	public function get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#s()
	{
		return queryToArray(variables.dao.read(argumentCollection = arguments));
	}

