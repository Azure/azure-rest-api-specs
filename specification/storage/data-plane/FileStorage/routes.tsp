import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Storage.File;

/** Azure Storage File basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperation<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  RequestMediaType extends string = "application/xml",
  ResponseMediaType extends string = "application/xml",
  TError = Error
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
  ...DateResponseHeader;
}) | TError;

/** Azure Storage File basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperationNoBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  TError = Error
>(...ApiVersionHeader, ...ClientRequestIdHeader, ...TParams): (TResponse & {
  ...ApiVersionHeader;
  ...RequestIdResponseHeader;
  ...ClientRequestIdHeader;
  ...DateResponseHeader;
}) | TError;

/** Azure Storage File basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperationResponseBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  ResponseMediaType extends string = "application/xml",
  TError = Error
> is StorageOperationNoBody<
  TParams,
  {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: ResponseMediaType;
  } & TResponse,
  TError
>;

/** Azure Storage File basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperationRequestBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  RequestMediaType extends string = "application/xml",
  TError = Error
> is StorageOperationNoBody<
  {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: RequestMediaType;
  } & TParams,
  TResponse,
  TError
>;

/**
 * Service operations
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing storage API."
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Service {
  /**
   * Sets properties for a storage account's File service endpoint, including properties for Storage Analytics metrics and CORS (Cross-Origin Resource Sharing) rules.
   */
  @route("/?restype=service&comp=properties")
  @put
  setProperties is StorageOperationRequestBody<
    {
      ...TimeoutParameter;
      ...FileRequestIntentParameter;

      /** Storage service properties */
      @body storageServiceProperties: StorageServiceProperties;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /**
   * Gets the properties of a storage account's File service, including properties for Storage Analytics metrics and CORS (Cross-Origin Resource Sharing) rules.
   */
  @route("/?restype=service&comp=properties")
  @get
  getProperties is StorageOperationResponseBody<
    {
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
    },
    {
      @body properties: StorageServiceProperties;
    }
  >;

  /**
   * The List Shares Segment operation returns a list of the shares and share snapshots under the specified account.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("/?comp=list")
  @get
  @list
  listSharesSegment is StorageOperationResponseBody<
    {
      ...PrefixParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;

      /** Include this parameter to specify one or more datasets to include in the response. */
      @query include?: ListSharesIncludeType[];
    },
    {
      @body response: ListSharesResponse;
    }
  >;

  /**
   * Retrieves a user delegation key for the File service. This can be used to generate a user delegation SAS.
   */
  @route("/?restype=service&comp=userdelegationkey")
  @post
  getUserDelegationKey is StorageOperation<
    {
      ...TimeoutParameter;

      /** Key information */
      @body keyInfo: KeyInfo;
    },
    {
      @body userDelegationKey: UserDelegationKey;
    }
  >;
}

