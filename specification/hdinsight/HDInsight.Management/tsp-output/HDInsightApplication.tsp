import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HDInsightCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HDInsight;
@doc("The HDInsight cluster application")
@parentResource(HDInsightCluster)
model HDInsightApplication is ProxyResource<ApplicationProperties> {
  @doc("The constant value for the application name.")
  @path
  @key("applicationName")
  @segment("applications")
  name: string;
}

@armResourceOperations
interface HDInsightApplications {
  @doc("Gets properties of the specified application.")
  get is ArmResourceRead<HDInsightApplication>;
  @doc("Creates applications for the HDInsight cluster.")
  create is ArmResourceCreateOrUpdateAsync<HDInsightApplication>;
  @doc("Deletes the specified application on the HDInsight cluster.")
  delete is ArmResourceDeleteAsync<HDInsightApplication>;
  @doc("Lists all of the applications for the HDInsight cluster.")
  listByCluster is ArmResourceListByParent<HDInsightApplication>;
  @doc("Gets the async operation status.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/applications/{applicationName}/azureasyncoperations/{operationId}")
  @get
  GetAzureAsyncOperationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The constant value for the application name.")
      @path
      applicationName: string;

      @doc("The long running operation id.")
      @path
      operationId: string;
    },
    AsyncOperationResult
  >;
}
