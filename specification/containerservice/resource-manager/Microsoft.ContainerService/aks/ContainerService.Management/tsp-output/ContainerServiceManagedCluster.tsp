import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;
@doc("Managed cluster.")
model ContainerServiceManagedCluster
  is TrackedResource<ManagedClusterProperties> {
  @doc("The name of the managed cluster resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("resourceName")
  @segment("managedClusters")
  name: string;

  @doc("The extended location of the Virtual Machine.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ContainerServiceManagedClusters {
  @doc("Gets a managed cluster.")
  get is ArmResourceRead<ContainerServiceManagedCluster>;
  @doc("Creates or updates a managed cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ContainerServiceManagedCluster>;
  @doc("Updates tags on a managed cluster.")
  updateTags is ArmTagsPatchAsync<ContainerServiceManagedCluster>;
  @doc("Deletes a managed cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ContainerServiceManagedCluster,
    {
      ...BaseParameters<ContainerServiceManagedCluster>;

      @doc("ignore-pod-disruption-budget=true to delete those pods on a node without considering Pod Disruption Budget")
      @query("ignore-pod-disruption-budget")
      `ignore-pod-disruption-budget`?: boolean;
    }
  >;
  @doc("Lists managed clusters in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<ContainerServiceManagedCluster>;
  @doc("Gets a list of managed clusters in the specified subscription.")
  list is ArmListBySubscription<ContainerServiceManagedCluster>;
  @doc("**WARNING**: This API will be deprecated. Instead use [ListClusterUserCredentials](https://docs.microsoft.com/rest/api/aks/managedclusters/listclusterusercredentials) or [ListClusterAdminCredentials](https://docs.microsoft.com/rest/api/aks/managedclusters/listclusteradmincredentials) .")
  getAccessProfile is ArmResourceActionSync<
    ContainerServiceManagedCluster,
    void,
    ManagedClusterAccessProfile,
    {
      ...BaseParameters<ContainerServiceManagedCluster>;

      @doc("The name of the role for managed cluster accessProfile resource.")
      @path
      roleName: string;
    }
  >;
  @doc("Lists the admin credentials of a managed cluster.")
  listClusterAdminCredentials is ArmResourceActionSync<
    ContainerServiceManagedCluster,
    void,
    CredentialResults,
    {
      ...BaseParameters<ContainerServiceManagedCluster>;

      @doc("server fqdn type for credentials to be returned")
      @query("server-fqdn")
      `server-fqdn`?: string;
    }
  >;
  @doc("Lists the user credentials of a managed cluster.")
  listClusterUserCredentials is ArmResourceActionSync<
    ContainerServiceManagedCluster,
    void,
    CredentialResults,
    {
      ...BaseParameters<ContainerServiceManagedCluster>;

      @doc("server fqdn type for credentials to be returned")
      @query("server-fqdn")
      `server-fqdn`?: string;

      @doc("Only apply to AAD clusters, specifies the format of returned kubeconfig. Format 'azure' will return azure auth-provider kubeconfig; format 'exec' will return exec format kubeconfig, which requires kubelogin binary in the path.")
      @query("format")
      format?: Format;
    }
  >;
  @doc("Lists the cluster monitoring user credentials of a managed cluster.")
  listClusterMonitoringUserCredentials is ArmResourceActionSync<
    ContainerServiceManagedCluster,
    void,
    CredentialResults,
    {
      ...BaseParameters<ContainerServiceManagedCluster>;

      @doc("server fqdn type for credentials to be returned")
      @query("server-fqdn")
      `server-fqdn`?: string;
    }
  >;
  @doc("This action cannot be performed on a cluster that is not using a service principal")
  resetServicePrincipalProfile is ArmResourceActionAsync<
    ContainerServiceManagedCluster,
    ManagedClusterServicePrincipalProfile,
    void
  >;
  @doc("Reset the AAD Profile of a managed cluster.")
  resetAADProfile is ArmResourceActionAsync<
    ContainerServiceManagedCluster,
    ManagedClusterAADProfile,
    void
  >;
  @doc("Aborts the currently running operation on the managed cluster. The Managed Cluster will be moved to a Canceling state and eventually to a Canceled state when cancellation finishes. If the operation completes before cancellation can take place, an error is returned.")
  abortLatestOperation is ArmResourceActionNoResponseContentAsync<
    ContainerServiceManagedCluster,
    void
  >;
  @doc("See [Certificate rotation](https://docs.microsoft.com/azure/aks/certificate-rotation) for more details about rotating managed cluster certificates.")
  rotateClusterCertificates is ArmResourceActionNoResponseContentAsync<
    ContainerServiceManagedCluster,
    void
  >;
  @doc("Rotates the service account signing keys of a managed cluster.")
  rotateServiceAccountSigningKeys is ArmResourceActionNoResponseContentAsync<
    ContainerServiceManagedCluster,
    void
  >;
  @doc("This can only be performed on Azure Virtual Machine Scale set backed clusters. Stopping a cluster stops the control plane and agent nodes entirely, while maintaining all object and cluster state. A cluster does not accrue charges while it is stopped. See [stopping a cluster](https://docs.microsoft.com/azure/aks/start-stop-cluster) for more details about stopping a cluster.")
  stop is ArmResourceActionNoResponseContentAsync<
    ContainerServiceManagedCluster,
    void
  >;
  @doc("See [starting a cluster](https://docs.microsoft.com/azure/aks/start-stop-cluster) for more details about starting a cluster.")
  start is ArmResourceActionNoResponseContentAsync<
    ContainerServiceManagedCluster,
    void
  >;
  @doc("AKS will create a pod to run the command. This is primarily useful for private clusters. For more information see [AKS Run Command](https://docs.microsoft.com/azure/aks/private-clusters#aks-run-command-preview).")
  runCommand is ArmResourceActionAsync<
    ContainerServiceManagedCluster,
    RunCommandRequest,
    RunCommandResult
  >;
  @doc("Gets the private link service ID for the specified managed cluster.")
  pOST is ArmResourceActionSync<
    ContainerServiceManagedCluster,
    PrivateLinkResource,
    PrivateLinkResource
  >;
  @summary("Gets the results of a command which has been run on the Managed Cluster.")
  @doc("Gets the results of a command which has been run on the Managed Cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/commandResults/{commandId}")
  @get
  GetCommandResult is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the managed cluster resource.")
      @maxLength(63)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
      @path
      resourceName: string;

      @doc("Id of the command.")
      @path
      commandId: string;
    },
    RunCommandResult | void
  >;

  @summary("Gets a list of egress endpoints (network endpoints of all outbound dependencies) in the specified managed cluster.")
  @doc("Gets a list of egress endpoints (network endpoints of all outbound dependencies) in the specified managed cluster. The operation returns properties of each egress endpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/outboundNetworkDependenciesEndpoints")
  @get
  ListOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the managed cluster resource.")
      @maxLength(63)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
      @path
      resourceName: string;
    },
    OutboundEnvironmentEndpointCollection
  >;

  @summary("Gets a list of supported Kubernetes versions for the specified agent pool.")
  @doc("See [supported Kubernetes versions](https://docs.microsoft.com/azure/aks/supported-kubernetes-versions) for more details about the version lifecycle.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/availableAgentPoolVersions")
  @get
  GetAvailableAgentPoolVersions is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the managed cluster resource.")
      @maxLength(63)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
      @path
      resourceName: string;
    },
    AgentPoolAvailableVersions
  >;

  @summary("Gets a list of private link resources in the specified managed cluster.")
  @doc("To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/privateLinkResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the managed cluster resource.")
      @maxLength(63)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
      @path
      resourceName: string;
    },
    PrivateLinkResourcesListResult
  >;
}
