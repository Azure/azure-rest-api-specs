import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace DeviceRegistrySoftwareUpdateClient;

// ---------------------------------------------------------------------------
// Shared operation template
// ---------------------------------------------------------------------------

/** Standard operation with the Azure.Core error response. */
alias ServiceOperation<
  Params extends TypeSpec.Reflection.Model,
  Response
> = Foundations.Operation<Params, Response, {}, Foundations.ErrorResponse>;

// ---------------------------------------------------------------------------
// Shared parameter models. These are spread (...) into operations so the
// autorest emitter promotes them to global #/parameters/* entries, matching
// the original hand-authored swagger.
// ---------------------------------------------------------------------------

/** Update provider parameter. */
model UpdateProviderParameter {
  /**
   * Update provider.
   */
  @path
  provider: string;
}

/** Update name parameter. */
model UpdateNameParameter {
  /**
   * Update name.
   */
  @path
  name: string;
}

/** Update version parameter. */
model UpdateVersionParameter {
  /**
   * Update version.
   */
  @path
  version: string;
}

/** Update file id parameter. */
model FileIdParameter {
  /**
   * File identifier.
   */
  @path
  fileId: string;
}

/** If-None-Match access condition parameter. */
model IfNoneMatchParameter {
  /**
   * Defines the If-None-Match condition. The operation will be performed only if
   * the ETag on the server does not match this value.
   */
  @header("If-None-Match")
  ifNoneMatch?: string;
}

/** Operation id parameter. */
model OperationIdParameter {
  /**
   * Operation identifier.
   */
  @maxLength(256)
  @minLength(1)
  @path
  operationId: string;
}

/** Device class id parameter. */
model DeviceClassIdParameter {
  /**
   * Device class identifier.
   */
  @path
  deviceClassId: string;
}

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

/**
 * Step type.
 */
union StepType {
  string,

  /**
   * Step type that performs code execution.
   */
  Inline: "inline",

  /**
   * Step type that installs another update.
   */
  Reference: "reference",
}

/**
 * Operation status filter.
 */
union OperationFilterStatus {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",
}

// ---------------------------------------------------------------------------
// Update (content) models
// ---------------------------------------------------------------------------

/**
 * The list of updates.
 */
model UpdateList is Azure.Core.Page<Update>;

/**
 * Key-value pairs representing update compatibility information.
 */
model Compatibility is Record<string>;

/**
 * Update metadata.
 */
model Update {
  /**
   * Update identity.
   */
  updateId: UpdateId;

  /**
   * Update description specified by creator.
   */
  @maxLength(512)
  @minLength(1)
  description?: string;

  /**
   * Friendly update name specified by importer.
   */
  @maxLength(512)
  @minLength(1)
  friendlyName?: string;

  /**
   * Whether the update can be deployed to a device on its own.
   */
  isDeployable?: boolean = true;

  /**
   * Update type. Deprecated in latest import manifest schema.
   */
  updateType?: string;

  /**
   * String interpreted by Device Update client to determine if the update is
   * installed on the device. Deprecated in latest import manifest schema.
   */
  installedCriteria?: string;

  /**
   * List of update compatibility information.
   */
  @minItems(1)
  @maxItems(10)
  compatibility: Compatibility[];

  /**
   * Update install instructions.
   */
  instructions?: Instructions;

  /**
   * List of update identities that reference this update.
   */
  @minItems(1)
  referencedBy?: UpdateId[];

  /**
   * Update aggregate scan result (calculated from payload file scan results).
   */
  scanResult?: string;

  /**
   * Schema version of manifest used to import the update.
   */
  manifestVersion: string;

  /**
   * Date and time in UTC when the update was imported.
   */
  importedDateTime: utcDateTime;

  /**
   * Date and time in UTC when the update was created.
   */
  createdDateTime: utcDateTime;

  /**
   * Update ETag.
   */
  etag?: eTag;
}

/**
 * Update identifier.
 */
model UpdateId {
  /**
   * Update provider. Must be between 1 and 64 characters and contain only letters, digits, periods, and hyphens.
   */
  @minLength(1)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9.-]+$")
  provider: string;

  /**
   * Update name. Must be between 1 and 64 characters and contain only letters, digits, periods, and hyphens.
   */
  @minLength(1)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9.-]+$")
  name: string;

  /**
   * Update version as a two- to four-part dot-separated numeric string.
   */
  @minLength(3)
  @pattern("^\\d+(\\.\\d+){1,3}$")
  version: string;
}

/**
 * Update install instructions container.
 */
model Instructions {
  /**
   * Collection of installation steps.
   */
  @minItems(1)
  @maxItems(10)
  steps: Step[];
}

/**
 * Update install instruction step.
 */
model Step {
  /**
   * Step type.
   */
  type?: StepType = StepType.Inline;

  /**
   * Step description.
   */
  @maxLength(64)
  @minLength(1)
  description?: string;

  /**
   * Identity of handler that will execute this step. Required if step type is
   * inline.
   */
  @maxLength(32)
  @minLength(1)
  handler?: string;

  /**
   * Parameters to be passed to handler during execution.
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "handlerProperties intentionally preserves the original swagger additionalProperties: {} shape for arbitrary handler-specific settings."
  handlerProperties?: Record<unknown>;

  /**
   * Collection of file names to be passed to handler during execution. Required if
   * step type is inline.
   */
  @minItems(1)
  @maxItems(5)
  fileNames?: string[];

  /**
   * Referenced child update identity.  Required if step type is reference.
   */
  updateId?: UpdateId;
}

