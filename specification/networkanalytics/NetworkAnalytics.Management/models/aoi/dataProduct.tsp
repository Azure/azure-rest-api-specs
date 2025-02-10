using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.NetworkAnalytics;

@doc("Encryption key details.")
@added(Versions.v2023_11_15)
model EncryptionKeyDetails {
  @doc("The Uri of the key vault.")
  keyVaultUri: string;

  @doc("The name of the key vault key.")
  keyName: string;

  @doc("The version of the key vault key.")
  keyVersion: string;
}

@doc("Data Product Network rule set")
@added(Versions.v2023_11_15)
model DataProductNetworkAcls {
  @doc("Virtual Network Rule")
  @added(Versions.v2023_11_15)
  @madeOptional(Versions.v2024_04_01_preview)
  virtualNetworkRule?: VirtualNetworkRule[];

  @added(Versions.v2023_11_15)
  @madeOptional(Versions.v2024_04_01_preview)
  @doc("IP rule with specific IP or IP range in CIDR format.")
  @extension("x-ms-identifiers", [])
  ipRules?: IPRules[];

  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @doc("The list of query ips in the format of CIDR allowed to connect to query/visualization endpoint.")
  allowedQueryIpRangeList: string[];

  @doc("Default Action")
  defaultAction: DefaultAction;
}

@doc("The data product resource.")
@added(Versions.v2023_11_15)
model DataProduct is TrackedResource<DataProductProperties> {
  @doc("The data product resource name")
  @key("dataProductName")
  @segment("dataProducts")
  @path
  @pattern("^[a-z][a-z0-9]*$")
  @minLength(3)
  @maxLength(63)
  name: string;

  ...ManagedServiceIdentity;
}

