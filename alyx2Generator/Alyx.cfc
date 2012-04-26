component  extends="alyx.core.Alyx"
{

	public function setupApplication()
	{
		super.setupApplication(ArgumentCollection = arguments);
	}

	public function setupSession()
	{
		super.setupSession(ArgumentCollection = arguments);
	}

	public function setupRequest()
	{
		super.setupRequest(ArgumentCollection = arguments);
	}

}