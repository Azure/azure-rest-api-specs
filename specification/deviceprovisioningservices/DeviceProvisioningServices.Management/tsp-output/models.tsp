import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Devices;

interface Operations extends Azure.ResourceManager.Operations {}

enum CertificatePurpose {
  clientAuthentication,
  serverAuthentication,
}

/**
 * Current state of the provisioning service.
 */
enum State {
  Activating,
  Active,
  Deleting,
  Deleted,
  ActivationFailed,
  DeletionFailed,
  Transitioning,
  Suspending,
  Suspended,
  Resuming,
  FailingOver,
  FailoverFailed,
}

/**
 * Whether requests from Public Network are allowed
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * The status of a private endpoint connection
 */
enum PrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Allocation policy to be used by this provisioning service.
 */
enum AllocationPolicy {
  Hashed,
  GeoLatency,
  Static,
}

/**
 * Rights that this key has.
 */
enum AccessRightsDescription {
  ServiceConfig,
  EnrollmentRead,
  EnrollmentWrite,
  DeviceConnect,
  RegistrationStatusRead,
  RegistrationStatusWrite,
}

/**
 * Sku name.
 */
enum IotDpsSku {
  S1,
}

/**
 * specifies the reason a name is unavailable
 */
enum NameUnavailabilityReason {
  Invalid,
  AlreadyExists,
}

/**
 * The desired action for requests captured by this rule.
 */
@fixed
enum IpFilterActionType {
  Accept,
  Reject,
}

/**
 * Target for requests captured by this rule.
 */
@fixed
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
  @visibility("read")
  code?: string;

  /**
   * The HTTP status code.
   */
  @visibility("read")
  httpStatusCode?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: string;
}

/**
 * The description of an X509 CA Certificate.
 */
model CertificateProperties {
  /**
   * The certificate's subject name.
   */
  @visibility("read")
  subject?: string;

  /**
   * The certificate's expiration date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The certificate's thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Determines whether certificate has been verified.
   */
  isVerified?: boolean;

  /**
   * base-64 representation of X509 certificate .cer file or just .pem file content.
   */
  certificate?: string;

  /**
   * The certificate's creation date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The certificate's last update date and time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
  ipFilterRules?: IpFilterRule[];

  /**
   * Private endpoint connections created on this IotHub
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The ARM provisioning state of the provisioning service.
   */
  provisioningState?: string;

  /**
   * List of IoT hubs associated with this provisioning service.
   */
  iotHubs?: IotHubDefinitionDescription[];

  /**
   * Allocation policy to be used by this provisioning service.
   */
  allocationPolicy?: AllocationPolicy;

  /**
   * Service endpoint for provisioning service.
   */
  @visibility("read")
  serviceOperationsHostName?: string;

  /**
   * Device endpoint for this provisioning service.
   */
  @visibility("read")
  deviceProvisioningHostName?: string;

  /**
   * Unique identifier of this provisioning service.
   */
  @visibility("read")
  idScope?: string;

  /**
   * List of authorization keys for a provisioning service.
   */
  authorizationPolicies?: SharedAccessSignatureAuthorizationRuleAccessRightsDescription[];

  /**
   * Optional.
   * Indicates if the DPS instance has Data Residency enabled, removing the cross geo-pair disaster recovery.
   */
  enableDataResidency?: boolean;
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  tier?: string;

  /**
   * The number of units to provision
   */
  capacity?: int64;
}

/**
 * The common properties of an Azure resource.
 */
model Resource {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The resource location.
   */
  location: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a Provisioning Service instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  tags?: Record<string>;
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
  @visibility("read")
  name?: string;

  /**
   * Request etag.
   */
  @visibility("read")
  etag?: string;

  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  properties?: VerificationCodeResponseProperties;
}

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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

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
  certificate?: string;

  /**
   * Certificate created time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Certificate updated time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;
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
 * The properties for a group information object
 */
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
