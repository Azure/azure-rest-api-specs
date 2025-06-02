import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
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

model ArmPipelineResponse is ArmResponse<Pipeline>;

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
   * Approves the specified connection request in a pipeline.
   */
  approveConnection is ArmResourceActionAsync<
    Pipeline,
    ResourceBody,
    ArmConnectionResponse
  >;

  /**
   * Executes a privileged action for a pipeline.
   */
  executeAction is ArmResourceActionAsync<
    Pipeline,
    Action,
    ArmPipelineResponse
  >;

  /**
   * Lists the flows in a pipeline.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @action("listFlows")
  @operationId("ListFlowsByPipeline_List")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @action("listSchemas")
  @operationId("ListSchemas_List")
  listSchemasList is ArmResourceActionSync<
    Pipeline,
    Schema,
    ArmResponse<SchemasListResult>
  >;

  /**
   * Rejects the specified connection request in a pipeline.
   */
  rejectConnection is ArmResourceActionAsync<
    Pipeline,
    ResourceBody,
    ArmConnectionResponse
  >;
}

@@maxLength(Pipeline.name, 64);
@@minLength(Pipeline.name, 3);
@@doc(Pipeline.name, "The name for the pipeline to perform the operation on.");
@@doc(Pipeline.properties, "Properties of pipeline");
@@doc(Pipelines.createOrUpdate::parameters.resource, "Pipeline body");
@@doc(Pipelines.update::parameters.properties, "Pipeline body");
@@doc(Pipelines.approveConnection::parameters.body, "Connection body");
@@doc(Pipelines.executeAction::parameters.body, "Action to execute");
@@doc(Pipelines.listSchemasList::parameters.body, "Schema(s) to retrieve");
@@doc(Pipelines.rejectConnection::parameters.body, "Connection body");

@@clientName(Pipelines.createOrUpdate::parameters.resource, "pipeline");
@@clientName(Pipelines.update::parameters.properties, "pipeline");
@@clientName(Pipelines.approveConnection::parameters.body, "connection");
@@clientName(Pipelines.rejectConnection::parameters.body, "connection");
@@clientName(Pipelines.executeAction::parameters.body, "action");
@@clientName(Pipelines.listSchemasList::parameters.body, "schema");
