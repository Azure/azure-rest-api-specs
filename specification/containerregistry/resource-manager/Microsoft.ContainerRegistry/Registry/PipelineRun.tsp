import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./PipelineRun.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a pipeline run for a container registry.
 */
@added(Versions.vLatestPreview)
@parentResource(Registry)
model PipelineRun
  is Azure.ResourceManager.ProxyResource<PipelineRunProperties> {
  ...ResourceNameParameter<
    Resource = PipelineRun,
    KeyName = "pipelineRunName",
    SegmentName = "pipelineRuns",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

@added(Versions.vLatestPreview)
@armResourceOperations
interface PipelineRuns {
  /**
   * Gets the detailed information for a given pipeline run.
   */
  get is ArmResourceRead<PipelineRun>;

  /**
   * Creates a pipeline run for a container registry with the specified parameters
   */
  create is ArmResourceCreateOrReplaceAsync<PipelineRun>;

  /**
   * Deletes a pipeline run from a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PipelineRun,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the pipeline runs for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    PipelineRun,
    Response = ArmResponse<PipelineRunListResult>
  >;
}

@@maxLength(PipelineRun.name, 50);
@@minLength(PipelineRun.name, 5);
@@doc(PipelineRun.name, "The name of the pipeline run.");
@@doc(PipelineRun.properties, "The properties of a pipeline run.");
@@doc(PipelineRuns.create::parameters.resource,
  "The parameters for creating a pipeline run."
);
