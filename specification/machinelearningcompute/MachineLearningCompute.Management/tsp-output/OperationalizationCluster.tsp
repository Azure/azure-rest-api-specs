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

namespace Microsoft.MachineLearningCompute;
/**
 * Instance of an Azure ML Operationalization Cluster resource.
 */
model OperationalizationCluster
  is TrackedResource<OperationalizationClusterProperties> {
  /**
   * The name of the cluster.
   */
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z][-\\w\\._\\(\\)]+[a-zA-Z0-9]$")
  @path
  @key("clusterName")
  @segment("operationalizationClusters")
  name: string;
}

@armResourceOperations
interface OperationalizationClusters {
  /**
   * Gets the operationalization cluster resource view. Note that the credentials are not returned by this call. Call ListKeys to get them.
   */
  get is ArmResourceRead<OperationalizationCluster>;

  /**
   * Create or update an operationalization cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OperationalizationCluster>;

  /**
   * The PATCH operation can be used to update only the tags for a cluster. Use PUT operation to update other properties.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    OperationalizationCluster,
    OperationalizationClusterUpdateParameters
  >;

  /**
   * Deletes the specified cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    OperationalizationCluster,
    {
      ...BaseParameters<OperationalizationCluster>;

      /**
       * If true, deletes all resources associated with this cluster.
       */
      @query("deleteAll")
      deleteAll?: boolean;
    }
  >;

  /**
   * Gets the clusters in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("OperationalizationClusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    OperationalizationCluster,
    {
      ...BaseParameters<OperationalizationCluster>;

      /**
       * Continuation token for pagination.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Gets the operationalization clusters in the specified subscription.
   */
  listBySubscriptionId is ArmListBySubscription<OperationalizationCluster>;

  /**
   * Gets the credentials for the specified cluster such as Storage, ACR and ACS credentials. This is a long running operation because it fetches keys from dependencies.
   */
  listKeys is ArmResourceActionSync<
    OperationalizationCluster,
    void,
    OperationalizationClusterCredentials
  >;

  /**
   * Checks if updates are available for system services in the cluster.
   */
  checkSystemServicesUpdatesAvailable is ArmResourceActionSync<
    OperationalizationCluster,
    void,
    CheckSystemServicesUpdatesAvailableResponse
  >;

  /**
   * Updates system services in a cluster.
   */
  updateSystemServices is ArmResourceActionAsync<
    OperationalizationCluster,
    void,
    UpdateSystemServicesResponse
  >;
}

@@projectedName(OperationalizationClusters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(OperationalizationClusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(OperationalizationClusters.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update an Operationalization cluster."
);
@@projectedName(OperationalizationClusters.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(OperationalizationClusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(OperationalizationClusters.update::parameters.properties,
  "The parameters supplied to patch the cluster."
);
