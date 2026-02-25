import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureFileStorage;

/** Azure Storage File basic operation template */
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

/** Azure Storage File basic operation template */
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

/** Azure Storage File basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperationResponseBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  ResponseMediaType extends string = "application/xml",
  TError = StorageError
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
  TError = StorageError
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
  @route("/?comp=list")
  @get
  listSharesSegment is StorageOperationResponseBody<
    {
      ...PrefixParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;

      /** Include additional metadata in response. */
      @query include?: string[];
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
      ...FileRequestIntentParameter;
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
interface Share {
  /**
   * Creates a new share under the specified account. If the share with the same name already exists, the operation fails.
   */
  @route("/{shareName}?restype=share")
  @put
  create is StorageOperationNoBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...FileRequestIntentParameter;

      /** The maximum size of the share in bytes. */
      @header("x-ms-share-quota") shareQuota?: int32;

      /** Specifies the access tier of the share. */
      @header("x-ms-access-tier") accessTier?: ShareAccessTier;

      /** Specifies which protocols are enabled on the share. */
      @header("x-ms-enabled-protocols") enabledProtocols?: string;

      /** Specifies the SquashMode for the share. */
      @header("x-ms-root-squash") rootSquash?: ShareRootSquash;

      /** Optional. Used to set file permission for shares that use POSIX ACLs. */
      @header("x-ms-file-permission") filePermission?: string;

      /** Optional. Used to set file attributes for shares. */
      @header("x-ms-file-attributes") fileAttributes?: string;

      /** Optional. Used to set file creation time for shares. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** Optional. Used to set file last write time for shares. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** Optional. Used to set file change time for shares. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** Optional. Used to set permission format for shares. */
      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      /** Optional. Used to set provisioned IOPS for shares. */
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

      /** Optional. Used to set provisioned bandwidth for shares. */
      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

      /** Optional. Used to enable paid bursting for shares. */
      @header("x-ms-paid-bursting-enabled") paidBurstingEnabled?: boolean;

      /** Optional. Used to set max IOPS for paid bursting. */
      @header("x-ms-paid-bursting-max-iops") paidBurstingMaxIops?: int64;

      /** Optional. Used to set max bandwidth for paid bursting. */
      @header("x-ms-paid-bursting-max-bandwidth-mibps")
      paidBurstingMaxBandwidthMibps?: int64;

      /** Optional. Used to enable snapshot virtual directory access. */
      @header("x-ms-enable-snapshot-virtual-directory-access")
      enableSnapshotVirtualDirectoryAccess?: boolean;

