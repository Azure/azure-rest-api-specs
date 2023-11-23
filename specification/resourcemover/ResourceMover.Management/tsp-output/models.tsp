import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

interface Operations extends Azure.ResourceManager.Operations {}

enum ResourceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

enum ProvisioningState {
  Succeeded,
  Updating,
  Creating,
  Failed,
}

enum MoveType {
  RegionToRegion,
  RegionToZone,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum MoveResourceInputType {
  MoveResourceId,
  MoveResourceSourceId,
}

enum MoveState {
  AssignmentPending,
  PreparePending,
  PrepareInProgress,
  PrepareFailed,
  MovePending,
  MoveInProgress,
  MoveFailed,
  DiscardInProgress,
  DiscardFailed,
  CommitPending,
  CommitInProgress,
  CommitFailed,
  Committed,
  DeleteSourcePending,
  ResourceMoveCompleted,
}

enum JobName {
  InitialSync,
}

enum ResolutionType {
  Manual,
  Automatic,
}

enum DependencyType {
  RequiredForPrepare,
  RequiredForMove,
}

enum DependencyLevel {
  Direct,
  Descendant,
}

enum TargetAvailabilityZone {
  `1`,
  `2`,
  `3`,
  NA,
}

enum ZoneRedundant {
  Enable,
  Disable,
}

@doc("Defines the MSI properties of the Move Collection.")
model Identity {
  @doc("The type of identity used for the resource mover service.")
  type?: ResourceIdentityType;

  @doc("Gets or sets the principal id.")
  principalId?: string;

  @doc("Gets or sets the tenant id.")
  tenantId?: string;
}

@doc("Defines the move collection properties.")
model MoveCollectionProperties {
  @doc("Gets or sets the source region.")
  sourceRegion?: string;

  @doc("Gets or sets the target region.")
  targetRegion?: string;

  @doc("Gets or sets the move region which indicates the region where the VM Regional to Zonal move will be conducted.")
  moveRegion?: string;

  @doc("Defines the provisioning states.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Gets or sets the version of move collection.")
  version?: string;

  @doc("Defines the MoveType.")
  moveType?: MoveType;

  @doc("Defines the move collection errors.")
  @visibility("read")
  errors?: MoveCollectionPropertiesErrors;
}

@doc("Defines the move collection errors.")
model MoveCollectionPropertiesErrors {
  ...MoveResourceError;
}

@doc("An error response from the azure resource mover service.")
model MoveResourceError {
  @doc("The move resource error body.")
  properties?: MoveResourceErrorBody;
}

@doc("An error response from the Azure Migrate service.")
model MoveResourceErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  @visibility("read")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  @visibility("read")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  @visibility("read")
  target?: string;

  @doc("A list of additional details about the error.")
  @visibility("read")
  details?: MoveResourceErrorBody[];
}

@doc("An error response from the service.")
@error
model CloudError {
  @doc("Cloud error body.")
  error?: CloudErrorBody;
}

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("Operation status REST resource.")
model OperationStatus {
  @doc("Resource Id.")
  @visibility("read")
  id?: string;

  @doc("Operation name.")
  @visibility("read")
  name?: string;

  @doc("Status of the operation. ARM expects the terminal status to be one of Succeeded/ Failed/ Canceled. All other values imply that the operation is still running.")
  @visibility("read")
  status?: string;

  @doc("Start time.")
  @visibility("read")
  startTime?: string;

  @doc("End time.")
  @visibility("read")
  endTime?: string;

  @doc("Error stating all error details for the operation.")
  @visibility("read")
  error?: OperationStatusError;

  @doc("Custom data.")
  @visibility("read")
  properties?: Record<unknown>;
}

@doc("Class for operation status errors.")
model OperationStatusError {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error details.")
  @visibility("read")
  details?: OperationStatusError[];

  @doc("The additional info.")
  @visibility("read")
  additionalInfo?: OperationErrorAdditionalInfo[];
}

@doc("The operation error info.")
model OperationErrorAdditionalInfo {
  @doc("The error type.")
  @visibility("read")
  type?: string;

  @doc("The operation error info.")
  @visibility("read")
  info?: MoveErrorInfo;
}

