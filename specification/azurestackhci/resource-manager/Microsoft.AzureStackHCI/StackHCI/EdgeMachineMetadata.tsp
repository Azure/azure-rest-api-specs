import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./EdgeMachine.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/**
 * EdgeMachine Metadata resource - stores validated recipe information for an edge machine.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineMetadata
  is Azure.ResourceManager.ProxyResource<EdgeMachineMetadataProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineMetadata,
    KeyName = "default",
    SegmentName = "edgeMachineMetadata",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

/**
 * CRUD operations for EdgeMachine Metadata.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineMetadataOperations {
  /**
   * Get EdgeMachine metadata.
   */
  get is ArmResourceRead<EdgeMachineMetadata>;

  /**
   * Create or update EdgeMachine metadata.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachineMetadata>;

  /**
   * Delete EdgeMachine metadata.
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineMetadata>;

  /**
   * List EdgeMachine metadata resources by EdgeMachine.
   */
  list is ArmResourceListByParent<EdgeMachineMetadata>;
}

@@doc(EdgeMachineMetadata.name, "Name of EdgeMachine metadata");
