import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Qumulo;
@doc("A FileSystem Resource by Qumulo")
model QumuloFileSystemResource
  is TrackedResource<FileSystemResourceProperties> {
  @doc("Name of the File System resource")
  @path
  @key("fileSystemName")
  @segment("fileSystems")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface QumuloFileSystemResources {
  @doc("Get a FileSystemResource")
  get is ArmResourceRead<QumuloFileSystemResource>;
  @doc("Create a FileSystemResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<QumuloFileSystemResource>;
  @doc("Update a FileSystemResource")
  update is ArmResourcePatchSync<
    QumuloFileSystemResource,
    FileSystemResourceProperties
  >;
  @doc("Delete a FileSystemResource")
  delete is ArmResourceDeleteAsync<QumuloFileSystemResource>;
  @doc("List FileSystemResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<QumuloFileSystemResource>;
  @doc("List FileSystemResource resources by subscription ID")
  listBySubscription is ArmListBySubscription<QumuloFileSystemResource>;
}
