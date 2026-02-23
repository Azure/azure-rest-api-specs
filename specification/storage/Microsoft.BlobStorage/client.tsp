import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.Blob;

namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust,go"
)
interface BlobServiceClient extends Storage.Blob.Service {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust,go"
)
interface BlobContainerClient extends Storage.Blob.Container {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust,go"
)
interface BlobClient extends Storage.Blob.Blob {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust,go"
)
interface AppendBlobClient extends Storage.Blob.AppendBlob {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust,go"
)
interface BlockBlobClient extends Storage.Blob.BlockBlob {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust,go"
)
interface PageBlobClient extends Storage.Blob.PageBlob {}

// @@clientInitialization(BlobServiceClient,
//   {
//     initializedBy: InitializedBy.customizeCode,
//   }
// );

// @@clientInitialization(BlobContainerClient,
//   {
//     initializedBy: InitializedBy.customizeCode,
//   }
// );

// @@clientInitialization(BlobClient,
//   {
//     initializedBy: InitializedBy.customizeCode,
//   }
// );

// @@clientInitialization(AppendBlobClient,
//   {
//     initializedBy: InitializedBy.customizeCode,
//   }
// );

// @@clientInitialization(BlockBlobClient,
//   {
//     initializedBy: InitializedBy.customizeCode,
//   }
// );

// @@clientInitialization(PageBlobClient,
//   {
//     initializedBy: InitializedBy.customizeCode,
//   }
// );

@@usage(BlobName, Usage.output, "rust");

@@alternateType(BlobItem.name, string, "rust");
@@alternateType(BlobPrefix.name, string, "rust");

@@clientOption(BlobItem.name,
  "deserialize_with",
  "crate::models::deserialize_blob_name",
  "rust"
);
@@clientOption(BlobPrefix.name,
  "deserialize_with",
  "crate::models::deserialize_blob_name",
  "rust"
);

@@clientNamespace(Storage.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.AppendBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.BlockBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.PageBlob, "Azure.Storage.Blobs");

@@clientName(Storage.Blob.BlockBlob.upload, "upload_internal", "rust");
@@clientName(Storage.Blob.Blob.download, "download_internal", "rust");

@@clientName(ContainerProperties.denyEncryptionScopeOverride,
  "PreventEncryptionScopeOverride"
);
@@clientName(ContainerProperties.immutableStorageWithVersioningEnabled,
  "IsImmutableStorageWithVersioningEnabled"
);
@@clientName(BlobProperties.expiryTime, "ExpiresOn");
@@clientName(BlobProperties.sealed, "IsSealed");
@@clientName(BlobProperties.lastAccessTime, "LastAccessedOn");
@@clientName(BlobProperties.immutabilityPolicyUntilDate,
  "ImmutabilityPolicyExpiresOn"
);
@@clientName(MetadataHeaders.metadata, "metadata", "rust");
@@clientName(ObjectReplicationHeaders.objectReplicationRules,
  "objectReplicationRules",
  "rust"
);
@@clientName(ImmutabilityPolicyExpiryRequiredParameter.immutabilityPolicyExpiry,
  "expiry",
  "!python"
);

@@alternateType(AccessPolicy.start, string, "javascript");
@@alternateType(AccessPolicy.expiry, string, "javascript");
@@alternateType(UserDelegationKey.signedStart, string, "javascript");
@@alternateType(UserDelegationKey.signedExpiry, string, "javascript");

