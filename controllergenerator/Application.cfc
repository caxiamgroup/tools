component
{
	this.name = Hash(GetCurrentTemplatePath());

	include "/workflow_2010/alyx/core/framework.cfc";


	public function setupApplication()
	{

		super.setupApplication();
	}

	public function getEnvironment()
	{
		var local = StructNew();
		local.result = "prod";

		if (cgi.http_host contains "ds.caxiamgroup.net")
		{
			local.result = "ds";
		}
		else if(cgi.http_host contains "localhost" or cgi.http_host contains ".caxiamgroup.net")
		{
			local.result =  "dev";
		}

		return local.result;
	}

	public function setupSession()
	{
		super.setupSession();
	}

	public function setupRequest()
	{
		super.setupRequest();
	}

	public function isDevEnvironment()
	{
		return getEnvironment() eq "dev";
	}


}