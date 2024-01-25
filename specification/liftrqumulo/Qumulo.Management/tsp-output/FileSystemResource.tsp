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
/**
 * A FileSystem Resource by Qumulo
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(FileSystemResourceProperties)
model FileSystemResource extends TrackedResourceBase {
  /**
   * Name of the File System resource
   */
  @path
  @key("fileSystemName")
  @segment("fileSystems")
  @visibility("read")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: FileSystemResourceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface FileSystemResources {
  /**
   * Get a FileSystemResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FileSystems_Get")
  get is ArmResourceRead<FileSystemResource>;

  /**
   * Create a FileSystemResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FileSystems_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FileSystemResource,
    BaseParameters<FileSystemResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a FileSystemResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("FileSystems_Update")
  update is ArmCustomPatchSync<FileSystemResource, FileSystemResourceUpdate>;

  /**
   * Delete a FileSystemResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FileSystems_Delete")
  delete is ArmResourceDeleteAsync<
    FileSystemResource,
    BaseParameters<FileSystemResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List FileSystemResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FileSystems_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<FileSystemResource>;

  /**
   * List FileSystemResource resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FileSystems_ListBySubscription")
  listBySubscription is ArmListBySubscription<FileSystemResource>;
}
