import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.Devices;

/**
 * Represents a list of private endpoint connections.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateEndpointConnectionsList is PrivateEndpointConnection[];

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationListResult {
  /**
   * [Placeholder] Description for value property
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value: Operation[];

  /**
   * [Placeholder] Description for nextLink property.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Represents an operation.
 */
model Operation {
  /**
   * The name of the operation.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The display information for the operation.
   */
  display?: {
    /**
     * Service provider: Microsoft Devices.
     */
    @visibility(Lifecycle.Read)
    provider?: string;

    /**
     * Resource Type: ProvisioningServices.
     */
    @visibility(Lifecycle.Read)
    resource?: string;

    /**
     * Name of the operation.
     */
    @visibility(Lifecycle.Read)
    operation?: string;
  };
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union CertificatePurpose {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientAuthentication: "clientAuthentication",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serverAuthentication: "serverAuthentication",
}

/**
 * Current state of the provisioning service.
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Activating: "Activating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActivationFailed: "ActivationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeletionFailed: "DeletionFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Transitioning: "Transitioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Resuming: "Resuming",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FailingOver: "FailingOver",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FailoverFailed: "FailoverFailed",
}

/**
 * Whether requests from Public Network are allowed
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The status of a private endpoint connection
 */
union PrivateLinkServiceConnectionStatus {
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
 * Device Registry Namespace MI authentication type: UserAssigned, SystemAssigned.
 */
union DeviceRegistryNamespaceAuthenticationType {
  string,

  /**
   * User assigned authentication type.
   */
  UserAssigned: "UserAssigned",

  /**
   * System assigned authentication type.
   */
  SystemAssigned: "SystemAssigned",
}

/**
 * Allocation policy to be used by this provisioning service.
 */
union AllocationPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hashed: "Hashed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeoLatency: "GeoLatency",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Static: "Static",
}

/**
 * Rights that this key has.
 */
union AccessRightsDescription {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServiceConfig: "ServiceConfig",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EnrollmentRead: "EnrollmentRead",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EnrollmentWrite: "EnrollmentWrite",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeviceConnect: "DeviceConnect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RegistrationStatusRead: "RegistrationStatusRead",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RegistrationStatusWrite: "RegistrationStatusWrite",
}

/**
 * Sku name.
 */
union IotDpsSku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  S1: "S1",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * specifies the reason a name is unavailable
 */
union NameUnavailabilityReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlreadyExists: "AlreadyExists",
}

/**
 * The desired action for requests captured by this rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IpFilterActionType {
  Accept,
  Reject,
}

/**
 * Target for requests captured by this rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IpFilterTargetType {
  all,
  serviceApi,
  deviceApi,
}

/**
 * Error details.
 */
@error
model ErrorDetails {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: int32;

  /**
   * The HTTP status code.
   */
  @visibility(Lifecycle.Read)
  httpStatusCode?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  details?: string;
}

/**
 * The description of an X509 CA Certificate.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CertificateProperties {
  /**
   * The certificate's subject name.
   */
  @visibility(Lifecycle.Read)
  subject?: string;

  /**
   * The certificate's expiration date and time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @encode(DateTimeKnownEncoding.rfc7231)
  expiry?: utcDateTime;

  /**
   * The certificate's thumbprint.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Determines whether certificate has been verified.
   */
  isVerified?: boolean;

  /**
   * base-64 representation of X509 certificate .cer file or just .pem file content.
   */
  certificate?: bytes;

  /**
   * The certificate's creation date and time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @encode(DateTimeKnownEncoding.rfc7231)
  created?: utcDateTime;

  /**
   * The certificate's last update date and time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @encode(DateTimeKnownEncoding.rfc7231)
  updated?: utcDateTime;
}

/**
 * the service specific properties of a provisioning service, including keys, linked iot hubs, current state, and system generated properties such as hostname and idScope
 */
