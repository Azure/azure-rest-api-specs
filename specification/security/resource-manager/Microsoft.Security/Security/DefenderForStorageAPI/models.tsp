import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace DefenderForStorageAPI;

/**
 * Optional. Write scan result on BlobIndexTags by default.
 */
union BlobScanResultsOptions {
  string,

  /**
   * Write scan results on the blobs index tags.
   */
  BlobIndexTags: "BlobIndexTags",

  /**
   * Do not write scan results on the blobs index tags.
   */
  None: "None",
}

/**
 * Optional. Specifies the automated response action to take when malware is detected.
 */
union AutomatedResponseType {
  string,

  /**
   * No automated response will be taken when malware is detected.
   */
  None: "None",

  /**
   * The blob will be soft deleted when malware is detected.
   */
  BlobSoftDelete: "BlobSoftDelete",
}

/**
 * List of Defender for Storage settings.
 */
model DefenderForStorageSettingList {
  /**
   * List of Defender for Storage settings.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: DefenderForStorageSetting[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  nextLink?: url;
}

/**
 * List of Defender for Storage malware scans.
 */
model MalwareScanList {
  /**
   * List of Defender for Storage malware scans.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: MalwareScan[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  nextLink?: url;
}

/**
 * The provisioning state of the Defender for Storage settings resource.
 */
@Azure.Core.lroStatus
union DefenderForStorageProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,

  /**
   * The resource is being provisioned.
   */
  InProgress: "InProgress",
}

/**
 * Defender for Storage resource properties.
 */
model DefenderForStorageSettingProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DefenderForStorageProvisioningState;

  /**
   * Indicates whether Defender for Storage is enabled on this storage account.
   */
  isEnabled?: boolean;

  /**
   * Properties of Malware Scanning.
   */
  malwareScanning?: MalwareScanningProperties;

  /**
   * Properties of Sensitive Data Discovery.
   */
  sensitiveDataDiscovery?: SensitiveDataDiscoveryProperties;

  /**
   * Indicates whether the settings defined for this storage account should override the settings defined for the subscription.
   */
  overrideSubscriptionLevelSettings?: boolean;
}

/**
 * Properties of Malware Scanning.
 */
model MalwareScanningProperties {
  /**
   * Properties of On Upload malware scanning.
   */
  onUpload?: OnUploadProperties;

  /**
   * Optional. Resource id of an Event Grid Topic to send scan results to.
   */
  scanResultsEventGridTopicResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EventGrid/topics";
    }
  ]>;

  /**
   * Optional. Write scan result on BlobIndexTags by default.
   */
  blobScanResultsOptions?: BlobScanResultsOptions = BlobScanResultsOptions.BlobIndexTags;

  /**
   * Optional. Specifies the automated response action to take when malware is detected.
   */
  automatedResponse?: AutomatedResponseType = AutomatedResponseType.None;

  /**
   * Upon failure or partial success. Additional data describing Malware Scanning enable/disable operation.
   */
  @visibility(Lifecycle.Read)
  operationStatus?: OperationStatus;
}

/**
 * Properties of On Upload malware scanning.
 */
