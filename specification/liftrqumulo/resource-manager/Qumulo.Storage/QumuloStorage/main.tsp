import "./LiftrBase.Storage/main.tsp";
import "./back-compatible.tsp";

import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./client.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Storage;

@armProviderNamespace
@useLibraryNamespace(LiftrBase.Storage)
@service(#{ title: "Qumulo.Storage" })
@versioned(Versions)
namespace Qumulo.Storage;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-02-01 Stable API version.
   */
  @useDependency(LiftrBase.Versions.v2_preview)
  @useDependency(LiftrBase.Storage.Versions.v2_preview)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2_stable: "2024-06-19",

  /**
   * The 2025-10-01-preview Preview API version.
   */
  @useDependency(LiftrBase.Versions.v2_preview)
  @useDependency(LiftrBase.Storage.Versions.v2025_10_01_preview)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2025_10_01_preview: "2025-10-01-preview",

  /**
   * The 2026-02-17-preview Preview API version.
   */
  @useDependency(LiftrBase.Versions.v2_preview)
  @useDependency(LiftrBase.Storage.Versions.v2026_02_17_preview)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2026_02_17_preview: "2026-02-17-preview",

  /**
   * The 2026-04-16 Stable API version.
   */
  @useDependency(LiftrBase.Versions.v2_preview)
  @useDependency(LiftrBase.Storage.Versions.v2026_04_16)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2026_04_16: "2026-04-16",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface FileSystems {
  /**
   * Get a FileSystemResource
   */
  get is ArmResourceRead<FileSystemResource>;

  /**
   * Create a FileSystemResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FileSystemResource,
    BaseParameters<FileSystemResource>,
    ArmAsyncOperationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a FileSystemResource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<FileSystemResource, FileSystemResourceUpdate>;

  /**
   * Delete a FileSystemResource
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    FileSystemResource,
    BaseParameters<FileSystemResource>,
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List FileSystemResource resources by resource group
   */
  listByResourceGroup is ArmResourceListByParent<FileSystemResource>;

  /**
   * List FileSystemResource resources by subscription ID
   */
  listBySubscription is ArmListBySubscription<FileSystemResource>;
}
