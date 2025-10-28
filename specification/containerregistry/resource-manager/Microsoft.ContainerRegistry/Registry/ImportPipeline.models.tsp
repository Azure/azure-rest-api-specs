import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./ImportPipeline.tsp";
import "./models.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * The current status of the source trigger.
 */
union TriggerStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The type of source for the import pipeline.
 */
union PipelineSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageBlobContainer: "AzureStorageBlobContainer",
}

/**
 * The properties of an import pipeline.
 */
model ImportPipelineProperties {
  /**
   * The source properties of the import pipeline.
   */
  source: ImportPipelineSourceProperties;

  /**
   * The properties that describe the trigger of the import pipeline.
   */
  trigger?: PipelineTriggerProperties;

  /**
   * The list of all options configured for the pipeline.
   */
  options?: PipelineOptions[];

  /**
   * The provisioning state of the pipeline at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties of the import pipeline source.
 */
model ImportPipelineSourceProperties {
  /**
   * The type of source for the import pipeline.
   */
  type?: PipelineSourceType = PipelineSourceType.AzureStorageBlobContainer;

  /**
   * The source uri of the import pipeline.
   * When 'AzureStorageBlob': "https://accountName.blob.core.windows.net/containerName/blobName"
   * When 'AzureStorageBlobContainer': "https://accountName.blob.core.windows.net/containerName"
   */
  uri?: string;

  /**
   * They key vault secret uri to obtain the source storage SAS token.
   */
  keyVaultUri: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PipelineTriggerProperties {
  /**
   * The source trigger properties of the pipeline.
   */
  sourceTrigger?: PipelineSourceTriggerProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PipelineSourceTriggerProperties {
  /**
   * The current status of the source trigger.
   */
  status: TriggerStatus = TriggerStatus.Enabled;
}

/**
 * The result of a request to list import pipelines for a container registry.
 */
model ImportPipelineListResult {
  /**
   * The list of import pipelines. Since this list may be incomplete, the nextLink field should be used to request the next list of import pipelines.
   */
  @pageItems
  value?: ImportPipeline[];

  /**
   * The URI that can be used to request the next list of import pipelines.
   */
  @nextLink
  nextLink?: string;
}
