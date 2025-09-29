import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridContainerService;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
}

/**
 * The extended location type. Allowed value: 'CustomLocation'
 */
union ExtendedLocationTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CustomLocation: "CustomLocation",
}

/**
 * A list of virtual network resources.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model virtualNetworksListResult {
  @pageItems
  @doc("The collection of virtual networks.")
  value?: virtualNetwork[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

/**
 * Properties of the virtual network resource
 */
model VirtualNetworkProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  infraVnetProfile?: VirtualNetworkPropertiesInfraVnetProfile;

  /**
   * Range of IP Addresses for Kubernetes API Server and services if using HA Proxy load balancer
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  vipPool?: VirtualNetworkPropertiesVipPoolItem[];

  /**
   * Range of IP Addresses for Kubernetes node VMs
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  vmipPool?: VirtualNetworkPropertiesVmipPoolItem[];

  /**
   * List of DNS server IP Addresses associated with the network
   */
  dnsServers?: string[];

  /**
   * IP Address of the Gateway associated with the network
   */
  gateway?: string;

  /**
   * IP Address Prefix of the network
   */
  ipAddressPrefix?: string;

  /**
   * VLAN Id used by the network
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  vlanID?: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Status of the virtual network resource
   */
  @visibility(Lifecycle.Read)
  status?: VirtualNetworkPropertiesStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualNetworkPropertiesInfraVnetProfile {
  /**
   * Infrastructure network profile for HCI platform
   */
  hci?: VirtualNetworkPropertiesInfraVnetProfileHci;
}

/**
 * Infrastructure network profile for HCI platform
 */
model VirtualNetworkPropertiesInfraVnetProfileHci {
  /**
   * Group in MOC(Microsoft On-premises Cloud)
   */
  mocGroup?: string;

  /**
   * Location in MOC(Microsoft On-premises Cloud)
   */
  mocLocation?: string;

  /**
   * Virtual Network name in MOC(Microsoft On-premises Cloud)
   */
  mocVnetName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualNetworkPropertiesVipPoolItem {
  /**
   * Ending IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  endIP?: string;

  /**
   * Starting IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  startIP?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualNetworkPropertiesVmipPoolItem {
  /**
   * Ending IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  endIP?: string;

  /**
   * Starting IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  startIP?: string;
}

/**
 * Status of the virtual network resource
 */
model VirtualNetworkPropertiesStatus {
  /**
   * The detailed status of the long running operation.
   */
  operationStatus?: VirtualNetworkPropertiesStatusOperationStatus;
}

/**
 * The detailed status of the long running operation.
 */
model VirtualNetworkPropertiesStatusOperationStatus {
  /**
   * The error if any from the operation.
   */
  error?: VirtualNetworkPropertiesStatusOperationStatusError;

  /**
   * The identifier of the operation.
   */
  operationId?: string;

  /**
   * The status of the operation.
   */
  status?: string;
}

/**
 * The error if any from the operation.
 */
model VirtualNetworkPropertiesStatusOperationStatusError {
  /**
   * The error code from the operation.
   */
  code?: string;

  /**
   * The error message from the operation.
   */
  message?: string;
}

/**
 * Extended location pointing to the underlying infrastructure
 */
model VirtualNetworkExtendedLocation {
  /**
   * The extended location type. Allowed value: 'CustomLocation'
   */
  type?: ExtendedLocationTypes;

  /**
   * ARM Id of the extended location.
   */
  name?: string;
}

/**
 * The Virtual Network resource patch definition.
 */
model VirtualNetworksPatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}