import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.StoragePool;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state of the iSCSI Target.
 */
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

/**
 * Operational status of the resource.
 */
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

/**
 * ACL mode for iSCSI Target.
 */
enum IscsiTargetAclMode {
  Dynamic,
  Static,
}

/**
 * SKU of the VM host part of the Disk Pool deployment
 */
enum DiskPoolTier {
  Basic,
  Standard,
  Premium,
}

/**
 * The type of restrictions.
 */
@fixed
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

/**
 * The reason for restriction.
 */
@fixed
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

/**
 * Description of a StoragePool RP Operation
 */
model StoragePoolRPOperation {
  /**
   * The name of the operation being performed on this particular object
   */
  name: string;

  /**
   * Indicates whether the operation applies to data-plane.
   */
  isDataAction: boolean;

  /**
   * Indicates the action type.
   */
  actionType?: string;

  /**
   * Additional metadata about RP operation.
   */
  display: StoragePoolOperationDisplay;

  /**
   * The intended executor of the operation; governs the display of the operation in the RBAC UX and the audit logs UX.
   */
  origin?: string;
}

/**
 * Metadata about an operation.
 */
model StoragePoolOperationDisplay {
  /**
   * Localized friendly form of the resource provider name.
   */
  provider: string;

  /**
   * Localized friendly form of the resource type related to this action/operation.
   */
  resource: string;

  /**
   * Localized friendly name for the operation, as it should be shown to the user.
   */
  operation: string;

  /**
   * Localized friendly description for the operation, as it should be shown to the user.
   */
  description: string;
}

/**
 * The resource management error response.
 */
@error
model Error {
  /**
   * RP error response.
   */
  error?: ErrorResponse;
}

/**
 * Sku for ARM resource
 */
model Sku {
  /**
   * Sku name
   */
  name: string;

  /**
   * Sku tier
   */
  tier?: string;
}

/**
 * Disk Pool response properties.
 */
model DiskPoolProperties {
  /**
   * State of the operation on the resource.
   */
  @visibility("read")
  provisioningState: ProvisioningStates;

  /**
   * Logical zone for Disk Pool resource; example: ["1"].
   */
  availabilityZones: string[];

  /**
   * Operational status of the Disk Pool.
   */
  status: OperationalStatus;

  /**
   * List of Azure Managed Disks to attach to a Disk Pool.
   */
  disks?: Disk[];

  /**
   * Azure Resource ID of a Subnet for the Disk Pool.
   */
  @visibility("read", "create")
  subnetId: string;

  /**
   * List of additional capabilities for Disk Pool.
   */
  additionalCapabilities?: string[];
}

/**
 * Azure Managed Disk to attach to the Disk Pool.
 */