model IotDpsPropertiesDescription {
  /**
   * Current state of the provisioning service.
   */
  state?: State;

  /**
   * Whether requests from Public Network are allowed
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The IP filter rules.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipFilterRules?: IpFilterRule[];

  /**
   * Private endpoint connections created on this IotHub
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The ARM provisioning state of the provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: string;

  /**
   * List of IoT hubs associated with this provisioning service.
   */
  iotHubs?: IotHubDefinitionDescription[];

  /**
   * The Device Registry namespace that is linked to the provisioning service.
   */
  deviceRegistryNamespace?: DeviceRegistryNamespaceDescription;

  /**
   * Allocation policy to be used by this provisioning service.
   */
  allocationPolicy?: AllocationPolicy;

  /**
   * Service endpoint for provisioning service.
   */
  @visibility(Lifecycle.Read)
  serviceOperationsHostName?: string;

  /**
   * Device endpoint for this provisioning service.
   */
  @visibility(Lifecycle.Read)
  deviceProvisioningHostName?: string;

  /**
   * Unique identifier of this provisioning service.
   */
  @visibility(Lifecycle.Read)
  idScope?: string;

  /**
   * List of authorization keys for a provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationPolicies?: SharedAccessSignatureAuthorizationRuleAccessRightsDescription[];

  /**
   * Optional.
   * Indicates if the DPS instance has Data Residency enabled, removing the cross geo-pair disaster recovery.
   */
  enableDataResidency?: boolean;

  /**
   * Portal endpoint to enable CORS for this provisioning service.
   */
  portalOperationsHostName?: string;
}

/**
 * The IP filter rules for a provisioning Service.
 */
model IpFilterRule {
  /**
   * The name of the IP filter rule.
   */
  filterName: string;

  /**
   * The desired action for requests captured by this rule.
   */
  action: IpFilterActionType;

  /**
   * A string that contains the IP address range in CIDR notation for the rule.
   */
  ipMask: string;

  /**
   * Target for requests captured by this rule.
   */
  target?: IpFilterTargetType;
}

/**
 * The properties of a private endpoint connection
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateEndpointConnectionProperties {
  /**
   * The private endpoint property of a private endpoint connection
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * The current state of a private endpoint connection
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;
}

/**
 * The private endpoint property of a private endpoint connection
 */
model PrivateEndpoint {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * The current state of a private endpoint connection
 */
model PrivateLinkServiceConnectionState {
  /**
   * The status of a private endpoint connection
   */
  status: PrivateLinkServiceConnectionStatus;

  /**
   * The description for the current state of a private endpoint connection
   */
  description: string;

  /**
   * Actions required for a private endpoint connection
   */
  actionsRequired?: string;
}

/**
 * Description of the IoT hub.
 */
model IotHubDefinitionDescription {
  /**
   * flag for applying allocationPolicy or not for a given iot hub.
   */
  applyAllocationPolicy?: boolean;

  /**
   * weight to apply for a given iot h.
   */
  allocationWeight?: int32;

  /**
   * Host name of the IoT hub.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Connection string of the IoT hub.
   */
  connectionString: string;

  /**
   * ARM region of the IoT hub.
   */
  location: string;
}

/**
 * Description of the Device Registry namespace that is linked to the provisioning service.
 */
model DeviceRegistryNamespaceDescription {
  /**
   * The ARM resource ID of the Device Registry namespace.
   */
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces";
    }
  ]>;

  /**
   * Device Registry Namespace MI authentication type: UserAssigned, SystemAssigned.
   */
  authenticationType: DeviceRegistryNamespaceAuthenticationType;

  /**
   * The selected user-assigned identity resource Id associated with Device Registry namespace. This is required when authenticationType is UserAssigned.
   */
  selectedUserAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * Description of the shared access key.
 */
model SharedAccessSignatureAuthorizationRuleAccessRightsDescription {
  /**
   * Name of the key.
   */
  keyName: string;

  /**
   * Primary SAS key value.
   */
  primaryKey?: string;

  /**
   * Secondary SAS key value.
   */
  secondaryKey?: string;

  /**
   * Rights that this key has.
   */
  rights: AccessRightsDescription;
}

/**
 * List of possible provisioning service SKUs.
 */
