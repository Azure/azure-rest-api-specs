import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";

import "./models.tsp";

namespace Microsoft.BlobStorage;

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ClientGenerator.Core;

@route("/?restype=service&comp=properties")
interface BlobServiceProperties {
  /**
  Get the properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
  */
  @put
  @operationId("Service_SetProperties")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setServiceProperties(
    /** The storage service properties that specifies the analytics and CORS rules to set on the Blob service. */
    @body body: StorageServiceProperties;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 202;

    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;

  /** Retrieves properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. */
  @operationId("Service_GetProperties")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getServiceProperties(
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;
    @body body: StorageServiceProperties; // TODO: XML

    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/?restype=service&comp=stats")
interface BlobServiceStatistics {
  /**  Retrieves statistics related to replication for the Blob service. It is only available on the secondary location endpoint when read-access geo-redundant replication is enabled for the storage account. */
  @operationId("Service_GetStatistics")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getStatistics(
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;
    @body body: StorageServiceStats; // TODO: XML
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/?comp=list")
interface BlobServiceListContainerSegments {
  /** The List Containers Segment operation returns a list of the containers under the specified account */
  @get
  @operationId("Service_ListContainersSegment")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  listContainers(
    ...PrefixParameter;
    ...TimeoutParameter;
    ...MarkerParameter;
    ...MaxResultsParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;
    @body body: ListContainersSegmentResponse; // TODO: XML
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/?restype=service&comp=userdelegationkey")
interface BlobServiceUserDelegationKey {
  /** The Get User Delegation Key operation gets the user delegation key for the Blob service. This is only a valid operation when using User Delegation SAS. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas\">Create a user delegation SAS</a>. */
  @post
  @operationId("Service_GetUserDelegationKey") 
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getUserDelegationKey(
    /** The user delegation key info. */
    @body body: KeyInfo;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;
    /** The user delegation key. */
    @body body: UserDelegationKey; // TODO: XML

    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/?restype=account&comp=properties")
interface BlobServiceAccountProperties {
  /** Returns the sku name and account kind. */
  @get
  @operationId("Service_GetAccountInfo")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getAccountInfo(
    ...ApiVersionParameter;
  ): {
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
  @post
  @operationId("Service_SubmitBatch")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  submitBatch(
    /** The batch request content */
    @body body: bytes; // TODO: Investigate this type
    ...ContentLengthHeader;
    ...MultipartContentType;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;

    ...ContentTypeResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/?comp=blobs")
interface FilterBlobsService {
  /** The Filter Blobs operation enables callers to list blobs across all containers whose tags match a given search expression. */
  @get
  @operationId("Service_FilterBlobs")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  listBlobs(
    ...FilterBlobsWhere;
    ...FilterBlobsInclude;
    ...TimeoutParameter;
    ...MarkerParameter;
    ...MaxResultsParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
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
  @put
  @operationId("Container_Create")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  createContainer(
    ...ContainerNameParameter;
    ...MetadataParameter;
    ...BlobPublicAccess;
    ...DefaultEncryptionScope;
    ...DenyEncryptionScopeOverride;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 201;
    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;

  /** returns all user-defined metadata and system properties for the specified container. The data returned does not include the container's list of blobs */
  @get
  @operationId("Container_GetProperties")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getContainerProperties(
    ...ContainerNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseIdOptional;
  ): {
    @statusCode statusCode: 200;
    
    // TODO: x-ms-meta headers
    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    /** When a blob is leased, specifies whether the lease is of infinite or fixed duration. */
    @clientName("LeaseDuration")
    @header `x-ms-lease-duration`: LeaseDuration;
    /** Lease state of the container. */
    @clientName("LeaseState")
    @header `x-ms-lease-state`: LeaseState;
    /** The lease status of the container. */
    @clientName("LeaseStatus")
    @header `x-ms-lease-status`: LeaseStatus;
    /** The public access setting for the container. */
    @header `x-ms-blob-public-access`: PublicAccessType;
    /** Indicates whether the container has an immutability policy set on it. */
    @clientName("HasImmutabilityPolicy")
    @header `x-ms-has-immutability-policy`: boolean;
    /** Indicates whether the container has a legal hold. */
    @clientName("HasLegalHold")
    @header `x-ms-has-legal-hold`: boolean;
    /** The default encryption scope for the container. */
    @clientName("DefaultEncryptionScope")
    @header `x-ms-default-encryption-scope`: string;
    /** Indicates whether the container's default encryption scope can be overriden. */
    @clientName("DenyEncryptionScopeOverride")
    @header `x-ms-deny-encryption-scope-override`: boolean;
    /** Indicates whether version level worm is enabled on a container */
    @clientName("IsImmutableStorageWithVersioningEnabled")
    @header `x-ms-immutable-storage-with-versioning-enabled`: boolean;
  } | StorageError;

  /** operation marks the specified container for deletion. The container and any blobs contained within it are later deleted during garbage collection */
  @delete
  @operationId("Container_Delete")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  deleteContainer(
    ...ContainerNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseIdOptional;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
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
  @put
  @operationId("Container_SetMetadata")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setContainerMetadata(
    ...ContainerNameParameter;
    ...MetadataParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...IfModifiedSince;
    ...LeaseIdOptional;
  ): {
    @statusCode statusCode: 200;
    ...ETagResponseHeader;
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
  @get
  @operationId("Container_GetAccessPolicy")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getContainerccessPolicy(
    ...ContainerNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseIdOptional;
  ): {
    @statusCode statusCode: 200;
    @body body: SignedIdentifiers; // TODO: XML

    /** Indicated whether data in the container may be accessed publicly and the level of access */
    @header `x-ms-blob-public-access`: PublicAccessType;
    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;

  /** sets the permissions for the specified container. The permissions indicate whether blobs in a container may be accessed publicly. */
  @put
  @operationId("Container_SetAccessPolicy")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setContainerAccessPolicy(
    ...ContainerNameParameter;
    ...ContainerAcl;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...LeaseIdOptional;
    /** The signed identifiers. */
    @body body: SignedIdentifiers;
  ): {
    @statusCode statusCode: 200;

    ...ETagResponseHeader;
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
  @put
  @operationId("Container_Undelete")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  undeleteContainer(
    ...ContainerNameParameter;
    ...DeletedContainerName;
    ...DeletedContainerVersion;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
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
  @put
  @operationId("Container_Rename")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  renameContainer(
    ...ContainerNameParameter;
    ...SourceContainerName;
    ...SourceLeaseId;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
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
  @post
  @operationId("Container_SubmitBatch")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  submitBatch(
    /** The batch request content */
    @body body: bytes; // TODO: Investigate this type
    ...ContainerNameParameter;
    ...ContentLengthHeader;
    ...MultipartContentType;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 202;
    ...ContentTypeResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=blobs")
interface BlobListService {
  /** The Filter Blobs operation enables callers to list blobs in a container whose tags match a given search expression.  Filter blobs searches within the given container. */
  @get
  @operationId("Container_FilterBlobs")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  filterBlobs(
    ...ContainerNameParameter;
    ...MarkerParameter;
    ...MaxResultsParameter;
    ...FilterBlobsWhere;
    ...FilterBlobsInclude;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;
    @body body: FilterBlobSegment; // TODO: XML

    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?comp=lease&restype=container&acquire")
interface ContainerLeaseService {
  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  @put
  @operationId("Container_AcquireLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  acquireLease(
    ...ContainerNameParameter;
    ...LeaseDurationParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...ProposedLeaseIdOptional;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
  ): {
    @statusCode statusCode: 201;

    /** The lease ID specified in the request or a generated one if not specified. */
    @header `x-ms-lease-id`: string;
    ...ETagResponseHeader;
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
  @put
  @operationId("Container_ReleaseLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  releaseLease(
    ...ContainerNameParameter;
    ...LeaseIdRequired;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
  ): {
    @statusCode statusCode: 200;

    ...ETagResponseHeader;
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
  @put
  @operationId("Container_RenewLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  renewLease(
    ...ContainerNameParameter;
    ...LeaseIdRequired;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
  ): {
    @statusCode statusCode: 200;
    /** The lease ID specified in the request or a generated one if not specified. */
    @header `x-ms-lease-id`: string;
    ...ETagResponseHeader;
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
  @put
  @operationId("Container_BreakLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  breakLease(
    ...ContainerNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...LeaseBreakPeriod;
  ): {
    @statusCode statusCode: 202;
    /** The lease time remaining on the container. */
    @header `x-ms-lease-time`: int32;
    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    /** The lease ID specified in the request or a generated one if not specified. */
    @header `x-ms-lease-id`: string;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?comp=lease&restype=container&change")
interface ContainerChangeLeaseService {
  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  @put
  @operationId("Container_ChangeLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  changeLease(
    ...ContainerNameParameter;
    ...LeaseIdRequired;
    ...ProposedLeaseIdRequired;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
  ): {
    @statusCode statusCode: 200;
    /** The lease ID specified in the request or a generated one if not specified. */
    @header `x-ms-lease-id`: string;
    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    /** The lease time remaining on the container. */
    @header `x-ms-lease-time`: int64;
    ...ClientRequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=list&flat")
interface ContainerListBlobsService {
  /** [Update] The List Blobs operation returns a list of the blobs under the specified container */
  @get
  @operationId("Container_ListBlobFlatSegment")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  listBlobs(
    ...ContainerNameParameter;
    ...PrefixParameter;
    ...MarkerParameter;
    ...MaxResultsParameter;
    ...ListBlobsInclude;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;
    @body body: ListBlobsFlatSegmentResponse; // TODO: XML
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=container&comp=list&hierarchy")
interface ContainerListBlobsHierarchyService {
  /** [Update] The List Blobs operation returns a list of the blobs under the specified container */
  @get
  @operationId("Container_ListBlobHierarchySegment")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  listBlobs(
    ...ContainerNameParameter;
    ...DelimiterParameter;
    ...PrefixParameter;
    ...MarkerParameter;
    ...MaxResultsParameter;
    ...ListBlobsInclude;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;
    @body body: ListBlobsHierarchySegmentResponse; // TODO: XML

    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
  } | StorageError;
}

@route("/{containerName}?restype=account&comp=properties")
interface ContainerAccountInfoService {
  /** Returns the sku name and account kind  */
  @get
  @operationId("Container_GetAccountInfo")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getAccountInfo(
    ...ApiVersionParameter;
  ): {
    @statusCode statusCode: 200;

    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    /** Identifies the sku name of the account. */
    @clientName("SkuName")
    @header `x-ms-sku-name`: SkuName;
    /** Identifies the account kind. */
    @clientName("AccountKind")
    @header `x-ms-account-kind`: AccountKind;
  } | StorageError;
}

@route("/{containerName}/{blob}")
interface BlobService {
  /** The Download operation reads or downloads a blob from the system, including its metadata and properties. You can also call Download to read a snapshot. */
  @get
  @operationId("Blob_Download")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  downloadBlob(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...SnapshotParameter;
    ...VersionIdParameter;
    ...TimeoutParameter;
    ...RangeParameter;
    ...LeaseIdOptional;
    ...GetRangeContentMD5;
    ...GetRangeContentCRC64;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...ClientRequestIdParameter;
    ...ApiVersionParameter;
  ): {
    @statusCode statusCode: 200;
    @body body: bytes;

    // TODO: x-ms-meta headers
    // TODO: x-ms-or headers
    ...LastModifiedResponseHeader;
    ...CreationTimeResponseHeader;
    /** Optional. Only valid when Object Replication is enabled for the storage container and on the destination blob of the replication. */
    @clientName("ObjectReplicationPolicyId")
    @header `x-ms-or-policy-id`: string;
    ...ContentRangeResponseHeader;
    ...ContentMD5ResponseHeader;
    ...ContentEncodingResponseParameter;
    ...CacheControlResponseHeader;
    ...ContentDispositionResponseHeader;
    ...ContentLanguageResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    /** The type of the blob. */
    @clientName("BlobType")
    @header `x-ms-blob-type`: BlobType;
    /** Conclusion time of the last attempted Copy Blob operation where this blob was the destination blob. This value can specify the time of a completed, aborted, or failed copy attempt. This header does not appear if a copy is pending, if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
    @clientName("CopyCompletionTime")
    @encode("date-time-rfc1123")
    @header `x-ms-copy-completion-time`: utcDateTime;
    /** Only appears when x-ms-copy-status is failed or pending. Describes the cause of the last fatal or non-fatal copy operation failure. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
    @clientName("CopyStatusDescription")
    @header `x-ms-copy-status-description`: string;
    ...CopyIdResponseHeader;
    /** Contains the number of bytes copied and the total bytes in the source in the last attempted Copy Blob operation where this blob was the destination blob. Can show between 0 and Content-Length bytes copied. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
    @clientName("CopyProgress")
    @header `x-ms-copy-progress`: string;
    ...CopyStatusResponseHeader;
    /** URL up to 2 KB in length that specifies the source blob or file used in the last attempted Copy Blob operation where this blob was the destination blob. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
    @clientName("CopySource")
    @header `x-ms-copy-source`: string;
    /** When a blob is leased, specifies whether the lease is of infinite or fixed duration. */
    @clientName("LeaseDuration")
    @header `x-ms-lease-duration`: LeaseDuration;
    /** Lease state of the blob. */
    @clientName("LeaseState")
    @header `x-ms-lease-state`: LeaseState;
    /** The lease status of the blob. */
    @clientName("LeaseStatus")
    @header `x-ms-lease-status`: LeaseStatus;
    ...VersionResponseHeader;
    ...VersionIdResponseHeader;
    /** The value of this header indicates whether version of this blob is a current version, see also x-ms-version-id header. */
    @clientName("IsCurrentVersion")
    @header `x-ms-is-current-version`: boolean;
    /** Indicates that the service supports requests for partial blob content. */
    @header `Accept-Ranges`: string;
    /** The number of committed blocks present in the blob. This header is returned only for append blobs. */
    @clientName("BlobCommittedBlockCount")
    @header `x-ms-blob-committed-block-count`: int32;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    /** The number of tags associated with the blob */
    @clientName("TagCount")
    @header `x-ms-tag-count`: int64;
    /** If this blob has been sealed */
    @clientName("IsSealed")
    @header `x-ms-blob-sealed`: boolean;
    /** UTC date/time value generated by the service that indicates the time at which the blob was last read or written to */
    @clientName("LastAccessed")
    @encode("date-time-rfc1123")
    @header `x-ms-last-access-time`: utcDateTime;
    /** UTC date/time value generated by the service that indicates the time at which the blob immutability policy will expire. */
    @clientName("ImmutabilityPolicyExpiresOn")
    @encode("date-time-rfc1123")
    @header `x-ms-immutability-policy-until-date`: utcDateTime;
    /** Indicates immutability policy mode. */
    @clientName("ImmutabilityPolicyMode")
    @header `x-ms-immutability-policy-mode`: BlobImmutabilityPolicyMode;
    /** Indicates if a legal hold is present on the blob. */
    @clientName("LegalHold")
    @header `x-ms-legal-hold`: boolean;
    ...ContentTypeResponseHeader;
    ...ContentLengthResponseHeader;
    ...ETagResponseHeader;
  } | {
    @statusCode statusCode: 206;
    @body body: bytes;

    // TODO: x-ms-meta headers
    // TODO: x-ms-or headers
    ...LastModifiedResponseHeader;
    ...CreationTimeResponseHeader;
    /** Optional. Only valid when Object Replication is enabled for the storage container and on the destination blob of the replication. */
    @clientName("ObjectReplicationPolicyId")
    @header `x-ms-or-policy-id`: string;
    ...ContentRangeResponseHeader;
    ...ContentMD5ResponseHeader;
    ...ContentEncodingResponseParameter;
    ...CacheControlResponseHeader;
    ...ContentDispositionResponseHeader;
    ...ContentLanguageResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    /** The type of the blob. */
    @clientName("BlobType")
    @header `x-ms-blob-type`: BlobType;
    /** Conclusion time of the last attempted Copy Blob operation where this blob was the destination blob. This value can specify the time of a completed, aborted, or failed copy attempt. This header does not appear if a copy is pending, if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
    @clientName("CopyCompletionTime")
    @encode("date-time-rfc1123")
    @header `x-ms-copy-completion-time`: utcDateTime;
    /** Only appears when x-ms-copy-status is failed or pending. Describes the cause of the last fatal or non-fatal copy operation failure. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
    @clientName("CopyStatusDescription")
    @header `x-ms-copy-status-description`: string;
    ...CopyIdResponseHeader;
    /** Contains the number of bytes copied and the total bytes in the source in the last attempted Copy Blob operation where this blob was the destination blob. Can show between 0 and Content-Length bytes copied. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
    @clientName("CopyProgress")
    @header `x-ms-copy-progress`: string;
    ...CopyStatusResponseHeader;
    /** URL up to 2 KB in length that specifies the source blob or file used in the last attempted Copy Blob operation where this blob was the destination blob. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
    @clientName("CopySource")
    @header `x-ms-copy-source`: string;
    /** When a blob is leased, specifies whether the lease is of infinite or fixed duration. */
    @clientName("LeaseDuration")
    @header `x-ms-lease-duration`: LeaseDuration;
    /** Lease state of the blob. */
    @clientName("LeaseState")
    @header `x-ms-lease-state`: LeaseState;
    /** The lease status of the blob. */
    @clientName("LeaseStatus")
    @header `x-ms-lease-status`: LeaseStatus;
    ...VersionResponseHeader;
    ...VersionIdResponseHeader;
    /** The value of this header indicates whether version of this blob is a current version, see also x-ms-version-id header. */
    @clientName("IsCurrentVersion")
    @header `x-ms-is-current-version`: boolean;
    /** Indicates that the service supports requests for partial blob content. */
    @header `Accept-Ranges`: string;
    /** The number of committed blocks present in the blob. This header is returned only for append blobs. */
    @clientName("BlobCommittedBlockCount")
    @header `x-ms-blob-committed-block-count`: int32;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    /** The number of tags associated with the blob */
    @clientName("TagCount")
    @header `x-ms-tag-count`: int64;
    /** If this blob has been sealed */
    @clientName("IsSealed")
    @header `x-ms-blob-sealed`: boolean;
    /** UTC date/time value generated by the service that indicates the time at which the blob was last read or written to */
    @clientName("LastAccessed")
    @encode("date-time-rfc1123")
    @header `x-ms-last-access-time`: utcDateTime;
    /** UTC date/time value generated by the service that indicates the time at which the blob immutability policy will expire. */
    @clientName("ImmutabilityPolicyExpiresOn")
    @encode("date-time-rfc1123")
    @header `x-ms-immutability-policy-until-date`: utcDateTime;
    /** Indicates immutability policy mode. */
    @clientName("ImmutabilityPolicyMode")
    @header `x-ms-immutability-policy-mode`: BlobImmutabilityPolicyMode;
    /** Indicates if a legal hold is present on the blob. */
    @clientName("LegalHold")
    @header `x-ms-legal-hold`: boolean;
    ...ContentTypeResponseHeader;
    ...ContentLengthResponseHeader;
    ...ETagResponseHeader;
  } | StorageError;

  /** The Get Properties operation returns all user-defined metadata, standard HTTP properties, and system properties for the blob. It does not return the content of the blob. */
  @head
  @operationId("Blob_GetProperties")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getBlobProperties(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...SnapshotParameter;
    ...VersionIdParameter;
    ...LeaseIdOptional;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...ClientRequestIdParameter;
    ...ApiVersionParameter;
  ): {
    @statusCode statusCode: 200;
    // TODO: x-ms-meta headers
    // TODO: x-ms-or headers

    ...LastModifiedResponseHeader;
    ...CreationTimeResponseHeader;
    /** Optional. Only valid when Object Replication is enabled for the storage container and on the destination blob of the replication. */
    @clientName("ObjectReplicationPolicyId")
    @header `x-ms-or-policy-id`: string;
    /** The type of the blob. */
    @clientName("BlobType")
    @header `x-ms-blob-type`: BlobType;
    /** Conclusion time of the last attempted Copy Blob operation where this blob was the destination blob. This value can specify the time of a completed, aborted, or failed copy attempt. This header does not appear if a copy is pending, if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
    @clientName("CopyCompletionTime")
    @encode("date-time-rfc1123")
    @header `x-ms-copy-completion-time`: utcDateTime;
    /** Only appears when x-ms-copy-status is failed or pending. Describes the cause of the last fatal or non-fatal copy operation failure. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
    @clientName("CopyStatusDescription")
    @header `x-ms-copy-status-description`: string;
    ...CopyIdResponseHeader;
    /** Contains the number of bytes copied and the total bytes in the source in the last attempted Copy Blob operation where this blob was the destination blob. Can show between 0 and Content-Length bytes copied. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
    @clientName("CopyProgress")
    @header `x-ms-copy-progress`: string;
    ...CopyStatusResponseHeader;
    /** URL up to 2 KB in length that specifies the source blob or file used in the last attempted Copy Blob operation where this blob was the destination blob. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
    @clientName("CopySource")
    @header `x-ms-copy-source`: string;
    /** Included if the blob is incremental copy blob. */
    @clientName("IsIncrementalCopy")
    @header `x-ms-incremental-copy`: boolean;
    /** Included if the blob is incremental copy blob or incremental copy snapshot, if x-ms-copy-status is success. Snapshot time of the last successful incremental copy snapshot for this blob. */
    @clientName("DestinationSnapshot")
    @header `x-ms-copy-destination-snapshot`: string;
    /** When a blob is leased, specifies whether the lease is of infinite or fixed duration. */
    @clientName("LeaseDuration")
    @header `x-ms-lease-duration`: LeaseDuration;
    /** Lease state of the container. */
    @clientName("LeaseState")
    @header `x-ms-lease-state`: LeaseState;
    /** The lease status of the container. */
    @clientName("LeaseStatus")
    @header `x-ms-lease-status`: LeaseStatus;
    ...ContentTypeResponseHeader;
    ...ContentLengthResponseHeader;
    ...ETagResponseHeader;
    ...ContentMD5ResponseHeader;
    ...ContentEncodingResponseParameter;
    ...CacheControlResponseHeader;
    ...ContentDispositionResponseHeader;
    ...ContentLanguageResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    /** Indicates that the service supports requests for partial blob content. */
    @header `Accept-Ranges`: string;
    /** The number of committed blocks present in the blob. This header is returned only for append blobs. */
    @clientName("BlobCommittedBlockCount")
    @header `x-ms-blob-committed-block-count`: int32;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    /** The tier of page blob on a premium storage account or tier of block blob on blob storage LRS accounts. For a list of allowed premium page blob tiers, see https://docs.microsoft.com/en-us/azure/virtual-machines/windows/premium-storage#features. For blob storage LRS accounts, valid values are Hot/Cool/Archive. */
    @clientName("AccessTier")
    @header `x-ms-access-tier`: AccessTier;
    /** For page blobs on a premium storage account only. If the access tier is not explicitly set on the blob, the tier is inferred based on its content length and this header will be returned with true value. */
    @clientName("AccessTierInferred")
    @header `x-ms-access-tier-inferred`: boolean;
    /** For blob storage LRS accounts, valid values are rehydrate-pending-to-hot/rehydrate-pending-to-cool. If the blob is being rehydrated and is not complete then this header is returned indicating that rehydrate is pending and also tells the destination tier. */
    @clientName("ArchiveStatus")
    @header `x-ms-archive-status`: ArchiveStatus;
    /** The time the tier was changed on the object. This is only returned if the tier on the block blob was ever set. */
    @encode("date-time-rfc1123")
    @clientName("AccessTierChangeTime")
    @header `x-ms-access-tier-change-time`: utcDateTime;
    ...VersionIdResponseHeader;
    /** The value of this header indicates whether version of this blob is a current version, see also x-ms-version-id header. */
    @clientName("IsCurrentVersion")
    @header `x-ms-is-current-version`: boolean;
    /** The number of tags associated with the blob */
    @clientName("TagCount")
    @header `x-ms-tag-count`: int64;
    /** The time this blob will expire. */
    @clientName("ExpiresOn")
    @encode("date-time-rfc1123")
    @header `x-ms-expiry-time`: utcDateTime;
    /** If this blob has been sealed */
    @clientName("IsSealed")
    @header `x-ms-blob-sealed`: boolean;
    /** If an object is in rehydrate pending state then this header is returned with priority of rehydrate. Valid values are High and Standard. */
    @clientName("RehydratePriority")
    @header `x-ms-rehydrate-priority`: RehydratePriority;
    /** UTC date/time value generated by the service that indicates the time at which the blob was last read or written to */
    @clientName("LastAccessed")
    @encode("date-time-rfc1123")
    @header `x-ms-last-access-time`: utcDateTime;
    /** UTC date/time value generated by the service that indicates the time at which the blob immutability policy will expire. */
    @clientName("ImmutabilityPolicyExpiresOn")
    @encode("date-time-rfc1123")
    @header `x-ms-immutability-policy-until-date`: utcDateTime;
    /** Indicates immutability policy mode. */
    @clientName("ImmutabilityPolicyMode")
    @header `x-ms-immutability-policy-mode`: BlobImmutabilityPolicyMode;
    /** Indicates if a legal hold is present on the blob. */
    @clientName("LegalHold")
    @header `x-ms-legal-hold`: boolean;
  } | StorageError;

  @delete
  /** If the storage account's soft delete feature is disabled then, when a blob is deleted, it is permanently removed from the storage account. If the storage account's soft delete feature is enabled, then, when a blob is deleted, it is marked for deletion and becomes inaccessible immediately. However, the blob service retains the blob or snapshot for the number of days specified by the DeleteRetentionPolicy section of [Storage service properties] (Set-Blob-Service-Properties.md). After the specified number of days has passed, the blob's data is permanently removed from the storage account. Note that you continue to be charged for the soft-deleted blob's storage until it is permanently removed. Use the List Blobs API and specify the \"include=deleted\" query parameter to discover which blobs and snapshots have been soft deleted. You can then use the Undelete Blob API to restore a soft-deleted blob. All other operations on a soft-deleted blob or snapshot causes the service to return an HTTP status code of 404 (ResourceNotFound). */
  @operationId("Blob_Delete")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  deleteBlob(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...SnapshotParameter;
    ...VersionIdParameter;
    ...TimeoutParameter;
    ...LeaseIdOptional;
    ...DeleteSnapshotsParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...BlobDeleteTypeParameter;
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
  @put
  @operationId("PageBlob_Create")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  createPageBlob(
    // TODO: Metadata
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ContentLengthHeader;
    ...PremiumPageBlobAccessTierOptional;
    ...BlobContentTypeParameter;
    ...BlobContentEncodingParameter;
    ...BlobContentLanguageParameter;
    ...BlobContentMD5Parameter;
    ...BlobCacheControlParameter;
    ...LeaseIdOptional;
    ...BlobContentDispositionParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...BlobContentLengthRequiredParameter;
    ...BlobSequenceNumberParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...BlobTagsHeaderParameter;
    ...ImmutabilityPolicyExpiryParameter;
    ...LegalHoldOptionalParameter;
  ): {
    @statusCode statusCode: 201;

    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMD5ResponseHeader;
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
  @put
  /** The Create operation creates a new append blob. */
  @operationId("AppendBlob_Create")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  createAppendBlob(
    // TODO: Metadata
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ContentLengthHeader;
    ...BlobContentTypeParameter;
    ...BlobContentEncodingParameter;
    ...BlobContentLanguageParameter;
    ...BlobContentMD5Parameter;
    ...BlobCacheControlParameter;
    ...LeaseIdOptional;
    ...BlobContentDispositionParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...BlobTagsHeaderParameter;
    ...ImmutabilityPolicyExpiryParameter;
    ...ImmutabilityPolicyModeParameter;
    ...LegalHoldOptionalParameter;
  ): {
    @statusCode statusCode: 201;

    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMD5ResponseHeader;
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
  @put
  @operationId("BlockBlob_Upload")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  uploadBlockBlob(
    // TODO: Metadata

    ...ContainerNameParameter;
    ...BlobNameParameter;

    // TODO: body
    /** The bytes to upload to the block blob. */
    @body body: bytes;

    ...TimeoutParameter;
    ...ContentMD5Parameter;
    ...BlobContentTypeParameter;
    ...BlobContentEncodingParameter;
    ...BlobContentLanguageParameter;
    ...BlobContentMD5Parameter;
    ...BlobCacheControlParameter;
    ...LeaseIdOptional;
    ...BlobContentDispositionParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...AccessTierOptionalParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...BlobTagsHeaderParameter;
    ...ImmutabilityPolicyExpiryParameter;
    ...ImmutabilityPolicyModeParameter;
    ...LegalHoldOptionalParameter;
    ...ContentCrc64Parameter;
  ): {
    @statusCode statusCode: 201;

    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMD5ResponseHeader;
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
interface BlockBlobFromUrlService{
  @put
  /** The Put Blob from URL operation creates a new Block Blob where the contents of the blob are read from a given URL.  This API is supported beginning with the 2020-04-08 version. Partial updates are not supported with Put Blob from URL; the content of an existing blob is overwritten with the content of the new blob.  To perform partial updates to a block blob’s contents using a source URL, use the Put Block from URL API in conjunction with Put Block List. */
  @operationId("BlockBlob_PutBlobFromUrl")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  putBlockBlobFromUrl(
    // TODO: Metadata

    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ContentMD5Parameter;
    ...ContentLengthHeader;
    ...BlobContentTypeParameter;
    ...BlobContentEncodingParameter;
    ...BlobContentLanguageParameter;
    ...BlobContentMD5Parameter;
    ...BlobCacheControlParameter;
    ...LeaseIdOptional;
    ...BlobContentDispositionParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...AccessTierOptionalParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...SourceIfModifiedSinceParameter;
    ...SourceIfMatchParameter;
    ...SourceIfNoneMatchParameter;
    ...SourceIfTagsParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...SourceContentMD5Parameter;
    ...BlobTagsHeaderParameter;
    ...CopySourceParameter;
    ...CopySourceBlobPropertiesParameter;
    ...CopySourceAuthorizationParameter;
    ...CopySourceTagsParameter;
  ): {
    @statusCode statusCode: 201;

    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMD5ResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...IsServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=undelete")
interface BlobUndeleteService {
  @post
  /** "Undelete a blob that was previously soft deleted" */
  @operationId("Blob_Undelete")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  undeleteBlob(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
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
  @post
  /** "Set the expiration time of a blob" */
  @operationId("Blob_SetExpiry")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setBlobExpiry(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...BlobExpiryOptionsParameter;
    ...BlobExpiryTimeParameter;
  ): {
    @statusCode statusCode: 200;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_SetHTTPHeaders")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setHttpHeaders(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...BlobCacheControlParameter;
    ...BlobContentTypeParameter;
    ...BlobContentMD5Parameter;
    ...BlobContentEncodingParameter;
    ...BlobContentLanguageParameter;
    ...LeaseIdOptional;
    ...BlobContentDispositionParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 200;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_SetImmutabilityPolicy")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setImmutabilityPolicy(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...IfUnmodifiedSince;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...ImmutabilityPolicyExpiryParameter;
    ...ImmutabilityPolicyModeParameter;
  ): {
    @statusCode statusCode: 200;
    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...ImmutabilityPolicyExpiryResponseHeader;
    ...ImmutabilityPolicyModeResponseHeader;
  } | StorageError;

  /** The Delete Immutability Policy operation deletes the immutability policy on the blob. */
  @delete 
  @operationId("Blob_DeleteImmutabilityPolicy")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  deleteImmutabilityPolicy(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
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
  @put
  @operationId("Blob_SetLegalHold")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setLegalHold(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LegalHoldRequiredParameter;
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
  @put
  @operationId("Blob_SetMetadata")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setMetadata(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    // TODO: Metadata ...MetadataParameter; 
    ...LeaseIdOptional;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
  ): {
    @statusCode statusCode: 200;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_AcquireLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  acquireLease(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseDurationParameter;
    ...ProposedLeaseIdOptional;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
  ): {
    @statusCode statusCode: 201;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_ReleaseLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  releaseLease(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseIdRequiredParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
  ): {
    @statusCode statusCode: 200;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_RenewLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  renewLease(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseIdRequiredParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
  ): {
    @statusCode statusCode: 200;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_ChangeLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  changeLease(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseIdRequiredParameter;
    ...ProposedLeaseIdOptional;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
  ): {
    @statusCode statusCode: 200;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_BreakLease")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  breakLease(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseBreakPeriodParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
  ): {
    @statusCode statusCode: 202;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_CreateSnapshot")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  createSnapshot(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    // TODO: ...MetadataParameter;
    ...LeaseIdOptional;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
  ): {
    @statusCode statusCode: 201;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_StartCopyFromURL")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  startCopyFromUrl(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    // TODO: ...MetadataParameter;
    ...AccessTierOptionalParameter;
    ...RehydratePriorityParameter;
    ...SourceIfModifiedSinceParameter;
    ...SourceIfUnmodifiedSinceParameter;
    ...SourceIfMatchParameter;
    ...SourceIfNoneMatchParameter;
    ...SourceIfTagsParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...CopySourceParameter;
    ...LeaseIdOptional;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...BlobTagsHeaderParameter;
    ...SealBlobParameter;
    ...ImmutabilityPolicyExpiryParameter;
    ...ImmutabilityPolicyModeParameter;
    ...LegalHoldOptionalParameter;
  ): {
    @statusCode statusCode: 202;
    ...ETagResponseHeader;
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
  @put
  @operationId("Blob_AbortCopyFromURL")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  copyFromUrl(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    // TODO: ...MetadataParameter;
    ...AccessTierOptionalParameter;
    ...SourceIfModifiedSinceParameter;
    ...SourceIfUnmodifiedSinceParameter;
    ...SourceIfMatchParameter;
    ...SourceIfNoneMatchParameter;
    ...IfModifiedSince;
    ...IfUnmodifiedSince;
    ...IfMatchParameter;
    ...IfNoneMatchParameter;
    ...IfTagsParameter;
    ...CopySourceParameter;
    ...LeaseIdOptional;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...SourceContentMD5Parameter;
    ...BlobTagsHeaderParameter;
    ...ImmutabilityPolicyExpiryParameter;
    ...ImmutabilityPolicyModeParameter;
    ...LegalHoldOptionalParameter;
    ...CopySourceAuthorizationParameter;
    ...EncryptionScopeParameter;
    ...CopySourceTagsParameter;
  ): {
    @statusCode statusCode: 202;
    ...ETagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ClientRequestIdResponseHeader;
    ...RequestIdResponseHeader;
    ...VersionResponseHeader;
    ...DateResponseHeader;
    ...CopyIdResponseHeader;
    ...CopyStatusResponseHeader;
    ...ContentMD5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...EncryptionScopeResponseHeader;
  } | StorageError;
}

@route("/{containerName}/{blob}?comp=copy&copyid")
interface BlobCopyAbortService {
  /** The Abort Copy From URL operation aborts a pending Copy From URL operation, and leaves a destination blob with zero length and full metadata. */
  @put
  @operationId("Blob_AbortCopyFromURL")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  abortCopyFromUrl(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...CopyIdParameter;
    ...LeaseIdOptional;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
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
  @put
  @operationId("Blob_SetTier")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  setTier(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...TimeoutParameter;
    ...AccessTierRequiredParameter;
    ...RehydratePriorityParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
    ...LeaseIdOptional;
    ...IfTagsParameter;

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
  @get
  @operationId("Blob_GetAccountInfo")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  getAccountInfo(
    ...ContainerNameParameter;
    ...BlobNameParameter;
    ...ApiVersionParameter;
    ...ClientRequestIdParameter;
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
