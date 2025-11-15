import "./Pipeline.models.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * The properties of an export pipeline.
 */
@added(Versions.vLatestPreview)
model ExportPipelineProperties {
  /**
   * The target properties of the export pipeline.
   */
  target: ExportPipelineTargetProperties;

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
 * The properties of the export pipeline target.
 */
@added(Versions.vLatestPreview)
model ExportPipelineTargetProperties {
  /**
   * The type of target for the export pipeline.
   */
  type?: string;

  /**
   * The target uri of the export pipeline.
   * When 'AzureStorageBlob': "https://accountName.blob.core.windows.net/containerName/blobName"
   * When 'AzureStorageBlobContainer':  "https://accountName.blob.core.windows.net/containerName"
   */
  uri?: string;

  /**
   * They key vault secret uri to obtain the target storage SAS token.
   */
  keyVaultUri?: string;

  /**
   * The storage access mode used for the customer storage account.
   */
  storageAccessMode?: StorageAccessMode = StorageAccessMode.SasToken;
}

/**
 * The result of a request to list export pipelines for a container registry.
 */
@added(Versions.vLatestPreview)
model ExportPipelineListResult {
  /**
   * The list of export pipelines. Since this list may be incomplete, the nextLink field should be used to request the next list of export pipelines.
   */
  @pageItems
  value?: ExportPipeline[];

  /**
   * The URI that can be used to request the next list of export pipelines.
   */
  @nextLink
  nextLink?: string;
}
