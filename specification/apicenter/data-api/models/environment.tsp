namespace ApiCenter.DataApi.Models;

@doc("Environment")
model Environment {
  @doc("The resource name.")
  @maxLength(50)
  name: string;

  @doc("The name of the environment.")
  @maxLength(50)
  title: string;

  @doc("Kind of deployment environment.")
  kind: string;

  @doc("Description of the environment.")
  @maxLength(1000)
  description?: string;

  @doc("Server information of the environment.")
  server?: EnvironmentServer;

  @doc("Onboarding information for this environment.")
  onboarding?: EnvironmentOnboardingModel;

  @doc("The custom metadata defined for Environment entries.")
  customProperties?: Record<string>;
}

@doc("Environment Server")
model EnvironmentServer {
  @doc("Type of the server that represents the environment.")
  type: string;

  @doc("URIs of the server's management portal.")
  managementPortalUri: Array<string>;
}

@doc("Environment Onboarding Model")
model EnvironmentOnboardingModel {
  @doc("Instructions how to onboard to the environment.")
  @maxLength(1000)
  instructions: string;

  @doc("Developer portal URIs of the environment.")
  developerPortalUri: Array<string>;
}