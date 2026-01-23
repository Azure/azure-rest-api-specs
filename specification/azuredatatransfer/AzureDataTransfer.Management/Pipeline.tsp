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
using TypeSpec.Versioning;

namespace Microsoft.AzureDataTransfer;

/**
 * The pipeline resource definition. A Pipeline defines the scope and identity under which data replication scenarios are managed.
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

/**
 * Defines the set of operations available for managing Pipeline resources.
 */
@armResourceOperations
interface Pipelines {
  /**
   * Retrieves the specified Pipeline resource.
   */
  get is ArmResourceRead<Pipeline>;

  /**
   * Creates a new Pipeline resource or updates an existing one. This operation is asynchronous and returns the resulting Pipeline.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Pipeline>;

  /**
   * Applies partial updates to an existing Pipeline resource. This operation supports patch semantics and returns the updated Pipeline.
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
   * Deletes the specified Pipeline resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Pipeline>;

  /**
   * Lists all Pipeline resources within the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Pipeline>;

  /**
   * Lists all Pipeline resources within the current subscription.
   */
  listBySubscription is ArmListBySubscription<Pipeline>;

  /**
   * Approves a pending connection request associated with the specified Pipeline.
   */
  approveConnection is ArmResourceActionAsync<
    Pipeline,
    ResourceBody,
    ArmConnectionResponse
  >;

  /**
   * Executes a privileged or administrative action on the specified Pipeline.
   */
  executeAction is ArmResourceActionAsync<
    Pipeline,
    Action,
    ArmPipelineResponse
  >;

  /**
   * Lists all Flows associated with the specified Pipeline.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @action("listFlows")
  @operationId("ListFlowsByPipeline_List")
  list is ArmResourceActionSync<
    Pipeline,
    {
      /**
       * A list of connection identifiers used to filter the Flows to be retrieved.
       */
      @bodyRoot
      connections?: ConnectionIdList;
    },
    ArmResponse<ListFlowsByPipelineResult>
  >;

  /**
   * Lists the schemas associated with a specific connection in the Pipeline. This operation has reached end of life support starting version 2025-05-30-preview. For schema support please create and use a FlowProfile resource.
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
   * Rejects a pending connection request associated with the specified Pipeline.
   */
  rejectConnection is ArmResourceActionAsync<
    Pipeline,
    ResourceBody,
    ArmConnectionResponse
  >;
}

@@maxLength(Pipeline.name, 64);
@@minLength(Pipeline.name, 3);
@@doc(Pipeline.name, "The name of the pipeline on which to operate.");
@@doc(Pipeline.properties,
  "The set of configurable properties for the Pipeline resource."
);
@@doc(Pipelines.createOrUpdate::parameters.resource,
  "The request body containing the Pipeline definition."
);
@@doc(Pipelines.update::parameters.properties,
  "The request body containing the updated Pipeline properties."
);
@@doc(Pipelines.approveConnection::parameters.body,
  "The request body containing the connection to approve."
);
@@doc(Pipelines.executeAction::parameters.body,
  "The action to be executed on the Pipeline."
);
@@doc(Pipelines.listSchemasList::parameters.body,
  "The schema(s) to retrieve for the specified connection."
);
@@doc(Pipelines.rejectConnection::parameters.body,
  "The request body containing the connection to reject."
);

@@clientName(Pipelines.createOrUpdate::parameters.resource, "pipeline");
@@clientName(Pipelines.update::parameters.properties, "pipeline");
@@clientName(Pipelines.approveConnection::parameters.body, "connection");
@@clientName(Pipelines.rejectConnection::parameters.body, "connection");
@@clientName(Pipelines.executeAction::parameters.body, "action");
@@clientName(Pipelines.listSchemasList::parameters.body, "schema");
