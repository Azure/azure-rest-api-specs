import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./instance.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsDataProcessor;

@doc("A Pipeline resource belonging to an Instance resource.")
@parentResource(Instance)
model Pipeline is TrackedResource<PipelineProperties> {
  @doc("Name of pipeline")
  @key("pipelineName")
  @segment("pipelines")
  @pattern("^[a-z0-9][a-z0-9-]{1,60}[a-z0-9]$")
  @path
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("The properties of a Pipeline resource.")
model PipelineProperties {
  @doc("Detailed description of the Pipeline.")
  description?: string;

  @doc("Flag indicating whether the pipeline should be running or not.")
  enabled: boolean;

  @doc("Information about where to pull input data from.")
  input: PipelineInput;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Map of stage ids to stage configurations for all pipeline processing and output stages.")
  stages: Record<PipelineStage>;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
@doc("Stage configuration for Pipeline input stage.")
model PipelineInput is Record<unknown> {
  @doc("ARM resource type.")
  type: string;

  @doc("Description for stage.")
  description?: string;

  @doc("Next stage in the pipeline.")
  next: string[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
@doc("Stage configurations for all Pipeline processing and output stages.")
model PipelineStage is Record<unknown> {
  @doc("ARM resource type.")
  type: string;

  @doc("Description for stage.")
  description?: string;

  @doc("Next stage in the pipeline. Not required if output stage.")
  next?: string[];
}

@armResourceOperations
interface Pipelines {
  get is ArmResourceRead<Pipeline>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Pipeline>;
  update is ArmCustomPatchSync<Pipeline>;
  delete is ArmResourceDeleteWithoutOkAsync<Pipeline>;
  listByInstance is ArmResourceListByParent<Pipeline>;
}
