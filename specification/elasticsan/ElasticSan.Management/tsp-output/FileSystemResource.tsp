import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a FileSystemResource")
  @operationId("FileSystems_Get")
  get is ArmResourceRead<FileSystemResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a FileSystemResource")
  @operationId("FileSystems_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FileSystemResource,
    BaseParameters<FileSystemResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a FileSystemResource")
  @operationId("FileSystems_Update")
  update is ArmCustomPatchSync<FileSystemResource, FileSystemResourceUpdate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a FileSystemResource")
  @operationId("FileSystems_Delete")
  delete is ArmResourceDeleteAsync<
    FileSystemResource,
    BaseParameters<FileSystemResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List FileSystemResource resources by resource group")
  @operationId("FileSystems_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<FileSystemResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List FileSystemResource resources by subscription ID")
  @operationId("FileSystems_ListBySubscription")
  listBySubscription is ArmListBySubscription<FileSystemResource>;
}
