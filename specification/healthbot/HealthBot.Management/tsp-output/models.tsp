import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HealthBot;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The type of identity that creates/modifies resources
 */
enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * The name of the Azure Health Bot SKU
 */
@fixed
enum SkuName {
  F0,
  S1,
  C0,
}

/**
 * The identity type. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the Azure Health Bot
 */
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the Azure Health Bot SKU
   */
  name: SkuName;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the Azure Health Bot
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   *
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The details of the user assigned managed identity used by the Video Analyzer resource.
 */
model UserAssignedIdentity {
  /**
   * The principal ID of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client ID of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The properties of a Azure Health Bot. The Health Bot Service is a cloud platform that empowers developers in Healthcare organizations to build and deploy their compliant, AI-powered virtual health assistants and health bots, that help them improve processes and reduce costs.
 */
model HealthBotProperties {
  /**
   * The provisioning state of the Azure Health Bot resource.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The link.
   */
  @visibility("read")
  botManagementPortalLink?: string;

  /**
   * KeyVault properties for the resource encryption.
   */
  keyVaultProperties?: KeyVaultProperties;
}

/**
 * Properties of the key vault.
 */
model KeyVaultProperties {
  /**
   * The name of the key vault key.
   */
  keyName: string;

  /**
   * The version of the key vault key.
   */
  keyVersion?: string;

  /**
   * The Uri of the key vault.
   */
  keyVaultUri: string;

  /**
   * The user assigned identity (ARM resource id) that has access to the key.
   */
  userIdentity?: string;
}

/**
 * The resource model definition for a ARM tracked top level resource
 */
model TrackedResource extends Resource {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility("read", "create")
  location: string;
}

/**
 * The resource model definition for a ARM tracked top level resource
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The resource management error response.
 */
@error
model Error {
  /**
   * The error object.
   */
  error?: ErrorError;
}

/**
 * The error object.
 */
model ErrorError {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: Error[];

  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * Parameters for updating a Azure Health Bot.
 */
model HealthBotUpdateParameters {
  /**
   * Properties of Azure Health Bot.
   */
  properties?: HealthBotProperties;

  /**
   * Tags for a Azure Health Bot.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * SKU of the Azure Health Bot.
   */
  sku?: Sku;

  /**
   * The identity of the Azure Health Bot.
   */
  identity?: Identity;

  @visibility("read", "create")
  location?: string;
}

/**
 * Operation detail payload
 */
model OperationDetail {
  /**
   * Name of the operation
   */
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
   * Additional properties.
   */
  properties?: Record<unknown>;
}

/**
 * The response returned from validation process
 */
model ValidationResult {
  /**
   * The status code of the response validation.
   */
  status?: string;
}