@doc("The move custom error info.")
model MoveErrorInfo {
  @doc("The affected move resources.")
  @visibility("read")
  moveResources?: AffectedMoveResource[];
}

@doc("The RP custom operation error info.")
model AffectedMoveResource {
  @doc("The affected move resource id.")
  @visibility("read")
  id?: string;

  @doc("The affected move resource source id.")
  @visibility("read")
  sourceId?: string;

  @doc("The affected move resources.")
  @visibility("read")
  moveResources?: AffectedMoveResource[];
}

@doc("Defines the request body for initiate prepare operation.")
model PrepareRequest {
  @doc("Gets or sets a value indicating whether the operation needs to only run pre-requisite.")
  validateOnly?: boolean;

  @doc("Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.")
  moveResources: string[];

  @doc("Defines the move resource input type.")
  moveResourceInputType?: MoveResourceInputType;
}

@doc("Defines the request body for resource move operation.")
model ResourceMoveRequest {
  @doc("Gets or sets a value indicating whether the operation needs to only run pre-requisite.")
  validateOnly?: boolean;

  @doc("Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.")
  moveResources: string[];

  @doc("Defines the move resource input type.")
  moveResourceInputType?: MoveResourceInputType;
}

@doc("Defines the request body for commit operation.")
model CommitRequest {
  @doc("Gets or sets a value indicating whether the operation needs to only run pre-requisite.")
  validateOnly?: boolean;

  @doc("Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.")
  moveResources: string[];

  @doc("Defines the move resource input type.")
  moveResourceInputType?: MoveResourceInputType;
}

@doc("Defines the request body for discard operation.")
model DiscardRequest {
  @doc("Gets or sets a value indicating whether the operation needs to only run pre-requisite.")
  validateOnly?: boolean;

  @doc("Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.")
  moveResources: string[];

  @doc("Defines the move resource input type.")
  moveResourceInputType?: MoveResourceInputType;
}

@doc("Defines the move resource properties.")
model MoveResourceProperties {
  @doc("Defines the provisioning states.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Gets or sets the Source ARM Id of the resource.")
  sourceId: string;

  @doc("Gets or sets the Target ARM Id of the resource.")
  @visibility("read")
  targetId?: string;

  @doc("Gets or sets the existing target ARM Id of the resource.")
  existingTargetId?: string;

  @doc("Gets or sets the resource settings.")
  resourceSettings?: ResourceSettings;

  @doc("Gets or sets the source resource settings.")
  @visibility("read")
  sourceResourceSettings?: ResourceSettings;

  @doc("Defines the move resource status.")
  @visibility("read")
  moveStatus?: MoveResourcePropertiesMoveStatus;

  @doc("Gets or sets the move resource dependencies.")
  @visibility("read")
  dependsOn?: MoveResourceDependency[];

  @doc("Gets or sets the move resource dependencies overrides.")
  dependsOnOverrides?: MoveResourceDependencyOverride[];

  @doc("Gets a value indicating whether the resolve action is required over the move collection.")
  @visibility("read")
  isResolveRequired?: boolean;

  @doc("Defines the move resource errors.")
  @visibility("read")
  errors?: MoveResourcePropertiesErrors;
}

@doc("Gets or sets the resource settings.")
@discriminator("resourceType")
model ResourceSettings {
  @doc("Gets or sets the target Resource name.")
  targetResourceName?: string;

  @doc("Gets or sets the target resource group name.")
  targetResourceGroupName?: string;
}

@doc("Defines the move resource status.")
model MoveResourcePropertiesMoveStatus {
  ...MoveResourceStatus;
}

@doc("Defines the move resource status.")
model MoveResourceStatus {
  @doc("Defines the MoveResource states.")
  @visibility("read")
  moveState?: MoveState;

  @doc("Defines the job status.")
  jobStatus?: JobStatus;

  @doc("An error response from the azure resource mover service.")
  errors?: MoveResourceError;
}

@doc("Defines the job status.")
model JobStatus {
  @doc("Defines the job name.")
  @visibility("read")
  jobName?: JobName;

  @doc("Gets or sets the monitoring job percentage.")
  @visibility("read")
  jobProgress?: string;
}

