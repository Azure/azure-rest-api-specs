namespace DataApi.Models;

@doc("API deployment")
model ApiDeployment {
  @doc("The name of the deployment.")
  @maxLength(50)
  title: string;

  @doc("The description of the deployment.")
  @maxLength(1000)
  description: string;

  @doc("The name of the deployment environment.")
  environment: string;

  @doc("Base runtime URIs for this deployment.")
  @maxLength(200)
  deploymentRuntimeUrl: string;

}