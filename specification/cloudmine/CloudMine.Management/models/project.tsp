import "./common.tsp";

@doc("Properties for the project resource.")
model ProjectProperties {
  @doc("The organization name for the project.")
  organizationName: string;

  @doc("The project ID for the project.")
  projectId: string;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
