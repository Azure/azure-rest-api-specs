import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./models.tsp";

namespace Storage.DataLake;

using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;

// ============================================================================
// Operation Templates
// ============================================================================

/** DataLake operation template with both request body and response body Content-Type headers. */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op DataLakeOperation<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  RequestMediaType extends string = "application/json",
  ResponseMediaType extends string = "application/json",
  TError = StorageError
>(
  /** Content-Type header */
  #suppress "@typespec/http/content-type-ignored" "Template for existing API"
  @header("Content-Type")
  contentType: RequestMediaType,

  ...ApiVersionHeader,
  ...ClientRequestIdParameter,
  ...TParams,
):
  | (TResponse & {
      /** Content-Type header */
      #suppress "@typespec/http/content-type-ignored" "Template for existing API"
      @header("Content-Type")
      contentType: ResponseMediaType;

      ...DateResponseHeader;
      ...ApiVersionHeader;
      ...RequestIdResponseHeader;
      ...ClientRequestIdResponseHeader;
    })
  | TError;

/** DataLake operation template with no request body and no response body (headers only). */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op DataLakeOperationNoBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  TError = StorageError
>(...ApiVersionHeader, ...ClientRequestIdParameter, ...TParams):
  | (TResponse & {
      ...DateResponseHeader;
      ...ApiVersionHeader;
      ...RequestIdResponseHeader;
      ...ClientRequestIdResponseHeader;
    })
  | TError;

/** DataLake operation template with response body Content-Type but no request body. */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op DataLakeOperationResponseBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  ResponseMediaType extends string = "application/json",
  TError = StorageError
> is DataLakeOperationNoBody<
  TParams,
  {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: ResponseMediaType;
  } & TResponse,
  TError
>;

/** DataLake operation template with request body Content-Type but no response body. */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op DataLakeOperationRequestBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  RequestMediaType extends string = "application/json",
  TError = StorageError
> is DataLakeOperationNoBody<
  {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: RequestMediaType;
  } & TParams,
  TResponse,
  TError
>;

// ============================================================================
// Service Interface
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Service {
  /** List filesystems and their properties in given account. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @list
  @sharedRoute
  listFileSystems is DataLakeOperationResponseBody<
    {
      /** The value must be "account" for all account operations. */
      @query resource: AccountResourceType;

      ...PrefixParameter;
      ...ContinuationParameter;
      ...MaxResultsParameter;
      ...TimeoutParameter;
    },
    {
      /** The list of filesystems. */
      @body body: FileSystemList;

      ...ContinuationResponseHeader;
    }
  >;
}