/**
 * Import update input metadata.
 */
model ImportUpdateRequest {
  /**
   * Import update input metadata.
   */
  @minItems(1)
  @maxItems(11)
  importUpdateInput: ImportUpdateInputItem[];

  /**
   * Whether to enable anti-malware scan of the imported update payload files.
   */
  enableScan?: boolean = false;
}

/**
 * Import update input item metadata.
 */
model ImportUpdateInputItem {
  /**
   * Import manifest metadata like source URL, file size/hashes, etc.
   */
  importManifest: ImportManifestMetadata;

  /**
   * Friendly update name.
   */
  @maxLength(512)
  @minLength(1)
  friendlyName?: string;

  /**
   * One or more update file properties like file name and source URL.
   */
  @minItems(1)
  @maxItems(5)
  files?: FileImportMetadata[];
}

/**
 * Metadata describing the import manifest, a document which describes the files
 * and other metadata about an update version.
 */
model ImportManifestMetadata {
  /**
   * Azure Blob location from which the import manifest can be downloaded by Device
   * Update for Device Registry. This is typically a read-only SAS-protected blob URL
   * with an expiration set to at least 4 hours.
   */
  url: string;

  /**
   * File size in number of bytes.
   */
  sizeInBytes: int64;

  /**
   * A JSON object containing the hash(es) of the file. At least SHA256 hash is
   * required. This object can be thought of as a set of key-value pairs where the
   * key is the hash algorithm, and the value is the hash of the file calculated
   * using that algorithm.
   */
  hashes: Record<string>;
}

/**
 * Metadata describing an update file.
 */
model FileImportMetadata {
  /**
   * Update file name as specified inside import manifest.
   */
  fileName: string;

  /**
   * Azure Blob location from which the update file can be downloaded by Device
   * Update for Device Registry. This is typically a read-only SAS-protected blob URL
   * with an expiration set to at least 4 hours.
   */
  url: string;
}

/**
 * The list of strings with server paging support.
 */
model StringsList {
  /** The collection of pageable items. */
  @pageItems value: string[];

  /** The link to the next page of items. */
  @nextLink nextLink?: string;
}

/**
 * Update file metadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model UpdateFile extends UpdateFileBase {
  /**
   * File identity, generated by server at import time.
   */
  fileId: string;

  /**
   * Optional related files metadata used together DownloadHandler metadata to
   * download payload file.
   */
  relatedFiles?: UpdateFileBase[];

  /**
   * Optional download handler for utilizing related files to download payload file.
   */
  downloadHandler?: UpdateFileDownloadHandler;

  /**
   * File ETag.
   */
  etag?: eTag;
}

/**
 * Update file basic metadata.
 */
model UpdateFileBase {
  /**
   * File name.
   */
  fileName: string;

  /**
   * File size in number of bytes.
   */
  sizeInBytes: int64;

  /**
   * Mapping of hashing algorithm to base64 encoded hash values.
   */
  hashes: Record<string>;

  /**
   * File MIME type.
   */
  mimeType?: string;

  /**
   * Anti-malware scan result.
   */
  scanResult?: string;

  /**
   * Anti-malware scan details.
   */
  scanDetails?: string;

  /**
   * Optional file properties (not consumed by service but pass-through to device).
   */
  properties?: Record<string>;
}

/**
 * Download handler for utilizing related files to download payload file.
 */
model UpdateFileDownloadHandler {
  /**
   * Download handler identifier.
   */
  id: string;
}

/**
 * The list of operations with server paging support.
 */
model UpdateOperationsList is Azure.Core.Page<UpdateOperation>;

/**
 * Operation metadata.
 */
model UpdateOperation {
  /**
   * Operation Id.
   */
  operationId: string;

  /**
   * Operation status.
   */
  status: Foundations.OperationState;

  /**
   * The update being imported or deleted. For import, this property will only be
   * populated after import manifest is processed successfully.
   */
  update?: UpdateInfo;

  /**
   * Location of the imported update when operation is successful.
   */
  resourceLocation?: string;

  /**
   * Operation error encountered, if any.
   */
  @lroErrorResult
  error?: Foundations.Error;

  /**
   * Operation correlation identity that can used by Microsoft Support for
   * troubleshooting.
   */
  traceId?: string;

  /**
   * Date and time in UTC when the operation status was last updated.
   */
  lastActionDateTime: utcDateTime;

  /**
   * Date and time in UTC when the operation was created.
   */
  createdDateTime: utcDateTime;

  /**
   * Operation ETag.
   */
  etag?: eTag;
}

/**
 * Update information.
 */
model UpdateInfo {
  /**
   * Update identifier.
   */
  updateId: UpdateId;

  /**
   * Update description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Friendly update name.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;
}
