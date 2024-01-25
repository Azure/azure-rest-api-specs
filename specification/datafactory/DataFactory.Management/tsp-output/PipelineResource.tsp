import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Pipeline resource type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Factory)
@includeInapplicableMetadataInPayload(false)
model PipelineResource extends SubResource {
  /**
   * The pipeline name.
   */
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("pipelineName")
  @segment("pipelines")
  @visibility("read")
  name: string;

  /**
   * Properties of the pipeline.
   */
  @extension("x-ms-client-flatten", true)
  properties: Pipeline;
}

@armResourceOperations
interface PipelineResources {
  /**
   * Gets a pipeline.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pipelines_Get")
  get is ArmResourceRead<
    PipelineResource,
    {
      ...BaseParameters<PipelineResource>;

      /**
       * ETag of the pipeline entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a pipeline.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pipelines_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PipelineResource,
    {
      ...BaseParameters<PipelineResource>;

      /**
       * ETag of the pipeline entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes a pipeline.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pipelines_Delete")
  delete is ArmResourceDeleteSync<PipelineResource>;

  /**
   * Lists pipelines.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pipelines_ListByFactory")
  listByFactory is ArmResourceListByParent<PipelineResource>;

  /**
   * Creates a run of a pipeline.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Pipelines_CreateRun")
  createRun is ArmResourceActionSync<
    PipelineResource,
    ParameterValueSpecification,
    CreateRunResponse,
    {
      ...BaseParameters<PipelineResource>;

      /**
       * The pipeline run identifier. If run ID is specified the parameters of the specified run will be used to create a new run.
       */
      @query("referencePipelineRunId")
      referencePipelineRunId?: string;

      /**
       * Recovery mode flag. If recovery mode is set to true, the specified referenced pipeline run and the new run will be grouped under the same groupId.
       */
      @query("isRecovery")
      isRecovery?: boolean;

      /**
       * In recovery mode, the rerun will start from this activity. If not specified, all activities will run.
       */
      @query("startActivityName")
      startActivityName?: string;

      /**
       * In recovery mode, if set to true, the rerun will start from failed activities. The property will be used only if startActivityName is not specified.
       */
      @query("startFromFailure")
      startFromFailure?: boolean;
    }
  >;
}

@@projectedName(PipelineResources.createOrUpdate::parameters.resource,
  "json",
  "pipeline"
);
@@extension(PipelineResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "pipeline"
);
@@doc(PipelineResources.createOrUpdate::parameters.resource,
  "Pipeline resource definition."
);
@@projectedName(PipelineResources.createRun::parameters.body,
  "json",
  "parameters"
);
@@extension(PipelineResources.createRun::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(PipelineResources.createRun::parameters.body,
  "Parameters of the pipeline run. These parameters will be used only if the runId is not specified."
);
