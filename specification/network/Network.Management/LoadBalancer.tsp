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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@Http.Private.includeInapplicableMetadataInPayload(false)
model LoadBalancer extends Resource {
  properties?: LoadBalancerPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("loadBalancerName")
  @segment("loadBalancers")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The extended location of the load balancer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * The load balancer SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: LoadBalancerSku;
}

alias LoadBalancerLoadBalancerOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("resourceGroups")
    @pattern("^[a-z][a-z0-9]*$")
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the load balancer. */
    @path
    @segment("loadBalancers")
    @key
    @pattern("^[a-z][a-z0-9]*$")
    loadBalancerName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a load balancer.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LoadBalancer,
    Error = CloudError
  >;

  /**
   * Updates a load balancer tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    LoadBalancer,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified load balancer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    LoadBalancer,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the load balancers in a resource group.
   */
  list is ArmResourceListByParent<LoadBalancer, Error = CloudError>;

  /**
   * Gets all the load balancers in a subscription.
   */
  listAll is ArmListBySubscription<LoadBalancer, Error = CloudError>;

  /**
   * Migrate load balancer to IP Based
   */
  migrateToIpBased is LoadBalancerLoadBalancerOps.ActionSync<
    LoadBalancer,
    MigrateLoadBalancerToIpBasedRequest,
    Response = ArmResponse<MigratedPools>,
    OptionalRequestBody = true,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets associated load balancer network interfaces.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerNetworkInterfaces_List")
  @list
  @get
  @action("networkInterfaces")
  loadBalancerNetworkInterfacesList is ArmResourceActionSync<
    LoadBalancer,
    void,
    ArmResponse<ResourceListResult<NetworkInterface>>,
    Error = CloudError
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