@doc("Defines the dependency of the move resource.")
model MoveResourceDependency {
  @doc("Gets the source ARM ID of the dependent resource.")
  id?: string;

  @doc("Gets the dependency resolution status.")
  resolutionStatus?: string;

  @doc("Defines the resolution type.")
  resolutionType?: ResolutionType;

  @doc("Defines the dependency type.")
  dependencyType?: DependencyType;

  @doc("Defines the properties for manual resolution.")
  manualResolution?: ManualResolutionProperties;

  @doc("Defines the properties for automatic resolution.")
  automaticResolution?: AutomaticResolutionProperties;

  @doc("Gets or sets a value indicating whether the dependency is optional.")
  isOptional?: string;
}

@doc("Defines the properties for manual resolution.")
model ManualResolutionProperties {
  @doc("Gets or sets the target resource ARM ID of the dependent resource if the resource type is Manual.")
  targetId?: string;
}

@doc("Defines the properties for automatic resolution.")
model AutomaticResolutionProperties {
  @doc("""
Gets the MoveResource ARM ID of
the dependent resource if the resolution type is Automatic.
""")
  moveResourceId?: string;
}

@doc("Defines the dependency override of the move resource.")
model MoveResourceDependencyOverride {
  @doc("Gets or sets the ARM ID of the dependent resource.")
  id?: string;

  @doc("""
Gets or sets the resource ARM id of either the MoveResource or the resource ARM ID of
the dependent resource.
""")
  targetId?: string;
}

@doc("Defines the move resource errors.")
model MoveResourcePropertiesErrors {
  ...MoveResourceError;
}

@doc("Summary Collection.")
model SummaryCollection {
  @doc("Gets or sets the field name on which summary is done.")
  fieldName?: string;

  @doc("Gets or sets the list of summary items.")
  summary?: Summary[];
}

@doc("Summary item.")
model Summary {
  @doc("Gets the count.")
  count?: int32;

  @doc("Gets the item.")
  item?: string;
}

@doc("Unresolved dependency collection.")
model UnresolvedDependencyCollection is Azure.Core.Page<UnresolvedDependency> {
  @doc("Gets or sets the list of summary items and the field on which summary is done.")
  @visibility("read")
  summaryCollection?: SummaryCollection;

  @doc("Gets the total count.")
  @visibility("read")
  totalCount?: int32;
}

@doc("Unresolved dependency.")
model UnresolvedDependency {
  @doc("Gets or sets the count.")
  count?: int32;

  @doc("Gets or sets the arm id of the dependency.")
  id?: string;
}

@doc("Defines the request body for bulk remove of move resources operation.")
model BulkRemoveRequest {
  @doc("Gets or sets a value indicating whether the operation needs to only run pre-requisite.")
  validateOnly?: boolean;

  @doc("Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.")
  moveResources?: string[];

  @doc("Defines the move resource input type.")
  moveResourceInputType?: MoveResourceInputType;
}

@doc("Collection of ClientDiscovery details.")
model OperationsDiscoveryCollection {
  @doc("Gets or sets the ClientDiscovery details.")
  value?: OperationsDiscovery[];

  @doc("Gets or sets the value of next link.")
  nextLink?: string;
}

@doc("Operations discovery class.")
model OperationsDiscovery {
  @doc("""
Gets or sets Name of the API.
The name of the operation being performed on this particular object. It should
match the action name that appears in RBAC / the event service.
Examples of operations include:
* Microsoft.Compute/virtualMachine/capture/action
* Microsoft.Compute/virtualMachine/restart/action
* Microsoft.Compute/virtualMachine/write
* Microsoft.Compute/virtualMachine/read
* Microsoft.Compute/virtualMachine/delete
Each action should include, in order:
(1) Resource Provider Namespace
(2) Type hierarchy for which the action applies (e.g. server/databases for a SQL
Azure database)
(3) Read, Write, Action or Delete indicating which type applies. If it is a PUT/PATCH
on a collection or named value, Write should be used.
If it is a GET, Read should be used. If it is a DELETE, Delete should be used. If it
is a POST, Action should be used.
As a note: all resource providers would need to include the \"{Resource Provider
Namespace}/register/action\" operation in their response.
This API is used to register for their service, and should include details about the
operation (e.g. a localized name for the resource provider + any special
considerations like PII release).
""")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("""
Contains the localized display information for this particular operation / action. These
value will be used by several clients for
(1) custom role definitions for RBAC;
(2) complex query filters for the event service; and
(3) audit history / records for management operations.
""")
  display?: Display;

  @doc("""
Gets or sets Origin.
The intended executor of the operation; governs the display of the operation in the
RBAC UX and the audit logs UX.
Default value is \"user,system\".
""")
  origin?: string;

  @doc("ClientDiscovery properties.")
  properties?: Record<unknown>;
}

