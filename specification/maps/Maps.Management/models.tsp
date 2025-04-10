import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Maps;

/**
 * The name of the SKU, in standard format (such as G2).
 */
union Name {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  G2: "G2",
}

/**
 * The Kind of the Maps Account.
 */
union Kind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Gen2: "Gen2",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * (Optional) Discouraged to include in resource definition. Only needed where it is possible to disable platform (AKA infrastructure) encryption. Azure SQL TDE is an example of this. Values are enabled and disabled.
 */
union InfrastructureEncryption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  disabled: "disabled",
}

/**
 * The type of identity to use. Values can be systemAssignedIdentity, userAssignedIdentity, or delegatedResourceIdentity.
 */
union EncryptionCustomerManagedKeyEncryptionKeyEncryptionKeyIdentityIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  systemAssignedIdentity: "systemAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  userAssignedIdentity: "userAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  delegatedResourceIdentity: "delegatedResourceIdentity",
}

/**
 * The Maps account key to use for signing. Picking `primaryKey` or `secondaryKey` will use the Maps account Shared Keys, and using `managedIdentity` will use the auto-renewed private key to sign the SAS.
 */
union SigningKey {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  primaryKey: "primaryKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  secondaryKey: "secondaryKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  managedIdentity: "managedIdentity",
}

/**
 * Whether the operation refers to the primary or secondary key.
 */
union KeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  primary: "primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  secondary: "secondary",
}

/**
 * The SKU of the Maps Account.
 */
