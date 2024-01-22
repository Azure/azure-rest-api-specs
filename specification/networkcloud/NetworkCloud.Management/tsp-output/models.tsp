import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;


namespace Microsoft.NetworkCloud;

interface Operations extends Azure.ResourceManager.Operations {} 

/**
* The cordon status of the bare metal machine.
*/
    enum BareMetalMachineCordonStatus {
        "Cordoned", "Uncordoned"
    }

/**
* The more detailed status of the bare metal machine.
*/
    enum BareMetalMachineDetailedStatus {
        "Preparing", "Error", "Available", "Provisioning", "Provisioned", "Deprovisioning"
    }

/**
* The outcome of the hardware validation.
*/
    enum BareMetalMachineHardwareValidationResult {
        "Pass", "Fail"
    }

/**
* The power state derived from the baseboard management controller.
*/
    enum BareMetalMachinePowerState {
        "On", "Off"
    }

/**
* The provisioning state of the bare metal machine.
*/
    enum BareMetalMachineProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The indicator of whether the bare metal machine is ready to receive workloads.
*/
    enum BareMetalMachineReadyState {
        "True", "False"
    }

/**
* The more detailed status of the cloud services network.
*/
    enum CloudServicesNetworkDetailedStatus {
        "Error", "Available", "Provisioning"
    }

/**
* The indicator of whether the platform default endpoints are allowed for the egress traffic.
*/
    enum CloudServicesNetworkEnableDefaultEgressEndpoints {
        "True", "False"
    }

/**
* The provisioning state of the cloud services network.
*/
    enum CloudServicesNetworkProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The detailed status that provides additional information about the cluster manager.
*/
    enum ClusterManagerDetailedStatus {
        "Error", "Available", "Provisioning", "ProvisioningFailed", "Updating", "UpdateFailed"
    }

/**
* The provisioning state of the cluster manager.
*/
    enum ClusterManagerProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted", "Updating"
    }

/**
* The indicator of whether the control plane will be impacted during the upgrade.
*/
    enum ControlImpact {
        "True", "False"
    }

/**
* The indicator of whether the workload will be impacted during the upgrade.
*/
    enum WorkloadImpact {
        "True", "False"
    }

/**
* The latest heartbeat status between the cluster manager and the cluster.
*/
    enum ClusterConnectionStatus {
        "Connected", "Timeout", "Undefined"
    }

/**
* The latest connectivity status between cluster manager and the cluster.
*/
    enum ClusterManagerConnectionStatus {
        "Connected", "Unreachable"
    }

/**
* The type of rack configuration for the cluster.
*/
    enum ClusterType {
        "SingleRack", "MultiRack"
    }

/**
* Selection of how the type evaluation is applied to the cluster calculation.
*/
    enum ValidationThresholdGrouping {
        "PerCluster", "PerRack"
    }

/**
* Selection of how the threshold should be evaluated.
*/
    enum ValidationThresholdType {
        "CountSuccess", "PercentSuccess"
    }

/**
* The current detailed status of the cluster.
*/
    enum ClusterDetailedStatus {
        "PendingDeployment", "Deploying", "Running", "Updating", "Degraded", "Deleting", "Disconnected", "Failed"
    }

/**
* The provisioning state of the cluster.
*/
    enum ClusterProvisioningState {
        "Succeeded", "Failed", "Canceled", "Accepted", "Validating", "Updating"
    }

/**
* The version lifecycle indicator.
*/
    enum AvailabilityLifecycle {
        "Preview", "GenerallyAvailable"
    }

/**
* The current status of the Kubernetes cluster.
*/
    enum KubernetesClusterDetailedStatus {
        "Available", "Error", "Provisioning"
    }

/**
* The status representing the state of this feature.
*/
    enum FeatureDetailedStatus {
        "Running", "Failed", "Unknown"
    }

/**
* The size of the hugepages to allocate.
*/
    enum HugepagesSize {
        "2M", "1G"
    }

/**
* The indicator of how this network will be utilized by the Kubernetes cluster.
*/
    enum KubernetesPluginType {
        "DPDK", "SRIOV", "OSDevice", "MACVLAN", "IPVLAN"
    }

/**
* The indication of whether this network will or will not perform IP address management and allocate IP addresses when attached.
*/
    enum L3NetworkConfigurationIpamEnabled {
        "True", "False"
    }

/**
* The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
*/
    enum AgentPoolMode {
        "System", "User", "NotApplicable"
    }

/**
* The indicator of if this advertisement is also made to the network fabric associated with the Network Cloud Cluster. This field is ignored if fabricPeeringEnabled is set to False.
*/
    enum AdvertiseToFabric {
        "True", "False"
    }

/**
* The indicator to determine if automatic allocation from the pool should occur.
*/
    enum BfdEnabled {
        "True", "False"
    }

/**
* The indicator to enable multi-hop peering support.
*/
    enum BgpMultiHop {
        "True", "False"
    }

/**
* The indicator to specify if the load balancer peers with the network fabric.
*/
    enum FabricPeeringEnabled {
        "True", "False"
    }

/**
* The detailed state of this node.
*/
    enum KubernetesClusterNodeDetailedStatus {
        "Available", "Error", "Provisioning", "Running", "Scheduling", "Stopped", "Terminating", "Unknown"
    }

/**
* The indicator of whether this is the default gateway.
Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
*/
    enum DefaultGateway {
        "True", "False"
    }

/**
* The IP allocation mechanism for the virtual machine.
Dynamic and Static are only valid for l3Network which may also specify Disabled.
Otherwise, Disabled is the only permitted value.
*/
    enum VirtualMachineIPAllocationMethod {
        "Dynamic", "Static", "Disabled"
    }

/**
* The power state of this node.
*/
    enum KubernetesNodePowerState {
        "On", "Off", "Unknown"
    }

/**
* The role of this node in the cluster.
*/
    enum KubernetesNodeRole {
        "ControlPlane", "Worker"
    }

/**
* The provisioning state of the Kubernetes cluster resource.
*/
    enum KubernetesClusterProvisioningState {
        "Succeeded", "Failed", "Canceled", "Accepted", "InProgress", "Created", "Updating", "Deleting"
    }

/**
* The more detailed status of the L2 network.
*/
    enum L2NetworkDetailedStatus {
        "Error", "Available", "Provisioning"
    }

/**
* Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
*/
    enum HybridAksPluginType {
        "DPDK", "SRIOV", "OSDevice"
    }

/**
* The provisioning state of the L2 network.
*/
    enum L2NetworkProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The more detailed status of the L3 network.
*/
    enum L3NetworkDetailedStatus {
        "Error", "Available", "Provisioning"
    }

/**
* Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The indicator of whether or not to disable IPAM allocation on the network attachment definition injected into the Hybrid AKS Cluster.
*/
    enum HybridAksIpamEnabled {
        "True", "False"
    }

/**
* The type of the IP address allocation, defaulted to "DualStack".
*/
    enum IpAllocationType {
        "IPV4", "IPV6", "DualStack"
    }

/**
* The provisioning state of the L3 network.
*/
    enum L3NetworkProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The type of bootstrap protocol used.
*/
    enum BootstrapProtocol {
        "PXE"
    }

/**
* The connection type of the rack SKU resource.
*/
    enum MachineSkuDiskConnectionType {
        "PCIE", "SATA", "RAID", "SAS"
    }

/**
* The disk type of rack SKU resource.
*/
    enum DiskType {
        "HDD", "SSD"
    }

/**
* The connection type of the device.
*/
    enum DeviceConnectionType {
        "PCI"
    }

/**
* The provisioning state of the rack SKU resource.
*/
    enum RackSkuProvisioningState {
        "Succeeded"
    }

/**
* The type of the rack.
*/
    enum RackSkuType {
        "Aggregator", "Compute", "Single"
    }

/**
* The more detailed status of the rack.
*/
    enum RackDetailedStatus {
        "Error", "Available", "Provisioning"
    }

/**
* The provisioning state of the rack resource.
*/
    enum RackProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The detailed status of the storage appliance.
*/
    enum StorageApplianceDetailedStatus {
        "Error", "Available", "Provisioning"
    }

/**
* The provisioning state of the storage appliance.
*/
    enum StorageApplianceProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The indicator of whether the storage appliance supports remote vendor management.
*/
    enum RemoteVendorManagementFeature {
        "Supported", "Unsupported"
    }

/**
* The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.
*/
    enum RemoteVendorManagementStatus {
        "Enabled", "Disabled", "Unsupported"
    }

/**
* The more detailed status of the trunked network.
*/
    enum TrunkedNetworkDetailedStatus {
        "Error", "Available", "Provisioning"
    }

/**
* The provisioning state of the trunked network.
*/
    enum TrunkedNetworkProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* Selects the boot method for the virtual machine.
*/
    enum VirtualMachineBootMethod {
        "UEFI", "BIOS"
    }

/**
* The more detailed status of the virtual machine.
*/
    enum VirtualMachineDetailedStatus {
        "Available", "Error", "Provisioning", "Running", "Scheduling", "Stopped", "Terminating", "Unknown"
    }

/**
* Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.
*/
    enum VirtualMachineIsolateEmulatorThread {
        "True", "False"
    }

/**
* The specification of whether this hint supports affinity or anti-affinity with the referenced resources.
*/
    enum VirtualMachinePlacementHintType {
        "Affinity", "AntiAffinity"
    }

/**
* The indicator of whether the hint is a hard or soft requirement during scheduling.
*/
    enum VirtualMachineSchedulingExecution {
        "Hard", "Soft"
    }

/**
* The scope for the virtual machine affinity or anti-affinity placement hint. It should always be "Machine" in the case of node affinity.
*/
    enum VirtualMachinePlacementHintPodAffinityScope {
        "Rack", "Machine"
    }

/**
* The power state of the virtual machine.
*/
    enum VirtualMachinePowerState {
        "On", "Off", "Unknown"
    }

/**
* The provisioning state of the virtual machine.
*/
    enum VirtualMachineProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The strategy for creating the OS disk.
*/
    enum OsDiskCreateOption {
        "Ephemeral"
    }

/**
* The strategy for deleting the OS disk.
*/
    enum OsDiskDeleteOption {
        "Delete"
    }

/**
* Field Deprecated, use virtualizationModel instead. The type of the virtio interface.
*/
    enum VirtualMachineVirtioInterfaceType {
        "Modern", "Transitional"
    }

/**
* The type of the device model to use.
*/
    enum VirtualMachineDeviceModelType {
        "T1", "T2"
    }

/**
* The more detailed status of the volume.
*/
    enum VolumeDetailedStatus {
        "Error", "Active", "Provisioning"
    }

/**
* The provisioning state of the volume.
*/
    enum VolumeProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The indicator of whether to evacuate the node workload when the bare metal machine is cordoned.
*/
    enum BareMetalMachineEvacuate {
        "True", "False"
    }

/**
* The indicator of whether to skip the graceful OS shutdown and power off the bare metal machine immediately.
*/
    enum BareMetalMachineSkipShutdown {
        "True", "False"
    }

/**
* The more detailed status of the key set.
*/
    enum BareMetalMachineKeySetDetailedStatus {
        "AllActive", "SomeInvalid", "AllInvalid", "Validating"
    }

/**
* The access level allowed for the users in this key set.
*/
    enum BareMetalMachineKeySetPrivilegeLevel {
        "Standard", "Superuser"
    }

/**
* The provisioning state of the bare metal machine key set.
*/
    enum BareMetalMachineKeySetProvisioningState {
        "Succeeded", "Failed", "Canceled", "Accepted", "Provisioning"
    }

/**
* The indicator of whether the user is currently deployed for access.
*/
    enum BareMetalMachineKeySetUserSetupStatus {
        "Active", "Invalid"
    }

