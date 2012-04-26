component
	extends = "controllers.common"
	INVALID_PROJECT_NAME = "The project name was invalid"
{

	public function index(required rc, required vc)
	{
		local.form = getForm("project");
		local.form.addField(name="project", label="Project", type="string", required=true);

		if (local.form.wasSubmitted())
		{
			local.form.validate();
			if (!local.form.hasErrors())
			{
				rc.projectDirectory = local.form.getFieldValue(name="project");
				redirect(action="generateControllers", persist="projectDirectory");
			}
		}

		local.projectPath = application.controller.getSetting("projectsPath");
		local.projects = getProjects(path = local.projectPath);

		local.form.setFieldDataset(name="project", data=local.projects, idField="path", labelField="name");

		vc.myForm = local.form;
	}

	public function generateControllers(required rc, required vc)
	{
		param name="rc.projectDirectory" default="";

		if (!Len(rc.projectDirectory))
		{
			redirect(action="index");
		}

		local.projectName = Replace(rc.projectDirectory, application.controller.getSetting("projectsPath"), "", "one");
		local.projectName = ListChangeDelims(local.projectName, "/", "\");
		local.projectName = ListChangeDelims(local.projectName, "_", "/");

		checkTempDirectory();
		checkProjectDirectory(projectName = local.projectName);

		local.actions = [];
		local.views = getViews(path = rc.projectDirectory & "views");

		for (local.view in local.views)
		{
			if (ListLen(local.view, "/") < 2)
			{
				local.view = ListPrepend(local.view, "general", "/");
			}
			ArrayAppend(local.actions, ListChangeDelims(local.view, ".", "/"));
		}

		local.controllers = {};

		for (local.action in local.actions)
		{
			local.controllerPath = ListDeleteAt(local.action, ListLen(local.action, "."), ".");
			if(!StructKeyExists(local.controllers, local.controllerPath))
			{
				local.controllers[local.controllerPath] = [];
			}
			ArrayAppend(local.controllers[local.controllerPath], Replace(ListLast(local.action, "."), "-", "_", "all"));
		}


		for (local.key in local.controllers)
		{
			local.functions = local.controllers[local.key];
			writeController(projectName = local.projectName, fileAction = local.key, functions = local.functions);
		}


		writeControllerCommon(projectName = local.projectName);

		local.executeArguments = {};
		local.executeArguments.name = "_open";
		local.executeArguments.arguments = "#ExpandPath('/temp/#local.projectName#')#";
		if (FindNoCase("windows", server.os.name))
		{
			local.executeArguments.name = "explorer.exe";
			local.executeArguments.arguments = "#ListChangeDelims(ExpandPath('/temp/#local.projectName#'), "\", "/")#";
		}
		else if (FindNoCase("mac", server.os.name))
		{
			local.executeArguments.name = "open";
		}
		new execute(ArgumentCollection = local.executeArguments);
		redirect("index");
	}

	private function checkTempDirectory()
	{
		if(!DirectoryExists(ExpandPath("/temp")))
		{
			DirectoryCreate(ExpandPath("/temp"));
		}
	}

	private function checkProjectDirectory(projectName="")
	{
		local.directory = ExpandPath("/temp/#arguments.projectName#");
		local.projectDirectoryExists = DirectoryExists(local.directory);
		if (Len(arguments.projectName) && !local.projectDirectoryExists)
		{
			DirectoryCreate(local.directory);
		}
		else if (Len(arguments.projectName) && local.projectDirectoryExists)
		{
			DirectoryDelete(local.directory, true);
			DirectoryCreate(local.directory);
		}
		else
		{
			Throw(type="INVALID_PROJECT_NAME", message=getStaticProperty("INVALID_PROJECT_NAME"));
		}
	}

	private function writeControllerCommon()
	{
		local.file = ExpandPath("/temp/#arguments.projectName#")& "/common.cfc";
		local.body = getControllerContent(functions = [], extends="alyx.controllers.common");
		FileWrite(local.file, local.body);
	}

	private function writeController(required projectName, required fileAction, required functions)
	{
		local.file = ExpandPath("/temp/#arguments.projectName#")& "/" & ListChangeDelims(arguments.fileAction, "/", ".") & ".cfc";

		if (ListLen(arguments.fileAction, ".") > 1)
		{
			for (local.i = 1; local.i < ListLen(arguments.fileAction, "."); local.i++)
			{
				local.path = arguments.projectName;
				for (local.ii = 1; local.ii <= local.i; local.ii++)
				{
					local.path = ListAppend(local.path, ListGetAt(arguments.fileAction, local.ii, "."), "/");
				}
				checkProjectDirectory(local.path);
			}
		}

		local.body = getControllerContent(functions = arguments.functions, extends="controllers.common");
		FileWrite(local.file, local.body);
	}

	private function getControllerContent(required functions, required extends)
	{
		local.lineBreak = Chr(13)&Chr(10);
		local.tab = Chr(9);
		saveContent variable="local.body"
		{
			WriteOutput("component extends=""#arguments.extends#""#local.lineBreak#");
			WriteOutput("{#local.lineBreak#");
			for (local.function in arguments.functions)
			{
				WriteOutput("#local.lineBreak#");
				WriteOutput("#local.tab#public function #local.function#(required rc, required vc)#local.lineBreak#");
				WriteOutput("#local.tab#{#local.lineBreak#");
				WriteOutput("#local.lineBreak#");
				WriteOutput("#local.tab#}#local.lineBreak#");
				WriteOutput("#local.lineBreak#");
			}
			WriteOutput("}");
		}
		return local.body;
	}


	private function getProjects()
	{
		if (!StructKeyExists(application, "projects"))
		{
			application.projects = super.getProjects(ArgumentCollection = arguments);
		}
		return application.projects;
	}

}