model Sku {
  /**
   * The name of the SKU, in standard format (such as G2).
   */
  name: Name;

  /**
   * Gets the sku tier. This is based on the SKU name.
   */
  @visibility(Lifecycle.Read)
  tier?: string;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Additional Maps account properties
 */
model MapsAccountProperties {
  /**
   * A unique identifier for the Maps Account
   */
  @visibility(Lifecycle.Read)
  uniqueId?: string;

  /**
   * Allows toggle functionality on Azure Policy to disable Azure Maps local authentication support. This will disable Shared Keys and Shared Access Signature Token authentication from any usage.
   */
  disableLocalAuth?: boolean;

  /**
   * The provisioning state of the Maps account resource, Account updates can only be performed on terminal states. Terminal states: `Succeeded` and `Failed`
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The array of associated resources to the Maps account. Linked resource in the array cannot individually update, you must update all linked resources in the array together. These resources may be used on operations on the Azure Maps REST API. Access is controlled by the Maps Account Managed Identity(s) permissions to those resource(s).
   */
  linkedResources?: LinkedResource[];

  /**
   * Specifies CORS rules for the Blob service. You can include up to five CorsRule elements in the request. If no CorsRule elements are included in the request body, all CORS rules will be deleted, and CORS will be disabled for the Blob service.
   */
  cors?: CorsRules;

  /**
   * All encryption configuration for a resource.
   */
  encryption?: Encryption;

  /**
   * List of additional data processing regions for the Maps Account, which may result in requests being processed in another geography. Some features or results may be restricted to specific regions. By default, Maps REST APIs process requests according to the account location or the [geographic scope](https://learn.microsoft.com/azure/azure-maps/geographic-scope).
   */
  locations?: LocationsItem[];
}

/**
 * Linked resource is reference to a resource deployed in an Azure subscription, add the linked resource `uniqueName` value as an optional parameter for operations on Azure Maps Geospatial REST APIs.
 */
model LinkedResource {
  /**
   * A provided name which uniquely identifies the linked resource.
   */
  uniqueName: string;

  /**
   * ARM resource id in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/accounts/{storageName}'.
   */
  id: string;
}

/**
 * Sets the CORS rules. You can include up to five CorsRule elements in the request.
 */
model CorsRules {
  /**
   * The list of CORS rules. You can include up to five CorsRule elements in the request.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  corsRules?: CorsRule[];
}

/**
 * Specifies a CORS rule for the Map Account.
 */
model CorsRule {
  /**
   * Required if CorsRule element is present. A list of origin domains that will be allowed via CORS, or "*" to allow all domains
   */
  allowedOrigins: string[];
}

/**
 * All encryption configuration for a resource.
 */
model Encryption {
  /**
   * (Optional) Discouraged to include in resource definition. Only needed where it is possible to disable platform (AKA infrastructure) encryption. Azure SQL TDE is an example of this. Values are enabled and disabled.
   */
  infrastructureEncryption?: InfrastructureEncryption;

  /**
   * All Customer-managed key encryption properties for the resource.
   */
  customerManagedKeyEncryption?: EncryptionCustomerManagedKeyEncryption;
}

/**
 * All Customer-managed key encryption properties for the resource.
 */
model EncryptionCustomerManagedKeyEncryption {
  /**
   * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
   */
  keyEncryptionKeyIdentity?: EncryptionCustomerManagedKeyEncryptionKeyEncryptionKeyIdentity;

  /**
   * key encryption key Url, versioned or unversioned. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek.
   */
  keyEncryptionKeyUrl?: string;
}

/**
 * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
 */
model EncryptionCustomerManagedKeyEncryptionKeyEncryptionKeyIdentity {
  /**
   * The type of identity to use. Values can be systemAssignedIdentity, userAssignedIdentity, or delegatedResourceIdentity.
   */
  identityType?: EncryptionCustomerManagedKeyEncryptionKeyEncryptionKeyIdentityIdentityType;

  /**
   * User assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity.
   */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * application client identity to use for accessing key encryption key Url in a different tenant. Ex: f83c6b1b-4d34-47e4-bb34-9d83df58b540
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  federatedClientId?: string;

  /**
   * delegated identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity and userAssignedIdentity - internal use only.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  delegatedIdentityClientId?: string;
}

/**
 * Data processing location.
 */
model LocationsItem {
  /**
   * The location name.
   */
  locationName: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Parameters used to update an existing Maps Account.
 */
model MapsAccountUpdateParameters {
  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Get or Set Kind property.
   */
  kind?: Kind;

  /**
   * The SKU of this account.
   */
  sku?: Sku;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: ManagedServiceIdentity;

  /**
   * The map account properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: MapsAccountProperties;
}

/**
 * A list of Maps Accounts.
 */
model MapsAccounts is Azure.Core.Page<MapsAccount>;

/**
 * Parameters used to create an account Shared Access Signature (SAS) token. The REST API access control is provided by Azure Maps Role Based Access (RBAC) identity and access.
 */
model AccountSasParameters {
  /**
   * The Maps account key to use for signing. Picking `primaryKey` or `secondaryKey` will use the Maps account Shared Keys, and using `managedIdentity` will use the auto-renewed private key to sign the SAS.
   */
  signingKey: SigningKey;

  /**
   * The principal Id also known as the object Id of a User Assigned Managed Identity currently assigned to the Maps Account. To assign a Managed Identity of the account, use operation Create or Update an assign a User Assigned Identity resource Id.
   */
  principalId: string;

  /**
   * Optional, allows control of which region locations are permitted access to Azure Maps REST APIs with the SAS token. Example: "eastus", "westus2". Omitting this parameter will allow all region locations to be accessible.
   */
  regions?: string[];

  /**
   * Required parameter which represents the desired maximum request per second to allowed for the given SAS token. This does not guarantee perfect accuracy in measurements but provides application safe guards of abuse with eventual enforcement.
   */
  @maxValue(500)
  maxRatePerSecond: int32 = 500;

  /**
   * The date time offset of when the token validity begins. For example "2017-05-24T10:42:03.1567373Z". Maximum duration allowed is 24 hours between `start` and `expiry`.
   */
  start: string;

  /**
   * The date time offset of when the token validity expires. For example "2017-05-24T10:42:03.1567373Z". Maximum duration allowed is 24 hours between `start` and `expiry`.
   */
  expiry: string;
}

/**
 * A new Sas token which can be used to access the Maps REST APIs and is controlled by the specified Managed identity permissions on Azure (IAM) Role Based Access Control.
 */
model MapsAccountSasToken {
  /**
   * The shared access signature access token.
   */
  @visibility(Lifecycle.Read)
  accountSasToken?: string;
}

/**
 * The set of keys which can be used to access the Maps REST APIs. Two keys are provided for key rotation without interruption.
 */
model MapsAccountKeys {
  /**
   * The last updated date and time of the primary key.
   */
  @visibility(Lifecycle.Read)
  primaryKeyLastUpdated?: string;

  /**
   * The primary key for accessing the Maps REST APIs.
   */
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /**
   * The secondary key for accessing the Maps REST APIs.
   */
  @visibility(Lifecycle.Read)
  secondaryKey?: string;

  /**
   * The last updated date and time of the secondary key.
   */
  @visibility(Lifecycle.Read)
  secondaryKeyLastUpdated?: string;
}

/**
 * Whether the operation refers to the primary or secondary key.
 */
model MapsKeySpecification {
  /**
   * Whether the operation refers to the primary or secondary key.
   */
  keyType: KeyType;
}

/**
 * A list of Creator resources.
 */
model CreatorList is Azure.Core.Page<Creator>;

/**
 * Creator resource properties
 */
model CreatorProperties {
  /**
   * The state of the resource provisioning, terminal states: Succeeded, Failed, Canceled
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The storage units to be allocated. Integer values from 1 to 100, inclusive.
   */
  @maxValue(100)
  @minValue(1)
  storageUnits: int32;

  /**
   * The total allocated storage unit size in bytes for the creator resource.
   */
  totalStorageUnitSizeInBytes?: int32;

  /**
   * The consumed storage unit size in bytes for the creator resource.
   */
  consumedStorageUnitSizeInBytes?: int32;
}

/**
 * Parameters used to update an existing Creator resource.
 */
model CreatorUpdateParameters {
  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Creator resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CreatorProperties;
}