/**
* The more detailed status of the key set.
*/
    enum BmcKeySetDetailedStatus {
        "AllActive", "SomeInvalid", "AllInvalid", "Validating"
    }

/**
* The access level allowed for the users in this key set.
*/
    enum BmcKeySetPrivilegeLevel {
        "ReadOnly", "Administrator"
    }

/**
* The provisioning state of the baseboard management controller key set.
*/
    enum BmcKeySetProvisioningState {
        "Succeeded", "Failed", "Canceled", "Accepted", "Provisioning"
    }

/**
* The more detailed status of the metrics configuration.
*/
    enum ClusterMetricsConfigurationDetailedStatus {
        "Processing", "Applied", "Error"
    }

/**
* The provisioning state of the metrics configuration.
*/
    enum ClusterMetricsConfigurationProvisioningState {
        "Succeeded", "Failed", "Canceled", "Accepted", "Provisioning"
    }

/**
* The current status of the agent pool.
*/
    enum AgentPoolDetailedStatus {
        "Available", "Error", "Provisioning"
    }

/**
* The provisioning state of the agent pool.
*/
    enum AgentPoolProvisioningState {
        "Accepted", "Canceled", "Deleting", "Failed", "InProgress", "Succeeded", "Updating"
    }

/**
* The more detailed status of the console.
*/
    enum ConsoleDetailedStatus {
        "Ready", "Error"
    }

/**
* The credentials used to login to the image repository that has access to the specified image.
*/
    enum ConsoleEnabled {
        "True", "False"
    }

/**
* The provisioning state of the virtual machine console.
*/
    enum ConsoleProvisioningState {
        "Succeeded", "Failed", "Canceled", "Provisioning", "Accepted"
    }

/**
* The indicator of whether to skip the graceful OS shutdown and power off the virtual machine immediately.
*/
    enum SkipShutdown {
        "True", "False"
    }




/**
* ExtendedLocation represents the Azure custom location where the resource will be created.
*/
model ExtendedLocation {
/**
* The resource ID of the extended location on which the resource will be created.
*/
@visibility("read", "create")
"name": string;
/**
* The extended location type, for example, CustomLocation.
*/
@visibility("read", "create")
"type": string;
}

/**
* BareMetalMachineProperties represents the properties of a bare metal machine.
*/
model BareMetalMachineProperties {
/**
* The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
*/
@visibility("read")
"associatedResourceIds"?: string[];
/**
* The connection string for the baseboard management controller including IP address and protocol.
*/
"bmcConnectionString": string;
/**
* The credentials of the baseboard management controller on this bare metal machine.
*/
"bmcCredentials": AdministrativeCredentials;
/**
* The MAC address of the BMC device.
*/
@pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
"bmcMacAddress": string;
/**
* The MAC address of a NIC connected to the PXE network.
*/
@pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
"bootMacAddress": string;
/**
* The resource ID of the cluster this bare metal machine is associated with.
*/
@visibility("read")
"clusterId"?: string;
/**
* The cordon status of the bare metal machine.
*/
@visibility("read")
"cordonStatus"?: BareMetalMachineCordonStatus;
/**
* The more detailed status of the bare metal machine.
*/
@visibility("read")
"detailedStatus"?: BareMetalMachineDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The hardware inventory, including information acquired from the model/sku information and from the ironic inspector.
*/
@visibility("read")
"hardwareInventory"?: HardwareInventory;
/**
* The details of the latest hardware validation performed for this bare metal machine.
*/
@visibility("read")
"hardwareValidationStatus"?: HardwareValidationStatus;
/**
* Field Deprecated. These fields will be empty/omitted. The list of the resource IDs for the HybridAksClusters that have nodes hosted on this bare metal machine.
*/
@visibility("read")
"hybridAksClustersAssociatedIds"?: string[];
/**
* The name of this machine represented by the host object in the Cluster's Kubernetes control plane.
*/
@visibility("read")
"kubernetesNodeName"?: string;
/**
* The version of Kubernetes running on this machine.
*/
@visibility("read")
"kubernetesVersion"?: string;
/**
* The custom details provided by the customer.
*/
@maxLength(256)
"machineDetails": string;
/**
* The OS-level hostname assigned to this machine.
*/
@pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
"machineName": string;
/**
* The unique internal identifier of the bare metal machine SKU.
*/
"machineSkuId": string;
/**
* The IPv4 address that is assigned to the bare metal machine during the cluster deployment.
*/
@visibility("read")
"oamIpv4Address"?: string;
/**
* The IPv6 address that is assigned to the bare metal machine during the cluster deployment.
*/
@visibility("read")
"oamIpv6Address"?: string;
/**
* The image that is currently provisioned to the OS disk.
*/
@visibility("read")
"osImage"?: string;
/**
* The power state derived from the baseboard management controller.
*/
@visibility("read")
"powerState"?: BareMetalMachinePowerState;
/**
* The provisioning state of the bare metal machine.
*/
@visibility("read")
"provisioningState"?: BareMetalMachineProvisioningState;
/**
* The resource ID of the rack where this bare metal machine resides.
*/
"rackId": string;
/**
* The rack slot in which this bare metal machine is located, ordered from the bottom up i.e. the lowest slot is 1.
*/
@maxValue(256)
@minValue(1)
"rackSlot": int64;
/**
* The indicator of whether the bare metal machine is ready to receive workloads.
*/
@visibility("read")
"readyState"?: BareMetalMachineReadyState;
/**
* The serial number of the bare metal machine.
*/
@maxLength(64)
@minLength(1)
"serialNumber": string;
/**
* The discovered value of the machine's service tag.
*/
@visibility("read")
"serviceTag"?: string;
/**
* Field Deprecated. These fields will be empty/omitted. The list of the resource IDs for the VirtualMachines that are hosted on this bare metal machine.
*/
@visibility("read")
"virtualMachinesAssociatedIds"?: string[];
}

/**
* AdministrativeCredentials represents the admin credentials for the device requiring password-based authentication.
*/
model AdministrativeCredentials {
/**
* The password of the administrator of the device used during initialization.
*/
@minLength(1)
"password"?: string;
/**
* The username of the administrator of the device used during initialization.
*/
@minLength(1)
"username": string;
}

/**
* HardwareInventory represents the hardware configuration of this machine as exposed to the customer, including information acquired from the model/sku information and from the ironic inspector.
*/
model HardwareInventory {
/**
* Freeform data extracted from the environment about this machine. This information varies depending on the specific hardware and configuration.
*/
@visibility("read")
"additionalHostInformation"?: string;
/**
* The list of network interfaces and associated details for the bare metal machine.
*/
@visibility("read")
"interfaces"?: HardwareInventoryNetworkInterface[];
/**
* Field Deprecated. Will be removed in an upcoming version. The list of network interface cards and associated details for the bare metal machine.
*/
@visibility("read")
"nics"?: Nic[];
}

/**
* HardwareInventoryNetworkInterface represents the network interface details as part of a hardware inventory.
*/
model HardwareInventoryNetworkInterface {
/**
* The current status of the link.
*/
@visibility("read")
"linkStatus"?: string;
/**
* The MAC address associated with this interface.
*/
@visibility("read")
"macAddress"?: string;
/**
* The name of the interface.
*/
@visibility("read")
"name"?: string;
/**
* The resource ID of the network interface for the port on the switch that this machine's interface is connected to.
*/
@visibility("read")
"networkInterfaceId"?: string;
}

/**
* Type Deprecated. Will be removed in an upcoming version. Nic represents the network interface card details.
*/
model Nic {
/**
* The information about the device connected to this NIC.
*/
@visibility("read")
"lldpNeighbor"?: LldpNeighbor;
/**
* The MAC address associated with this NIC.
*/
@visibility("read")
"macAddress"?: string;
/**
* The name of the NIC/interface.
*/
@visibility("read")
"name"?: string;
}

/**
* Type Deprecated. Will be removed in an upcoming version. LldpNeighbor represents the details about the device connected to the NIC.
*/
model LldpNeighbor {
/**
* The descriptive information about the port on the connected device.
*/
@visibility("read")
"portDescription"?: string;
/**
* The system-assigned name of the port on the connected device.
*/
@visibility("read")
"portName"?: string;
/**
* The descriptive information about the connected device.
*/
@visibility("read")
"systemDescription"?: string;
/**
* The system-assigned name of the connected device.
*/
@visibility("read")
"systemName"?: string;
}

/**
* HardwareValidationStatus represents the latest hardware validation details performed for this bare metal machine.
*/
model HardwareValidationStatus {
/**
* The timestamp of the hardware validation execution.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastValidationTime"?: utcDateTime;
/**
* The outcome of the hardware validation.
*/
@visibility("read")
"result"?: BareMetalMachineHardwareValidationResult;
}

/**
* Common fields that are returned in the response for all Azure Resource Manager resources
*/
model Resource {
/**
* Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
*/
@visibility("read")
"id"?: ResourceIdentifier;
/**
* The name of the resource
*/
@visibility("read")
"name"?: string;
/**
* The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
*/
@visibility("read")
"type"?: string;
/**
* Azure Resource Manager metadata containing createdBy and modifiedBy information.
*/
@visibility("read")
"systemData"?: SystemData;
}

/**
* CloudServicesNetworkProperties represents properties of the cloud services network.
*/
model CloudServicesNetworkProperties {
/**
* The list of egress endpoints. This allows for connection from a Hybrid AKS cluster to the specified endpoint.
*/
"additionalEgressEndpoints"?: EgressEndpoint[];
/**
* The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
*/
@visibility("read")
"associatedResourceIds"?: string[];
/**
* The resource ID of the Network Cloud cluster this cloud services network is associated with.
*/
@visibility("read")
"clusterId"?: string;
/**
* The more detailed status of the cloud services network.
*/
@visibility("read")
"detailedStatus"?: CloudServicesNetworkDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The indicator of whether the platform default endpoints are allowed for the egress traffic.
*/
"enableDefaultEgressEndpoints"?: CloudServicesNetworkEnableDefaultEgressEndpoints;
/**
* The full list of additional and default egress endpoints that are currently enabled.
*/
@visibility("read")
"enabledEgressEndpoints"?: EgressEndpoint[];
/**
* Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this cloud services network.
*/
@visibility("read")
"hybridAksClustersAssociatedIds"?: string[];
/**
* The name of the interface that will be present in the virtual machine to represent this network.
*/
@visibility("read")
"interfaceName"?: string;
/**
* The provisioning state of the cloud services network.
*/
@visibility("read")
"provisioningState"?: CloudServicesNetworkProvisioningState;
/**
* Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this cloud services network.
*/
@visibility("read")
"virtualMachinesAssociatedIds"?: string[];
}

/**
* EgressEndpoint represents the connection from a cloud services network to the specified endpoint for a common purpose.
*/
model EgressEndpoint {
/**
* The descriptive category name of endpoints accessible by the AKS agent node. For example, azure-resource-management, API server, etc. The platform egress endpoints provided by default will use the category 'default'.
*/
"category": string;
/**
* The list of endpoint dependencies.
*/
"endpoints": EndpointDependency[];
}

/**
* EndpointDependency represents the definition of an endpoint, including the domain and details.
*/
model EndpointDependency {
/**
* The domain name of the dependency.
*/
"domainName": string;
/**
* The port of this endpoint.
*/
@maxValue(65535)
@minValue(1)
"port"?: int64;
}

