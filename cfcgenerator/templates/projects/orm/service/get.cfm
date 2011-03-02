	public function get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#()
	{
		return read(argumentCollection = arguments);
	}


	public function get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#s()
	{
		return variables.dao.read(argumentCollection = arguments);
	}


	public function get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#sCount()
	{
		arguments.selectList = " COUNT(*) ";
		arguments.offset = "";
		arguments.maxResults = "";
		return variables.dao.executeReadHQL(argumentCollection = arguments)[1];
	}

