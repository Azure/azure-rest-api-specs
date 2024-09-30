import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.tsp";

namespace Azure.Storage.Blob;

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ClientGenerator.Core;

@route("/?restype=service&comp=properties")
interface BlobServiceProperties {
  /** Get the properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("Service_SetProperties")
  setServiceProperties(
    /** The storage service properties that specifies the analytics and CORS rules to set on the Blob service. */
    @body body: StorageServiceProperties,

    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 202;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;

  /** Retrieves properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @operationId("Service_GetProperties")
  @get
  getServiceProperties(
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: StorageServiceProperties;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/?restype=service&comp=stats")
interface BlobServiceStatistics {
  /** Retrieves statistics related to replication for the Blob service. It is only available on the secondary location endpoint when read-access geo-redundant replication is enabled for the storage account. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @operationId("Service_GetStatistics")
  @get
  getStatistics(
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: StorageServiceStats;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/?comp=list")
interface BlobServiceListContainerSegments {
  /** The List Containers Segment operation returns a list of the containers under the specified account */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("Service_ListContainersSegment")
  getContainers(
    ...PrefixParameter,
    ...TimeoutParameter,
    ...MarkerParameter,
    ...MaxResultsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: ListContainersSegmentResponse;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/?restype=service&comp=userdelegationkey")
interface BlobServiceUserDelegationKey {
  /** The Get User Delegation Key operation gets the user delegation key for the Blob service. This is only a valid operation when using User Delegation SAS. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas\">Create a user delegation SAS</a>. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @post
  @operationId("Service_GetUserDelegationKey")
  getUserDelegationKey(
    /** The user delegation key info. */
    @body body: KeyInfo,

    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;

    /** The user delegation key. */
    @body body: UserDelegationKey;

    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/?restype=account&comp=properties")
interface BlobServiceAccountProperties {
  /** Returns the sku name and account kind. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @operationId("Service_GetAccountInfo")
  getAccountInfo(...ApiVersionParameter): {
    @statusCode statusCode: 200;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...SkuNameResponseHeader;
    ...AccountKindResponseHeader;
    ...IsHierarchicalNamespaceEnabledResponseHeader;
  } | StorageError;
}

@route("/?comp=batch")
interface BlobServiceBatch {
  /** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @operationId("Service_SubmitBatch")
  submitBatch(
    ...ContentLengthParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/?comp=blobs")
interface FilterBlobsService {
  /** The Filter Blobs operation enables callers to list blobs across all containers whose tags match a given search expression. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("Service_FilterBlobs")
  getBlobs(
    ...FilterBlobsWhereParameter,
    ...FilterBlobsIncludeParameter,
    ...TimeoutParameter,
    ...MarkerParameter,
    ...MaxResultsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: FilterBlobSegment;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container")
interface BlobServiceContainer {
  /** Creates a new container under the specified account. If the container with the same name already exists, the operation fails. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("Container_Create")
  createContainer(
    ...ContainerNameParameter,

    // TODO: x-ms-meta headers
    ...BlobPublicAccessParameter,

    ...DefaultEncryptionScopeParameter,
    ...DenyEncryptionScopeOverrideParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;

  /** returns all user-defined metadata and system properties for the specified container. The data returned does not include the container's list of blobs */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @operationId("Container_GetProperties")
  getContainerProperties(
    ...ContainerNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseIdOptionalParameter,
  ): {
    @statusCode statusCode: 200;

    // TODO: x-ms-meta headers
    ...EtagResponseHeader;

    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...LeaseDurationResponseHeader;
    ...LeaseStateResponseHeader;
    ...LeaseStatusResponseHeader;
    ...PublicAccessResponseHeader;
    ...HasImmutabilityPolicyResponseHeader;
    ...HasLegalHoldResponseHeader;
    ...DefaultEncryptionScopeResponseHeader;
    ...DenyEncryptionScopeOverrideResponseHeader;
    ...IsImmutableStorageWithVersioningEnabledResponseHeader;
  } | StorageError;

  /** operation marks the specified container for deletion. The container and any blobs contained within it are later deleted during garbage collection */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @delete
  @operationId("Container_Delete")
  deleteContainer(
    ...ContainerNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseIdOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
  ): {
    @statusCode statusCode: 202;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=metadata")
interface BlobServiceContainerMetadata {
  /** operation sets one or more user-defined name-value pairs for the specified container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Container_SetMetadata")
  setContainerMetadata(
    ...ContainerNameParameter,

    // TODO: ...MetadataParameter;
    ...TimeoutParameter,

    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...IfModifiedSinceParameter,
    ...LeaseIdOptionalParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=acl")
interface BlobServiceContainerAccessPolicy {
  /** gets the permissions for the specified container. The permissions indicate whether container data may be accessed publicly. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("Container_GetAccessPolicy")
  getContainerccessPolicy(
    ...ContainerNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseIdOptionalParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: SignedIdentifiers;
    ...PublicAccessResponseHeader;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;

  /** sets the permissions for the specified container. The permissions indicate whether blobs in a container may be accessed publicly. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Container_SetAccessPolicy")
  setContainerAccessPolicy(
    ...ContainerNameParameter,
    ...ContainerAclParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...LeaseIdOptionalParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=undelete")
interface ContainerRestoreService {
  /** Restores a previously-deleted container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Container_Undelete")
  undeleteContainer(
    ...ContainerNameParameter,
    ...DeletedContainerNameParameter,
    ...DeletedContainerVersionParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 201;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=rename")
interface ContainerRenameService {
  /** Renames an existing container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Container_Rename")
  renameContainer(
    ...ContainerNameParameter,
    ...SourceContainerNameParameter,
    ...SourceLeaseIdParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=batch")
interface ContainerBatchService {
  /** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @operationId("Container_SubmitBatch")
  submitBatch(
    /** The batch request content */
    ...BodyParameter,

    ...ContainerNameParameter,
    ...ContentLengthParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 202;
    @body body: bytes;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=blobs")
interface BlobListService {
  /** The Filter Blobs operation enables callers to list blobs in a container whose tags match a given search expression.  Filter blobs searches within the given container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("Container_FilterBlobs")
  getBlobs(
    ...ContainerNameParameter,
    ...MarkerParameter,
    ...MaxResultsParameter,
    ...FilterBlobsWhereParameter,
    ...FilterBlobsIncludeParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: FilterBlobSegment;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?comp=lease&restype=container&acquire")
interface ContainerLeaseService {
  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Container_AcquireLease")
  acquireLease(
    ...ContainerNameParameter,
    ...LeaseDurationParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...ProposedLeaseIdOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
  ): {
    @statusCode statusCode: 201;
    ...LeaseIdResponseHeader;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?comp=lease&restype=container&release")
interface ContainerReleaseLeaseService {
  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Container_ReleaseLease")
  releaseLease(
    ...ContainerNameParameter,
    ...LeaseIdRequiredParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?comp=lease&restype=container&renew")
interface ContainerRenewLeaseService {
  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Container_RenewLease")
  renewLease(
    ...ContainerNameParameter,
    ...LeaseIdRequiredParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
  ): {
    @statusCode statusCode: 200;
    ...LeaseIdResponseHeader;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?comp=lease&restype=container&break")
interface ConatinerBreakLeaseService {
  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("Container_BreakLease")
  breakLease(
    ...ContainerNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...LeaseBreakPeriodParameter,
  ): {
    @statusCode statusCode: 202;
    ...LeaseTimeResponseHeader;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...LeaseIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?comp=lease&restype=container&change")
interface ContainerChangeLeaseService {
  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Container_ChangeLease")
  changeLease(
    ...ContainerNameParameter,
    ...LeaseIdRequiredParameter,
    ...ProposedLeaseIdRequiredParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
  ): {
    @statusCode statusCode: 200;
    ...LeaseIdResponseHeader;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...LeaseTimeResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=list&flat")
interface ContainerListBlobsService {
  /** [Update] The List Blobs operation returns a list of the blobs under the specified container */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("Container_ListBlobFlatSegment")
  getBlobs(
    ...ContainerNameParameter,
    ...PrefixParameter,
    ...MarkerParameter,
    ...MaxResultsParameter,
    ...ListBlobsIncludeParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: ListBlobsFlatSegmentResponse;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=list&hierarchy")
interface ContainerListBlobsHierarchyService {
  /** [Update] The List Blobs operation returns a list of the blobs under the specified container */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("Container_ListBlobHierarchySegment")
  getBlobs(
    ...ContainerNameParameter,
    ...DelimiterParameter,
    ...PrefixParameter,
    ...MarkerParameter,
    ...MaxResultsParameter,
    ...ListBlobsIncludeParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: ListBlobsHierarchySegmentResponse;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=account&comp=properties")
interface ContainerAccountInfoService {
  /** Returns the sku name and account kind */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @operationId("Container_GetAccountInfo")
  getAccountInfo(...ContainerNameParameter, ...ApiVersionParameter): {
    @statusCode statusCode: 200;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...SkuNameResponseHeader;
    ...AccountKindResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}")
interface BlobService {
  /** The Download operation reads or downloads a blob from the system, including its metadata and properties. You can also call Download to read a snapshot. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @operationId("Blob_Download")
  downloadBlob(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...SnapshotParameter,
    ...VersionIdParameter,
    ...TimeoutParameter,
    ...RangeParameter,
    ...LeaseIdOptionalParameter,
    ...GetRangeContentMd5Parameter,
    ...GetRangeContentCrc64Parameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...ClientRequestIdParameter,
    ...ApiVersionParameter,
  ): {
    @statusCode statusCode: 200 | 206;
    ...BodyParameter;

    // TODO: x-ms-meta headers
    // TODO: x-ms-or headers
    ...LastModifiedResponseHeader;

    ...CreationTimeResponseHeader;
    ...ObjectReplicationPolicyIdResponseHeader;
    ...ContentRangeResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentEncodingResponseParameter;
    ...CacheControlResponseHeader;
    ...ContentDispositionResponseHeader;
    ...ContentLanguageResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...BlobTypeResponseHeader;
    ...CopyCompletionTimeResponseHeader;
    ...CopyStatusDescriptionResponseHeader;
    ...CopyIdResponseHeader;
    ...CopyProgressResponseHeader;
    ...CopyStatusResponseHeader;
    ...CopySourceResponseHeader;
    ...LeaseDurationResponseHeader;
    ...LeaseStateResponseHeader;
    ...LeaseStatusResponseHeader;
    ...VersionResponseHeader;
    ...VersionIdResponseHeader;
    ...IsCurrentVersionResponseHeader;
    ...AcceptRangesResponseHeader;
    ...BlobCommittedBlockCountResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    ...TagCountResponseHeader;
    ...IsSealedResponseHeader;
    ...LastAccessedResponseHeader;
    ...ImmutabilityPolicyExpiresOnResponseHeader;
    ...ImmutabilityPolicyModeResponseHeader;
    ...LegalHoldResponseHeader;
    ...ContentLengthResponseHeader;
    ...EtagResponseHeader;
  } | StorageError;

  /** The Get Properties operation returns all user-defined metadata, standard HTTP properties, and system properties for the blob. It does not return the content of the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @head
  @operationId("Blob_GetProperties")
  getBlobProperties(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...SnapshotParameter,
    ...VersionIdParameter,
    ...LeaseIdOptionalParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ClientRequestIdParameter,
    ...ApiVersionParameter,
  ): {
    @statusCode statusCode: 200;

    // TODO: x-ms-meta headers
    // TODO: x-ms-or headers

    ...LastModifiedResponseHeader;

    ...CreationTimeResponseHeader;
    ...ObjectReplicationPolicyIdResponseHeader;
    ...BlobTypeResponseHeader;
    ...CopyCompletionTimeResponseHeader;
    ...CopyStatusDescriptionResponseHeader;
    ...CopyIdResponseHeader;
    ...CopyProgressResponseHeader;
    ...CopyStatusResponseHeader;
    ...CopySourceResponseHeader;
    ...IsIncrementalCopyResponseHeader;
    ...DestinationSnapshotResponseHeader;
    ...LeaseDurationResponseHeader;
    ...LeaseStateResponseHeader;
    ...LeaseStatusResponseHeader;
    ...ContentLengthResponseHeader;
    ...EtagResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentEncodingResponseParameter;
    ...CacheControlResponseHeader;
    ...ContentDispositionResponseHeader;
    ...ContentLanguageResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...AcceptRangesResponseHeader;
    ...BlobCommittedBlockCountResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    ...AccessTierResponseHeader;
    ...AccessTierInferredResponseHeader;
    ...ArchiveStatusResponseHeader;
    ...AccessTierChangeTimeResponseHeader;
    ...VersionIdResponseHeader;
    ...IsCurrentVersionResponseHeader;
    ...TagCountResponseHeader;
    ...ExpiresOnResponseHeader;
    ...IsSealedResponseHeader;
    ...RehydratePriorityResponseHeader;
    ...LastAccessedResponseHeader;
    ...ImmutabilityPolicyExpiresOnResponseHeader;
    ...ImmutabilityPolicyModeResponseHeader;
    ...LegalHoldResponseHeader;
  } | StorageError;

  /** If the storage account's soft delete feature is disabled then, when a blob is deleted, it is permanently removed from the storage account. If the storage account's soft delete feature is enabled, then, when a blob is deleted, it is marked for deletion and becomes inaccessible immediately. However, the blob service retains the blob or snapshot for the number of days specified by the DeleteRetentionPolicy section of [Storage service properties] (Set-Blob-Service-Properties.md). After the specified number of days has passed, the blob's data is permanently removed from the storage account. Note that you continue to be charged for the soft-deleted blob's storage until it is permanently removed. Use the List Blobs API and specify the \"include=deleted\" query parameter to discover which blobs and snapshots have been soft deleted. You can then use the Undelete Blob API to restore a soft-deleted blob. All other operations on a soft-deleted blob or snapshot causes the service to return an HTTP status code of 404 (ResourceNotFound). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @delete
  @operationId("Blob_Delete")
  deleteBlob(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...SnapshotParameter,
    ...VersionIdParameter,
    ...TimeoutParameter,
    ...LeaseIdOptionalParameter,
    ...DeleteSnapshotsParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...BlobDeleteTypeParameter,
  ): {
    @statusCode statusCode: 202;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?PageBlob")
interface PageBlobService {
  /** The Create operation creates a new page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("PageBlob_Create")
  createPageBlob(
    // TODO: Metadata
    ...ContainerNameParameter,

    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ContentLengthParameter,
    ...PremiumPageBlobAccessTierOptional,
    ...BlobContentTypeParameter,
    ...BlobContentEncodingParameter,
    ...BlobContentLanguageParameter,
    ...BlobContentMd5Parameter,
    ...BlobCacheControlParameter,
    ...LeaseIdOptionalParameter,
    ...BlobContentDispositionParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...BlobContentLengthRequiredParameter,
    ...BlobSequenceNumberParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...BlobTagsHeaderParameter,
    ...ImmutabilityPolicyExpiryParameter,
    ...LegalHoldOptionalParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...VersionIdResponseHeader;
    ...DateResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?AppendBlob")
interface AppendBlobService {
  /** The Create operation creates a new append blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("AppendBlob_Create")
  createAppendBlob(
    // TODO: Metadata
    ...ContainerNameParameter,

    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ContentLengthParameter,
    ...BlobContentTypeParameter,
    ...BlobContentEncodingParameter,
    ...BlobContentLanguageParameter,
    ...BlobContentMd5Parameter,
    ...BlobCacheControlParameter,
    ...LeaseIdOptionalParameter,
    ...BlobContentDispositionParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...BlobTagsHeaderParameter,
    ...ImmutabilityPolicyExpiryParameter,
    ...ImmutabilityPolicyModeParameter,
    ...LegalHoldOptionalParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...VersionIdResponseHeader;
    ...DateResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?BlockBlob")
interface BlockBlobService {
  /** The Upload Block Blob operation updates the content of an existing block blob. Updating an existing block blob overwrites any existing metadata on the blob. Partial updates are not supported with Put Blob; the content of the existing blob is overwritten with the content of the new blob. To perform a partial update of the content of a block blob, use the Put Block List operation. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("BlockBlob_Upload")
  uploadBlockBlob(
    // TODO: Metadata

    ...ContainerNameParameter,

    ...BlobNameParameter,
    ...BodyParameter,
    ...TimeoutParameter,
    ...ContentMd5Parameter,
    ...BlobContentTypeParameter,
    ...BlobContentEncodingParameter,
    ...BlobContentLanguageParameter,
    ...BlobContentMd5Parameter,
    ...BlobCacheControlParameter,
    ...LeaseIdOptionalParameter,
    ...BlobContentDispositionParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...AccessTierOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...BlobTagsHeaderParameter,
    ...ImmutabilityPolicyExpiryParameter,
    ...ImmutabilityPolicyModeParameter,
    ...LegalHoldOptionalParameter,
    ...ContentCrc64Parameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...VersionIdResponseHeader;
    ...DateResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?BlockBlob&fromUrl")
interface BlockBlobFromUrlService {
  /** The Put Blob from URL operation creates a new Block Blob where the contents of the blob are read from a given URL.  This API is supported beginning with the 2020-04-08 version. Partial updates are not supported with Put Blob from URL; the content of an existing blob is overwritten with the content of the new blob.  To perform partial updates to a block blob’s contents using a source URL, use the Put Block from URL API in conjunction with Put Block List. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("BlockBlob_PutBlobFromUrl")
  putBlockBlobFromUrl(
    // TODO: Metadata

    ...ContainerNameParameter,

    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ContentMd5Parameter,
    ...ContentLengthParameter,
    ...BlobContentTypeParameter,
    ...BlobContentEncodingParameter,
    ...BlobContentLanguageParameter,
    ...BlobContentMd5Parameter,
    ...BlobCacheControlParameter,
    ...LeaseIdOptionalParameter,
    ...BlobContentDispositionParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...AccessTierOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...SourceIfModifiedSinceParameter,
    ...SourceIfMatchParameter,
    ...SourceIfNoneMatchParameter,
    ...SourceIfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...SourceContentMd5Parameter,
    ...BlobTagsHeaderParameter,
    ...CopySourceParameter,
    ...CopySourceBlobPropertiesParameter,
    ...CopySourceAuthorizationParameter,
    ...CopySourceTagsParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=undelete")
interface BlobUndeleteService {
  /** "Undelete a blob that was previously soft deleted" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @operationId("Blob_Undelete")
  undeleteBlob(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=expiry")
interface BlobExpirationService {
  /** "Set the expiration time of a blob" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @operationId("Blob_SetExpiry")
  setBlobExpiry(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...BlobExpiryOptionsParameter,
    ...BlobExpiryTimeParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=properties&SetHTTPHeaders")
interface BlobSetHttpHeadersService {
  /** The Set HTTP Headers operation sets system properties on the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_SetHTTPHeaders")
  setHttpHeaders(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...BlobCacheControlParameter,
    ...BlobContentTypeParameter,
    ...BlobContentMd5Parameter,
    ...BlobContentEncodingParameter,
    ...BlobContentLanguageParameter,
    ...LeaseIdOptionalParameter,
    ...BlobContentDispositionParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=immutabilityPolicies")
interface BlobSetImmutabilityPolicyService {
  /** "Set the immutability policy of a blob" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_SetImmutabilityPolicy")
  setImmutabilityPolicy(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...IfUnmodifiedSinceParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...ImmutabilityPolicyExpiryParameter,
    ...ImmutabilityPolicyModeParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...ImmutabilityPolicyExpiryResponseHeader;
    ...ImmutabilityPolicyModeResponseHeader;
  } | StorageError;

  /** The Delete Immutability Policy operation deletes the immutability policy on the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @delete
  @operationId("Blob_DeleteImmutabilityPolicy")
  deleteImmutabilityPolicy(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=legalhold")
interface BlobLegalHoldService {
  /** The Set Legal Hold operation sets a legal hold on the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_SetLegalHold")
  setLegalHold(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LegalHoldRequiredParameter,
  ): {
    @statusCode statusCode: 200;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...LegalHoldResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=metadata")
interface BlobSetMetadataService {
  /** The Set Metadata operation sets user-defined metadata for the specified blob as one or more name-value pairs. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_SetMetadata")
  setMetadata(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,

    // TODO: Metadata ...MetadataParameter;
    ...LeaseIdOptionalParameter,

    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=lease&acquire")
interface BlobLeaseAcquireService {
  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_AcquireLease")
  acquireLease(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseDurationParameter,
    ...ProposedLeaseIdOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...LeaseIdResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=lease&release")
interface BlobLeaseReleaseService {
  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_ReleaseLease")
  releaseLease(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseIdRequiredParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=lease&renew")
interface BlobLeaseRenewService {
  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_RenewLease")
  renewLease(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseIdRequiredParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...LeaseIdResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=lease&change")
interface BlobLeaseChangeService {
  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_ChangeLease")
  changeLease(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseIdRequiredParameter,
    ...ProposedLeaseIdOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...LeaseIdResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=lease&break")
interface BlobLeaseBreakService {
  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("Blob_BreakLease")
  breakLease(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseBreakPeriodParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 202;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...LeaseTimeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=snapshot")
interface BlobSnapshotService {
  /** The Create Snapshot operation creates a read-only snapshot of a blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("Blob_CreateSnapshot")
  createSnapshot(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,

    // TODO: ...MetadataParameter;
    ...LeaseIdOptionalParameter,

    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...SnapshotResponseHeader;
    ...DateResponseHeader;
    ...IsServerEncryptedResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=copy")
interface BlobCopyService {
  /** The Start Copy From URL operation copies a blob or an internet resource to a new blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("Blob_StartCopyFromURL")
  startCopyFromUrl(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,

    // TODO: ...MetadataParameter;
    ...AccessTierOptionalParameter,

    ...RehydratePriorityParameter,
    ...SourceIfModifiedSinceParameter,
    ...SourceIfUnmodifiedSinceParameter,
    ...SourceIfMatchParameter,
    ...SourceIfNoneMatchParameter,
    ...SourceIfTagsParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...CopySourceParameter,
    ...LeaseIdOptionalParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...BlobTagsHeaderParameter,
    ...SealBlobParameter,
    ...ImmutabilityPolicyExpiryParameter,
    ...ImmutabilityPolicyModeParameter,
    ...LegalHoldOptionalParameter,
  ): {
    @statusCode statusCode: 202;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...VersionIdResponseHeader;
    ...DateResponseHeader;
    ...CopyIdResponseHeader;
    ...CopyStatusResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=copy&sync")
interface BlobCopySyncService {
  /** The Copy From URL operation copies a blob or an internet resource to a new blob. It will not return a response until the copy is complete. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("Blob_AbortCopyFromURL")
  copyFromUrl(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,

    // TODO: ...MetadataParameter;
    ...AccessTierOptionalParameter,

    ...SourceIfModifiedSinceParameter,
    ...SourceIfUnmodifiedSinceParameter,
    ...SourceIfMatchParameter,
    ...SourceIfNoneMatchParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...CopySourceParameter,
    ...LeaseIdOptionalParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...SourceContentMd5Parameter,
    ...BlobTagsHeaderParameter,
    ...ImmutabilityPolicyExpiryParameter,
    ...ImmutabilityPolicyModeParameter,
    ...LegalHoldOptionalParameter,
    ...CopySourceAuthorizationParameter,
    ...EncryptionScopeParameter,
    ...CopySourceTagsParameter,
  ): {
    @statusCode statusCode: 202;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...CopyIdResponseHeader;
    ...CopyStatusResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=copy&copyid")
interface BlobCopyAbortService {
  /** The Abort Copy From URL operation aborts a pending Copy From URL operation, and leaves a destination blob with zero length and full metadata. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @put
  @operationId("Blob_AbortCopyFromURL")
  abortCopyFromUrl(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...CopyIdParameter,
    ...LeaseIdOptionalParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 204;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=tier")
interface BlobTierService {
  /** The Set Tier operation sets the tier on a block blob. The operation is allowed on a page blob or block blob, but not on an append blob. A block blob's tier determines Hot/Cool/Archive storage type. This operation does not update the blob's ETag. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("Blob_SetTier")
  setTier(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...AccessTierRequiredParameter,
    ...RehydratePriorityParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...LeaseIdOptionalParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 200;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | {
    @statusCode statusCode: 202;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?restype=account&comp=properties")
interface BlobAccountPropertiesService {
  /** Returns the sku name and account kind */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @operationId("Blob_GetAccountInfo")
  getAccountInfo(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...AccountKindResponseHeader;
    ...SkuNameResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=block")
interface BlobBlockStageService {
  /** The Stage Block operation creates a new block to be committed as part of a blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("BlockBlob_StageBlock")
  stageBlock(
    ...BodyParameter,
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...BlockIdParameter,
    ...ContentLengthParameter,
    ...ContentMd5Parameter,
    ...TimeoutParameter,
    ...ContentCrc64Parameter,
    ...LeaseIdOptionalParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 201;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=block&fromURL")
interface BlobBlockStageFromUrlService {
  /** The Stage Block From URL operation creates a new block to be committed as part of a blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("BlockBlob_StageBlockFromURL")
  stageBlockFromUrl(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...BlockIdParameter,
    ...ContentLengthParameter,
    ...SourceUrlParameter,
    ...SourceRangeParameter,
    ...SourceContentMd5Parameter,
    ...SourceContentCrc64Parameter,
    ...TimeoutParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...LeaseIdOptionalParameter,
    ...SourceIfModifiedSinceParameter,
    ...SourceIfUnmodifiedSinceParameter,
    ...SourceIfMatchParameter,
    ...SourceIfNoneMatchParameter,
    ...CopySourceAuthorizationParameter,
  ): {
    @statusCode statusCode: 201;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=blocklist")
interface BlobBlockListService {
  /** The Commit Block List operation writes a blob by specifying the list of block IDs that make up the blob. In order to be written as part of a blob, a block must have been successfully written to the server in a prior Put Block operation. You can call Put Block List to update a blob by uploading only those blocks that have changed, then committing the new and existing blocks together. You can do this by specifying whether to commit a block from the committed block list or from the uncommitted block list, or to commit the most recently uploaded version of the block, whichever list it may belong to. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("BlockBlob_CommitBlockList")
  commitBlockList(
    ...BlobBlocksParameter,
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...BlobCacheControlParameter,
    ...BlobContentTypeParameter,
    ...BlobContentEncodingParameter,
    ...BlobContentLanguageParameter,
    ...BlobContentMd5Parameter,
    ...ContentMd5Parameter,
    ...ContentCrc64Parameter,

    // TODO: ...MetadataParameter;
    ...BlobContentDispositionParameter,

    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...AccessTierOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...BlobTagsHeaderParameter,
    ...ImmutabilityPolicyExpiryParameter,
    ...ImmutabilityPolicyModeParameter,
    ...LegalHoldOptionalParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;

  /** The Get Block List operation retrieves the list of blocks that have been uploaded as part of a block blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("BlockBlob_GetBlockList")
  getBlockList(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...SnapshotParameter,
    ...BlockListTypeParameter,
    ...LeaseIdOptionalParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: BlockLookupList;
    ...LastModifiedResponseHeader;
    ...EtagResponseHeader;
    ...BlobContentLengthResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=page&update")
interface PageBlobUpdateService {
  /** The Upload Pages operation writes a range of pages to a page blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("PageBlob_UploadPages")
  uploadPages(
    /** The data to upload. */
    ...BodyParameter,

    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ContentLengthParameter,
    ...ContentMd5Parameter,
    ...ContentCrc64Parameter,
    ...TimeoutParameter,
    ...RangeParameter,
    ...LeaseIdOptionalParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...IfSequenceNumberLessThanOrEqualToParameter,
    ...IfSequenceNumberLessThanParameter,
    ...IfSequenceNumberEqualToParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=page&clear")
interface PageBlobClearService {
  /** The Clear Pages operation clears a range of pages from a page blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("PageBlob_ClearPages")
  clearPages(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ContentLengthParameter,
    ...TimeoutParameter,
    ...RangeParameter,
    ...LeaseIdOptionalParameter,
    ...IfSequenceNumberLessThanOrEqualToParameter,
    ...IfSequenceNumberLessThanParameter,
    ...IfSequenceNumberEqualToParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=page&update&fromUrl")
interface BlobPageUpdateFromUrlService {
  /** The Upload Pages operation writes a range of pages to a page blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("PageBlob_UploadPagesFromURL")
  uploadPagesFromUrl(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ContentLengthParameter,
    ...SourceUrlParameter,
    ...SourceRangeRequiredPutPageFromUrlParameter,
    ...SourceContentMd5Parameter,
    ...SourceContentCrc64Parameter,
    ...RangeRequiredPutPageFromUrlParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...LeaseIdOptionalParameter,
    ...IfSequenceNumberLessThanOrEqualToParameter,
    ...IfSequenceNumberLessThanParameter,
    ...IfSequenceNumberEqualToParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...SourceIfModifiedSinceParameter,
    ...SourceIfUnmodifiedSinceParameter,
    ...SourceIfMatchParameter,
    ...SourceIfNoneMatchParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...CopySourceAuthorizationParameter,
  ): {
    @statusCode statusCode: 202;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=pagelist")
interface PageBlobListService {
  /** The Get Page Ranges operation returns the list of valid page ranges for a page blob or snapshot of a page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("PageBlob_GetPageRanges")
  getPageRanges(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...SnapshotParameter,
    ...RangeParameter,
    ...LeaseIdOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...MarkerParameter,
    ...MaxResultsParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: PageList;
    ...LastModifiedResponseHeader;
    ...EtagResponseHeader;
    ...BlobContentLengthResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=pagelist&diff")
interface PageBlobDiffService {
  /** The Get Page Ranges Diff operation returns the list of valid page ranges for a page blob or snapshot of a page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("PageBlob_GetPageRangesDiff")
  getPageRangesDiff(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...SnapshotParameter,
    ...TimeoutParameter,
    ...PrevSnapshotParameter,
    ...PrevSnapshotUrlParameter,
    ...RangeParameter,
    ...LeaseIdOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...MarkerParameter,
    ...MaxResultsParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: PageList;
    ...LastModifiedResponseHeader;
    ...EtagResponseHeader;
    ...BlobContentLengthResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=properties&Resize")
interface PageBlobResizeService {
  /** The Resize operation increases the size of the page blob to the specified size. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("PageBlob_Resize")
  resize(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...LeaseIdOptionalParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...BlobContentLengthRequiredParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=properties&UpdateSequenceNumber")
interface PageBlobUpdateSequenceNumberService {
  /** The Update Sequence Number operation sets the blob's sequence number. The operation will fail if the specified sequence number is less than the current sequence number of the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("PageBlob_UpdateSequenceNumber")
  updateSequenceNumber(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...LeaseIdOptionalParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...SequenceNumberActionParameter,
    ...SequenceNumberParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=incrementalcopy")
interface PageBlobIncrementalCopyService {
  /** The Copy Incremental operation copies a snapshot of the source page blob to a destination page blob. The snapshot is copied such that only the differential changes between the previously copied snapshot are transferred to the destination. The copied snapshots are complete copies of the original snapshot and can be read or copied from as usual. This API is supported since REST version 2016-05-31. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @operationId("PageBlob_CopyIncremental")
  incrementalCopy(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...LeaseIdOptionalParameter,
    ...CopySourceParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 202;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...CopyIdResponseHeader;
    ...CopyStatusResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=appendblock")
interface AppendBlobAppendBlockService {
  /** The Append Block operation commits a new block of data to the end of an append blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("AppendBlob_AppendBlock")
  appendBlock(
    /** The data to upload. */
    ...BodyParameter,

    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ContentLengthParameter,
    ...ContentMd5Parameter,
    ...ContentCrc64Parameter,
    ...LeaseIdOptionalParameter,
    ...BlobConditionMaxSizeParameter,
    ...BlobConditionAppendPosParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...BlobAppendOffsetResponseHeader;
    ...BlobCommittedBlockCountResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=appendblock&fromUrl")
interface AppendBlockAppendBlockFromUrlService {
  /** The Append Block From URL operation creates a new block to be committed as part of an append blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("AppendBlob_AppendBlockFromURL")
  appendBlockFromUrl(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ContentLengthParameter,
    ...SourceUrlParameter,
    ...SourceRangeParameter,
    ...SourceContentMd5Parameter,
    ...SourceContentCrc64Parameter,
    ...LeaseIdOptionalParameter,
    ...BlobConditionMaxSizeParameter,
    ...BlobConditionAppendPosParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...EncryptionScopeParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...CopySourceAuthorizationParameter,
  ): {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...BlobAppendOffsetResponseHeader;
    ...BlobCommittedBlockCountResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=seal")
interface AppendBlobSealService {
  /** The Seal operation seals the Append Blob to make it read-only. Seal is supported only on version 2019-12-12 version or later. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @operationId("AppendBlob_Seal")
  seal(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...LeaseIdOptionalParameter,
    ...BlobConditionAppendPosParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...IsSealedResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=query")
interface BlobQueryService {
  /** The Query operation enables users to select/project on blob data by providing simple query expressions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @post
  @operationId("Blob_Query")
  query(
    ...QueryRequestParameter,
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...SnapshotParameter,
    ...TimeoutParameter,
    ...LeaseIdOptionalParameter,
    ...EncryptionKeyParameter,
    ...EncryptionKeySha256Parameter,
    ...EncryptionAlgorithmParameter,
    ...IfModifiedSinceParameter,
    ...IfUnmodifiedSinceParameter,
    ...IfMatchParameter,
    ...IfNoneMatchParameter,
    ...IfTagsParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
  ): {
    @statusCode statusCode: 200 | 206;
    ...BodyParameter;

    // TODO: MetadataResponseHeader;

    ...LastModifiedResponseHeader;

    ...ContentLengthResponseHeader;
    ...ContentRangeResponseHeader;
    ...EtagResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentEncodingResponseParameter;
    ...CacheControlResponseHeader;
    ...ContentLanguageResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...BlobTypeResponseHeader;
    ...CopyCompletionTimeResponseHeader;
    ...CopyStatusDescriptionResponseHeader;
    ...CopyIdResponseHeader;
    ...CopyProgressResponseHeader;
    ...CopySourceResponseHeader;
    ...CopyStatusResponseHeader;
    ...LeaseDurationResponseHeader;
    ...LeaseStateResponseHeader;
    ...LeaseStatusResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...AcceptRangesResponseHeader;
    ...BlobCommittedBlockCountResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    ...BlobContentMd5ResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=tags")
interface BlobTagsService {
  /** The Get Blob Tags operation enables users to get tags on a blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @operationId("Blob_GetTags")
  getTags(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...SnapshotParameter,
    ...VersionIdParameter,
    ...LeaseIdOptionalParameter,
    ...IfTagsParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: BlobTags;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;

  /** The Set Tags operation enables users to set tags on a blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @put
  @operationId("Blob_SetTags")
  setTags(
    ...ContainerNameParameter,
    ...BlobNameParameter,
    ...TimeoutParameter,
    ...ApiVersionParameter,
    ...ClientRequestIdParameter,
    ...VersionIdParameter,
    ...LeaseIdOptionalParameter,
    ...ContentMd5Parameter,
    ...ContentCrc64Parameter,
    ...IfTagsParameter,
    ...BlobTagsBodyParameter,
  ): {
    @statusCode statusCode: 204;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}
