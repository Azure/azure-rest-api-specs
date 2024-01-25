import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Role.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
// FIXME: Addon has no properties property
/**
 * Role Addon
 */
@parentResource(Role)
model Addon is ProxyResource<{}> {
  /**
   * The addon name.
   */
  @path
  @key("addonName")
  @segment("addons")
  @visibility("read")
  name: string;

  /**
   * Addon type.
   */
  kind: AddonType;
}

@armResourceOperations
interface Addons {
  /**
   * Gets a specific addon by name.
   */
  get is ArmResourceRead<Addon>;

  /**
   * Create or update a addon.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Addon>;

  /**
   * Deletes the addon on the device.
   */
  delete is ArmResourceDeleteAsync<Addon>;

  /**
   * Lists all the addons configured in the role.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Addons_ListByRole")
  listByRole is ArmResourceListByParent<Addon>;
}

@@projectedName(Addons.createOrUpdate::parameters.resource, "json", "addon");
@@extension(Addons.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "addon"
);
@@doc(Addons.createOrUpdate::parameters.resource, "The addon properties.");
