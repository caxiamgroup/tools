component extends="alyx.controllers.common" output="false"
{

	private function getProjects(path = "/")
	{
		local.directories = [];
		local.applications = DirectoryList(
			arguments.path,
			true,
			"path",
			"Application.cfc",
			"asc"
		);

		for (local.application in local.applications)
		{
			local.application = Replace(local.application, "Application.cfc", "", "one");

			if (DirectoryExists(local.application & "views"))
			{
				local.directory = {};
				local.directory.path = local.application;
				local.directory.name = Replace(local.application, arguments.path, "", "one");
				local.directory.name = listChangeDelims(local.directory.name, "/", "\");
				local.directory.name = listChangeDelims(local.directory.name, ".", "/");
				ArrayAppend(local.directories, local.directory);
			}
		}

		return local.directories;
	}

	private function getViews(path = "/")
	{
		local.views = [];
		local.files = DirectoryList(
			arguments.path,
			true,
			"path",
			"*.cfm",
			"asc"
		);

		for (local.file in local.files)
		{
			local.file = Replace(local.file, arguments.path, "", "one");
			local.file = ListFirst(local.file, ".");
			local.file = listChangeDelims(local.file, "/", "\");
			ArrayAppend(local.views, local.file);
		}

		return local.views;
	}

	private function getStaticProperty(required propertyName, class = this)
	{
		if (IsSimpleValue(arguments.class))
		{
			local.metadata = getComponentMetadata(arguments.class);
		}
		else
		{
			local.metadata = getMetadata(arguments.class);
		}

		if (!StructKeyExists(local.metadata, arguments.propertyName))
		{
			Throw(type="NONEXISTANT_STATIC_PROPERTY");
		}

		return local.metadata[arguments.propertyName];
	}

}