@@clientName(AccessPolicy.start, "startsOn", "javascript");
@@clientName(AccessPolicy.expiry, "expiresOn", "javascript");
@@clientName(AccessPolicy.permission, "permissions", "javascript");
@@clientName(BlobProperties.accessTierChangeTime,
  "accessTierChangedOn",
  "javascript"
);
@@clientName(BlobProperties.creationTime, "createdOn", "javascript");
@@clientName(BlobProperties.copyCompletionTime,
  "copyCompletedOn",
  "javascript"
);
@@clientName(BlobProperties.deletedTime, "deletedOn", "javascript");
@@clientName(BlobProperties.eTag, "etag", "javascript");
@@clientName(ContainerProperties.deletedTime, "deletedOn", "javascript");
@@clientName(ContainerProperties.eTag, "etag", "javascript");
@@clientName(EtagResponseHeader.eTag, "etag", "javascript");
@@clientName(GeoReplication.lastSyncTime, "lastSyncOn", "javascript");
@@clientName(KeyInfo.start, "startsOn", "javascript");
@@clientName(KeyInfo.expiry, "expiresOn", "javascript");
@@clientName(BlobServiceProperties.logging,
  "blobAnalyticsLogging",
  "javascript"
);
@@clientName(Logging.delete, "deleteProperty", "javascript");
@@clientName(Metrics.includeApis, "includeAPIs", "javascript");
@@clientName(UserDelegationKey.signedOid, "signedObjectId", "javascript");
@@clientName(UserDelegationKey.signedTid, "signedTenantId", "javascript");
@@clientName(UserDelegationKey.signedStart, "signedStartsOn", "javascript");
@@clientName(UserDelegationKey.signedExpiry, "signedExpiresOn", "javascript");
@@clientName(FilterBlobSegment.nextMarker, "continuationToken", "javascript");
@@clientName(ListContainersSegmentResponse.NextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(MaxResultsParameter.maxresults, "maxPageSize", "javascript");
@@clientName(ListContainersSegmentResponse.maxResults,
  "maxPageSize",
  "javascript"
);
@@clientName(ListBlobsResponse.nextMarker, "continuationToken", "javascript");
@@clientName(ListBlobsResponse.maxResults, "maxPageSize", "javascript");
@@clientName(PageList.nextMarker, "continuationToken", "javascript");
@@clientName(ListBlobsHierarchySegmentResponse.nextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(ListBlobsHierarchySegmentResponse.maxResults,
  "maxPageSize",
  "javascript"
);
@@clientName(BlobPublicAccess.access, "blobPublicAccess", "javascript");
@@clientName(LeaseDurationResponseHeader.duration,
  "leaseDuration",
  "javascript"
);
@@alternateType(BlobProperties.contentLength, uint64, "rust");
@@alternateType(BlobContentLengthRequired.size, uint64, "rust");
@@alternateType(ContentLengthResponseHeader.contentLength, uint64, "rust");
@@alternateType(ContentLengthParameter.contentLength, uint64, "rust");
@@alternateType(StructuredContentLengthParameter.structuredContentLength,
  uint64,
  "rust"
);
@@alternateType(StructuredContentLengthResponseHeader.structuredContentLength,
  uint64,
  "rust"
);

@@scope(Storage.Blob.Container.submitBatch, "!rust");
@@scope(Storage.Blob.Service.submitBatch, "!rust");

// GO SPECIFICATION
/** The algorithm used to produce the encryption key hash. Currently, the only accepted value is \"AES256\". Must be provided if the x-ms-encryption-key header is provided. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum EncryptionAlgorithmTypeGo {
  /** The AES256 encryption algorithm. */
  AES256: "AES256",

  /** Deprecated */
  None: "None",
}
/** The list blob includes parameter values. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ListBlobsIncludeItemGo {
  /** The include copies. */
  Copy: "copy",

  /** The include deleted blobs. */
  Deleted: "deleted",

  /** The include metadata. */
  Metadata: "metadata",

  /** The include snapshots. */
  Snapshots: "snapshots",

  /** The include uncommitted blobs. */
  UncommittedBlobs: "uncommittedblobs",

  /** The include versions. */
  Versions: "versions",

  /** The include tags. */
  Tags: "tags",

  /** The include immutable policy. */
  ImmutabilityPolicy: "immutabilitypolicy",

  /** The include legal hold. */
  LegalHold: "legalhold",

  /** The include deleted with versions. */
  DeletedWithVersions: "deletedwithversions",

  /** Deprecated */
  Permissions: "permissions",
}
/** The immutability policy mode used in requests and responses. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ImmutabilityPolicySetting {
  /** The immutability policy is locked. */
  Locked: "locked",

  /** The immutability policy is unlocked. */
  Unlocked: "unlocked",
}
@@alternateType(AccessPolicy.start, utcDateTime, "go");
@@alternateType(AccessPolicy.expiry, utcDateTime, "go");
@@alternateType(BlobItem.name, string, "go");
@@alternateType(BlobItem.metadata, Record<string>, "go");
@@alternateType(BlobItem.objectReplicationMetadata, Record<string>, "go");
@@alternateType(BlobPrefix.name, string, "go");
@@alternateType(BlockIdParameter.blockid, string, "go");
@@alternateType(BlockLookupList.latest, string[], "go");
@@alternateType(EncryptionAlgorithmParameter.encryptionAlgorithm,
  EncryptionAlgorithmTypeGo,
  "go"
);
@@alternateType(ImmutabilityPolicyModeParameter.immutabilityPolicyMode,
  ImmutabilityPolicySetting,
  "go"
);
@@alternateType(SourceEncryptionAlgorithmParameter.sourceEncryptionAlgorithm,
  EncryptionAlgorithmTypeGo,
  "go"
);
@@alternateType(ListBlobsIncludeParameter.include,
  ListBlobsIncludeItemGo[],
  "go"
);
@@alternateType(UserDelegationKey.signedExpiry, utcDateTime, "go");
@@alternateType(UserDelegationKey.signedStart, utcDateTime, "go");
@@alternateType(UserDelegationKey.value, string, "go");
@@clientName(BlobContainerClient, "ContainerClient", "go");
@@clientName(BlobServiceClient, "ServiceClient", "go");
@@clientName(BlobDeleteTypeGo, "DeleteType", "go");
@@clientName(BlobExpiryOptions, "ExpiryOptions", "go");
@@clientName(BlobItem.objectReplicationMetadata, "OrMetadata", "go");
@@clientName(BlobServiceProperties, "StorageServiceProperties", "go");
@@clientName(BlobServiceProperties.cors, "CORS", "go");
@@clientName(CorsRule, "CORSRule", "go");
@@clientName(Error, "StorageError", "go");
@@clientName(EncryptionAlgorithmTypeGo, "EncryptionAlgorithmType", "go");
@@clientName(GeoReplicationStatusType, "BlobGeoReplicationStatus", "go");
@@clientName(ListBlobsIncludeItemGo, "ListBlobsIncludeItem", "go");
@@clientName(ListBlobsResponse, "ListBlobsFlatSegmentResponse", "go");
@@clientName(QueryType, "QueryFormatType", "go");
@@clientName(Storage.Blob.Blob.setProperties, "SetHTTPHeaders", "go");
@@clientName(Storage.Blob.Container.findBlobsByTags, "FilterBlobs", "go");
@@clientName(Storage.Blob.Container.listBlobs, "ListBlobFlatSegment", "go");
@@clientName(Storage.Blob.Service.listContainers,
  "ListContainersSegment",
  "go"
);
@@clientName(Storage.Blob.PageBlob.setSequenceNumber,
  "UpdateSequenceNumber",
  "go"
);
@@clientName(Storage.Blob.Service.findBlobsByTags, "FilterBlobs", "go");
@@clientName(UserDelegationKey.signedDelegatedUserTid,
  "SignedDelegatedUserTID",
  "go"
);
@@clientName(UserDelegationKey.signedOid, "SignedOID", "go");
@@clientName(UserDelegationKey.signedTid, "SignedTID", "go");

