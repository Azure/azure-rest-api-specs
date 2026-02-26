import "./Pipeline.models.tsp";

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
@added(Versions.vLatestPreview)
union PipelineSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageBlobContainer: "AzureStorageBlobContainer",
}

/**
 * The properties of an import pipeline.
 */
@added(Versions.vLatestPreview)
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
@added(Versions.vLatestPreview)
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
  keyVaultUri?: string;

  /**
   * The storage access mode used for the customer storage account.
   */
  storageAccessMode?: StorageAccessMode = StorageAccessMode.SasToken;
}

/**
 * The trigger properties of the import pipeline
 */
model PipelineTriggerProperties {
  /**
   * The source trigger properties of the pipeline.
   */
  sourceTrigger?: PipelineSourceTriggerProperties;
}

/**
 * The source trigger properties of the import pipeline
 */
model PipelineSourceTriggerProperties {
  /**
   * The current status of the source trigger.
   */
  status: TriggerStatus = TriggerStatus.Enabled;
}

/**
 * The result of a request to list import pipelines for a container registry.
 */
@added(Versions.vLatestPreview)
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
