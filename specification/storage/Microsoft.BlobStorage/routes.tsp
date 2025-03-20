import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.tsp";

namespace Storage.Blob;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

/** Azure Storage Blob basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperation<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  TError = StorageError
>(
  ...TParams,

  /** Specifies the version of the operation to use for this request. */
  @header("x-ms-version")
  version: string,

  ...ClientRequestIdHeader,
): (TResponse & {
  /** Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above. */
  @header("x-ms-version")
  version: string;

  ...RequestIdResponseHeader;
  ...ClientRequestIdHeader;
}) | TError;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Service {
  /** Get the properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/?restype=service&comp=properties")
  setProperties is StorageOperation<
    {
      /** The storage service properties that specifies the analytics and CORS rules to set on the Blob service. */
      @body body: StorageServiceProperties;

      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /** Retrieves properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("/?restype=service&comp=properties")
  getProperties is StorageOperation<
    {
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: StorageServiceProperties;
    }
  >;

  /** Retrieves statistics related to replication for the Blob service. It is only available on the secondary location endpoint when read-access geo-redundant replication is enabled for the storage account. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("/?restype=service&comp=stats")
  getStatistics is StorageOperation<
    TimeoutParameter,
    {
      @statusCode statusCode: 200;
      @body body: StorageServiceStats;
      ...DateResponseHeader;
    }
  >;

  /** The List Containers Segment operation returns a list of the containers under the specified account */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/?comp=list")
  listContainersSegment is StorageOperation<
    {
      ...PrefixParameter;
      ...TimeoutParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: ListContainersSegmentResponse;
    }
  >;

  /** The Get User Delegation Key operation gets the user delegation key for the Blob service. This is only a valid operation when using User Delegation SAS. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas\">Create a user delegation SAS</a>. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @post
  @route("/?restype=service&comp=userdelegationkey")
  getUserDelegationKey is StorageOperation<
    {
      /** The user delegation key info. */
      @body body: KeyInfo;

      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 200;

      /** The user delegation key. */
      @body body: UserDelegationKey;
    }
  >;

  /** Returns the sku name and account kind. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @route("/?restype=account&comp=properties")
  getAccountInfo is StorageOperation<
    {},
    {
      @statusCode statusCode: 200;
      ...DateResponseHeader;
      ...SkuNameResponseHeader;
      ...AccountKindResponseHeader;
      ...IsHierarchicalNamespaceEnabledResponseHeader;
    }
  >;

  /** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @route("/?comp=batch")
  submitBatch is StorageOperation<
    {
      ...ContentLengthParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 200;
    }
  >;

  /** The Filter Blobs operation enables callers to list blobs across all containers whose tags match a given search expression. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/?comp=blobs")
  filterBlobs is StorageOperation<
    {
      ...FilterBlobsWhereParameter;
      ...FilterBlobsIncludeParameter;
      ...TimeoutParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: FilterBlobSegment;
      ...DateResponseHeader;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Container {
  /** Creates a new container under the specified account. If the container with the same name already exists, the operation fails. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}?restype=container")
  create is StorageOperation<
    {
      ...ContainerNameParameter;

      // TODO: x-ms-meta headers
      ...BlobPublicAccessParameter;

      ...DefaultEncryptionScopeParameter;
      ...DenyEncryptionScopeOverrideParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** returns all user-defined metadata and system properties for the specified container. The data returned does not include the container's list of blobs */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @route("/{containerName}?restype=container")
  getProperties is StorageOperation<
    {
      ...ContainerNameParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
    },
    {
      @statusCode statusCode: 200;

      // TODO: x-ms-meta headers
      ...EtagResponseHeader;

      ...LastModifiedResponseHeader;
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
    }
  >;

  /** operation marks the specified container for deletion. The container and any blobs contained within it are later deleted during garbage collection */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @delete
  @route("/{containerName}?restype=container")
  delete is StorageOperation<
    {
      ...ContainerNameParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
    },
    {
      @statusCode statusCode: 202;
      ...DateResponseHeader;
    }
  >;

  /** operation sets one or more user-defined name-value pairs for the specified container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?restype=container&comp=metadata")
  setMetadata is StorageOperation<
    {
      ...ContainerNameParameter;

      // TODO: ...MetadataParameter;
      ...TimeoutParameter;

      ...IfModifiedSinceParameter;
      ...LeaseIdOptionalParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** gets the permissions for the specified container. The permissions indicate whether container data may be accessed publicly. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("/{containerName}?restype=container&comp=acl")
  getAccessPolicy is StorageOperation<
    {
      ...ContainerNameParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: SignedIdentifiers;
      ...PublicAccessResponseHeader;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** sets the permissions for the specified container. The permissions indicate whether blobs in a container may be accessed publicly. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?restype=container&comp=acl")
  setAccessPolicy is StorageOperation<
    {
      ...ContainerNameParameter;
      ...ContainerAclParameter;
      ...TimeoutParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...LeaseIdOptionalParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** Restores a previously-deleted container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?restype=container&comp=undelete")
  undelete is StorageOperation<
    {
      ...ContainerNameParameter;
      ...DeletedContainerNameParameter;
      ...DeletedContainerVersionParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 201;
      ...DateResponseHeader;
    }
  >;

  /** Renames an existing container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?restype=container&comp=rename")
  rename is StorageOperation<
    {
      ...ContainerNameParameter;
      ...SourceContainerNameParameter;
      ...SourceLeaseIdParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 200;
      ...DateResponseHeader;
    }
  >;

  /** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @route("/{containerName}?restype=container&comp=batch")
  submitBatch is StorageOperation<
    {
      /** The batch request content */
      ...BodyParameter;

      ...ContainerNameParameter;
      ...ContentLengthParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 202;
      @body body: bytes;
    }
  >;

  /** The Filter Blobs operation enables callers to list blobs in a container whose tags match a given search expression.  Filter blobs searches within the given container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/{containerName}?restype=container&comp=blobs")
  filterBlobs is StorageOperation<
    {
      ...ContainerNameParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...FilterBlobsWhereParameter;
      ...FilterBlobsIncludeParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: FilterBlobSegment;
      ...DateResponseHeader;
    }
  >;

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&acquire")
  acquireLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...LeaseDurationParameter;
      ...TimeoutParameter;
      ...ProposedLeaseIdOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
    },
    {
      @statusCode statusCode: 201;
      ...LeaseIdResponseHeader;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&release")
  releaseLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...LeaseIdRequiredParameter;
      ...TimeoutParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&renew")
  renewLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...LeaseIdRequiredParameter;
      ...TimeoutParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
    },
    {
      @statusCode statusCode: 200;
      ...LeaseIdResponseHeader;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&break")
  breakLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...TimeoutParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...LeaseBreakPeriodParameter;
    },
    {
      @statusCode statusCode: 202;
      ...LeaseTimeResponseHeader;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseIdResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** [Update] establishes and manages a lock on a container for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}?comp=lease&restype=container&change")
  changeLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...LeaseIdRequiredParameter;
      ...ProposedLeaseIdRequiredParameter;
      ...TimeoutParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
    },
    {
      @statusCode statusCode: 200;
      ...LeaseIdResponseHeader;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseTimeResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** [Update] The List Blobs operation returns a list of the blobs under the specified container */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/{containerName}?restype=container&comp=list&flat")
  listBlobFlatSegment is StorageOperation<
    {
      ...ContainerNameParameter;
      ...PrefixParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...ListBlobsIncludeParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: ListBlobsFlatSegmentResponse;
      ...DateResponseHeader;
    }
  >;

  /** [Update] The List Blobs operation returns a list of the blobs under the specified container */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("/{containerName}?restype=container&comp=list&hierarchy")
  listBlobHierarchySegment is StorageOperation<
    {
      ...ContainerNameParameter;
      ...DelimiterParameter;
      ...PrefixParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...ListBlobsIncludeParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: ListBlobsHierarchySegmentResponse;
      ...DateResponseHeader;
    }
  >;

  /** Returns the sku name and account kind */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @route("/{containerName}?restype=account&comp=properties")
  getAccountInfo is StorageOperation<
    {
      ...ContainerNameParameter;
    },
    {
      @statusCode statusCode: 200;
      ...DateResponseHeader;
      ...SkuNameResponseHeader;
      ...AccountKindResponseHeader;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
@route("/{containerName}/{blob}")
interface Blob {
  /** The Download operation reads or downloads a blob from the system, including its metadata and properties. You can also call Download to read a snapshot. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  download is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...SnapshotParameter;
      ...VersionIdParameter;
      ...TimeoutParameter;
      ...RangeParameter;
      ...LeaseIdOptionalParameter;
      ...GetRangeContentMd5Parameter;
      ...GetRangeContentCrc64Parameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
    },
    {
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
    }
  >;

  /** The Get Properties operation returns all user-defined metadata, standard HTTP properties, and system properties for the blob. It does not return the content of the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @head
  getProperties is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...SnapshotParameter;
      ...VersionIdParameter;
      ...LeaseIdOptionalParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
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
    }
  >;

  /** If the storage account's soft delete feature is disabled then, when a blob is deleted, it is permanently removed from the storage account. If the storage account's soft delete feature is enabled, then, when a blob is deleted, it is marked for deletion and becomes inaccessible immediately. However, the blob service retains the blob or snapshot for the number of days specified by the DeleteRetentionPolicy section of [Storage service properties] (Set-Blob-Service-Properties.md). After the specified number of days has passed, the blob's data is permanently removed from the storage account. Note that you continue to be charged for the soft-deleted blob's storage until it is permanently removed. Use the List Blobs API and specify the \"include=deleted\" query parameter to discover which blobs and snapshots have been soft deleted. You can then use the Undelete Blob API to restore a soft-deleted blob. All other operations on a soft-deleted blob or snapshot causes the service to return an HTTP status code of 404 (ResourceNotFound). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @delete
  delete is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...SnapshotParameter;
      ...VersionIdParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...DeleteSnapshotsParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...BlobDeleteTypeParameter;
    },
    {
      @statusCode statusCode: 202;
      ...DateResponseHeader;
    }
  >;

  /** "Undelete a blob that was previously soft deleted" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @route("?comp=undelete")
  @post
  undelete is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
    },
    {
      @statusCode statusCode: 200;
      ...DateResponseHeader;
    }
  >;

  /** "Set the expiration time of a blob" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @route("?comp=expiry")
  setExpiry is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...BlobExpiryOptionsParameter;
      ...BlobExpiryTimeParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** The Set HTTP Headers operation sets system properties on the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=properties&SetHTTPHeaders")
  setHttpHeaders is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...BlobCacheControlParameter;
      ...BlobContentTypeParameter;
      ...BlobContentMd5Parameter;
      ...BlobContentEncodingParameter;
      ...BlobContentLanguageParameter;
      ...LeaseIdOptionalParameter;
      ...BlobContentDispositionParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...BlobSequenceNumberResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** "Set the immutability policy of a blob" */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=immutabilityPolicies")
  setImmutabilityPolicy is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...IfUnmodifiedSinceParameter;
      ...ImmutabilityPolicyExpiryParameter;
      ...ImmutabilityPolicyModeParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...ImmutabilityPolicyExpiryResponseHeader;
      ...ImmutabilityPolicyModeResponseHeader;
    }
  >;

  /** The Delete Immutability Policy operation deletes the immutability policy on the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @delete
  @route("?comp=immutabilityPolicies")
  deleteImmutabilityPolicy is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 200;
      ...DateResponseHeader;
    }
  >;

  /** The Set Legal Hold operation sets a legal hold on the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=legalhold")
  setLegalHold is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LegalHoldRequiredParameter;
    },
    {
      @statusCode statusCode: 200;
      ...DateResponseHeader;
      ...LegalHoldResponseHeader;
    }
  >;

  /** The Set Metadata operation sets user-defined metadata for the specified blob as one or more name-value pairs. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=metadata")
  setMetadata is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;

      // TODO: Metadata ...MetadataParameter;
      ...LeaseIdOptionalParameter;

      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=lease&acquire")
  acquireLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LeaseDurationParameter;
      ...ProposedLeaseIdOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...LeaseIdResponseHeader;
    }
  >;

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=lease&release")
  releaseLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LeaseIdRequiredParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=lease&renew")
  renewLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LeaseIdRequiredParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...LeaseIdResponseHeader;
    }
  >;

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=lease&change")
  changeLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LeaseIdRequiredParameter;
      ...ProposedLeaseIdOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...LeaseIdResponseHeader;
    }
  >;

  /** [Update] The Lease Blob operation establishes and manages a lock on a blob for write and delete operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?comp=lease&break")
  breakLease is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LeaseBreakPeriodParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...LeaseTimeResponseHeader;
    }
  >;

  /** The Create Snapshot operation creates a read-only snapshot of a blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?comp=snapshot")
  createSnapshot is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;

      // TODO: ...MetadataParameter;
      ...LeaseIdOptionalParameter;

      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...SnapshotResponseHeader;
      ...DateResponseHeader;
      ...IsServerEncryptedResponseHeader;
    }
  >;

  /** The Start Copy From URL operation copies a blob or an internet resource to a new blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?comp=copy")
  startCopyFromUrl is StorageOperation<
    {
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
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...CopySourceParameter;
      ...LeaseIdOptionalParameter;
      ...BlobTagsHeaderParameter;
      ...SealBlobParameter;
      ...ImmutabilityPolicyExpiryParameter;
      ...ImmutabilityPolicyModeParameter;
      ...LegalHoldOptionalParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...VersionIdResponseHeader;
      ...DateResponseHeader;
      ...CopyIdResponseHeader;
      ...CopyStatusResponseHeader;
    }
  >;

  /** The Copy From URL operation copies a blob or an internet resource to a new blob. It will not return a response until the copy is complete. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?comp=copy&sync")
  copyFromUrl is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;

      // TODO: ...MetadataParameter;
      ...AccessTierOptionalParameter;

      ...SourceIfModifiedSinceParameter;
      ...SourceIfUnmodifiedSinceParameter;
      ...SourceIfMatchParameter;
      ...SourceIfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...CopySourceParameter;
      ...LeaseIdOptionalParameter;
      ...SourceContentMd5Parameter;
      ...BlobTagsHeaderParameter;
      ...ImmutabilityPolicyExpiryParameter;
      ...ImmutabilityPolicyModeParameter;
      ...LegalHoldOptionalParameter;
      ...CopySourceAuthorizationParameter;
      ...EncryptionScopeParameter;
      ...CopySourceTagsParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...CopyIdResponseHeader;
      ...CopyStatusResponseHeader;
      ...ContentMd5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Abort Copy From URL operation aborts a pending Copy From URL operation, and leaves a destination blob with zero length and full metadata. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @put
  @route("?comp=copy&copyid")
  abortCopyFromUrl is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...CopyIdParameter;
      ...LeaseIdOptionalParameter;
    },
    {
      @statusCode statusCode: 204;
      ...DateResponseHeader;
    }
  >;

  /** The Set Tier operation sets the tier on a block blob. The operation is allowed on a page blob or block blob, but not on an append blob. A block blob's tier determines Hot/Cool/Archive storage type. This operation does not update the blob's ETag. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=tier")
  setTier is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...AccessTierRequiredParameter;
      ...RehydratePriorityParameter;
      ...LeaseIdOptionalParameter;
      ...IfTagsParameter;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard pattern"
      @statusCode statusCode: 200 | 202;
    }
  >;

  /** Returns the sku name and account kind */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @route("?restype=account&comp=properties")
  getAccountInfo is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
    },
    {
      @statusCode statusCode: 200;
      ...DateResponseHeader;
      ...AccountKindResponseHeader;
      ...SkuNameResponseHeader;
    }
  >;

  /** The Query operation enables users to select/project on blob data by providing simple query expressions. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @post
  @route("/{containerName}/{blob}?comp=query")
  query is StorageOperation<
    {
      ...QueryRequestParameter;
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...SnapshotParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
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
      ...DateResponseHeader;
      ...AcceptRangesResponseHeader;
      ...BlobCommittedBlockCountResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
      ...BlobContentMd5ResponseHeader;
    }
  >;

  /** The Get Blob Tags operation enables users to get tags on a blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("/{containerName}/{blob}?comp=tags")
  getTags is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...SnapshotParameter;
      ...VersionIdParameter;
      ...LeaseIdOptionalParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: BlobTags;
      ...DateResponseHeader;
    }
  >;

  /** The Set Tags operation enables users to set tags on a blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=tags")
  setTags is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...VersionIdParameter;
      ...LeaseIdOptionalParameter;
      ...ContentMd5Parameter;
      ...ContentCrc64Parameter;
      ...IfTagsParameter;
      ...BlobTagsBodyParameter;
    },
    {
      @statusCode statusCode: 204;
      ...DateResponseHeader;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface PageBlob {
  /** The Create operation creates a new page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}/{blob}?PageBlob")
  create is StorageOperation<
    {
      // TODO: Metadata
      ...ContainerNameParameter;

      ...BlobNameParameter;
      ...TimeoutParameter;
      ...ContentLengthParameter;
      ...PremiumPageBlobAccessTierOptional;
      ...BlobContentTypeParameter;
      ...BlobContentEncodingParameter;
      ...BlobContentLanguageParameter;
      ...BlobContentMd5Parameter;
      ...BlobCacheControlParameter;
      ...LeaseIdOptionalParameter;
      ...BlobContentDispositionParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...BlobContentLengthRequiredParameter;
      ...BlobSequenceNumberParameter;
      ...BlobTagsHeaderParameter;
      ...ImmutabilityPolicyExpiryParameter;
      ...LegalHoldOptionalParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentMd5ResponseHeader;
      ...VersionIdResponseHeader;
      ...DateResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Upload Pages operation writes a range of pages to a page blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=page&update")
  uploadPages is StorageOperation<
    {
      /** The data to upload. */
      ...BodyParameter;

      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...ContentLengthParameter;
      ...ContentMd5Parameter;
      ...ContentCrc64Parameter;
      ...TimeoutParameter;
      ...RangeParameter;
      ...LeaseIdOptionalParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...IfSequenceNumberLessThanOrEqualToParameter;
      ...IfSequenceNumberLessThanParameter;
      ...IfSequenceNumberEqualToParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentMd5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...BlobSequenceNumberResponseHeader;
      ...DateResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Clear Pages operation clears a range of pages from a page blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=page&clear")
  clearPages is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...ContentLengthParameter;
      ...TimeoutParameter;
      ...RangeParameter;
      ...LeaseIdOptionalParameter;
      ...IfSequenceNumberLessThanOrEqualToParameter;
      ...IfSequenceNumberLessThanParameter;
      ...IfSequenceNumberEqualToParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...BlobSequenceNumberResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** The Upload Pages operation writes a range of pages to a page blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=page&update&fromUrl")
  uploadPagesFromUrl is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...ContentLengthParameter;
      ...SourceUrlParameter;
      ...SourceRangeRequiredPutPageFromUrlParameter;
      ...SourceContentMd5Parameter;
      ...SourceContentCrc64Parameter;
      ...RangeRequiredPutPageFromUrlParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...LeaseIdOptionalParameter;
      ...IfSequenceNumberLessThanOrEqualToParameter;
      ...IfSequenceNumberLessThanParameter;
      ...IfSequenceNumberEqualToParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...SourceIfModifiedSinceParameter;
      ...SourceIfUnmodifiedSinceParameter;
      ...SourceIfMatchParameter;
      ...SourceIfNoneMatchParameter;
      ...CopySourceAuthorizationParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...ContentMd5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...BlobSequenceNumberResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Get Page Ranges operation returns the list of valid page ranges for a page blob or snapshot of a page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("/{containerName}/{blob}?comp=pagelist")
  getPageRanges is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...SnapshotParameter;
      ...RangeParameter;
      ...LeaseIdOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: PageList;
      ...LastModifiedResponseHeader;
      ...EtagResponseHeader;
      ...BlobContentLengthResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** The Get Page Ranges Diff operation returns the list of valid page ranges for a page blob or snapshot of a page blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("/{containerName}/{blob}?comp=pagelist&diff")
  getPageRangesDiff is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...SnapshotParameter;
      ...TimeoutParameter;
      ...PrevSnapshotParameter;
      ...PrevSnapshotUrlParameter;
      ...RangeParameter;
      ...LeaseIdOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: PageList;
      ...LastModifiedResponseHeader;
      ...EtagResponseHeader;
      ...BlobContentLengthResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** The Resize operation increases the size of the page blob to the specified size. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=properties&Resize")
  resize is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...BlobContentLengthRequiredParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...BlobSequenceNumberResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** The Update Sequence Number operation sets the blob's sequence number. The operation will fail if the specified sequence number is less than the current sequence number of the blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=properties&UpdateSequenceNumber")
  updateSequenceNumber is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...SequenceNumberActionParameter;
      ...SequenceNumberParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...BlobSequenceNumberResponseHeader;
      ...DateResponseHeader;
    }
  >;

  /** The Copy Incremental operation copies a snapshot of the source page blob to a destination page blob. The snapshot is copied such that only the differential changes between the previously copied snapshot are transferred to the destination. The copied snapshots are complete copies of the original snapshot and can be read or copied from as usual. This API is supported since REST version 2016-05-31. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=incrementalcopy")
  copyIncremental is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...LeaseIdOptionalParameter;
      ...CopySourceParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...CopyIdResponseHeader;
      ...CopyStatusResponseHeader;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
@route("/{containerName}/{blob}?AppendBlob")
interface AppendBlob {
  /** The Create operation creates a new append blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  create is StorageOperation<
    {
      // TODO: Metadata
      ...ContainerNameParameter;

      ...BlobNameParameter;
      ...TimeoutParameter;
      ...ContentLengthParameter;
      ...BlobContentTypeParameter;
      ...BlobContentEncodingParameter;
      ...BlobContentLanguageParameter;
      ...BlobContentMd5Parameter;
      ...BlobCacheControlParameter;
      ...LeaseIdOptionalParameter;
      ...BlobContentDispositionParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...BlobTagsHeaderParameter;
      ...ImmutabilityPolicyExpiryParameter;
      ...ImmutabilityPolicyModeParameter;
      ...LegalHoldOptionalParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentMd5ResponseHeader;
      ...VersionIdResponseHeader;
      ...DateResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Append Block operation commits a new block of data to the end of an append blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=appendblock")
  appendBlock is StorageOperation<
    {
      /** The data to upload. */
      ...BodyParameter;

      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...ContentLengthParameter;
      ...ContentMd5Parameter;
      ...ContentCrc64Parameter;
      ...LeaseIdOptionalParameter;
      ...BlobConditionMaxSizeParameter;
      ...BlobConditionAppendPosParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...BlobSequenceNumberResponseHeader;
      ...DateResponseHeader;
      ...ContentMd5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...BlobAppendOffsetResponseHeader;
      ...BlobCommittedBlockCountResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Append Block From URL operation creates a new block to be committed as part of an append blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=appendblock&fromUrl")
  appendBlockFromUrl is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...ContentLengthParameter;
      ...SourceUrlParameter;
      ...SourceRangeParameter;
      ...SourceContentMd5Parameter;
      ...SourceContentCrc64Parameter;
      ...LeaseIdOptionalParameter;
      ...BlobConditionMaxSizeParameter;
      ...BlobConditionAppendPosParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...CopySourceAuthorizationParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...ContentMd5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...BlobAppendOffsetResponseHeader;
      ...BlobCommittedBlockCountResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Seal operation seals the Append Blob to make it read-only. Seal is supported only on version 2019-12-12 version or later. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=seal")
  seal is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...BlobConditionAppendPosParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 200;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...DateResponseHeader;
      ...IsSealedResponseHeader;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface BlockBlob {
  /** The Upload Block Blob operation updates the content of an existing block blob. Updating an existing block blob overwrites any existing metadata on the blob. Partial updates are not supported with Put Blob; the content of the existing blob is overwritten with the content of the new blob. To perform a partial update of the content of a block blob, use the Put Block List operation. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?BlockBlob")
  upload is StorageOperation<
    {
      // TODO: Metadata

      ...ContainerNameParameter;

      ...BlobNameParameter;
      ...BodyParameter;
      ...TimeoutParameter;
      ...ContentMd5Parameter;
      ...BlobContentTypeParameter;
      ...BlobContentEncodingParameter;
      ...BlobContentLanguageParameter;
      ...BlobContentMd5Parameter;
      ...BlobCacheControlParameter;
      ...LeaseIdOptionalParameter;
      ...BlobContentDispositionParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...AccessTierOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...BlobTagsHeaderParameter;
      ...ImmutabilityPolicyExpiryParameter;
      ...ImmutabilityPolicyModeParameter;
      ...LegalHoldOptionalParameter;
      ...ContentCrc64Parameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentMd5ResponseHeader;
      ...VersionIdResponseHeader;
      ...DateResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Put Blob from URL operation creates a new Block Blob where the contents of the blob are read from a given URL.  This API is supported beginning with the 2020-04-08 version. Partial updates are not supported with Put Blob from URL; the content of an existing blob is overwritten with the content of the new blob.  To perform partial updates to a block blob’s contents using a source URL, use the Put Block from URL API in conjunction with Put Block List. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?BlockBlob&fromUrl")
  putBlobFromUrl is StorageOperation<
    {
      // TODO: Metadata

      ...ContainerNameParameter;

      ...BlobNameParameter;
      ...TimeoutParameter;
      ...ContentMd5Parameter;
      ...ContentLengthParameter;
      ...BlobContentTypeParameter;
      ...BlobContentEncodingParameter;
      ...BlobContentLanguageParameter;
      ...BlobContentMd5Parameter;
      ...BlobCacheControlParameter;
      ...LeaseIdOptionalParameter;
      ...BlobContentDispositionParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...AccessTierOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...SourceIfModifiedSinceParameter;
      ...SourceIfMatchParameter;
      ...SourceIfNoneMatchParameter;
      ...SourceIfTagsParameter;
      ...SourceContentMd5Parameter;
      ...BlobTagsHeaderParameter;
      ...CopySourceParameter;
      ...CopySourceBlobPropertiesParameter;
      ...CopySourceAuthorizationParameter;
      ...CopySourceTagsParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentMd5ResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Stage Block operation creates a new block to be committed as part of a blob */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("/{containerName}/{blob}?comp=block")
  stageBlock is StorageOperation<
    {
      ...BodyParameter;
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...BlockIdParameter;
      ...ContentLengthParameter;
      ...ContentMd5Parameter;
      ...TimeoutParameter;
      ...ContentCrc64Parameter;
      ...LeaseIdOptionalParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
    },
    {
      @statusCode statusCode: 201;
      ...DateResponseHeader;
      ...ContentMd5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Stage Block From URL operation creates a new block to be committed as part of a blob where the contents are read from a URL. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=block&fromURL")
  stageBlockFromUrl is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...BlockIdParameter;
      ...ContentLengthParameter;
      ...SourceUrlParameter;
      ...SourceRangeParameter;
      ...SourceContentMd5Parameter;
      ...SourceContentCrc64Parameter;
      ...TimeoutParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...LeaseIdOptionalParameter;
      ...SourceIfModifiedSinceParameter;
      ...SourceIfUnmodifiedSinceParameter;
      ...SourceIfMatchParameter;
      ...SourceIfNoneMatchParameter;
      ...CopySourceAuthorizationParameter;
    },
    {
      @statusCode statusCode: 201;
      ...DateResponseHeader;
      ...ContentMd5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Commit Block List operation writes a blob by specifying the list of block IDs that make up the blob. In order to be written as part of a blob, a block must have been successfully written to the server in a prior Put Block operation. You can call Put Block List to update a blob by uploading only those blocks that have changed, then committing the new and existing blocks together. You can do this by specifying whether to commit a block from the committed block list or from the uncommitted block list, or to commit the most recently uploaded version of the block, whichever list it may belong to. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=blocklist")
  commitBlockList is StorageOperation<
    {
      ...BlobBlocksParameter;
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...TimeoutParameter;
      ...BlobCacheControlParameter;
      ...BlobContentTypeParameter;
      ...BlobContentEncodingParameter;
      ...BlobContentLanguageParameter;
      ...BlobContentMd5Parameter;
      ...ContentMd5Parameter;
      ...ContentCrc64Parameter;

      // TODO: ...MetadataParameter;
      ...BlobContentDispositionParameter;

      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...EncryptionScopeParameter;
      ...AccessTierOptionalParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfTagsParameter;
      ...BlobTagsHeaderParameter;
      ...ImmutabilityPolicyExpiryParameter;
      ...ImmutabilityPolicyModeParameter;
      ...LegalHoldOptionalParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentMd5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...DateResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionScopeResponseHeader;
    }
  >;

  /** The Get Block List operation retrieves the list of blocks that have been uploaded as part of a block blob. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("?comp=blocklist")
  getBlockList is StorageOperation<
    {
      ...ContainerNameParameter;
      ...BlobNameParameter;
      ...SnapshotParameter;
      ...BlockListTypeParameter;
      ...LeaseIdOptionalParameter;
      ...IfTagsParameter;
    },
    {
      @statusCode statusCode: 200;
      @body body: BlockLookupList;
      ...LastModifiedResponseHeader;
      ...EtagResponseHeader;
      ...BlobContentLengthResponseHeader;
      ...DateResponseHeader;
    }
  >;
}
