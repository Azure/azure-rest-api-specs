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
 * The Extension object.
 */
model Extension is Azure.ResourceManager.ProxyResource<ExtensionProperties> {
  ...ResourceNameParameter<
    Resource = Extension,
    KeyName = "extensionName",
    SegmentName = "extensions",
    NamePattern = ""
  >;

  /**
   * Identity of the Extension resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.Identity;

  ...Azure.ResourceManager.ResourcePlanProperty;
}

alias ExtensionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<Extension>;
    ...ParentKeysOf<Extension>;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<Extension>;
    ...KeysOf<Extension>;
  }
>;

alias ExtensionBuildingOps = Azure.ResourceManager.Legacy.RoutedOperations<
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

    ...KeysOf<Extension>;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("operations")
    @key
    operationId: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface Extensions {
  /**
   * Gets Kubernetes Cluster Extension.
   */
  get is ExtensionOps.Read<Extension>;

  /**
   * Create a new Kubernetes Cluster Extension.
   */
  create is ExtensionOps.CreateOrUpdateAsync<Extension>;

  /**
   * Patch an existing Kubernetes Cluster Extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ExtensionOps.CustomPatchAsync<
    Extension,
    PatchModel = PatchExtension,
    Parameters = {},
    Response = ArmResponse<Extension> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Extension> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Extension;
    })
  >;

  /**
   * Delete a Kubernetes Cluster Extension. This will cause the Agent to Uninstall the extension from the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ExtensionOps.DeleteWithoutOkAsync<
    Extension,
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
   * List all Extensions in the cluster.
   */
  list is ExtensionOps.List<Extension, Response = ArmResponse<ExtensionsList>>;

  /**
   * Get Async Operation status
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions/{extensionName}/operations/{operationId}")
  operationStatusGet is ExtensionBuildingOps.ActionSync<
    Extension,
    void,
    ArmResponse<OperationStatusResult>
  >;
}

@@doc(Extension.name, "Name of the Extension.");
@@doc(Extension.properties, "Properties of an Extension resource");
@@doc(Extensions.create::parameters.resource,
  "Properties necessary to Create an Extension."
);
@@doc(Extensions.update::parameters.properties,
  "Properties to Patch in an existing Extension."
);
