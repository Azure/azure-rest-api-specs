import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ServiceLinkerManagementClient;

enum TargetServiceType {
  AzureResource,
  ConfluentBootstrapServer,
  ConfluentSchemaRegistry,
}

enum AuthType {
  systemAssignedIdentity,
  userAssignedIdentity,
  servicePrincipalSecret,
  servicePrincipalCertificate,
  secret,
}

enum ClientType {
  none,
  dotnet,
  java,
  python,
  go,
  php,
  ruby,
  django,
  nodejs,
  springBoot,
}

enum VNetSolutionType {
  serviceEndpoint,
  privateLink,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum ValidationResultStatus {
  success,
  failure,
  warning,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum AzureResourceType {
  KeyVault,
}

enum SecretType {
  rawValue,
  keyVaultSecretUri,
  keyVaultSecretReference,
}

@doc("The list of Linker.")
model LinkerList is Azure.Core.Page<LinkerResource>;

@doc("Linker of source and target resource")
model LinkerResource {
  ...ProxyResource;

  @doc("The properties of the linker.")
  properties: LinkerProperties;

  @doc("The system data.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The properties of the linker.")
model LinkerProperties {
  @doc("The target service properties")
  targetService?: TargetServiceBase;

  @doc("The authentication type.")
  authInfo?: AuthInfoBase;

  @doc("The application client type")
  clientType?: ClientType;

  @doc("The provisioning state. ")
  @visibility("read")
  provisioningState?: string;

  @doc("The VNet solution.")
  vNetSolution?: VNetSolution;

  @doc("An option to store secret value in secure place")
  secretStore?: SecretStore;

  @doc("connection scope in source service.")
  scope?: string;
}

@doc("The target service properties")
@discriminator("type")
model TargetServiceBase {}

@doc("The authentication info")
@discriminator("authType")
model AuthInfoBase {}

@doc("The VNet solution for linker")
model VNetSolution {
  @doc("Type of VNet solution.")
  type?: VNetSolutionType;
}

@doc("An option to store secret value in secure place")
model SecretStore {
  @doc("The key vault id to store secret")
  keyVaultId?: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
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

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("A linker to be updated.")
model LinkerPatch {
  @doc("Linker properties")
  properties?: LinkerProperties;
}

@doc("The validation operation result for a linker.")
model ValidateOperationResult {
  @doc("The validation result detail.")
  properties?: ValidateResult;

  @doc("Validated linker id.")
  resourceId?: string;

  @doc("Validation operation status.")
  status?: string;
}

@doc("The validation result for a linker.")
model ValidateResult {
  @doc("The linker name.")
  linkerName?: string;

  @doc("A boolean value indicating whether the connection is available or not")
  isConnectionAvailable?: boolean;

  @doc("The start time of the validation report.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reportStartTimeUtc?: utcDateTime;

  @doc("The end time of the validation report.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reportEndTimeUtc?: utcDateTime;

  @doc("The resource id of the linker source application.")
  sourceId?: string;

  @doc("The resource Id of target service.")
  targetId?: string;

  @doc("The authentication type.")
  authType?: AuthType;

  @doc("The detail of validation result")
  validationDetail?: ValidationResultItem[];
}

@doc("The validation item for a linker.")
model ValidationResultItem {
  @doc("The validation item name.")
  name?: string;

  @doc("The display name of validation item")
  description?: string;

  @doc("The result of validation")
  result?: ValidationResultStatus;

  @doc("The error message of validation result")
  errorMessage?: string;

  @doc("The error code of validation result")
  errorCode?: string;
}

@doc("""
Configurations for source resource, include appSettings, connectionString and
serviceBindings
""")
model SourceConfigurationResult {
  @doc("The configuration properties for source resource.")
  configurations?: SourceConfiguration[];
}

@doc("A configuration item for source resource")
model SourceConfiguration {
  @doc("The name of setting.")
  name?: string;

  @doc("The value of setting")
  value?: string;
}

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}

@doc("The azure resource properties")
@discriminator("type")
model AzureResourcePropertiesBase {}

@doc("The azure resource info when target service type is AzureResource")
model AzureResource extends TargetServiceBase {
  @doc("The Id of azure resource.")
  id?: string;

  @doc("The azure resource connection related properties.")
  resourceProperties?: AzureResourcePropertiesBase;

  @doc("The target service type.")
  type: "AzureResource";
}

@doc("The resource properties when type is Azure Key Vault")
model AzureKeyVaultProperties extends AzureResourcePropertiesBase {
  @doc("True if connect via Kubernetes CSI Driver.")
  connectAsKubernetesCsiDriver?: boolean;

  @doc("The azure resource type.")
  type: "KeyVault";
}

@doc("The service properties when target service type is ConfluentBootstrapServer")
model ConfluentBootstrapServer extends TargetServiceBase {
  @doc("The endpoint of service.")
  endpoint?: string;

  @doc("The target service type.")
  type: "ConfluentBootstrapServer";
}

@doc("The service properties when target service type is ConfluentSchemaRegistry")
model ConfluentSchemaRegistry extends TargetServiceBase {
  @doc("The endpoint of service.")
  endpoint?: string;

  @doc("The target service type.")
  type: "ConfluentSchemaRegistry";
}

@doc("The secret info")
@discriminator("secretType")
model SecretInfoBase {}

@doc("""
The secret info when type is rawValue. It's for scenarios that user input the
secret.
""")
model ValueSecretInfo extends SecretInfoBase {
  @doc("The actual value of the secret.")
  value?: string;

  @doc("The secret type.")
  secretType: "rawValue";
}

@doc("""
The secret info when type is keyVaultSecretReference. It's for scenario that
user provides a secret stored in user's keyvault and source is Azure
Kubernetes. The key Vault's resource id is linked to secretStore.keyVaultId.
""")
model KeyVaultSecretReferenceSecretInfo extends SecretInfoBase {
  @doc("Name of the Key Vault secret.")
  name?: string;

  @doc("Version of the Key Vault secret.")
  version?: string;

  @doc("The secret type.")
  secretType: "keyVaultSecretReference";
}

@doc("""
The secret info when type is keyVaultSecretUri. It's for scenario that user
provides a secret stored in user's keyvault and source is Web App, Spring Cloud
or Container App.
""")
model KeyVaultSecretUriSecretInfo extends SecretInfoBase {
  @doc("URI to the keyvault secret")
  value?: string;

  @doc("The secret type.")
  secretType: "keyVaultSecretUri";
}

@doc("The authentication info when authType is secret")
model SecretAuthInfo extends AuthInfoBase {
  @doc("Username or account name for secret auth.")
  name?: string;

  @doc("Password or key vault secret for secret auth.")
  secretInfo?: SecretInfoBase;

  @doc("The authentication type.")
  authType: "secret";
}

@doc("The authentication info when authType is userAssignedIdentity")
model UserAssignedIdentityAuthInfo extends AuthInfoBase {
  @doc("Client Id for userAssignedIdentity.")
  clientId?: string;

  @doc("Subscription id for userAssignedIdentity.")
  subscriptionId?: string;

  @doc("The authentication type.")
  authType: "userAssignedIdentity";
}

@doc("The authentication info when authType is systemAssignedIdentity")
model SystemAssignedIdentityAuthInfo extends AuthInfoBase {
  @doc("The authentication type.")
  authType: "systemAssignedIdentity";
}

@doc("The authentication info when authType is servicePrincipal secret")
model ServicePrincipalSecretAuthInfo extends AuthInfoBase {
  @doc("ServicePrincipal application clientId for servicePrincipal auth.")
  clientId: string;

  @doc("Principal Id for servicePrincipal auth.")
  principalId: string;

  @doc("Secret for servicePrincipal auth.")
  secret: string;

  @doc("The authentication type.")
  authType: "servicePrincipalSecret";
}

@doc("The authentication info when authType is servicePrincipal certificate")
model ServicePrincipalCertificateAuthInfo extends AuthInfoBase {
  @doc("Application clientId for servicePrincipal auth.")
  clientId: string;

  @doc("Principal Id for servicePrincipal auth.")
  principalId: string;

  @doc("ServicePrincipal certificate for servicePrincipal auth.")
  certificate: string;

  @doc("The authentication type.")
  authType: "servicePrincipalCertificate";
}