      /** Optional. Used to enable SMB directory lease. */
      @header("x-ms-enable-smb-directory-lease")
      enableSmbDirectoryLease?: boolean;
    },
    {
      @statusCode statusCode: 201;
    }
  >;

  /**
   * Returns all user-defined metadata and system properties for the specified share or share snapshot.
   */
  @route("/{shareName}?restype=share")
  @get
  getProperties is StorageOperationNoBody<
    {
      @path shareName: string;
      ...ShareSnapshotParameter;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      ...LeaseIdParameter;
    },
    {
      ...MetadataHeaders;

      /** The maximum quota for the share. */
      @header("x-ms-share-quota") shareQuota: int32;

      /** The provisioned IOPS for the share. */
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

      /** The provisioned ingress for the share. */
      @header("x-ms-share-provisioned-ingress-mbps")
      shareProvisionedIngressMbps?: int32;

      /** The provisioned egress for the share. */
      @header("x-ms-share-provisioned-egress-mbps")
      shareProvisionedEgressMbps?: int32;

      /** The provisioned bandwidth for the share. */
      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

      /** The next allowed quota downgrade time. */
      @header("x-ms-share-next-allowed-quota-downgrade-time")
      shareNextAllowedQuotaDowngradeTime?: string;

      /** The access tier of the share. */
      @header("x-ms-access-tier") accessTier?: string;

      /** The access tier change time. */
      @header("x-ms-access-tier-change-time") accessTierChangeTime?: string;

      /** The access tier transition state. */
      @header("x-ms-access-tier-transition-state")
      accessTierTransitionState?: string;

      /** The lease duration. */
      @header("x-ms-lease-duration") leaseDuration?: string;

      /** The lease state. */
      @header("x-ms-lease-state") leaseState: string;

      /** The lease status. */
      @header("x-ms-lease-status") leaseStatus: string;

      /** The enabled protocols for the share. */
      @header("x-ms-enabled-protocols") enabledProtocols?: string;

      /** The root squash mode for the share. */
      @header("x-ms-root-squash") rootSquash?: string;

      /** Whether snapshot virtual directory access is enabled. */
      @header("x-ms-enable-snapshot-virtual-directory-access")
      enableSnapshotVirtualDirectoryAccess?: boolean;

      /** Whether paid bursting is enabled. */
      @header("x-ms-paid-bursting-enabled") paidBurstingEnabled?: boolean;

      /** The maximum IOPS for paid bursting. */
      @header("x-ms-paid-bursting-max-iops") paidBurstingMaxIops?: int64;

      /** The maximum bandwidth for paid bursting. */
      @header("x-ms-paid-bursting-max-bandwidth-mibps")
      paidBurstingMaxBandwidthMibps?: int64;

      /** The included burst IOPS. */
      @header("x-ms-included-burst-iops") includedBurstIops?: int64;

      /** The maximum burst credits for IOPS. */
      @header("x-ms-max-burst-credits-for-iops") maxBurstCreditsForIops?: int64;

      /** The next allowed provisioned IOPS downgrade time. */
      @header("x-ms-share-next-allowed-provisioned-iops-downgrade-time")
      shareNextAllowedProvisionedIopsDowngradeTime?: string;

      /** The next allowed provisioned bandwidth downgrade time. */
      @header("x-ms-share-next-allowed-provisioned-bandwidth-downgrade-time")
      shareNextAllowedProvisionedBandwidthDowngradeTime?: string;

      /** Whether SMB directory lease is enabled. */
      @header("x-ms-enable-smb-directory-lease")
      enableSmbDirectoryLease?: boolean;
    }
  >;

  /**
   * Operation marks the specified share or share snapshot for deletion. The share or share snapshot and any files contained within it are later deleted during garbage collection.
   */
  @route("/{shareName}?restype=share")
  @delete
  delete is StorageOperationNoBody<
    {
      @path shareName: string;
      ...ShareSnapshotParameter;
      ...TimeoutParameter;

      @header("x-ms-delete-snapshots")
      deleteSnapshots?: DeleteSnapshotsOptionType;

      ...FileRequestIntentParameter;
      ...LeaseIdParameter;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&acquire")
  @put
  acquireLease is StorageOperationNoBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      @header("x-ms-lease-duration") leaseDuration: int32;
      @header("x-ms-proposed-lease-id") proposedLeaseId?: string;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      @header("x-ms-lease-id") leaseId: string;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&release")
  @put
  releaseLease is StorageOperationNoBody<
    {
      @path shareName: string;
      ...LeaseIdParameter;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 200;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&change")
  @put
  changeLease is StorageOperationNoBody<
    {
      @path shareName: string;
      ...LeaseIdParameter;
      @header("x-ms-proposed-lease-id") proposedLeaseId: string;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 200;
      @header("x-ms-lease-id") leaseId: string;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&renew")
  @put
  renewLease is StorageOperationNoBody<
    {
      @path shareName: string;
      ...LeaseIdParameter;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 200;
      @header("x-ms-lease-id") leaseId: string;
    }
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&break")
  @put
  breakLease is StorageOperationNoBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      @header("x-ms-lease-break-period") leaseBreakPeriod?: int32;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 202;
      @header("x-ms-lease-time") leaseTime?: string;
    }
  >;

  /**
   * Creates a read-only snapshot of a share.
   */
  @route("/{shareName}?restype=share&comp=snapshot")
  @put
  createSnapshot is StorageOperationNoBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      @header("x-ms-snapshot") snapshot: string;
    }
  >;

  /**
   * Create a permission (a security descriptor). This is used to support file level ACLs for SMB shares.
   */
  @route("/{shareName}?restype=share&comp=filepermission")
  @put
  createPermission is StorageOperationRequestBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      @body permission: SharePermission;
    },
    {
      @statusCode statusCode: 201;
      @header("x-ms-file-permission-key") filePermissionKey: string;
    }
  >;

  /**
   * Returns the permission (security descriptor) for a given permission key. This is used to support file level ACLs for SMB shares.
   */
  @route("/{shareName}?restype=share&comp=filepermission")
  @get
  getPermission is StorageOperationResponseBody<
    {
      @path shareName: string;
      @header("x-ms-file-permission-key") filePermissionKey: string;
      ...TimeoutParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      ...FileRequestIntentParameter;
    },
    {
      @body permission: SharePermission;
    }
  >;

  /**
   * Sets properties for the specified share.
   */
  @route("/{shareName}?restype=share&comp=properties")
  @put
  setProperties is StorageOperationNoBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      @header("x-ms-share-quota") shareQuota?: int32;
      @header("x-ms-access-tier") accessTier?: ShareAccessTier;
      ...LeaseIdParameter;
      @header("x-ms-root-squash") rootSquash?: ShareRootSquash;
      ...FileRequestIntentParameter;
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

      @header("x-ms-paid-bursting-enabled") paidBurstingEnabled?: boolean;
      @header("x-ms-paid-bursting-max-iops") paidBurstingMaxIops?: int64;

      @header("x-ms-paid-bursting-max-bandwidth-mibps")
      paidBurstingMaxBandwidthMibps?: int64;
    },
    {}
  >;

  /**
   * Sets one or more user-defined name-value pairs for the specified share.
   */
  @route("/{shareName}?restype=share&comp=metadata")
  @put
  setMetadata is StorageOperationNoBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
    },
    {}
  >;

  /**
   * Returns information about stored access policies specified on the share that may be used with Shared Access Signatures.
   */
  @route("/{shareName}?restype=share&comp=acl")
  @get
  getAccessPolicy is StorageOperationResponseBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
    },
    {
      @body signedIdentifiers: SignedIdentifier[];
    }
  >;

  /**
   * Sets stored access policies for the share that may be used with Shared Access Signatures.
   */
  @route("/{shareName}?restype=share&comp=acl")
  @put
  setAccessPolicy is StorageOperationRequestBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
      @body shareAcl?: SignedIdentifier[];
    },
    {
      @statusCode statusCode: 200;
    }
  >;

  /**
   * Retrieves statistics related to the share.
   */
  @route("/{shareName}?restype=share&comp=stats")
  @get
  getStatistics is StorageOperationResponseBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
    },
    {
      @body shareStats: ShareStats;
    }
  >;

  /**
   * Restores a previously deleted share.
   */
  @route("/{shareName}?restype=share&comp=undelete")
  @put
  restore is StorageOperationNoBody<
    {
      @path shareName: string;
      ...TimeoutParameter;
      @header("x-ms-deleted-share-name") deletedShareName?: string;
      @header("x-ms-deleted-share-version") deletedShareVersion?: string;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
    }
  >;
}

