import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.Core;
using Http;
using Rest;
using Azure.ClientGenerator.Core;
namespace Microsoft.AzureStackHCI;

/**
 * Edge device resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "for backward compatibility, provisioningState is defined in EdgeDeviceProperties"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "for backward compatibility, properties is defined as empty model here"
@discriminator("kind")
model EdgeDevice is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDevice,
    KeyName = "edgeDeviceName",
    SegmentName = "edgeDevices"
  >;

  /**
   * Device kind to support polymorphic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: DeviceKind = DeviceKind.HCI;
}

@armResourceOperations
interface EdgeDevices {
  /**
   * Get a EdgeDevice
   */
  get is ArmResourceRead<EdgeDevice>;

  /**
   * Create a EdgeDevice
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Follow existing naming for backward compatibility"
  CreateOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeDevice>;

  /**
   * List EdgeDevice resources by parent
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Follow existing naming for backward compatibility"
  List is ArmResourceListByParent<
    EdgeDevice,
    Response = ArmResponse<EdgeDeviceListResult>
  >;

  /**
   * Delete a EdgeDevice
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeDevice>;

  /**
   * A long-running resource action.
   */
  validate is ArmResourceActionAsync<
    EdgeDevice,
    ValidateRequest,
    EdgeDeviceValidateResponseResult
  >;
}

@@doc(EdgeDevice.name, "Name of Device");

// Models

/**
 * The response of a EdgeDevice list operation.
 */
model EdgeDeviceListResult is Azure.Core.Page<EdgeDevice>;

/**
 * The validate request for Edge Device.
 */
model ValidateRequest {
  /**
   * Node Ids against which, current node has to be validated.
   */
  edgeDeviceIds: string[];

  /**
   * Additional info required for validation.
   */
  additionalInfo?: string;
}

/**
 * An Accepted response with an Operation-Location header.
 */
