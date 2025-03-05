import "./common.tsp";

namespace Microsoft.Frontdoor;

@doc("VirtualMachine Properties")
model VmProperties {
  @doc("Unique identifier for the VM (hostname + VM) used as identifier")
  virtualMachineName: string;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: Microsoft.Frontdoor.ProvisioningState;

  @doc("Name of the physical server/machine this VM is running atop of")
  physicalHostName: string;

  @doc("Whether this is in production or not (Prod, PPE, Test)")
  environment: Environment;

  @doc("3 letter Data Center where this asset resides")
  datacenterCode: string;

  @doc("Cloud the virtual machine exists in  (Public)")
  cloud: Cloud;

  @doc("current machine status (Alive, Suspended, Decommissioned, Provisioned, Not Provisioned)")
  status: Status;

  @doc("Asset Tag of parent physicalHostName")
  hostAssetTag?: string;

  @doc("Serial number of parent physicalHostName")
  hostSerialNumber?: string;

  @doc("Type of machine being tracked (BaremetalVM)")
  assetType?: Microsoft.Frontdoor.AssetTypeVM;

  @doc("Logical Environment Name")
  environmentName?: string;

  @doc("OS Properties for the machine")
  osProperties: OsProperties;

  @doc("IPv4 addresses for the machine")
  ipv4Addresses: Azure.Core.ipV4Address[];

  @doc("MS private IPv4 addresses for the machine")
  ipv4MsPrivateAddresses: Azure.Core.ipV4Address[];

  @doc("IPv6 addresses for the machine")
  ipv6Addresses: Azure.Core.ipV6Address[];

  @doc("Link local IPv6 addresses for the machine")
  ipv6LinkLocalAddresses: Azure.Core.ipV6Address[];
}

@doc("OSProperties composed of osVersion, osType, osName, osBuild")
model OsProperties {
  @doc("Version of Operating System running on the virtual machine")
  osVersion: string;

  @doc("Type  of Operating System running on the virtual machine (Windows, Linux)")
  osType: OsType;

  @doc("Operating System running on the virtual machine (Ubuntu, Mariner)")
  osName?: string;

  @doc("OS Build Number")
  osBuild?: string;
}