@@alternateType(AccessPolicy.start, string, "python");
@@alternateType(AccessPolicy.expiry, string, "python");

@@clientName(QueryType, "QueryFormatType", "python");
@@clientName(Storage.Blob.BlockBlob.uploadBlobFromUrl,
  "putBlobFromUrl",
  "python"
);
@@clientName(BlobServiceProperties, "StorageServiceProperties", "python");
@@clientName(Storage.Blob.Blob.setProperties, "setHttpHeaders", "python");
@@clientName(Storage.Blob.PageBlob.setSequenceNumber,
  "updateSequenceNumber",
  "python"
);
@@clientName(Storage.Blob.Service.findBlobsByTags, "filterBlobs", "python");
@@clientName(Storage.Blob.Container.findBlobsByTags, "filterBlobs", "python");

@@alternateType(BlockIdParameter.blockid, string, "python");

@@Legacy.disablePageable(Storage.Blob.Container.listBlobs, "python,javascript");
@@Legacy.disablePageable(Storage.Blob.Container.listBlobHierarchySegment,
  "python,javascript"
);
@@Legacy.disablePageable(Storage.Blob.Service.listContainers,
  "python,javascript"
);

@@clientName(Storage.Blob.Container.listBlobs, "listBlobFlatSegment", "python");
@@clientName(Storage.Blob.Service.listContainers,
  "listContainersSegment",
  "python"
);

@@clientOption(Storage.Blob, "includeRootSlash", false, "python,javascript");

@@scope(Storage.Blob.Service.getUserDelegationKey, "!rust");
@@scope(Storage.Blob.Container.listBlobHierarchySegment, "!rust");
@@scope(Storage.Blob.Container.rename, "!rust");
@@scope(Storage.Blob.Container.restore, "!rust");
@@scope(Storage.Blob.Blob.abortCopyFromUrl, "!rust");
@@scope(Storage.Blob.Blob.copyFromUrl, "!rust");
@@scope(Storage.Blob.Blob.setExpiry, "!rust");
@@scope(Storage.Blob.Blob.startCopyFromUrl, "!rust");
@@scope(Storage.Blob.BlockBlob.query, "!rust");
@@scope(Storage.Blob.PageBlob.copyIncremental, "!rust");
@@scope(Storage.Blob.PageBlob.getPageRangesDiff, "!rust");

@@clientName(Storage.Blob.ContainerProperties.eTag, "etag", "python");
@@clientName(Storage.Blob.ContainerItem.delete, "deleted", "python");

@@alternateType(Storage.Blob.UserDelegationKey.signedStart, string, "python");
@@alternateType(Storage.Blob.UserDelegationKey.signedExpiry, string, "python");
@@alternateType(Storage.Blob.UserDelegationKey.value, string, "python");
@@alternateType(Storage.Blob.Block.name, string, "python");
