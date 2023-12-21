import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.StoragePool;

interface Operations extends Azure.ResourceManager.Operations {}

enum ProvisioningStates {
  Invalid,
  Succeeded,
  Failed,
  Canceled,
  Pending,
  Creating,
  Updating,
  Deleting,
}

enum OperationalStatus {
  Invalid,
  Unknown,
  Healthy,
  Unhealthy,
  Updating,
  Running,
  Stopped,
  `Stopped (deallocated)`,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum IscsiTargetAclMode {
  Dynamic,
  Static,
}

enum DiskPoolTier {
  Basic,
  Standard,
  Premium,
}
@Azure.Core.fixed
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}
@Azure.Core.fixed
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

@doc("List of operations supported by the RP.")
model StoragePoolOperationListResult is Azure.Core.Page<StoragePoolRPOperation>;

@doc("Description of a StoragePool RP Operation")
model StoragePoolRPOperation {
  @doc("The name of the operation being performed on this particular object")
  name: string;

  @doc("Indicates whether the operation applies to data-plane.")
  isDataAction: boolean;

  @doc("Indicates the action type.")
  actionType?: string;

  @doc("Additional metadata about RP operation.")
  display: StoragePoolOperationDisplay;

  @doc("The intended executor of the operation; governs the display of the operation in the RBAC UX and the audit logs UX.")
  origin?: string;
}

@doc("Metadata about an operation.")
model StoragePoolOperationDisplay {
  @doc("Localized friendly form of the resource provider name.")
  provider: string;

  @doc("Localized friendly form of the resource type related to this action/operation.")
  resource: string;

  @doc("Localized friendly name for the operation, as it should be shown to the user.")
  operation: string;

  @doc("Localized friendly description for the operation, as it should be shown to the user.")
  description: string;
}

@doc("The resource management error response.")
@error
model Error {
  @doc("RP error response.")
  error?: ErrorResponse;
}

@doc("Sku for ARM resource")
model Sku {
  @doc("Sku name")
  name: string;

  @doc("Sku tier")
  tier?: string;
}

@doc("Disk Pool response properties.")
model DiskPoolProperties {
  @doc("State of the operation on the resource.")
  @visibility("read")
  provisioningState: ProvisioningStates;

  @doc("Logical zone for Disk Pool resource; example: [\"1\"].")
  availabilityZones: string[];

  @doc("Operational status of the Disk Pool.")
  status: OperationalStatus;

  @doc("List of Azure Managed Disks to attach to a Disk Pool.")
  disks?: Disk[];

  @doc("Azure Resource ID of a Subnet for the Disk Pool.")
  @visibility("read", "create")
  subnetId: string;

  @doc("List of additional capabilities for Disk Pool.")
  additionalCapabilities?: string[];
}