/**
* ClusterManagerProperties represents the properties of a cluster manager.
*/
model ClusterManagerProperties {
/**
* The resource ID of the Log Analytics workspace that is used for the logs collection.
*/
@visibility("read", "create")
"analyticsWorkspaceId"?: string;
/**
* Field deprecated, this value will no longer influence the cluster manager allocation process and will be removed in a future version. The Azure availability zones within the region that will be used to support the cluster manager resource.
*/
@visibility("read", "create")
"availabilityZones"?: string[];
/**
* The list of the cluster versions the manager supports. It is used as input in clusterVersion property of a cluster resource.
*/
@visibility("read")
"clusterVersions"?: ClusterAvailableVersion[];
/**
* The detailed status that provides additional information about the cluster manager.
*/
@visibility("read")
"detailedStatus"?: ClusterManagerDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The resource ID of the fabric controller that has one to one mapping with the cluster manager.
*/
@visibility("read", "create")
"fabricControllerId": string;
/**
* The configuration of the managed resource group associated with the resource.
*/
"managedResourceGroupConfiguration"?: ManagedResourceGroupConfiguration;
/**
* The extended location (custom location) that represents the cluster manager's control plane location. This extended location is used when creating cluster and rack manifest resources.
*/
@visibility("read")
"managerExtendedLocation"?: ExtendedLocation;
/**
* The provisioning state of the cluster manager.
*/
@visibility("read")
"provisioningState"?: ClusterManagerProvisioningState;
/**
* Field deprecated, this value will no longer influence the cluster manager allocation process and will be removed in a future version. The size of the Azure virtual machines to use for hosting the cluster manager resource.
*/
@visibility("read", "create")
"vmSize"?: string;
}

/**
* ClusterAvailableVersion represents the cluster version that the cluster manager can be asked to create and manage.
*/
model ClusterAvailableVersion {
/**
* The last date the version of the platform is supported.
*/
@visibility("read")
"supportExpiryDate"?: string;
/**
* The version of the cluster to be deployed.
*/
@visibility("read")
"targetClusterVersion"?: string;
}

/**
* ManagedResourceGroupConfiguration represents the configuration of the resource group managed by Azure.
*/
model ManagedResourceGroupConfiguration {
/**
* The location of the managed resource group. If not specified, the location of the parent resource is chosen.
*/
@visibility("read", "create")
"location"?: string;
/**
* The name for the managed resource group. If not specified, the unique name is automatically generated.
*/
@visibility("read", "create")
@maxLength(75)
"name"?: string;
}

/**
* ClusterProperties represents the properties of a cluster.
*/
model ClusterProperties {
/**
* The rack definition that is intended to reflect only a single rack in a single rack cluster, or an aggregator rack in a multi-rack cluster.
*/
"aggregatorOrSingleRackDefinition": RackDefinition;
/**
* The resource ID of the Log Analytics Workspace that will be used for storing relevant logs.
*/
@visibility("read", "create")
"analyticsWorkspaceId"?: string;
/**
* The list of cluster runtime version upgrades available for this cluster.
*/
@visibility("read")
"availableUpgradeVersions"?: ClusterAvailableUpgradeVersion[];
/**
* The capacity supported by this cluster.
*/
@visibility("read")
"clusterCapacity"?: ClusterCapacity;
/**
* The latest heartbeat status between the cluster manager and the cluster.
*/
@visibility("read")
"clusterConnectionStatus"?: ClusterConnectionStatus;
/**
* The extended location (custom location) that represents the cluster's control plane location. This extended location is used to route the requests of child objects of the cluster that are handled by the platform operator.
*/
@visibility("read")
"clusterExtendedLocation"?: ExtendedLocation;
/**
* The customer-provided location information to identify where the cluster resides.
*/
@maxLength(256)
"clusterLocation"?: string;
/**
* The latest connectivity status between cluster manager and the cluster.
*/
@visibility("read")
"clusterManagerConnectionStatus"?: ClusterManagerConnectionStatus;
/**
* The resource ID of the cluster manager that manages this cluster. This is set by the Cluster Manager when the cluster is created.
*/
@visibility("read")
"clusterManagerId"?: string;
/**
* The service principal to be used by the cluster during Arc Appliance installation.
*/
"clusterServicePrincipal"?: ServicePrincipalInformation;
/**
* The type of rack configuration for the cluster.
*/
@visibility("read", "create")
"clusterType": ClusterType;
/**
* The current runtime version of the cluster.
*/
@visibility("read", "create")
"clusterVersion": string;
/**
* The validation threshold indicating the allowable failures of compute machines during environment validation and deployment.
*/
"computeDeploymentThreshold"?: ValidationThreshold;
/**
* The list of rack definitions for the compute racks in a multi-rack
cluster, or an empty list in a single-rack cluster.
*/
"computeRackDefinitions"?: RackDefinition[];
/**
* The current detailed status of the cluster.
*/
@visibility("read")
"detailedStatus"?: ClusterDetailedStatus;
/**
* The descriptive message about the detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* Field Deprecated. This field will not be populated in an upcoming version. The extended location (custom location) that represents the Hybrid AKS control plane location. This extended location is used when creating provisioned clusters (Hybrid AKS clusters).
*/
@visibility("read")
"hybridAksExtendedLocation"?: ExtendedLocation;
/**
* The configuration of the managed resource group associated with the resource.
*/
"managedResourceGroupConfiguration"?: ManagedResourceGroupConfiguration;
/**
* The count of Manual Action Taken (MAT) events that have not been validated.
*/
@visibility("read")
"manualActionCount"?: int64;
/**
* The resource ID of the Network Fabric associated with the cluster.
*/
@visibility("read", "create")
"networkFabricId": string;
/**
* The provisioning state of the cluster.
*/
@visibility("read")
"provisioningState"?: ClusterProvisioningState;
/**
* The support end date of the runtime version of the cluster.
*/
@visibility("read")
"supportExpiryDate"?: string;
/**
* The list of workload resource IDs that are hosted within this cluster.
*/
@visibility("read")
"workloadResourceIds"?: string[];
}

/**
* RackDefinition represents details regarding the rack.
*/
model RackDefinition {
/**
* The zone name used for this rack when created. Availability zones are used for workload placement.
*/
@pattern("^[a-zA-Z0-9]{1,10}$")
"availabilityZone"?: string;
/**
* The unordered list of bare metal machine configuration.
*/
"bareMetalMachineConfigurationData"?: BareMetalMachineConfigurationData[];
/**
* The resource ID of the network rack that matches this rack definition.
*/
"networkRackId": string;
/**
* The free-form description of the rack's location.
*/
@maxLength(256)
"rackLocation"?: string;
/**
* The unique identifier for the rack within Network Cloud cluster. An alternate unique alphanumeric value other than a serial number may be provided if desired.
*/
@maxLength(64)
@minLength(1)
"rackSerialNumber": string;
/**
* The resource ID of the sku for the rack being added.
*/
"rackSkuId": string;
/**
* The list of storage appliance configuration data for this rack.
*/
"storageApplianceConfigurationData"?: StorageApplianceConfigurationData[];
}

/**
* BareMetalMachineConfigurationData represents configuration for the bare metal machine.
*/
model BareMetalMachineConfigurationData {
/**
* The connection string for the baseboard management controller including IP address and protocol.
*/
@visibility("read")
"bmcConnectionString"?: string;
/**
* The credentials of the baseboard management controller on this bare metal machine.
*/
"bmcCredentials": AdministrativeCredentials;
/**
* The MAC address of the BMC for this machine.
*/
@pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
"bmcMacAddress": string;
/**
* The MAC address associated with the PXE NIC card.
*/
@pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
"bootMacAddress": string;
/**
* The free-form additional information about the machine, e.g. an asset tag.
*/
@maxLength(256)
"machineDetails"?: string;
/**
* The user-provided name for the bare metal machine created from this specification.
If not provided, the machine name will be generated programmatically.
*/
@pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
"machineName"?: string;
/**
* The slot the physical machine is in the rack based on the BOM configuration.
*/
@maxValue(256)
@minValue(1)
"rackSlot": int64;
/**
* The serial number of the machine. Hardware suppliers may use an alternate value. For example, service tag.
*/
@maxLength(64)
"serialNumber": string;
}

/**
* StorageApplianceConfigurationData represents configuration for the storage application.
*/
model StorageApplianceConfigurationData {
/**
* The credentials of the administrative interface on this storage appliance.
*/
"adminCredentials": AdministrativeCredentials;
/**
* The slot that storage appliance is in the rack based on the BOM configuration.
*/
@maxValue(256)
@minValue(1)
"rackSlot": int64;
/**
* The serial number of the appliance.
*/
"serialNumber": string;
/**
* The user-provided name for the storage appliance that will be created from this specification.
*/
@pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
"storageApplianceName"?: string;
}

/**
* ClusterAvailableUpgradeVersion represents the various cluster upgrade parameters.
*/
model ClusterAvailableUpgradeVersion {
/**
* The indicator of whether the control plane will be impacted during the upgrade.
*/
@visibility("read")
"controlImpact"?: ControlImpact;
/**
* The expected duration needed for this upgrade.
*/
@visibility("read")
"expectedDuration"?: string;
/**
* The impact description including the specific details and release notes.
*/
@visibility("read")
"impactDescription"?: string;
/**
* The last date the version of the platform is supported.
*/
@visibility("read")
"supportExpiryDate"?: string;
/**
* The target version this cluster will be upgraded to.
*/
@visibility("read")
"targetClusterVersion"?: string;
/**
* The indicator of whether the workload will be impacted during the upgrade.
*/
@visibility("read")
"workloadImpact"?: WorkloadImpact;
}

/**
* ClusterCapacity represents various details regarding compute capacity.
*/
model ClusterCapacity {
/**
* The remaining appliance-based storage in GB available for workload use.
*/
"availableApplianceStorageGB"?: int64;
/**
* The remaining number of cores that are available in this cluster for workload use.
*/
"availableCoreCount"?: int64;
/**
* The remaining machine or host-based storage in GB available for workload use.
*/
"availableHostStorageGB"?: int64;
/**
* The remaining memory in GB that are available in this cluster for workload use.
*/
"availableMemoryGB"?: int64;
/**
* The total appliance-based storage in GB supported by this cluster for workload use.
*/
"totalApplianceStorageGB"?: int64;
/**
* The total number of cores that are supported by this cluster for workload use.
*/
"totalCoreCount"?: int64;
/**
* The total machine or host-based storage in GB supported by this cluster for workload use.
*/
"totalHostStorageGB"?: int64;
/**
* The total memory supported by this cluster for workload use.
*/
"totalMemoryGB"?: int64;
}

/**
* ServicePrincipalInformation represents the details of the service principal to be used by the cluster during Arc Appliance installation.
*/
model ServicePrincipalInformation {
/**
* The application ID, also known as client ID, of the service principal.
*/
"applicationId": string;
/**
* The password of the service principal.
*/
"password"?: string;
/**
* The principal ID, also known as the object ID, of the service principal.
*/
"principalId": string;
/**
* The tenant ID, also known as the directory ID, of the tenant in which the service principal is created.
*/
"tenantId": string;
}

/**
* ValidationThreshold indicates allowed machine and node hardware and deployment failures.
*/
model ValidationThreshold {
/**
* Selection of how the type evaluation is applied to the cluster calculation.
*/
"grouping": ValidationThresholdGrouping;
/**
* Selection of how the threshold should be evaluated.
*/
"type": ValidationThresholdType;
/**
* The numeric threshold value.
*/
"value": int64;
}