// ============================================================================
// FileSystem Interface
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface FileSystem {
  /** Create a FileSystem rooted at the specified location. If the FileSystem already exists, the operation fails. This operation does not support conditional HTTP requests. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @sharedRoute
  create is DataLakeOperationNoBody<
    {
      /** The value must be "filesystem" for all filesystem operations. */
      @query resource: FileSystemResourceType;

      ...PropertiesParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...NamespaceEnabledResponseHeader;
    }
  >;

  /** Set properties for the FileSystem. This operation supports conditional HTTP requests. For more information, see [Specifying Conditional Headers for Blob Service Operations](https://learn.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @patch
  @sharedRoute
  setProperties is DataLakeOperationNoBody<
    {
      /** The value must be "filesystem" for all filesystem operations. */
      @query resource: FileSystemResourceType;

      ...PropertiesParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...TimeoutParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
  >;

  /** All system and user-defined filesystem properties are specified in the response headers. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @head
  @sharedRoute
  getProperties is DataLakeOperationNoBody<
    {
      /** The value must be "filesystem" for all filesystem operations. */
      @query resource: FileSystemResourceType;

      ...TimeoutParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...PropertiesResponseHeader;
      ...NamespaceEnabledResponseHeader;
    }
  >;

  /** Marks the FileSystem for deletion. When a FileSystem is deleted, a FileSystem with the same identifier cannot be created for at least 30 seconds. While the filesystem is being deleted, attempts to create a filesystem with the same identifier will fail with status code 409 (Conflict), with the service returning additional error information indicating that the filesystem is being deleted. All other operations, including operations on any files or directories within the filesystem, will fail with status code 404 (Not Found) while the filesystem is being deleted. This operation supports conditional HTTP requests. For more information, see [Specifying Conditional Headers for Blob Service Operations](https://learn.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @delete
  @sharedRoute
  delete is DataLakeOperationNoBody<
    {
      /** The value must be "filesystem" for all filesystem operations. */
      @query resource: FileSystemResourceType;

      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /** List FileSystem paths and their properties. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @list
  @sharedRoute
  @route("?resource=filesystem")
  listPaths is DataLakeOperationResponseBody<
    {
      ...ContinuationParameter;
      ...DirectoryParameter;
      ...RecursiveRequiredParameter;
      ...MaxResultsParameter;
      ...UpnParameter;
      ...BeginFromParameter;
      ...TimeoutParameter;
    },
    {
      /** The list of paths. */
      @body body: PathList;

      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContinuationResponseHeader;
    }
  >;

  /** The List Blobs operation returns a list of the blobs under the specified container. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @list
  @route("?restype=container&comp=list")
  listBlobHierarchySegment is DataLakeOperationResponseBody<
    {
      ...PrefixParameter;
      ...DelimiterParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...ListBlobsIncludeParameter;
      ...ListBlobsShowOnlyParameter;
      ...TimeoutParameter;
    },
    {
      /** The list of blobs. */
      @body body: ListBlobsHierarchySegmentResponse;
    },
    "application/xml"
  >;
}

