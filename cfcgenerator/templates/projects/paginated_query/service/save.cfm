	public function save#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#(required bean, forceInsert = false)
	{
		if (! Len(arguments.bean.get#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#Id()) || arguments.forceInsert)
		{
			variables.dao.insert(arguments.bean);
		}
		else
		{
			variables.dao.update(arguments.bean);
		}
	}

