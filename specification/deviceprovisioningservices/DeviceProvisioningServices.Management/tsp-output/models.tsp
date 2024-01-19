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

@doc("Current state of the provisioning service.")
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

@doc("Whether requests from Public Network are allowed")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("The status of a private endpoint connection")
enum PrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("Allocation policy to be used by this provisioning service.")
enum AllocationPolicy {
  Hashed,
  GeoLatency,
  Static,
}

@doc("Rights that this key has.")
enum AccessRightsDescription {
  ServiceConfig,
  EnrollmentRead,
  EnrollmentWrite,
  DeviceConnect,
  RegistrationStatusRead,
  RegistrationStatusWrite,
}

@doc("Sku name.")
enum IotDpsSku {
  S1,
}

@doc("specifies the reason a name is unavailable")
enum NameUnavailabilityReason {
  Invalid,
  AlreadyExists,
}

@doc("The desired action for requests captured by this rule.")
@fixed
enum IpFilterActionType {
  Accept,
  Reject,
}

@doc("Target for requests captured by this rule.")
@fixed
enum IpFilterTargetType {
  all,
  serviceApi,
  deviceApi,
}

@doc("Error details.")
@error
model ErrorDetails {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The HTTP status code.")
  @visibility("read")
  httpStatusCode?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error details.")
  @visibility("read")
  details?: string;
}

