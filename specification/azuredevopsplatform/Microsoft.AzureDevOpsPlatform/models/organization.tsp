import "./common.tsp";

@doc("Organization Scope enum")
union OrganizationScope {
  @doc("The organization is internal to Microsoft.")
  Internal: "Internal",

  @doc("The organization is external to Microsoft.")
  External: "External",

  string,
}

@doc("Organization Properties")
model OrganizationProperties {
  @doc("Unique id of the organization")
  aadTenantId: string;

  @doc("Display name of the organization")
  displayName: string;

  @doc("Preferred geography of the organization. This should align with the the list of available Azure regions, as found by running az account list-locations --query [].name")
  geography?: string;

  @doc("Indicates whether the organization is internal or external to Microsoft.")
  organizationScope: OrganizationScope;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
