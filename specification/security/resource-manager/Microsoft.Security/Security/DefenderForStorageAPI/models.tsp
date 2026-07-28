import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
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
  nextLink?: string;
}

/**
 * Defender for Storage resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefenderForStorageSettingProperties {
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  capGBPerMonth?: int32;

  /**
   * Optional. Determine which blobs get scanned by On Upload malware scanning. An Or operation is performed between each filter type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  excludeBlobsWithPrefix?: string[] | null;

  /**
   * Optional. A list of suffixes to exclude from on-upload malware scanning. Suffixes match only the end of blob names, and should be used for file extensions or blob name endings only.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  excludeBlobsWithSuffix?: string[] | null;

  /**
   * Optional. Specifies the maximum size in bytes for blobs to be scanned. This parameter accepts a single positive integer value. Blobs larger than this value will be excluded from scanning.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  excludeBlobsLargerThan?: unknown | null;
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
 * Describes the state of a malware scan operation.
 */
model MalwareScan {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: MalwareScanProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MalwareScanProperties {
  /**
   * The identifier of the scan.
   */
  scanId?: string;

  /**
   * A status code of the scan operation.
   */
  scanStatus?: string;

  /**
   * A description of the status of the scan.
   */
  scanStatusMessage?: string;

  /**
   * The time at which the scan had been initiated.
   */
  scanStartTime?: string;

  /**
   * The time at which the scan has ended. Only available for a scan which has terminated.
   */
  scanEndTime?: string;

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

  /**
   * The estimated cost of the scan. Only available for a scan which has terminated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  estimatedScanCostUSD?: float64;
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scannedFilesInGB?: float64;
}

/**
 * The matching strategy for the filter.
 */
@added(Versions.v2026_01_01_preview)
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
@added(Versions.v2026_01_01_preview)
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
@added(Versions.v2026_01_01_preview)
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
@added(Versions.v2026_01_01_preview)
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
@added(Versions.v2026_01_01_preview)
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
@added(Versions.v2026_01_01_preview)
model StartMalwareScanRequestProperties {
  /**
   * Optional filters to scope the malware scan to specific blobs or files.
   */
  filters?: MalwareScanFilters;
}

/**
 * Request body for starting a malware scan with optional filters.
 */
@added(Versions.v2026_01_01_preview)
model StartMalwareScanRequest {
  /**
   * Properties for the malware scan request.
   */
  properties?: StartMalwareScanRequestProperties;
}
