import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Factory resource type.
 */
model Factory
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<FactoryProperties> {
  ...ResourceNameParameter<
    Resource = Factory,
    KeyName = "factoryName",
    SegmentName = "factories",
    NamePattern = "^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * Managed service identity of the factory.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: FactoryIdentity;
}

alias PipelineRunsOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("factories")
    @key
    @maxLength(63)
    @minLength(3)
    @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
    factoryName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface Factories {
  /**
   * Gets a factory.
   */
  get is ArmResourceRead<
    Factory,
    Parameters = {
      /**
       * ETag of the factory entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    },
    Response = ArmResponse<Factory> | NotModifiedResponse,
    Error = CloudError
  >;

  /**
   * Creates or updates a factory.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Factory,
    Parameters = {
      /**
       * ETag of the factory entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<Factory>,
    Error = CloudError
  >;

  /**
   * Updates a factory.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Factory,
    PatchModel = FactoryUpdateParameters,
    Error = CloudError
  >;

  /**
   * Deletes a factory.
   */
  delete is ArmResourceDeleteSync<Factory, Error = CloudError>;

  /**
   * Lists factories.
   */
  listByResourceGroup is ArmResourceListByParent<
    Factory,
    Response = ArmResponse<FactoryListResponse>,
    Error = CloudError
  >;

  /**
   * Lists factories under the specified subscription.
   */
  list is ArmListBySubscription<
    Factory,
    Response = ArmResponse<FactoryListResponse>,
    Error = CloudError
  >;

  /**
   * Get GitHub Access Token.
   */
  getGitHubAccessToken is ArmResourceActionSync<
    Factory,
    GitHubAccessTokenRequest,
    ArmResponse<GitHubAccessTokenResponse>,
    Error = CloudError
  >;

  /**
   * Get Data Plane access.
   */
  getDataPlaneAccess is ArmResourceActionSync<
    Factory,
    UserAccessPolicy,
    ArmResponse<AccessPolicyResponse>,
    Error = CloudError
  >;

  /**
   * Get exposure control feature for specific factory.
   */
  @action("getFeatureValue")
  getFeatureValueByFactory is ArmResourceActionSync<
    Factory,
    ExposureControlRequest,
    ArmResponse<ExposureControlResponse>,
    Error = CloudError
  >;

  /**
   * Get list of exposure control features for specific factory.
   */
  @action("queryFeaturesValue")
  queryFeatureValuesByFactory is ArmResourceActionSync<
    Factory,
    ExposureControlBatchRequest,
    ArmResponse<ExposureControlBatchResponse>,
    Error = CloudError
  >;

  /**
   * Query pipeline runs in the factory based on input filter conditions.
   */
  @list
  @action("queryPipelineRuns")
  queryByFactory is ArmResourceActionSync<
    Factory,
    RunFilterParameters,
    ArmResponse<PipelineRunsQueryResponse>,
    Error = CloudError
  >;

  /**
   * Get a pipeline run by its run ID.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}")
  pipelineRunsGet is PipelineRunsOps.ActionSync<
    Factory,
    void,
    ArmResponse<PipelineRun>,
    Parameters = {
      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Cancel a pipeline run by its run ID.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}/cancel")
  cancel is PipelineRunsOps.ActionSync<
    Factory,
    void,
    OkResponse,
    Parameters = {
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
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Query activity runs based on input filter conditions.
   */
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/pipelineruns/{runId}/queryActivityruns")
  queryByPipelineRun is PipelineRunsOps.ActionSync<
    Factory,
    RunFilterParameters,
    ArmResponse<ActivityRunsQueryResponse>,
    Parameters = {
      /**
       * The pipeline run identifier.
       */
      @path
      runId: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Query triggers.
   */
  @list
  @action("querytriggers")
  triggersQueryByFactory is ArmResourceActionSync<
    Factory,
    TriggerFilterParameters,
    ArmResponse<TriggerQueryResponse>,
    Error = CloudError
  >;

  /**
   * Query trigger runs.
   */
  @list
  @action("queryTriggerRuns")
  triggerRunsQueryByFactory is ArmResourceActionSync<
    Factory,
    RunFilterParameters,
    ArmResponse<TriggerRunsQueryResponse>,
    Error = CloudError
  >;

  /**
   * Creates a data flow debug session.
   */
  @action("createDataFlowDebugSession")
  create is ArmResourceActionAsync<
    Factory,
    CreateDataFlowDebugSessionRequest,
    ArmResponse<CreateDataFlowDebugSessionResponse>,
    Error = CloudError
  >;

  /**
   * Query all active data flow debug sessions.
   */
  @list
  @action("queryDataFlowDebugSessions")
  dataFlowDebugSessionQueryByFactory is ArmResourceActionSync<
    Factory,
    void,
    ArmResponse<QueryDataFlowDebugSessionsResponse>,
    Error = CloudError
  >;

  /**
   * Add a data flow into debug session.
   */
  @action("addDataFlowToDebugSession")
  addDataFlow is ArmResourceActionSync<
    Factory,
    DataFlowDebugPackage,
    ArmResponse<AddDataFlowToDebugSessionResponse>,
    Error = CloudError
  >;

  /**
   * Deletes a data flow debug session.
   */
  @action("deleteDataFlowDebugSession")
  dataFlowDebugSessionDelete is ArmResourceActionSync<
    Factory,
    DeleteDataFlowDebugSessionRequest,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Execute a data flow debug command.
   */
  @action("executeDataFlowDebugCommand")
  executeCommand is ArmResourceActionAsync<
    Factory,
    DataFlowDebugCommandRequest,
    ArmResponse<DataFlowDebugCommandResponse>,
    Error = CloudError
  >;

  /**
   * Gets the private link resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("privateLinkResources_Get")
  @list
  @get
  @action("privateLinkResources")
  privateLinkResourcesGet is ArmResourceActionSync<
    Factory,
    void,
    ArmResponse<PrivateLinkResourcesWrapper>,
    Error = CloudError
  >;
}

@@maxLength(Factory.name, 63);
@@minLength(Factory.name, 3);
@@doc(Factory.name, "The factory name.");
@@doc(Factory.properties, "Properties of the factory.");
@@doc(Factories.createOrUpdate::parameters.resource,
  "Factory resource definition."
);
@@doc(Factories.update::parameters.properties,
  "The parameters for updating a factory."
);
@@doc(Factories.getGitHubAccessToken::parameters.body,
  "Get GitHub access token request definition."
);
@@doc(Factories.getDataPlaneAccess::parameters.body,
  "Data Plane user access policy definition."
);
@@doc(Factories.getFeatureValueByFactory::parameters.body,
  "The exposure control request."
);
@@doc(Factories.queryFeatureValuesByFactory::parameters.body,
  "The exposure control request for list of features."
);
@@doc(Factories.queryByFactory::parameters.body,
  "Parameters to filter the pipeline run."
);
@@doc(Factories.queryByPipelineRun::parameters.body,
  "Parameters to filter the activity runs."
);
@@doc(Factories.triggersQueryByFactory::parameters.body,
  "Parameters to filter the triggers."
);
@@doc(Factories.triggerRunsQueryByFactory::parameters.body,
  "Parameters to filter the pipeline run."
);
@@doc(Factories.create::parameters.body, "Data flow debug session definition");
@@doc(Factories.addDataFlow::parameters.body,
  "Data flow debug session definition with debug content."
);
@@doc(Factories.dataFlowDebugSessionDelete::parameters.body,
  "Data flow debug session definition for deletion"
);
@@doc(Factories.executeCommand::parameters.body,
  "Data flow debug command definition."
);
