import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
@doc("The HDInsight cluster application")
@parentResource(Cluster)
model Application is ProxyResource<ApplicationProperties> {
  @doc("The constant value for the application name.")
  @path
  @key("applicationName")
  @segment("applications")
  name: string;

  @doc("The ETag for the application")
  etag?: string;
}

@armResourceOperations
interface Applications {
  @doc("Gets properties of the specified application.")
  get is ArmResourceRead<Application>;

  @doc("Creates applications for the HDInsight cluster.")
  create is ArmResourceCreateOrUpdateAsync<
    Application,
    BaseParameters<Application>,
    ArmLroLocationHeader
  >;

  @doc("Deletes the specified application on the HDInsight cluster.")
  delete is ArmResourceDeleteAsync<
    Application,
    BaseParameters<Application>,
    ArmLroLocationHeader
  >;

  @doc("Lists all of the applications for the HDInsight cluster.")
  listByCluster is ArmResourceListByParent<Application>;

  @doc("Gets the async operation status.")
  // FIXME: Applications_GetAzureAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/applications/{applicationName}/azureasyncoperations/{operationId}")
  @get
  getAzureAsyncOperationStatus is Azure.Core.Foundations.Operation<
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

@@projectedName(Applications.create::parameters.resource, "json", "parameters");
@@extension(Applications.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Applications.create::parameters.resource,
  "The application create request."
);
