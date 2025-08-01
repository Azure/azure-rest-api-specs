import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./Connectors/connectorModels.tsp";
import "./DataShares/dataShareModels.tsp";
import "./storageAccount.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Storage")
@service(#{ title: "StorageManagementClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.Storage;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_07_01_preview: "2025-07-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Connector is a tracked ARM resource modeled as a sub-resource of a Storage Account")
@parentResource(StorageAccount)
model Connector is TrackedResource<ConnectorProperties> {
  @doc("The name of the storage connector")
  @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
  @key("connectorName")
  @segment("connectors")
  @path
  name: string;
}

@armResourceOperations(Connector)
interface Connectors {
  @doc("Get the specified Storage Connector.")
  get is ArmResourceRead<Connector>;

  @doc("Create a Storage Connector if it does not already exist; otherwise, error out. This API will not allow you to replace an already existing resource. ")
  create is ArmResourceCreateOrReplaceAsync<Connector>;

  @doc("Update a Storage Connector.")
  update is ArmResourcePatchAsync<Connector, ConnectorProperties>;

  @doc("Delete a Storage Connector.")
  delete is ArmResourceDeleteWithoutOkAsync<Connector>;

  @doc("List all Storage Connectors in a Storage Account.")
  listByStorageAccount is ArmResourceListByParent<Connector>;

  @doc("This method is used to verify that the connection to the backing data store works. This API is designed to be used for monitoring and debugging purposes. From the caller’s perspective, this method does the following: Calls List on the backing data store, attempting to list up to one blob/object/etc. If the above succeeds, and if a blob/object/etc is found, calls Get on that object, attempting to download one byte.")
  testExistingConnection is ArmResourceActionAsync<
    Connector,
    TestExistingConnectionRequest,
    TestConnectionResponse
  >;
}

@doc("A DataShare is a tracked ARM resource modeled as a sub-resource of a Storage Account")
@parentResource(StorageAccount)
@added(Versions.v2025_07_01_preview)
model DataShare is TrackedResource<DataShareProperties> {
  @doc("The name of the Storage Data Share")
  @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
  @key("dataShareName")
  @segment("dataShares")
  @path
  name: string;
}

@armResourceOperations(DataShare)
interface DataShares {
  @doc("Get the specified Storage DataShare.")
  @added(Versions.v2025_07_01_preview)
  get is ArmResourceRead<DataShare>;

  @doc("Create a Storage DataShare if it does not already exist; otherwise, error out. This API will not allow you to replace an already existing resource. ")
  @added(Versions.v2025_07_01_preview)
  create is ArmResourceCreateOrReplaceAsync<DataShare>;

  @doc("Update a Storage DataShare.")
  @added(Versions.v2025_07_01_preview)
  update is ArmResourcePatchAsync<DataShare, DataShareProperties>;

  @doc("Delete a Storage DataShare.")
  @added(Versions.v2025_07_01_preview)
  delete is ArmResourceDeleteWithoutOkAsync<DataShare>;

  @doc("List all Storage DataShares in a Storage Account.")
  @added(Versions.v2025_07_01_preview)
  listByStorageAccount is ArmResourceListByParent<DataShare>;
}
