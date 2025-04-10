import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Qumulo.Storage;
/**
 * Concrete tracked resource types can be created by aliasing this type using a specific property type.
 */
model FileSystemResource
  is Azure.ResourceManager.TrackedResource<FileSystemResourceProperties> {
  ...ResourceNameParameter<
    Resource = FileSystemResource,
    KeyName = "fileSystemName",
    SegmentName = "fileSystems",
    NamePattern = "^[a-zA-Z0-9_-]*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface FileSystemResources {
  /**
   * Get a FileSystemResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FileSystems_Get")
  get is ArmResourceRead<FileSystemResource>;

  /**
   * Create a FileSystemResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FileSystems_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FileSystemResource>;

  /**
   * Update a FileSystemResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("FileSystems_Update")
  update is ArmCustomPatchSync<
    FileSystemResource,
    PatchModel = FileSystemResourceUpdate
  >;

  /**
   * Delete a FileSystemResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FileSystems_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<FileSystemResource>;

  /**
   * List FileSystemResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FileSystems_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<FileSystemResource>;

  /**
   * List FileSystemResource resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FileSystems_ListBySubscription")
  listBySubscription is ArmListBySubscription<FileSystemResource>;
}

@@doc(FileSystemResource.name, "Name of the File System resource");
@@doc(FileSystemResource.properties,
  "The resource-specific properties for this resource."
);
