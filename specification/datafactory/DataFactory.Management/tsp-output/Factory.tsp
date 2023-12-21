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
model Factory is TrackedResource<FactoryProperties> {
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
interface Factories {
  @doc("Gets a factory.")
  get is ArmResourceRead<
    Factory,
    {
      ...BaseParameters<Factory>;

      @doc("ETag of the factory entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a factory.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Factory,
    {
      ...BaseParameters<Factory>;

      @doc("ETag of the factory entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Updates a factory.")
  update is ArmResourcePatchSync<Factory, FactoryProperties>;
  @doc("Deletes a factory.")
  delete is ArmResourceDeleteSync<Factory>;
  @doc("Lists factories.")
  listByResourceGroup is ArmResourceListByParent<Factory>;
  @doc("Lists factories under the specified subscription.")
  list is ArmListBySubscription<Factory>;
  @doc("Get GitHub Access Token.")
  getGitHubAccessToken is ArmResourceActionSync<
    Factory,
    GitHubAccessTokenRequest,
    GitHubAccessTokenResponse
  >;
  @doc("Get Data Plane access.")
  getDataPlaneAccess is ArmResourceActionSync<
    Factory,
    UserAccessPolicy,
    AccessPolicyResponse
  >;
}

@armResourceOperations
interface ExposureControl {
  @doc("Get exposure control feature for specific factory.")
  getFeatureValueByFactory is ArmResourceActionSync<
    Factory,
    ExposureControlRequest,
    ExposureControlResponse
  >;
  @doc("Get list of exposure control features for specific factory.")
  queryFeatureValuesByFactory is ArmResourceActionSync<
    Factory,
    ExposureControlBatchRequest,
    ExposureControlBatchResponse
  >;
}

@armResourceOperations
interface PipelineRuns {
  @doc("Query pipeline runs in the factory based on input filter conditions.")
  queryByFactory is ArmResourceActionSync<
    Factory,
    RunFilterParameters,
    PipelineRunsQueryResponse
  >;
  @doc("Cancel a pipeline run by its run ID.")
  cancel is ArmResourceActionSync<
    Factory,
    void,
    void,
    {
      ...BaseParameters<Factory>;

      @doc("The pipeline run identifier.")
      @path
      runId: string;

      @doc("If true, cancel all the Child pipelines that are triggered by the current pipeline.")
      @query("isRecursive")
      isRecursive?: boolean;
    }
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
}

@armResourceOperations
interface ActivityRuns {
  @doc("Query activity runs based on input filter conditions.")
  queryByPipelineRun is ArmResourceActionSync<
    Factory,
    RunFilterParameters,
    ActivityRunsQueryResponse,
    {
      ...BaseParameters<Factory>;

      @doc("The pipeline run identifier.")
      @path
      runId: string;
    }
  >;
}

@armResourceOperations
interface Triggers {
  @doc("Query triggers.")
  queryByFactory is ArmResourceActionSync<
    Factory,
    TriggerFilterParameters,
    TriggerQueryResponse
  >;
}

@armResourceOperations
interface TriggerRuns {
  @doc("Query trigger runs.")
  queryByFactory is ArmResourceActionSync<
    Factory,
    RunFilterParameters,
    TriggerRunsQueryResponse
  >;
}

@armResourceOperations
interface DataFlowDebugSession {
  @doc("Creates a data flow debug session.")
  create is ArmResourceActionAsync<
    Factory,
    CreateDataFlowDebugSessionRequest,
    CreateDataFlowDebugSessionResponse
  >;
  @doc("Query all active data flow debug sessions.")
  queryByFactory is ArmResourceActionSync<
    Factory,
    void,
    QueryDataFlowDebugSessionsResponse
  >;
  @doc("Add a data flow into debug session.")
  addDataFlow is ArmResourceActionSync<
    Factory,
    DataFlowDebugPackage,
    AddDataFlowToDebugSessionResponse
  >;
  @doc("Deletes a data flow debug session.")
  delete is ArmResourceActionSync<
    Factory,
    DeleteDataFlowDebugSessionRequest,
    void
  >;
  @doc("Execute a data flow debug command.")
  executeCommand is ArmResourceActionAsync<
    Factory,
    DataFlowDebugCommandRequest,
    DataFlowDebugCommandResponse
  >;
}

@armResourceOperations
interface privateLinkResources {
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
