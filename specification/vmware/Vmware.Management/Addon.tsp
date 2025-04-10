import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * An addon resource
 */
@parentResource(PrivateCloud)
model Addon is Azure.ResourceManager.ProxyResource<AddonProperties> {
  ...ResourceNameParameter<
    Resource = Addon,
    KeyName = "addonName",
    SegmentName = "addons",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface Addons {
  /**
   * Get a Addon
   */
  get is ArmResourceRead<Addon>;

  /**
   * Create a Addon
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Addon>;

  /**
   * Delete a Addon
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Addon,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Addon resources by PrivateCloud
   */
  list is ArmResourceListByParent<Addon, Response = ArmResponse<AddonList>>;
}

@@doc(Addon.name, "Name of the addon.");
@@doc(Addon.properties, "The resource-specific properties for this resource.");
