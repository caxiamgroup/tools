	public function save#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#(required bean, forceInsert = false)
	{
		if( !IsInstanceOf(arguments.bean, "#root.bean.xmlAttributes.name#") )
		{
			Throw(object = variables.NONEXISTANT_FUNCTION_ON_SERVICE_ERROR);
		}

		if (! Len(arguments.bean.get#request.templateUtils.camelCase(request.templateUtils.getPrimaryKey(root.bean.dbtable))#()) || arguments.forceInsert)
		{
			variables.dao.insert(arguments.bean);
		}
		else
		{
			variables.dao.update(arguments.bean);
		}
	}

	public function save#request.templateUtils.pluralize(request.templateUtils.camelCase(root.bean.xmlAttributes.name))#(required beanArray)
	{
		for(local.bean in arguments.beanArray)
		{
			save#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#(local.bean);
		}
	}

