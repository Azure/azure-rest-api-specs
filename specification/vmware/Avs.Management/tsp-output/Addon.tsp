import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * An addon resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@Azure.ResourceManager.Private.armResourceInternal(AddonProperties)
@includeInapplicableMetadataInPayload(false)
model Addon extends ProxyResourceBase {
  /**
   * Name of the addon for the private cloud
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("addonName")
  @segment("addons")
  name: string;

  /**
   * The properties of an addon resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: AddonProperties;
}

@armResourceOperations
interface Addons {
  /**
   * Get an addon by name in a private cloud
   */
  get is ArmResourceRead<Addon>;

  /**
   * Create or update a addon in a private cloud
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Addon>;

  /**
   * Delete a addon in a private cloud
   */
  delete is ArmResourceDeleteAsync<Addon>;

  /**
   * List addons in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Addons_List")
  list is ArmResourceListByParent<Addon>;
}

@@projectedName(Addons.createOrUpdate::parameters.resource, "json", "addon");
@@extension(Addons.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "addon"
);
@@doc(Addons.createOrUpdate::parameters.resource,
  "A addon in the private cloud"
);
