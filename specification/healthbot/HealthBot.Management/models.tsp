import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Versioning;

namespace Microsoft.HealthBot;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UserAssignedIdentityMap is Record<UserAssignedIdentity>;
/**
 * The type of identity that creates/modifies resources
 */
union IdentityType {
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
 * The name of the Azure Health Bot SKU
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SkuName {
  F0,

  @removed(Versions.v2025_11_01)
  S1,

  C0,
  PES,
  C1,
}

/**
 * The identity type. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the Azure Health Bot
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The details of the user assigned managed identity used by the Video Analyzer resource.
 */
model UserAssignedIdentity {
  /**
   * The principal ID of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The properties of a Azure Health Bot. The Health Bot Service is a cloud platform that empowers developers in Healthcare organizations to build and deploy their compliant, AI-powered virtual health assistants and health bots, that help them improve processes and reduce costs.
 */
model HealthBotProperties {
  /**
   * The provisioning state of the Azure Health Bot resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The link.
   */
  @visibility(Lifecycle.Read)
  botManagementPortalLink?: string;

  /**
   * KeyVault properties for the resource encryption.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * The access control method for the Azure Health Bot resource.
   */
  @visibility(Lifecycle.Read)
  accessControlMethod?: string;
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TrackedResource extends Resource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;
}

/**
 * The resource model definition for a ARM tracked top level resource
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Read only system data
 */
model SystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource
   */
  createdByType?: IdentityType;

  /**
   * The timestamp of resource creation (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource
   */
  lastModifiedByType?: IdentityType;

  /**
   * The timestamp of resource last modification (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * The resource management error response.
 */
@error
model Error {
  /**
   * The error object.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  error?: ErrorDetail;
}
/**
 * The error object.
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
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: Error[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * SKU of the Azure Health Bot.
   */
  sku?: Sku;

  /**
   * The identity of the Azure Health Bot.
   */
  identity?: Identity;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * Health Bot Keys Response.
 */
model HealthBotKeysResponse {
  /**
   * Array of Azure Health Bot Secrets.
   */
  @identifiers(#[])
  secrets?: HealthBotKey[];
}

/**
 * An entry of HealthBotKeysResponse
 */
model HealthBotKey {
  /**
   * The name of the key.
   */
  keyName?: string;

  /**
   * The value of the key.
   */
  @secret
  value?: string;
}

/**
 * The list of Azure Health Bot operation response.
 */
model BotResponseList is Azure.Core.Page<HealthBot>;

/**
 * Available operations of the service.
 */
model AvailableOperations {
  /**
   * Collection of available operation details.
   */
  @identifiers(#[])
  @pageItems
  value: OperationDetail[];

  /**
   * URL client should use to fetch the next page (per server side paging).
   * It's null for now, added for future use.
   */
  @nextLink
  nextLink?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  provider?: string;

  /**
   * Resource of the operation
   */
  resource?: string;

  /**
   * Localized friendly name for the operation
   */
  operation?: string;

  /**
   * Localized friendly description for the operation
   */
  description?: string;
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
