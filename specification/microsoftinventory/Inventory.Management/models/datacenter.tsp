import "./common.tsp";

@doc("Datacenter Properties")
model DatacenterProperties {
  @doc("Datacenter short Id")
  shortId: string;

  @doc("Datacenter location Dcmt Id")
  locationDcmtId: string;

  @doc("Datacenter friendly Name Id")
  friendlyName: string;

  @doc("Availability Zone Id")
  availabilityZoneId: AvailabilityZoneResourceId;

  @doc("Facility Id")
  facilityId: FacilityResourceId;

  @doc("Azure Region Id")
  azureRegionId: AzureRegionResourceId;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
