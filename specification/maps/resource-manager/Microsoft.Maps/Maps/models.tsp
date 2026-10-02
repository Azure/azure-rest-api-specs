import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Maps;

/**
 * The name of the SKU, in standard format (such as G2).
 */
union Name {
  string,

  /**
   * G2
   */
  G2: "G2",
}

/**
 * The Kind of the Maps Account.
 */
union Kind {
  string,

  /**
   * Gen2
   */
  Gen2: "Gen2",
}

/**
 * Property to specify whether the Maps Account will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked.
 */
union PublicNetworkAccess {
  string,

  /**
   * enabled
   */
  enabled: "enabled",

  /**
   * disabled
   */
  disabled: "disabled",
}

/**
 * The Maps account key to use for signing. Picking `primaryKey` or `secondaryKey` will use the Maps account Shared Keys, and using `managedIdentity` will use the auto-renewed private key to sign the SAS.
 */
union SigningKey {
  string,

  /**
   * primaryKey
   */
  primaryKey: "primaryKey",

  /**
   * secondaryKey
   */
  secondaryKey: "secondaryKey",

  /**
   * managedIdentity
   */
  managedIdentity: "managedIdentity",
}

/**
 * Whether the operation refers to the primary or secondary key.
 */
union KeyType {
  string,

  /**
   * primary
   */
  primary: "primary",

  /**
   * secondary
   */
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
  disableLocalAuth?: boolean = false;

  /**
   * The provisioning state of the Maps account resource, Account updates can only be performed on terminal states. Terminal states: `Succeeded` and `Failed`
   */
  @typeChangedFrom(Versions.v2026_12_01, string)
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The array of associated resources to the Maps account. Linked resource in the array cannot individually update, you must update all linked resources in the array together. These resources may be used on operations on the Azure Maps REST API. Access is controlled by the Maps Account Managed Identity(s) permissions to those resource(s).
   */
  @maxItems(10)
  linkedResources?: LinkedResource[];

  /**
   * Specifies CORS rules for the Blob service. You can include up to five CorsRule elements in the request. If no CorsRule elements are included in the request body, all CORS rules will be deleted, and CORS will be disabled for the Blob service.
   */
  cors?: CorsRules;

  /**
   * All encryption configuration for a resource.
   */
  encryption?: Azure.ResourceManager.CommonTypes.Encryption;

  /**
   * List of additional data processing regions for the Maps Account, which may result in requests being processed in another geography. Some features or results may be restricted to specific regions. By default, Maps REST APIs process requests according to the account location or the [geographic scope](https://learn.microsoft.com/azure/azure-maps/geographic-scope).
   */
  @identifiers(#["locationName"])
  locations?: LocationsItem[];

  /**
   * List of private endpoint connections associated with the Maps Account.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["properties/privateEndpoint/id"])
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Property to specify whether the Maps Account will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked.
   */
  publicNetworkAccess?: PublicNetworkAccess;
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
  @identifiers(#[])
  @maxItems(5)
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
 * Data processing location.
 */
model LocationsItem {
  /**
   * The location name.
   */
  locationName: string;
}

/**
 * Parameters used to update an existing Maps Account.
 */
@removed(Versions.v2026_12_01)
@renamedFrom(Versions.v2026_12_01, "MapsAccountUpdateParameters")
model MapsAccountUpdateParametersV1 {
  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The map account properties.
   */
  properties?: MapsAccountProperties;
}

/**
 * Parameters used to update an existing Maps Account.
 */
@added(Versions.v2026_12_01)
model MapsAccountUpdateParameters {
  ...ArmTagsProperty;

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
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The map account properties.
   */
  properties?: MapsAccountProperties;
}

@@doc(
  MapsAccountUpdateParameters.tags,
  "Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource across resource groups."
);

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
  @minValue(0)
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
  @removed(Versions.v2026_12_01)
  @renamedFrom(Versions.v2026_12_01, "accountSasToken")
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  accountSasTokenV1?: string;

  /**
   * The shared access signature access token.
   */
  @added(Versions.v2026_12_01)
  @secret
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
  @removed(Versions.v2026_12_01)
  @renamedFrom(Versions.v2026_12_01, "primaryKey")
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  primaryKeyV1?: string;

  /**
   * The primary key for accessing the Maps REST APIs.
   */
  @added(Versions.v2026_12_01)
  @secret
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /**
   * The secondary key for accessing the Maps REST APIs.
   */
  @removed(Versions.v2026_12_01)
  @renamedFrom(Versions.v2026_12_01, "secondaryKey")
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  secondaryKeyV1?: string;

  /**
   * The secondary key for accessing the Maps REST APIs.
   */
  @added(Versions.v2026_12_01)
  @secret
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
  @typeChangedFrom(Versions.v2026_12_01, string)
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Creator resource properties.
   */
  properties?: CreatorProperties;
}

/**
 * A list of private link resources for a Maps Account resource type.
 */
model PrivateLinkResourceList is Azure.Core.Page<PrivateLinkResource>;

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionList
  is Azure.Core.Page<PrivateEndpointConnection>;
