	public function delete#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#()
	{
		delete(argumentCollection = arguments);
	}

	public function delete#request.templateUtils.pluralize(request.templateUtils.camelCase(root.bean.xmlAttributes.name))#(required beanArray)
	{
		if( !IsInstanceOf(arguments.bean, "#root.bean.xmlAttributes.name#"))
		{
			Throw(type="SERVICE_BEAN_TYPE_ERROR", message="The bean you tried to save was not of the appropriate data type");
		}

		for(local.bean in arguments.beanArray)
		{
			delete#request.templateUtils.camelCase(root.bean.xmlAttributes.name)#(local.bean);
		}
	}

