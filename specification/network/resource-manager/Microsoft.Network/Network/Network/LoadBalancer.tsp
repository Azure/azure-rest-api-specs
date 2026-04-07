import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../Common/LoadBalancer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;

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

      /**
       * Controls verbosity of the returned load balancer resource. When set to 'Reduced', read-only back-reference collections (e.g., rules referencing frontendIPConfigurations) are omitted from the response.
       */
      @added(Versions.v2025_07_01)
      @query("detailLevel")
      detailLevel?: LoadBalancerDetailLevel;
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
