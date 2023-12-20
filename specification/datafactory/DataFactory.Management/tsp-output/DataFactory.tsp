import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Factory resource type.")
model DataFactory is TrackedResource<FactoryProperties> {
  @doc("The factory name.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  @path
  @key("factoryName")
  @segment("factories")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DataFactories {
  @doc("Gets a factory.")
  get is ArmResourceRead<
    DataFactory,
    {
      ...BaseParameters<DataFactory>;

      @doc("ETag of the factory entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a factory.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFactory,
    {
      ...BaseParameters<DataFactory>;

      @doc("ETag of the factory entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Updates a factory.")
  update is ArmResourcePatchSync<DataFactory, FactoryProperties>;
  @doc("Deletes a factory.")
  delete is ArmResourceDeleteSync<DataFactory>;
  @doc("Lists factories.")
  listByResourceGroup is ArmResourceListByParent<DataFactory>;
  @doc("Lists factories under the specified subscription.")
  list is ArmListBySubscription<DataFactory>;
  @doc("Get GitHub Access Token.")
  getGitHubAccessToken is ArmResourceActionSync<
    DataFactory,
    GitHubAccessTokenRequest,
    GitHubAccessTokenResponse
  >;
  @doc("Get Data Plane access.")
  getDataPlaneAccess is ArmResourceActionSync<
    DataFactory,
    UserAccessPolicy,
    AccessPolicyResponse
  >;
  @doc("Get exposure control feature for specific factory.")
  getFeatureValueByFactory is ArmResourceActionSync<
    DataFactory,
    ExposureControlRequest,
    ExposureControlResponse
  >;
  @doc("Get list of exposure control features for specific factory.")
  queryFeatureValuesByFactory is ArmResourceActionSync<
    DataFactory,
    ExposureControlBatchRequest,
    ExposureControlBatchResponse
  >;
  @doc("Query pipeline runs in the factory based on input filter conditions.")
  queryByFactory is ArmResourceActionSync<
    DataFactory,
    RunFilterParameters,
    PipelineRunsQueryResponse
  >;
  @doc("Cancel a pipeline run by its run ID.")
  cancel is ArmResourceActionSync<
    DataFactory,
    void,
    void,
    {
      ...BaseParameters<DataFactory>;

      @doc("The pipeline run identifier.")
      @path
      runId: string;

      @doc("If true, cancel all the Child pipelines that are triggered by the current pipeline.")
      @query("isRecursive")
      isRecursive?: boolean;
    }
  >;
  @doc("Query activity runs based on input filter conditions.")
  queryByPipelineRun is ArmResourceActionSync<
    DataFactory,
    RunFilterParameters,
    ActivityRunsQueryResponse,
    {
      ...BaseParameters<DataFactory>;

      @doc("The pipeline run identifier.")
      @path
      runId: string;
    }
  >;
  @doc("Query triggers.")
  queryByFactory is ArmResourceActionSync<
    DataFactory,
    TriggerFilterParameters,
    TriggerQueryResponse
  >;
  @doc("Query trigger runs.")
  queryByFactory is ArmResourceActionSync<
    DataFactory,
    RunFilterParameters,
    TriggerRunsQueryResponse
  >;
  @doc("Creates a data flow debug session.")
  create is ArmResourceActionAsync<
    DataFactory,
    CreateDataFlowDebugSessionRequest,
    CreateDataFlowDebugSessionResponse
  >;
  @doc("Query all active data flow debug sessions.")
  queryByFactory is ArmResourceActionSync<
    DataFactory,
    void,
    QueryDataFlowDebugSessionsResponse
  >;
  @doc("Add a data flow into debug session.")
  addDataFlow is ArmResourceActionSync<
    DataFactory,
    DataFlowDebugPackage,
    AddDataFlowToDebugSessionResponse
  >;
  @doc("Deletes a data flow debug session.")
  delete is ArmResourceActionSync<
    DataFactory,
    DeleteDataFlowDebugSessionRequest,
    void
  >;
  @doc("Execute a data flow debug command.")
  executeCommand is ArmResourceActionAsync<
    DataFactory,
    DataFlowDebugCommandRequest,
    DataFlowDebugCommandResponse
  >;
  @doc("Get a pipeline run by its run ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The factory name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;

      @doc("The pipeline run identifier.")
      @path
      runId: string;
    },
    PipelineRun
  >;

  @doc("Gets the private link resources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/privateLinkResources")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The factory name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;
    },
    PrivateLinkResourcesWrapper
  >;
}
