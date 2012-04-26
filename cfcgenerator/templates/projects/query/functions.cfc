<cfcomponent extends="cfcgenerator.templates.projects.functions"><cfscript>

	function init(stripPrefix)
	{
		variables.stripPrefix = arguments.stripPrefix;
		return super.init(argumentCollection = arguments);
	}

	function camelCase(value)
	{
		if (Len(variables.stripPrefix))
		{
			arguments.value = ReReplace(arguments.value, "^" & variables.stripPrefix, "");
		}
		return super.camelCase(arguments.value);
	}

	function formatName(value)
	{
		if (Len(variables.stripPrefix))
		{
			arguments.value = ReReplace(arguments.value, "^" & variables.stripPrefix, "");
		}
		arguments.value = lowerCase(arguments.value);

		return super.formatName(arguments.value);
	}
	function lowerCase(value)
	{
		return LCase(Left(arguments.value, 1)) & Right(arguments.value, Len(arguments.value)-1);
	}

</cfscript></cfcomponent>