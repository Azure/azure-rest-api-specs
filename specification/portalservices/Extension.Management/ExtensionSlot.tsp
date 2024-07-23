import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PortalExtension.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PortalServices;
/**
 * A Portal Extension Slot
 */
@parentResource(PortalExtension)
model ExtensionSlot
  is Azure.ResourceManager.TrackedResource<ExtensionSlotProperties> {
  /**
   * The name of the slot
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]+$")
  @path
  @key("slotName")
  @segment("slots")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PortalExtensionSlots {
  /**
   * Gets the portal extension slot.
   */
  get is ArmResourceRead<ExtensionSlot>;

  /**
   * Creates or Updates a slot
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExtensionSlot>;

  /**
   * Updates an existing portal extension slot.
   */
  update is ArmCustomPatchSync<ExtensionSlot, PatchableExtensionSlot>;

  /**
   * Deletes a portal extension slot.
   */
  delete is ArmResourceDeleteSync<ExtensionSlot>;

  /**
   * Gets all the portal extension Slots within an extension.
   */
  listByExtensions is ArmResourceListByParent<ExtensionSlot>;
}

@@doc(PortalExtensionSlots.createOrUpdate::parameters.resource,
  "The slot deployment definition"
);
@@doc(PortalExtensionSlots.update::parameters.properties,
  "The updatable fields of a portal extension slot."
);

@@clientName(PortalExtensionSlots.update::parameters.properties, "parameters");
@@encodedName(PortalExtensionSlots.update::parameters.properties,
  "application/json",
  "parameters"
);
