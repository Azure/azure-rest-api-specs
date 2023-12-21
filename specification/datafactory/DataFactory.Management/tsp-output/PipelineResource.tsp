import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Pipeline resource type.")
@parentResource(Factory)
model PipelineResource is ProxyResource<Pipeline> {
  @doc("The pipeline name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("pipelineName")
  @segment("pipelines")
  name: string;
}

@armResourceOperations
interface Pipelines {
  @doc("Gets a pipeline.")
  get is ArmResourceRead<
    PipelineResource,
    {
      ...BaseParameters<PipelineResource>;

      @doc("ETag of the pipeline entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a pipeline.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PipelineResource,
    {
      ...BaseParameters<PipelineResource>;

      @doc("ETag of the pipeline entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a pipeline.")
  delete is ArmResourceDeleteSync<PipelineResource>;
  @doc("Lists pipelines.")
  listByFactory is ArmResourceListByParent<PipelineResource>;
  @doc("Creates a run of a pipeline.")
  createRun is ArmResourceActionSync<
    PipelineResource,
    Record<Record<unknown>>,
    CreateRunResponse,
    {
      ...BaseParameters<PipelineResource>;

      @doc("The pipeline run identifier. If run ID is specified the parameters of the specified run will be used to create a new run.")
      @query("referencePipelineRunId")
      referencePipelineRunId?: string;

      @doc("Recovery mode flag. If recovery mode is set to true, the specified referenced pipeline run and the new run will be grouped under the same groupId.")
      @query("isRecovery")
      isRecovery?: boolean;

      @doc("In recovery mode, the rerun will start from this activity. If not specified, all activities will run.")
      @query("startActivityName")
      startActivityName?: string;

      @doc("In recovery mode, if set to true, the rerun will start from failed activities. The property will be used only if startActivityName is not specified.")
      @query("startFromFailure")
      startFromFailure?: boolean;
    }
  >;
}