@doc("The description of an X509 CA Certificate.")
model CertificateProperties {
  @doc("The certificate's subject name.")
  @visibility("read")
  subject?: string;

  @doc("The certificate's expiration date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  @doc("The certificate's thumbprint.")
  @visibility("read")
  thumbprint?: string;

  @doc("Determines whether certificate has been verified.")
  isVerified?: boolean;

  @doc("base-64 representation of X509 certificate .cer file or just .pem file content.")
  certificate?: string;

  @doc("The certificate's creation date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The certificate's last update date and time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;
}

@doc("the service specific properties of a provisioning service, including keys, linked iot hubs, current state, and system generated properties such as hostname and idScope")
model IotDpsPropertiesDescription {
  @doc("Current state of the provisioning service.")
  state?: State;

  @doc("Whether requests from Public Network are allowed")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The IP filter rules.")
  ipFilterRules?: IpFilterRule[];

  @doc("Private endpoint connections created on this IotHub")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("The ARM provisioning state of the provisioning service.")
  provisioningState?: string;

  @doc("List of IoT hubs associated with this provisioning service.")
  iotHubs?: IotHubDefinitionDescription[];

  @doc("Allocation policy to be used by this provisioning service.")
  allocationPolicy?: AllocationPolicy;

  @doc("Service endpoint for provisioning service.")
  @visibility("read")
  serviceOperationsHostName?: string;

  @doc("Device endpoint for this provisioning service.")
  @visibility("read")
  deviceProvisioningHostName?: string;

  @doc("Unique identifier of this provisioning service.")
  @visibility("read")
  idScope?: string;

  @doc("List of authorization keys for a provisioning service.")
  authorizationPolicies?: SharedAccessSignatureAuthorizationRuleAccessRightsDescription[];

  @doc("""
Optional.
Indicates if the DPS instance has Data Residency enabled, removing the cross geo-pair disaster recovery.
""")
  enableDataResidency?: boolean;
}

@doc("The IP filter rules for a provisioning Service.")
model IpFilterRule {
  @doc("The name of the IP filter rule.")
  filterName: string;

  @doc("The desired action for requests captured by this rule.")
  action: IpFilterActionType;

  @doc("A string that contains the IP address range in CIDR notation for the rule.")
  ipMask: string;

  @doc("Target for requests captured by this rule.")
  target?: IpFilterTargetType;
}

@doc("The properties of a private endpoint connection")
model PrivateEndpointConnectionProperties {
  @doc("The private endpoint property of a private endpoint connection")
  privateEndpoint?: PrivateEndpoint;

  @doc("The current state of a private endpoint connection")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;
}

@doc("The private endpoint property of a private endpoint connection")
model PrivateEndpoint {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;
}

@doc("The current state of a private endpoint connection")
model PrivateLinkServiceConnectionState {
  @doc("The status of a private endpoint connection")
  status: PrivateLinkServiceConnectionStatus;

  @doc("The description for the current state of a private endpoint connection")
  description: string;

  @doc("Actions required for a private endpoint connection")
  actionsRequired?: string;
}

@doc("Description of the IoT hub.")
model IotHubDefinitionDescription {
  @doc("flag for applying allocationPolicy or not for a given iot hub.")
  applyAllocationPolicy?: boolean;

  @doc("weight to apply for a given iot h.")
  allocationWeight?: int32;

  @doc("Host name of the IoT hub.")
  @visibility("read")
  name?: string;

  @doc("Connection string of the IoT hub.")
  connectionString: string;

  @doc("ARM region of the IoT hub.")
  location: string;
}

@doc("Description of the shared access key.")
model SharedAccessSignatureAuthorizationRuleAccessRightsDescription {
  @doc("Name of the key.")
  keyName: string;

  @doc("Primary SAS key value.")
  primaryKey?: string;

  @doc("Secondary SAS key value.")
  secondaryKey?: string;

  @doc("Rights that this key has.")
  rights: AccessRightsDescription;
}

@doc("List of possible provisioning service SKUs.")
model IotDpsSkuInfo {
  @doc("Sku name.")
  name?: IotDpsSku;

  @doc("Pricing tier name of the provisioning service.")
  @visibility("read")
  tier?: string;

  @doc("The number of units to provision")
  capacity?: int32;
}

@doc("The common properties of an Azure resource.")
model Resource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("The resource location.")
  location: string;

  @doc("The resource tags.")
  tags?: Record<string>;
}

@doc("A container holding only the Tags for a resource, allowing the user to update the tags on a Provisioning Service instance.")
model TagsResource {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("List of available SKUs.")
model IotDpsSkuDefinitionListResult is Azure.Core.Page<IotDpsSkuDefinition>;

@doc("Available SKUs of tier and units.")
model IotDpsSkuDefinition {
  @doc("Sku name.")
  name?: IotDpsSku;
}

@doc("Description of the response of the verification code.")
model VerificationCodeResponse {
  @doc("Name of certificate.")
  @visibility("read")
  name?: string;

  @doc("Request etag.")
  @visibility("read")
  etag?: string;

  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  properties?: VerificationCodeResponseProperties;
}

model VerificationCodeResponseProperties {
  @doc("Verification code.")
  verificationCode?: string;

  @doc("Certificate subject.")
  subject?: string;

  @doc("Code expiry.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  @doc("Certificate thumbprint.")
  thumbprint?: string;

  @doc("Indicate if the certificate is verified by owner of private key.")
  isVerified?: boolean;

  @doc("base-64 representation of X509 certificate .cer file or just .pem file content.")
  certificate?: string;

  @doc("Certificate created time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("Certificate updated time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updated?: utcDateTime;
}

@doc("The JSON-serialized leaf certificate")
model VerificationCodeRequest {
  @doc("base-64 representation of X509 certificate .cer file or just .pem file content.")
  certificate?: string;
}

@doc("Input values for operation results call.")
model OperationInputs {
  @doc("The name of the Provisioning Service to check.")
  name: string;
}

@doc("Description of name availability.")
model NameAvailabilityInfo {
  @doc("specifies if a name is available or not")
  nameAvailable?: boolean;

  @doc("specifies the reason a name is unavailable")
  reason?: NameUnavailabilityReason;

  @doc("message containing a detailed reason name is unavailable")
  message?: string;
}

@doc("List of shared access keys.")
model SharedAccessSignatureAuthorizationRuleListResult
  is Azure.Core.Page<SharedAccessSignatureAuthorizationRuleAccessRightsDescription>;

@doc("The properties for a group information object")
model GroupIdInformationProperties {
  @doc("The group id")
  groupId?: string;

  @doc("The required members for a specific group id")
  requiredMembers?: string[];

  @doc("The required DNS zones for a specific group id")
  requiredZoneNames?: string[];
}

@doc("Result of a long running operation.")
model AsyncOperationResult {
  @doc("current status of a long running operation.")
  status?: string;

  @doc("Error message containing code, description and details")
  error?: ErrorMessage;
}

@doc("Error response containing message and code.")
model ErrorMessage {
  @doc("standard error code")
  code?: string;

  @doc("standard error description")
  message?: string;

  @doc("detailed summary of error")
  details?: string;
}

@doc("The JSON-serialized X509 Certificate.")
model CertificateBodyDescription {
  @doc("Base-64 representation of the X509 leaf certificate .cer file or just .pem file content.")
  certificate?: string;

  @doc("True indicates that the certificate will be created in verified state and proof of possession will not be required.")
  isVerified?: boolean;
}
