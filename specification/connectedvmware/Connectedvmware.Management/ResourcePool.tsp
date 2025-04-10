import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the resourcePool.
 */
model ResourcePool
  is Azure.ResourceManager.TrackedResource<ResourcePoolProperties, false> {
  ...ResourceNameParameter<
    Resource = ResourcePool,
    KeyName = "resourcePoolName",
    SegmentName = "resourcePools",
    NamePattern = ""
  >;

  /**
   * Gets or sets the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;
}

@armResourceOperations
interface ResourcePools {
  /**
   * Implements resourcePool GET method.
   */
  get is ArmResourceRead<ResourcePool>;

  /**
   * Create Or Update resourcePool.
   */
  create is ArmResourceCreateOrReplaceAsync<ResourcePool>;

  /**
   * API to update certain properties of the resourcePool resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ResourcePool, PatchModel = ResourcePatch>;

  /**
   * Implements resourcePool DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ResourcePool,
    Parameters = {
      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List of resourcePools in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ResourcePool,
    Response = ArmResponse<ResourcePoolsList>
  >;

  /**
   * List of resourcePools in a subscription.
   */
  list is ArmListBySubscription<
    ResourcePool,
    Response = ArmResponse<ResourcePoolsList>
  >;
}

@@doc(ResourcePool.name, "Name of the resourcePool.");
@@doc(ResourcePool.properties, "Resource properties.");
@@doc(ResourcePools.create::parameters.resource, "Request payload.");
@@doc(ResourcePools.update::parameters.properties,
  "Resource properties to update."
);