model OnUploadProperties {
  /**
   * Indicates whether On Upload malware scanning should be enabled.
   */
  isEnabled?: boolean;

  /**
   * Defines the max GB to be scanned per Month. Set to -1 if no capping is needed. If not specified, the default value is -1.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserves the JSON property name 'capGBPerMonth' published in 2025-09-01-preview; changing its casing would break compatibility with existing clients."
  capGBPerMonth?: int32;

  /**
   * The number of gigabytes scanned by On Upload malware scanning during the current month. Reflects the current month's usage.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "'GB' matches the casing of the existing capGBPerMonth, scannedBlobsInGB and scannedFilesInGB properties in this spec."
  @visibility(Lifecycle.Read)
  scannedGBThisMonth?: float64;

  /**
   * Optional. Determine which blobs get scanned by On Upload malware scanning. An Or operation is performed between each filter type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Service explicitly returns null when no filters are configured, not just omits the field."
  filters?: OnUploadFilters | null;
}

/**
 * Optional. Determine which blobs get scanned by On Upload malware scanning. An Or operation is performed between each filter type.
 */
model OnUploadFilters {
  /**
   * Optional. A list of prefixes to exclude from on-upload malware scanning.
   * Format: `container-name/blob-name` (start with the container name; do not include the storage account name).
   * Exclude entire containers: Use prefix of container names you want to exclude without a trailing `/`.
   * Exclude a single container: Add a trailing slash `/` after the container name to avoid excluding other containers with similar prefixes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Service explicitly returns null when no prefixes are configured, not just omits the field."
  excludeBlobsWithPrefix?: string[] | null;

  /**
   * Optional. A list of suffixes to exclude from on-upload malware scanning. Suffixes match only the end of blob names, and should be used for file extensions or blob name endings only.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Service explicitly returns null when no suffixes are configured, not just omits the field."
  excludeBlobsWithSuffix?: string[] | null;

  /**
   * Optional. Specifies the maximum size in bytes for blobs to be scanned. This parameter accepts a single positive integer value. Blobs larger than this value will be excluded from scanning.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Service explicitly returns null when no size limit is configured, not just omits the field."
  excludeBlobsLargerThan?: int64 | null;
}

/**
 * Properties of Sensitive Data Discovery.
 */
model SensitiveDataDiscoveryProperties {
  /**
   * Indicates whether Sensitive Data Discovery should be enabled.
   */
  isEnabled?: boolean;

  /**
   * Upon failure or partial success. Additional data describing Sensitive Data Discovery enable/disable operation.
   */
  @visibility(Lifecycle.Read)
  operationStatus?: OperationStatus;
}

/**
 * A status code of the malware scan operation.
 */
union MalwareScanStatus {
  string,

  /** The scan request has been queued and is waiting to be processed. */
  Queued: "Queued",

  /** The scan is currently in progress. */
  InProgress: "InProgress",

  /** The scan has finished processing and is waiting for final results. */
  WaitingForCompletion: "WaitingForCompletion",

  /** The scan is being cancelled upon user request. */
  Canceling: "Canceling",

  /** The scan has been canceled. */
  Canceled: "Canceled",

  /** The scan failed. */
  Failed: "Failed",

  /** The scan has completed successfully. */
  Completed: "Completed",
}

/**
 * Properties of a malware scan operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "MalwareScan is a read-only resource created via the startMalwareScan action (no PUT/PATCH). Its lifecycle is modeled by scanStatus; an ARM provisioningState is not applicable."
model MalwareScanProperties {
  /**
   * The identifier of the scan.
   */
  scanId?: string;

  /**
   * A status code of the scan operation.
   */
  scanStatus?: MalwareScanStatus;

  /**
   * A description of the status of the scan.
   */
  scanStatusMessage?: string;

  /**
   * The time at which the scan had been initiated.
   */
  scanStartTime?: utcDateTime;

  /**
   * The time at which the scan has ended. Only available for a scan which has terminated.
   */
  scanEndTime?: utcDateTime;

  /**
   * A summary of the scan results.
   */
  scanSummary?: ScanSummary;
}

/**
 * A summary of the scan results.
 */
model ScanSummary {
  /**
   * A summary of the scan results of the blobs that were scanned.
   */
  blobs?: BlobsScanSummary;

  /**
   * A summary of the scan results of the files that were scanned.
   */
  files?: FilesScanSummary;
}

/**
 * A summary of the scan results of the blobs that were scanned.
 */
model BlobsScanSummary {
  /**
   * The total number of blobs that were scanned.
   */
  totalBlobsScanned?: int64;

  /**
   * The number of malicious blobs that were detected during the scan.
   */
  maliciousBlobsCount?: int64;

  /**
   * The number of blobs that were skipped.
   */
  skippedBlobsCount?: int64;

  /**
   * The number of failed blob scans.
   */
  failedBlobsCount?: int64;

  /**
   * The number of gigabytes of data that were scanned.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserves the JSON response property name 'scannedBlobsInGB' published in 2025-09-01-preview; changing its casing would break compatibility with existing clients."
  scannedBlobsInGB?: float64;
}

/**
 * A summary of the scan results of the files that were scanned.
 */
model FilesScanSummary {
  /**
   * The total number of files that were scanned.
   */
  totalFilesScanned?: int64;

  /**
   * The number of malicious files that were detected during the scan.
   */
  maliciousFilesCount?: int64;

  /**
   * The number of files that were skipped.
   */
  skippedFilesCount?: int64;

  /**
   * The number of failed file scans.
   */
  failedFilesCount?: int64;

  /**
   * The number of gigabytes of data that were scanned.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserves the JSON response property name 'scannedFilesInGB' published in 2025-09-01-preview; changing its casing would break compatibility with existing clients."
  scannedFilesInGB?: float64;
}

/**
 * The matching strategy for the filter.
 */
union MatchType {
  string,

  /**
   * Match resources with values starting with the specified string.
   */
  Prefix: "Prefix",

  /**
   * Match resources with the exact value specified.
   */
  Exact: "Exact",
}

/**
 * Filter with value and matching strategy.
 */
model MatchFilter {
  /**
   * The value to match against.
   */
  value: string;

  /**
   * The matching strategy for the filter.
   */
  match: MatchType;
}

/**
 * Filter for blob scanning. At least one of 'container' or 'blob' must be specified; a request with neither is rejected by the service. If only container is provided, all blobs in that container are scanned. If only blob is provided, blobs matching the filter across all containers are scanned.
 */
model BlobScanFilter {
  /**
   * Optional filter for the blob container to scan. If not provided, the blob filter will apply across all containers.
   */
  container?: MatchFilter;

  /**
   * Optional filter for specific blob(s). If container is specified, this filters blobs within that container. If container is not specified, this filters blobs across all containers.
   */
  blob?: MatchFilter;
}

/**
 * Filter for file scanning. At least one of 'share' or 'file' must be specified; a request with neither is rejected by the service. If only share is provided, all files in that share are scanned. If only file is provided, files matching the filter across all shares are scanned.
 */
model FileScanFilter {
  /**
   * Optional filter for the file share to scan. If not provided, the file filter will apply across all shares.
   */
  share?: MatchFilter;

  /**
   * Optional filter for specific file(s). If share is specified, this filters files within that share. If share is not specified, this filters files across all shares.
   */
  file?: MatchFilter;
}

/**
 * Filters to scope the malware scan.
 */
model MalwareScanFilters {
  /**
   * Optional filter for blob scanning. Specifies which blobs to scan.
   */
  blobs?: BlobScanFilter;

  /**
   * Optional filter for file scanning. Specifies which files to scan.
   */
  files?: FileScanFilter;
}

/**
 * Properties for the malware scan request.
 */
model StartMalwareScanRequestProperties {
  /**
   * Optional filters to scope the malware scan to specific blobs or files.
   */
  filters?: MalwareScanFilters;
}

/**
 * Request body for starting a malware scan with optional filters.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model StartMalwareScanRequest {
  /**
   * Properties for the malware scan request.
   */
  properties?: StartMalwareScanRequestProperties;
}
