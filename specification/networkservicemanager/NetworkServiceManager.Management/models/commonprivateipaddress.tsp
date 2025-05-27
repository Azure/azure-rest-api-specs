/**
 * This file is copied from specification\microsoftinventory\commonmodelslib\commonprivateipaddress.tsp.
 * Copy the file here to fix the "invalid folder structure" error of importing files
 * outside "specification/networkservicemanager".
 */
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./common.tsp";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Inventory.CommonTypes;

@doc("Properties for private ip address resources")
model PrivateIpAddressPropertiesBase {
  @doc("Specifies the IP Version")
  ipVersion: IpVersion;

  @doc("The IP Address (IPv4/IPv6). This can also be represented as a block address range in CIDR notation.")
  ipAddress: string;

  @doc("Managed, Allocated, Active, Retired")
  state: IpAddressState;

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
  provisioningState?: ResourceProvisioningState;
}