@doc("""
Contains the localized display information for this particular operation / action. These
value will be used by several clients for
(1) custom role definitions for RBAC;
(2) complex query filters for the event service; and
(3) audit history / records for management operations.
""")
model Display {
  @doc("""
Gets or sets the provider.
The localized friendly form of the resource provider name – it is expected to also
include the publisher/company responsible.
It should use Title Casing and begin with \"Microsoft\" for 1st party services.
e.g. \"Microsoft Monitoring Insights\" or \"Microsoft Compute.\".
""")
  provider?: string;

  @doc("""
Gets or sets the resource.
The localized friendly form of the resource related to this action/operation – it
should match the public documentation for the resource provider.
It should use Title Casing.
This value should be unique for a particular URL type (e.g. nested types should *not*
reuse their parent’s display.resource field)
e.g. \"Virtual Machines\" or \"Scheduler Job Collections\", or \"Virtual Machine VM Sizes\"
or \"Scheduler Jobs\".
""")
  resource?: string;

  @doc("""
Gets or sets the operation.
The localized friendly name for the operation, as it should be shown to the user.
It should be concise (to fit in drop downs) but clear (i.e. self-documenting).
It should use Title Casing.
Prescriptive guidance: Read Create or Update Delete 'ActionName'.
""")
  operation?: string;

  @doc("""
Gets or sets the description.
The localized friendly description for the operation, as it should be shown to the
user.
It should be thorough, yet concise – it will be used in tool tips and detailed views.
Prescriptive guidance for namespace:
Read any 'display.provider'  resource
Create or Update any  'display.provider'  resource
Delete any  'display.provider'  resource
Perform any other action on any  'display.provider'  resource
Prescriptive guidance for namespace:
Read any 'display.resource' Create or Update any  'display.resource' Delete any
 'display.resource' 'ActionName' any 'display.resources'.
""")
  description?: string;
}

@doc("Required for resources collection.")
model RequiredForResourcesCollection {
  @doc("Gets or sets the list of source Ids for which the input resource is required.")
  sourceIds?: string[];
}

@doc("Move resource filter.")
model MoveResourceFilter {
  properties?: MoveResourceFilterProperties;
}

model MoveResourceFilterProperties {
  @doc("The provisioning state.")
  provisioningState?: string;
}

@doc("Unresolved dependencies contract.")
model UnresolvedDependenciesFilter {
  properties?: UnresolvedDependenciesFilterProperties;
}

model UnresolvedDependenciesFilterProperties {
  @doc("The count of the resource.")
  count?: int32;
}

@doc("Gets or sets the virtual machine resource settings.")
model VirtualMachineResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Gets or sets user-managed identities")
  userManagedIdentities?: string[];

  @doc("Gets or sets the target availability zone.")
  targetAvailabilityZone?: TargetAvailabilityZone;

  @doc("Gets or sets the target virtual machine size.")
  targetVmSize?: string;

  @doc("Gets or sets the target availability set id for virtual machines not in an availability set at source.")
  targetAvailabilitySetId?: string;

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Compute/virtualMachines";
}

@doc("Gets or sets the availability set resource settings.")
model AvailabilitySetResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Gets or sets the target fault domain.")
  faultDomain?: int32;

  @doc("Gets or sets the target update domain.")
  updateDomain?: int32;

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Compute/availabilitySets";
}