@clientName("ValidateResponse")
model EdgeDeviceValidateResponseResult {
  /**
   * edge device validation status
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * The AdapterPropertyOverrides of a cluster.
 */
model EdgeDevicesAdapterPropertyOverrides {
  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  jumboPacket?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  networkDirect?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation. Expected values are 'iWARP', 'RoCEv2', 'RoCE'
   */
  @visibility(Lifecycle.Read)
  networkDirectTechnology?: string;
}

/**
 * Edge Device properties
 */
model EdgeDeviceProperties {
  /**
   * Device Configuration
   */
  deviceConfiguration?: DeviceConfiguration;

  /**
   * Provisioning state of edgeDevice resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The device Configuration for edge device.
 */
model DeviceConfiguration {
  /**
   * NIC Details of device
   */
  @identifiers(#["adapterName"])
  nicDetails?: NicDetail[];

  /**
   * Device metadata details.
   */
  deviceMetadata?: string;
}

/**
 * details of validation failure
 */
model ErrorDetail {
  /**
   * Exception details while installing extension.
   */
  @visibility(Lifecycle.Read)
  exception?: string;
}

/**
 * Arc extension installed on edge device.
 */
model EdgeDevicesExtension {
  /**
   * Arc extension name installed on edge device.
   */
  @visibility(Lifecycle.Read)
  extensionName?: string;

  /**
   * Arc extension state from arc machine extension.
   */
  @visibility(Lifecycle.Read)
  state?: ArcExtensionState;

  /**
   * Error details while installing Arc extension.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errorDetails?: ErrorDetail[];

  /**
   * Arc Extension Azure resource id.
   */
  @visibility(Lifecycle.Read)
  extensionResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Extension version installed.
   */
  @visibility(Lifecycle.Read)
  typeHandlerVersion?: string;

  /**
   * Extension managed by user or Azure.
   */
  @visibility(Lifecycle.Read)
  managedBy?: ExtensionManagedBy;
}

/**
 * Extensions details for edge device.
 */
model ExtensionProfile {
  /**
   * List of Arc extensions installed on edge device.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["extensionName"])
  extensions?: EdgeDevicesExtension[];
}

/**
 * Arc-enabled edge device with HCI OS.
 */
model HciEdgeDevice extends EdgeDevice {
  /**
   * properties for Arc-enabled edge device with HCI OS.
   */
  properties?: HciEdgeDeviceProperties;

  /**
   * Device kind to support polymorphic resource.
   */
  kind: "HCI";
}

/**
 * properties for Arc-enabled edge device with HCI OS.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HciEdgeDeviceProperties extends EdgeDeviceProperties {
  /**
   * The instance view of all current configurations on HCI device.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: HciReportedProperties;
}

/**
 * The device Configuration for HCI device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HciReportedProperties extends ReportedProperties {
  /**
   * HCI device network information.
   */
  @visibility(Lifecycle.Read)
  networkProfile?: HciNetworkProfile;

  /**
   * HCI device OS specific information.
   */
  @visibility(Lifecycle.Read)
  osProfile?: HciOsProfile;

  /**
   * Solution builder extension (SBE) deployment package information.
   */
  @visibility(Lifecycle.Read)
  sbeDeploymentPackageInfo?: SbeDeploymentPackageInfo;

  /**
   * Hci device storage specific information.
   */
  @visibility(Lifecycle.Read)
  storageProfile?: HciStorageProfile;

  /**
   * Hci device hardware specific information.
   */
  @visibility(Lifecycle.Read)
  hardwareProfile?: HciHardwareProfile;
}

/**
 * The network profile of a device.
 */
model HciNetworkProfile {
  /**
   * List of NIC Details of device.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["adapterName"])
  nicDetails?: HciNicDetail[];

  /**
   * List of switch details for edge device.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["switchName"])
  switchDetails?: SwitchDetail[];

  /**
   * HostNetwork config to deploy AzureStackHCI Cluster.
   */
  @visibility(Lifecycle.Read)
  hostNetwork?: EdgeDeviceHostNetwork;
}

/**
 * The NIC Detail of a device.
 */
model NicDetail {
  /**
   * Adapter Name of NIC
   */
  adapterName?: string;

  /**
   * Interface Description of NIC
   */
  interfaceDescription?: string;

  /**
   * Component Id of NIC
   */
  componentId?: string;

  /**
   * Driver Version of NIC
   */
  driverVersion?: string;

  /**
   * Subnet Mask of NIC
   */
  ip4Address?: string;

  /**
   * Subnet Mask of NIC
   */
  subnetMask?: string;

  /**
   * Default Gateway of NIC
   */
  defaultGateway?: string;

  /**
   * DNS Servers for NIC
   */
  dnsServers?: string[];

  /**
   * Default Isolation of Management NIC
   */
  defaultIsolationId?: string;
}

/**
 * The NIC Detail of a device.
 */
model HciNicDetail {
  /**
   * Adapter Name of NIC
   */
  @visibility(Lifecycle.Read)
  adapterName?: string;

  /**
   * Interface Description of NIC
   */
  @visibility(Lifecycle.Read)
  interfaceDescription?: string;

  /**
   * Component Id of NIC
   */
  @visibility(Lifecycle.Read)
  componentId?: string;

  /**
   * Driver Version of NIC
   */
  @visibility(Lifecycle.Read)
  driverVersion?: string;

  /**
   * Subnet Mask of NIC
   */
  @visibility(Lifecycle.Read)
  ip4Address?: string;

  /**
   * Subnet Mask of NIC
   */
  @visibility(Lifecycle.Read)
  subnetMask?: string;

  /**
   * Default Gateway of NIC
   */
  @visibility(Lifecycle.Read)
  defaultGateway?: string;

  /**
   * DNS Servers for NIC
   */
  @visibility(Lifecycle.Read)
  dnsServers?: string[];

  /**
   * Default Isolation of Management NIC
   */
  @visibility(Lifecycle.Read)
  defaultIsolationId?: string;

  /**
   * MAC address information of NIC.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The slot attached to the NIC.
   */
  @visibility(Lifecycle.Read)
  slot?: string;

  /**
   * The switch attached to the NIC, if any.
   */
  @visibility(Lifecycle.Read)
  switchName?: string;

  /**
   * The type of NIC, physical, virtual, management.
   */
  @visibility(Lifecycle.Read)
  nicType?: string;

  /**
   * The VLAN ID of the physical NIC.
   */
  @visibility(Lifecycle.Read)
  vlanId?: string;

  /**
   * The status of NIC, up, disconnected.
   */
  @visibility(Lifecycle.Read)
  nicStatus?: string;

  /**
   * Describes the RDMA capability of the network adapter.
   */
  @visibility(Lifecycle.Read)
  rdmaCapability?: RdmaCapability = RdmaCapability.Disabled;
}

/**
 * List of switch details for edge device.
 */
model SwitchDetail {
  /**
   * The name of the switch.
   */
  @visibility(Lifecycle.Read)
  switchName?: string;

  /**
   * The type of the switch. e.g. external, internal.
   */
  @visibility(Lifecycle.Read)
  switchType?: string;

  /**
   * This represents extensions installed on virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["extensionName"])
  extensions?: SwitchExtension[];
}

/**
 * This represents extensions installed on virtualSwitch.
 */
model SwitchExtension {
  /**
   * Unique identifier for virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  switchId?: string;

  /**
   * This will show extension name for virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  extensionName?: string;

  /**
   * This represents whether extension is enabled on virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  extensionEnabled?: boolean;
}

/**
 * The HostNetwork of a cluster.
 */
model EdgeDeviceHostNetwork {
  /**
   * The network intents assigned to the network reference pattern used for the deployment. Each intent will define its own name, traffic type, adapter names, and overrides as recommended by your OEM.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["intentName"])
  intents?: EdgeDevicesIntents[];

  /**
   * List of StorageNetworks config to deploy AzureStackHCI Cluster.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["networkAdapterName"])
  storageNetworks?: EdgeDevicesStorageNetworks[];

  /**
   * Defines how the storage adapters between nodes are connected either switch or switch less.
   */
  @visibility(Lifecycle.Read)
  storageConnectivitySwitchless?: boolean;

  /**
   * Optional parameter required only for 3 Nodes Switchless deployments. This allows users to specify IPs and Mask for Storage NICs when Network ATC is not assigning the IPs for storage automatically.
   */
  @visibility(Lifecycle.Read)
  enableStorageAutoIp?: boolean;
}

/**
 * The Intents of a cluster.
 */
model EdgeDevicesIntents {
  /**
   * Scope for host network intent.
   */
  @visibility(Lifecycle.Read)
  scope?: int64;

  /**
   * IntentType for host network intent.
   */
  @visibility(Lifecycle.Read)
  intentType?: int64;

  /**
   * IsComputeIntentSet for host network intent.
   */
  @visibility(Lifecycle.Read)
  isComputeIntentSet?: boolean;

  /**
   * IsStorageIntentSet for host network intent.
   */
  @visibility(Lifecycle.Read)
  isStorageIntentSet?: boolean;

  /**
   * IntentType for host network intent.
   */
  @visibility(Lifecycle.Read)
  isOnlyStorage?: boolean;

  /**
   * IsManagementIntentSet for host network intent.
   */
  @visibility(Lifecycle.Read)
  isManagementIntentSet?: boolean;

  /**
   * IsStretchIntentSet for host network intent.
   */
  @visibility(Lifecycle.Read)
  isStretchIntentSet?: boolean;

  /**
   * IsOnlyStretch for host network intent.
   */
  @visibility(Lifecycle.Read)
  isOnlyStretch?: boolean;

  /**
   * IsNetworkIntentType for host network intent.
   */
  @visibility(Lifecycle.Read)
  isNetworkIntentType?: boolean;

  /**
   * Name of the network intent you wish to create.
   */
  @visibility(Lifecycle.Read)
  intentName?: string;

  /**
   * Array of adapters used for the network intent.
   */
  @visibility(Lifecycle.Read)
  intentAdapters?: string[];

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  overrideVirtualSwitchConfiguration?: boolean;

  /**
   * Set virtualSwitch ConfigurationOverrides for cluster.
   */
  @visibility(Lifecycle.Read)
  virtualSwitchConfigurationOverrides?: EdgeDevicesVirtualSwitchConfigurationOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  overrideQosPolicy?: boolean;

  /**
   * Set QoS PolicyOverrides for cluster.
   */
  @visibility(Lifecycle.Read)
  qosPolicyOverrides?: QosPolicyOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  overrideAdapterProperty?: boolean;

  /**
   * Set Adapter PropertyOverrides for cluster.
   */
  @visibility(Lifecycle.Read)
  adapterPropertyOverrides?: EdgeDevicesAdapterPropertyOverrides;
}

/**
 * The VirtualSwitchConfigurationOverrides of a cluster.
 */
model EdgeDevicesVirtualSwitchConfigurationOverrides {
  /**
   * Enable IoV for Virtual Switch
   */
  @visibility(Lifecycle.Read)
  enableIov?: string;

  /**
   * Load Balancing Algorithm for Virtual Switch
   */
  @visibility(Lifecycle.Read)
  loadBalancingAlgorithm?: string;
}

/**
 * The StorageNetworks of a cluster.
 */
model EdgeDevicesStorageNetworks {
  /**
   * Name of the storage network.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Name of the storage network adapter.
   */
  @visibility(Lifecycle.Read)
  networkAdapterName?: string;

  /**
   * ID specified for the VLAN storage network. This setting is applied to the network interfaces that route the storage and VM migration traffic.
   */
  @visibility(Lifecycle.Read)
  storageVlanId?: string;

  /**
   * List of Storage adapter physical nodes config to deploy AzureStackHCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
  @visibility(Lifecycle.Read)
  @identifiers(#["physicalNode"])
  storageAdapterIPInfo?: EdgeDevicesStorageAdapterIPInfo[];
}

/**
 * The StorageAdapter physical nodes of a cluster.
 */
model EdgeDevicesStorageAdapterIPInfo {
  /**
   * storage adapter physical node name.
   */
  @visibility(Lifecycle.Read)
  physicalNode?: string;

  /**
   * The IPv4 address assigned to each storage adapter physical node on your Azure Stack HCI cluster.
   */
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  /**
   * The SubnetMask address assigned to each storage adapter physical node on your Azure Stack HCI cluster.
   */
  @visibility(Lifecycle.Read)
  subnetMask?: string;
}

/**
 * OS configurations for HCI device.
 */
model HciOsProfile {
  /**
   * The boot type of the device. e.g. UEFI, Legacy etc
   */
  @visibility(Lifecycle.Read)
  bootType?: string;

  /**
   * Version of assembly present on device
   */
  @visibility(Lifecycle.Read)
  assemblyVersion?: string;
}

/**
 * Solution builder extension (SBE) deployment package information.
 */
model SbeDeploymentPackageInfo {
  /**
   * SBE deployment validation code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A detailed message that explains the SBE package validation result.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * This represents discovered update results for matching updates and store it as SBE manifest.
   */
  @visibility(Lifecycle.Read)
  sbeManifest?: string;
}

/**
 * Storage configurations for HCI device.
 */
model HciStorageProfile {
  /**
   * Number of storage disks in the device with $CanPool as true.
   */
  @visibility(Lifecycle.Read)
  poolableDisksCount?: int64;
}

/**
 * Hardware configurations for HCI device.
 */
model HciHardwareProfile {
  /**
   * Process type of the device
   */
  @visibility(Lifecycle.Read)
  processorType?: string;
}

/**
 * Reported properties pushed from edge device.
 */
model ReportedProperties {
  /**
   * edge device state.
   */
  @visibility(Lifecycle.Read)
  deviceState?: DeviceState;

  /**
   * Extensions details for edge device.
   */
  @visibility(Lifecycle.Read)
  extensionProfile?: ExtensionProfile;
}
