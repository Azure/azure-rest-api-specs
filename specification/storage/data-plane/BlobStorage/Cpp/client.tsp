import "../main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Storage.Blob;

// Multipart construction, dispatch, and subresponse parsing remain handwritten.
@@access(Service.submitBatch, Access.internal, "cpp");
@@access(Container.submitBatch, Access.internal, "cpp");

@@alternateType(MetadataHeaders.metadata, Record<string>, "cpp");
#suppress "@azure-tools/typespec-client-generator-core/client-option" "C++ prefix header collection support."
@@clientOption(
  MetadataHeaders.metadata,
  "collectionHeaderPrefix",
  "x-ms-meta-",
  "cpp"
);

// Preserve the existing XML/Arrow readers and their streaming response ownership.
@@scope(Container.listBlobs, "!cpp");
@@scope(Container.listBlobHierarchySegment, "!cpp");
@@access(Container.listBlobs, Access.internal, "cpp");
@@access(Container.listBlobHierarchySegment, Access.internal, "cpp");

/** Returns the flat listing stream for the handwritten C++ XML/Arrow reader. */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage uses an API version header."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "C++ streaming protocol customization."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "C++ streaming protocol customization."
@scope("cpp")
@TypeSpec.Http.get
@TypeSpec.Http.sharedRoute
@TypeSpec.Http.route("?restype=container&comp=list")
op listBlobsRaw(
  ...ApiVersionHeader,
  ...ClientRequestIdHeader,
  ...PrefixParameter,
  ...MarkerParameter,
  ...MaxResultsParameter,
  ...ListBlobsIncludeParameter,
  ...TimeoutParameter,
  ...ListBlobsStartFrom,

  /** The exclusive end of the listing range. */
  @TypeSpec.Http.query("endBefore") endBefore?: string,
): {
  @TypeSpec.Http.statusCode statusCode: 200;
  @TypeSpec.Http.body body: bytes;
};

/** Returns the hierarchical listing stream for the handwritten C++ XML/Arrow reader. */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage uses an API version header."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "C++ streaming protocol customization."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "C++ streaming protocol customization."
@scope("cpp")
@TypeSpec.Http.get
@TypeSpec.Http.sharedRoute
@TypeSpec.Http.route("?restype=container&comp=list")
op listBlobsHierarchyRaw(
  ...ApiVersionHeader,
  ...ClientRequestIdHeader,

  /** The optional virtual hierarchy delimiter. */
  @TypeSpec.Http.query delimiter?: string,

  ...PrefixParameter,
  ...MarkerParameter,
  ...MaxResultsParameter,
  ...ListBlobsIncludeParameter,
  ...TimeoutParameter,
  ...ListBlobsStartFrom,

  /** The exclusive end of the listing range. */
  @TypeSpec.Http.query("endBefore") endBefore?: string,

  /** The type of entries to include. */
  @TypeSpec.Http.query("showonly") showOnly?: string,
): {
  @TypeSpec.Http.statusCode statusCode: 200;
  @TypeSpec.Http.body body: bytes;
};

// These values are already encoded in the retained Storage protocol contracts.
@@alternateType(KeyInfo.start, string, "cpp");
@@alternateType(KeyInfo.expiry, string, "cpp");
@@alternateType(UserDelegationKey.value, string, "cpp");
@@alternateType(BlobProperties.contentMd5, string, "cpp");
@@alternateType(Block.name, string, "cpp");
@@alternateType(BlockIdParameter.blockid, string, "cpp");
@@alternateType(BlockLookupList.committed, string[], "cpp");
@@alternateType(BlockLookupList.uncommitted, string[], "cpp");
@@alternateType(BlockLookupList.latest, string[], "cpp");
@@alternateType(GeoReplication.lastSyncTime, string, "cpp");
@@alternateType(ExpiryTimeParameter.expiresOn, string, "cpp");

@@alternateType(
  QueryFormat.parquetTextConfiguration,
  Customizations.StorageCppParquetConfiguration,
  "cpp"
);

// Conditional headers remain absent when the service does not return them.
@@alternateType(ContentMd5ResponseHeader.contentMd5, bytes | null, "cpp");
@@alternateType(
  ContentEncodingResponseParameter.contentEncoding,
  string | null,
  "cpp"
);
@@alternateType(
  ContentLanguageResponseHeader.contentLanguage,
  string | null,
  "cpp"
);
@@alternateType(
  ContentDispositionResponseHeader.contentDisposition,
  string | null,
  "cpp"
);
@@alternateType(CacheControlResponseHeader.cacheControl, string | null, "cpp");
@@alternateType(ContentRangeResponseHeader.contentRange, string | null, "cpp");
@@alternateType(
  BlobSequenceNumberResponseHeader.blobSequenceNumber,
  int64 | null,
  "cpp"
);
@@alternateType(
  BlobSequenceNumberResponseHeaderPrivate.blobSequenceNumber,
  int64 | null,
  "cpp"
);
@@alternateType(ContentLengthResponseHeader.contentLength, int64 | null, "cpp");
@@alternateType(
  LastModifiedResponseHeader.lastModified,
  utcDateTime | null,
  "cpp"
);
@@alternateType(
  LastModifiedResponseHeaderPrivate.lastModified,
  utcDateTime | null,
  "cpp"
);
@@alternateType(EtagResponseHeader.eTag, Azure.Core.eTag | null, "cpp");
@@alternateType(EtagResponseHeaderPrivate.eTag, Azure.Core.eTag | null, "cpp");
@@alternateType(VersionIdResponseHeader.versionId, string | null, "cpp");
@@alternateType(VersionIdResponseHeaderPrivate.versionId, string | null, "cpp");
@@alternateType(
  ImmutabilityPolicyModeResponseHeader.immutabilityPolicyMode,
  ImmutabilityPolicyMode | null,
  "cpp"
);
@@alternateType(DateResponseHeaderPrivate.date, utcDateTime | null, "cpp");