@doc("Defines the virtual network subnets resource settings.")
model SubnetResourceSettings {
  @doc("Gets or sets the Subnet name.")
  name?: string;

  @doc("Gets or sets address prefix for the subnet.")
  addressPrefix?: string;

  @doc("Defines reference to NSG.")
  networkSecurityGroup?: NsgReference;
}

@doc("Defines reference to NSG.")
model NsgReference {
  ...AzureResourceReference;
}

@doc("Defines reference to an Azure resource.")
model AzureResourceReference {
  @doc("Gets the ARM resource ID of the tracked resource being referenced.")
  sourceArmResourceId: string;
}

@doc("Defines the virtual network resource settings.")
model VirtualNetworkResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("""
Gets or sets a value indicating whether gets or sets whether the
DDOS protection should be switched on.
""")
  enableDdosProtection?: boolean;

  @doc("Gets or sets the address prefixes for the virtual network.")
  addressSpace?: string[];

  @doc("""
Gets or sets DHCPOptions that contains an array of DNS servers available to VMs
deployed in the virtual network.
""")
  dnsServers?: string[];

  @doc("Gets or sets List of subnets in a VirtualNetwork.")
  subnets?: SubnetResourceSettings[];

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Network/virtualNetworks";
}

@doc("Defines reference to a proxy resource.")
model ProxyResourceReference {
  ...AzureResourceReference;

  @doc("Gets the name of the proxy resource on the target side.")
  name?: string;
}

@doc("Defines the network interface resource settings.")
model NetworkInterfaceResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Gets or sets the IP configurations of the NIC.")
  ipConfigurations?: NicIpConfigurationResourceSettings[];

  @doc("Gets or sets a value indicating whether accelerated networking is enabled.")
  enableAcceleratedNetworking?: boolean;

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Network/networkInterfaces";
}

@doc("Defines NIC IP configuration properties.")
model NicIpConfigurationResourceSettings {
  @doc("Gets or sets the IP configuration name.")
  name?: string;

  @doc("Gets or sets the private IP address of the network interface IP Configuration.")
  privateIpAddress?: string;

  @doc("Gets or sets the private IP address allocation method.")
  privateIpAllocationMethod?: string;

  @doc("Defines reference to subnet.")
  subnet?: SubnetReference;

  @doc("Gets or sets a value indicating whether this IP configuration is the primary.")
  primary?: boolean;

  @doc("Gets or sets the references of the load balancer backend address pools.")
  loadBalancerBackendAddressPools?: LoadBalancerBackendAddressPoolReference[];

  @doc("Gets or sets the references of the load balancer NAT rules.")
  loadBalancerNatRules?: LoadBalancerNatRuleReference[];

  @doc("Defines reference to a public IP.")
  publicIp?: PublicIpReference;
}

@doc("Defines reference to subnet.")
model SubnetReference {
  ...ProxyResourceReference;
}

@doc("Defines reference to load balancer backend address pools.")
model LoadBalancerBackendAddressPoolReference {
  ...ProxyResourceReference;
}

@doc("Defines reference to load balancer NAT rules.")
model LoadBalancerNatRuleReference {
  ...ProxyResourceReference;
}

@doc("Defines reference to a public IP.")
model PublicIpReference {
  ...AzureResourceReference;
}

@doc("Security Rule data model for Network Security Groups.")
model NsgSecurityRule {
  @doc("Gets or sets the Security rule name.")
  name?: string;

  @doc("""
Gets or sets whether network traffic is allowed or denied.
Possible values are “Allow” and “Deny”.
""")
  access?: string;

  @doc("Gets or sets a description for this rule. Restricted to 140 chars.")
  description?: string;

  @doc("""
Gets or sets destination address prefix. CIDR or source IP range.
 A “*” can also be used to match all source IPs. Default tags such
as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used.
""")
  destinationAddressPrefix?: string;

  @doc("""
Gets or sets Destination Port or Range. Integer or range between
0 and 65535. A “*” can also be used to match all ports.
""")
  destinationPortRange?: string;

  @doc("""
Gets or sets the direction of the rule.InBound or Outbound. The
direction specifies if rule will be evaluated on incoming or outgoing traffic.
""")
  direction?: string;

  @doc("""
Gets or sets the priority of the rule. The value can be between
100 and 4096. The priority number must be unique for each rule in the collection.
The lower the priority number, the higher the priority of the rule.
""")
  priority?: int32;

  @doc("Gets or sets Network protocol this rule applies to. Can be Tcp, Udp or All(*).")
  protocol?: string;

  @doc("""
Gets or sets source address prefix. CIDR or source IP range. A
“*” can also be used to match all source IPs.  Default tags such as ‘VirtualNetwork’,
‘AzureLoadBalancer’ and ‘Internet’ can also be used. If this is an ingress
rule, specifies where network traffic originates from.
""")
  sourceAddressPrefix?: string;

  @doc("""
Gets or sets Source Port or Range. Integer or range between 0 and
65535. A “*” can also be used to match all ports.
""")
  sourcePortRange?: string;
}