/**
 * Share operations
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing storage API."
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Share {
  /**
   * Creates a new share under the specified account. If the share with the same name already exists, the operation fails.
   */
  @route("?restype=share")
  @put
  create is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...ShareQuotaOptionalHeader;
      ...ShareAccessTierRequestHeader;
      ...EnabledProtocolsHeader;
      ...ShareRootSquashRequestHeader;
      ...EnableSnapshotVirtualDirectoryAccessHeader;
      ...PaidBurstingRequestHeaders;
      ...FileRequestIntentParameter;
      ...ShareProvisionedIopsOptionalHeader;
      ...ShareProvisionedBandwidthOptionalHeader;
      ...EnableSmbDirectoryLeaseHeader;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ShareQuotaOptionalHeader;
      ...ShareProvisionedIopsOptionalHeader;
      ...ShareProvisionedBandwidthOptionalHeader;

      /** The included burst IOPS. */
      @header("x-ms-share-included-burst-iops") shareIncludedBurstIops?: int64;

      ...MaxBurstCreditsForIopsOptionalHeader;
    }
  >;

  /**
   * Returns all user-defined metadata and system properties for the specified share or share snapshot.
   */
  @route("?restype=share")
  @get
  getProperties is StorageOperationNoBody<
    {
      ...ShareSnapshotParameter;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      ...LeaseIdOptionalParameter;
    },
    {
      ...MetadataHeaders;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ShareQuotaOptionalHeader;

      /** The provisioned IOPS for the share. */
      @header("x-ms-share-provisioned-iops") provisionedIops?: int64;

      /** The provisioned ingress for the share. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API. The casing is correct."
      @header("x-ms-share-provisioned-ingress-mbps")
      provisionedIngressMBps?: int64;

      /** The provisioned egress for the share. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API. The casing is correct."
      @header("x-ms-share-provisioned-egress-mbps")
      provisionedEgressMBps?: int64;

      /** The next allowed quota downgrade time. */
      @encode("rfc7231")
      @header("x-ms-share-next-allowed-quota-downgrade-time")
      nextAllowedQuotaDowngradeTime?: utcDateTime;

      /** The provisioned bandwidth for the share. */
      @header("x-ms-share-provisioned-bandwidth-mibps")
      @clientName("ProvisionedBandwidthMiBps", "go")
      provisionedBandwidthMibps?: int64;

      ...LeaseResponseHeaders;

      /** The access tier of the share. */
      @header("x-ms-access-tier") accessTier?: string;

      /** The access tier change time. */
      @header("x-ms-access-tier-change-time") accessTierChangeTime?: string;

      /** The access tier transition state. */
      @header("x-ms-access-tier-transition-state")
      accessTierTransitionState?: string;

      /** The enabled protocols for the share. */
      @header("x-ms-enabled-protocols") enabledProtocols?: string;

      /** The root squash mode for the share. */
      @header("x-ms-root-squash") rootSquash?: string;

      /** Whether snapshot virtual directory access is enabled. */
      @header("x-ms-enable-snapshot-virtual-directory-access")
      enableSnapshotVirtualDirectoryAccess?: boolean;

      ...PaidBurstingResponseHeaders;

      /** The next allowed provisioned IOPS downgrade time. */
      @encode("rfc7231")
      @header("x-ms-share-next-allowed-provisioned-iops-downgrade-time")
      nextAllowedProvisionedIopsDowngradeTime?: utcDateTime;

      /** The next allowed provisioned bandwidth downgrade time. */
      @encode("rfc7231")
      @header("x-ms-share-next-allowed-provisioned-bandwidth-downgrade-time")
      nextAllowedProvisionedBandwidthDowngradeTime?: utcDateTime;

      /** Whether SMB directory lease is enabled. */
      @header("x-ms-enable-smb-directory-lease")
      @clientName("EnableSMBDirectoryLease", "go")
      enableSmbDirectoryLease?: boolean;
    }
  >;

  /**
   * Operation marks the specified share or share snapshot for deletion. The share or share snapshot and any files contained within it are later deleted during garbage collection.
   */
  @route("?restype=share")
  @delete
  delete is StorageOperationNoBody<
    {
      ...ShareSnapshotParameter;
      ...TimeoutParameter;

      /** Specifies the option include to delete the base share and all of its snapshots. */
      ...DeleteSnapshotsHeader;

      ...FileRequestIntentParameter;
      ...LeaseIdOptionalParameter;
    },
    {
      @statusCode statusCode: 202;
      ...ShareUsageResponseHeader;
      ...ShareSnapshotUsageResponseHeader;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?restype=share&comp=lease")
  @put
  acquireLease is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...LeaseDurationParameter;
      ...ProposeLeaseIdParameter;
      ...LeaseActionParameter<"acquire">;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseIdOptionalParameter;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?restype=share&comp=lease")
  @put
  releaseLease is StorageOperationNoBody<
    {
      ...LeaseIdRequiredParameter;
      ...LeaseActionParameter<"release">;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?restype=share&comp=lease")
  @put
  changeLease is StorageOperationNoBody<
    {
      ...LeaseIdRequiredParameter;
      ...ProposeLeaseIdParameter;
      ...LeaseActionParameter<"change">;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseIdOptionalParameter;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?restype=share&comp=lease")
  @put
  renewLease is StorageOperationNoBody<
    {
      ...LeaseIdRequiredParameter;
      ...LeaseActionParameter<"renew">;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseIdOptionalParameter;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @sharedRoute
  @route("?restype=share&comp=lease")
  @put
  breakLease is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...BreakPeriodParameter;
      ...LeaseIdOptionalParameter;
      ...LeaseActionParameter<"break">;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseTimeResponseHeader;
      ...LeaseIdOptionalParameter;
    }
  >;

  /**
   * Creates a read-only snapshot of a share.
   */
  @route("?restype=share&comp=snapshot")
  @put
  createSnapshot is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...SnapshotResponseHeader;
    }
  >;

  /**
   * Create a permission (a security descriptor). This is used to support file level ACLs for SMB shares.
   */
  @route("?restype=share&comp=filepermission")
  @put
  createPermission is StorageOperationRequestBody<
    {
      ...TimeoutParameter;
      ...FileRequestIntentParameter;

      /** A permission (a security descriptor) at the share level. */
      @body permission: SharePermission;
    },
    {
      @statusCode statusCode: 201;
      ...FilePermissionKeyResponseHeader;
    },
    "application/json"
  >;

  /**
   * Returns the permission (security descriptor) for a given permission key. This is used to support file level ACLs for SMB shares.
   */
  @route("?restype=share&comp=filepermission")
  @get
  getPermission is StorageOperationResponseBody<
    {
      ...FilePermissionKeyRequestHeader;
      ...TimeoutParameter;

      /** Optional. Specifies the format in which the permission is returned. Acceptable values are SDDL or binary. */
      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      ...FileRequestIntentParameter;
    },
    {
      @body permission: SharePermission;
    },
    "application/json"
  >;

  /**
   * Sets properties for the specified share.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?restype=share&comp=properties")
  @put
  setProperties is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...ShareQuotaOptionalHeader;
      ...ShareAccessTierRequestHeader;
      ...LeaseIdOptionalParameter;
      ...ShareRootSquashRequestHeader;
      ...EnableSnapshotVirtualDirectoryAccessHeader;
      ...PaidBurstingRequestHeaders;
      ...FileRequestIntentParameter;
      ...ShareProvisionedIopsOptionalHeader;
      ...ShareProvisionedBandwidthOptionalHeader;
      ...EnableSmbDirectoryLeaseHeader;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ShareProvisioningResponseHeaders;
      ...ShareDowngradeTimeResponseHeaders;
    }
  >;

  /**
   * Sets one or more user-defined name-value pairs for the specified share.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?restype=share&comp=metadata")
  @put
  setMetadata is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...LeaseIdOptionalParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
  >;

  /**
   * Returns information about stored access policies specified on the share that may be used with Shared Access Signatures.
   */
  @route("?restype=share&comp=acl")
  @get
  getAccessPolicy is StorageOperationResponseBody<
    {
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      @body
      signedIdentifiers: SignedIdentifiers;
    }
  >;

  /**
   * Sets stored access policies for the share that may be used with Shared Access Signatures.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?restype=share&comp=acl")
  @put
  setAccessPolicy is StorageOperationNoBody<
    {
      /** Content-Type header */
      #suppress "@typespec/http/content-type-ignored" "Template for existing API"
      @header("Content-Type")
      contentType?: "application/xml";

      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...FileRequestIntentParameter;

      /** The ACL for the share. */
      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing storage API."
      @body shareAcl?: SignedIdentifiers;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
  >;

  /**
   * Retrieves statistics related to the share.
   */
  @route("?restype=share&comp=stats")
  @get
  getStatistics is StorageOperationResponseBody<
    {
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      @body shareStats: ShareStats;
    }
  >;

  /**
   * Restores a previously deleted share.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?restype=share&comp=undelete")
  @put
  restore is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...ShareDeletedNameHeader;
      ...ShareDeletedVersionHeader;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ShareProvisioningResponseHeaders;
    }
  >;
}

/**
 * Directory operations
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing storage API."
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Directory {
  /**
   * Creates a new directory under the specified share or parent directory.
   */
  @route("?restype=directory")
  @put
  create is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...FileSmtPropertyRequestHeaders;
      ...FilePermissionFormatParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;
      ...FilePropertySemanticsHeader;
      ...AllowTrailingDotParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
      ...NfsResponseHeaders;
    }
  >;

  /**
   * Returns all system properties for the specified directory, and can also be used to check the existence of a directory.
   */
  @route("?restype=directory")
  @get
  getProperties is StorageOperationNoBody<
    {
      ...ShareSnapshotParameter;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      ...MetadataHeaders;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
      ...ServerEncryptedResponseHeader;
      ...NfsResponseHeaders;
    }
  >;

  /**
   * Removes the specified empty directory. Note that the directory must be empty before it can be deleted.
   */
  @route("?restype=directory")
  @delete
  delete is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /**
   * Sets properties for the specified directory.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?restype=directory&comp=properties")
  @put
  setProperties is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...FileSmtPropertyRequestHeaders;
      ...FilePermissionFormatParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
      @header("x-ms-mode") fileMode?: string;
      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;
    }
  >;

  /**
   * Sets one or more user-defined name-value pairs for the specified directory.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?restype=directory&comp=metadata")
  @put
  setMetadata is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...RequestServerEncryptedResponseHeader;
    }
  >;

  /**
   * Returns a list of files and directories under the specified share or directory. It lists the contents only for a single level of the directory hierarchy.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?restype=directory&comp=list")
  @get
  @list
  listFilesAndDirectoriesSegment is StorageOperationResponseBody<
    {
      ...PrefixParameter;
      ...ShareSnapshotParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;

      /** Include this parameter to specify one or more datasets to include in the response. */
      @query include?: ListFilesIncludeType[];

      ...TimeoutParameter;
      ...FileExtendedInfoHeader;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @body response: ListFilesAndDirectoriesSegmentResponse;
    }
  >;

  /**
   * Lists handles for directory.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?comp=listhandles")
  @get
  @list
  listHandles is StorageOperationResponseBody<
    {
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...RecursiveParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @body response: ListHandlesResponse;
    }
  >;

  /**
   * Closes all handles open for given directory.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?comp=forceclosehandles")
  @put
  forceCloseHandles is StorageOperationNoBody<
    {
      ...HandleIdParameter;
      ...TimeoutParameter;
      ...MarkerParameter;
      ...ShareSnapshotParameter;
      ...RecursiveParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...ForceCloseHandlesResponseHeaders;
    }
  >;

  /**
   * Renames a directory. By default, the destination is overwritten and if the destination already exists and has a read-only attribute set, the operation will fail.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?restype=directory&comp=rename")
  @put
  rename is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...RenameRequestHeaders;
      ...DestinationLeaseIdParameter;

      ...FileAttributesStringHeader;
      ...FileCreationTimeStringHeader<"Creation time for the directory.">;
      ...FileLastWriteTimeStringHeader<"Last write time for the directory.">;
      ...FileChangeTimeStringHeader<"Change time for the directory.">;
      ...FilePermissionOptionalHeader<"If specified the permission shall be set for the directory.">;

      ...FilePermissionFormatParameter;

      ...FilePermissionKeyOptionalStringHeader;

      ...MetadataHeaders;
      ...AllowTrailingDotParameter;
      ...SourceAllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
    }
  >;
}

/**
 * File operations
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing storage API."
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface File {
  /**
   * Creates a new file or replaces a file. Note it only initializes the file with no content.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "Existing storage API."
  @sharedRoute
  @put
  create is StorageOperationNoBody<
    {
      /** Content-Type header */
      #suppress "@typespec/http/content-type-ignored" "Template for existing API"
      @header("Content-Type")
      contentType?: "application/octet-stream";

      /** Specifies the number of bytes being transmitted in the request body. When the x-ms-write header is set to clear, the value of this header must be set to zero. */
      @header("x-ms-content-length") contentLength: int64;

      ...TimeoutParameter;
      ...FileTypeParameter;
      ...FileContentRequestHeaders;
      ...MetadataHeaders;
      ...FileSmtPropertyRequestHeaders;
      ...FilePermissionFormatParameter;
      ...LeaseIdOptionalParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;

      /** Optional, NFS only. Type of the file or directory. */
      @header("x-ms-file-file-type")
      @clientName("NFSFileType", "go")
      nfsFileType?: NfsFileType;

      ...ContentMD5RequestHeader;
      ...FilePropertySemanticsHeader;

      /** Optional. Specifies the content length of the file. */
      @header("Content-Length") optionalContentLength?: int64;

      ...StructuredBodyRequestHeaders;
      ...OptionalBody;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
      ...NfsResponseHeaders;
      ...ContentMD5ResponseHeader;

      /** Content length of the file. */
      @header("Content-Length") contentLength?: int64;

      ...StructuredBodyResponseHeader;
    }
  >;

  /**
   * Reads or downloads a file from the system, including its metadata and properties.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @get
  download is StorageOperationResponseBody<
    {
      ...TimeoutParameter;
      ...RangeHeader;
      ...RangeGetContentMD5Header;
      ...LeaseIdOptionalParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...StructuredBodyGetRequestHeader;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Specifying supported status codes for download operation."
      @statusCode statusCode: 200 | 206;
      ...LastModifiedResponseHeader;
      ...MetadataHeaders;
      @header("Content-Length") contentLength: int64;
      @header("Content-Range") contentRange?: string;

      @header("ETag")
      @clientName("ETag", "go")
      etag: Azure.Core.eTag;

      ...FileHttpContentResponseHeaders;
      @header("Accept-Ranges") acceptRanges?: string;
      ...CopyStatusResponseHeaders;
      ...FileContentMD5ResponseHeader;
      ...ServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
      ...LeaseResponseHeaders;
      ...StructuredBodyResponseHeaders;
      ...NfsResponseHeaders;
      ...LinkCountResponseHeader;
      @body content?: bytes;
    },
    "application/octet-stream"
  >;

  /**
   * Returns all user-defined metadata, standard HTTP properties, and system properties for the file.
   */
  @head
  getProperties is StorageOperationNoBody<
    {
      ...ShareSnapshotParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...LastModifiedResponseHeader;
      ...MetadataHeaders;

      /** Dummy type header, must be "file". */
      @header("x-ms-type") fileType: "File";

      @header("Content-Length") contentLength: int64;
      #suppress "@typespec/http/content-type-ignored" "This is a HEAD operation"
      @header("Content-Type") contentType?: string;

      @header("ETag")
      @clientName("ETag", "go")
      etag: Azure.Core.eTag;

      ...FileHttpContentResponseHeaders;
      ...CopyStatusResponseHeaders;
      ...ServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
      ...LeaseResponseHeaders;
      ...NfsResponseHeaders;
      ...LinkCountResponseHeader;
    }
  >;

  /**
   * Removes the file from the storage account.
   */
  @delete
  delete is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 202;
      ...LinkCountResponseHeader;
    }
  >;

  /**
   * Sets HTTP headers on a file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?comp=properties")
  @put
  setHttpHeaders is StorageOperationNoBody<
    {
      ...TimeoutParameter;

      /** Specifies the number of bytes being transmitted. */
      @header("x-ms-content-length") fileContentLength?: int64;

      ...FileContentRequestHeaders;
      ...FileSmtPropertyRequestHeaders;
      ...FilePermissionFormatParameter;
      ...LeaseIdOptionalParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
      @header("x-ms-mode") fileMode?: string;
      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;
      ...LinkCountResponseHeader;
    }
  >;

  /**
   * Sets one or more user-defined name-value pairs for the specified file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?comp=metadata")
  @put
  setMetadata is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...LeaseIdOptionalParameter;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      ...EtagResponseHeader;
      ...RequestServerEncryptedResponseHeader;
    }
  >;

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @put
  @sharedRoute
  @route("?comp=lease")
  acquireLease is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...LeaseDurationParameter;
      ...ProposeLeaseIdParameter;
      ...LeaseActionParameter<"acquire">;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseIdOptionalParameter;
    }
  >;

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @put
  @sharedRoute
  @route("?comp=lease")
  releaseLease is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...LeaseIdRequiredParameter;
      ...LeaseActionParameter<"release">;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
  >;

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @put
  @sharedRoute
  @route("?comp=lease")
  changeLease is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...LeaseIdRequiredParameter;
      ...ProposeLeaseIdParameter;
      ...LeaseActionParameter<"change">;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseIdOptionalParameter;
    }
  >;

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
  @put
  @sharedRoute
  @route("?comp=lease")
  breakLease is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...LeaseActionParameter<"break">;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LeaseTimeResponseHeader;
      ...LeaseIdOptionalParameter;
    }
  >;

  /**
   * Upload a range of bytes to a file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  #suppress "@azure-tools/typespec-azure-core/byos" "Existing storage API."
  @sharedRoute
  @route("?comp=range")
  @put
  uploadRange is StorageOperationNoBody<
    {
      /** Content-Type header */
      #suppress "@typespec/http/content-type-ignored" "Template for existing API"
      @header("Content-Type")
      contentType?: "application/octet-stream";

      ...RangeRequiredHeader;

      /** Specify one of the following options: - Update: Writes the bytes specified by the request body into the specified range. - Clear: Clears the specified range and releases the space used in storage for that range. */
      @header("x-ms-write")
      fileRangeWrite: FileRangeWriteType = FileRangeWriteType.update;

      ...UploadContentLengthHeader;

      ...TimeoutParameter;
      ...ContentMD5RequestHeader;
      ...LeaseIdOptionalParameter;
      ...FileLastWrittenModeHeader;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...StructuredBodyRequestHeaders;
      ...OptionalBody;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentMD5ResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileLastWriteTimeResponseHeader;
      ...StructuredBodyResponseHeader;
    }
  >;

  /**
   * Upload a range of bytes to a file where the contents are read from a URL.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?comp=range")
  @put
  uploadRangeFromUrl is StorageOperationNoBody<
    {
      ...RangeRequiredHeader;

      ...CopySourceHeader;

      /** Bytes of source data in the specified range. */
      @header("x-ms-source-range") sourceRange?: string;

      /** Only update is supported. */
      @header("x-ms-write")
      fileRangeWriteFromUrl: FileRangeWriteFromUrlType = FileRangeWriteFromUrlType.update;

      ...UploadContentLengthHeader;

      ...TimeoutParameter;

      /** Specify the CRC64 hash of the source content. */
      @header("x-ms-source-content-crc64")
      sourceContentCrc64?: bytes;

      /** Specify the CRC64 hash value to check for source content integrity. */
      @header("x-ms-source-if-match-crc64")
      sourceIfMatchCrc64?: bytes;

      /** Specify the CRC64 hash value to check for source content mismatch. */
      @header("x-ms-source-if-none-match-crc64")
      sourceIfNoneMatchCrc64?: bytes;

      ...LeaseIdOptionalParameter;
      ...CopySourceAuthorizationHeader;
      ...FileLastWrittenModeHeader;
      ...AllowTrailingDotParameter;
      ...SourceAllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...ContentCrc64ResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileLastWriteTimeResponseHeader;
    }
  >;

  /**
   * Returns the list of valid page ranges for a file or snapshot of a file.
   */
  @route("?comp=rangelist")
  @get
  getRangeList is StorageOperationResponseBody<
    {
      ...ShareSnapshotParameter;
      ...PreviousSnapshotParameter;
      ...TimeoutParameter;
      ...RangeHeader;
      ...LeaseIdOptionalParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...SupportRenameHeader;
    },
    {
      ...LastModifiedResponseHeader;
      ...EtagResponseHeader;
      ...FileContentLengthResponseHeader;
      @body rangeList: ShareFileRangeList;
    }
  >;

  /**
   * Copies a blob or file to a destination file within the storage account.
   */
  @sharedRoute
  @put
  startCopy is StorageOperationNoBody<
    {
      ...CopySourceHeader;
      ...TimeoutParameter;
      ...MetadataHeaders;

      ...FilePermissionOptionalHeader<"If specified the permission shall be set for the file.">;

      ...FilePermissionFormatParameter;

      ...FilePermissionKeyOptionalStringHeader;

      ...FilePermissionCopyModeHeader;
      ...IgnoreReadOnlyHeader;

      ...FileAttributesStringHeader;
      ...FileCreationTimeStringHeader<"Creation time for the file.">;
      ...FileLastWriteTimeStringHeader<"Last write time for the file.">;
      ...FileChangeTimeStringHeader<"Change time for the file.">;

      ...SetArchiveAttributeHeader;
      ...LeaseIdOptionalParameter;
      ...AllowTrailingDotParameter;
      ...SourceAllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;
      ...ModeCopyModeHeader;
      ...OwnerCopyModeHeader;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...CopyIdResponseHeader;
      ...CopyStatusResponseHeader;
    }
  >;

  /**
   * Aborts a pending Copy File operation, and leaves a destination file with zero length and full metadata.
   */
  @sharedRoute
  @route("?comp=copy")
  @put
  abortCopy is StorageOperationNoBody<
    {
      ...CopyActionAbortHeader;
      ...CopyIdQueryParameter;
      ...TimeoutParameter;
      ...LeaseIdOptionalParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 204;
    }
  >;

  /**
   * Lists handles for file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?comp=listhandles")
  @get
  @list
  listHandles is StorageOperationResponseBody<
    {
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @body response: ListHandlesResponse;
    }
  >;

  /**
   * Closes all handles open for given file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @sharedRoute
  @route("?comp=forceclosehandles")
  @put
  forceCloseHandles is StorageOperationNoBody<
    {
      ...HandleIdParameter;
      ...TimeoutParameter;
      ...MarkerParameter;
      ...ShareSnapshotParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...ForceCloseHandlesResponseHeaders;
    }
  >;

  /**
   * Renames a file. By default, the destination is overwritten and if the destination already exists and has a read-only attribute set, the operation will fail.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing storage API."
  @route("?comp=rename")
  @put
  rename is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...RenameRequestHeaders;
      ...DestinationLeaseIdParameter;

      ...FileAttributesStringHeader;
      ...FileCreationTimeStringHeader<"Creation time for the file.">;
      ...FileLastWriteTimeStringHeader<"Last write time for the file.">;
      ...FileChangeTimeStringHeader<"Change time for the file.">;
      ...FilePermissionOptionalHeader<"If specified the permission shall be set for the file.">;

      ...FilePermissionFormatParameter;

      ...FilePermissionKeyOptionalStringHeader;

      ...MetadataHeaders;

      /** Sets the MIME content type of the file. */
      @header("x-ms-content-type") fileContentType?: string;

      ...AllowTrailingDotParameter;
      ...SourceAllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
    }
  >;

  /**
   * Creates a symbolic link to a target file. NFS only.
   */
  @route("?restype=symboliclink")
  @put
  createSymbolicLink is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;

      ...FileCreationTimeStringHeader<"Creation time for the file.">;
      ...FileLastWriteTimeStringHeader<"Last write time for the file.">;

      ...LeaseIdOptionalParameter;

      ...NfsOwnerGroupHeaders;

      ...LinkTextHeader;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...NfsTimestampResponseHeaders;
      ...NfsResponseHeaders;
    }
  >;

  /**
   * Returns the target of a symbolic link. NFS only.
   */
  @route("?restype=symboliclink")
  @get
  getSymbolicLink is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...LinkTextHeader;
    }
  >;

  /**
   * Creates a hard link to a target file. NFS only.
   */
  @route("?restype=hardlink")
  @put
  createHardLink is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...FileTypeParameter;
      ...LeaseIdOptionalParameter;
      ...TargetFileHeader;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...NfsTimestampResponseHeaders;
      ...LinkCountResponseHeader;
      ...NfsResponseHeaders;
    }
  >;
}