/**
 * Directory operations
 */
interface Directory {
  /**
   * Creates a new directory under the specified share or parent directory.
   */
  @route("/{shareName}/{directory}?restype=directory")
  @put
  create is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      @header("x-ms-file-permission") filePermission?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      @header("x-ms-posix-permissions") posixPermissions?: string;
      @header("x-ms-posix-umask") posixUmask?: string;
      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;
      @header("x-ms-mode") mode?: string;
    },
    {
      @statusCode statusCode: 201;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
    }
  >;

  /**
   * Returns all system properties for the specified directory, and can also be used to check the existence of a directory.
   */
  @route("/{shareName}/{directory}?restype=directory")
  @get
  getProperties is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      ...ShareSnapshotParameter;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...MetadataHeaders;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
    }
  >;

  /**
   * Removes the specified empty directory. Note that the directory must be empty before it can be deleted.
   */
  @route("/{shareName}/{directory}?restype=directory")
  @delete
  delete is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /**
   * Sets properties for the specified directory.
   */
  @route("/{shareName}/{directory}?restype=directory&comp=properties")
  @put
  setProperties is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      ...TimeoutParameter;
      @header("x-ms-file-permission") filePermission?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      ...FileRequestIntentParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      @header("x-ms-posix-permissions") posixPermissions?: string;
      @header("x-ms-posix-umask") posixUmask?: string;
      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;
      @header("x-ms-mode") mode?: string;
    },
    {
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
    }
  >;

  /**
   * Sets one or more user-defined name-value pairs for the specified directory.
   */
  @route("/{shareName}/{directory}?restype=directory&comp=metadata")
  @put
  setMetadata is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...FileRequestIntentParameter;
    },
    {}
  >;

  /**
   * Returns a list of files and directories under the specified share or directory. It lists the contents only for a single level of the directory hierarchy.
   */
  @route("/{shareName}/{directory}?restype=directory&comp=list")
  @get
  listFilesAndDirectoriesSegment is StorageOperationResponseBody<
    {
      @path shareName: string;
      @path directory: string;
      ...PrefixParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      @query include?: string[]; // ListFilesIncludeType values
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
      @header("x-ms-file-extended-info") fileExtendedInfo?: boolean;
    },
    {
      @body response: ListFilesAndDirectoriesSegmentResponse;
    }
  >;

  /**
   * Lists handles for directory.
   */
  @route("/{shareName}/{directory}?comp=listhandles")
  @get
  listHandles is StorageOperationResponseBody<
    {
      @path shareName: string;
      @path directory: string;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      @query recursive?: boolean;
      ...FileRequestIntentParameter;
    },
    {
      @body response: ListHandlesResponse;
    }
  >;

  /**
   * Closes all handles open for given directory.
   */
  @route("/{shareName}/{directory}?comp=forceclosehandles")
  @put
  forceCloseHandles is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @header("x-ms-handle-id") handleId: string;
      ...TimeoutParameter;
      ...MarkerParameter;
      ...ShareSnapshotParameter;
      @query recursive?: boolean;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 200;
      @header("x-ms-number-of-handles-closed") numberOfHandlesClosed: int32;
      @header("x-ms-number-of-handles-failed") numberOfHandlesFailed: int32;
    }
  >;

  /**
   * Renames a directory. By default, the destination is overwritten and if the destination already exists and has a read-only attribute set, the operation will fail.
   */
  @route("/{shareName}/{directory}?restype=directory&comp=rename")
  @put
  rename is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @header("x-ms-rename-source") renameSource: string;
      ...TimeoutParameter;

      @header("x-ms-file-rename-replace-if-exists")
      renameReplaceIfExists?: boolean;

      @header("x-ms-file-rename-ignore-read-only")
      renameIgnoreReadOnly?: boolean;

      @header("x-ms-source-lease-id") sourceLeaseId?: string;
      ...FileRequestIntentParameter;

      @header("x-ms-source-allow-trailing-dot")
      sourceAllowTrailingDot?: boolean;

      ...AllowTrailingDotParameter;
    },
    {}
  >;
}