/**
* KubernetesClusterProperties represents the properties of Kubernetes cluster resource.
*/
model KubernetesClusterProperties {
/**
* The Azure Active Directory Integration properties.
*/
@visibility("read", "create")
"aadConfiguration"?: AadConfiguration;
/**
* The administrative credentials that will be applied to the control plane and agent pool nodes that do not specify their own values.
*/
@visibility("read", "create")
"administratorConfiguration"?: AdministratorConfiguration;
/**
* The full list of network resource IDs that are attached to this cluster, including those attached only to specific agent pools.
*/
@visibility("read")
"attachedNetworkIds"?: string[];
/**
* The list of versions that this Kubernetes cluster can be upgraded to.
*/
@visibility("read")
"availableUpgrades"?: AvailableUpgrade[];
/**
* The resource ID of the Network Cloud cluster.
*/
@visibility("read")
"clusterId"?: string;
/**
* The resource ID of the connected cluster set up when this Kubernetes cluster is created.
*/
@visibility("read")
"connectedClusterId"?: string;
/**
* The current running version of Kubernetes on the control plane.
*/
@visibility("read")
"controlPlaneKubernetesVersion"?: string;
/**
* The defining characteristics of the control plane for this Kubernetes Cluster.
*/
@visibility("read", "create")
"controlPlaneNodeConfiguration": ControlPlaneNodeConfiguration;
/**
* The current status of the Kubernetes cluster.
*/
@visibility("read")
"detailedStatus"?: KubernetesClusterDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The current feature settings.
*/
@visibility("read")
"featureStatuses"?: FeatureStatus[];
/**
* The agent pools that are created with this Kubernetes cluster for running critical system services and workloads. This data in this field is only used during creation, and the field will be empty following the creation of the Kubernetes Cluster. After creation, the management of agent pools is done using the agentPools sub-resource.
*/
@visibility("read", "create")
"initialAgentPoolConfigurations": InitialAgentPoolConfiguration[];
/**
* The Kubernetes version for this cluster. Accepts n.n, n.n.n, and n.n.n-n format. The interpreted version used will be resolved into this field after creation or update.
*/
"kubernetesVersion": string;
/**
* The configuration of the managed resource group associated with the resource.
*/
"managedResourceGroupConfiguration"?: ManagedResourceGroupConfiguration;
/**
* The configuration of the Kubernetes cluster networking, including the attachment of networks that span the cluster.
*/
@visibility("read", "create")
"networkConfiguration": NetworkConfiguration;
/**
* The details of the nodes in this cluster.
*/
@visibility("read")
"nodes"?: KubernetesClusterNode[];
/**
* The provisioning state of the Kubernetes cluster resource.
*/
@visibility("read")
"provisioningState"?: KubernetesClusterProvisioningState;
}

/**
* AadConfiguration represents the Azure Active Directory Integration properties.
*/
model AadConfiguration {
/**
* The list of Azure Active Directory group object IDs that will have an administrative role on the Kubernetes cluster.
*/
@visibility("read", "create")
"adminGroupObjectIds": string[];
}

/**
* AdministratorConfiguration represents the administrative credentials that will be applied to the control plane and agent pool nodes in Kubernetes clusters.
*/
model AdministratorConfiguration {
/**
* The user name for the administrator that will be applied to the operating systems that run Kubernetes nodes. If not supplied, a user name will be chosen by the service.
*/
@visibility("read", "create")
"adminUsername"?: string;
/**
* The SSH configuration for the operating systems that run the nodes in the Kubernetes cluster. In some cases, specification of public keys may be required to produce a working environment.
*/
@visibility("read", "create")
"sshPublicKeys"?: SshPublicKey[];
}

/**
* SshPublicKey represents the public key used to authenticate with a resource through SSH.
*/
model SshPublicKey {
/**
* The SSH public key data.
*/
@minLength(1)
"keyData": string;
}

/**
* AvailableUpgrade represents an upgrade available for a Kubernetes cluster.
*/
model AvailableUpgrade {
/**
* The version lifecycle indicator.
*/
@visibility("read")
"availabilityLifecycle"?: AvailabilityLifecycle;
/**
* The version available for upgrading.
*/
@visibility("read")
"version"?: string;
}

/**
* ControlPlaneNodeConfiguration represents the selection of virtual machines and size of the control plane for a Kubernetes cluster.
*/
model ControlPlaneNodeConfiguration {
/**
* The administrator credentials to be used for the nodes in the control plane.
*/
@visibility("read", "create")
"administratorConfiguration"?: AdministratorConfiguration;
/**
* The list of availability zones of the Network Cloud cluster to be used for the provisioning of nodes in the control plane. If not specified, all availability zones will be used.
*/
@visibility("read", "create")
"availabilityZones"?: string[];
/**
* The number of virtual machines that use this configuration.
*/
@minValue(1)
"count": int64;
/**
* The name of the VM SKU supplied during creation.
*/
@visibility("read", "create")
"vmSkuName": string;
}

/**
* FeatureStatus contains information regarding a Kubernetes cluster feature.
*/
model FeatureStatus {
/**
* The status representing the state of this feature.
*/
@visibility("read")
"detailedStatus"?: FeatureDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The name of the feature.
*/
@visibility("read")
"name"?: string;
/**
* The version of the feature.
*/
@visibility("read")
"version"?: string;
}

/**
* InitialAgentPoolConfiguration specifies the configuration of a pool of virtual machines that are initially defined with a Kubernetes cluster.
*/
model InitialAgentPoolConfiguration {
/**
* The administrator credentials to be used for the nodes in this agent pool.
*/
@visibility("read", "create")
"administratorConfiguration"?: AdministratorConfiguration;
/**
* The configurations that will be applied to each agent in this agent pool.
*/
@visibility("read", "create")
"agentOptions"?: AgentOptions;
/**
* The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.
*/
@visibility("read", "create")
"attachedNetworkConfiguration"?: AttachedNetworkConfiguration;
/**
* The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.
*/
@visibility("read", "create")
"availabilityZones"?: string[];
/**
* The number of virtual machines that use this configuration.
*/
@visibility("read", "create")
"count": int64;
/**
* The labels applied to the nodes in this agent pool.
*/
@visibility("read", "create")
"labels"?: KubernetesLabel[];
/**
* The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
*/
@visibility("read", "create")
"mode": AgentPoolMode;
/**
* The name that will be used for the agent pool resource representing this agent pool.
*/
@visibility("read", "create")
@pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
"name": string;
/**
* The taints applied to the nodes in this agent pool.
*/
@visibility("read", "create")
"taints"?: KubernetesLabel[];
/**
* The configuration of the agent pool.
*/
"upgradeSettings"?: AgentPoolUpgradeSettings;
/**
* The name of the VM SKU that determines the size of resources allocated for node VMs.
*/
@visibility("read", "create")
"vmSkuName": string;
}

/**
* AgentOptions are configurations that will be applied to each agent in an agent pool.
*/
model AgentOptions {
/**
* The number of hugepages to allocate.
*/
"hugepagesCount": int64;
/**
* The size of the hugepages to allocate.
*/
@visibility("read", "create")
"hugepagesSize"?: HugepagesSize = HugepagesSize.2M;
}

/**
* AttachedNetworkConfiguration represents the set of workload networks to attach to a resource.
*/
model AttachedNetworkConfiguration {
/**
* The list of Layer 2 Networks and related configuration for attachment.
*/
@visibility("read", "create")
"l2Networks"?: L2NetworkAttachmentConfiguration[];
/**
* The list of Layer 3 Networks and related configuration for attachment.
*/
@visibility("read", "create")
"l3Networks"?: L3NetworkAttachmentConfiguration[];
/**
* The list of Trunked Networks and related configuration for attachment.
*/
@visibility("read", "create")
"trunkedNetworks"?: TrunkedNetworkAttachmentConfiguration[];
}

/**
* L2NetworkAttachmentConfiguration represents the configuration of the attachment of a Layer 2 network.
*/
model L2NetworkAttachmentConfiguration {
/**
* The resource ID of the network that is being configured for attachment.
*/
@visibility("read", "create")
"networkId": string;
/**
* The indicator of how this network will be utilized by the Kubernetes cluster.
*/
@visibility("read", "create")
"pluginType"?: KubernetesPluginType;
}

/**
* L3NetworkAttachmentConfiguration represents the configuration of the attachment of a Layer 3 network.
*/
model L3NetworkAttachmentConfiguration {
/**
* The indication of whether this network will or will not perform IP address management and allocate IP addresses when attached.
*/
@visibility("read", "create")
"ipamEnabled"?: L3NetworkConfigurationIpamEnabled = L3NetworkConfigurationIpamEnabled.False;
/**
* The resource ID of the network that is being configured for attachment.
*/
@visibility("read", "create")
"networkId": string;
/**
* The indicator of how this network will be utilized by the Kubernetes cluster.
*/
@visibility("read", "create")
"pluginType"?: KubernetesPluginType;
}

/**
* TrunkedNetworkAttachmentConfiguration represents the configuration of the attachment of a trunked network.
*/
model TrunkedNetworkAttachmentConfiguration {
/**
* The resource ID of the network that is being configured for attachment.
*/
@visibility("read", "create")
"networkId": string;
/**
* The indicator of how this network will be utilized by the Kubernetes cluster.
*/
@visibility("read", "create")
"pluginType"?: KubernetesPluginType;
}

/**
* KubernetesLabel represents a single entry for a Kubernetes label or taint such as those used on a node or pod.
*/
model KubernetesLabel {
/**
* The name of the label or taint.
*/
@visibility("read", "create")
"key": string;
/**
* The value of the label or taint.
*/
@visibility("read", "create")
"value": string;
}

/**
* AgentPoolUpgradeSettings specifies the upgrade settings for an agent pool.
*/
model AgentPoolUpgradeSettings {
/**
* The maximum number or percentage of nodes that are surged during upgrade. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified, the default is 1.
*/
"maxSurge"?: string = "1";
}

/**
* NetworkConfiguration specifies the Kubernetes cluster network related configuration.
*/
model NetworkConfiguration {
/**
* The configuration of networks being attached to the cluster for use by the workloads that run on this Kubernetes cluster.
*/
@visibility("read", "create")
"attachedNetworkConfiguration"?: AttachedNetworkConfiguration;
/**
* The configuration of the BGP service load balancer for this Kubernetes cluster.
*/
@visibility("read", "create")
"bgpServiceLoadBalancerConfiguration"?: BgpServiceLoadBalancerConfiguration;
/**
* The resource ID of the associated Cloud Services network.
*/
@visibility("read", "create")
"cloudServicesNetworkId": string;
/**
* The resource ID of the Layer 3 network that is used for creation of the Container Networking Interface network.
*/
@visibility("read", "create")
"cniNetworkId": string;
/**
* The IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in service CIDR.
*/
@visibility("read", "create")
"dnsServiceIp"?: string;
/**
* The CIDR notation IP ranges from which to assign pod IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.
*/
@visibility("read", "create")
"podCidrs"?: string[];
/**
* The CIDR notation IP ranges from which to assign service IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.
*/
@visibility("read", "create")
"serviceCidrs"?: string[];
}

/**
* BgpServiceLoadBalancerConfiguration represents the configuration of a BGP service load balancer.
*/
model BgpServiceLoadBalancerConfiguration {
/**
* The association of IP address pools to the communities and peers, allowing for announcement of IPs.
*/
@visibility("read", "create")
"bgpAdvertisements"?: BgpAdvertisement[];
/**
* The list of additional BgpPeer entities that the Kubernetes cluster will peer with. All peering must be explicitly defined.
*/
@visibility("read", "create")
"bgpPeers"?: ServiceLoadBalancerBgpPeer[];
/**
* The indicator to specify if the load balancer peers with the network fabric.
*/
@visibility("read", "create")
"fabricPeeringEnabled"?: FabricPeeringEnabled = FabricPeeringEnabled.True;
/**
* The list of pools of IP addresses that can be allocated to Load Balancer services.
*/
@visibility("read", "create")
"ipAddressPools"?: IpAddressPool[];
}

/**
* BgpAdvertisement represents the association of IP address pools to the communities and peers.
*/
model BgpAdvertisement {
/**
* The indicator of if this advertisement is also made to the network fabric associated with the Network Cloud Cluster. This field is ignored if fabricPeeringEnabled is set to False.
*/
@visibility("read", "create")
"advertiseToFabric"?: AdvertiseToFabric = AdvertiseToFabric.True;
/**
* The names of the BGP communities to be associated with the announcement, utilizing a BGP community string in 1234:1234 format.
*/
@visibility("read", "create")
"communities"?: string[];
/**
* The names of the IP address pools associated with this announcement.
*/
@visibility("read", "create")
"ipAddressPools": string[];
/**
* The names of the BGP peers to limit this advertisement to. If no values are specified, all BGP peers will receive this advertisement.
*/
@visibility("read", "create")
"peers"?: string[];
}