@doc("Defines the NSG resource settings.")
model NetworkSecurityGroupResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Gets or sets Security rules of network security group.")
  securityRules?: NsgSecurityRule[];

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Network/networkSecurityGroups";
}

@doc("Defines load balancer frontend IP configuration properties.")
model LBFrontendIPConfigurationResourceSettings {
  @doc("Gets or sets the frontend IP configuration name.")
  name?: string;

  @doc("""
Gets or sets the IP address of the Load Balancer.This is only specified if a specific
private IP address shall be allocated from the subnet specified in subnetRef.
""")
  privateIpAddress?: string;

  @doc("Gets or sets PrivateIP allocation method (Static/Dynamic).")
  privateIpAllocationMethod?: string;

  @doc("Defines reference to subnet.")
  subnet?: SubnetReference;

  @doc("Gets or sets the csv list of zones.")
  zones?: string;
}

@doc("Defines load balancer backend address pool properties.")
model LBBackendAddressPoolResourceSettings {
  @doc("Gets or sets the backend address pool name.")
  name?: string;
}

@doc("Defines the load balancer resource settings.")
model LoadBalancerResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Gets or sets load balancer sku (Basic/Standard).")
  sku?: string;

  @doc("Gets or sets the frontend IP configurations of the load balancer.")
  frontendIPConfigurations?: LBFrontendIPConfigurationResourceSettings[];

  @doc("Gets or sets the backend address pools of the load balancer.")
  backendAddressPools?: LBBackendAddressPoolResourceSettings[];

  @doc("""
Gets or sets the csv list of zones common for all frontend IP configurations. Note this is given
 precedence only if frontend IP configurations settings are not present.
""")
  zones?: string;

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Network/loadBalancers";
}

@doc("Defines the SQL Server resource settings.")
model SqlServerResourceSettings extends ResourceSettings {
  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Sql/servers";
}

@doc("Defines the Sql ElasticPool resource settings.")
model SqlElasticPoolResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Defines the zone redundant resource setting.")
  zoneRedundant?: ZoneRedundant;

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Sql/servers/elasticPools";
}

@doc("Defines the Sql Database resource settings.")
model SqlDatabaseResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Defines the zone redundant resource setting.")
  zoneRedundant?: ZoneRedundant;

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Sql/servers/databases";
}

@doc("Defines the resource group resource settings.")
model ResourceGroupResourceSettings extends ResourceSettings {
  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "resourceGroups";
}

@doc("Defines the public IP address resource settings.")
model PublicIPAddressResourceSettings extends ResourceSettings {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Gets or sets the domain name label.")
  domainNameLabel?: string;

  @doc("Gets or sets the fully qualified domain name.")
  fqdn?: string;

  @doc("Gets or sets public IP allocation method.")
  publicIpAllocationMethod?: string;

  @doc("Gets or sets public IP sku.")
  sku?: string;

  @doc("Gets or sets public IP zones.")
  zones?: string;

  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Network/publicIPAddresses";
}

@doc("Defines the key vault resource settings.")
model KeyVaultResourceSettings extends ResourceSettings {
  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.KeyVault/vaults";
}

@doc("Defines the disk encryption set resource settings.")
model DiskEncryptionSetResourceSettings extends ResourceSettings {
  @doc("The resource type. For example, the value can be Microsoft.Compute/virtualMachines.")
  resourceType: "Microsoft.Compute/diskEncryptionSets";
}
