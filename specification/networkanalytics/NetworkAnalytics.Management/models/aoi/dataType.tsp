using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.NetworkAnalytics;

@doc("The data type resource.")
@added(Versions.v2023_11_15)
@parentResource(DataProduct)
model DataType is ProxyResource<DataTypeProperties> {
  @doc("The data type name.")
  @segment("dataTypes")
  @key("dataTypeName")
  @path
  @pattern("^[a-z][a-z0-9-]*$")
  @minLength(3)
  @maxLength(63)
  name: string;
}

@doc("The data type properties")
@added(Versions.v2023_11_15)
model DataTypeProperties {
  @doc("Latest provisioning state  of data product.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("State of data type.")
  @visibility("read", "create", "update")
  state?: DataTypeState;

  @doc("Reason for the state of data type.")
  @visibility("read")
  stateReason?: string;

  @doc("Field for storage output retention in days.")
  @visibility("read", "create", "update")
  storageOutputRetention?: int32;

  @doc("Field for database cache retention in days.")
  @visibility("read", "create", "update")
  databaseCacheRetention?: int32;

  @doc("Field for database data retention in days.")
  @visibility("read", "create", "update")
  databaseRetention?: int32;

  @doc("Url for data visualization.")
  @visibility("read")
  visualizationUrl?: string;
}

@doc("The data type state")
@added(Versions.v2023_11_15)
enum DataTypeState {
  @doc("Field to specify stopped state.")
  Stopped,

  @doc("Field to specify running state.")
  Running,
}

@doc("Operations on data type resource.")
@added(Versions.v2023_11_15)
@armResourceOperations
interface DataTypes {
  @doc("Create data type resource.")
  create is ArmResourceCreateOrUpdateAsync<DataType>;

  @doc("Retrieve data type resource.")
  get is ArmResourceRead<DataType>;

  @doc("Update data type resource.")
  update is ArmResourcePatchAsync<DataType, DataTypeProperties>;

  @doc("Delete data type resource.")
  delete is ArmResourceDeleteWithoutOkAsync<DataType>;

  @doc("Delete data for data type.")
  deleteData is ArmResourceActionNoResponseContentAsync<DataType, {}>;

  @doc("Generate sas token for storage container.")
  generateStorageContainerSasToken is ArmResourceActionSync<
    DataType,
    ContainerSaS,
    ContainerSasToken
  >;

  @doc("List data type by parent resource.")
  listByParent is ArmResourceListByParent<DataType>;
}