/**
* ServiceLoadBalancerBgpPeer represents the configuration of the BGP service load balancer for the Kubernetes cluster.
*/
model ServiceLoadBalancerBgpPeer {
/**
* The indicator of BFD enablement for this BgpPeer.
*/
@visibility("read", "create")
"bfdEnabled"?: BfdEnabled;
/**
* The indicator to enable multi-hop peering support.
*/
@visibility("read", "create")
"bgpMultiHop"?: BgpMultiHop = BgpMultiHop.False;
/**
* The requested BGP hold time value. This field uses ISO 8601 duration format, for example P1H.
*/
@visibility("read", "create")
"holdTime"?: string;
/**
* The requested BGP keepalive time value. This field uses ISO 8601 duration format, for example P1H.
*/
@visibility("read", "create")
"keepAliveTime"?: string;
/**
* The autonomous system number used for the local end of the BGP session.
*/
@visibility("read", "create")
@maxValue(4294967295)
"myAsn"?: int64;
/**
* The name used to identify this BGP peer for association with a BGP advertisement.
*/
@visibility("read", "create")
@pattern("^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9]){0,1}$")
"name": string;
/**
* The authentication password for routers enforcing TCP MD5 authenticated sessions.
*/
@visibility("create")
@maxLength(80)
@pattern("^[a-zA-Z0-9]{0,80}$")
"password"?: string;
/**
* The IPv4 or IPv6 address used to connect this BGP session.
*/
@visibility("read", "create")
"peerAddress": string;
/**
* The autonomous system number expected from the remote end of the BGP session.
*/
@visibility("read", "create")
@maxValue(4294967295)
"peerAsn": int64;
/**
* The port used to connect this BGP session.
*/
@visibility("read", "create")
"peerPort"?: int64 = 179;
}

/**
* IpAddressPool represents a pool of IP addresses that can be allocated to a service.
*/
model IpAddressPool {
/**
* The list of IP address ranges. Each range can be a either a subnet in CIDR format or an explicit start-end range of IP addresses.
*/
@visibility("read", "create")
"addresses": string[];
/**
* The indicator to determine if automatic allocation from the pool should occur.
*/
@visibility("read", "create")
"autoAssign"?: BfdEnabled;
/**
* The name used to identify this IP address pool for association with a BGP advertisement.
*/
@visibility("read", "create")
@pattern("^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9]){0,1}$")
"name": string;
/**
* The indicator to prevent the use of IP addresses ending with .0 and .255 for this pool. Enabling this option will only use IP addresses between .1 and .254 inclusive.
*/
@visibility("read", "create")
"onlyUseHostIps"?: BfdEnabled;
}

/**
* KubernetesClusterNode represents the details of a node in a Kubernetes cluster.
*/
model KubernetesClusterNode {
/**
* The resource ID of the agent pool that this node belongs to. This value is not represented on control plane nodes.
*/
@visibility("read")
"agentPoolId"?: string;
/**
* The availability zone this node is running within.
*/
@visibility("read")
"availabilityZone"?: string;
/**
* The resource ID of the bare metal machine that hosts this node.
*/
@visibility("read")
"bareMetalMachineId"?: string;
/**
* The number of CPU cores configured for this node, derived from the VM SKU specified.
*/
@visibility("read")
"cpuCores"?: int64;
/**
* The detailed state of this node.
*/
@visibility("read")
"detailedStatus"?: KubernetesClusterNodeDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The size of the disk configured for this node.
*/
@visibility("read")
"diskSizeGB"?: int64;
/**
* The machine image used to deploy this node.
*/
@visibility("read")
"image"?: string;
/**
* The currently running version of Kubernetes and bundled features running on this node.
*/
@visibility("read")
"kubernetesVersion"?: string;
/**
* The list of labels on this node that have been assigned to the agent pool containing this node.
*/
@visibility("read")
"labels"?: KubernetesLabel[];
/**
* The amount of memory configured for this node, derived from the vm SKU specified.
*/
@visibility("read")
"memorySizeGB"?: int64;
/**
* The mode of the agent pool containing this node. Not applicable for control plane nodes.
*/
@visibility("read")
"mode"?: AgentPoolMode;
/**
* The name of this node, as realized in the Kubernetes cluster.
*/
@visibility("read")
"name"?: string;
/**
* The NetworkAttachments made to this node.
*/
@visibility("read")
"networkAttachments"?: NetworkAttachment[];
/**
* The power state of this node.
*/
@visibility("read")
"powerState"?: KubernetesNodePowerState;
/**
* The role of this node in the cluster.
*/
@visibility("read")
"role"?: KubernetesNodeRole;
/**
* The list of taints that have been assigned to the agent pool containing this node.
*/
@visibility("read")
"taints"?: KubernetesLabel[];
/**
* The VM SKU name that was used to create this cluster node.
*/
@visibility("read")
"vmSkuName"?: string;
}

/**
* NetworkAttachment represents the single network attachment.
*/
model NetworkAttachment {
/**
* The resource ID of the associated network attached to the virtual machine.
It can be one of cloudServicesNetwork, l3Network, l2Network or trunkedNetwork resources.
*/
@visibility("read", "create")
"attachedNetworkId": string;
/**
* The indicator of whether this is the default gateway.
Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
*/
"defaultGateway"?: DefaultGateway;
/**
* The IP allocation mechanism for the virtual machine.
Dynamic and Static are only valid for l3Network which may also specify Disabled.
Otherwise, Disabled is the only permitted value.
*/
@visibility("read", "create")
"ipAllocationMethod": VirtualMachineIPAllocationMethod;
/**
* The IPv4 address of the virtual machine.

This field is used only if the attached network has IPAllocationType of IPV4 or DualStack.

If IPAllocationMethod is:
Static - this field must contain a user specified IPv4 address from within the subnet specified in the attached network.
Dynamic - this field is read-only, but will be populated with an address from within the subnet specified in the attached network.
Disabled - this field will be empty.
*/
@visibility("read", "create")
"ipv4Address"?: string;
/**
* The IPv6 address of the virtual machine.

This field is used only if the attached network has IPAllocationType of IPV6 or DualStack.

If IPAllocationMethod is:
Static - this field must contain an IPv6 address range from within the range specified in the attached network.
Dynamic - this field is read-only, but will be populated with an range from within the subnet specified in the attached network.
Disabled - this field will be empty.
*/
@visibility("read", "create")
"ipv6Address"?: string;
/**
* The MAC address of the interface for the virtual machine that corresponds to this network attachment.
*/
@visibility("read")
"macAddress"?: string;
/**
* The associated network's interface name.
If specified, the network attachment name has a maximum length of 15 characters and must be unique to this virtual machine.
If the user doesn’t specify this value, the default interface name of the network resource will be used.
For a CloudServicesNetwork resource, this name will be ignored.
*/
@visibility("read", "create")
@maxLength(15)
"networkAttachmentName"?: string;
}

/**
* L2NetworkProperties represents properties of the L2 network.
*/
model L2NetworkProperties {
/**
* The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
*/
@visibility("read")
"associatedResourceIds"?: string[];
/**
* The resource ID of the Network Cloud cluster this L2 network is associated with.
*/
@visibility("read")
"clusterId"?: string;
/**
* The more detailed status of the L2 network.
*/
@visibility("read")
"detailedStatus"?: L2NetworkDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource ID(s) that are associated with this L2 network.
*/
@visibility("read")
"hybridAksClustersAssociatedIds"?: string[];
/**
* Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
*/
@visibility("read", "create")
"hybridAksPluginType"?: HybridAksPluginType;
/**
* The default interface name for this L2 network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
*/
@visibility("read", "create")
@maxLength(12)
@pattern("^[a-zA-Z0-9@._-]*$")
"interfaceName"?: string;
/**
* The resource ID of the Network Fabric l2IsolationDomain.
*/
@visibility("read", "create")
"l2IsolationDomainId": string;
/**
* The provisioning state of the L2 network.
*/
@visibility("read")
"provisioningState"?: L2NetworkProvisioningState;
/**
* Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource ID(s), excluding any Hybrid AKS virtual machines, that are currently using this L2 network.
*/
@visibility("read")
"virtualMachinesAssociatedIds"?: string[];
}

/**
* L3NetworkProperties represents properties of the L3 network.
*/
model L3NetworkProperties {
/**
* The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
*/
@visibility("read")
"associatedResourceIds"?: string[];
/**
* The resource ID of the Network Cloud cluster this L3 network is associated with.
*/
@visibility("read")
"clusterId"?: string;
/**
* The more detailed status of the L3 network.
*/
@visibility("read")
"detailedStatus"?: L3NetworkDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this L3 network.
*/
@visibility("read")
"hybridAksClustersAssociatedIds"?: string[];
/**
* Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The indicator of whether or not to disable IPAM allocation on the network attachment definition injected into the Hybrid AKS Cluster.
*/
@visibility("read", "create")
"hybridAksIpamEnabled"?: HybridAksIpamEnabled = HybridAksIpamEnabled.True;
/**
* Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
*/
@visibility("read", "create")
"hybridAksPluginType"?: HybridAksPluginType;
/**
* The default interface name for this L3 network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
*/
@visibility("read", "create")
@maxLength(12)
@pattern("^[a-zA-Z0-9@._-]*$")
"interfaceName"?: string;
/**
* The type of the IP address allocation, defaulted to "DualStack".
*/
"ipAllocationType"?: IpAllocationType = IpAllocationType.DualStack;
/**
* The IPV4 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type
is IPV4 or DualStack.
*/
@visibility("read", "create")
"ipv4ConnectedPrefix"?: string;
/**
* The IPV6 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type
is IPV6 or DualStack.
*/
@visibility("read", "create")
"ipv6ConnectedPrefix"?: string;
/**
* The resource ID of the Network Fabric l3IsolationDomain.
*/
@visibility("read", "create")
"l3IsolationDomainId": string;
/**
* The provisioning state of the L3 network.
*/
@visibility("read")
"provisioningState"?: L3NetworkProvisioningState;
/**
* Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this L3 network.
*/
@visibility("read")
"virtualMachinesAssociatedIds"?: string[];
/**
* The VLAN from the l3IsolationDomain that is used for this network.
*/
@visibility("read", "create")
"vlan": int64;
}

/**
* RackSkuProperties represents the properties of compute-related hardware for a rack. This supports both aggregator and compute racks.
*/
model RackSkuProperties {
/**
* The list of machine SKUs and associated rack slot for the compute-dedicated machines in this rack model.
*/
@visibility("read")
"computeMachines"?: MachineSkuSlot[];
/**
* The list of machine SKUs and associated rack slot for the control-plane dedicated machines in this rack model.
*/
@visibility("read")
"controllerMachines"?: MachineSkuSlot[];
/**
* The free-form text describing the rack.
*/
@visibility("read")
"description"?: string;
/**
* The maximum number of compute racks supported by an aggregator rack. 0 if this is a compute rack or a rack for a single rack cluster(rackType="Single").
*/
@visibility("read")
"maxClusterSlots"?: int64;
/**
* The provisioning state of the rack SKU resource.
*/
@visibility("read")
"provisioningState"?: RackSkuProvisioningState;
/**
* The type of the rack.
*/
@visibility("read")
"rackType"?: RackSkuType;
/**
* The list of appliance SKUs and associated rack slot for the storage appliance(s) in this rack model.
*/
@visibility("read")
"storageAppliances"?: StorageApplianceSkuSlot[];
/**
* The list of supported SKUs if the rack is an aggregator.
*/
@visibility("read")
"supportedRackSkuIds"?: string[];
}

