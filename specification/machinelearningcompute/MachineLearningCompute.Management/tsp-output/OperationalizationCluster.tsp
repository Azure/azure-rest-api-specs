import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MachineLearningCompute;
@doc("Instance of an Azure ML Operationalization Cluster resource.")
model OperationalizationCluster
  is TrackedResource<OperationalizationClusterProperties> {
  @doc("The name of the cluster.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z][-\\w\\._\\(\\)]+[a-zA-Z0-9]$")
  @key("clusterName")
  @segment("operationalizationClusters")
  name: string;
}

@armResourceOperations
interface OperationalizationClusters {
  @doc("Gets the operationalization cluster resource view. Note that the credentials are not returned by this call. Call ListKeys to get them.")
  get is ArmResourceRead<OperationalizationCluster>;
  @doc("Create or update an operationalization cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OperationalizationCluster>;
  @doc("The PATCH operation can be used to update only the tags for a cluster. Use PUT operation to update other properties.")
  update is ArmCustomPatchSync<
    OperationalizationCluster,
    OperationalizationClusterUpdateParameters
  >;
  @doc("Deletes the specified cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    OperationalizationCluster,
    {
      ...BaseParameters<OperationalizationCluster>;

      @doc("If true, deletes all resources associated with this cluster.")
      @query("deleteAll")
      deleteAll?: boolean;
    }
  >;
  @doc("Gets the clusters in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    OperationalizationCluster,
    {
      ...BaseParameters<OperationalizationCluster>;

      @doc("Continuation token for pagination.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
  @doc("Gets the operationalization clusters in the specified subscription.")
  listBySubscriptionId is ArmListBySubscription<OperationalizationCluster>;
  @doc("Gets the credentials for the specified cluster such as Storage, ACR and ACS credentials. This is a long running operation because it fetches keys from dependencies.")
  listKeys is ArmResourceActionSync<
    OperationalizationCluster,
    void,
    OperationalizationClusterCredentials
  >;
  @doc("Checks if updates are available for system services in the cluster.")
  checkSystemServicesUpdatesAvailable is ArmResourceActionSync<
    OperationalizationCluster,
    void,
    CheckSystemServicesUpdatesAvailableResponse
  >;
  @doc("Updates system services in a cluster.")
  updateSystemServices is ArmResourceActionAsync<
    OperationalizationCluster,
    void,
    UpdateSystemServicesResponse
  >;
}
