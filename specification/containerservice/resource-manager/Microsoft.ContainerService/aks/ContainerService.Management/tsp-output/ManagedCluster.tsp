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

namespace Microsoft.ContainerService;
@doc("Managed cluster.")
model ManagedCluster is TrackedResource<ManagedClusterProperties> {
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
interface ManagedClusters {
  @doc("Gets a managed cluster.")
  get is ArmResourceRead<ManagedCluster>;

  @doc("Creates or updates a managed cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedCluster>;

  @doc("Updates tags on a managed cluster.")
  updateTags is ArmCustomPatchAsync<ManagedCluster, TagsObject>;

  @doc("Deletes a managed cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedCluster,
    {
      ...BaseParameters<ManagedCluster>;

      @doc("ignore-pod-disruption-budget=true to delete those pods on a node without considering Pod Disruption Budget")
      @query("ignore-pod-disruption-budget")
      `ignore-pod-disruption-budget`?: boolean;
    }
  >;

  @doc("Lists managed clusters in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<ManagedCluster>;

  @doc("Gets a list of managed clusters in the specified subscription.")
  list is ArmListBySubscription<ManagedCluster>;

  @doc("**WARNING**: This API will be deprecated. Instead use [ListClusterUserCredentials](https://docs.microsoft.com/rest/api/aks/managedclusters/listclusterusercredentials) or [ListClusterAdminCredentials](https://docs.microsoft.com/rest/api/aks/managedclusters/listclusteradmincredentials) .")
  getAccessProfile is ArmResourceActionSync<
    ManagedCluster,
    void,
    ManagedClusterAccessProfile,
    {
      ...BaseParameters<ManagedCluster>;

      @doc("The name of the role for managed cluster accessProfile resource.")
      @path
      roleName: string;
    }
  >;

  @doc("Lists the admin credentials of a managed cluster.")
  listClusterAdminCredentials is ArmResourceActionSync<
    ManagedCluster,
    void,
    CredentialResults,
    {
      ...BaseParameters<ManagedCluster>;

      @doc("server fqdn type for credentials to be returned")
      @query("server-fqdn")
      `server-fqdn`?: string;
    }
  >;

  @doc("Lists the user credentials of a managed cluster.")
  listClusterUserCredentials is ArmResourceActionSync<
    ManagedCluster,
    void,
    CredentialResults,
    {
      ...BaseParameters<ManagedCluster>;

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
    ManagedCluster,
    void,
    CredentialResults,
    {
      ...BaseParameters<ManagedCluster>;

      @doc("server fqdn type for credentials to be returned")
      @query("server-fqdn")
      `server-fqdn`?: string;
    }
  >;

  @doc("This action cannot be performed on a cluster that is not using a service principal")
  resetServicePrincipalProfile is ArmResourceActionAsync<
    ManagedCluster,
    ManagedClusterServicePrincipalProfile,
    void,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Reset the AAD Profile of a managed cluster.")
  @operationId("ManagedClusters_ResetAADProfile")
  resetAADProfile is ArmResourceActionAsync<
    ManagedCluster,
    ManagedClusterAADProfile,
    void,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  @doc("Aborts the currently running operation on the managed cluster. The Managed Cluster will be moved to a Canceling state and eventually to a Canceled state when cancellation finishes. If the operation completes before cancellation can take place, an error is returned.")
  abortLatestOperation is ArmResourceActionNoResponseContentAsync<
    ManagedCluster,
    void,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  @doc("See [Certificate rotation](https://docs.microsoft.com/azure/aks/certificate-rotation) for more details about rotating managed cluster certificates.")
  rotateClusterCertificates is ArmResourceActionNoResponseContentAsync<
    ManagedCluster,
    void,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  @doc("Rotates the service account signing keys of a managed cluster.")
  rotateServiceAccountSigningKeys is ArmResourceActionNoResponseContentAsync<
    ManagedCluster,
    void,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  @doc("This can only be performed on Azure Virtual Machine Scale set backed clusters. Stopping a cluster stops the control plane and agent nodes entirely, while maintaining all object and cluster state. A cluster does not accrue charges while it is stopped. See [stopping a cluster](https://docs.microsoft.com/azure/aks/start-stop-cluster) for more details about stopping a cluster.")
  stop is ArmResourceActionNoResponseContentAsync<
    ManagedCluster,
    void,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  @doc("See [starting a cluster](https://docs.microsoft.com/azure/aks/start-stop-cluster) for more details about starting a cluster.")
  start is ArmResourceActionNoResponseContentAsync<
    ManagedCluster,
    void,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  @doc("AKS will create a pod to run the command. This is primarily useful for private clusters. For more information see [AKS Run Command](https://docs.microsoft.com/azure/aks/private-clusters#aks-run-command-preview).")
  runCommand is ArmResourceActionAsync<
    ManagedCluster,
    RunCommandRequest,
    RunCommandResult,
    BaseParameters<ManagedCluster>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the private link service ID for the specified managed cluster.")
  @operationId("ResolvePrivateLinkServiceId_POST")
  pOST is ArmResourceActionSync<
    ManagedCluster,
    PrivateLinkResource,
    PrivateLinkResource
  >;

  @summary("Gets the results of a command which has been run on the Managed Cluster.")
  @doc("Gets the results of a command which has been run on the Managed Cluster.")
  // FIXME: ManagedClusters_GetCommandResult could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/commandResults/{commandId}")
  @get
  getCommandResult is Azure.Core.Foundations.Operation<
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
  // FIXME: ManagedClusters_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AgentPools_GetAvailableAgentPoolVersions")
  @summary("Gets a list of supported Kubernetes versions for the specified agent pool.")
  @doc("See [supported Kubernetes versions](https://docs.microsoft.com/azure/aks/supported-kubernetes-versions) for more details about the version lifecycle.")
  // FIXME: AgentPools_GetAvailableAgentPoolVersions could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/availableAgentPoolVersions")
  @get
  getAvailableAgentPoolVersions is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_List")
  @summary("Gets a list of private link resources in the specified managed cluster.")
  @doc("To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters")
  // FIXME: PrivateLinkResources_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{resourceName}/privateLinkResources")
  @get
  list is Azure.Core.Foundations.Operation<
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

@@projectedName(ManagedClusters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedClusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedClusters.createOrUpdate::parameters.resource,
  "The managed cluster to create or update."
);
@@projectedName(ManagedClusters.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(ManagedClusters.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedClusters.updateTags::parameters.properties,
  "Parameters supplied to the Update Managed Cluster Tags operation."
);
@@projectedName(ManagedClusters.resetServicePrincipalProfile::parameters.body,
  "json",
  "parameters"
);
@@extension(ManagedClusters.resetServicePrincipalProfile::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedClusters.resetServicePrincipalProfile::parameters.body,
  "The service principal profile to set on the managed cluster."
);
@@projectedName(ManagedClusters.resetAADProfile::parameters.body,
  "json",
  "parameters"
);
@@extension(ManagedClusters.resetAADProfile::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedClusters.resetAADProfile::parameters.body,
  "The AAD profile to set on the Managed Cluster"
);
@@projectedName(ManagedClusters.runCommand::parameters.body,
  "json",
  "requestPayload"
);
@@extension(ManagedClusters.runCommand::parameters.body,
  "x-ms-client-name",
  "requestPayload"
);
@@doc(ManagedClusters.runCommand::parameters.body, "The run command request");
@@projectedName(ManagedClusters.pOST::parameters.body, "json", "parameters");
@@extension(ManagedClusters.pOST::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedClusters.pOST::parameters.body,
  "Parameters required in order to resolve a private link service ID."
);
