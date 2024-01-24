import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the resourcePool.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ResourcePoolProperties)
@includeInapplicableMetadataInPayload(false)
model ResourcePool extends TrackedResourceBase {
  /**
   * Name of the resourcePool.
   */
  @path
  @key("resourcePoolName")
  @segment("resourcePools")
  name: string;

  /**
   * Gets or sets the extended location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  kind?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ResourcePoolProperties;
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
  create is ArmResourceCreateOrReplaceAsync<
    ResourcePool,
    BaseParameters<ResourcePool>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the resourcePool resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ResourcePool, ResourcePatch>;

  /**
   * Implements resourcePool DELETE method.
   */
  delete is ArmResourceDeleteAsync<
    ResourcePool,
    {
      ...BaseParameters<ResourcePool>;

      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List of resourcePools in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourcePools_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ResourcePool>;

  /**
   * List of resourcePools in a subscription.
   */
  list is ArmListBySubscription<ResourcePool>;
}

@@projectedName(ResourcePools.create::parameters.resource, "json", "body");
@@extension(ResourcePools.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ResourcePools.create::parameters.resource, "Request payload.");
@@projectedName(ResourcePools.update::parameters.properties, "json", "body");
@@extension(ResourcePools.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(ResourcePools.update::parameters.properties,
  "Resource properties to update."
);
