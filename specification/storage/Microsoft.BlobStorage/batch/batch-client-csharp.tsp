import "@azure-tools/typespec-client-generator-core";
import "../main.tsp";
import "../client.tsp";

using Azure.ClientGenerator.Core;
using Storage.Blob;
using TypeSpec.Http;

namespace BatchCustomizations;

// Root client
@client(
  {
    name: "BlobBatchClient",
    service: Storage.Blob
  },
  "csharp"
)

namespace BlobBatchClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @operationGroup("csharp")
  interface BatchServiceClient {
    submitBatch is Storage.Blob.Service.submitBatch;
  }

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @operationGroup("csharp")
  interface BatchContainerClient {
    submitBatch is containerSubmitBatchCsharp;
  }

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @operationGroup("csharp")
  interface BatchBlobClient {
    delete is deleteCsharp;
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    setAccessTier is setTierCsharp;
  }
}

/** Initialization parameters for the BlobRestClient. */
model BatchBlobClientOptions {
  /** The snapshot parameter is an opaque DateTime value that, when present, specifies the blob snapshot to retrieve. */
  snapshot?: SnapshotParameter.snapshot;
}

@@clientInitialization(BlobBatchClient.BatchServiceClient,
  {
    initializedBy: InitializedBy.parent,
  },
  "csharp"
);

@@clientInitialization(BlobBatchClient.BatchContainerClient,
  {
    initializedBy: InitializedBy.parent,
  },
  "csharp"
);

@@clientInitialization(BlobBatchClient.BatchBlobClient,
  {
    parameters: BatchBlobClientOptions,
    initializedBy: InitializedBy.parent,
  },
  "csharp"
);

/** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
@post
@route("/{containerName}?restype=container&comp=batch")
@scope("csharp")
op containerSubmitBatchCsharp(
  /** Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID> */
  @header("Content-Type")
  @alternateType(string, "csharp")
  contentType: "multipart/mixed",

  ...ApiVersionHeader,
  ...TimeoutParameter,
  ...ClientRequestIdHeader,
  ...ContentLengthParameter,

  /** The batch request content */
  ...MultipartBodyParameter,

  /** The container name */
  @path containerName: string,
): ({
  @statusCode statusCode: 202;

  /** The media type of the body of the response. For batch requests, this is multipart/mixed; boundary=batchresponse_GUID */
  #suppress "@typespec/http/content-type-ignored" "Template for existing API"
  @header("Content-Type")
  contentType: "multipart/mixed";

  ...RequestIdResponseHeader;
  ...ApiVersionHeader;
} & MultipartBodyParameter) | Error;

/** If the storage account's soft delete feature is disabled then, when a blob is deleted, it is permanently removed from the storage account. If the storage account's soft delete feature is enabled, then, when a blob is deleted, it is marked for deletion and becomes inaccessible immediately. However, the blob service retains the blob or snapshot for the number of days specified by the DeleteRetentionPolicy section of [Storage service properties] (Set-Blob-Service-Properties.md). After the specified number of days has passed, the blob's data is permanently removed from the storage account. Note that you continue to be charged for the soft-deleted blob's storage until it is permanently removed. Use the List Blobs API and specify the \"include=deleted\" query parameter to discover which blobs and snapshots have been soft deleted. You can then use the Undelete Blob API to restore a soft-deleted blob. All other operations on a soft-deleted blob or snapshot causes the service to return an HTTP status code of 404 (ResourceNotFound). */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
@delete
@route("/{containerName}/{blob}")
@scope("csharp")
op deleteCsharp is StorageOperationNoBody<
  {
    ...SnapshotParameter;
    ...VersionIdParameter;
    ...TimeoutParameter;
    ...LeaseIdOptionalParameter;

    /** Required if the blob has associated snapshots. Specify one of the following two options: include: Delete the base blob and all of its snapshots. only: Delete only the blob's snapshots and not the blob itself */
    @header("x-ms-delete-snapshots")
    deleteSnapshots?: DeleteSnapshotsOptionType;

    ...IfModifiedSinceParameter;
    ...IfUnmodifiedSinceParameter;
    ...IfNoneMatchParameter;
    ...IfMatchParameter;
    ...IfTagsParameter;

    /** Optional.  Only possible value is 'permanent', which specifies to permanently delete a blob if blob soft delete is enabled. */
    @query
    @clientName("blobDeleteType")
    deletetype?: BlobDeleteType;

    ...AccessTierIfModifiedSinceParameter;
    ...AccessTierIfUnmodifiedSinceParameter;

    /** The container name */
    @path containerName: string;
    /** The blob name */
    @path blob: string;
  },
  {
    @statusCode statusCode: 202;
  }
>;

/** The Set Tier operation sets the tier on a block blob. The operation is allowed on a page blob or block blob, but not on an append blob. A block blob's tier determines Hot/Cool/Archive storage type. This operation does not update the blob's ETag. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@sharedRoute
@route("/{containerName}/{blob}?comp=tier")
@scope("csharp")
op setTierCsharp is StorageOperationNoBody<
  {
    ...SnapshotParameter;
    ...VersionIdParameter;
    ...TimeoutParameter;

    /** Indicates the tier to be set on the blob. */
    @header("x-ms-access-tier")
    tier: AccessTier;

    ...RehydratePriorityHeader;
    ...LeaseIdOptionalParameter;
    ...IfTagsParameter;
        /** The container name */
    @path containerName: string;
        /** The blob name */
    @path blob: string;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard pattern"
    @statusCode statusCode: 200 | 202;
  }
>;

@@clientName(BlobBatchClient.BatchServiceClient, "ServiceRestClient", "csharp");
@@clientName(BlobBatchClient.BatchContainerClient, "ContainerRestClient", "csharp");
@@clientName(BlobBatchClient.BatchBlobClient, "BlobRestClient", "csharp");
@@clientName(AccessTier, "BatchAccessTier", "csharp");
@@clientName(RehydratePriority, "BatchRehydratePriority", "csharp");

@@access(DeleteSnapshotsOptionType, Access.`internal`, "csharp");
