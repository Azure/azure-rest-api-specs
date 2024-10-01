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

interface Service {
  /** Get the properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/?restype=service&comp=properties")
  setProperties(
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
  @get
  @route("/?restype=service&comp=properties")
  getProperties(
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

  /** Retrieves statistics related to replication for the Blob service. It is only available on the secondary location endpoint when read-access geo-redundant replication is enabled for the storage account. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @route("/?restype=service&comp=stats")
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

  /** The List Containers Segment operation returns a list of the containers under the specified account */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/?comp=list")
  listContainersSegment(
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

  /** The Get User Delegation Key operation gets the user delegation key for the Blob service. This is only a valid operation when using User Delegation SAS. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas\">Create a user delegation SAS</a>. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @post
  @route("/?restype=service&comp=userdelegationkey")
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

  /** Returns the sku name and account kind. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @route("/?restype=account&comp=properties")
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

  /** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @route("/?comp=batch")
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

  /** The Filter Blobs operation enables callers to list blobs across all containers whose tags match a given search expression. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/?comp=blobs")
  filterBlobs(
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

interface Container {
  /** Creates a new container under the specified account. If the container with the same name already exists, the operation fails. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}?restype=container")
  create(
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
  @route("/{containerName}?restype=container")
  getProperties(
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
  @route("/{containerName}?restype=container")
  delete(
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

  /** operation sets one or more user-defined name-value pairs for the specified container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?restype=container&comp=metadata")
  setMetadata(
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

  /** gets the permissions for the specified container. The permissions indicate whether container data may be accessed publicly. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @route("/{containerName}?restype=container&comp=acl")
  getAccessPolicy(
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
  @route("/{containerName}?restype=container&comp=acl")
  setAccessPolicy(
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

  /** Restores a previously-deleted container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?restype=container&comp=undelete")
  undelete(
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

  /** Renames an existing container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?restype=container&comp=rename")
  rename(
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

  /** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @route("/{containerName}?restype=container&comp=batch")
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

  /** The Filter Blobs operation enables callers to list blobs in a container whose tags match a given search expression.  Filter blobs searches within the given container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/{containerName}?restype=container&comp=blobs")
  filterBlobs(
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

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&acquire")
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

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&release")
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

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&renew")
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

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&break")
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

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&change")
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

  /** [Update] The List Blobs operation returns a list of the blobs under the specified container */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/{containerName}?restype=container&comp=list&flat")
  listBlobFlatSegment(
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

  /** [Update] The List Blobs operation returns a list of the blobs under the specified container */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/{containerName}?restype=container&comp=list&hierarchy")
  listBlobHierarchySegment(
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

  /** Returns the sku name and account kind */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @route("/{containerName}?restype=account&comp=properties")
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
interface Blob {
  /** The Download operation reads or downloads a blob from the system, including its metadata and properties. You can also call Download to read a snapshot. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  download(
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
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard pattern"
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
  getProperties(
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
  delete(
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

  /** "Undelete a blob that was previously soft deleted" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @route("?comp=undelete")
  @post
  undelete(
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

  /** "Set the expiration time of a blob" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @route("?comp=expiry")
  setExpiry(
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

  /** The Set HTTP Headers operation sets system properties on the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=properties&SetHTTPHeaders")
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

  /** "Set the immutability policy of a blob" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=immutabilityPolicies")
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
  @route("?comp=immutabilityPolicies")
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

  /** The Set Legal Hold operation sets a legal hold on the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=legalhold")
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

  /** The Set Metadata operation sets user-defined metadata for the specified blob as one or more name-value pairs. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=metadata")
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

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=lease&acquire")
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

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=lease&release")
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

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=lease&renew")
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

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=lease&change")
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

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?comp=lease&break")
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

  /** The Create Snapshot operation creates a read-only snapshot of a blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?comp=snapshot")
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

  /** The Start Copy From URL operation copies a blob or an internet resource to a new blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?comp=copy")
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

  /** The Copy From URL operation copies a blob or an internet resource to a new blob. It will not return a response until the copy is complete. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?comp=copy&sync")
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

  /** The Abort Copy From URL operation aborts a pending Copy From URL operation, and leaves a destination blob with zero length and full metadata. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @put
  @route("?comp=copy&copyid")
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

  /** The Set Tier operation sets the tier on a block blob. The operation is allowed on a page blob or block blob, but not on an append blob. A block blob's tier determines Hot/Cool/Archive storage type. This operation does not update the blob's ETag. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=tier")
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

  /** Returns the sku name and account kind */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @route("?restype=account&comp=properties")
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

  /** The Query operation enables users to select/project on blob data by providing simple query expressions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @post
  @route("/{containerName}/{blob}?comp=query")
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
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard pattern"
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

  /** The Get Blob Tags operation enables users to get tags on a blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @route("/{containerName}/{blob}?comp=tags")
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
  @route("/{containerName}/{blob}?comp=tags")
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

interface PageBlob {
  /** The Create operation creates a new page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}/{blob}?PageBlob")
  create(
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

  /** The Upload Pages operation writes a range of pages to a page blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=page&update")
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

  /** The Clear Pages operation clears a range of pages from a page blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=page&clear")
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

  /** The Upload Pages operation writes a range of pages to a page blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=page&update&fromUrl")
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

  /** The Get Page Ranges operation returns the list of valid page ranges for a page blob or snapshot of a page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @route("/{containerName}/{blob}?comp=pagelist")
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

  /** The Get Page Ranges Diff operation returns the list of valid page ranges for a page blob or snapshot of a page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  @get
  @route("/{containerName}/{blob}?comp=pagelist&diff")
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

  /** The Resize operation increases the size of the page blob to the specified size. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=properties&Resize")
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

  /** The Update Sequence Number operation sets the blob's sequence number. The operation will fail if the specified sequence number is less than the current sequence number of the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=properties&UpdateSequenceNumber")
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

  /** The Copy Incremental operation copies a snapshot of the source page blob to a destination page blob. The snapshot is copied such that only the differential changes between the previously copied snapshot are transferred to the destination. The copied snapshots are complete copies of the original snapshot and can be read or copied from as usual. This API is supported since REST version 2016-05-31. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=incrementalcopy")
  copyIncremental(
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

@route("/{containerName}/{blob}?AppendBlob")
interface AppendBlob {
  /** The Create operation creates a new append blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  create(
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

  /** The Append Block operation commits a new block of data to the end of an append blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=appendblock")
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

  /** The Append Block From URL operation creates a new block to be committed as part of an append blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=appendblock&fromUrl")
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

  /** The Seal operation seals the Append Blob to make it read-only. Seal is supported only on version 2019-12-12 version or later. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=seal")
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

interface BlockBlob {
  /** The Upload Block Blob operation updates the content of an existing block blob. Updating an existing block blob overwrites any existing metadata on the blob. Partial updates are not supported with Put Blob; the content of the existing blob is overwritten with the content of the new blob. To perform a partial update of the content of a block blob, use the Put Block List operation. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?BlockBlob")
  upload(
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

  /** The Put Blob from URL operation creates a new Block Blob where the contents of the blob are read from a given URL.  This API is supported beginning with the 2020-04-08 version. Partial updates are not supported with Put Blob from URL; the content of an existing blob is overwritten with the content of the new blob.  To perform partial updates to a block blob’s contents using a source URL, use the Put Block from URL API in conjunction with Put Block List. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?BlockBlob&fromUrl")
  putBlobFromUrl(
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

  /** The Stage Block operation creates a new block to be committed as part of a blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=block")
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

  /** The Stage Block From URL operation creates a new block to be committed as part of a blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=block&fromURL")
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

  /** The Commit Block List operation writes a blob by specifying the list of block IDs that make up the blob. In order to be written as part of a blob, a block must have been successfully written to the server in a prior Put Block operation. You can call Put Block List to update a blob by uploading only those blocks that have changed, then committing the new and existing blocks together. You can do this by specifying whether to commit a block from the committed block list or from the uncommitted block list, or to commit the most recently uploaded version of the block, whichever list it may belong to. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=blocklist")
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
  @route("?comp=blocklist")
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
