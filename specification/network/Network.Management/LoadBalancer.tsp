import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * LoadBalancer resource.
 */
model LoadBalancer
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<LoadBalancerPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = LoadBalancer,
    KeyName = "loadBalancerName",
    SegmentName = "loadBalancers",
    NamePattern = ""
  >;

  /**
   * The extended location of the load balancer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  /**
   * The load balancer SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: LoadBalancerSku;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface LoadBalancers {
  /**
   * Gets the specified load balancer.
   */
  get is ArmResourceRead<
    LoadBalancer,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates a load balancer.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LoadBalancer>;

  /**
   * Updates a load balancer tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<LoadBalancer, PatchModel = TagsObject>;

  /**
   * Deletes the specified load balancer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    LoadBalancer,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the load balancers in a resource group.
   */
  list is ArmResourceListByParent<LoadBalancer>;

  /**
   * Gets all the load balancers in a subscription.
   */
  listAll is ArmListBySubscription<LoadBalancer>;

  /**
   * Migrate load balancer to IP Based
   */
  migrateToIpBased is ArmResourceActionSync<
    LoadBalancer,
    MigrateLoadBalancerToIpBasedRequest,
    ArmResponse<MigratedPools>,
    Parameters = {
      /**
       * The name of the resource group.
       */
      @pattern("^[a-z][a-z0-9]*$")
      @path
      groupName: string;
    },
    OptionalRequestBody = true
  >;

  /**
   * Gets associated load balancer network interfaces.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerNetworkInterfaces_List")
  @list
  @get
  @action("networkInterfaces")
  loadBalancerNetworkInterfacesList is ArmResourceActionSync<
    LoadBalancer,
    void,
    ArmResponse<ResourceListResult<NetworkInterface>>
  >;
}

@@doc(LoadBalancer.name, "The name of the load balancer.");
@@doc(LoadBalancer.properties, "Properties of load balancer.");
@@doc(LoadBalancers.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update load balancer operation."
);
@@doc(LoadBalancers.updateTags::parameters.properties,
  "Parameters supplied to update load balancer tags."
);
@@doc(LoadBalancers.migrateToIpBased::parameters.body,
  "Parameters supplied to the migrateToIpBased Api."
);
