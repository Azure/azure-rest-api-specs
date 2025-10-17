import "@typespec/versioning";
import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Frontdoor;

@doc("Datacenter Properties")
@added(Versions.v2025_08_01_preview)
model LogicalDatacenterProperties {
  @doc("The logical datacenter name")
  logicalDatacenterName: string;

  @doc("Geography of the logical datacenter")
  geography: string;

  @doc("Facility Codes for physical datacenters attached to this logical datacenter")
  facilityCodes: string[];

  @doc("Azure Region Id")
  regionResourceId: string;

  @doc("Azure Availability Zone Id")
  availabilityZoneResourceId: string;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
