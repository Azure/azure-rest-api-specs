namespace ApiCenter.DataApi;

using TypeSpec.Rest;

@doc("API deployment resource model.")
@resource("deployments")
@parentResource(Api)
model ApiDeployment {
  @doc("Deployment identifier.")
  @key("deploymentName")
  @visibility
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

  @doc("The custom metadata defined for API deployment entities.")
  customProperties?: {};

  @doc("Indicates if this is currently recommended deployment.")
  recommended?: boolean;
}

@doc("Api Deployment Server")
model ApiDeploymentServer {
  @doc("Base runtime URIs for this deployment.")
  runtimeUris: url[];
}
