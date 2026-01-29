import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ExtensionType.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KubernetesConfiguration;
/**
 * The Extension Type Version object.
 */
@subscriptionResource
@parentResource(ExtensionType)
model ExtensionTypeVersionForReleaseTrain
  is Azure.ResourceManager.ProxyResource<ExtensionTypeVersionForReleaseTrainProperties> {
  ...ResourceNameParameter<
    Resource = ExtensionTypeVersionForReleaseTrain,
    KeyName = "versionNumber",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias ExtensionTypeVersionForReleaseTrainOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.KubernetesConfiguration";

    ...LocationParameter;

    /** Name of the Extension Type. */
    @path
    @segment("extensionTypes")
    @key
    @pattern("^[a-zA-Z][a-zA-Z0-9-_]*$")
    extensionTypeName: string;
  },
  {},
  {
    /** Version number of the Extension Type. */
    @path
    @segment("versions")
    @key
    versionNumber: string;
  }
>;

@armResourceOperations
interface ExtensionTypeVersionForReleaseTrains {
  /**
   * Get details of a version for an extension type and location
   */
  getVersion is ExtensionTypeVersionForReleaseTrainOps.Read<ExtensionTypeVersionForReleaseTrain>;

  /**
   * List the versions for an extension type and location.
   */
  listVersions is ExtensionTypeVersionForReleaseTrainOps.List<
    ExtensionTypeVersionForReleaseTrain,
    Parameters = {
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

      /**
       * Filter results by the major version of an extension type
       */
      @query("majorVersion")
      majorVersion?: string;

      /**
       * Filter results by only the latest version (based on other query parameters)
       */
      @query("showLatest")
      showLatest?: boolean;
    },
    Response = ArmResponse<ExtensionTypeVersionsList>
  >;
}
alias ExtensionTypeVersionForReleaseTrainOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    ...Extension.ExtensionProviderNamespace<ExtensionTypeVersionForReleaseTrain>;
    ...KeysOf<ExtensionType>;
  },
  {
    ...Extension.ExtensionProviderNamespace<ExtensionTypeVersionForReleaseTrain>;
    ...KeysOf<ExtensionType>;

    /** Version number of the Extension Type. */
    @path
    @segment("versions")
    @key
    versionNumber: string;
  }
>;

@armResourceOperations
interface ExtensionTypeVersionForReleaseTrainOperationGroup {
  /**
   * Get details of a version for an Extension Type installable to the cluster.
   */
  clusterGetVersion is ExtensionTypeVersionForReleaseTrainOperationGroupOps.Read<ExtensionTypeVersionForReleaseTrain>;

  /**
   * List the version for an Extension Type installable to the cluster.
   */
  clusterListVersions is ExtensionTypeVersionForReleaseTrainOperationGroupOps.List<
    ExtensionTypeVersionForReleaseTrain,
    Parameters = {
      /**
       * Filter results by release train (default value is stable)
       */
      @query("releaseTrain")
      releaseTrain?: string;

      /**
       * Filter results by the major version of an extension type
       */
      @query("majorVersion")
      majorVersion?: string;

      /**
       * Filter results by only the latest version (based on other query parameters)
       */
      @query("showLatest")
      showLatest?: boolean;
    },
    Response = ArmResponse<ExtensionTypeVersionsList>
  >;
}

@@doc(ExtensionTypeVersionForReleaseTrain.name,
  "Version number of the Extension Type."
);
@@doc(ExtensionTypeVersionForReleaseTrain.properties, "");
