import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/**
 * EdgeDevice Metadata resource - stores validated recipe information for an edge device.
 */
@added(Versions.v2026_03_15_preview)
model EdgeDeviceMetadata
  is Azure.ResourceManager.ExtensionResource<EdgeDeviceMetadataProperties> {
  ...ResourceNameParameter<
    Resource = EdgeDeviceMetadata,
    KeyName = "metadataName",
    SegmentName = "edgeDeviceMetadata",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

/**
 * CRUD operations for EdgeDevice Metadata.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeDeviceMetadataOperations {
  /**
   * Get EdgeDevice metadata.
   */
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDeviceMetadata
  >;

  /**
   * Create or update EdgeDevice metadata.
   */
  createOrUpdate is Azure.ResourceManager.Extension.CreateOrReplaceAsync<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDeviceMetadata
  >;

  /**
   * Delete EdgeDevice metadata.
   */
  delete is Azure.ResourceManager.Extension.DeleteWithoutOkAsync<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDeviceMetadata
  >;

  /**
   * List EdgeDevice metadata resources by EdgeDevice.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDeviceMetadata
  >;
}
