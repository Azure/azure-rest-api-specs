import "@typespec/versioning";
import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Frontdoor;

@doc("Properties for private ip address resources")
@added(Versions.v2025_08_01_preview)
model PrivateNetworkAddressProperties {
  @doc("Specifies the IP Version")
  ipVersion: IpVersion;

  @doc("The IP Address (IPv4/IPv6). This can also be represented as a block address range in CIDR notation.")
  ipAddress: string;

  @doc("Managed, Allocated, Active, Retired")
  state: IpAddressState;

  @doc("Cloud where the asset exists")
  cloud: Cloud;

  @doc("Region where the IP address exists")
  region: string;

  @doc("Determines whether the private IP address is used across regions")
  isReuse?: boolean;

  @doc("Indicates the ownership of the private IP address")
  ownership?: Ownership;

  @doc("Metadata that describes the resource to which this private IP address is assigned")
  assignedResource: AssignedResource;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
