component  extends="controllers.common"
{

	public function index(required rc, required vc)
	{
		local.form = getForm("projectLocation");
		local.form.addField(name="location", label="Folder Location", type="string", required=true, defaultValue=getDefaultPath());

		if (local.form.wasSubmitted())
		{
			local.form.validate();

			local.directoryLocation = local.form.getFieldValue("location");

			if (!DirectoryExists(local.directoryLocation))
			{
				local.form.addError("The directory you are trying to create the project on doesn't exist.");
			}

			if (!local.form.hasErrors())
			{
				try
				{
					local.templatePath = ExpandPath("./template");
					local.directoryList = DirectoryList(local.templatePath, true, "query");
					local.directoryList.sort("type", 1);
					while (local.directoryList.next())
					{
						local.newPath = ListChangeDelims(local.directoryLocation & Replace(local.directoryList.directory, local.templatePath, "", "all"), "\", "/") & "\" & local.directoryList.name;

						if (local.directoryList.type == "File")
						{
							local.sourcePath = local.directoryList.directory & "\" & local.directoryList.name;
							FileCopy(local.sourcePath, local.newPath);
						}
						else if (local.directoryList.type == "Dir")
						{
							DirectoryCreate(local.newPath);
						}
					}
					local.form.setSuccessMessage("The Files have been written!");
				}
				catch (Any error)
				{
					local.form.addError(error.message);
				}
			}
		}

		vc.form = local.form;
	}

	private function getDefaultPath()
	{
		if (IsNull(variables.path))
		{
			variables.path = ListChangeDelims(getMetadata(variables.alyx).extends.path, "\", "/");

			for (local.i = 1; local.i <= 3; local.i++)
			{
				variables.path = listDeleteAt(variables.path, ListLen(variables.path, "\"), "\");
			}
		}

		return variables.path;
	}

}