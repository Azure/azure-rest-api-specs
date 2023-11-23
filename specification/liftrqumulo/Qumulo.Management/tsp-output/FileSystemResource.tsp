import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Qumulo.Storage;
@doc("A FileSystem Resource by Qumulo")
model FileSystemResource is TrackedResource<FileSystemResourceProperties> {
  @doc("Name of the File System resource")
  @path
  @key("fileSystemName")
  @segment("fileSystems")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface FileSystemResources {
  @doc("Get a FileSystemResource")
  get is ArmResourceRead<FileSystemResource>;
  @doc("Create a FileSystemResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FileSystemResource>;
  @doc("Update a FileSystemResource")
  update is ArmResourcePatchSync<
    FileSystemResource,
    FileSystemResourceProperties
  >;
  @doc("Delete a FileSystemResource")
  delete is ArmResourceDeleteAsync<FileSystemResource>;
  @doc("List FileSystemResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<FileSystemResource>;
  @doc("List FileSystemResource resources by subscription ID")
  listBySubscription is ArmListBySubscription<FileSystemResource>;
}