@doc("The data product properties.")
@added(Versions.v2023_11_15)
model DataProductProperties {
  @doc("The resource GUID property of the data product resource.")
  @visibility("read")
  resourceGuid?: string;

  @doc("Latest provisioning state  of data product.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @added(Versions.v2023_11_15)
  @doc("Data product publisher name.")
  @visibility("create", "read")
  publisher: string;

  @added(Versions.v2023_11_15)
  @doc("Product name of data product.")
  @visibility("create", "read")
  product: string;

  @doc("Major version of data product.")
  @visibility("create", "read")
  majorVersion: string;

  @doc("List of name or email associated with data product resource deployment.")
  @visibility("create", "read", "update")
  owners?: string[];

  @doc("Flag to enable or disable redundancy for data product.")
  @visibility("create", "read")
  redundancy?: ControlState;

  @doc("Purview account url for data product to connect to.")
  @visibility("create", "update", "read")
  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @renamedFrom(Versions.v2024_04_01_preview, "purviewAccount")
  oldPurviewAccount?: string;

  @doc("Purview collection url for data product to connect to.")
  @visibility("create", "update", "read")
  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @renamedFrom(Versions.v2024_04_01_preview, "purviewCollection")
  oldPurviewCollection?: string;

  @added(Versions.v2024_04_01_preview)
  @doc("Purview account url for data product to connect to.")
  @visibility("create", "read")
  purviewAccount?: string;

  @added(Versions.v2024_04_01_preview)
  @doc("Purview collection url for data product to connect to.")
  @visibility("create", "read")
  purviewCollection?: string;

  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @doc("Flag to enable or disable private link for data product resource.")
  @visibility("create", "update", "read")
  privateLinksEnabled?: ControlState;

  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @doc("Flag to enable or disable public access of data product resource.")
  @visibility("create", "read")
  publicNetworkAccess?: ControlState;

  @doc("Flag to enable customer managed key encryption for data product.")
  @visibility("create", "read")
  customerManagedKeyEncryptionEnabled?: ControlState;

  @doc("Customer managed encryption key details for data product.")
  @visibility("create", "read")
  customerEncryptionKey?: EncryptionKeyDetails;

  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @doc("Network rule set for data product.")
  @visibility("create", "read")
  networkacls?: DataProductNetworkAcls;

  @doc("Managed resource group configuration.")
  @visibility("create")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @added(Versions.v2024_04_01_preview)
  @doc("Flag to enable or disable public access to the ingestion endpoint of data product resource.")
  @visibility("create", "read")
  ingestionPublicNetworkAccess?: ControlState = ControlState.Enabled;

  @added(Versions.v2024_04_01_preview)
  @doc("Network rule set for ingestion endpoint of data product.")
  @visibility("create", "read")
  ingestionNetworkAcls?: DataProductNetworkAcls;

  @added(Versions.v2024_04_01_preview)
  @doc("Flag to enable or disable public access to the insights or the file access endpoint of data product resource.")
  @visibility("create", "read")
  insightsStoragePublicNetworkAccess?: ControlState = ControlState.Enabled;

  @added(Versions.v2024_04_01_preview)
  @doc("Network rule set for insights or the file access endpoint of data product.")
  @visibility("create", "read")
  insightsStorageNetworkAcls?: DataProductNetworkAcls;

  @added(Versions.v2024_04_01_preview)
  @doc("Flag to enable or disable public access to the query endpoint of data product resource.")
  @visibility("create", "update", "read")
  insightsQueryNetworkAccess?: ControlState;

  @added(Versions.v2024_04_01_preview)
  @doc("The list of query IPAddress in the format of Public IPv4 IPAddress or CIDR allowed to connect to query/visualization endpoint.")
  @visibility("create", "update", "read")
  insightsQueryAllowedQueryIpRangeList?: string[];

  @added(Versions.v2024_04_01_preview)
  @doc("This field indicates the status of the query IPAddress update operation.")
  @visibility("read")
  insightQueryUpdateStateReason?: string;

  @added(Versions.v2024_04_01_preview)
  @doc("Flag to enable or disable copilot access for a data product resource.")
  @visibility("create", "read")
  copilotAccess?: ControlState = ControlState.Disabled;

  @added(Versions.v2024_04_01_preview)
  @doc("Option to select between dev or prod SKU for query cluster.")
  @visibility("create", "read")
  workload: WorkloadType = WorkloadType.Production;

  @added(Versions.v2023_11_15)
  @doc("List of available minor versions of the data product resource.")
  @visibility("read")
  @removed(Versions.v2024_04_01_preview)
  availableMinorVersions?: string[];

  @added(Versions.v2023_11_15)
  @doc("Current configured minor version of the data product resource.")
  @visibility("read", "update")
  @removed(Versions.v2024_04_01_preview)
  currentMinorVersion?: string;

  @added(Versions.v2023_11_15)
  @doc("Documentation link for the data product based on definition file.")
  @visibility("read")
  @removed(Versions.v2024_04_01_preview)
  documentation?: string;

  @doc("Resource links which exposed to the customer to query the data.")
  @visibility("read")
  consumptionEndpoints?: ConsumptionEndpointsProperties;

  @doc("Key vault url.")
  @visibility("read")
  keyVaultUrl?: string;

  @added(Versions.v2024_04_01_preview)
  @doc("This field provides specific data product version.")
  @visibility("read")
  currentVersion?: string;
}

@doc("Workload type for query resource.")
@added(Versions.v2024_04_01_preview)
enum WorkloadType {
  @doc("Field for dev or test query workload type.")
  Development: "Development/Testing",

  @doc("Field to production query workload type.")
  Production: "Production",
}

@doc("Details of Consumption Properties")
@added(Versions.v2023_11_15)
model ConsumptionEndpointsProperties {
  @added(Versions.v2023_11_15)
  @doc("Ingestion url to upload the data.")
  @visibility("read")
  @removed(Versions.v2024_04_01_preview)
  ingestionUrl?: string;

  @doc("Blob URL of Ingestion endpoint upload the data.")
  @visibility("read")
  @added(Versions.v2024_04_01_preview)
  ingestionBlobUrl?: string;

  @doc("Datalake URL of Ingestion endpoint to upload the data.")
  @visibility("read")
  @added(Versions.v2024_04_01_preview)
  ingestionDataLakeUrl?: string;

  @doc("Resource Id of ingestion endpoint.")
  @visibility("read")
  ingestionResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("Url to consume file type.")
  @visibility("read")
  fileAccessUrl?: string;

  @doc("Resource Id of file access endpoint.")
  @visibility("read")
  fileAccessResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("Url to consume the processed data.")
  @visibility("read")
  queryUrl?: string;

  @doc("Resource Id of query endpoint.")
  @visibility("read")
  queryResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.Kusto/clusters";
    }
  ]>;

  @doc("Copilot web interface URL.")
  @visibility("read")
  @added(Versions.v2024_04_01_preview)
  copilotWebInterfaceUrl?: string;
}

@doc("The details for storage account sas creation.")
@added(Versions.v2023_11_15)
model AccountSas {
  @doc("Sas token start timestamp.")
  startTimeStamp: utcDateTime;

  @doc("Sas token expiry timestamp.")
  expiryTimeStamp: utcDateTime;

  @doc("Ip Address")
  ipAddress: string;
}

