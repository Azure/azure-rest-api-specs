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
 * The Extension Type object.
 */
@subscriptionResource
model ExtensionType
  is Azure.ResourceManager.ProxyResource<ExtensionTypeProperties> {
  ...ResourceNameParameter<
    Resource = ExtensionType,
    KeyName = "extensionTypeName",
    SegmentName = "extensionTypes",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-_]*$"
  >;
}

alias ExtensionTypeOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.KubernetesConfiguration";

    ...LocationParameter;
  },
  {},
  {
    /** Name of the Extension Type. */
    @path
    @segment("extensionTypes")
    @key
    @pattern("^[a-zA-Z][a-zA-Z0-9-_]*$")
    extensionTypeName: string;
  }
>;

@armResourceOperations
interface ExtensionTypes {
  /**
   * Get an extension type for the location.
   */
  locationGet is ExtensionTypeOps.Read<ExtensionType>;

  /**
   * List all Extension Types for the location.
   */
  locationList is ExtensionTypeOps.List<
    ExtensionType,
    Parameters = {
      /**
       * Filter results by Publisher ID of a marketplace extension type
       */
      @query("publisherId")
      publisherId?: string;

      /**
       * Filter results by Offer or Product ID of a marketplace extension type
       */
      @query("offerId")
      offerId?: string;

      /**
       * Filter results by Plan ID of a marketplace extension type
       */
      @query("planId")
      planId?: string;

      /**
       * Filter results by release train (default value is stable)
       */
      @query("releaseTrain")
      releaseTrain?: string;

      /**
       * Filter results by the cluster type for extension types
       */
      @query("clusterType")
      clusterType?: string;
    },
    Response = ArmResponse<ExtensionTypesList>
  >;
}
alias ExtensionTypeOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    ...Extension.ExtensionProviderNamespace<ExtensionType>;
    ...ParentKeysOf<ExtensionType>;
  },
  {
    ...Extension.ExtensionProviderNamespace<ExtensionType>;
    ...KeysOf<ExtensionType>;
  }
>;

@armResourceOperations
interface ExtensionTypeOperationGroup {
  /**
   * Get an Extension Type installable to the cluster based region and type for the cluster.
   */
  get is ExtensionTypeOperationGroupOps.Read<ExtensionType>;

  /**
   * List installable Extension Types for the cluster based region and type for the cluster.
   */
  list is ExtensionTypeOperationGroupOps.List<
    ExtensionType,
    Parameters = {
      /**
       * Filter results by Publisher ID of a marketplace extension type
       */
      @query("publisherId")
      publisherId?: string;

      /**
       * Filter results by Offer or Product ID of a marketplace extension type
       */
      @query("offerId")
      offerId?: string;

      /**
       * Filter results by Plan ID of a marketplace extension type
       */
      @query("planId")
      planId?: string;

      /**
       * Filter results by release train (default value is stable)
       */
      @query("releaseTrain")
      releaseTrain?: string;
    },
    Response = ArmResponse<ExtensionTypesList>
  >;
}

@@doc(ExtensionType.name, "Name of the Extension Type.");
@@doc(ExtensionType.properties, "");
