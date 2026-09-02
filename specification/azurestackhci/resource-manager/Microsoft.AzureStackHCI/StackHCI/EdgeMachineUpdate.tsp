import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./EdgeMachine.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/** EdgeMachine Update resource that stores validated update configurations for an edge machine. */
@added(Versions.v2026_05_01_preview)
@parentResource(EdgeMachine)
model EdgeMachineUpdate
  is Azure.ResourceManager.ProxyResource<EdgeMachineUpdateProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineUpdate,
    KeyName = "default",
    SegmentName = "updates",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

/**
 * Operations for EdgeMachine Update.
 */
@added(Versions.v2026_05_01_preview)
@armResourceOperations
interface EdgeMachineUpdates {
  /**
   * Get EdgeMachine update.
   */
  get is ArmResourceRead<EdgeMachineUpdate>;

  /**
   * Create or update EdgeMachine update.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachineUpdate>;

  /**
   * Delete EdgeMachine update.
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineUpdate>;

  /**
   * List EdgeMachine update resources by EdgeMachine.
   */
  list is ArmResourceListByParent<EdgeMachineUpdate>;
}

@@doc(EdgeMachineUpdate.name, "Name of EdgeMachine update");
