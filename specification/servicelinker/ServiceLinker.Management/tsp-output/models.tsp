import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceLinker;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The target service type.
 */
enum TargetServiceType {
  AzureResource,
  ConfluentBootstrapServer,
  ConfluentSchemaRegistry,
}

/**
 * The authentication type.
 */
enum AuthType {
  systemAssignedIdentity,
  userAssignedIdentity,
  servicePrincipalSecret,
  servicePrincipalCertificate,
  secret,
}

/**
 * The application client type
 */
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

/**
 * Type of VNet solution.
 */
enum VNetSolutionType {
  serviceEndpoint,
  privateLink,
}

/**
 * The result of validation
 */
enum ValidationResultStatus {
  success,
  failure,
  warning,
}

/**
 * The azure resource type.
 */
enum AzureResourceType {
  KeyVault,
}

/**
 * The secret type.
 */
enum SecretType {
  rawValue,
  keyVaultSecretUri,
  keyVaultSecretReference,
}

/**
 * The properties of the linker.
 */
model LinkerProperties {
  /**
   * The target service properties
   */
  targetService?: TargetServiceBase;

  /**
   * The authentication type.
   */
  authInfo?: AuthInfoBase;

  /**
   * The application client type
   */
  clientType?: ClientType;

  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The VNet solution.
   */
  vNetSolution?: VNetSolution;

  /**
   * An option to store secret value in secure place
   */
  secretStore?: SecretStore;

  /**
   * connection scope in source service.
   */
  scope?: string;
}

/**
 * The target service properties
 */
@discriminator("type")
model TargetServiceBase {}

/**
 * The authentication info
 */
@discriminator("authType")
model AuthInfoBase {}

/**
 * The VNet solution for linker
 */
model VNetSolution {
  /**
   * Type of VNet solution.
   */
  type?: VNetSolutionType;
}

/**
 * An option to store secret value in secure place
 */