model Disk {
  /**
   * Unique Azure Resource ID of the Managed Disk.
   */
  id: string;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model SystemMetadata {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource.
   */
  createdByType?: CreatedByType;

  /**
   * The timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: CreatedByType;

  /**
   * The type of identity that last modified the resource.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * ARM resource model definition.
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts.
   */
  @visibility("read")
  type?: string;
}

/**
 * Request payload for create or update Disk Pool request.
 */
model DiskPoolCreate {
  /**
   * Determines the SKU of the Disk Pool
   */
  sku: Sku;

  /**
   * Properties for Disk Pool create request.
   */
  @extension("x-ms-client-flatten", true)
  properties: DiskPoolCreateProperties;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives.
   */
  @visibility("read", "create")
  location: string;

  /**
   * Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts.
   */
  @visibility("read")
  type?: string;

  /**
   * Azure resource id. Indicates if this resource is managed by another Azure resource.
   */
  managedBy?: string;

  /**
   * List of Azure resource ids that manage this resource.
   */
  managedByExtended?: string[];
}

/**
 * Properties for Disk Pool create or update request.
 */
model DiskPoolCreateProperties {
  /**
   * Logical zone for Disk Pool resource; example: ["1"].
   */
  availabilityZones?: string[];

  /**
   * List of Azure Managed Disks to attach to a Disk Pool.
   */
  disks?: Disk[];

  /**
   * Azure Resource ID of a Subnet for the Disk Pool.
   */
  @visibility("read", "create")
  subnetId: string;

  /**
   * List of additional capabilities for a Disk Pool.
   */
  additionalCapabilities?: string[];
}

/**
 * Request payload for Update Disk Pool request.
 */
model DiskPoolUpdate {
  /**
   * Azure resource id. Indicates if this resource is managed by another Azure resource.
   */
  managedBy?: string;

  /**
   * List of Azure resource ids that manage this resource.
   */
  managedByExtended?: string[];

  /**
   * Properties for Disk Pool update request.
   */
  @extension("x-ms-client-flatten", true)
  properties: DiskPoolUpdateProperties;

  /**
   * Determines the SKU of the Disk Pool
   */
  sku?: Sku;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * Properties for Disk Pool update request.
 */
model DiskPoolUpdateProperties {
  /**
   * List of Azure Managed Disks to attach to a Disk Pool.
   */
  disks?: Disk[];
}

/**
 * List Disk Pool skus operation response.
 */
model DiskPoolZoneListResult is Azure.Core.Page<DiskPoolZoneInfo>;

/**
 * Disk Pool SKU Details
 */
model DiskPoolZoneInfo {
  /**
   * Logical zone for Disk Pool resource; example: ["1"].
   */
  @visibility("read")
  availabilityZones?: string[];

  /**
   * List of additional capabilities for Disk Pool.
   */
  @visibility("read")
  additionalCapabilities?: string[];

  /**
   * Determines the SKU of VM deployed for Disk Pool
   */
  @visibility("read")
  sku?: Sku;
}

/**
 * List Disk Pool skus operation response.
 */
model ResourceSkuListResult is Azure.Core.Page<ResourceSkuInfo>;

/**
 * Resource SKU Details
 */
model ResourceSkuInfo {
  /**
   * StoragePool RP API version
   */
  @visibility("read")
  apiVersion?: string;

  /**
   * StoragePool resource type
   */
  @visibility("read")
  resourceType?: string;

  /**
   * List of additional capabilities for StoragePool resource.
   */
  @visibility("read")
  capabilities?: ResourceSkuCapability[];

  /**
   * Zones and zone capabilities in those locations where the SKU is available.
   */
  @visibility("read")
  locationInfo?: ResourceSkuLocationInfo;

  /**
   * Sku name
   */
  @visibility("read")
  name?: string;

  /**
   * Sku tier
   */
  @visibility("read")
  tier?: string;

  /**
   * The restrictions because of which SKU cannot be used. This is empty if there are no restrictions.
   */
  @visibility("read")
  restrictions?: ResourceSkuRestrictions[];
}

/**
 * Capability a resource SKU has.
 */
model ResourceSkuCapability {
  /**
   * Capability name
   */
  @visibility("read")
  name?: string;

  /**
   * Capability value
   */
  @visibility("read")
  value?: string;
}

/**
 * Zone and capability info for resource sku
 */
model ResourceSkuLocationInfo {
  /**
   * Location of the SKU
   */
  @visibility("read")
  location?: string;

  /**
   * List of availability zones where the SKU is supported.
   */
  @visibility("read")
  zones?: string[];

  /**
   * Details of capabilities available to a SKU in specific zones.
   */
  @visibility("read")
  zoneDetails?: ResourceSkuZoneDetails[];
}

/**
 * Describes The zonal capabilities of a SKU.
 */
model ResourceSkuZoneDetails {
  /**
   * The set of zones that the SKU is available in with the specified capabilities.
   */
  @visibility("read")
  name?: string[];

  /**
   * A list of capabilities that are available for the SKU in the specified list of zones.
   */
  @visibility("read")
  capabilities?: ResourceSkuCapability[];
}

/**
 * Describes scaling information of a SKU.
 */
model ResourceSkuRestrictions {
  /**
   * The type of restrictions.
   */
  @visibility("read")
  type?: ResourceSkuRestrictionsType;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  @visibility("read")
  values?: string[];

  /**
   * The information about the restriction where the SKU cannot be used.
   */
  @visibility("read")
  restrictionInfo?: ResourceSkuRestrictionInfo;

  /**
   * The reason for restriction.
   */
  @visibility("read")
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

/**
 * Describes an available Compute SKU Restriction Information.
 */
model ResourceSkuRestrictionInfo {
  /**
   * Locations where the SKU is restricted
   */
  @visibility("read")
  locations?: string[];

  /**
   * List of availability zones where the SKU is restricted.
   */
  @visibility("read")
  zones?: string[];
}

/**
 * Collection of Outbound Environment Endpoints
 */
model OutboundEnvironmentEndpointList
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

/**
 * Endpoints accessed for a common purpose that the App Service Environment requires outbound network access to.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The type of service accessed by the App Service Environment, e.g., Azure Storage, Azure SQL Database, and Azure Active Directory.
   */
  category?: string;

  /**
   * The endpoints that the App Service Environment reaches the service at.
   */
  endpoints?: EndpointDependency[];
}

/**
 * A domain name that a service is reached at, including details of the current connection status.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency.
   */
  domainName?: string;

  /**
   * The IP Addresses and Ports used when connecting to DomainName.
   */
  endpointDetails?: EndpointDetail[];
}

/**
 * Current TCP connectivity information from the App Service Environment to a single endpoint.
 */
model EndpointDetail {
  /**
   * An IP Address that Domain Name currently resolves to.
   */
  ipAddress?: string;

  /**
   * The port an endpoint is connected to.
   */
  port?: int32;

  /**
   * The time in milliseconds it takes for a TCP connection to be created from the App Service Environment to this IpAddress at this Port.
   */
  latency?: float64;

  /**
   * Whether it is possible to create a TCP connection from the App Service Environment to this IpAddress at this Port.
   */
  isAccessible?: boolean;
}

/**
 * Response properties for iSCSI Target operations.
 */
model IscsiTargetProperties {
  /**
   * Mode for Target connectivity.
   */
  aclMode: IscsiTargetAclMode;

  /**
   * Access Control List (ACL) for an iSCSI Target; defines LUN masking policy
   */
  staticAcls?: Acl[];

  /**
   * List of LUNs to be exposed through iSCSI Target.
   */
  luns?: IscsiLun[];

  /**
   * iSCSI Target IQN (iSCSI Qualified Name); example: "iqn.2005-03.org.iscsi:server".
   */
  targetIqn: string;

  /**
   * State of the operation on the resource.
   */
  @visibility("read")
  provisioningState: ProvisioningStates;

  /**
   * Operational status of the iSCSI Target.
   */
  status: OperationalStatus;

  /**
   * List of private IPv4 addresses to connect to the iSCSI Target.
   */
  endpoints?: string[];

  /**
   * The port used by iSCSI Target portal group.
   */
  port?: int32;

  /**
   * List of identifiers for active sessions on the iSCSI target
   */
  @visibility("read")
  sessions?: string[];
}

/**
 * Access Control List (ACL) for an iSCSI Target; defines LUN masking policy
 */
model Acl {
  /**
   * iSCSI initiator IQN (iSCSI Qualified Name); example: "iqn.2005-03.org.iscsi:client".
   */
  initiatorIqn: string;

  /**
   * List of LUN names mapped to the ACL.
   */
  mappedLuns: string[];
}

/**
 * LUN to expose the Azure Managed Disk.
 */
model IscsiLun {
  /**
   * User defined name for iSCSI LUN; example: "lun0"
   */
  name: string;

  /**
   * Azure Resource ID of the Managed Disk.
   */
  managedDiskAzureResourceId: string;

  /**
   * Specifies the Logical Unit Number of the iSCSI LUN.
   */
  @visibility("read")
  lun?: int32;
}

/**
 * Payload for iSCSI Target create or update requests.
 */
model IscsiTargetCreate extends ProxyResource {
  /**
   * Properties for iSCSI Target create request.
   */
  @extension("x-ms-client-flatten", true)
  properties: IscsiTargetCreateProperties;

  /**
   * Azure resource id. Indicates if this resource is managed by another Azure resource.
   */
  managedBy?: string;

  /**
   * List of Azure resource ids that manage this resource.
   */
  managedByExtended?: string[];
}

/**
 * Properties for iSCSI Target create or update request.
 */
model IscsiTargetCreateProperties {
  /**
   * Mode for Target connectivity.
   */
  aclMode: IscsiTargetAclMode;

  /**
   * iSCSI Target IQN (iSCSI Qualified Name); example: "iqn.2005-03.org.iscsi:server".
   */
  targetIqn?: string;

  /**
   * Access Control List (ACL) for an iSCSI Target; defines LUN masking policy
   */
  staticAcls?: Acl[];

  /**
   * List of LUNs to be exposed through iSCSI Target.
   */
  luns?: IscsiLun[];
}

/**
 * Payload for iSCSI Target update requests.
 */
model IscsiTargetUpdate extends ProxyResource {
  /**
   * Properties for iSCSI Target update request.
   */
  @extension("x-ms-client-flatten", true)
  properties: IscsiTargetUpdateProperties;

  /**
   * Azure resource id. Indicates if this resource is managed by another Azure resource.
   */
  managedBy?: string;

  /**
   * List of Azure resource ids that manage this resource.
   */
  managedByExtended?: string[];
}

/**
 * Properties for iSCSI Target update request.
 */
model IscsiTargetUpdateProperties {
  /**
   * Access Control List (ACL) for an iSCSI Target; defines LUN masking policy
   */
  staticAcls?: Acl[];

  /**
   * List of LUNs to be exposed through iSCSI Target.
   */
  luns?: IscsiLun[];
}
