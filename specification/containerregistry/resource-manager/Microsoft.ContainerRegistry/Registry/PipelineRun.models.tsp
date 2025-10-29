using Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * The type of the source.
 */
@added(Versions.vLatestPreview)
union PipelineRunSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageBlob: "AzureStorageBlob",
}

/**
 * The type of the target.
 */
@added(Versions.vLatestPreview)
union PipelineRunTargetType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageBlob: "AzureStorageBlob",
}

/**
 * The properties of a pipeline run.
 */
@added(Versions.vLatestPreview)
model PipelineRunProperties {
  /**
   * The provisioning state of a pipeline run.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The request parameters for a pipeline run.
   */
  request?: PipelineRunRequest;

  /**
   * The response of a pipeline run.
   */
  @visibility(Lifecycle.Read)
  response?: PipelineRunResponse;

  /**
   * How the pipeline run should be forced to recreate even if the pipeline run configuration has not changed.
   */
  forceUpdateTag?: string;
}

/**
 * The request properties provided for a pipeline run.
 */
@added(Versions.vLatestPreview)
model PipelineRunRequest {
  /**
   * The resource ID of the pipeline to run.
   */
  pipelineResourceId?: string;

  @doc("""
    List of source artifacts to be transferred by the pipeline. 
    Specify an image by repository ('hello-world'). This will use the 'latest' tag.
    Specify an image by tag ('hello-world:latest').
    Specify an image by sha256-based manifest digest ('hello-world@sha256:abc123').
    """)
  artifacts?: string[];

  /**
   * The source properties of the pipeline run.
   */
  source?: PipelineRunSourceProperties;

  /**
   * The target properties of the pipeline run.
   */
  target?: PipelineRunTargetProperties;

  /**
   * The digest of the tar used to transfer the artifacts.
   */
  catalogDigest?: string;
}

/**
 * The pipeline run source properties
 */
@added(Versions.vLatestPreview)
model PipelineRunSourceProperties {
  /**
   * The type of the source.
   */
  type?: PipelineRunSourceType = PipelineRunSourceType.AzureStorageBlob;

  /**
   * The name of the source.
   */
  name?: string;
}

/**
 * The pipeline run target properties
 */
@added(Versions.vLatestPreview)
model PipelineRunTargetProperties {
  /**
   * The type of the target.
   */
  type?: PipelineRunTargetType = PipelineRunTargetType.AzureStorageBlob;

  /**
   * The name of the target.
   */
  name?: string;
}

/**
 * The response properties returned for a pipeline run.
 */
@added(Versions.vLatestPreview)
model PipelineRunResponse {
  /**
   * The current status of the pipeline run.
   */
  status?: string;

  /**
   * The artifacts imported in the pipeline run.
   */
  importedArtifacts?: string[];

  /**
   * The current progress of the copy operation.
   */
  progress?: ProgressProperties;

  /**
   * The time the pipeline run started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time the pipeline run finished.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  /**
   * The source of the pipeline run.
   */
  source?: ImportPipelineSourceProperties;

  /**
   * The target of the pipeline run.
   */
  target?: ExportPipelineTargetProperties;

  /**
   * The digest of the tar used to transfer the artifacts.
   */
  catalogDigest?: string;

  /**
   * The trigger that caused the pipeline run.
   */
  trigger?: PipelineTriggerDescriptor;

  /**
   * The detailed error message for the pipeline run in the case of failure.
   */
  pipelineRunErrorMessage?: string;
}

/**
 * The progress properties.
 */
model ProgressProperties {
  /**
   * The percentage complete of the copy operation.
   */
  percentage?: string;
}

/**
 * The pipeline trigger descriptor
 */
model PipelineTriggerDescriptor {
  /**
   * The source trigger that caused the pipeline run.
   */
  sourceTrigger?: PipelineSourceTriggerDescriptor;
}

/**
 * The pipeline source trigger descriptor.
 */
model PipelineSourceTriggerDescriptor {
  /**
   * The timestamp when the source update happened.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

/**
 * The result of a request to list pipeline runs for a container registry.
 */
@added(Versions.vLatestPreview)
model PipelineRunListResult {
  /**
   * The list of pipeline runs. Since this list may be incomplete, the nextLink field should be used to request the next list of pipeline runs.
   */
  @pageItems
  value?: PipelineRun[];

  /**
   * The URI that can be used to request the next list of pipeline runs.
   */
  @nextLink
  nextLink?: string;
}