/**
 * File operations
 */
interface File {
  /**
   * Creates a new file or replaces a file. Note it only initializes the file with no content.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @put
  create is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-content-length") contentLength: int64;
      ...TimeoutParameter;
      @header("x-ms-type") fileType?: string;
      ...MetadataHeaders;
      @header("x-ms-file-permission") filePermission?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("Content-Type") contentType?: string;
      @header("Content-Encoding") contentEncoding?: string;
      @header("Content-Language") contentLanguage?: string;
      @header("Cache-Control") cacheControl?: string;
      @header("Content-MD5") contentMd5?: string;
      @header("Content-Disposition") contentDisposition?: string;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;
      @header("x-ms-mode") mode?: string;
      @header("x-ms-nfs-file-type") nfsFileType?: NfsFileType;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 201;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
    }
  >;

  /**
   * Reads or downloads a file from the system, including its metadata and properties.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @get
  download is StorageOperationResponseBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      @query sharesnapshot?: string;
      @header("Range") range?: string;
      @header("x-ms-range-get-content-md5") getContentMd5?: boolean;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
      @header("x-ms-structured-body-get") structuredBodyGet?: string;
    },
    {
      @statusCode statusCode: 200 | 206;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-meta-*") metadata?: Record<string>;
      @header("Content-Length") contentLength: int64;
      @header("Content-Range") contentRange?: string;
      @header("ETag") etag: string;
      @header("Content-MD5") contentMd5?: string;
      @header("Content-Encoding") contentEncoding?: string;
      @header("Cache-Control") cacheControl?: string;
      @header("Content-Disposition") contentDisposition?: string;
      @header("Content-Language") contentLanguage?: string;
      @header("Accept-Ranges") acceptRanges?: string;
      @header("x-ms-copy-completion-time") copyCompletionTime?: string;
      @header("x-ms-copy-status-description") copyStatusDescription?: string;
      @header("x-ms-copy-id") copyId?: string;
      @header("x-ms-copy-progress") copyProgress?: string;
      @header("x-ms-copy-source") copySource?: string;
      @header("x-ms-copy-status") copyStatus?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
      @header("x-ms-lease-duration") leaseDuration?: string;
      @header("x-ms-lease-state") leaseState?: string;
      @header("x-ms-lease-status") leaseStatus?: string;
      @body content?: bytes;
    }
  >;

  /**
   * Returns all user-defined metadata, standard HTTP properties, and system properties for the file.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @head
  getProperties is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @query sharesnapshot?: string;
      ...TimeoutParameter;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-meta-*") metadata?: Record<string>;
      @header("x-ms-type") fileType: string;
      @header("Content-Length") contentLength: int64;
      @header("Content-Type") contentType?: string;
      @header("ETag") etag: string;
      @header("Content-MD5") contentMd5?: string;
      @header("Content-Encoding") contentEncoding?: string;
      @header("Cache-Control") cacheControl?: string;
      @header("Content-Disposition") contentDisposition?: string;
      @header("Content-Language") contentLanguage?: string;
      @header("x-ms-copy-completion-time") copyCompletionTime?: string;
      @header("x-ms-copy-status-description") copyStatusDescription?: string;
      @header("x-ms-copy-id") copyId?: string;
      @header("x-ms-copy-progress") copyProgress?: string;
      @header("x-ms-copy-source") copySource?: string;
      @header("x-ms-copy-status") copyStatus?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
      @header("x-ms-lease-duration") leaseDuration?: string;
      @header("x-ms-lease-state") leaseState?: string;
      @header("x-ms-lease-status") leaseStatus?: string;
    }
  >;

  /**
   * Removes the file from the storage account.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @delete
  delete is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /**
   * Sets HTTP headers on a file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=properties")
  @put
  setHTTPHeaders is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      @header("x-ms-file-permission") filePermission?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;

      @header("x-ms-file-last-write-time-mode")
      fileLastWriteTimeMode?: FileLastWrittenMode;

      @header("Content-Length") contentLength?: int64;
      @header("Content-Type") contentType?: string;
      @header("Content-Encoding") contentEncoding?: string;
      @header("Content-Language") contentLanguage?: string;
      @header("Cache-Control") cacheControl?: string;
      @header("Content-MD5") contentMd5?: string;
      @header("Content-Disposition") contentDisposition?: string;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;

      @header("x-ms-file-property-semantics")
      filePropertySemantics?: FilePropertySemantics;
    },
    {
      @statusCode statusCode: 200;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
    }
  >;

  /**
   * Sets one or more user-defined name-value pairs for the specified file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=metadata")
  @put
  setMetadata is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
    }
  >;

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=lease&acquire")
  @put
  acquireLease is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-lease-duration") leaseDuration: int32;
      @header("x-ms-proposed-lease-id") proposedLeaseId?: string;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 201;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-lease-id") leaseId: string;
    }
  >;

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=lease&release")
  @put
  releaseLease is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-lease-id") leaseId: string;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
    }
  >;

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=lease&change")
  @put
  changeLease is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-lease-id") leaseId: string;
      @header("x-ms-proposed-lease-id") proposedLeaseId: string;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-lease-id") leaseId: string;
    }
  >;

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=lease&break")
  @put
  breakLease is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      @header("x-ms-lease-break-period") leaseBreakPeriod?: int32;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 202;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-lease-time") leaseTime?: string;
    }
  >;

  /**
   * Upload a range of bytes to a file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=range")
  @put
  uploadRange is StorageOperationRequestBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-range") targetRange: string;
      @header("x-ms-write") fileRangeWrite: "update" | "clear";
      @header("Content-Length") contentLength: int64;
      ...TimeoutParameter;
      @header("Content-MD5") contentMd5?: string;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
      @header("x-ms-structured-body-put") structuredBodyPut?: string;
      @header("x-ms-structured-content-length") structuredContentLength?: int64;
      @body content?: bytes;
    },
    {
      @statusCode statusCode: 201;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("Content-MD5") contentMd5?: string;
    }
  >;

  /**
   * Upload a range of bytes to a file where the contents are read from a URL.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=range&fromURL")
  @put
  uploadRangeFromURL is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-range") targetRange: string;
      @header("x-ms-copy-source") copySource: string;
      @header("x-ms-source-range") sourceRange: string;
      @header("Content-Length") contentLength: int64;
      ...TimeoutParameter;
      @header("x-ms-source-content-crc64") sourceContentCrc64?: string;
      @header("x-ms-source-if-match-crc64") sourceIfMatchCrc64?: string;

      @header("x-ms-source-if-none-match-crc64")
      sourceIfNoneMatchCrc64?: string;

      @header("x-ms-lease-id") leaseId?: string;
      @header("x-ms-source-lease-id") sourceLeaseId?: string;

      @header("x-ms-copy-source-authorization")
      copySourceAuthorization?: string;

      ...FileRequestIntentParameter;

      @header("x-ms-source-allow-trailing-dot")
      sourceAllowTrailingDot?: boolean;

      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 201;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("Content-MD5") contentMd5?: string;
    }
  >;

  /**
   * Returns the list of valid page ranges for a file or snapshot of a file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=rangelist")
  @get
  getRangeList is StorageOperationResponseBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @query sharesnapshot?: string;
      ...TimeoutParameter;
      @header("Range") range?: string;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @header("Last-Modified") lastModified: string;
      @header("ETag") etag: string;
      @header("x-ms-content-length") contentLength: int64;
      @body rangeList: ShareFileRangeList;
    }
  >;

  /**
   * Copies a blob or file to a destination file within the storage account.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=copy")
  @put
  startCopy is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-copy-source") copySource: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      @header("x-ms-file-permission") filePermission?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;

      @header("x-ms-file-permission-copy-mode")
      filePermissionCopyMode?: PermissionCopyModeType;

      @header("x-ms-file-copy-ignore-read-only")
      fileCopyIgnoreReadOnly?: boolean;

      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-copy-file-attributes") fileCopyFileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      @header("x-ms-file-copy-file-creation-time")
      fileCopyFileCreationTime?: string;

      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      @header("x-ms-file-copy-file-last-write-time")
      fileCopyFileLastWriteTime?: string;

      @header("x-ms-file-change-time") fileChangeTime?: string;

      @header("x-ms-file-copy-file-change-time")
      fileCopyFileChangeTime?: string;

      @header("x-ms-file-copy-set-archive-attribute")
      fileCopySetArchiveAttribute?: boolean;

      @header("x-ms-lease-id") leaseId?: string;
      @header("x-ms-source-lease-id") sourceLeaseId?: string;

      @header("x-ms-copy-source-authorization")
      copySourceAuthorization?: string;

      ...FileRequestIntentParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      @header("x-ms-source-allow-trailing-dot")
      sourceAllowTrailingDot?: boolean;

      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;
      @header("x-ms-mode") mode?: string;

      @header("x-ms-file-copy-mode-copy-mode")
      fileCopyModeCopyMode?: ModeCopyMode;

      @header("x-ms-file-copy-owner-copy-mode")
      fileCopyOwnerCopyMode?: OwnerCopyMode;
    },
    {
      @statusCode statusCode: 202;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-copy-id") copyId: string;
      @header("x-ms-copy-status") copyStatus: string;
    }
  >;

  /**
   * Aborts a pending Copy File operation, and leaves a destination file with zero length and full metadata.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=copy&copyid")
  @put
  abortCopy is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-copy-action") copyActionAbort: "abort";
      @query copyid: string;
      ...TimeoutParameter;
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 204;
    }
  >;

  /**
   * Lists handles for file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=listhandles")
  @get
  listHandles is StorageOperationResponseBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...MarkerParameter;
      ...MaxResultsParameter;
      ...TimeoutParameter;
      @query sharesnapshot?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @body response: ListHandlesResponse;
    }
  >;

  /**
   * Closes all handles open for given file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=forceclosehandles")
  @put
  forceCloseHandles is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-handle-id") handleId: string;
      ...TimeoutParameter;
      ...MarkerParameter;
      @query sharesnapshot?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @header("x-ms-number-of-handles-closed") numberOfHandlesClosed: int32;
      @header("x-ms-number-of-handles-failed") numberOfHandlesFailed: int32;
    }
  >;

  /**
   * Renames a file. By default, the destination is overwritten and if the destination already exists and has a read-only attribute set, the operation will fail.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=rename")
  @put
  rename is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      @header("x-ms-rename-source") renameSource: string;
      ...TimeoutParameter;

      @header("x-ms-file-rename-replace-if-exists")
      renameReplaceIfExists?: boolean;

      @header("x-ms-file-rename-ignore-read-only")
      renameIgnoreReadOnly?: boolean;

      @header("x-ms-source-lease-id") sourceLeaseId?: string;
      @header("x-ms-destination-lease-id") destinationLeaseId?: string;
      ...FileRequestIntentParameter;

      @header("x-ms-source-allow-trailing-dot")
      sourceAllowTrailingDot?: boolean;

      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
    }
  >;

  /**
   * Creates a symbolic link to a target file. NFS only.
   */
  @route("/{shareName}/{directory}/{fileName}?restype=symboliclink")
  @put
  createSymbolicLink is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      @header("x-ms-file-permission") filePermission?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      ...FileRequestIntentParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;
      @header("x-ms-mode") mode?: string;
      @header("x-ms-link-text") linkText: string;
    },
    {
      @statusCode statusCode: 201;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
    }
  >;

  /**
   * Returns the target of a symbolic link. NFS only.
   */
  @route("/{shareName}/{directory}/{fileName}?restype=symboliclink")
  @get
  getSymbolicLink is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 200;
      @header("x-ms-meta-*") metadata?: Record<string>;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
      @header("x-ms-link-text") linkText: string;
    }
  >;

  /**
   * Creates a hard link to a target file. NFS only.
   */
  @route("/{shareName}/{directory}/{fileName}?restype=hardlink")
  @put
  createHardLink is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
      @header("x-ms-target-file") targetFile: string;
    },
    {
      @statusCode statusCode: 201;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
    }
  >;
}
