import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./pipeline_models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureDataTransfer;
/**
 * The pipeline resource definition.
 */
model Pipeline is Azure.ResourceManager.TrackedResource<PipelineProperties> {
  ...ResourceNameParameter<
    Resource = Pipeline,
    KeyName = "pipelineName",
    SegmentName = "pipelines",
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Pipelines {
  /**
   * Gets pipeline resource.
   */
  get is ArmResourceRead<Pipeline>;

  /**
   * Creates or updates the pipeline resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Pipeline>;

  /**
   * Updates the pipeline resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Prior OpenAPI2 Json spec provides the resource back in the LRO response."
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Pipeline,
    PatchModel = PipelinesPatch,
    Response = ArmResponse<Pipeline> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Pipeline;
    })
  >;

  /**
   * Deletes the pipeline resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Pipeline>;

  /**
   * Gets pipelines in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Pipeline>;

  /**
   * Gets pipelines in a subscription.
   */
  listBySubscription is ArmListBySubscription<Pipeline>;

  /**
   * Approves the specified connection in a pipeline.
   */
  approveConnection is ArmResourceActionAsync<
    Pipeline,
    ResourceBody,
    ArmResponse<Connection>
  >;

  /**
   * Executes a privileged action for a pipeline.
   */
  executeAction is ArmResourceActionAsync<
    Pipeline,
    Action,
    ArmResponse<Pipeline>
  >;

  /**
   * Rejects the specified connection in a pipeline.
   */
  rejectConnection is ArmResourceActionAsync<
    Pipeline,
    ResourceBody,
    ArmResponse<Connection>
  >;

  /**
   * Lists the flows in a pipeline.
   */
  @action("listFlows")
  list is ArmResourceActionSync<
    Pipeline,
    {
      /**
       * Connection(s) to retrieve flows of
       */
      @bodyRoot
      connections?: ConnectionIdList;
    },
    ArmResponse<ListFlowsByPipelineResult>
  >;

  /**
   * Lists the schemas for the specified connection in a pipeline.
   */
  @action("listSchemas")
  listSchemasList is ArmResourceActionSync<
    Pipeline,
    Schema,
    ArmResponse<SchemasListResult>
  >;
}

@@maxLength(Pipeline.name, 64);
@@minLength(Pipeline.name, 3);
@@doc(Pipeline.name, "The name for the pipeline that is to be requested.");
@@doc(Pipeline.properties, "Properties of pipeline");
@@doc(Pipelines.createOrUpdate::parameters.resource, "Pipeline body");
@@doc(Pipelines.update::parameters.properties, "Pipeline body");
@@doc(Pipelines.approveConnection::parameters.body, "Connection body");
@@doc(Pipelines.executeAction::parameters.body, "Action to execute");
@@doc(Pipelines.rejectConnection::parameters.body, "Connection body");
@@doc(Pipelines.listSchemasList::parameters.body, "Schema(s) to retrieve");