/**
* MachineSkuSlot represents a single SKU and rack slot associated with the machine.
*/
model MachineSkuSlot {
/**
* The list of the resource properties.
*/
"properties"?: MachineSkuProperties;
/**
* The position in the rack for the machine.
*/
@visibility("read")
"rackSlot"?: int64;
}

/**
* MachineSkuProperties represents the properties of the machine SKU.
*/
model MachineSkuProperties {
/**
* The type of bootstrap protocol used.
*/
@visibility("read")
"bootstrapProtocol"?: BootstrapProtocol;
/**
* The count of CPU cores for this machine.
*/
@visibility("read")
"cpuCores"?: int64;
/**
* The count of CPU sockets for this machine.
*/
@visibility("read")
"cpuSockets"?: int64;
/**
* The list of disks.
*/
@visibility("read")
"disks"?: MachineDisk[];
/**
* The generation of the architecture.
*/
@visibility("read")
"generation"?: string;
/**
* The hardware version of the machine.
*/
@visibility("read")
"hardwareVersion"?: string;
/**
* The maximum amount of memory in GB.
*/
@visibility("read")
"memoryCapacityGB"?: int64;
/**
* The model of the machine.
*/
@visibility("read")
"model"?: string;
/**
* The list of network interfaces.
*/
@visibility("read")
"networkInterfaces"?: NetworkInterface[];
/**
* The count of SMT and physical core threads for this machine.
*/
@visibility("read")
"totalThreads"?: int64;
/**
* The make of the machine.
*/
@visibility("read")
"vendor"?: string;
}

/**
* Disk represents the properties of the disk.
*/
model MachineDisk {
/**
* The maximum amount of storage in GB.
*/
@visibility("read")
"capacityGB"?: int64;
/**
* The connection type of the rack SKU resource.
*/
@visibility("read")
"connection"?: MachineSkuDiskConnectionType;
/**
* The disk type of rack SKU resource.
*/
@visibility("read")
"type"?: DiskType;
}

/**
* NetworkInterface represents properties of the network interface.
*/
model NetworkInterface {
/**
* The partial address of Peripheral Component Interconnect (PCI).
*/
@visibility("read")
"address"?: string;
/**
* The connection type of the device.
*/
@visibility("read")
"deviceConnectionType"?: DeviceConnectionType;
/**
* The model name of the device.
*/
@visibility("read")
"model"?: string;
/**
* The physical slot for this device.
*/
@visibility("read")
"physicalSlot"?: int64;
/**
* The number of ports on the device.
*/
@visibility("read")
"portCount"?: int64;
/**
* The maximum amount of data in GB that the line card transmits through a port at any given second.
*/
@visibility("read")
"portSpeed"?: int64;
/**
* The vendor name of the device.
*/
@visibility("read")
"vendor"?: string;
}

/**
* StorageApplianceSkuSlot represents the single SKU and rack slot associated with the storage appliance.
*/
model StorageApplianceSkuSlot {
/**
* The list of the resource properties.
*/
"properties"?: StorageApplianceSkuProperties;
/**
* The position in the rack for the storage appliance.
*/
@visibility("read")
"rackSlot"?: int64;
}

/**
* StorageApplianceSkuProperties represents the properties of the storage appliance SKU.
*/
model StorageApplianceSkuProperties {
/**
* The maximum capacity of the storage appliance.
*/
@visibility("read")
"capacityGB"?: int64;
/**
* The model of the storage appliance.
*/
@visibility("read")
"model"?: string;
}

/**
* RackProperties represents the properties of the rack.
*/
model RackProperties {
/**
* The value that will be used for machines in this rack to represent the availability zones that can be referenced by Hybrid AKS Clusters for node arrangement.
*/
@pattern("^[a-zA-Z0-9]{1,10}$")
"availabilityZone": string;
/**
* The resource ID of the cluster the rack is created for. This value is set when the rack is created by the cluster.
*/
@visibility("read")
"clusterId"?: string;
/**
* The more detailed status of the rack.
*/
@visibility("read")
"detailedStatus"?: RackDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The provisioning state of the rack resource.
*/
@visibility("read")
"provisioningState"?: RackProvisioningState;
/**
* The free-form description of the rack location. (e.g. “DTN Datacenter, Floor 3, Isle 9, Rack 2B”)
*/
@maxLength(256)
"rackLocation": string;
/**
* The unique identifier for the rack within Network Cloud cluster. An alternate unique alphanumeric value other than a serial number may be provided if desired.
*/
@maxLength(64)
@minLength(1)
"rackSerialNumber": string;
/**
* The SKU for the rack.
*/
"rackSkuId": string;
}

/**
* StorageApplianceProperties represents the properties of the storage appliance.
*/
model StorageApplianceProperties {
/**
* The credentials of the administrative interface on this storage appliance.
*/
@visibility("read", "create")
"administratorCredentials": AdministrativeCredentials;
/**
* The total capacity of the storage appliance.
*/
@visibility("read")
"capacity"?: int64;
/**
* The amount of storage consumed.
*/
@visibility("read")
"capacityUsed"?: int64;
/**
* The resource ID of the cluster this storage appliance is associated with.
*/
@visibility("read")
"clusterId"?: string;
/**
* The detailed status of the storage appliance.
*/
@visibility("read")
"detailedStatus"?: StorageApplianceDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The endpoint for the management interface of the storage appliance.
*/
@visibility("read")
"managementIpv4Address"?: string;
/**
* The provisioning state of the storage appliance.
*/
@visibility("read")
"provisioningState"?: StorageApplianceProvisioningState;
/**
* The resource ID of the rack where this storage appliance resides.
*/
@visibility("read", "create")
"rackId": string;
/**
* The slot the storage appliance is in the rack based on the BOM configuration.
*/
@visibility("read", "create")
@maxValue(256)
@minValue(1)
"rackSlot": int64;
/**
* The indicator of whether the storage appliance supports remote vendor management.
*/
@visibility("read")
"remoteVendorManagementFeature"?: RemoteVendorManagementFeature;
/**
* The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.
*/
@visibility("read")
"remoteVendorManagementStatus"?: RemoteVendorManagementStatus;
/**
* The serial number for the storage appliance.
*/
"serialNumber": string;
/**
* The SKU for the storage appliance.
*/
@visibility("read", "create")
"storageApplianceSkuId": string;
}

/**
* TrunkedNetworkProperties represents properties of the trunked network.
*/
model TrunkedNetworkProperties {
/**
* The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
*/
@visibility("read")
"associatedResourceIds"?: string[];
/**
* The resource ID of the Network Cloud cluster this trunked network is associated with.
*/
@visibility("read")
"clusterId"?: string;
/**
* The more detailed status of the trunked network.
*/
@visibility("read")
"detailedStatus"?: TrunkedNetworkDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this trunked network.
*/
@visibility("read")
"hybridAksClustersAssociatedIds"?: string[];
/**
* Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
*/
@visibility("read", "create")
"hybridAksPluginType"?: HybridAksPluginType;
/**
* The default interface name for this trunked network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
*/
@visibility("read", "create")
@maxLength(12)
@pattern("^[a-zA-Z0-9@._-]*$")
"interfaceName"?: string;
/**
* The list of resource IDs representing the Network Fabric isolation domains. It can be any combination of l2IsolationDomain and l3IsolationDomain resources.
*/
@visibility("read", "create")
"isolationDomainIds": string[];
/**
* The provisioning state of the trunked network.
*/
@visibility("read")
"provisioningState"?: TrunkedNetworkProvisioningState;
/**
* Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this trunked network.
*/
@visibility("read")
"virtualMachinesAssociatedIds"?: string[];
/**
* The list of vlans that are selected from the isolation domains for trunking.
*/
@visibility("read", "create")
"vlans": int64[];
}

/**
* VirtualMachineProperties represents the properties of the virtual machine.
*/
model VirtualMachineProperties {
/**
* The name of the administrator to which the ssh public keys will be added into the authorized keys.
*/
@visibility("read", "create")
@maxLength(32)
@minLength(1)
@pattern("^[a-z_][a-z0-9_]{0,31}$")
"adminUsername": string;
/**
* The cluster availability zone containing this virtual machine.
*/
@visibility("read")
"availabilityZone"?: string;
/**
* The resource ID of the bare metal machine the virtual machine has landed to.
*/
@visibility("read")
"bareMetalMachineId"?: string;
/**
* Selects the boot method for the virtual machine.
*/
@visibility("read", "create")
"bootMethod"?: VirtualMachineBootMethod = VirtualMachineBootMethod.UEFI;
/**
* The cloud service network that provides platform-level services for the virtual machine.
*/
@visibility("read", "create")
"cloudServicesNetworkAttachment": NetworkAttachment;
/**
* The resource ID of the cluster the virtual machine is created for.
*/
@visibility("read")
"clusterId"?: string;
/**
* The number of CPU cores in the virtual machine.
*/
@visibility("read", "create")
@minValue(2)
"cpuCores": int64;
/**
* The more detailed status of the virtual machine.
*/
@visibility("read")
"detailedStatus"?: VirtualMachineDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.
*/
@visibility("read", "create")
"isolateEmulatorThread"?: VirtualMachineIsolateEmulatorThread = VirtualMachineIsolateEmulatorThread.True;
/**
* The memory size of the virtual machine in GB.
*/
@visibility("read", "create")
@minValue(1)
"memorySizeGB": int64;
/**
* The list of network attachments to the virtual machine.
*/
@visibility("read", "create")
"networkAttachments"?: NetworkAttachment[];
/**
* The Base64 encoded cloud-init network data.
*/
@visibility("read", "create")
"networkData"?: string;
/**
* The scheduling hints for the virtual machine.
*/
@visibility("read", "create")
"placementHints"?: VirtualMachinePlacementHint[];
/**
* The power state of the virtual machine.
*/
@visibility("read")
"powerState"?: VirtualMachinePowerState;
/**
* The provisioning state of the virtual machine.
*/
@visibility("read")
"provisioningState"?: VirtualMachineProvisioningState;
/**
* The list of ssh public keys. Each key will be added to the virtual machine using the cloud-init ssh_authorized_keys mechanism for the adminUsername.
*/
@visibility("read", "create")
"sshPublicKeys"?: SshPublicKey[];
/**
* The storage profile that specifies size and other parameters about the disks related to the virtual machine.
*/
@visibility("read", "create")
"storageProfile": StorageProfile;
/**
* The Base64 encoded cloud-init user data.
*/
@visibility("read", "create")
"userData"?: string;
/**
* Field Deprecated, use virtualizationModel instead. The type of the virtio interface.
*/
@visibility("read", "create")
"virtioInterface"?: VirtualMachineVirtioInterfaceType = VirtualMachineVirtioInterfaceType.Modern;
/**
* The type of the device model to use.
*/
@visibility("read", "create")
"vmDeviceModel"?: VirtualMachineDeviceModelType = VirtualMachineDeviceModelType.T2;
/**
* The virtual machine image that is currently provisioned to the OS disk, using the full url and tag notation used to pull the image.
*/
@visibility("read", "create")
"vmImage": string;
/**
* The credentials used to login to the image repository that has access to the specified image.
*/
"vmImageRepositoryCredentials"?: ImageRepositoryCredentials;
/**
* The resource IDs of volumes that are attached to the virtual machine.
*/
@visibility("read")
"volumes"?: string[];
}

