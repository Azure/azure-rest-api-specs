import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.HealthBot;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
model UserAssignedIdentityMap is Record<UserAssignedIdentity>;
/**
 * The type of identity that creates/modifies resources
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The name of the Azure Health Bot SKU
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SkuName {
  F0,
  S1,
  C0,
  PES,
  C1,
}

/**
 * The identity type. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the Azure Health Bot
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
  userAssignedIdentities?: UserAssignedIdentityMap;
}

/**
 * The properties of a Azure Health Bot. The Health Bot Service is a cloud platform that empowers developers in Healthcare organizations to build and deploy their compliant, AI-powered virtual health assistants and health bots, that help them improve processes and reduce costs.
 */
model HealthBotProperties {
  /**
   * The provisioning state of the Azure Health Bot resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * The resource management error response.
 */
@error
model Error {
  /**
   * The error object.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" ""
  error?: ErrorDetail;
}

/**
 * The error object detail.
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: Error[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * Additional information about an error.
 */
model ErrorAdditionalInfo {
  /**
   * The type of the additional error information.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional error information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
  @visibility(Lifecycle.Read)
  info?: {};
}

/**
 * Represents a user-assigned identity.
 */
model UserAssignedIdentity {
  /**
   * The principal ID of the user-assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of the user-assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  value?: string;
}

/**
 * The list of Azure Health Bot operation response.
 */
model BotResponseList is Azure.Core.Page<HealthBot>;

/**
 * Available operations of the service.
 */
@pagedResult
model AvailableOperations {
  /**
   * Collection of available operation details.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  @items
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
  properties?: {};
}

/**
 * Localized display information for and operation.
 */
model OperationDisplay {
  /** 
  The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  provider?: string;

  /** 
    The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
     */
  resource?: string;

  /** 
    The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
     */
  operation?: string;

  /** The short, localized friendly description of the operation; suitable for tool tips and detailed views. */
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
