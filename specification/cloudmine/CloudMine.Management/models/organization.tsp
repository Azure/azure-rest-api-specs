import "./common.tsp";

@doc("Properties for the organization resource.")
model OrganizationProperties {
  @doc("The name of the organization.")
  organizationName: string;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