@doc("Details of storage account sas token .")
@added(Versions.v2023_11_15)
model AccountSasToken {
  @doc("Field to specify storage account sas token.")
  @secret
  storageAccountSasToken: string;
}

@doc("Details of storage container account sas token .")
@added(Versions.v2023_11_15)
model ContainerSasToken {
  @doc("Field to specify storage container sas token.")
  @secret
  storageContainerSasToken: string;
}

@doc("Details for KeyVault.")
@added(Versions.v2023_11_15)
model KeyVaultInfo {
  @doc("key vault url.")
  keyVaultUrl: string;
}

@doc("The details for container sas creation.")
@added(Versions.v2023_11_15)
model ContainerSaS is AccountSas;

@doc("The details for role assignment response.")
@added(Versions.v2023_11_15)
model RoleAssignmentDetail is RoleAssignmentCommonProperties {
  @doc("Id of role assignment request")
  roleAssignmentId: string;
}

@doc("list role assignments.")
@added(Versions.v2023_11_15)
model ListRoleAssignments {
  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @doc("Count of role assignments.")
  count: int32;

  @doc("list of role assignments")
  @extension("x-ms-identifiers", ["roleAssignmentId"])
  roleAssignmentResponse: RoleAssignmentDetail[];
}

@doc("The data type state")
@added(Versions.v2023_11_15)
enum DataProductUserRole {
  @doc("Field to specify user of type Reader.")
  Reader,

  @doc("""
Field to specify user of type SensitiveReader.
This user has privileged access to read sensitive data of a data product.
""")
  SensitiveReader,
}

@doc("The details for role assignment common properties.")
@added(Versions.v2023_11_15)
model RoleAssignmentCommonProperties {
  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @doc("Role Id of the Built-In Role")
  roleId: string;

  @doc("Object ID of the AAD principal or security-group.")
  principalId: string;

  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @doc("User name.")
  userName: string;

  @added(Versions.v2023_11_15)
  @removed(Versions.v2024_04_01_preview)
  @doc("Data Type Scope at which the role assignment is created.")
  dataTypeScope: string[];

  @doc("Type of the principal Id: User, Group or ServicePrincipal")
  principalType: string;

  @doc("Data Product role to be assigned to a user.")
  role: DataProductUserRole;
}

@added(Versions.v2024_04_01_preview)
@doc("Details of DataProduct capacity per azure region.")
model RegionalDataProductCapacities is Record<int32>;

@doc("Operations on data product resource.")
@added(Versions.v2023_11_15)
@armResourceOperations
interface DataProducts {
  @doc("Create data product resource.")
  create is ArmResourceCreateOrUpdateAsync<DataProduct>;

  @doc("Retrieve data product resource.")
  get is ArmResourceRead<DataProduct>;

  @doc("Update data product resource.")
  update is ArmResourcePatchAsync<DataProduct, DataProductProperties>;

  @doc("Delete data product resource.")
  delete is ArmResourceDeleteWithoutOkAsync<DataProduct>;

  @doc("Generate sas token for storage account.")
  generateStorageAccountSasToken is ArmResourceActionSync<
    DataProduct,
    AccountSas,
    AccountSasToken
  >;

  @doc("Initiate key rotation on Data Product.")
  rotateKey is ArmResourceActionNoContentSync<DataProduct, KeyVaultInfo>;

  @doc("Assign role to the data product.")
  addUserRole is ArmResourceActionSync<
    DataProduct,
    RoleAssignmentCommonProperties,
    RoleAssignmentDetail
  >;

  @doc("Remove role from the data product.")
  removeUserRole is ArmResourceActionNoContentSync<
    DataProduct,
    RoleAssignmentDetail
  >;

  @doc("List user roles associated with the data product.")
  listRolesAssignments is ArmResourceActionSync<
    DataProduct,
    {},
    ListRoleAssignments
  >;

  @doc("List data products by resource group.")
  listByResourceGroup is ArmResourceListByParent<DataProduct>;

  @doc("List data products by subscription.")
  listBySubscription is ArmListBySubscription<DataProduct>;

  @added(Versions.v2024_04_01_preview)
  @doc("Fetch per region capacity for the data product resource type.")
  @action("providers/Microsoft.NetworkAnalytics/getRegionalDataProductCapacity")
  @post
  @armResourceCollectionAction
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  getRegionalCapacity(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<RegionalDataProductCapacities> | ArmAcceptedLroResponse | ErrorResponse;
}