model IotDpsSkuInfo {
  /**
   * Sku name.
   */
  name?: IotDpsSku;

  /**
   * Pricing tier name of the provisioning service.
   */
  @visibility(Lifecycle.Read)
  tier?: string;

  /**
   * The number of units to provision
   */
  capacity?: int64;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
   */
  type: ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The common properties of an Azure resource.
 */
model Resource {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource location.
   */
  location: string;

  /**
   * The resource group of the resource.
   */
  resourcegroup?: string;

  /**
   * The subscription id of the resource.
   */
  subscriptionid?: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a Provisioning Service instance.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TagsResource {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The JSON-serialized array of Certificate objects.
 */
model CertificateListDescription {
  /**
   * The array of Certificate objects.
   */
  @pageItems
  value?: CertificateResponse[];
}

/**
 * Result of a long running operation.
 */
model AsyncOperationResult {
  /**
   * current status of a long running operation.
   */
  status?: string;

  /**
   * Error message containing code, description and details
   */
  error?: ErrorMessage;
}

/**
 * Error response containing message and code.
 */
model ErrorMessage {
  /**
   * standard error code
   */
  code?: string;

  /**
   * standard error description
   */
  message?: string;

  /**
   * detailed summary of error
   */
  details?: string;
}

/**
 * List of available SKUs.
 */
model IotDpsSkuDefinitionListResult is Azure.Core.Page<IotDpsSkuDefinition>;

/**
 * Available SKUs of tier and units.
 */
model IotDpsSkuDefinition {
  /**
   * Sku name.
   */
  name?: IotDpsSku;
}

/**
 * Description of the response of the verification code.
 */
model VerificationCodeResponse {
  /**
   * Name of certificate.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Request etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: VerificationCodeResponseProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VerificationCodeResponseProperties {
  /**
   * Verification code.
   */
  verificationCode?: string;

  /**
   * Certificate subject.
   */
  subject?: string;

  /**
   * Code expiry.
   */
  expiry?: string;

  /**
   * Certificate thumbprint.
   */
  thumbprint?: string;

  /**
   * Indicate if the certificate is verified by owner of private key.
   */
  isVerified?: boolean;

  /**
   * base-64 representation of X509 certificate .cer file or just .pem file content.
   */
  certificate?: bytes;

  /**
   * Certificate created time.
   */
  created?: string;

  /**
   * Certificate updated time.
   */
  updated?: string;
}

/**
 * The JSON-serialized leaf certificate
 */
model VerificationCodeRequest {
  /**
   * base-64 representation of X509 certificate .cer file or just .pem file content.
   */
  certificate?: string;
}

/**
 * Input values for operation results call.
 */
model OperationInputs {
  /**
   * The name of the Provisioning Service to check.
   */
  name: string;
}

/**
 * Description of name availability.
 */
model NameAvailabilityInfo {
  /**
   * specifies if a name is available or not
   */
  nameAvailable?: boolean;

  /**
   * specifies the reason a name is unavailable
   */
  reason?: NameUnavailabilityReason;

  /**
   * message containing a detailed reason name is unavailable
   */
  message?: string;
}

/**
 * List of shared access keys.
 */
model SharedAccessSignatureAuthorizationRuleListResult
  is Azure.Core.Page<SharedAccessSignatureAuthorizationRuleAccessRightsDescription>;

/**
 * The available private link resources for a provisioning service
 */
model PrivateLinkResources {
  /**
   * The list of available private link resources for a provisioning service
   */
  @pageItems
  value?: GroupIdInformation[];
}

/**
 * The properties for a group information object
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GroupIdInformationProperties {
  /**
   * The group id
   */
  groupId?: string;

  /**
   * The required members for a specific group id
   */
  requiredMembers?: string[];

  /**
   * The required DNS zones for a specific group id
   */
  requiredZoneNames?: string[];
}

/**
 * The JSON-serialized X509 Certificate.
 */
model CertificateBodyDescription {
  /**
   * Base-64 representation of the X509 leaf certificate .cer file or just .pem file content.
   */
  certificate?: string;

  /**
   * True indicates that the certificate will be created in verified state and proof of possession will not be required.
   */
  isVerified?: boolean;
}
