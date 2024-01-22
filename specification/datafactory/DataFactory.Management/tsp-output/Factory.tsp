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

namespace Microsoft.DataFactory;
/**
 * Factory resource type.
 */
model Factory is TrackedResource<FactoryProperties> {
  /**
   * The factory name.
   */
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
  /**
   * Gets a factory.
   */
  get is ArmResourceRead<
    Factory,
    {
      ...BaseParameters<Factory>;

      /**
       * ETag of the factory entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a factory.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Factory,
    {
      ...BaseParameters<Factory>;

      /**
       * ETag of the factory entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates a factory.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Factory, FactoryUpdateParameters>;

  /**
   * Deletes a factory.
   */
  delete is ArmResourceDeleteSync<Factory>;

  /**
   * Lists factories.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Factories_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Factory>;

  /**
   * Lists factories under the specified subscription.
   */
  list is ArmListBySubscription<Factory>;

  /**
   * Get GitHub Access Token.
   */
  getGitHubAccessToken is ArmResourceActionSync<
    Factory,
    GitHubAccessTokenRequest,
    GitHubAccessTokenResponse
  >;

  /**
   * Get Data Plane access.
   */
  getDataPlaneAccess is ArmResourceActionSync<
    Factory,
    UserAccessPolicy,
    AccessPolicyResponse
  >;

  /**
   * Get exposure control feature for specific factory.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExposureControl_GetFeatureValueByFactory")
  getFeatureValueByFactory is ArmResourceActionSync<
    Factory,
    ExposureControlRequest,
    ExposureControlResponse
  >;

  /**
   * Get list of exposure control features for specific factory.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExposureControl_QueryFeatureValuesByFactory")
  queryFeatureValuesByFactory is ArmResourceActionSync<
    Factory,
    ExposureControlBatchRequest,
    ExposureControlBatchResponse
  >;

  /**
   * Query pipeline runs in the factory based on input filter conditions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PipelineRuns_QueryByFactory")
  queryByFactory is ArmResourceActionSync<
    Factory,
    RunFilterParameters,
    PipelineRunsQueryResponse
  >;

  /**
   * Cancel a pipeline run by its run ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PipelineRuns_Cancel")
  cancel is ArmResourceActionSync<
    Factory,
    void,
    void,
    {
      ...BaseParameters<Factory>;

      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;

      /**
       * If true, cancel all the Child pipelines that are triggered by the current pipeline.
       */
      @query("isRecursive")
      isRecursive?: boolean;
    }
  >;

  /**
   * Query activity runs based on input filter conditions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActivityRuns_QueryByPipelineRun")
  queryByPipelineRun is ArmResourceActionSync<
    Factory,
    RunFilterParameters,
    ActivityRunsQueryResponse,
    {
      ...BaseParameters<Factory>;

      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    }
  >;

  /**
   * Query triggers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Triggers_QueryByFactory")
  queryByFactory is ArmResourceActionSync<
    Factory,
    TriggerFilterParameters,
    TriggerQueryResponse
  >;

  /**
   * Query trigger runs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TriggerRuns_QueryByFactory")
  queryByFactory is ArmResourceActionSync<
    Factory,
    RunFilterParameters,
    TriggerRunsQueryResponse
  >;

  /**
   * Creates a data flow debug session.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlowDebugSession_Create")
  create is ArmResourceActionAsync<
    Factory,
    CreateDataFlowDebugSessionRequest,
    CreateDataFlowDebugSessionResponse
  >;

  /**
   * Query all active data flow debug sessions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlowDebugSession_QueryByFactory")
  queryByFactory is ArmResourceActionSync<
    Factory,
    void,
    QueryDataFlowDebugSessionsResponse
  >;

  /**
   * Add a data flow into debug session.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlowDebugSession_AddDataFlow")
  addDataFlow is ArmResourceActionSync<
    Factory,
    DataFlowDebugPackage,
    AddDataFlowToDebugSessionResponse
  >;

  /**
   * Deletes a data flow debug session.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlowDebugSession_Delete")
  delete is ArmResourceActionSync<
    Factory,
    DeleteDataFlowDebugSessionRequest,
    void
  >;

  /**
   * Execute a data flow debug command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlowDebugSession_ExecuteCommand")
  executeCommand is ArmResourceActionAsync<
    Factory,
    DataFlowDebugCommandRequest,
    DataFlowDebugCommandResponse
  >;

  /**
   * Get a pipeline run by its run ID.
   */
  // FIXME: PipelineRuns_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PipelineRuns_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The factory name.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;

      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    },
    PipelineRun
  >;

  /**
   * Gets the private link resources
   */
  // FIXME: privateLinkResources_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("privateLinkResources_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/privateLinkResources")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The factory name.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;
    },
    PrivateLinkResourcesWrapper
  >;
}