/**
* VirtualMachinePlacementHint represents a single scheduling hint of the virtual machine.
*/
model VirtualMachinePlacementHint {
/**
* The specification of whether this hint supports affinity or anti-affinity with the referenced resources.
*/
@visibility("read", "create")
"hintType": VirtualMachinePlacementHintType;
/**
* The resource ID of the target object that the placement hints will be checked against, e.g., the bare metal node to host the virtual machine.
*/
@visibility("read", "create")
@minLength(1)
"resourceId": string;
/**
* The indicator of whether the hint is a hard or soft requirement during scheduling.
*/
@visibility("read", "create")
"schedulingExecution": VirtualMachineSchedulingExecution;
/**
* The scope for the virtual machine affinity or anti-affinity placement hint. It should always be "Machine" in the case of node affinity.
*/
@visibility("read", "create")
"scope": VirtualMachinePlacementHintPodAffinityScope;
}

/**
* StorageProfile represents information about a disk.
*/
model StorageProfile {
/**
* The disk to use with this virtual machine.
*/
"osDisk": OsDisk;
/**
* The resource IDs of volumes that are requested to be attached to the virtual machine.
*/
"volumeAttachments"?: string[];
}

/**
* OsDisk represents configuration of the boot disk.
*/
model OsDisk {
/**
* The strategy for creating the OS disk.
*/
"createOption"?: OsDiskCreateOption = OsDiskCreateOption.Ephemeral;
/**
* The strategy for deleting the OS disk.
*/
"deleteOption"?: OsDiskDeleteOption = OsDiskDeleteOption.Delete;
/**
* The size of the disk in gigabytes. Required if the createOption is Ephemeral.
*/
"diskSizeGB": int64;
}

/**
* ImageRepositoryCredentials represents the credentials used to login to the image repository.
*/
model ImageRepositoryCredentials {
/**
* The password or token used to access an image in the target repository.
*/
@minLength(1)
"password"?: string;
/**
* The URL of the authentication server used to validate the repository credentials.
*/
"registryUrl": string;
/**
* The username used to access an image in the target repository.
*/
@minLength(1)
"username": string;
}

/**
* VolumeProperties represents properties of the volume resource.
*/
model VolumeProperties {
/**
* The list of resource IDs that attach the volume. It may include virtual machines and Hybrid AKS clusters.
*/
@visibility("read")
"attachedTo"?: string[];
/**
* The more detailed status of the volume.
*/
@visibility("read")
"detailedStatus"?: VolumeDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The provisioning state of the volume.
*/
@visibility("read")
"provisioningState"?: VolumeProvisioningState;
/**
* The unique identifier of the volume.
*/
@visibility("read")
"serialNumber"?: string;
/**
* The size of the allocation for this volume in Mebibytes.
*/
@visibility("read", "create")
@minValue(1)
"sizeMiB": int64;
}

/**
* BareMetalMachinePatchParameters represents the body of the request to patch bare metal machine properties.
*/
model BareMetalMachinePatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: BareMetalMachinePatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* BareMetalMachinePatchProperties represents the properties of the bare metal machine that can be patched.
*/
model BareMetalMachinePatchProperties {
/**
* The details provided by the customer during the creation of rack manifests
that allows for custom data to be associated with this machine.
*/
@maxLength(256)
"machineDetails"?: string;
}

/**
* BareMetalMachineCordonParameters represents the body of the request to evacuate workloads from node on a bare metal machine.
*/
model BareMetalMachineCordonParameters {
/**
* The indicator of whether to evacuate the node workload when the bare metal machine is cordoned.
*/
"evacuate"?: BareMetalMachineEvacuate = BareMetalMachineEvacuate.False;
}

/**
* BareMetalMachinePowerOffParameters represents the body of the request to power off bare metal machine.
*/
model BareMetalMachinePowerOffParameters {
/**
* The indicator of whether to skip the graceful OS shutdown and power off the bare metal machine immediately.
*/
"skipShutdown"?: BareMetalMachineSkipShutdown = BareMetalMachineSkipShutdown.False;
}

/**
* BareMetalMachineReplaceParameters represents the body of the request to physically swap a bare metal machine for another.
*/
model BareMetalMachineReplaceParameters {
/**
* The credentials of the baseboard management controller on this bare metal machine.
*/
"bmcCredentials"?: AdministrativeCredentials;
/**
* The MAC address of the BMC device.
*/
@pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
"bmcMacAddress"?: string;
/**
* The MAC address of a NIC connected to the PXE network.
*/
@pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
"bootMacAddress"?: string;
/**
* The OS-level hostname assigned to this machine.
*/
@pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
"machineName"?: string;
/**
* The serial number of the bare metal machine.
*/
@maxLength(64)
@minLength(1)
"serialNumber"?: string;
}

/**
* BareMetalMachineRunCommandParameters represents the body of the request to execute a script on the bare metal machine.
*/
model BareMetalMachineRunCommandParameters {
/**
* The list of string arguments that will be passed to the script in order as separate arguments.
*/
"arguments"?: string[];
/**
* The maximum time the script is allowed to run.
If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
*/
@maxValue(14400)
@minValue(60)
"limitTimeSeconds": int64;
/**
* The base64 encoded script to execute on the bare metal machine.
*/
"script": string;
}

/**
* BareMetalMachineRunDataExtractsParameters represents the body of request containing list of curated data extraction commands to run on the bare metal machine.
*/
model BareMetalMachineRunDataExtractsParameters {
/**
* The list of curated data extraction commands to be executed directly against the target machine.
*/
"commands": BareMetalMachineCommandSpecification[];
/**
* The maximum time the commands are allowed to run.
If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
*/
@maxValue(14400)
@minValue(60)
"limitTimeSeconds": int64;
}

/**
* BareMetalMachineCommandSpecification represents the command and optional arguments to exercise against the bare metal machine.
*/
model BareMetalMachineCommandSpecification {
/**
* The list of string arguments that will be passed to the script in order as separate arguments.
*/
"arguments"?: string[];
/**
* The command to execute against the bare metal machine.
*/
"command": string;
}

/**
* BareMetalMachineRunReadCommandsParameters represents the body of request containing list of read-only commands to run on the bare metal machine.
*/
model BareMetalMachineRunReadCommandsParameters {
/**
* The list of read-only commands to be executed directly against the target machine.
*/
"commands": BareMetalMachineCommandSpecification[];
/**
* The maximum time the commands are allowed to run.
If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
*/
@maxValue(14400)
@minValue(60)
"limitTimeSeconds": int64;
}

/**
* CloudServicesNetworkPatchParameters represents the body of the request to patch the cloud services network.
*/
model CloudServicesNetworkPatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: CloudServicesNetworkPatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* CloudServicesNetworkPatchProperties represents the properties of the cloud services network that can be updated using a patch request.
*/
model CloudServicesNetworkPatchProperties {
/**
* The list of egress endpoints. This allows for connection from a Hybrid AKS cluster to the specified endpoint.
*/
"additionalEgressEndpoints"?: EgressEndpoint[];
/**
* The indicator of whether the platform default endpoints are allowed for the egress traffic.
*/
"enableDefaultEgressEndpoints"?: CloudServicesNetworkEnableDefaultEgressEndpoints;
}

