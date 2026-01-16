import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KubernetesConfiguration;
/**
 * The Flux Configuration object returned in Get & Put response.
 */
model FluxConfiguration
  is Azure.ResourceManager.ProxyResource<FluxConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = FluxConfiguration,
    KeyName = "fluxConfigurationName",
    SegmentName = "fluxConfigurations",
    NamePattern = ""
  >;
}

alias FluxConfigurationOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /**
     * The Kubernetes cluster RP - i.e. Microsoft.ContainerService, Microsoft.Kubernetes, Microsoft.HybridContainerService.
     */
    @path
    @segment("providers")
    @key
    clusterRp: string;

    /**
     * The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
     */
    @key
    @path
    @pattern("^[a-zA-Z]*$")
    clusterResourceName: string;

    /**
     * The name of the kubernetes cluster.
     */
    @key
    @path
    @pattern("^.*")
    clusterName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<FluxConfiguration>;
    ...ParentKeysOf<FluxConfiguration>;
  },
  {
    ...Extension.ExtensionProviderNamespace<FluxConfiguration>;
    ...KeysOf<FluxConfiguration>;
  }
>;

alias FluxConfigurationsBuildingOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /**
     * The Kubernetes cluster RP - i.e. Microsoft.ContainerService, Microsoft.Kubernetes, Microsoft.HybridContainerService.
     */
    @path
    @segment("providers")
    @key
    clusterRp: string;

    /**
     * The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters, appliances.
     */
    @key
    @path
    @pattern("^[a-zA-Z]*$")
    clusterResourceName: string;

    /**
     * The name of the kubernetes cluster.
     */
    @pattern("^.*")
    @key
    @path
    clusterName: string;

    ...KeysOf<FluxConfiguration>;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("operations")
    @key
    operationId: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface FluxConfigurations {
  /**
   * Gets details of the Flux Configuration.
   */
  get is FluxConfigurationOperationGroupOps.Read<FluxConfiguration>;

  /**
   * Create a new Kubernetes Flux Configuration.
   */
  createOrUpdate is FluxConfigurationOperationGroupOps.CreateOrUpdateAsync<FluxConfiguration>;

  /**
   * Update an existing Kubernetes Flux Configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is FluxConfigurationOperationGroupOps.CustomPatchAsync<
    FluxConfiguration,
    PatchModel = FluxConfigurationPatch,
    Response = ArmResponse<FluxConfiguration> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = FluxConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: FluxConfiguration;
    })
  >;

  /**
   * This will delete the YAML file used to set up the Flux Configuration, thus stopping future sync from the source repo.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is FluxConfigurationOperationGroupOps.DeleteWithoutOkAsync<
    FluxConfiguration,
    Parameters = {
      /**
       * Delete the extension resource in Azure - not the normal asynchronous delete.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Flux Configurations.
   */
  list is FluxConfigurationOperationGroupOps.List<
    FluxConfiguration,
    Response = ArmResponse<FluxConfigurationsList>
  >;

  /**
   * Get Async Operation status
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations/{fluxConfigurationName}/operations/{operationId}")
  fluxConfigOperationStatusGet is FluxConfigurationsBuildingOps.ActionSync<
    FluxConfiguration,
    void,
    ArmResponse<OperationStatusResult>
  >;
}

@@doc(FluxConfiguration.name, "Name of the Flux Configuration.");
@@doc(FluxConfiguration.properties,
  "Properties to create a Flux Configuration resource"
);
@@doc(FluxConfigurations.createOrUpdate::parameters.resource,
  "Properties necessary to Create a FluxConfiguration."
);
@@doc(FluxConfigurations.update::parameters.properties,
  "Properties to Patch in an existing Flux Configuration."
);
