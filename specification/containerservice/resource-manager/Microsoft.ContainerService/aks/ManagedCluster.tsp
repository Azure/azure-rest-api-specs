import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;
/**
 * Managed cluster.
 */
model ManagedCluster
  is Azure.ResourceManager.TrackedResource<ManagedClusterProperties> {
  ...ResourceNameParameter<
    Resource = ManagedCluster,
    KeyName = "resourceName",
    SegmentName = "managedClusters",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The managed cluster SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ManagedClusterSKU;

  /**
   * The extended location of the Virtual Machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * The identity of the managed cluster, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedClusterIdentity;

  /**
   * This is primarily used to expose different UI experiences in the portal for different kinds
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface ManagedClusters {
  /**
   * Gets a managed cluster.
   */
  @tag("ManagedClusters")
  get is ArmResourceRead<ManagedCluster>;

  /**
   * Creates or updates a managed cluster.
   */
  @tag("ManagedClusters")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedCluster,
    Parameters = {
      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;

      /**
       * The request should only proceed if no entity matches this string.
       */
      @header
      ifNoneMatch?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedCluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates tags on a managed cluster.
   */
  @tag("ManagedClusters")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    ManagedCluster,
    PatchModel = TagsObject,
    Parameters = {
      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Deletes a managed cluster.
   */
  @tag("ManagedClusters")
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedCluster,
    Parameters = {
      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;

      /**
       * ignore-pod-disruption-budget=true to delete those pods on a node without considering Pod Disruption Budget
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @added(Versions.v2025_10_02_preview)
      @query("ignore-pod-disruption-budget")
      `ignore-pod-disruption-budget`?: boolean;
    }
  >;

  /**
   * Lists managed clusters in the specified subscription and resource group.
   */
  @tag("ManagedClusters")
  listByResourceGroup is ArmResourceListByParent<ManagedCluster>;

  /**
   * Gets a list of managed clusters in the specified subscription.
   */
  @tag("ManagedClusters")
  list is ArmListBySubscription<ManagedCluster>;

  /**
   * **WARNING**: This API will be deprecated. Instead use [ListClusterUserCredentials](https://docs.microsoft.com/rest/api/aks/managedclusters/listclusterusercredentials) or [ListClusterAdminCredentials](https://docs.microsoft.com/rest/api/aks/managedclusters/listclusteradmincredentials) .
   */
  #deprecated "This API will be deprecated. Instead use [ListClusterUserCredentials](https://docs.microsoft.com/rest/api/aks/managedclusters/listclusterusercredentials) or [ListClusterAdminCredentials](https://docs.microsoft.com/rest/api/aks/managedclusters/listclusteradmincredentials) ."
  @tag("ManagedClusters")
  @action("listCredential")
  @summary("Gets an access profile of a managed cluster.")
  getAccessProfile is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<ManagedClusterAccessProfile>,
    Parameters = {
      /**
       * The name of the role for managed cluster accessProfile resource.
       */
      @path
      @segment("accessProfiles")
      roleName: string;
    }
  >;

  /**
   * Lists the admin credentials of a managed cluster.
   */
  @tag("ManagedClusters")
  @action("listClusterAdminCredential")
  listClusterAdminCredentials is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<CredentialResults>,
    Parameters = {
      /**
       * server fqdn type for credentials to be returned
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("server-fqdn")
      `server-fqdn`?: string;
    }
  >;

  /**
   * Lists the user credentials of a managed cluster.
   */
  @tag("ManagedClusters")
  @action("listClusterUserCredential")
  listClusterUserCredentials is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<CredentialResults>,
    Parameters = {
      /**
       * server fqdn type for credentials to be returned
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("server-fqdn")
      `server-fqdn`?: string;

      /**
       * Only apply to AAD clusters, specifies the format of returned kubeconfig. Format 'azure' will return azure auth-provider kubeconfig; format 'exec' will return exec format kubeconfig, which requires kubelogin binary in the path.
       */
      @query("format")
      format?: Format;
    }
  >;

  /**
   * Lists the cluster monitoring user credentials of a managed cluster.
   */
  @tag("ManagedClusters")
  @action("listClusterMonitoringUserCredential")
  listClusterMonitoringUserCredentials is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<CredentialResults>,
    Parameters = {
      /**
       * server fqdn type for credentials to be returned
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("server-fqdn")
      `server-fqdn`?: string;
    }
  >;

  /**
   * This action cannot be performed on a cluster that is not using a service principal
   */
  @tag("ManagedClusters")
  @summary("Reset the Service Principal Profile of a managed cluster.")
  resetServicePrincipalProfile is ArmResourceActionAsync<
    ManagedCluster,
    ManagedClusterServicePrincipalProfile,
    OkResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * **WARNING**: This API will be deprecated. Please see [AKS-managed Azure Active Directory integration](https://aka.ms/aks-managed-aad) to update your cluster with AKS-managed Azure AD.
   */
  #deprecated "This API will be deprecated. Please see [AKS-managed Azure Active Directory integration](https://aka.ms/aks-managed-aad) to update your cluster with AKS-managed Azure AD."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedClusters")
  @summary("Reset the AAD Profile of a managed cluster.")
  resetAADProfile is ArmResourceActionAsync<
    ManagedCluster,
    ManagedClusterAADProfile,
    OkResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * See [Certificate rotation](https://docs.microsoft.com/azure/aks/certificate-rotation) for more details about rotating managed cluster certificates.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedClusters")
  @summary("Rotates the certificates of a managed cluster.")
  rotateClusterCertificates is ArmResourceActionAsync<
    ManagedCluster,
    void,
    NoContentResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Aborts the currently running operation on the managed cluster. The Managed Cluster will be moved to a Canceling state and eventually to a Canceled state when cancellation finishes. If the operation completes before cancellation can take place, a 409 error code is returned.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedClusters")
  @action("abort")
  @summary("Aborts last operation running on managed cluster.")
  abortLatestOperation is ArmResourceActionAsync<
    ManagedCluster,
    void,
    NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Rotates the service account signing keys of a managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedClusters")
  rotateServiceAccountSigningKeys is ArmResourceActionAsync<
    ManagedCluster,
    void,
    NoContentResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * This can only be performed on Azure Virtual Machine Scale set backed clusters. Stopping a cluster stops the control plane and agent nodes entirely, while maintaining all object and cluster state. A cluster does not accrue charges while it is stopped. See [stopping a cluster](https://docs.microsoft.com/azure/aks/start-stop-cluster) for more details about stopping a cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedClusters")
  @summary("Stops a Managed Cluster")
  stop is ArmResourceActionAsync<
    ManagedCluster,
    void,
    NoContentResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * See [starting a cluster](https://docs.microsoft.com/azure/aks/start-stop-cluster) for more details about starting a cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedClusters")
  @summary("Starts a previously stopped Managed Cluster")
  start is ArmResourceActionAsync<
    ManagedCluster,
    void,
    NoContentResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * AKS will create a pod to run the command. This is primarily useful for private clusters. For more information see [AKS Run Command](https://docs.microsoft.com/azure/aks/private-clusters#aks-run-command-preview).
   */
  @tag("ManagedClusters")
  @summary("Submits a command to run against the Managed Cluster.")
  runCommand is ArmResourceActionAsync<
    ManagedCluster,
    RunCommandRequest,
    RunCommandResult
  >;

  /**
   * Gets the results of a command which has been run on the Managed Cluster.
   */
  @tag("ManagedClusters")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/commandResults/{commandId}")
  getCommandResult is ManagedClusterOps.ActionSync<
    ManagedCluster,
    void,
    ArmResponse<RunCommandResult> | (AcceptedResponse & LocationHeader),
    Parameters = {
      /**
       * Id of the command.
       */
      @path
      commandId: string;
    }
  >;

  /**
   * Gets a list of egress endpoints (network endpoints of all outbound dependencies) in the specified managed cluster. The operation returns properties of each egress endpoint.
   */
  @tag("ManagedClusters")
  @list
  @get
  @action("outboundNetworkDependenciesEndpoints")
  @summary("Gets a list of egress endpoints (network endpoints of all outbound dependencies) in the specified managed cluster.")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<OutboundEnvironmentEndpointCollection>
  >;

  /**
   * Rebalance nodes across specific load balancers.
   */
  @tag("ManagedClusters")
  @added(Versions.v2025_10_02_preview)
  rebalanceLoadBalancers is ArmResourceActionAsyncBase<
    ManagedCluster,
    RebalanceLoadBalancersRequestBody,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ManagedCluster>
  >;

  /**
   * See [supported Kubernetes versions](https://docs.microsoft.com/azure/aks/supported-kubernetes-versions) for more details about the version lifecycle.
   */
  @tag("AgentPools")
  @get
  @action("availableAgentPoolVersions")
  @summary("Gets a list of supported Kubernetes versions for the specified agent pool.")
  getAvailableAgentPoolVersions is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<AgentPoolAvailableVersions>
  >;

  /**
   * To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters
   */
  @tag("privateLinkResources")
  @get
  @action("privateLinkResources")
  @summary("Gets a list of private link resources in the specified managed cluster.")
  privateLinkResourcesList is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<PrivateLinkResourcesListResult>
  >;

  /**
   * Gets the private link service ID for the specified managed cluster.
   */
  @tag("resolvePrivateLinkServiceId")
  @action("resolvePrivateLinkServiceId")
  post is ArmResourceActionSync<
    ManagedCluster,
    PrivateLinkResource,
    ArmResponse<PrivateLinkResource>
  >;

  /**
   * Gets a list of operations in the specified managedCluster
   */
  @tag("ManagedClusters")
  @list
  @get
  @action("operations")
  @added(Versions.v2025_10_02_preview)
  operationStatusResultList is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<OperationStatusResultList>
  >;

  /**
   * Get the status of a specific operation in the specified managed cluster.
   */
  @tag("ManagedClusters")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerService/managedClusters/{resourceName}/operations/{operationId}")
  @added(Versions.v2025_10_02_preview)
  operationStatusResultGet is ManagedClusterOps.ActionSync<
    ManagedCluster,
    void,
    ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>,
    Parameters = {
      /**
       * The ID of an ongoing async operation.
       */
      @minLength(1)
      @path
      operationId: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface ManagedClusterOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      {
        ...KeysOf<ManagedCluster>,
      },
      ErrorResponse,
      #{ useStaticRoute: true }
    > {}

@@maxLength(ManagedCluster.name, 63);
@@minLength(ManagedCluster.name, 1);
@@doc(ManagedCluster.name, "The name of the managed cluster resource.");
@@doc(ManagedCluster.properties, "Properties of a managed cluster.");
@@doc(ManagedClusters.createOrUpdate::parameters.resource,
  "The managed cluster to create or update."
);
@@doc(ManagedClusters.updateTags::parameters.properties,
  "Parameters supplied to the Update Managed Cluster Tags operation."
);
@@doc(ManagedClusters.resetServicePrincipalProfile::parameters.body,
  "The service principal profile to set on the managed cluster."
);
@@doc(ManagedClusters.resetAADProfile::parameters.body,
  "The AAD profile to set on the Managed Cluster"
);
@@doc(ManagedClusters.runCommand::parameters.body, "The run command request");
@@doc(ManagedClusters.rebalanceLoadBalancers::parameters.body,
  "The names of the load balancers to be rebalanced. If set to empty, all load balancers will be rebalanced."
);
@@doc(ManagedClusters.post::parameters.body,
  "Parameters required in order to resolve a private link service ID."
);