/**
* ClusterManagerPatchParameters represents the body of the request to patch the cluster properties.
*/
model ClusterManagerPatchParameters {
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* ClusterPatchParameters represents the body of the request to patch the cluster properties.
*/
model ClusterPatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: ClusterPatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* ClusterPatchProperties represents the properties of the cluster for patching.
*/
model ClusterPatchProperties {
/**
* The rack definition that is intended to reflect only a single rack in a single rack cluster, or an aggregator rack in a multi-rack cluster.
*/
"aggregatorOrSingleRackDefinition"?: RackDefinition;
/**
* The customer-provided location information to identify where the cluster resides.
*/
"clusterLocation"?: string;
/**
* The service principal to be used by the cluster during Arc Appliance installation.
*/
"clusterServicePrincipal"?: ServicePrincipalInformation;
/**
* The validation threshold indicating the allowable failures of compute machines during environment validation and deployment.
*/
"computeDeploymentThreshold"?: ValidationThreshold;
/**
* The list of rack definitions for the compute racks in a multi-rack
cluster, or an empty list in a single-rack cluster.
*/
"computeRackDefinitions"?: RackDefinition[];
}

/**
* BareMetalMachineKeySetProperties represents the properties of bare metal machine key set.
*/
model BareMetalMachineKeySetProperties {
/**
* The object ID of Azure Active Directory group that all users in the list must be in for access to be granted. Users that are not in the group will not have access.
*/
@visibility("read", "create")
"azureGroupId": string;
/**
* The more detailed status of the key set.
*/
@visibility("read")
"detailedStatus"?: BareMetalMachineKeySetDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The date and time after which the users in this key set will be removed from the bare metal machines.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expiration": utcDateTime;
/**
* The list of IP addresses of jump hosts with management network access from which a login will be allowed for the users.
*/
"jumpHostsAllowed": string[];
/**
* The last time this key set was validated.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastValidation"?: utcDateTime;
/**
* The name of the group that users will be assigned to on the operating system of the machines.
*/
@visibility("read", "create")
@maxLength(32)
@pattern("^([A-Za-z]([A-Za-z0-9]*))$")
"osGroupName"?: string;
/**
* The access level allowed for the users in this key set.
*/
@visibility("read", "create")
"privilegeLevel": BareMetalMachineKeySetPrivilegeLevel;
/**
* The provisioning state of the bare metal machine key set.
*/
@visibility("read")
"provisioningState"?: BareMetalMachineKeySetProvisioningState;
/**
* The unique list of permitted users.
*/
"userList": KeySetUser[];
/**
* The status evaluation of each user.
*/
@visibility("read")
"userListStatus"?: KeySetUserStatus[];
}

/**
* KeySetUser represents the properties of the user in the key set.
*/
model KeySetUser {
/**
* The user name that will be used for access.
*/
"azureUserName": string;
/**
* The free-form description for this user.
*/
@maxLength(256)
"description"?: string;
/**
* The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
*/
"sshPublicKey": SshPublicKey;
}

/**
* KeySetUserStatus represents the status of the key set user.
*/
model KeySetUserStatus {
/**
* The user name that will be used for access.
*/
@visibility("read")
"azureUserName"?: string;
/**
* The indicator of whether the user is currently deployed for access.
*/
@visibility("read")
"status"?: BareMetalMachineKeySetUserSetupStatus;
/**
* The additional information describing the current status of this user, if any available.
*/
@visibility("read")
@maxLength(256)
"statusMessage"?: string;
}

/**
* BareMetalMachineKeySetPatchParameters represents the body of the request to patch the bare metal machine key set.
*/
model BareMetalMachineKeySetPatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: BareMetalMachineKeySetPatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* BareMetalMachineKeySetPatchProperties represents the properties of bare metal machine key set that can be patched.
*/
model BareMetalMachineKeySetPatchProperties {
/**
* The date and time after which the users in this key set will be removed from the bare metal machines.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expiration"?: utcDateTime;
/**
* The list of IP addresses of jump hosts with management network access from which a login will be allowed for the users.
*/
"jumpHostsAllowed"?: string[];
/**
* The unique list of permitted users.
*/
"userList"?: KeySetUser[];
}

/**
* BmcKeySetProperties represents the properties of baseboard management controller key set.
*/
model BmcKeySetProperties {
/**
* The object ID of Azure Active Directory group that all users in the list must be in for access to be granted. Users that are not in the group will not have access.
*/
@visibility("read", "create")
"azureGroupId": string;
/**
* The more detailed status of the key set.
*/
@visibility("read")
"detailedStatus"?: BmcKeySetDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The date and time after which the users in this key set will be removed from the baseboard management controllers.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expiration": utcDateTime;
/**
* The last time this key set was validated.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"lastValidation"?: utcDateTime;
/**
* The access level allowed for the users in this key set.
*/
@visibility("read", "create")
"privilegeLevel": BmcKeySetPrivilegeLevel;
/**
* The provisioning state of the baseboard management controller key set.
*/
@visibility("read")
"provisioningState"?: BmcKeySetProvisioningState;
/**
* The unique list of permitted users.
*/
"userList": KeySetUser[];
/**
* The status evaluation of each user.
*/
@visibility("read")
"userListStatus"?: KeySetUserStatus[];
}

/**
* BmcKeySetPatchParameters represents the body of the request to patch the baseboard management controller key set.
*/
model BmcKeySetPatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: BmcKeySetPatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* BmcKeySetPatchProperties represents the properties of baseboard management controller key set that are patchable.
*/
model BmcKeySetPatchProperties {
/**
* The date and time after which the users in this key set will be removed from the baseboard management controllers.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expiration"?: utcDateTime;
/**
* The unique list of permitted users.
*/
"userList"?: KeySetUser[];
}

/**
* ClusterDeployParameters represents the body of the request to deploy cluster.
*/
model ClusterDeployParameters {
/**
* The names of bare metal machines in the cluster that should be skipped during environment validation.
*/
"skipValidationsForMachines"?: string[];
}

/**
* ClusterMetricsConfigurationProperties represents the properties of metrics configuration for the cluster.
*/
model ClusterMetricsConfigurationProperties {
/**
* The interval in minutes by which metrics will be collected.
*/
@maxValue(1440)
@minValue(1)
"collectionInterval": int64;
/**
* The more detailed status of the metrics configuration.
*/
@visibility("read")
"detailedStatus"?: ClusterMetricsConfigurationDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The list of metrics that are available for the cluster but disabled at the moment.
*/
@visibility("read")
"disabledMetrics"?: string[];
/**
* The list of metric names that have been chosen to be enabled in addition to the core set of enabled metrics.
*/
"enabledMetrics"?: string[];
/**
* The provisioning state of the metrics configuration.
*/
@visibility("read")
"provisioningState"?: ClusterMetricsConfigurationProvisioningState;
}

/**
* ClusterMetricsConfigurationPatchParameters represents the body of the request to patch the metrics configuration of cluster.
*/
model ClusterMetricsConfigurationPatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: ClusterMetricsConfigurationPatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* ClusterMetricsConfigurationPatchProperties represents the properties of metrics configuration for the cluster for patching.
*/
model ClusterMetricsConfigurationPatchProperties {
/**
* The interval in minutes by which metrics will be collected.
*/
@maxValue(1440)
@minValue(1)
"collectionInterval"?: int64;
/**
* The list of metric names that have been chosen to be enabled in addition to the core set of enabled metrics.
*/
"enabledMetrics"?: string[];
}

/**
* ClusterUpdateVersionParameters represents the body of the request to update cluster version.
*/
model ClusterUpdateVersionParameters {
/**
* The version to be applied to the cluster during update.
*/
"targetClusterVersion": string;
}

/**
* KubernetesClusterPatchParameters represents the body of the request to patch the Hybrid AKS cluster.
*/
model KubernetesClusterPatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: KubernetesClusterPatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* KubernetesClusterPatchProperties represents the properties of the Kubernetes cluster that can be patched.
*/
model KubernetesClusterPatchProperties {
/**
* The defining characteristics of the control plane that can be patched for this Kubernetes cluster.
*/
"controlPlaneNodeConfiguration"?: ControlPlaneNodePatchConfiguration;
/**
* The Kubernetes version for this cluster. Accepts n.n, n.n.n, and n.n.n-n format. The interpreted version used will be resolved into this field after creation or update.
*/
"kubernetesVersion"?: string;
}

/**
* ControlPlaneNodePatchConfiguration represents the properties of the control plane that can be patched for this Kubernetes cluster.
*/
model ControlPlaneNodePatchConfiguration {
/**
* The number of virtual machines that use this configuration.
*/
@minValue(1)
"count"?: int64;
}

/**
* AgentPoolProperties represents the properties of the Kubernetes cluster agent pool.
*/
model AgentPoolProperties {
/**
* The administrator credentials to be used for the nodes in this agent pool.
*/
@visibility("read", "create")
"administratorConfiguration"?: AdministratorConfiguration;
/**
* The configurations that will be applied to each agent in this agent pool.
*/
@visibility("read", "create")
"agentOptions"?: AgentOptions;
/**
* The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.
*/
@visibility("read", "create")
"attachedNetworkConfiguration"?: AttachedNetworkConfiguration;
/**
* The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.
*/
@visibility("read", "create")
"availabilityZones"?: string[];
/**
* The number of virtual machines that use this configuration.
*/
"count": int64;
/**
* The current status of the agent pool.
*/
@visibility("read")
"detailedStatus"?: AgentPoolDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The Kubernetes version running in this agent pool.
*/
@visibility("read")
"kubernetesVersion"?: string;
/**
* The labels applied to the nodes in this agent pool.
*/
@visibility("read", "create")
"labels"?: KubernetesLabel[];
/**
* The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
*/
@visibility("read", "create")
"mode": AgentPoolMode;
/**
* The provisioning state of the agent pool.
*/
@visibility("read")
"provisioningState"?: AgentPoolProvisioningState;
/**
* The taints applied to the nodes in this agent pool.
*/
@visibility("read", "create")
"taints"?: KubernetesLabel[];
/**
* The configuration of the agent pool.
*/
"upgradeSettings"?: AgentPoolUpgradeSettings;
/**
* The name of the VM SKU that determines the size of resources allocated for node VMs.
*/
@visibility("read", "create")
"vmSkuName": string;
}

/**
* AgentPoolPatchParameters represents the body of the request to patch the Kubernetes cluster agent pool.
*/
model AgentPoolPatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: AgentPoolPatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* AgentPoolPatchProperties represents the properties of an agent pool that can be modified.
*/
model AgentPoolPatchProperties {
/**
* The number of virtual machines that use this configuration.
*/
"count"?: int64;
/**
* The configuration of the agent pool.
*/
"upgradeSettings"?: AgentPoolUpgradeSettings;
}

/**
* KubernetesClusterRestartNodeParameters represents the body of the request to restart the node of a Kubernetes cluster.
*/
model KubernetesClusterRestartNodeParameters {
/**
* The name of the node to restart.
*/
"nodeName": string;
}

/**
* L2NetworkPatchParameters represents the body of the request to patch the L2 network.
*/
model L2NetworkPatchParameters {
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* L3NetworkPatchParameters represents the body of the request to patch the cloud services network.
*/
model L3NetworkPatchParameters {
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* RackPatchParameters represents the body of the request to patch the rack properties.
*/
model RackPatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: RacksPatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* RacksPatchProperties represents the properties of the rack during patching.
*/
model RacksPatchProperties {
/**
* The free-form description of the rack location. (e.g. “DTN Datacenter, Floor 3, Isle 9, Rack 2B”)
*/
@maxLength(256)
"rackLocation"?: string;
/**
* The globally unique identifier for the rack.
*/
@maxLength(64)
@minLength(1)
"rackSerialNumber"?: string;
}

/**
* StorageAppliancePatchParameters represents the body of the request to patch storage appliance properties.
*/
model StorageAppliancePatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: StorageAppliancePatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* StorageAppliancePatchProperties represents the properties of the storage appliance that can be patched.
*/
model StorageAppliancePatchProperties {
/**
* The serial number for the storage appliance.
*/
"serialNumber"?: string;
}

/**
* StorageApplianceEnableRemoteVendorManagementParameters represents the body of the request to enable remote vendor management of a storage appliance.
*/
model StorageApplianceEnableRemoteVendorManagementParameters {
/**
* Field Deprecated. This field is not used and will be rejected if provided. The list of IPv4 subnets (in CIDR format), IPv6 subnets (in CIDR format), or hostnames that the storage appliance needs accessible in order to turn on the remote vendor management.
*/
"supportEndpoints"?: string[];
}

/**
* TrunkedNetworkPatchParameters represents the body of the request to patch the Trunked network.
*/
model TrunkedNetworkPatchParameters {
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* VirtualMachinePatchParameters represents the body of the request to patch the virtual machine.
*/
model VirtualMachinePatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: VirtualMachinePatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* VirtualMachinePatchProperties represents the properties of the virtual machine that can be patched.
*/
model VirtualMachinePatchProperties {
/**
* The credentials used to login to the image repository that has access to the specified image.
*/
"vmImageRepositoryCredentials"?: ImageRepositoryCredentials;
}

/**
* ConsoleProperties represents the properties of the virtual machine console.
*/
model ConsoleProperties {
/**
* The more detailed status of the console.
*/
@visibility("read")
"detailedStatus"?: ConsoleDetailedStatus;
/**
* The descriptive message about the current detailed status.
*/
@visibility("read")
"detailedStatusMessage"?: string;
/**
* The indicator of whether the console access is enabled.
*/
"enabled": ConsoleEnabled;
/**
* The date and time after which the key will be disallowed access.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expiration"?: utcDateTime;
/**
* The resource ID of the private link service that is used to provide virtual machine console access.
*/
@visibility("read")
"privateLinkServiceId"?: string;
/**
* The provisioning state of the virtual machine console.
*/
@visibility("read")
"provisioningState"?: ConsoleProvisioningState;
/**
* The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
*/
"sshPublicKey": SshPublicKey;
/**
* The unique identifier for the virtual machine that is used to access the console.
*/
@visibility("read")
"virtualMachineAccessId"?: string;
}

/**
* ConsolePatchParameters represents the body of the request to patch the virtual machine console.
*/
model ConsolePatchParameters {
/**
* The list of the resource properties.
*/
"properties"?: ConsolePatchProperties;
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* ConsolePatchProperties represents the properties of the virtual machine console that can be patched.
*/
model ConsolePatchProperties {
/**
* The credentials used to login to the image repository that has access to the specified image.
*/
"enabled"?: ConsoleEnabled;
/**
* The date and time after which the key will be disallowed access.
*/
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"expiration"?: utcDateTime;
/**
* The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
*/
"sshPublicKey"?: SshPublicKey;
}

/**
* VirtualMachinePowerOffParameters represents the body of the request to power off virtual machine.
*/
model VirtualMachinePowerOffParameters {
/**
* The indicator of whether to skip the graceful OS shutdown and power off the virtual machine immediately.
*/
"skipShutdown"?: SkipShutdown = SkipShutdown.False;
}

/**
* VolumePatchParameters represents the body of the request to patch the volume resource.
*/
model VolumePatchParameters {
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}

/**
* AgentPoolConfiguration specifies the configuration of a pool of nodes.
*/
model AgentPoolConfiguration {
/**
* The administrator credentials to be used for the nodes in this agent pool.
*/
@visibility("read", "create")
"administratorConfiguration"?: AdministratorConfiguration;
/**
* The configurations that will be applied to each agent in this agent pool.
*/
@visibility("read", "create")
"agentOptions"?: AgentOptions;
/**
* The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.
*/
@visibility("read", "create")
"attachedNetworkConfiguration"?: AttachedNetworkConfiguration;
/**
* The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.
*/
@visibility("read", "create")
"availabilityZones"?: string[];
/**
* The number of virtual machines that use this configuration.
*/
"count": int64;
/**
* The labels applied to the nodes in this agent pool.
*/
@visibility("read", "create")
"labels"?: KubernetesLabel[];
/**
* The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
*/
@visibility("read", "create")
"mode": AgentPoolMode;
/**
* The taints applied to the nodes in this agent pool.
*/
@visibility("read", "create")
"taints"?: KubernetesLabel[];
/**
* The configuration of the agent pool.
*/
"upgradeSettings"?: AgentPoolUpgradeSettings;
/**
* The name of the VM SKU that determines the size of resources allocated for node VMs.
*/
@visibility("read", "create")
"vmSkuName": string;
}

/**
* TagsParameter represents the resource tags.
*/
model TagsParameter {
/**
* The Azure resource tags that will replace the existing ones.
*/
"tags"?: Record<string>;
}