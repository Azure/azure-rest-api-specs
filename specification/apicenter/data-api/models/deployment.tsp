namespace ApiCenter.DataApi.Models;

@doc("API deployment")
model ApiDeployment {
  @doc("The resource name.")
  @maxLength(50)
  name: string;
  
  @doc("The name of the deployment.")
  @maxLength(50)
  title: string;

  @doc("The description of the deployment.")
  @maxLength(1000)
  description?: string;

  @doc("The name of the deployment environment.")
  environment: string;

  @doc("The server information of the API deployment.")
  server: ApiDeploymentServer;

  @doc("The custom metadata defined for Deployment entries..")
  customProperties?: Record<string>;

  @doc("Indicates if this is currently recommended deployment.")
  recommended?: boolean;
}

@doc("Api Deployment Server") 
  model ApiDeploymentServer {

    @doc("Base runtime URIs for this deployment.")
    runtimeUri: Array<string>;
}