@doc("Azure Managed Disk to attach to the Disk Pool.")
model Disk {
  @doc("Unique Azure Resource ID of the Managed Disk.")
  id: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemMetadata {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The type of identity that last modified the resource.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("Request payload for create or update Disk Pool request.")
model DiskPoolCreate {
  @doc("Determines the SKU of the Disk Pool")
  sku: Sku;

  @doc("Properties for Disk Pool create request.")
  properties: DiskPoolCreateProperties;

  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives.")
  @visibility("read", "create")
  location: string;

  @doc("Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts.")
  @visibility("read")
  type?: string;

  @doc("Azure resource id. Indicates if this resource is managed by another Azure resource.")
  managedBy?: string;

  @doc("List of Azure resource ids that manage this resource.")
  managedByExtended?: string[];
}

@doc("Properties for Disk Pool create or update request.")
model DiskPoolCreateProperties {
  @doc("Logical zone for Disk Pool resource; example: [\"1\"].")
  availabilityZones?: string[];

  @doc("List of Azure Managed Disks to attach to a Disk Pool.")
  disks?: Disk[];

  @doc("Azure Resource ID of a Subnet for the Disk Pool.")
  @visibility("read", "create")
  subnetId: string;

  @doc("List of additional capabilities for a Disk Pool.")
  additionalCapabilities?: string[];
}

@doc("List Disk Pool skus operation response.")
model DiskPoolZoneListResult is Azure.Core.Page<DiskPoolZoneInfo>;

@doc("Disk Pool SKU Details")
model DiskPoolZoneInfo {
  @doc("Logical zone for Disk Pool resource; example: [\"1\"].")
  @visibility("read")
  availabilityZones?: string[];

  @doc("List of additional capabilities for Disk Pool.")
  @visibility("read")
  additionalCapabilities?: string[];

  @doc("Determines the SKU of VM deployed for Disk Pool")
  @visibility("read")
  sku?: Sku;
}

@doc("List Disk Pool skus operation response.")
model ResourceSkuListResult is Azure.Core.Page<ResourceSkuInfo>;

@doc("Resource SKU Details")
model ResourceSkuInfo {
  @doc("StoragePool RP API version")
  @visibility("read")
  apiVersion?: string;

  @doc("StoragePool resource type")
  @visibility("read")
  resourceType?: string;

  @doc("List of additional capabilities for StoragePool resource.")
  @visibility("read")
  capabilities?: ResourceSkuCapability[];

  @doc("Zones and zone capabilities in those locations where the SKU is available.")
  @visibility("read")
  locationInfo?: ResourceSkuLocationInfo;

  @doc("Sku name")
  @visibility("read")
  name?: string;

  @doc("Sku tier")
  @visibility("read")
  tier?: string;

  @doc("The restrictions because of which SKU cannot be used. This is empty if there are no restrictions.")
  @visibility("read")
  restrictions?: ResourceSkuRestrictions[];
}

@doc("Capability a resource SKU has.")
model ResourceSkuCapability {
  @doc("Capability name")
  @visibility("read")
  name?: string;

  @doc("Capability value")
  @visibility("read")
  value?: string;
}

@doc("Zone and capability info for resource sku")
model ResourceSkuLocationInfo {
  @doc("Location of the SKU")
  @visibility("read")
  location?: string;

  @doc("List of availability zones where the SKU is supported.")
  @visibility("read")
  zones?: string[];

  @doc("Details of capabilities available to a SKU in specific zones.")
  @visibility("read")
  zoneDetails?: ResourceSkuZoneDetails[];
}

@doc("Describes The zonal capabilities of a SKU.")
model ResourceSkuZoneDetails {
  @doc("The set of zones that the SKU is available in with the specified capabilities.")
  @visibility("read")
  name?: string[];

  @doc("A list of capabilities that are available for the SKU in the specified list of zones.")
  @visibility("read")
  capabilities?: ResourceSkuCapability[];
}

@doc("Describes scaling information of a SKU.")
model ResourceSkuRestrictions {
  @doc("The type of restrictions.")
  @visibility("read")
  type?: ResourceSkuRestrictionsType;

  @doc("The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.")
  @visibility("read")
  values?: string[];

  @doc("The information about the restriction where the SKU cannot be used.")
  @visibility("read")
  restrictionInfo?: ResourceSkuRestrictionInfo;

  @doc("The reason for restriction.")
  @visibility("read")
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

@doc("Describes an available Compute SKU Restriction Information.")
model ResourceSkuRestrictionInfo {
  @doc("Locations where the SKU is restricted")
  @visibility("read")
  locations?: string[];

  @doc("List of availability zones where the SKU is restricted.")
  @visibility("read")
  zones?: string[];
}

@doc("Collection of Outbound Environment Endpoints")
model OutboundEnvironmentEndpointList
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

@doc("Endpoints accessed for a common purpose that the App Service Environment requires outbound network access to.")
model OutboundEnvironmentEndpoint {
  @doc("The type of service accessed by the App Service Environment, e.g., Azure Storage, Azure SQL Database, and Azure Active Directory.")
  category?: string;

  @doc("The endpoints that the App Service Environment reaches the service at.")
  endpoints?: EndpointDependency[];
}

@doc("A domain name that a service is reached at, including details of the current connection status.")
model EndpointDependency {
  @doc("The domain name of the dependency.")
  domainName?: string;

  @doc("The IP Addresses and Ports used when connecting to DomainName.")
  endpointDetails?: EndpointDetail[];
}

@doc("Current TCP connectivity information from the App Service Environment to a single endpoint.")
model EndpointDetail {
  @doc("An IP Address that Domain Name currently resolves to.")
  ipAddress?: string;

  @doc("The port an endpoint is connected to.")
  port?: int32;

  @doc("The time in milliseconds it takes for a TCP connection to be created from the App Service Environment to this IpAddress at this Port.")
  latency?: float32;

  @doc("Whether it is possible to create a TCP connection from the App Service Environment to this IpAddress at this Port.")
  isAccessible?: boolean;
}

@doc("Response properties for iSCSI Target operations.")
model IscsiTargetProperties {
  @doc("Mode for Target connectivity.")
  aclMode: IscsiTargetAclMode;

  @doc("Access Control List (ACL) for an iSCSI Target; defines LUN masking policy")
  staticAcls?: Acl[];

  @doc("List of LUNs to be exposed through iSCSI Target.")
  luns?: IscsiLun[];

  @doc("iSCSI Target IQN (iSCSI Qualified Name); example: \"iqn.2005-03.org.iscsi:server\".")
  targetIqn: string;

  @doc("State of the operation on the resource.")
  @visibility("read")
  provisioningState: ProvisioningStates;

  @doc("Operational status of the iSCSI Target.")
  status: OperationalStatus;

  @doc("List of private IPv4 addresses to connect to the iSCSI Target.")
  endpoints?: string[];

  @doc("The port used by iSCSI Target portal group.")
  port?: int32;

  @doc("List of identifiers for active sessions on the iSCSI target")
  @visibility("read")
  sessions?: string[];
}

@doc("Access Control List (ACL) for an iSCSI Target; defines LUN masking policy")
model Acl {
  @doc("iSCSI initiator IQN (iSCSI Qualified Name); example: \"iqn.2005-03.org.iscsi:client\".")
  initiatorIqn: string;

  @doc("List of LUN names mapped to the ACL.")
  mappedLuns: string[];
}

@doc("LUN to expose the Azure Managed Disk.")
model IscsiLun {
  @doc("User defined name for iSCSI LUN; example: \"lun0\"")
  name: string;

  @doc("Azure Resource ID of the Managed Disk.")
  managedDiskAzureResourceId: string;

  @doc("Specifies the Logical Unit Number of the iSCSI LUN.")
  @visibility("read")
  lun?: int32;
}

@doc("Payload for iSCSI Target create or update requests.")
model IscsiTargetCreate extends ProxyResource {
  @doc("Properties for iSCSI Target create request.")
  properties: IscsiTargetCreateProperties;

  @doc("Azure resource id. Indicates if this resource is managed by another Azure resource.")
  managedBy?: string;

  @doc("List of Azure resource ids that manage this resource.")
  managedByExtended?: string[];
}

@doc("Properties for iSCSI Target create or update request.")
model IscsiTargetCreateProperties {
  @doc("Mode for Target connectivity.")
  aclMode: IscsiTargetAclMode;

  @doc("iSCSI Target IQN (iSCSI Qualified Name); example: \"iqn.2005-03.org.iscsi:server\".")
  targetIqn?: string;

  @doc("Access Control List (ACL) for an iSCSI Target; defines LUN masking policy")
  staticAcls?: Acl[];

  @doc("List of LUNs to be exposed through iSCSI Target.")
  luns?: IscsiLun[];
}
