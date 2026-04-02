import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SettingName {
  string,

  /**
   * Name of the Defender for Storage Settings name.
   */
  current: "current",
}

/**
 * Optional. Write scan result on blobIndexTags by default.
 */
union BlobScanResultsOptions {
  string,

  /**
   * Write scan results on the blobs index tags.
   */
  blobIndexTags: "blobIndexTags",

  /**
   * Do not write scan results on the blobs index tags.
   */
  None: "None",
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
  scanResultsEventGridTopicResourceId?: string;

  /**
   * Optional. Write scan result on blobIndexTags by default.
   */
  blobScanResultsOptions?: BlobScanResultsOptions;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  excludeBlobsLargerThan?: unknown | null;
}

/**
 * A status describing the success/failure of the enablement/disablement operation.
 */
model OperationStatus {
  /**
   * The operation status code.
   */
  code?: string;

  /**
   * Additional information regarding the success/failure of the operation.
   */
  message?: string;
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
