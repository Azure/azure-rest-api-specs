import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Maps;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The name of the SKU, in standard format (such as S0).
 */
enum Name {
  S0,
  S1,
  G2,
}

/**
 * The Kind of the Maps Account.
 */
enum Kind {
  Gen1,
  Gen2,
}

/**
 * The Map account key to use for signing.
 */
enum SigningKey {
  primaryKey,
  secondaryKey,
}

/**
 * Whether the operation refers to the primary or secondary key.
 */
enum KeyType {
  primary,
  secondary,
}

/**
 * The identity type.
 */
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The SKU of the Maps Account.
 */
model Sku {
  /**
   * The name of the SKU, in standard format (such as S0).
   */
  name: Name;

  /**
   * Gets the sku tier. This is based on the SKU name.
   */
  @visibility("read")
  tier?: string;
}

model Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Additional Map account properties
 */
model MapsAccountProperties {
  /**
   * A unique identifier for the maps account
   */
  @visibility("read")
  uniqueId?: string;

  /**
   * Allows toggle functionality on Azure Policy to disable Azure Maps local authentication support. This will disable Shared Keys authentication from any usage.
   */
  disableLocalAuth?: boolean;

  /**
   * The provisioning state of the Map account resource.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Sets the resources to be used for Managed Identities based operations for the Map account resource.
   */
  linkedResources?: LinkedResource[];

  /**
   * Specifies CORS rules for the Blob service. You can include up to five CorsRule elements in the request. If no CorsRule elements are included in the request body, all CORS rules will be deleted, and CORS will be disabled for the Blob service.
   */
  cors?: CorsRules;
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
 * Parameters used to update an existing Maps Account.
 */
model MapsAccountUpdateParameters {
  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters.
   */
  tags?: Record<string>;

  /**
   * Get or Set Kind property.
   */
  kind?: Kind = Kind.Gen1;

  /**
   * The SKU of this account.
   */
  sku?: Sku;

  /**
   * Sets the identity property for maps account.
   */
  identity?: ManagedServiceIdentity;

  /**
   * The map account properties.
   */
  properties?: MapsAccountProperties;
}

/**
 * Parameters used to create an account Shared Access Signature (SAS) token. The REST API access control is provided by Azure Maps Role Based Access (RBAC) identity and access.
 */
model AccountSasParameters {
  /**
   * The Map account key to use for signing.
   */
  signingKey: SigningKey;

  /**
   * The principal Id also known as the object Id of a User Assigned Managed Identity currently assigned to the Map Account. To assign a Managed Identity of the account, use operation Create or Update an assign a User Assigned Identity resource Id.
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
   * The date time offset of when the token validity begins. For example "2017-05-24T10:42:03.1567373Z".
   */
  start: string;

  /**
   * The date time offset of when the token validity expires. For example "2017-05-24T10:42:03.1567373Z"
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
  @visibility("read")
  accountSasToken?: string;
}

/**
 * The set of keys which can be used to access the Maps REST APIs. Two keys are provided for key rotation without interruption.
 */
model MapsAccountKeys {
  /**
   * The last updated date and time of the primary key.
   */
  @visibility("read")
  primaryKeyLastUpdated?: string;

  /**
   * The primary key for accessing the Maps REST APIs.
   */
  @visibility("read")
  primaryKey?: string;

  /**
   * The secondary key for accessing the Maps REST APIs.
   */
  @visibility("read")
  secondaryKey?: string;

  /**
   * The last updated date and time of the secondary key.
   */
  @visibility("read")
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
 * Creator resource properties
 */
model CreatorProperties {
  /**
   * The state of the resource provisioning, terminal states: Succeeded, Failed, Canceled
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The storage units to be allocated. Integer values from 1 to 100, inclusive.
   */
  @maxValue(100)
  @minValue(1)
  storageUnits: int32;
}

/**
 * Parameters used to update an existing Creator resource.
 */
model CreatorUpdateParameters {
  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters.
   */
  tags?: Record<string>;

  /**
   * Creator resource properties.
   */
  properties?: CreatorProperties;
}

/**
 * The set of operations available for Maps.
 */
model MapsOperations {
  /**
   * An operation available for Maps.
   */
  @visibility("read")
  value?: OperationDetail[];

  /**
* URL client should use to fetch the next page (per server side paging).
It's null for now, added for future use.
*/
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
   * Properties of the operation
   */
  properties?: OperationProperties;
}

/**
 * Properties of operation, include metric specifications.
 */
model OperationProperties {
  /**
   * One property of operation, include metric specifications.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * One property of operation, include metric specifications.
 */
model ServiceSpecification {
  /**
   * Metric specifications of operation.
   */
  metricSpecifications?: MetricSpecification[];
}

/**
 * Metric specification of operation.
 */
model MetricSpecification {
  /**
   * Name of metric specification.
   */
  name?: string;

  /**
   * Display name of metric specification.
   */
  displayName?: string;

  /**
   * Display description of metric specification.
   */
  displayDescription?: string;

  /**
   * Unit could be Count.
   */
  unit?: string;

  /**
   * Dimensions of map account.
   */
  dimensions?: Dimension[];

  /**
   * Aggregation type could be Average.
   */
  aggregationType?: string;

  /**
   * The property to decide fill gap with zero or not.
   */
  fillGapWithZero?: boolean;

  /**
   * The category this metric specification belong to, could be Capacity.
   */
  category?: string;

  /**
   * Account Resource Id.
   */
  resourceIdDimensionNameOverride?: string;

  /**
   * Source metrics account.
   */
  sourceMdmAccount?: string;

  /**
   * Internal metric name.
   */
  internalMetricName?: string;
}

/**
 * Dimension of map account, for example API Category, Api Name, Result Type, and Response Code.
 */
model Dimension {
  /**
   * Display name of dimension.
   */
  name?: string;

  /**
   * Display name of dimension.
   */
  displayName?: string;

  /**
   * Internal name of the dimension.
   */
  internalName?: string;

  /**
   * Internal metric name of the dimension.
   */
  internalMetricName?: string;

  /**
   * Source Mdm Namespace of the dimension.
   */
  sourceMdmNamespace?: string;

  /**
   * Flag to indicate exporting to Azure Monitor.
   */
  toBeExportedToShoebox?: boolean;
}
