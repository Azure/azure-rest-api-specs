import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
namespace Storage.Blob {
  alias ApiVersionHeader = {
    /** Specifies the version of the operation to use for this request. */
    @apiVersion
    @access(Access.internal)
    @header("x-ms-version")
    version: string;
  };

  /** Azure Storage Blob basic operation template */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  op StorageOperation<
    TParams extends TypeSpec.Reflection.Model | void,
    TResponse extends TypeSpec.Reflection.Model | void,
    RequestMediaType extends string = "application/xml",
    ResponseMediaType extends string = "application/xml",
    TError = StorageError
  >(
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: RequestMediaType,

    ...ApiVersionHeader,
    ...ClientRequestIdHeader,
    ...TParams,
  ): (TResponse & {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: ResponseMediaType;

    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
  }) | TError;

  /** Azure Storage Blob basic operation template */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  op StorageOperationNoBody<
    TParams extends TypeSpec.Reflection.Model | void,
    TResponse extends TypeSpec.Reflection.Model | void,
    TError = StorageError
  >(...ApiVersionHeader, ...ClientRequestIdHeader, ...TParams): (TResponse & {
    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
  }) | TError;

  /** Sets properties for a storage account's Blob service endpoint, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @route("?restype=service&comp=properties")
  op setProperties is StorageOperation<
    {
      ...TimeoutParameter;

      /** The storage service properties to set. */
      @body
      storageServiceProperties: StorageServiceProperties;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /** Retrieves properties of a storage account's Blob service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("?restype=service&comp=properties")
  op getProperties is StorageOperation<
    TimeoutParameter,
    StorageServiceProperties
  >;

  /** Retrieves statistics related to replication for the Blob service. It is only available on the secondary location endpoint when read-access geo-redundant replication is enabled for the storage account. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("?restype=service&comp=stats")
  op getStatistics is StorageOperation<
    TimeoutParameter,
    {
      ...DateResponseHeader;

      /** Storage service statistics */
      @body
      storageServiceStats: StorageServiceStats;
    }
  >;

  /** The List Containers Segment operation returns a list of the containers under the specified account */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @list
  @route("?comp=list")
  op listContainersSegment is StorageOperation<
    {
      ...PrefixParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...TimeoutParameter;

      /** Include this parameter to specify that the container's metadata be returned as part of the response body. */
      @query include?: Array<ListContainersIncludeType>;
    },
    ListContainersSegmentResponse
  >;

  /** Retrieves a user delegation key for the Blob service. This is only a valid operation when using bearer token authentication. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @post
  @route("?restype=service&comp=userdelegationkey")
  op getUserDelegationKey is StorageOperation<
    {
      /** Key information provided in the request */
      @body
      keyInfo: KeyInfo;

      ...TimeoutParameter;
    },
    {
      /** The user delegation key */
      @body
      userDelegationKey: UserDelegationKey;

      ...DateResponseHeader;
    }
  >;

  /** Returns the sku name and account kind. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @get
  @route("?restype=account&comp=properties")
  op getAccountInfo is StorageOperation<
    TimeoutParameter,
    {
      ...DateResponseHeader;
      ...SkuNameResponseHeader;
      ...AccountKindResponseHeader;

      /** Version 2019-07-07 and newer. Indicates if the account has a hierarchical namespace enabled. */
      @header("x-ms-is-hns-enabled")
      isHierarchicalNamespaceEnabled?: boolean;
    }
  >;

  /** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @route("?comp=batch")
  op submitBatch(
    /** Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID> */
    @header("Content-Type")
    multipartContentType: "multipart/mixed",

    ...ApiVersionHeader,
    ...TimeoutParameter,
    ...ClientRequestIdHeader,
    ...ContentLengthParameter,
    ...MultipartBodyParameter,
  ): (MultipartBodyParameter & {
    /** The media type of the body of the response. For batch requests, this is multipart/mixed; boundary=batchresponse_GUID */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: "multipart/mixed";

    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
  }) | StorageError;

  /** The Filter Blobs operation enables callers to list blobs across all containers whose tags match a given search expression. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("?comp=blobs")
  op filterBlobs is StorageOperation<
    {
      ...TimeoutParameter;
      ...FilterBlobsWhereParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...FilterBlobsIncludeParameter;
    },
    {
      ...DateResponseHeader;

      /** The filter blobs enumeration results */
      @body
      enumerationResults: FilterBlobSegment;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  namespace Container {
    /** Creates a new container under the specified account. If the container with the same name already exists, the operation fails. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    @put
    @route("{containerName}?restype=container")
    op create is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...TimeoutParameter;
        ...MetadataHeaders;
        ...BlobPublicAccess;

        /** Optional.  Version 2019-07-07 and later.  Specifies the default encryption scope to set on the container and use for all future writes. */
        @header("x-ms-default-encryption-scope")
        defaultEncryptionScope?: string;

        ...DenyEncryptionScopeOverride;
      },
      {
        @statusCode statusCode: 201;
        ...EtagResponseHeaderPrivate;
        ...LastModifiedResponseHeaderPrivate;
        ...DateResponseHeaderPrivate;
      }
    >;

    /** returns all user-defined metadata and system properties for the specified container. The data returned does not include the container's list of blobs */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    @get
    @route("{containerName}?restype=container")
    op getProperties is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...TimeoutParameter;
        ...LeaseIdOptionalParameter;
      },
      {
        ...MetadataHeaders;
        ...EtagResponseHeader;
        ...LastModifiedResponseHeader;
        ...DateResponseHeaderPrivate;
        ...LeaseDurationResponseHeader;
        ...LeaseStateResponseHeader;
        ...LeaseStatusResponseHeader;
        ...BlobPublicAccess;

        /** Indicates whether the container has an immutability policy set on it. */
        @header("x-ms-has-immutability-policy")
        hasImmutabilityPolicy?: boolean;

        /** Indicates whether the container has a legal hold. */
        @header("x-ms-has-legal-hold")
        hasLegalHold?: boolean;

        /** The default encryption scope for the container. */
        @header("x-ms-default-encryption-scope")
        defaultEncryptionScope?: string;

        ...DenyEncryptionScopeOverride;

        /** Indicates whether version level worm is enabled on a container */
        @header("x-ms-immutable-storage-with-versioning-enabled")
        isImmutableStorageWithVersioningEnabled?: boolean;
      }
    >;

    /** operation marks the specified container for deletion. The container and any blobs contained within it are later deleted during garbage collection */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    @delete
    @route("{containerName}?restype=container")
    op delete is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...TimeoutParameter;
        ...LeaseIdOptionalParameter;
        ...IfModifiedSinceParameter;
        ...IfUnmodifiedSinceParameter;
      },
      {
        @statusCode statusCode: 202;
      }
    >;

    /** operation sets one or more user-defined name-value pairs for the specified container. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @put
    @route("{containerName}?restype=container&comp=metadata")
    op setMetadata is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...TimeoutParameter;
        ...LeaseIdOptionalParameter;
        ...MetadataHeaders;
        ...IfModifiedSinceParameter;
      },
      {
        ...EtagResponseHeaderPrivate;
        ...LastModifiedResponseHeaderPrivate;
        ...DateResponseHeaderPrivate;
      }
    >;

    /** gets the permissions for the specified container. The permissions indicate whether container data may be accessed publicly. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @get
    @route("{containerName}?restype=container&comp=acl")
    op getAccessPolicy is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...TimeoutParameter;
        ...LeaseIdOptionalParameter;
      },
      {
        /** Signed identifiers */
        @body body: SignedIdentifiers;

        ...BlobPublicAccess;
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
    @route("{containerName}?restype=container&comp=acl")
    op setAccessPolicy is StorageOperation<
      {
        ...ContainerNamePathParameter;

        /** The access control list for the container. */
        #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
        @body
        containerAcl: SignedIdentifiers;

        ...TimeoutParameter;
        ...LeaseIdOptionalParameter;
        ...BlobPublicAccess;
        ...IfModifiedSinceParameter;
        ...IfUnmodifiedSinceParameter;
      },
      {
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
    @route("{containerName}?restype=container&comp=undelete")
    op restore is StorageOperation<
      {
        ...ContainerNamePathParameter;

        /** Optional.  Version 2019-12-12 and later.  Specifies the name of the deleted container to restore. */
        @header("x-ms-deleted-container-name")
        deletedContainerName?: string;

        /** Optional.  Version 2019-12-12 and later.  Specifies the version of the deleted container to restore. */
        @header("x-ms-deleted-container-version")
        deletedContainerVersion?: string;

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
    @route("{containerName}?restype=container&comp=rename")
    op rename is StorageOperation<
      {
        ...ContainerNamePathParameter;

        /** Required.  Specifies the name of the container to rename. */
        @header("x-ms-source-container-name")
        sourceContainerName: string;

        /** A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match. */
        @header("x-ms-source-lease-id")
        sourceLeaseId?: string;

        ...TimeoutParameter;
      },
      DateResponseHeader
    >;

    /** The Batch operation allows multiple API calls to be embedded into a single HTTP request. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    @post
    @route("{containerName}?restype=container&comp=batch")
    op submitBatch(
      ...ContainerNamePathParameter,

      /** The batch request content */
      ...MultipartBodyParameter,

      /** Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID> */
      @header("Content-Type")
      multipartContentType: "multipart/mixed",

      ...ContentLengthParameter,
      ...TimeoutParameter,
      ...ApiVersionHeader,
      ...ClientRequestIdHeader,
    ): ({
      @statusCode statusCode: 202;

      /** Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID> */
      @header("Content-Type")
      multipartContentType: "multipart/mixed";

      ...RequestIdResponseHeader;
      ...ApiVersionHeader;
    } & MultipartBodyParameter) | StorageError;

    /** The Filter Blobs operation enables callers to list blobs in a container whose tags match a given search expression.  Filter blobs searches within the given container. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @get
    @route("{containerName}?restype=container&comp=blobs")
    op filterBlobs is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...TimeoutParameter;
        ...FilterBlobsWhereParameter;
        ...MarkerParameter;
        ...MaxResultsParameter;
        ...FilterBlobsIncludeParameter;
      },
      {
        ...DateResponseHeader;

        /** The container filter blob enumeration results */
        @body
        enumerationResults: FilterBlobSegment;
      }
    >;

    /** The Acquire Lease operation requests a new lease on a container. The lease lock duration can be 15 to 60 seconds, or can be infinite. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @put
    @route("{containerName}?comp=lease&restype=container&acquire")
    op acquireLease is StorageOperationNoBody<
      {
        ...ContainerNamePathParameter;
        ...LeaseDurationHeaderParameter;
        ...TimeoutParameter;
        ...ProposedLeaseIdOptionalParameter;
        ...IfModifiedSinceParameter;
        ...IfUnmodifiedSinceParameter;
        ...LeaseActionParameter<"acquire">;
      },
      {
        @statusCode statusCode: 201;
        ...LeaseIdResponseHeader;
        ...EtagResponseHeader;
        ...LastModifiedResponseHeader;
        ...DateResponseHeaderPrivate;
      }
    >;

    /** The Release Lease operation frees the lease if it's no longer needed, so that another client can immediately acquire a lease against the container. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @put
    @route("{containerName}?comp=lease&restype=container&release")
    op releaseLease is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...LeaseIdRequiredParameter;
        ...TimeoutParameter;
        ...IfModifiedSinceParameter;
        ...IfUnmodifiedSinceParameter;
        ...LeaseActionParameter<"release">;
      },
      {
        ...EtagResponseHeader;
        ...LastModifiedResponseHeader;
        ...DateResponseHeaderPrivate;
      }
    >;

    /** The Renew Lease operation renews an existing lease. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @put
    @route("{containerName}?comp=lease&restype=container&renew")
    op renewLease is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...LeaseIdRequiredParameter;
        ...TimeoutParameter;
        ...IfModifiedSinceParameter;
        ...IfUnmodifiedSinceParameter;
        ...LeaseActionParameter<"renew">;
      },
      {
        ...LeaseIdResponseHeader;
        ...EtagResponseHeader;
        ...LastModifiedResponseHeader;
        ...DateResponseHeaderPrivate;
      }
    >;

    /** The Break Lease operation ends a lease and ensures that another client can't acquire a new lease until the current lease period has expired. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    @put
    @route("{containerName}?comp=lease&restype=container&break")
    op breakLease is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...TimeoutParameter;
        ...IfModifiedSinceParameter;
        ...IfUnmodifiedSinceParameter;
        ...LeaseBreakPeriodParameter;
        ...LeaseActionParameter<"break">;
      },
      {
        @statusCode statusCode: 202;
        ...LeaseTimeResponseHeader;
        ...EtagResponseHeader;
        ...LastModifiedResponseHeader;
        ...DateResponseHeaderPrivate;
      }
    >;

    /** The Change Lease operation is used to change the ID of an existing lease. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @put
    @route("{containerName}?comp=lease&restype=container&change")
    op changeLease is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...LeaseIdRequiredParameter;
        ...ProposedLeaseIdRequiredParameter;
        ...TimeoutParameter;
        ...IfModifiedSinceParameter;
        ...IfUnmodifiedSinceParameter;
        ...LeaseActionParameter<"change">;
      },
      {
        ...LeaseIdResponseHeader;
        ...EtagResponseHeader;
        ...LastModifiedResponseHeader;
        ...DateResponseHeaderPrivate;
      }
    >;

    /** The List Blobs operation returns a list of the blobs under the specified container. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @get
    @list
    @route("{containerName}?restype=container&comp=list&flat")
    op listBlobFlatSegment is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...PrefixParameter;
        ...MarkerParameter;
        ...MaxResultsParameter;
        ...ListBlobsIncludeParameter;
        ...TimeoutParameter;
        ...ListBlobsStartFrom;
      },
      {
        ...DateResponseHeader;

        /** The list of blobs in the container */
        @body
        enumerationResults: ListBlobsFlatSegmentResponse;
      }
    >;

    /** The List Blobs operation returns a list of the blobs under the specified container. A delimiter can be used to traverse a virtual hierarchy of blobs as though it were a file system. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @get
    @list
    @route("{containerName}?restype=container&comp=list&hierarchy")
    op listBlobHierarchySegment is StorageOperation<
      {
        ...ContainerNamePathParameter;

        /** When the request includes this parameter, the operation returns a BlobPrefix element in the response body that acts as a placeholder for all blobs whose names begin with the same substring up to the appearance of the delimiter character. The delimiter may be a single character or a string. */
        @query delimiter: string;

        ...PrefixParameter;
        ...MarkerParameter;
        ...MaxResultsParameter;
        ...ListBlobsIncludeParameter;
        ...TimeoutParameter;
        ...ListBlobsStartFrom;
      },
      {
        ...DateResponseHeader;

        /** The list of blobs in the container */
        @body
        enumerationResults: ListBlobsHierarchySegmentResponse;
      }
    >;

    /** Returns the sku name and account kind */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
    @get
    @route("{containerName}?restype=account&comp=properties")
    op getAccountInfo is StorageOperation<
      {
        ...ContainerNamePathParameter;
        ...TimeoutParameter;
      },
      {
        ...DateResponseHeader;
        ...SkuNameResponseHeader;
        ...AccountKindResponseHeader;
        ...IsHierarchicalNamespaceEnabled;
      }
    >;

    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    @route("{containerName}")
    namespace Blob {
      /** The Download operation reads or downloads a blob from the system, including its metadata and properties. You can also call Download to read a snapshot. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      @get
      @route("{blobName}")
      op download(
        ...ApiVersionHeader,
        ...ClientRequestIdHeader,
        ...ContainerNamePathParameter,
        ...BlobPathParameter,
        ...SnapshotParameter,
        ...VersionIdParameter,
        ...TimeoutParameter,
        ...RangeParameter,
        ...LeaseIdOptionalParameter,

        /** When set to true and specified together with the Range, the service returns the MD5 hash for the range, as long as the range is less than or equal to 4 MB in size. */
        @header("x-ms-range-get-content-md5")
        rangeGetContentMd5?: boolean,

        /** Optional.  When this header is set to true and specified together with the Range header, the service returns the CRC64 hash for the range, as long as the range is less than or equal to 4 MB in size. */
        @header("x-ms-range-get-content-crc64")
        rangeGetContentCrc64?: boolean,

        /** Specifies the response content should be returned as a structured message and specifies the message schema version and properties. */
        @access(Access.internal)
        @header("x-ms-structured-body")
        structuredBodyType?: string,

        ...EncryptionKeyParameter,
        ...EncryptionKeySha256Parameter,
        ...EncryptionAlgorithmParameter,
        ...IfTagsParameter,
        ...ConditionalRequestHeaders,
      ): (BodyParameter & {
        /** The media type of the body of the response. */
        @header("Content-Type")
        contentType: "application/octet-stream";

        ...RequestIdResponseHeader;
        ...ClientRequestIdHeader;
        ...MetadataHeaders;
        ...ObjectReplicationHeaders;
        ...LastModifiedResponseHeader;
        ...CreationTimeResponseHeader;
        ...ObjectReplicationPolicyIdResponseHeader;
        ...ContentLengthResponseHeader;
        ...ContentRangeResponseHeader;
        ...EtagResponseHeader;
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
        ...AcceptRangesResponseHeaderPrivate;
        ...DateResponseHeaderPrivate;
        ...BlobCommittedBlockCountResponseHeader;
        ...ServerEncryptedResponseHeader;
        ...EncryptionKeySha256ResponseHeader;
        ...EncryptionScopeResponseHeader;
        ...BlobContentMd5ResponseHeader;
        ...TagCountResponseHeader;
        ...IsSealedResponseHeader;
        ...LastAccessedResponseHeader;
        ...ImmutabilityPolicyExpiresOnResponseHeader;
        ...ImmutabilityPolicyModeResponseHeader;
        ...LegalHoldResponseHeader;
        ...StructuredBodyTypeResponseHeader;
        ...StructuredContentLengthResponseHeader;
        ...ApiVersionHeader;
      }) | (BodyParameter & {
        #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard pattern"
        @statusCode statusCode: 206;

        /** The media type of the body of the response. */
        @header("Content-Type")
        contentType: "application/octet-stream";

        ...RequestIdResponseHeader;
        ...ClientRequestIdHeader;
        ...MetadataHeaders;
        ...ObjectReplicationHeaders;
        ...LastModifiedResponseHeader;
        ...CreationTimeResponseHeader;
        ...ObjectReplicationPolicyIdResponseHeader;
        ...ContentLengthResponseHeader;
        ...ContentRangeResponseHeader;
        ...EtagResponseHeader;
        ...ContentMd5ResponseHeader;
        ...ContentEncodingResponseParameter;
        ...CacheControlResponseHeader;
        ...ContentDispositionResponseHeader;
        ...ContentLanguageResponseHeader;
        ...BlobSequenceNumberResponseHeader;
        ...BlobTypeResponseHeader;
        ...ContentCrc64ResponseHeader;
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
        ...AcceptRangesResponseHeaderPrivate;
        ...DateResponseHeaderPrivate;
        ...BlobCommittedBlockCountResponseHeader;
        ...ServerEncryptedResponseHeader;
        ...EncryptionKeySha256ResponseHeader;
        ...EncryptionScopeResponseHeader;
        ...BlobContentMd5ResponseHeader;
        ...TagCountResponseHeader;
        ...IsSealedResponseHeader;
        ...LastAccessedResponseHeader;
        ...ImmutabilityPolicyExpiresOnResponseHeader;
        ...ImmutabilityPolicyModeResponseHeader;
        ...LegalHoldResponseHeader;
        ...StructuredBodyTypeResponseHeader;
        ...StructuredContentLengthResponseHeader;
        ...ApiVersionHeader;
      }) | StorageError;

      /** The Get Properties operation returns all user-defined metadata, standard HTTP properties, and system properties for the blob. It does not return the content of the blob. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      @head
      @route("{blobName}")
      op getProperties is StorageOperationNoBody<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...SnapshotParameter;
          ...VersionIdParameter;
          ...TimeoutParameter;
          ...LeaseIdOptionalParameter;
          ...EncryptionKeyParameter;
          ...EncryptionKeySha256Parameter;
          ...EncryptionAlgorithmParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
        },
        {
          ...MetadataHeaders;
          ...ObjectReplicationHeaders;
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

          /** Included if the blob is incremental copy blob. */
          @header("x-ms-incremental-copy")
          isIncrementalCopy?: boolean;

          /** Included if the blob is incremental copy blob or incremental copy snapshot, if x-ms-copy-status is success. Snapshot time of the last successful incremental copy snapshot for this blob. */
          @header("x-ms-copy-destination-snapshot")
          destinationSnapshot?: string;

          ...LeaseDurationResponseHeader;
          ...LeaseStateResponseHeader;
          ...LeaseStatusResponseHeader;
          ...ContentLengthResponseHeader;
          ...EtagResponseHeader;
          ...ContentMd5ResponseHeader;
          ...ContentEncodingResponseParameter;
          ...ContentDispositionResponseHeader;
          ...ContentLanguageResponseHeader;
          ...CacheControlResponseHeader;
          ...BlobSequenceNumberResponseHeader;
          ...DateResponseHeaderPrivate;
          ...AcceptRangesResponseHeaderPrivate;
          ...BlobCommittedBlockCountResponseHeader;
          ...ServerEncryptedResponseHeader;
          ...EncryptionKeySha256ResponseHeader;
          ...EncryptionScopeResponseHeader;

          /** The tier of page blob on a premium storage account or tier of block blob on blob storage LRS accounts. For a list of allowed premium page blob tiers, see https://learn.microsoft.com/azure/virtual-machines/disks-types#premium-ssd. For blob storage LRS accounts, valid values are Hot/Cool/Archive. */
          @header("x-ms-access-tier")
          accessTier?: string;

          /** For page blobs on a premium storage account only. If the access tier is not explicitly set on the blob, the tier is inferred based on its content length and this header will be returned with true value. */
          @header("x-ms-access-tier-inferred")
          accessTierInferred?: boolean;

          /** For blob storage LRS accounts, valid values are rehydrate-pending-to-hot/rehydrate-pending-to-cool. If the blob is being rehydrated and is not complete then this header is returned indicating that rehydrate is pending and also tells the destination tier. */
          @header("x-ms-archive-status")
          archiveStatus?: ArchiveStatus;

          /** The time the tier was changed on the object. This is only returned if the tier on the block blob was ever set. */
          #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
          @encode("rfc7231")
          @header("x-ms-access-tier-change-time")
          accessTierChangeTime?: utcDateTime;

          ...VersionIdResponseHeader;
          ...IsCurrentVersionResponseHeader;
          ...TagCountResponseHeader;
          ...ExpiryTimeHeader;
          ...IsSealedResponseHeader;
          ...RehydratePriorityHeader;
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
      @route("{blobName}")
      op delete is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
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
        },
        {
          @statusCode statusCode: 202;
          ...DateResponseHeaderPrivate;
        }
      >;

      /** Undelete a blob that was previously soft deleted */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      @put
      @route("{blobName}?comp=undelete")
      op undelete is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
        },
        DateResponseHeader
      >;

      /** Set the expiration time of a blob */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      @put
      @route("{blobName}?comp=expiry")
      op setExpiry is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...BlobExpiryOptionsParameter;
          ...ExpiryTimeHeader;
        },
        {
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
      @route("{blobName}?comp=properties&SetHTTPHeaders")
      op setProperties is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
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
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
        },
        {
          ...EtagResponseHeaderPrivate;
          ...LastModifiedResponseHeaderPrivate;
          ...BlobSequenceNumberResponseHeaderPrivate;
          ...DateResponseHeaderPrivate;
        }
      >;

      /** Set the immutability policy of a blob */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      @put
      @route("{blobName}?comp=immutabilityPolicies")
      op setImmutabilityPolicy is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...IfUnmodifiedSinceParameter;
          ...ImmutabilityPolicyExpiryParameter;
          ...ImmutabilityPolicyModeParameter;
          ...SnapshotParameter;
          ...VersionIdParameter;
        },
        {
          ...DateResponseHeader;
          ...ImmutabilityPolicyExpiresOnResponseHeader;
          ...ImmutabilityPolicyModeResponseHeader;
        }
      >;

      /** The Delete Immutability Policy operation deletes the immutability policy on the blob. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      @delete
      @route("{blobName}?comp=immutabilityPolicies")
      op deleteImmutabilityPolicy is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...SnapshotParameter;
          ...VersionIdParameter;
        },
        DateResponseHeader
      >;

      /** The Set Legal Hold operation sets a legal hold on the blob. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      @put
      @route("{blobName}?comp=legalhold")
      op setLegalHold is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...LegalHoldRequiredParameter;
          ...SnapshotParameter;
          ...VersionIdParameter;
        },
        {
          ...DateResponseHeader;
          ...LegalHoldResponseHeader;
        }
      >;

      /** The Set Metadata operation sets user-defined metadata for the specified blob as one or more name-value pairs. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      @put
      @route("{blobName}?comp=metadata")
      op setMetadata is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...MetadataHeaders;
          ...LeaseIdOptionalParameter;
          ...EncryptionKeyParameter;
          ...EncryptionKeySha256Parameter;
          ...EncryptionAlgorithmParameter;
          ...EncryptionScopeParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
        },
        {
          ...EtagResponseHeaderPrivate;
          ...LastModifiedResponseHeaderPrivate;
          ...VersionIdResponseHeaderPrivate;
          ...DateResponseHeaderPrivate;
          ...RequestServerEncryptedResponseHeaderPrivate;
          ...EncryptionKeySha256ResponseHeaderPrivate;
          ...EncryptionScopeResponseHeaderPrivate;
        }
      >;

      /** The Acquire Lease operation requests a new lease on a blob. The lease lock duration can be 15 to 60 seconds, or can be infinite. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      @put
      @route("{blobName}?comp=lease&acquire")
      op acquireLease is StorageOperationNoBody<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...LeaseDurationHeaderParameter;
          ...ProposedLeaseIdOptionalParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
          ...LeaseActionParameter<"acquire">;
        },
        {
          @statusCode statusCode: 201;
          ...EtagResponseHeader;
          ...LastModifiedResponseHeader;
          ...LeaseIdResponseHeader;
          ...DateResponseHeaderPrivate;
        }
      >;

      /** The Release Lease operation frees the lease if it's no longer needed, so that another client can immediately acquire a lease against the blob. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      @put
      @route("{blobName}?comp=lease&release")
      op releaseLease is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...LeaseIdRequiredParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
          ...LeaseActionParameter<"release">;
        },
        {
          ...EtagResponseHeader;
          ...LastModifiedResponseHeader;
          ...DateResponseHeaderPrivate;
        }
      >;

      /** The Renew Lease operation renews an existing lease. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      @put
      @route("{blobName}?comp=lease&renew")
      op renewLease is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...LeaseIdRequiredParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
          ...LeaseActionParameter<"renew">;
        },
        {
          ...EtagResponseHeader;
          ...LastModifiedResponseHeader;
          ...LeaseIdResponseHeader;
          ...DateResponseHeaderPrivate;
        }
      >;

      /** The Change Lease operation is used to change the ID of an existing lease. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
      @put
      @route("{blobName}?comp=lease&change")
      op changeLease is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...LeaseIdRequiredParameter;
          ...ProposedLeaseIdRequiredParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
          ...LeaseActionParameter<"change">;
        },
        {
          ...EtagResponseHeader;
          ...LastModifiedResponseHeader;
          ...LeaseIdResponseHeader;
          ...DateResponseHeaderPrivate;
        }
      >;

      /** The Break Lease operation ends a lease and ensures that another client can't acquire a new lease until the current lease period has expired. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      @put
      @sharedRoute
      @route("{blobName}?comp=lease&break")
      op breakLease is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...LeaseBreakPeriodParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
          ...LeaseActionParameter<"break">;
        },
        {
          @statusCode statusCode: 202;
          ...EtagResponseHeader;
          ...LastModifiedResponseHeader;
          ...LeaseTimeResponseHeader;
          ...DateResponseHeaderPrivate;
        }
      >;

      /** The Create Snapshot operation creates a read-only snapshot of a blob */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      @put
      @sharedRoute
      @route("{blobName}?comp=snapshot")
      op createSnapshot is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...MetadataHeaders;
          ...EncryptionKeyParameter;
          ...EncryptionKeySha256Parameter;
          ...EncryptionAlgorithmParameter;
          ...EncryptionScopeParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
          ...LeaseIdOptionalParameter;
        },
        {
          @statusCode statusCode: 201;

          /** Uniquely identifies the snapshot and indicates the snapshot version. It may be used in subsequent requests to access the snapshot. */
          @header("x-ms-snapshot")
          snapshot?: string;

          ...EtagResponseHeader;
          ...LastModifiedResponseHeader;
          ...VersionIdResponseHeader;
          ...DateResponseHeader;
          ...RequestServerEncryptedResponseHeader;
        }
      >;

      /** The Start Copy From URL operation copies a blob or an internet resource to a new blob. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
      @put
      @sharedRoute
      @route("{blobName}")
      op startCopyFromUrl is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...MetadataHeaders;
          ...AccessTierHeader;
          ...RehydratePriorityHeader;
          ...SourceIfModifiedSinceParameter;
          ...SourceIfUnmodifiedSinceParameter;
          ...SourceIfMatchParameter;
          ...SourceIfNoneMatchParameter;
          ...SourceIfTagsParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
          ...IfTagsParameter;
          ...CopySourceParameter;
          ...LeaseIdOptionalParameter;
          ...BlobTagsHeaderParameter;

          /** Overrides the sealed state of the destination blob.  Service version 2019-12-12 and newer. */
          @header("x-ms-seal-blob")
          sealBlob?: boolean;

          ...ImmutabilityPolicyExpiryParameter;
          ...ImmutabilityPolicyModeParameter;
          ...LegalHoldOptionalParameter;

          /** This header indicates that this is a synchronous Copy Blob From URL instead of a Asynchronous Copy Blob. */
          @header("x-ms-requires-sync")
          requiresSync: true;
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
      @sharedRoute
      @route("{blobName}?comp=copy&sync")
      op copyFromUrl is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...MetadataHeaders;
          ...AccessTierHeader;
          ...SourceIfModifiedSinceParameter;
          ...SourceIfUnmodifiedSinceParameter;
          ...SourceIfMatchParameter;
          ...SourceIfNoneMatchParameter;
          ...IfModifiedSinceParameter;
          ...IfUnmodifiedSinceParameter;
          ...IfNoneMatchParameter;
          ...IfMatchParameter;
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
          ...FileRequestIntentParameter;

          /** This header indicates that this is a synchronous Copy Blob From URL instead of a Asynchronous Copy Blob. */
          @header("x-ms-requires-sync")
          requiresSync: "true";
        },
        {
          @statusCode statusCode: 202;
          ...EtagResponseHeader;
          ...LastModifiedResponseHeader;
          ...VersionIdResponseHeader;
          ...DateResponseHeader;
          ...CopyIdResponseHeader;

          /** State of the copy operation identified by x-ms-copy-id. */
          @header("x-ms-copy-status")
          copyStatus?: "success";

          ...ContentMd5ResponseHeader;
          ...ContentCrc64ResponseHeader;
          ...EncryptionScopeResponseHeader;
        }
      >;

      /** The Abort Copy From URL operation aborts a pending Copy From URL operation, and leaves a destination blob with zero length and full metadata. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      @put
      @sharedRoute
      @route("{blobName}?comp=copy&copyid")
      op abortCopyFromUrl is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;

          /** The copy identifier provided in the x-ms-copy-id header of the original Copy Blob operation. */
          @clientName("copyId")
          @query
          copyid: string;

          ...LeaseIdOptionalParameter;

          /** The copy action to be performed. */
          @header("x-ms-copy-action")
          copyActionAbortConstant: "abort";
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
      @sharedRoute
      @route("{blobName}?comp=tier")
      op setTier is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...SnapshotParameter;
          ...VersionIdParameter;
          ...TimeoutParameter;

          /** Indicates the tier to be set on the blob. */
          @header("x-ms-access-tier")
          tier: AccessTier;

          ...RehydratePriorityHeader;
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
      @sharedRoute
      @route("{blobName}?restype=account&comp=properties&blob")
      op getAccountInfo is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
        },
        {
          ...DateResponseHeader;
          ...AccountKindResponseHeader;
          ...SkuNameResponseHeader;
          ...IsHierarchicalNamespaceEnabled;
        }
      >;

      /** The Get Blob Tags operation enables users to get tags on a blob. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      @get
      @sharedRoute
      @route("{blobName}?comp=tags")
      op getTags is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...SnapshotParameter;
          ...VersionIdParameter;
          ...LeaseIdOptionalParameter;
          ...IfTagsParameter;
          ...IfBlobModifiedSinceHeader;
          ...IfBlobUnmodifiedSinceHeader;
          ...IfBlobMatchHeader;
          ...IfBlobNoneMatchHeader;
        },
        {
          ...DateResponseHeader;

          /** The blob tags. */
          @body
          tags: BlobTags;
        }
      >;

      /** The Set Tags operation enables users to set tags on a blob. */
      #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
      @put
      @route("{blobName}?comp=tags")
      op setTags is StorageOperation<
        {
          ...ContainerNamePathParameter;
          ...BlobPathParameter;
          ...TimeoutParameter;
          ...VersionIdParameter;
          ...ContentMd5Parameter;
          ...ContentCrc64Parameter;
          ...IfTagsParameter;
          ...LeaseIdOptionalParameter;

          /** The blob tags. */
          @body
          tags: BlobTags;

          ...IfBlobModifiedSinceHeader;
          ...IfBlobUnmodifiedSinceHeader;
          ...IfBlobMatchHeader;
          ...IfBlobNoneMatchHeader;
        },
        {
          @statusCode statusCode: 204;
          ...DateResponseHeader;
        }
      >;

      #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
      namespace PageBlob {
        /** The Create operation creates a new page blob. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}")
        op create is StorageOperationNoBody<
          {
            ...MetadataHeaders;
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...TimeoutParameter;

            /** Optional. Indicates the tier to be set on the page blob. */
            @header("x-ms-access-tier")
            tier?: PremiumPageBlobAccessTier;

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
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...BlobContentLengthRequired;
            ...SequenceNumberParameter;
            ...BlobTagsHeaderParameter;
            ...ImmutabilityPolicyExpiryParameter;
            ...ImmutabilityPolicyModeParameter;
            ...LegalHoldOptionalParameter;

            /** the initial size of the page blob */
            @header("Content-Length")
            contentLength: 0;

            /** The type of the blob. */
            @header("x-ms-blob-type")
            blobType: "PageBlob";
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...VersionIdResponseHeader;
            ...DateResponseHeaderPrivate;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
          }
        >;

        /** The Upload Pages operation writes a range of pages to a page blob */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=page&update")
        op uploadPages is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;

            /** The data to upload. */
            ...BodyParameter;

            ...ContentLengthParameter;
            ...ContentMd5Parameter;
            ...ContentCrc64Parameter;
            ...TimeoutParameter;

            /** Bytes of data in the specified range. */
            @header("Range")
            range: string;

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
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...StructuredBodyParameter;
            ...StructuredContentLengthParameter;
            ...PageWriteParameter<"update">;
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...ContentCrc64ResponseHeader;
            ...BlobSequenceNumberResponseHeader;
            ...DateResponseHeaderPrivate;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
            ...StructuredBodyTypeResponseHeader;
          },
          "application/octet-stream"
        >;

        /** The Clear Pages operation clears a range of pages from a page blob */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=page&clear")
        op clearPages is StorageOperationNoBody<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;

            /** value must be 0 when x-ms-page-write is clear */
            @header("Content-Length")
            contentLength: 0;

            ...TimeoutParameter;

            /** Bytes of data in the specified range. */
            @header("Range")
            range: string;

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
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...PageWriteParameter<"clear">;
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...ContentCrc64ResponseHeader;
            ...BlobSequenceNumberResponseHeader;
            ...DateResponseHeaderPrivate;
          }
        >;

        /** The Upload Pages operation writes a range of pages to a page blob where the contents are read from a URL. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=page&update&fromUrl")
        op uploadPagesFromUrl is StorageOperationNoBody<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...SourceUrlParameter;

            /** Bytes of source data in the specified range. The length of this range should match the ContentLength header and x-ms-range/Range destination range header. */
            @header("x-ms-source-range")
            sourceRange: string;

            ...SourceContentMd5Parameter;
            ...SourceContentCrc64Parameter;
            ...ContentLengthParameter;
            ...TimeoutParameter;

            /** Bytes of source data in the specified range. The length of this range should match the ContentLength header and x-ms-range/Range destination range header. */
            @header("x-ms-range")
            range: string;

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
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...SourceIfModifiedSinceParameter;
            ...SourceIfUnmodifiedSinceParameter;
            ...SourceIfMatchParameter;
            ...SourceIfNoneMatchParameter;
            ...CopySourceAuthorizationParameter;
            ...FileRequestIntentParameter;
            ...PageWriteParameter<"update">;
            ...SourceEncryptionKeyParameter;
            ...SourceEncryptionKeySha256Parameter;
            ...SourceEncryptionAlgorithmParameter;
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...ContentCrc64ResponseHeader;
            ...BlobSequenceNumberResponseHeader;
            ...DateResponseHeaderPrivate;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
          }
        >;

        /** The Get Page Ranges operation returns the list of valid page ranges for a page blob or snapshot of a page blob. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @get
        @route("{blobName}?comp=pagelist")
        op getPageRanges is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...SnapshotParameter;
            ...TimeoutParameter;
            ...RangeParameter;
            ...LeaseIdOptionalParameter;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...MarkerParameter;
            ...MaxResultsParameter;
          },
          PageList & {
            ...LastModifiedResponseHeader;
            ...EtagResponseHeader;
            ...BlobContentLengthResponseHeader;
            ...DateResponseHeader;
          }
        >;

        /** The Get Page Ranges Diff operation returns the list of valid page ranges for a page blob or snapshot of a page blob. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @get
        @route("{blobName}?comp=pagelist&diff")
        op getPageRangesDiff is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...SnapshotParameter;
            ...TimeoutParameter;

            /** Optional in version 2015-07-08 and newer. The prevsnapshot parameter is a DateTime value that specifies that the response will contain only pages that were changed between target blob and previous snapshot. Changed pages include both updated and cleared pages. The target blob may be a snapshot, as long as the snapshot specified by prevsnapshot is the older of the two. Note that incremental snapshots are currently supported only for blobs created on or after January 1, 2016. */
            @query
            prevsnapshot?: string;

            /** Optional. This header is only supported in service versions 2019-04-19 and after and specifies the URL of a previous snapshot of the target blob. The response will only contain pages that were changed between the target blob and its previous snapshot. */
            @header("x-ms-previous-snapshot-url")
            prevSnapshotUrl?: string;

            ...RangeParameter;
            ...LeaseIdOptionalParameter;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...MarkerParameter;
            ...MaxResultsParameter;
          },
          PageList & {
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
        @sharedRoute
        @route("{blobName}?comp=properties&Resize")
        op resize is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...TimeoutParameter;
            ...LeaseIdOptionalParameter;
            ...EncryptionKeyParameter;
            ...EncryptionKeySha256Parameter;
            ...EncryptionAlgorithmParameter;
            ...EncryptionScopeParameter;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...BlobContentLengthRequired;
          },
          {
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...BlobSequenceNumberResponseHeader;
            ...DateResponseHeaderPrivate;
          }
        >;

        /** The Update Sequence Number operation sets the blob's sequence number. The operation will fail if the specified sequence number is less than the current sequence number of the blob. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=properties&UpdateSequenceNumber")
        op setSequenceNumber is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...TimeoutParameter;
            ...LeaseIdOptionalParameter;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...SequenceNumberActionParameter;
            ...SequenceNumberParameter;
          },
          {
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...BlobSequenceNumberResponseHeader;
            ...DateResponseHeaderPrivate;
          }
        >;

        /** The Copy Incremental operation copies a snapshot of the source page blob to a destination page blob. The snapshot is copied such that only the differential changes between the previously copied snapshot are transferred to the destination. The copied snapshots are complete copies of the original snapshot and can be read or copied from as usual. This API is supported since REST version 2016-05-31. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=incrementalcopy")
        op copyIncremental is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...TimeoutParameter;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
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
      namespace AppendBlob {
        /** The Create operation creates a new append blob. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}")
        op create is StorageOperationNoBody<
          {
            ...MetadataHeaders;
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...TimeoutParameter;
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
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...BlobTagsHeaderParameter;
            ...ImmutabilityPolicyExpiryParameter;
            ...ImmutabilityPolicyModeParameter;
            ...LegalHoldOptionalParameter;

            /** the initial size of the append blob */
            @header("Content-Length")
            contentLength: 0;

            /** The type of the blob. */
            @header("x-ms-blob-type")
            blobType: "AppendBlob";
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...VersionIdResponseHeader;
            ...DateResponseHeaderPrivate;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
          }
        >;

        /** The Append Block operation commits a new block of data to the end of an append blob. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=appendblock")
        op appendBlock is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;

            /** The data to upload. */
            ...BodyParameter;

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
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...StructuredBodyParameter;
            ...StructuredContentLengthParameter;
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...ContentCrc64ResponseHeader;
            ...DateResponseHeaderPrivate;
            ...BlobAppendOffsetResponseHeader;
            ...BlobCommittedBlockCountResponseHeader;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
            ...StructuredBodyTypeResponseHeader;
          },
          "application/octet-stream"
        >;

        /** The Append Block From URL operation creates a new block to be committed as part of an append blob where the contents are read from a URL. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=appendblock&fromUrl")
        op appendBlockFromUrl is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...SourceUrlParameter;
            ...SourceRangeParameter;
            ...SourceContentMd5Parameter;
            ...SourceContentCrc64Parameter;
            ...TimeoutParameter;
            ...ContentLengthParameter;
            ...ContentMd5Parameter;
            ...EncryptionKeyParameter;
            ...EncryptionKeySha256Parameter;
            ...EncryptionAlgorithmParameter;
            ...EncryptionScopeParameter;
            ...LeaseIdOptionalParameter;
            ...BlobConditionMaxSizeParameter;
            ...BlobConditionAppendPosParameter;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...SourceIfModifiedSinceParameter;
            ...SourceIfUnmodifiedSinceParameter;
            ...SourceIfMatchParameter;
            ...SourceIfNoneMatchParameter;
            ...CopySourceAuthorizationParameter;
            ...FileRequestIntentParameter;
            ...SourceEncryptionKeyParameter;
            ...SourceEncryptionKeySha256Parameter;
            ...SourceEncryptionAlgorithmParameter;
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...ContentCrc64ResponseHeader;
            ...DateResponseHeaderPrivate;
            ...BlobAppendOffsetResponseHeader;
            ...BlobCommittedBlockCountResponseHeader;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
          }
        >;

        /** The Seal operation seals the Append Blob to make it read-only. Seal is supported only on version 2019-12-12 version or later. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=seal")
        op seal is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...TimeoutParameter;
            ...LeaseIdOptionalParameter;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...BlobConditionAppendPosParameter;
          },
          {
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...DateResponseHeaderPrivate;
            ...IsSealedResponseHeader;
          }
        >;
      }

      #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
      namespace BlockBlob {
        /** The Upload Block Blob operation updates the content of an existing block blob. Updating an existing block blob overwrites any existing metadata on the blob. Partial updates are not supported with Put Blob; the content of the existing blob is overwritten with the content of the new blob. To perform a partial update of the content of a block blob, use the Put Block List operation. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}")
        op upload is StorageOperation<
          {
            ...MetadataHeaders;
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...BodyParameter;
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
            ...AccessTierHeader;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...BlobTagsHeaderParameter;
            ...ImmutabilityPolicyExpiryParameter;
            ...ImmutabilityPolicyModeParameter;
            ...LegalHoldOptionalParameter;
            ...ContentCrc64Parameter;
            ...StructuredBodyParameter;
            ...StructuredContentLengthParameter;

            /** The type of the blob. */
            @header("x-ms-blob-type")
            blobType: "BlockBlob";
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...VersionIdResponseHeader;
            ...DateResponseHeaderPrivate;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
            ...StructuredBodyTypeResponseHeader;
          },
          "application/octet-stream"
        >;

        /** The Put Blob from URL operation creates a new Block Blob where the contents of the blob are read from a given URL.  This API is supported beginning with the 2020-04-08 version. Partial updates are not supported with Put Blob from URL; the content of an existing blob is overwritten with the content of the new blob.  To perform partial updates to a block blob’s contents using a source URL, use the Put Block from URL API in conjunction with Put Block List. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?BlockBlob&fromUrl")
        op putBlobFromUrl is StorageOperationNoBody<
          {
            ...MetadataHeaders;
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
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
            ...AccessTierHeader;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
            ...SourceIfModifiedSinceParameter;
            ...SourceIfUnmodifiedSinceParameter;
            ...SourceIfMatchParameter;
            ...SourceIfNoneMatchParameter;
            ...SourceIfTagsParameter;
            ...SourceContentMd5Parameter;
            ...BlobTagsHeaderParameter;
            ...CopySourceParameter;
            ...CopySourceBlobPropertiesParameter;
            ...CopySourceAuthorizationParameter;
            ...CopySourceTagsParameter;

            /** The type of the blob. */
            @header("x-ms-blob-type")
            blobType: "BlockBlob";

            ...FileRequestIntentParameter;
            ...SourceEncryptionKeyParameter;
            ...SourceEncryptionKeySha256Parameter;
            ...SourceEncryptionAlgorithmParameter;
          },
          {
            @statusCode statusCode: 201;
            ...EtagResponseHeader;
            ...LastModifiedResponseHeader;
            ...ContentMd5ResponseHeader;
            ...VersionIdResponseHeader;
            ...DateResponseHeader;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
          }
        >;

        /** The Stage Block operation creates a new block to be committed as part of a blob */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=block")
        op stageBlock is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...BlockIdParameter;
            ...ContentLengthParameter;
            ...ContentMd5Parameter;
            ...ContentCrc64Parameter;
            ...BodyParameter;
            ...TimeoutParameter;
            ...LeaseIdOptionalParameter;
            ...EncryptionKeyParameter;
            ...EncryptionKeySha256Parameter;
            ...EncryptionAlgorithmParameter;
            ...EncryptionScopeParameter;
            ...StructuredBodyParameter;
            ...StructuredContentLengthParameter;
          },
          {
            @statusCode statusCode: 201;
            ...DateResponseHeaderPrivate;
            ...ContentMd5ResponseHeader;
            ...ContentCrc64ResponseHeader;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
            ...StructuredBodyTypeResponseHeader;
          },
          "application/octet-stream"
        >;

        /** The Stage Block From URL operation creates a new block to be committed as part of a blob where the contents are read from a URL. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=block&fromURL")
        op stageBlockFromUrl is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
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
            ...FileRequestIntentParameter;
            ...SourceEncryptionKeyParameter;
            ...SourceEncryptionKeySha256Parameter;
            ...SourceEncryptionAlgorithmParameter;
          },
          {
            @statusCode statusCode: 201;
            ...DateResponseHeader;
            ...ContentMd5ResponseHeader;
            ...ContentCrc64ResponseHeader;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
          }
        >;

        /** The Commit Block List operation writes a blob by specifying the list of block IDs that make up the blob. In order to be written as part of a blob, a block must have been successfully written to the server in a prior Put Block operation. You can call Put Block List to update a blob by uploading only those blocks that have changed, then committing the new and existing blocks together. You can do this by specifying whether to commit a block from the committed block list or from the uncommitted block list, or to commit the most recently uploaded version of the block, whichever list it may belong to. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
        @put
        @sharedRoute
        @route("{blobName}?comp=blocklist")
        op commitBlockList is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...TimeoutParameter;
            ...BlobCacheControlParameter;
            ...BlobContentTypeParameter;
            ...BlobContentEncodingParameter;
            ...BlobContentLanguageParameter;
            ...BlobContentMd5Parameter;
            ...ContentMd5Parameter;
            ...ContentCrc64Parameter;
            ...MetadataHeaders;
            ...LeaseIdOptionalParameter;
            ...BlobContentDispositionParameter;
            ...EncryptionKeyParameter;
            ...EncryptionKeySha256Parameter;
            ...EncryptionAlgorithmParameter;
            ...EncryptionScopeParameter;
            ...AccessTierHeader;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;

            /** Blob Blocks. */
            @body blocks: BlockLookupList;

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
            ...VersionIdResponseHeader;
            ...DateResponseHeaderPrivate;
            ...RequestServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
          }
        >;

        /** The Get Block List operation retrieves the list of blocks that have been uploaded as part of a block blob. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        @get
        @route("{blobName}?comp=blocklist")
        op getBlockList is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;
            ...SnapshotParameter;

            /** Specifies whether to return the list of committed blocks, the list of uncommitted blocks, or both lists together. */
            @query
            @clientName("listType")
            blocklisttype: BlockListType;

            ...TimeoutParameter;
            ...LeaseIdOptionalParameter;
            ...IfTagsParameter;
          },
          {
            /** Block list */
            @body
            blockList: BlockList;

            ...LastModifiedResponseHeader;
            ...EtagResponseHeader;
            ...BlobContentLengthResponseHeader;
            ...DateResponseHeaderPrivate;
          }
        >;

        /** The Query operation enables users to select/project on blob data by providing simple query expressions. */
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
        #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
        @post
        @route("{blobName}?comp=query")
        op query is StorageOperation<
          {
            ...ContainerNamePathParameter;
            ...BlobPathParameter;

            /** The query request */
            @body
            queryRequest: QueryRequest;

            ...SnapshotParameter;
            ...TimeoutParameter;
            ...LeaseIdOptionalParameter;
            ...EncryptionKeyParameter;
            ...EncryptionKeySha256Parameter;
            ...EncryptionAlgorithmParameter;
            ...IfModifiedSinceParameter;
            ...IfUnmodifiedSinceParameter;
            ...IfNoneMatchParameter;
            ...IfMatchParameter;
            ...IfTagsParameter;
          },
          BodyParameter & {
            #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard pattern"
            @statusCode statusCode: 200 | 206;
            ...MetadataHeaders;
            ...LastModifiedResponseHeader;
            ...ContentLengthResponseHeader;
            ...ContentRangeResponseHeader;
            ...EtagResponseHeader;
            ...ContentMd5ResponseHeader;
            ...ContentEncodingResponseParameter;
            ...CacheControlResponseHeader;
            ...ContentDispositionResponseHeader;
            ...ContentLanguageResponseHeader;
            ...BlobSequenceNumberResponseHeader;
            ...BlobTypeResponseHeader;
            ...ContentCrc64ResponseHeader;
            ...CopyCompletionTimeResponseHeader;
            ...CopyStatusDescriptionResponseHeader;
            ...CopyIdResponseHeader;
            ...CopyProgressResponseHeader;
            ...CopySourceResponseHeader;
            ...CopyStatusResponseHeader;
            ...LeaseDurationResponseHeader;
            ...LeaseStateResponseHeader;
            ...LeaseStatusResponseHeader;
            ...AcceptRangesResponseHeader;
            ...DateResponseHeader;
            ...BlobCommittedBlockCountResponseHeader;
            ...ServerEncryptedResponseHeader;
            ...EncryptionKeySha256ResponseHeader;
            ...EncryptionScopeResponseHeader;
            ...BlobContentMd5ResponseHeader;
          },
          "application/xml",
          "application/octet-stream"
        >;
      }
    }
  }
}
