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

@doc("The name of the SKU, in standard format (such as S0).")
enum Name {
  S0,
  S1,
  G2,
}

@doc("The Kind of the Maps Account.")
enum Kind {
  Gen1,
  Gen2,
}

@doc("The Map account key to use for signing.")
enum SigningKey {
  primaryKey,
  secondaryKey,
}

@doc("Whether the operation refers to the primary or secondary key.")
enum KeyType {
  primary,
  secondary,
}

@doc("The identity type.")
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("The SKU of the Maps Account.")
model Sku {
  @doc("The name of the SKU, in standard format (such as S0).")
  name: Name;

  @doc("Gets the sku tier. This is based on the SKU name.")
  @visibility("read")
  tier?: string;
}

model Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Additional Map account properties")
model MapsAccountProperties {
  @doc("A unique identifier for the maps account")
  @visibility("read")
  uniqueId?: string;

  @doc("Allows toggle functionality on Azure Policy to disable Azure Maps local authentication support. This will disable Shared Keys authentication from any usage.")
  disableLocalAuth?: boolean;

  @doc("The provisioning state of the Map account resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("Sets the resources to be used for Managed Identities based operations for the Map account resource.")
  linkedResources?: LinkedResource[];

  @doc("Specifies CORS rules for the Blob service. You can include up to five CorsRule elements in the request. If no CorsRule elements are included in the request body, all CORS rules will be deleted, and CORS will be disabled for the Blob service.")
  cors?: CorsRules;
}

@doc("Linked resource is reference to a resource deployed in an Azure subscription, add the linked resource `uniqueName` value as an optional parameter for operations on Azure Maps Geospatial REST APIs.")
model LinkedResource {
  @doc("A provided name which uniquely identifies the linked resource.")
  uniqueName: string;

  @doc("ARM resource id in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/accounts/{storageName}'.")
  id: string;
}

@doc("Sets the CORS rules. You can include up to five CorsRule elements in the request. ")
model CorsRules {
  @doc("The list of CORS rules. You can include up to five CorsRule elements in the request. ")
  corsRules?: CorsRule[];
}

@doc("Specifies a CORS rule for the Map Account.")
model CorsRule {
  @doc("Required if CorsRule element is present. A list of origin domains that will be allowed via CORS, or \"*\" to allow all domains")
  allowedOrigins: string[];
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Parameters used to update an existing Maps Account.")
model MapsAccountUpdateParameters {
  @doc("Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters.")
  tags?: Record<string>;

  @doc("Get or Set Kind property.")
  kind?: Kind;

  @doc("The SKU of this account.")
  sku?: Sku;

  @doc("Sets the identity property for maps account.")
  identity?: ManagedServiceIdentity;

  @doc("The map account properties.")
  properties?: MapsAccountProperties;
}

@doc("Parameters used to create an account Shared Access Signature (SAS) token. The REST API access control is provided by Azure Maps Role Based Access (RBAC) identity and access.")
model AccountSasParameters {
  @doc("The Map account key to use for signing.")
  signingKey: SigningKey;

  @doc("The principal Id also known as the object Id of a User Assigned Managed Identity currently assigned to the Map Account. To assign a Managed Identity of the account, use operation Create or Update an assign a User Assigned Identity resource Id.")
  principalId: string;

  @doc("Optional, allows control of which region locations are permitted access to Azure Maps REST APIs with the SAS token. Example: \"eastus\", \"westus2\". Omitting this parameter will allow all region locations to be accessible.")
  regions?: string[];

  @doc("Required parameter which represents the desired maximum request per second to allowed for the given SAS token. This does not guarantee perfect accuracy in measurements but provides application safe guards of abuse with eventual enforcement.")
  @maxValue(500)
  maxRatePerSecond: int32;

  @doc("The date time offset of when the token validity begins. For example \"2017-05-24T10:42:03.1567373Z\".")
  start: string;

  @doc("The date time offset of when the token validity expires. For example \"2017-05-24T10:42:03.1567373Z\"")
  expiry: string;
}

@doc("A new Sas token which can be used to access the Maps REST APIs and is controlled by the specified Managed identity permissions on Azure (IAM) Role Based Access Control.")
model MapsAccountSasToken {
  @doc("The shared access signature access token.")
  @visibility("read")
  accountSasToken?: string;
}

@doc("The set of keys which can be used to access the Maps REST APIs. Two keys are provided for key rotation without interruption.")
model MapsAccountKeys {
  @doc("The last updated date and time of the primary key.")
  @visibility("read")
  primaryKeyLastUpdated?: string;

  @doc("The primary key for accessing the Maps REST APIs.")
  @visibility("read")
  primaryKey?: string;

  @doc("The secondary key for accessing the Maps REST APIs.")
  @visibility("read")
  secondaryKey?: string;

  @doc("The last updated date and time of the secondary key.")
  @visibility("read")
  secondaryKeyLastUpdated?: string;
}

@doc("Whether the operation refers to the primary or secondary key.")
model MapsKeySpecification {
  @doc("Whether the operation refers to the primary or secondary key.")
  keyType: KeyType;
}

@doc("Creator resource properties")
model CreatorProperties {
  @doc("The state of the resource provisioning, terminal states: Succeeded, Failed, Canceled")
  @visibility("read")
  provisioningState?: string;

  @doc("The storage units to be allocated. Integer values from 1 to 100, inclusive.")
  @maxValue(100)
  @minValue(1)
  storageUnits: int32;
}

@doc("Parameters used to update an existing Creator resource.")
model CreatorUpdateParameters {
  @doc("Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters.")
  tags?: Record<string>;

  @doc("Creator resource properties.")
  properties?: CreatorProperties;
}

@doc("The set of operations available for Maps.")
model MapsOperations {
  @doc("An operation available for Maps.")
  @visibility("read")
  value?: OperationDetail[];

  @doc("""
URL client should use to fetch the next page (per server side paging).
It's null for now, added for future use.
""")
  nextLink?: string;
}

@doc("Operation detail payload")
model OperationDetail {
  @doc("Name of the operation")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Display of the operation")
  display?: OperationDisplay;

  @doc("Origin of the operation")
  origin?: string;

  @doc("Properties of the operation")
  properties?: OperationProperties;
}

@doc("Properties of operation, include metric specifications.")
model OperationProperties {
  @doc("One property of operation, include metric specifications.")
  serviceSpecification?: ServiceSpecification;
}

@doc("One property of operation, include metric specifications.")
model ServiceSpecification {
  @doc("Metric specifications of operation.")
  metricSpecifications?: MetricSpecification[];
}

@doc("Metric specification of operation.")
model MetricSpecification {
  @doc("Name of metric specification.")
  name?: string;

  @doc("Display name of metric specification.")
  displayName?: string;

  @doc("Display description of metric specification.")
  displayDescription?: string;

  @doc("Unit could be Count.")
  unit?: string;

  @doc("Dimensions of map account.")
  dimensions?: Dimension[];

  @doc("Aggregation type could be Average.")
  aggregationType?: string;

  @doc("The property to decide fill gap with zero or not.")
  fillGapWithZero?: boolean;

  @doc("The category this metric specification belong to, could be Capacity.")
  category?: string;

  @doc("Account Resource Id.")
  resourceIdDimensionNameOverride?: string;

  @doc("Source metrics account.")
  sourceMdmAccount?: string;

  @doc("Internal metric name.")
  internalMetricName?: string;
}

@doc("Dimension of map account, for example API Category, Api Name, Result Type, and Response Code.")
model Dimension {
  @doc("Display name of dimension.")
  name?: string;

  @doc("Display name of dimension.")
  displayName?: string;

  @doc("Internal name of the dimension.")
  internalName?: string;

  @doc("Internal metric name of the dimension.")
  internalMetricName?: string;

  @doc("Source Mdm Namespace of the dimension.")
  sourceMdmNamespace?: string;

  @doc("Flag to indicate exporting to Azure Monitor.")
  toBeExportedToShoebox?: boolean;
}
