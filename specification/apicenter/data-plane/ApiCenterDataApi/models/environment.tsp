import "./workspace.tsp";

namespace ApiCenter.DataApi;

using TypeSpec.Rest;

@doc("Paged collection of Environment items across workspaces")
model PagedEnvironmentAll {
  ...Azure.Core.Page<Environment>;
}

@doc("Environment resource model.")
@resource("environments")
@parentResource(Workspace)
model Environment {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "FIXME: misused @visibility to get around this warning"
  @doc("Environment identifier.")
  @key("environmentName")
  @maxLength(50)
  name: string;

  @doc("The name of the environment.")
  @maxLength(50)
  title: string;

  @doc("Kind of deployment environment.")
  kind: EnvironmentKind;

  @doc("Description of the environment.")
  @maxLength(1000)
  description?: string;

  @doc("Server information of the environment.")
  server?: EnvironmentServer;

  @doc("Onboarding information for this environment.")
  onboarding?: EnvironmentOnboardingModel;

  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with existing swagger."
  @doc("The custom metadata defined for environment entities.")
  customProperties?: {};
}

@doc("Environment Server")
model EnvironmentServer {
  @doc("Type of the server that represents the environment.")
  type: string;

  @doc("URIs of the server's management portal.")
  managementPortalUris: url[];
}

@doc("Environment Onboarding Model")
model EnvironmentOnboardingModel {
  @doc("Instructions how to onboard to the environment.")
  @maxLength(1000)
  instructions: string;

  @doc("Developer portal URIs of the environment.")
  developerPortalUris: url[];
}

@doc("Environment kind")
union EnvironmentKind {
  string,

  @doc("Environment is in the development stage")
  Development: "development",

  @doc("Environment is in the testing stage")
  Testing: "testing",

  @doc("Environment is in the staging stage")
  Staging: "staging",

  @doc("Environment is in the production stage")
  Production: "production",
}
