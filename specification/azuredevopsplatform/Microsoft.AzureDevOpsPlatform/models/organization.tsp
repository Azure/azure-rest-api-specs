import "./common.tsp";

@doc("Organization Properties")
model OrganizationProperties {
  @doc("Unique id of the organization")
  aadTenantId: string;

  @doc("Display name of the organization")
  displayName: string;

  @doc("Preferred geography of the organization")
  geography?: string;

  @doc("True if the organization is internal to Microsoft. Otherwise false")
  isInternal: boolean;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
