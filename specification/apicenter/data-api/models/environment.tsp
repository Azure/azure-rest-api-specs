namespace DataApi.Models;

@doc("Environment")
model Environment {
  @doc("The name of the environment.")
  @maxLength(50)
  title: string;

  @doc("Kind of deployment environment.")
  type: string;

  @doc("Description of the environment.")
  @maxLength(1000)
  description: string;

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

  @doc("URI of the server's management portal.")
  @maxLength(200)
  managementPortalUri: string;
}

@doc("Environment Onboarding Model")
model EnvironmentOnboardingModel {
  @doc("Instructions how to onboard to the environment.")
  @maxLength(1000)
  instructions: string;

  @doc("Developer portal URI of the environment.")
  @maxLength(200)
  developerPortalUri: string;
}