model SecretStore {
  /**
   * The key vault id to store secret
   */
  keyVaultId?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * A linker to be updated.
 */
model LinkerPatch {
  /**
   * Linker properties
   */
  properties?: LinkerProperties;
}

/**
 * The validation operation result for a linker.
 */
model ValidateOperationResult {
  /**
   * The validation result detail.
   */
  properties?: ValidateResult;

  /**
   * Validated linker id.
   */
  resourceId?: string;

  /**
   * Validation operation status.
   */
  status?: string;
}

/**
 * The validation result for a linker.
 */
model ValidateResult {
  /**
   * The linker name.
   */
  linkerName?: string;

  /**
   * A boolean value indicating whether the connection is available or not
   */
  isConnectionAvailable?: boolean;

  /**
   * The start time of the validation report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reportStartTimeUtc?: utcDateTime;

  /**
   * The end time of the validation report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reportEndTimeUtc?: utcDateTime;

  /**
   * The resource id of the linker source application.
   */
  sourceId?: string;

  /**
   * The resource Id of target service.
   */
  targetId?: string;

  /**
   * The authentication type.
   */
  authType?: AuthType;

  /**
   * The detail of validation result
   */
  validationDetail?: ValidationResultItem[];
}

/**
 * The validation item for a linker.
 */
model ValidationResultItem {
  /**
   * The validation item name.
   */
  name?: string;

  /**
   * The display name of validation item
   */
  description?: string;

  /**
   * The result of validation
   */
  result?: ValidationResultStatus;

  /**
   * The error message of validation result
   */
  errorMessage?: string;

  /**
   * The error code of validation result
   */
  errorCode?: string;
}

/**
 * Configurations for source resource, include appSettings, connectionString and serviceBindings
 */
model SourceConfigurationResult {
  /**
   * The configuration properties for source resource.
   */
  configurations?: SourceConfiguration[];
}

/**
 * A configuration item for source resource
 */
model SourceConfiguration {
  /**
   * The name of setting.
   */
  name?: string;

  /**
   * The value of setting
   */
  value?: string;
}

/**
 * The azure resource properties
 */
@discriminator("type")
model AzureResourcePropertiesBase {}

/**
 * The azure resource info when target service type is AzureResource
 */
model AzureResource extends TargetServiceBase {
  /**
   * The Id of azure resource.
   */
  id?: string;

  /**
   * The azure resource connection related properties.
   */
  resourceProperties?: AzureResourcePropertiesBase;

  /**
   * The target service type.
   */
  type: "AzureResource";
}

/**
 * The resource properties when type is Azure Key Vault
 */
model AzureKeyVaultProperties extends AzureResourcePropertiesBase {
  /**
   * True if connect via Kubernetes CSI Driver.
   */
  connectAsKubernetesCsiDriver?: boolean;

  /**
   * The azure resource type.
   */
  type: "KeyVault";
}

/**
 * The service properties when target service type is ConfluentBootstrapServer
 */
model ConfluentBootstrapServer extends TargetServiceBase {
  /**
   * The endpoint of service.
   */
  endpoint?: string;

  /**
   * The target service type.
   */
  type: "ConfluentBootstrapServer";
}

/**
 * The service properties when target service type is ConfluentSchemaRegistry
 */
model ConfluentSchemaRegistry extends TargetServiceBase {
  /**
   * The endpoint of service.
   */
  endpoint?: string;

  /**
   * The target service type.
   */
  type: "ConfluentSchemaRegistry";
}

/**
 * The secret info
 */
@discriminator("secretType")
model SecretInfoBase {}

/**
 * The secret info when type is rawValue. It's for scenarios that user input the secret.
 */
model ValueSecretInfo extends SecretInfoBase {
  /**
   * The actual value of the secret.
   */
  value?: string;

  /**
   * The secret type.
   */
  secretType: "rawValue";
}

/**
 * The secret info when type is keyVaultSecretReference. It's for scenario that user provides a secret stored in user's keyvault and source is Azure Kubernetes. The key Vault's resource id is linked to secretStore.keyVaultId.
 */
model KeyVaultSecretReferenceSecretInfo extends SecretInfoBase {
  /**
   * Name of the Key Vault secret.
   */
  name?: string;

  /**
   * Version of the Key Vault secret.
   */
  version?: string;

  /**
   * The secret type.
   */
  secretType: "keyVaultSecretReference";
}

/**
 * The secret info when type is keyVaultSecretUri. It's for scenario that user provides a secret stored in user's keyvault and source is Web App, Spring Cloud or Container App.
 */
model KeyVaultSecretUriSecretInfo extends SecretInfoBase {
  /**
   * URI to the keyvault secret
   */
  value?: string;

  /**
   * The secret type.
   */
  secretType: "keyVaultSecretUri";
}

/**
 * The authentication info when authType is secret
 */
model SecretAuthInfo extends AuthInfoBase {
  /**
   * Username or account name for secret auth.
   */
  name?: string;

  /**
   * Password or key vault secret for secret auth.
   */
  secretInfo?: SecretInfoBase;

  /**
   * The authentication type.
   */
  authType: "secret";
}

/**
 * The authentication info when authType is userAssignedIdentity
 */
model UserAssignedIdentityAuthInfo extends AuthInfoBase {
  /**
   * Client Id for userAssignedIdentity.
   */
  clientId?: string;

  /**
   * Subscription id for userAssignedIdentity.
   */
  subscriptionId?: string;

  /**
   * The authentication type.
   */
  authType: "userAssignedIdentity";
}

/**
 * The authentication info when authType is systemAssignedIdentity
 */
model SystemAssignedIdentityAuthInfo extends AuthInfoBase {
  /**
   * The authentication type.
   */
  authType: "systemAssignedIdentity";
}

/**
 * The authentication info when authType is servicePrincipal secret
 */
model ServicePrincipalSecretAuthInfo extends AuthInfoBase {
  /**
   * ServicePrincipal application clientId for servicePrincipal auth.
   */
  clientId: string;

  /**
   * Principal Id for servicePrincipal auth.
   */
  principalId: string;

  /**
   * Secret for servicePrincipal auth.
   */
  secret: string;

  /**
   * The authentication type.
   */
  authType: "servicePrincipalSecret";
}

/**
 * The authentication info when authType is servicePrincipal certificate
 */
model ServicePrincipalCertificateAuthInfo extends AuthInfoBase {
  /**
   * Application clientId for servicePrincipal auth.
   */
  clientId: string;

  /**
   * Principal Id for servicePrincipal auth.
   */
  principalId: string;

  /**
   * ServicePrincipal certificate for servicePrincipal auth.
   */
  certificate: string;

  /**
   * The authentication type.
   */
  authType: "servicePrincipalCertificate";
}
