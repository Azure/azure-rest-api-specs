import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.EventHub;

/**
 * Name of this SKU.
 */
union ClusterSkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dedicated: "Dedicated",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Provisioning state of the Cluster.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scaling: "Scaling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * Setting to Enable or Disable Confidential Compute
 */
union Mode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * Name of this SKU.
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
}

/**
 * The billing tier of this particular SKU.
 */
union SkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
}

/**
 * The minimum TLS version for the cluster to support, e.g. '1.2'
 */
union TlsVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.0`: "1.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.1`: "1.1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.2`: "1.2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.3`: "1.3",
}

/**
 * This determines if traffic is allowed over public network. By default it is enabled.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * Status of the connection.
 */
union PrivateLinkConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * Provisioning state of the Private Endpoint Connection.
 */
union EndPointProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * GeoDR Role Types
 */
union GeoDRRoleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Secondary: "Secondary",
}

/**
 * Provisioning state of NetworkSecurityPerimeter configuration propagation
 */
union NetworkSecurityPerimeterConfigurationProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InvalidResponse: "InvalidResponse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SucceededWithIssues: "SucceededWithIssues",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * Access Mode of the resource association
 */
union ResourceAssociationAccessMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoAssociationMode: "NoAssociationMode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EnforcedMode: "EnforcedMode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LearningMode: "LearningMode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AuditMode: "AuditMode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UnspecifiedMode: "UnspecifiedMode",
}

/**
 * Direction of Access Rule
 */
union NspAccessRuleDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inbound: "Inbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Outbound: "Outbound",
}

/**
 * Default Action for Network Rule Set
 */
union DefaultAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deny: "Deny",
}

/**
 * The IP Filter Action
 */
union NetworkRuleIPAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
}

/**
 * This determines if traffic is allowed over public network. By default it is enabled. If value is SecuredByPerimeter then Inbound and Outbound communication is controlled by the network security perimeter and profile's access rules.
 */
union PublicNetworkAccessFlag {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecuredByPerimeter: "SecuredByPerimeter",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AccessRights {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Manage: "Manage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Send: "Send",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Listen: "Listen",
}

/**
 * The access key to regenerate.
 */
union KeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrimaryKey: "PrimaryKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecondaryKey: "SecondaryKey",
}

/**
 * Enumerates the possible values for cleanup policy
 */
union CleanupPolicyRetentionDescription {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Compact: "Compact",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteOrCompact: "DeleteOrCompact",
}

/**
 * Denotes the type of timestamp the message will hold.Two types of timestamp types - "AppendTime" and "CreateTime". AppendTime refers the time in which message got appended inside broker log. CreateTime refers to the time in which the message was generated on source side and producers can set this timestamp while sending the message. Default value is AppendTime. If you are using AMQP protocol, CreateTime equals AppendTime and its behavior remains the same.
 */
union TimestampType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LogAppend: "LogAppend",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Create: "Create",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SchemaCompatibility {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Backward: "Backward",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Forward: "Forward",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SchemaType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Avro: "Avro",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProtoBuf: "ProtoBuf",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Json: "Json",
}

/**
 * Application Group Policy types
 */
union ApplicationGroupPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ThrottlingPolicy: "ThrottlingPolicy",
}

/**
 * Metric Id on which the throttle limit should be set, MetricId can be discovered by hovering over Metric in the Metrics section of Event Hub Namespace inside Azure Portal
 */
union MetricId {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IncomingBytes: "IncomingBytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OutgoingBytes: "OutgoingBytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IncomingMessages: "IncomingMessages",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OutgoingMessages: "OutgoingMessages",
}

/**
 * Type of managed service identity.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * Specifies the reason for the unavailability of the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum UnavailableReason {
  None,
  InvalidName,
  SubscriptionIsDisabled,
  NameInUse,
  NameInLockdown,
  TooManyNamespaceInCurrentSubscription,
}

/**
 * Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ProvisioningStateDR {
  Accepted,
  Succeeded,
  Failed,
}

/**
 * role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RoleDisasterRecovery {
  Primary,
  PrimaryNotReplicating,
  Secondary,
}

/**
 * Enumerates the possible values for the status of the Event Hub.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum EntityStatus {
  Active,
  Disabled,
  Restoring,
  SendDisabled,
  ReceiveDisabled,
  Creating,
  Deleting,
  Renaming,
  Unknown,
}

/**
 * Enumerates the possible values for the encoding format of capture description. Note: 'AvroDeflate' will be deprecated in New API Version
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum EncodingCaptureDescription {
  Avro,
  AvroDeflate,
}

/**
 * Type of Azure Active Directory Managed Identity.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CaptureIdentityType {
  SystemAssigned,
  UserAssigned,
}

/**
 * The response of the List Available Clusters operation.
 */
model AvailableClustersList {
  /**
   * The count of readily available and pre-provisioned Event Hubs Clusters per region.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: AvailableCluster[];
}

/**
 * Pre-provisioned and readily available Event Hubs Cluster count per region.
 */
model AvailableCluster {
  /**
   * Location fo the Available Cluster
   */
  location?: string;
}

/**
 * Error response indicates Event Hub service is not able to process the incoming request. The reason is provided in the error message.
 */
@error
model ErrorResponse {
  /**
   * The error object.
   */
  error?: ErrorDetail;
}

/**
 * The error detail.
 */
model ErrorDetail {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  details?: ErrorDetail[];

  /**
   * The error additional info.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * SKU parameters particular to a cluster instance.
 */
model ClusterSku {
  /**
   * Name of this SKU.
   */
  name: ClusterSkuName;

  /**
   * The quantity of Event Hubs Cluster Capacity Units contained in this cluster.
   */
  @minValue(1)
  capacity?: int32;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model SystemData {
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
 * Event Hubs Cluster properties supplied in responses in List or Get operations.
 */
model ClusterProperties {
  /**
   * The UTC time when the Event Hubs Cluster was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: string;

  /**
   * Provisioning state of the Cluster.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The UTC time when the Event Hubs Cluster was last updated.
   */
  @visibility(Lifecycle.Read)
  updatedAt?: string;

  /**
   * The metric ID of the cluster resource. Provided by the service and not modifiable by the user.
   */
  @visibility(Lifecycle.Read)
  metricId?: string;

  /**
   * Status of the Cluster resource
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * A value that indicates whether Scaling is Supported.
   */
  supportsScaling?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  platformCapabilities?: PlatformCapabilities;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PlatformCapabilities {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  confidentialCompute?: ConfidentialCompute;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfidentialCompute {
  /**
   * Setting to Enable or Disable Confidential Compute
   */
  mode?: Mode;
}

/**
 * Definition of resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TrackedResource extends Resource {
  /**
   * Resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The response of the List Namespace IDs operation
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EHNamespaceIdListResult {
  /**
   * Result of the List Namespace IDs operation
   */
  @pageItems
  value?: EHNamespaceIdContainer[];
}

/**
 * The full ARM ID of an Event Hubs Namespace
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EHNamespaceIdContainer {
  /**
   * id parameter
   */
  id?: string;
}

/**
 * SKU parameters supplied to the create namespace operation
 */
model Sku {
  /**
   * Name of this SKU.
   */
  name: SkuName;

  /**
   * The billing tier of this particular SKU.
   */
  tier?: SkuTier;

  /**
   * The Event Hubs throughput units for Basic or Standard tiers, where value should be 0 to 20 throughput units. The Event Hubs premium units for Premium tier, where value should be 0 to 10 premium units.
   */
  @minValue(0)
  capacity?: int32;
}

/**
 * Properties to configure Identity for Bring your Own Keys
 */
model Identity {
  /**
   * ObjectId from the KeyVault
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * TenantId from the KeyVault
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Type of managed service identity.
   */
  type?: ManagedServiceIdentityType;

  /**
   * Properties for User Assigned Identities
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Recognized Dictionary value.
 */
model UserAssignedIdentity {
  /**
   * Principal Id of user assigned identity
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Client Id of user assigned identity
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Namespace properties supplied for create namespace operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EHNamespaceProperties {
  /**
   * The minimum TLS version for the cluster to support, e.g. '1.2'
   */
  minimumTlsVersion?: TlsVersion;

  /**
   * Provisioning state of the Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Status of the Namespace.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The time the Namespace was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The time the Namespace was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Endpoint you can use to perform Service Bus operations.
   */
  @visibility(Lifecycle.Read)
  serviceBusEndpoint?: string;

  /**
   * Cluster ARM ID of the Namespace.
   */
  clusterArmId?: string;

  /**
   * Identifier for Azure Insights metrics.
   */
  @visibility(Lifecycle.Read)
  metricId?: string;

  /**
   * Value that indicates whether AutoInflate is enabled for eventhub namespace.
   */
  isAutoInflateEnabled?: boolean;

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * Upper limit of throughput units when AutoInflate is enabled, value should be within 0 to 20 throughput units. ( '0' if AutoInflateEnabled = true)
   */
  @minValue(0)
  maximumThroughputUnits?: int32;

  /**
   * Value that indicates whether Kafka is enabled for eventhub namespace.
   */
  kafkaEnabled?: boolean;

  /**
   * Enabling this property creates a Standard Event Hubs Namespace in regions supported availability zones.
   */
  zoneRedundant?: boolean;

  /**
   * Properties of BYOK Encryption description
   */
  encryption?: Encryption;

  /**
   * List of private endpoint connections.
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * This property disables SAS authentication for the Event Hubs namespace.
   */
  disableLocalAuth?: boolean;

  /**
   * Alternate name specified when alias and namespace names are same.
   */
  alternateName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  platformCapabilities?: PlatformCapabilities;

  /**
   * Geo Data Replication settings for the namespace
   */
  geoDataReplication?: GeoDataReplicationProperties;
}

/**
 * Properties to configure Encryption
 */
model Encryption {
  /**
   * Properties of KeyVault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultProperties?: KeyVaultProperties[];

  /**
   * Enumerates the possible value of keySource for Encryption
   */
  keySource?: "Microsoft.KeyVault" = "Microsoft.KeyVault";

  /**
   * Enable Infrastructure Encryption (Double Encryption)
   */
  requireInfrastructureEncryption?: boolean;
}

/**
 * Properties to configure keyVault Properties
 */
model KeyVaultProperties {
  /**
   * Name of the Key from KeyVault
   */
  keyName?: string;

  /**
   * Uri of KeyVault
   */
  keyVaultUri?: string;

  /**
   * Key Version
   */
  keyVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: UserAssignedIdentityProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UserAssignedIdentityProperties {
  /**
   * ARM ID of user Identity selected for encryption
   */
  userAssignedIdentity?: string;
}

/**
 * Properties of the private endpoint connection resource.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The Private Endpoint resource for this Connection.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Details about the state of the connection.
   */
  privateLinkServiceConnectionState?: ConnectionState;

  /**
   * Provisioning state of the Private Endpoint Connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: EndPointProvisioningState;
}

/**
 * PrivateEndpoint information.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint.
   */
  id?: string;
}

/**
 * ConnectionState information.
 */
model ConnectionState {
  /**
   * Status of the connection.
   */
  status?: PrivateLinkConnectionStatus;

  /**
   * Description of the connection state.
   */
  description?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model ProxyResource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.EventHub/Namespaces" or "Microsoft.EventHub/Namespaces/EventHubs"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * GeoDR Replication properties
 */
model GeoDataReplicationProperties {
  /**
   * The maximum acceptable lag for data replication operations from the primary replica to a quorum of secondary replicas.  When the lag exceeds the configured amount, operations on the primary replica will be failed. The allowed values are 0 and 5 minutes to 1 day.
   */
  maxReplicationLagDurationInSeconds?: int32;

  /**
   * A list of regions where replicas of the namespace are maintained.
   */
  @identifiers(#[])
  locations?: NamespaceReplicaLocation[];
}

/**
 * Namespace replication properties
 */
model NamespaceReplicaLocation {
  /**
   * Azure regions where a replica of the namespace is maintained
   */
  locationName?: string;

  /**
   * GeoDR Role Types
   */
  roleType?: GeoDRRoleType;

  /**
   * state of Namespace replica.
   */
  @visibility(Lifecycle.Read)
  replicaState?: string;

  /**
   * Optional property that denotes the ARM ID of the Cluster. This is required, if a namespace replica should be placed in a Dedicated Event Hub Cluster
   */
  clusterArmId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FailOver {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: FailOverProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FailOverProperties {
  /**
   * Query parameter for the new primary location after failover.
   */
  primaryLocation?: string;

  /**
   * If Force is false then graceful failover is attempted after ensuring no data loss. If Force flag is set to true, Forced failover is attempted with possible data loss.
   */
  force?: boolean;
}

/**
 * Information of the private link resource.
 */
model PrivateLinkResource {
  /**
   * Properties of the private link resource.
   */
  properties?: PrivateLinkResourceProperties;

  /**
   * Fully qualified identifier of the resource.
   */
  id?: string;

  /**
   * Name of the resource
   */
  name?: string;

  /**
   * Type of the resource
   */
  type?: string;
}

/**
 * Properties of PrivateLinkResource
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Result of the List NetworkSecurityPerimeterConfiguration operation.
 */
model NetworkSecurityPerimeterConfigurationList {
  /**
   * A collection of NetworkSecurityPerimeterConfigurations
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: NetworkSecurityPerimeterConfiguration[];
}

/**
 * Properties of NetworkSecurityPerimeterConfiguration
 */
model NetworkSecurityPerimeterConfigurationProperties {
  /**
   * Provisioning state of NetworkSecurityPerimeter configuration propagation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: NetworkSecurityPerimeterConfigurationProvisioningState;

  /**
   * List of Provisioning Issues if any
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  provisioningIssues?: ProvisioningIssue[];

  /**
   * NetworkSecurityPerimeter related information
   */
  @visibility(Lifecycle.Read)
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  /**
   * Information about resource association
   */
  @visibility(Lifecycle.Read)
  resourceAssociation?: NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation;

  /**
   * Information about current network profile
   */
  @visibility(Lifecycle.Read)
  profile?: NetworkSecurityPerimeterConfigurationPropertiesProfile;

  /**
   * True if the EventHub namespace is backed by another Azure resource and not visible to end users.
   */
  @visibility(Lifecycle.Read)
  isBackingResource?: boolean;

  /**
   * Indicates that the NSP controls related to backing association are only applicable to a specific feature in backing resource's data plane.
   */
  @visibility(Lifecycle.Read)
  applicableFeatures?: string[];

  /**
   * Source Resource Association name
   */
  @visibility(Lifecycle.Read)
  parentAssociationName?: string;

  /**
   * ARM Id of source resource
   */
  @visibility(Lifecycle.Read)
  sourceResourceId?: string;
}

/**
 * Describes Provisioning issue for given NetworkSecurityPerimeterConfiguration
 */
model ProvisioningIssue {
  /**
   * Name of the issue
   */
  name?: string;

  /**
   * Properties of Provisioning Issue
   */
  @visibility(Lifecycle.Read)
  properties?: ProvisioningIssueProperties;
}

/**
 * Properties of Provisioning Issue
 */
model ProvisioningIssueProperties {
  /**
   * Type of Issue
   */
  issueType?: string;

  /**
   * Description of the issue
   */
  description?: string;
}

/**
 * NetworkSecurityPerimeter related information
 */
model NetworkSecurityPerimeter {
  /**
   * Fully qualified identifier of the resource
   */
  id?: string;

  /**
   * Guid of the resource
   */
  perimeterGuid?: string;

  /**
   * Location of the resource
   */
  location?: string;
}

/**
 * Information about resource association
 */
model NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation {
  /**
   * Name of the resource association
   */
  name?: string;

  /**
   * Access Mode of the resource association
   */
  accessMode?: ResourceAssociationAccessMode;
}

/**
 * Information about current network profile
 */
model NetworkSecurityPerimeterConfigurationPropertiesProfile {
  /**
   * Name of the resource
   */
  name?: string;

  /**
   * Current access rules version
   */
  accessRulesVersion?: string;

  /**
   * List of Access Rules
   */
  accessRules?: NspAccessRule[];
}

/**
 * Information of Access Rule in Network Profile
 */
model NspAccessRule {
  /**
   * Fully qualified identifier of the resource
   */
  id?: string;

  /**
   * Name of the resource
   */
  name?: string;

  /**
   * Type of the resource
   */
  type?: string;

  /**
   * Properties of Access Rule
   */
  @visibility(Lifecycle.Read)
  properties?: NspAccessRuleProperties;
}

/**
 * Properties of Access Rule
 */
model NspAccessRuleProperties {
  /**
   * Direction of Access Rule
   */
  direction?: NspAccessRuleDirection;

  /**
   * Address prefixes in the CIDR format for inbound rules
   */
  addressPrefixes?: string[];

  /**
   * Subscriptions for inbound rules
   */
  subscriptions?: NspAccessRulePropertiesSubscriptionsItem[];

  /**
   * NetworkSecurityPerimeters for inbound rules
   */
  @visibility(Lifecycle.Read)
  networkSecurityPerimeters?: NetworkSecurityPerimeter[];

  /**
   * FQDN for outbound rules
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainNames?: string[];
}

/**
 * Subscription for inbound rule
 */
model NspAccessRulePropertiesSubscriptionsItem {
  /**
   * Fully qualified identifier of subscription
   */
  id?: string;
}

/**
 * Contains all settings for the cluster.
 */
model ClusterQuotaConfigurationProperties {
  /**
   * All possible Cluster settings - a collection of key/value paired settings which apply to quotas and configurations imposed on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: Record<string>;
}

/**
 * NetworkRuleSet properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkRuleSetProperties {
  /**
   * Value that indicates whether Trusted Service Access is Enabled or not.
   */
  trustedServiceAccessEnabled?: boolean;

  /**
   * Default Action for Network Rule Set
   */
  defaultAction?: DefaultAction;

  /**
   * List VirtualNetwork Rules
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualNetworkRules?: NWRuleSetVirtualNetworkRules[];

  /**
   * List of IpRules
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipRules?: NWRuleSetIpRules[];

  /**
   * This determines if traffic is allowed over public network. By default it is enabled. If value is SecuredByPerimeter then Inbound and Outbound communication is controlled by the network security perimeter and profile's access rules.
   */
  publicNetworkAccess?: PublicNetworkAccessFlag = PublicNetworkAccessFlag.Enabled;
}

/**
 * The response from the List namespace operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NWRuleSetVirtualNetworkRules {
  /**
   * Subnet properties
   */
  subnet?: Subnet;

  /**
   * Value that indicates whether to ignore missing Vnet Service Endpoint
   */
  ignoreMissingVnetServiceEndpoint?: boolean;
}

/**
 * Properties supplied for Subnet
 */
model Subnet {
  /**
   * Resource ID of Virtual Network Subnet
   */
  id?: string;
}

/**
 * The response from the List namespace operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NWRuleSetIpRules {
  /**
   * IP Mask
   */
  ipMask?: string;

  /**
   * The IP Filter Action
   */
  action?: NetworkRuleIPAction;
}

/**
 * Properties supplied to create or update AuthorizationRule
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AuthorizationRuleProperties {
  /**
   * The rights associated with the rule.
   */
  rights: AccessRights[];
}

/**
 * Namespace/EventHub Connection String
 */
model AccessKeys {
  /**
   * Primary connection string of the created namespace AuthorizationRule.
   */
  @visibility(Lifecycle.Read)
  primaryConnectionString?: string;

  /**
   * Secondary connection string of the created namespace AuthorizationRule.
   */
  @visibility(Lifecycle.Read)
  secondaryConnectionString?: string;

  /**
   * Primary connection string of the alias if GEO DR is enabled
   */
  @visibility(Lifecycle.Read)
  aliasPrimaryConnectionString?: string;

  /**
   * Secondary  connection string of the alias if GEO DR is enabled
   */
  @visibility(Lifecycle.Read)
  aliasSecondaryConnectionString?: string;

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @visibility(Lifecycle.Read)
  secondaryKey?: string;

  /**
   * A string that describes the AuthorizationRule.
   */
  @visibility(Lifecycle.Read)
  keyName?: string;
}

/**
 * Parameters supplied to the Regenerate Authorization Rule operation, specifies which key needs to be reset.
 */
model RegenerateAccessKeyParameters {
  /**
   * The access key to regenerate.
   */
  keyType: KeyType;

  /**
   * Optional, if the key value provided, is set for KeyType or autogenerated Key value set for keyType
   */
  key?: string;
}

/**
 * Parameter supplied to check Namespace name availability operation
 */
model CheckNameAvailabilityParameter {
  /**
   * Name to check the namespace name availability
   */
  name: string;
}

/**
 * The Result of the CheckNameAvailability operation
 */
model CheckNameAvailabilityResult {
  /**
   * The detailed info regarding the reason associated with the Namespace.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Value indicating Namespace is availability, true if the Namespace is available; otherwise, false.
   */
  nameAvailable?: boolean;

  /**
   * The reason for unavailability of a Namespace.
   */
  reason?: UnavailableReason;
}

/**
 * Single item in List or Get Consumer group operation
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConsumerGroupProperties {
  /**
   * Exact time the message was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The exact time the message was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * User Metadata is a placeholder to store user-defined string data with maximum length 1024. e.g. it can be used to store descriptive data, such as list of teams and their contact information also user-defined configuration settings can be stored.
   */
  userMetadata?: string;
}

/**
 * Properties required to the Create Or Update Alias(Disaster Recovery configurations)
 */
model ArmDisasterRecoveryProperties {
  /**
   * Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateDR;

  /**
   * ARM Id of the Primary/Secondary eventhub namespace name, which is part of GEO DR pairing
   */
  partnerNamespace?: string;

  /**
   * Alternate name specified when alias and namespace names are same.
   */
  alternateName?: string;

  /**
   * role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'
   */
  @visibility(Lifecycle.Read)
  role?: RoleDisasterRecovery;

  /**
   * Number of entities pending to be replicated.
   */
  @visibility(Lifecycle.Read)
  pendingReplicationOperationsCount?: int64;
}

/**
 * A Event Hub REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;
}

/**
 * Operation display payload
 */
model OperationDisplay {
  /**
   * Resource provider of the operation
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Resource of the operation
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * Localized friendly name for the operation
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Localized friendly description for the operation
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Properties supplied to the Create Or Update Event Hub operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventhubProperties {
  /**
   * Current number of shards on the Event Hub.
   */
  @visibility(Lifecycle.Read)
  partitionIds?: string[];

  /**
   * Exact time the Event Hub was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The exact time the message was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Number of days to retain the events for this Event Hub, value should be 1 to 7 days
   */
  @minValue(1)
  messageRetentionInDays?: int64;

  /**
   * Number of partitions created for the Event Hub, allowed values are from 1 to 32 partitions.
   */
  @minValue(1)
  partitionCount?: int64;

  /**
   * Enumerates the possible values for the status of the Event Hub.
   */
  status?: EntityStatus;

  /**
   * Properties of capture description
   */
  captureDescription?: CaptureDescription;

  /**
   * Event Hub retention settings
   */
  retentionDescription?: RetentionDescription;

  /**
   * Properties of MessageTimestamp Description
   */
  messageTimestampDescription?: MessageTimestampDescription;

  /**
   * Denotes the unique identifier for event hub and is generated by service while creating topic. This identifier can be used in kafka runtime apis wherever a UUID is required e.g Fetch & Delete Topic. This identifier is not supported in AMQP runtime operations yet.
   */
  @visibility(Lifecycle.Read)
  identifier?: string;

  /**
   * Gets and Sets Metadata of User.
   */
  userMetadata?: string;
}

/**
 * Properties to configure capture description for eventhub
 */
model CaptureDescription {
  /**
   * A value that indicates whether capture description is enabled.
   */
  enabled?: boolean;

  /**
   * Enumerates the possible values for the encoding format of capture description. Note: 'AvroDeflate' will be deprecated in New API Version
   */
  encoding?: EncodingCaptureDescription;

  /**
   * The time window allows you to set the frequency with which the capture to Azure Blobs will happen, value should between 60 to 900 seconds
   */
  intervalInSeconds?: int32;

  /**
   * The size window defines the amount of data built up in your Event Hub before an capture operation, value should be between 10485760 to 524288000 bytes
   */
  sizeLimitInBytes?: int32;

  /**
   * Properties of Destination where capture will be stored. (Storage Account, Blob Names)
   */
  destination?: Destination;

  /**
   * A value that indicates whether to Skip Empty Archives
   */
  skipEmptyArchives?: boolean;
}

/**
 * Capture storage details for capture description
 */
model Destination {
  /**
   * Name for capture destination
   */
  name?: string;

  /**
   * A value that indicates whether capture description is enabled.
   */
  identity?: CaptureIdentity;

  /**
   * Properties describing the storage account, blob container and archive name format for capture destination
   */
  properties?: DestinationProperties;
}

/**
 * A value that indicates whether capture description is enabled.
 */
model CaptureIdentity {
  /**
   * Type of Azure Active Directory Managed Identity.
   */
  type?: CaptureIdentityType;

  /**
   * ARM ID of Managed User Identity. This property is required is the type is UserAssignedIdentity. If type is SystemAssigned, then the System Assigned Identity Associated with the namespace will be used.
   */
  userAssignedIdentity?: string;
}

/**
 * Properties describing the storage account, blob container and archive name format for capture destination
 */
model DestinationProperties {
  /**
   * Resource id of the storage account to be used to create the blobs
   */
  storageAccountResourceId?: string;

  /**
   * Blob container Name
   */
  blobContainer?: string;

  /**
   * Blob naming convention for archive, e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
   */
  archiveNameFormat?: string;

  /**
   * Subscription Id of Azure Data Lake Store
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  dataLakeSubscriptionId?: string;

  /**
   * The Azure Data Lake Store name for the captured events
   */
  dataLakeAccountName?: string;

  /**
   * The destination folder path for the captured events
   */
  dataLakeFolderPath?: string;
}

/**
 * Properties to configure retention settings for the  eventhub
 */
model RetentionDescription {
  /**
   * Enumerates the possible values for cleanup policy
   */
  cleanupPolicy?: CleanupPolicyRetentionDescription;

  /**
   * Number of hours to retain the events for this Event Hub. This should be positive value upto namespace SKU max. -1 is a special case where retention time is infinite, but the size of an entity is restricted and its size depends on namespace SKU type.
   */
  retentionTimeInHours?: int64;

  /**
   * The minimum time a message will remain ineligible for compaction in the log. This value is used when cleanupPolicy is Compact or DeleteOrCompact.
   */
  minCompactionLagTimeInMinutes?: int64;

  /**
   * Number of hours to retain the tombstone markers of a compacted Event Hub. This value is used when cleanupPolicy is Compact or DeleteOrCompact. Consumer must complete reading the tombstone marker within this specified amount of time if consumer begins from starting offset to ensure they get a valid snapshot for the specific key described by the tombstone marker within the compacted Event Hub
   */
  tombstoneRetentionTimeInHours?: int32;
}

/**
 * Properties of MessageTimestamp Description
 */
model MessageTimestampDescription {
  /**
   * Denotes the type of timestamp the message will hold.Two types of timestamp types - "AppendTime" and "CreateTime". AppendTime refers the time in which message got appended inside broker log. CreateTime refers to the time in which the message was generated on source side and producers can set this timestamp while sending the message. Default value is AppendTime. If you are using AMQP protocol, CreateTime equals AppendTime and its behavior remains the same.
   */
  timestampType?: TimestampType;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SchemaGroupProperties {
  /**
   * Exact time the Schema Group was updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAtUtc?: utcDateTime;

  /**
   * Exact time the Schema Group was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAtUtc?: utcDateTime;

  /**
   * The ETag value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  eTag?: string;

  /**
   * dictionary object for SchemaGroup group properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groupProperties?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schemaCompatibility?: SchemaCompatibility;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  schemaType?: SchemaType;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationGroupProperties {
  /**
   * Determines if Application Group is allowed to create connection with namespace or not. Once the isEnabled is set to false, all the existing connections of application group gets dropped and no new connections will be allowed
   */
  isEnabled?: boolean;

  /**
   * The Unique identifier for application group.Supports SAS(SASKeyName=KeyName) or AAD(AADAppID=Guid)
   */
  clientAppGroupIdentifier: string;

  /**
   * List of group policies that define the behavior of application group. The policies can support resource governance scenarios such as limiting ingress or egress traffic.
   */
  @identifiers(#[])
  policies?: ApplicationGroupPolicy[];
}

/**
 * Properties of the Application Group policy
 */
@discriminator("type")
model ApplicationGroupPolicy {
  /**
   * The Name of this policy
   */
  name: string;

  /**
   * Application Group Policy types
   */
  type: ApplicationGroupPolicyType;
}

/**
 * Properties of the throttling policy
 */
model ThrottlingPolicy extends ApplicationGroupPolicy {
  /**
   * The Threshold limit above which the application group will be throttled.Rate limit is always per second.
   */
  rateLimitThreshold: int64;

  /**
   * Metric Id on which the throttle limit should be set, MetricId can be discovered by hovering over Metric in the Metrics section of Event Hub Namespace inside Azure Portal
   */
  metricId: MetricId;

  /**
   * Application Group Policy types
   */
  type: "ThrottlingPolicy";
}

model EventHubListResult is Azure.Core.Page<Eventhub>;

model PrivateLinkResourcesListResult is Azure.Core.Page<PrivateLinkResource>;

model NetworkRuleSetListResult is Azure.Core.Page<NetworkRuleSet>;

model OperationListResult is Azure.Core.Page<Operation>;
@@visibility(OperationListResult.value, Lifecycle.Read);