@@projectedName(Factories.createOrUpdate::parameters.resource,
  "json",
  "factory"
);
@@extension(Factories.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "factory"
);
@@doc(Factories.createOrUpdate::parameters.resource,
  "Factory resource definition."
);
@@projectedName(Factories.update::parameters.properties,
  "json",
  "factoryUpdateParameters"
);
@@extension(Factories.update::parameters.properties,
  "x-ms-client-name",
  "factoryUpdateParameters"
);
@@doc(Factories.update::parameters.properties,
  "The parameters for updating a factory."
);
@@projectedName(Factories.getGitHubAccessToken::parameters.body,
  "json",
  "gitHubAccessTokenRequest"
);
@@extension(Factories.getGitHubAccessToken::parameters.body,
  "x-ms-client-name",
  "gitHubAccessTokenRequest"
);
@@doc(Factories.getGitHubAccessToken::parameters.body,
  "Get GitHub access token request definition."
);
@@projectedName(Factories.getDataPlaneAccess::parameters.body,
  "json",
  "policy"
);
@@extension(Factories.getDataPlaneAccess::parameters.body,
  "x-ms-client-name",
  "policy"
);
@@doc(Factories.getDataPlaneAccess::parameters.body,
  "Data Plane user access policy definition."
);
@@projectedName(Factories.getFeatureValueByFactory::parameters.body,
  "json",
  "exposureControlRequest"
);
@@extension(Factories.getFeatureValueByFactory::parameters.body,
  "x-ms-client-name",
  "exposureControlRequest"
);
@@doc(Factories.getFeatureValueByFactory::parameters.body,
  "The exposure control request."
);
@@projectedName(Factories.queryFeatureValuesByFactory::parameters.body,
  "json",
  "exposureControlBatchRequest"
);
@@extension(Factories.queryFeatureValuesByFactory::parameters.body,
  "x-ms-client-name",
  "exposureControlBatchRequest"
);
@@doc(Factories.queryFeatureValuesByFactory::parameters.body,
  "The exposure control request for list of features."
);
@@projectedName(Factories.queryByFactory::parameters.body,
  "json",
  "filterParameters"
);
@@extension(Factories.queryByFactory::parameters.body,
  "x-ms-client-name",
  "filterParameters"
);
@@doc(Factories.queryByFactory::parameters.body,
  "Parameters to filter the pipeline run."
);
@@projectedName(Factories.queryByPipelineRun::parameters.body,
  "json",
  "filterParameters"
);
@@extension(Factories.queryByPipelineRun::parameters.body,
  "x-ms-client-name",
  "filterParameters"
);
@@doc(Factories.queryByPipelineRun::parameters.body,
  "Parameters to filter the activity runs."
);
@@projectedName(Factories.queryByFactory::parameters.body,
  "json",
  "filterParameters"
);
@@extension(Factories.queryByFactory::parameters.body,
  "x-ms-client-name",
  "filterParameters"
);
@@doc(Factories.queryByFactory::parameters.body,
  "Parameters to filter the triggers."
);
@@projectedName(Factories.queryByFactory::parameters.body,
  "json",
  "filterParameters"
);
@@extension(Factories.queryByFactory::parameters.body,
  "x-ms-client-name",
  "filterParameters"
);
@@doc(Factories.queryByFactory::parameters.body,
  "Parameters to filter the pipeline run."
);
@@projectedName(Factories.create::parameters.body, "json", "request");
@@extension(Factories.create::parameters.body, "x-ms-client-name", "request");
@@doc(Factories.create::parameters.body, "Data flow debug session definition");
@@projectedName(Factories.addDataFlow::parameters.body, "json", "request");
@@extension(Factories.addDataFlow::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(Factories.addDataFlow::parameters.body,
  "Data flow debug session definition with debug content."
);
@@projectedName(Factories.delete::parameters.body, "json", "request");
@@extension(Factories.delete::parameters.body, "x-ms-client-name", "request");
@@doc(Factories.delete::parameters.body,
  "Data flow debug session definition for deletion"
);
@@projectedName(Factories.executeCommand::parameters.body, "json", "request");
@@extension(Factories.executeCommand::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(Factories.executeCommand::parameters.body,
  "Data flow debug command definition."
);