// ============================================================================
// Path Interface
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Path {
  /** Create or rename a file or directory. By default, the destination is overwritten and if the destination already exists and has a lease the lease is broken. This operation supports conditional HTTP requests. For more information, see [Specifying Conditional Headers for Blob Service Operations](https://learn.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations). To fail if the destination already exists, use a conditional request with If-None-Match: "*". */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @sharedRoute
  create is DataLakeOperationNoBody<
    {
      /** Required only for Create File and Create Directory. The value must be "file" or "directory". */
      @query resource?: PathResourceType;

      /** Optional. Valid only when namespace is enabled. This parameter determines the behavior of the rename operation. The value must be "legacy" or "posix", and the default value will be "posix". */
      @query mode?: PathRenameMode;

      ...ContinuationParameter;
      ...CacheControlParameter;
      ...ContentEncodingParameter;
      ...ContentLanguageParameter;
      ...ContentDispositionParameter;
      ...ContentTypeParameter;
      ...RenameSourceParameter;
      ...LeaseIdOptionalParameter;
      ...SourceLeaseIdParameter;
      ...PropertiesParameter;
      ...PermissionsParameter;
      ...UmaskParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...SourceIfMatchParameter;
      ...SourceIfNoneMatchParameter;
      ...SourceIfModifiedSinceParameter;
      ...SourceIfUnmodifiedSinceParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...OwnerParameter;
      ...GroupParameter;
      ...AclParameter;
      ...ProposedLeaseIdOptionalParameter;
      ...LeaseDurationMethodParameter;
      ...PathExpiryOptionsOptionalParameter;
      ...PathExpiryTimeParameter;
      ...EncryptionContextParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContinuationResponseHeader;
      ...ContentLengthResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
    }
  >;

  /** Uploads data to be appended to a file, flushes (writes) previously uploaded data to a file, sets properties for a file or directory, or sets access control for a file or directory. Data can only be appended to a file. Concurrent writes to the same file using multiple clients are not supported. This operation supports conditional HTTP requests. For more information, see [Specifying Conditional Headers for Blob Service Operations](https://learn.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
  @patch(#{ implicitOptionality: true })
  @sharedRoute
  update is DataLakeOperation<
    {
      /** The action must be "append" to upload data to be appended to a file, "flush" to flush previously uploaded data to a file, "setProperties" to set the properties of a file or directory, "setAccessControl" to set the owner, group, permissions, or access control list for a file or directory, or "setAccessControlRecursive" to set the access control list for a directory recursively. Note that Hierarchical Namespace must be enabled for the account in order to use access control. Also note that the Access Control List (ACL) includes permissions for the owner, owning group, and others, so the x-ms-permissions and x-ms-acl request headers are mutually exclusive. */
      @query action: PathUpdateAction;

      /** Optional. Valid for "SetAccessControlRecursive" operation. It specifies the maximum number of files or directories on which the acl change will be applied. If omitted or greater than 2,000, the request will process up to 2,000 items. */
      @query
      @minValue(1)
      maxRecords?: int32;

      ...ContinuationParameter<"Optional. The number of paths processed with each invocation is limited. If the number of paths to be processed exceeds this limit, a continuation token is returned in the response header x-ms-continuation. When a continuation token is returned in the response, it must be percent-encoded and specified in a subsequent invocation of setAccessControlRecursive operation.">;

      /** Mode for set access control recursive. */
      @query mode?: PathSetAccessControlRecursiveMode;

      ...ForceFlagParameter;
      ...PositionParameter;
      ...RetainUncommittedDataParameter;
      ...CloseParameter;
      ...ContentLengthParameter;
      ...ContentMD5Parameter;
      ...LeaseIdOptionalParameter;
      ...CacheControlParameter;
      ...ContentDispositionParameter;
      ...ContentEncodingParameter;
      ...ContentLanguageParameter;
      ...PropertiesParameter;
      ...OwnerParameter;
      ...GroupParameter;
      ...PermissionsParameter;
      ...AclParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...BodyParameter;
      ...StructuredBodyParameter;
      ...StructuredContentLengthParameter;
      ...TimeoutParameter;
    },
    {
      /** The data was flushed (written) to the file or the properties were set successfully. Response body is optional and is valid only for "SetAccessControlRecursive". */
      @body body?: SetAccessControlRecursiveResponse;

      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...AcceptRangesResponseHeader;
      ...CacheControlResponseHeader;
      ...ContentDispositionResponseHeader;
      ...ContentEncodingResponseHeader;
      ...ContentLanguageResponseHeader;
      ...ContentLengthResponseHeader;
      ...ContentRangeResponseHeader;
      ...ContentMD5ResponseHeader;
      ...PropertiesResponseHeader;
      ...ContinuationResponseHeader;
    },
    "application/octet-stream",
    "application/json"
  >;

  /** Create and manage a lease to restrict write and delete access to the path. This operation supports conditional HTTP requests. For more information, see [Specifying Conditional Headers for Blob Service Operations](https://learn.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @post
  @sharedRoute
  lease is DataLakeOperationNoBody<
    {
      /** There are five lease actions: "acquire", "break", "change", "renew", and "release". Use "acquire" and specify the "x-ms-proposed-lease-id" and "x-ms-lease-duration" to acquire a new lease. Use "break" to break an existing lease. When a lease is broken, the lease break period is allowed to elapse, during which time no lease operation except break and release can be performed on the file. When a lease is successfully broken, the response indicates the interval in seconds until a new lease can be acquired. Use "change" and specify the current lease ID in "x-ms-lease-id" and the new lease ID in "x-ms-proposed-lease-id" to change the lease ID of an active lease. Use "renew" and specify the "x-ms-lease-id" to renew an existing lease. Use "release" and specify the "x-ms-lease-id" to release a lease. */
      @header("x-ms-lease-action")
      leaseAction: PathLeaseAction;

      ...LeaseDurationParameter;

      /** The lease break period duration is optional to break a lease, and specifies the break period of the lease in seconds. The lease break duration must be between 0 and 60 seconds. */
      @header("x-ms-lease-break-period")
      leaseBreakPeriod?: int32;

      ...LeaseIdOptionalParameter;
      ...ProposedLeaseIdOptionalParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...TimeoutParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseIdResponseHeader;
      ...LeaseTimeResponseHeader;
    }
  >;

  /** Read the contents of a file. For read operations, range requests are supported. This operation supports conditional HTTP requests. For more information, see [Specifying Conditional Headers for Blob Service Operations](https://learn.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @sharedRoute
  read is DataLakeOperationResponseBody<
    {
      /** The HTTP Range request header specifies one or more byte ranges of the resource to be retrieved. */
      @header("Range")
      range?: string;

      ...LeaseIdOptionalParameter;

      /** Optional. When this header is set to "true" and specified together with the Range header, the service returns the MD5 hash for the range, as long as the range is less than or equal to 4MB in size. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API"
      @header("x-ms-range-get-content-md5")
      rangeGetContentMD5?: boolean;

      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...TimeoutParameter;
    },
    {
      /** The file content. */
      @body body: bytes;

      ...AcceptRangesResponseHeader;
      ...CacheControlResponseHeader;
      ...ContentDispositionResponseHeader;
      ...ContentEncodingResponseHeader;
      ...ContentLanguageResponseHeader;
      ...ContentLengthResponseHeader;
      ...ContentRangeResponseHeader;
      ...ContentMD5ResponseHeader;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ResourceTypeResponseHeader;
      ...PropertiesResponseHeader;
      ...LeaseDurationResponseHeader;
      ...LeaseStateResponseHeader;
      ...LeaseStatusResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
    },
    "application/octet-stream"
  >;

  /** Get Properties returns all system and user defined properties for a path. Get Status returns all system defined properties for a path. Get Access Control List returns the access control list for a path. This operation supports conditional HTTP requests. For more information, see [Specifying Conditional Headers for Blob Service Operations](https://learn.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @head
  @sharedRoute
  getProperties is DataLakeOperationNoBody<
    {
      /** Optional. If the value is "getStatus" only the system defined properties for the path are returned. If the value is "getAccessControl" the access control list is returned in the response headers (Hierarchical Namespace must be enabled for the account), otherwise the properties are returned. */
      @query action?: PathGetPropertiesAction;

      ...UpnParameter;
      ...LeaseIdOptionalParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...TimeoutParameter;
    },
    {
      ...AcceptRangesResponseHeader;
      ...CacheControlResponseHeader;
      ...ContentDispositionResponseHeader;
      ...ContentEncodingResponseHeader;
      ...ContentLanguageResponseHeader;
      ...ContentLengthResponseHeader;
      ...ContentRangeResponseHeader;
      ...ContentTypeResponseHeader;
      ...ContentMD5ResponseHeader;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ResourceTypeResponseHeader;
      ...PropertiesResponseHeader;
      ...OwnerResponseHeader;
      ...GroupResponseHeader;
      ...PermissionsResponseHeader;
      ...AclResponseHeader;
      ...LeaseDurationResponseHeader;
      ...LeaseStateResponseHeader;
      ...LeaseStatusResponseHeader;
      ...IsServerEncryptedAltResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...EncryptionContextResponseHeader;
      ...EncryptionScopeResponseHeader;
      ...CreationTimeResponseHeader;
      ...ExpiryTimeResponseHeader;
    }
  >;

  /** Delete the file or directory. This operation supports conditional HTTP requests. For more information, see [Specifying Conditional Headers for Blob Service Operations](https://learn.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @delete
  @sharedRoute
  delete is DataLakeOperationNoBody<
    {
      ...RecursiveOptionalParameter;
      ...ContinuationParameter;
      ...LeaseIdOptionalParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...PaginatedParameter;
      ...TimeoutParameter;
    },
    {
      ...ContinuationResponseHeader;
      ...DeletionIdResponseHeader;
    }
  >;

  /** Set the owner, group, permissions, or access control list for a path. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @patch
  @route("?action=setAccessControl")
  setAccessControl is DataLakeOperationNoBody<
    {
      ...LeaseIdOptionalParameter;
      ...OwnerParameter;
      ...GroupParameter;
      ...PermissionsParameter;
      ...AclParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...TimeoutParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
  >;

  /** Set the access control list for a path and sub-paths. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @patch
  @route("?action=setAccessControlRecursive")
  setAccessControlRecursive is DataLakeOperationResponseBody<
    {
      /** Mode "set" sets POSIX access control rights on files and directories, "modify" modifies one or more POSIX access control rights that pre-exist on files and directories, "remove" removes one or more POSIX access control rights that were present earlier on files and directories. */
      @query mode: PathSetAccessControlRecursiveMode;

      ...ContinuationParameter;
      ...ForceFlagParameter;

      /** Optional. It specifies the maximum number of files or directories on which the acl change will be applied. If omitted or greater than 2,000, the request will process up to 2,000 items. */
      @query
      @minValue(1)
      maxRecords?: int32;

      ...AclParameter;
      ...TimeoutParameter;
    },
    {
      /** The set access control recursive response. */
      @body body: SetAccessControlRecursiveResponse;

      ...ContinuationResponseHeader;
    }
  >;

  /** Set the owner, group, permissions, or access control list for a path. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @patch
  @route("?action=flush")
  flushData is DataLakeOperationNoBody<
    {
      ...PositionParameter;
      ...RetainUncommittedDataParameter;
      ...CloseParameter;
      ...ContentLengthParameter;
      ...ContentMD5Parameter;
      ...LeaseIdOptionalParameter;
      ...LeaseActionParameter;
      ...LeaseDurationMethodParameter;
      ...ProposedLeaseIdOptionalParameter;
      ...CacheControlParameter;
      ...ContentTypeParameter;
      ...ContentDispositionParameter;
      ...ContentEncodingParameter;
      ...ContentLanguageParameter;
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
      ...IfModifiedSinceParameter;
      ...IfUnmodifiedSinceParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...TimeoutParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentLengthResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...LeaseRenewedResponseHeader;
    }
  >;

  /** Append data to the file. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
  @patch(#{ implicitOptionality: true })
  @route("?action=append")
  appendData is DataLakeOperationRequestBody<
    {
      ...PositionParameter;
      ...ContentLengthParameter;
      ...TransactionalContentMD5Parameter;
      ...ContentCrc64Parameter;
      ...LeaseIdOptionalParameter;
      ...LeaseActionParameter;
      ...LeaseDurationMethodParameter;
      ...ProposedLeaseIdOptionalParameter;
      ...BodyParameter;
      ...EncryptionKeyParameter;
      ...EncryptionKeySha256Parameter;
      ...EncryptionAlgorithmParameter;
      ...FlushParameter;
      ...StructuredBodyParameter;
      ...StructuredContentLengthParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...ContentMD5ResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...IsServerEncryptedResponseHeader;
      ...EncryptionKeySha256ResponseHeader;
      ...LeaseRenewedResponseHeader;
      ...StructuredBodyTypeResponseHeader;
    },
    "application/octet-stream"
  >;

  /** Sets the time a blob will expire and be deleted. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=expiry")
  setExpiry is DataLakeOperationNoBody<
    {
      ...PathExpiryOptionsRequiredParameter;
      ...PathExpiryTimeParameter;
      ...TimeoutParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
  >;

  /** Undelete a path that was previously soft deleted. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=undelete")
  undelete is DataLakeOperationNoBody<
    {
      ...UndeleteSourceParameter;
      ...TimeoutParameter;
    },
    {
      ...ResourceTypeResponseHeader;
    }
  >;
}
