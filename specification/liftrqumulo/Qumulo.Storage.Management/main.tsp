import "./LiftrBase.Storage/main.tsp";

import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Storage;
using LiftrBase;

@armProviderNamespace
@useLibraryNamespace(LiftrBase.Storage)
@service({
  title: "Qumulo.Storage",
})
@versioned(Versions)
namespace Qumulo.Storage;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-02-01 Stable API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v2)
  @useDependency(LiftrBase.Storage.Versions.v2)
  v2: "2024-02-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface FileSystems {
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
  delete is ArmResourceDeleteWithoutOkAsync<
    FileSystemResource,
    BaseParameters<FileSystemResource>,
    ArmCombinedLroHeaders
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
