import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureFileStorage;

/** Azure Storage File basic operation template */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing storage API."
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
      ...ShareQuotaOptionalHeader;

      /** Specifies the access tier of the share. */
      @header("x-ms-access-tier") accessTier?: ShareAccessTier;

      /** Protocols to enable on the share. */
      @header("x-ms-enabled-protocols") enabledProtocols?: string;

      /** Root squash to set on the share. Only valid for NFS shares. */
      @header("x-ms-root-squash") rootSquash?: ShareRootSquash;

      /** If specified the permission (security descriptor) shall be set for the directory/file. This header can be used if Permission size is <= 8KB, else x-ms-file-permission-key header shall be used. Default value: Inherit. If SDDL is specified as input, it must have owner, group and dacl. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
      @header("x-ms-file-permission") filePermission?: string;

      /** If specified, the provided file attributes shall be set. Default value: 'Archive' for file and 'Directory' for directory. 'None' can also be specified as default. */
      @header("x-ms-file-attributes") fileAttributes?: string;

      /** Creation time for the file/directory. Default value: Now. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** Last write time for the file/directory. Default value: Now. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** Change time for the file/directory. Default value: Now. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** Optional. Used to set permission format for shares. */
      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      /** Optional. Supported in version 2025-01-05 and later. Only allowed for provisioned v2 file shares. Specifies the provisioned number of input/output operations per second (IOPS) of the share. If this is not specified, the provisioned IOPS is set to value calculated based on recommendation formula. */
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

      /** Optional. Supported in version 2025-01-05 and later. Only allowed for provisioned v2 file shares. Specifies the provisioned bandwidth of the share, in mebibytes per second (MiBps). If this is not specified, the provisioned bandwidth is set to value calculated based on recommendation formula. */
      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

      /** Optional. Boolean. Default if not specified is false. This property enables paid bursting. */
      @header("x-ms-paid-bursting-enabled") paidBurstingEnabled?: boolean;

      /** Optional. Integer. Default if not specified is the maximum IOPS the file share can support. Current maximum for a file share is 102,400 IOPS. */
      @header("x-ms-paid-bursting-max-iops") paidBurstingMaxIops?: int64;

      /** Optional. Integer. Default if not specified is the maximum throughput the file share can support. Current maximum for a file share is 10,340 MiB/sec. */
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
      /** The name of the target share. */
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
      /** The name of the target share. */
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
      /** The name of the target share. */
      @path shareName: string;

      ...TimeoutParameter;

      /** Specifies the duration of the lease, in seconds, or negative one (-1) for a lease that never expires. A non-infinite lease can be between 15 and 60 seconds. A lease duration cannot be changed using renew or change. */
      @header("x-ms-lease-duration") leaseDuration: int32;

      /** Proposed lease ID, in a GUID string format. The File service returns 400 (Invalid request) if the proposed lease ID is not in the correct format. See Guid Constructor (String) for a list of valid GUID string formats. */
      @header("x-ms-proposed-lease-id") proposedLeaseId?: string;

      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;

      /** Uniquely identifies a share's lease */
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
      /** The name of the target share. */
      @path shareName: string;

      ...LeaseIdParameter;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {}
  >;

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&change")
  @put
  changeLease is StorageOperationNoBody<
    {
      /** The name of the target share. */
      @path shareName: string;

      ...LeaseIdParameter;

      /** Proposed lease ID, in a GUID string format. The File service returns 400 (Invalid request) if the proposed lease ID is not in the correct format. See Guid Constructor (String) for a list of valid GUID string formats. */
      @header("x-ms-proposed-lease-id") proposedLeaseId: string;

      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      /** Uniquely identifies a share's lease */
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
      /** The name of the target share. */
      @path shareName: string;

      ...LeaseIdParameter;
      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      /** Uniquely identifies a share's lease */
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
      /** The name of the target share. */
      @path shareName: string;

      ...TimeoutParameter;

      /** For a break operation, proposed duration the lease should continue before it is broken, in seconds, between 0 and 60. This break period is only used if it is shorter than the time remaining on the lease. If longer, the time remaining on the lease is used. A new lease will not be available before the break period has expired, but the lease may be held for longer than the break period. If this header does not appear with a break operation, a fixed-duration lease breaks after the remaining lease period elapses, and an infinite lease breaks immediately. */
      @header("x-ms-lease-break-period") leaseBreakPeriod?: int32;

      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 202;

      /** Approximate time remaining in the lease period, in seconds. */
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
      /** The name of the target share. */
      @path shareName: string;

      ...TimeoutParameter;
      ...MetadataHeaders;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;

      /** This header is a DateTime value that uniquely identifies the share snapshot. The value of this header may be used in subsequent requests to access the share snapshot. This value is opaque. */
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
      /** The name of the target share. */
      @path shareName: string;

      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      @body permission: SharePermission;
    },
    {
      @statusCode statusCode: 201;

      /** Key of the permission set for the directory/file. */
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
      /** The name of the target share. */
      @path shareName: string;

      /** Key of the permission to be set for the directory/file. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
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
      ...ShareQuotaOptionalHeader;
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
      /** The name of the target share. */
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
      /** The name of the target share. */
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
      /** The name of the target share. */
      @path shareName: string;

      ...TimeoutParameter;
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
      @body shareAcl?: SignedIdentifier[];
    },
    {}
  >;

  /**
   * Retrieves statistics related to the share.
   */
  @route("/{shareName}?restype=share&comp=stats")
  @get
  getStatistics is StorageOperationResponseBody<
    {
      /** The name of the target share. */
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
      /** The name of the target share. */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing storage API."
interface Directory {
  /**
   * Creates a new directory under the specified share or parent directory.
   */
  @route("/{shareName}/{directory}?restype=directory")
  @put
  create is StorageOperationNoBody<
    {
      /** The name of the target share. */
      @path shareName: string;

      /** The path of the target directory. */
      @path directory: string;

      ...TimeoutParameter;
      ...MetadataHeaders;

      /** If specified the permission (security descriptor) shall be set for the directory/file. This header can be used if Permission size is <= 8KB, else x-ms-file-permission-key header shall be used. Default value: Inherit. If SDDL is specified as input, it must have owner, group and dacl. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
      @header("x-ms-file-permission") filePermission?: string;

      /** Key of the permission to be set for the directory/file. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
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
      /** The name of the target share. */
      @path shareName: string;

      /** The path of the target directory. */
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
      /** The name of the target share. */
      @path shareName: string;

      /** The path of the target directory. */
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
      /** The name of the target share. */
      @path shareName: string;

      /** The path of the target directory. */
      @path directory: string;

      ...TimeoutParameter;

      /** If specified the permission (security descriptor) shall be set for the directory/file. This header can be used if Permission size is <= 8KB, else x-ms-file-permission-key header shall be used. Default value: Inherit. If SDDL is specified as input, it must have owner, group and dacl. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
      @header("x-ms-file-permission") filePermission?: string;

      /** Key of the permission to be set for the directory/file. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
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
      /** The name of the target share. */
      @path shareName: string;

      /** The path of the target directory. */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing storage API."
interface File {
  /**
   * Creates a new file or replaces a file. Note it only initializes the file with no content.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @put
  create is StorageOperationNoBody<
    {
      /** The name of the target share. */
      @path shareName: string;

      /** The path of the target directory. */
      @path directory: string;

      /** The path of the target file. */
      @path fileName: string;

      /** Specifies the number of bytes being transmitted in the request body. When the x-ms-write header is set to clear, the value of this header must be set to zero. */
      @header("x-ms-content-length") contentLength: int64;

      ...TimeoutParameter;

      /** Dummy constant parameter, file type can only be file. */
      @header("x-ms-type") fileType?: string;

      ...MetadataHeaders;

      /** If specified the permission (security descriptor) shall be set for the directory/file. This header can be used if Permission size is <= 8KB, else x-ms-file-permission-key header shall be used. Default value: Inherit. If SDDL is specified as input, it must have owner, group and dacl. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
      @header("x-ms-file-permission") filePermission?: string;

      /** Key of the permission to be set for the directory/file. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
      @header("x-ms-file-permission-key") filePermissionKey?: string;

      /** If specified, the provided file attributes shall be set. Default value: 'Archive' for file and 'Directory' for directory. 'None' can also be specified as default. */
      @header("x-ms-file-attributes") fileAttributes?: string;

      /** Creation time for the file/directory. Default value: Now. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** Last write time for the file/directory. Default value: Now. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** Change time for the file/directory. Default value: Now. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** Sets the MIME content type of the file. The default type is 'application/octet-stream'. */
      @header("Content-Type") contentType?: string;

      /** Specifies which content encodings have been applied to the file. */
      @header("Content-Encoding") contentEncoding?: string;

      /** Specifies the natural languages used by this resource. */
      @header("Content-Language") contentLanguage?: string;

      /** Sets the file's cache control. The File service stores this value but does not use or modify it. */
      @header("Cache-Control") cacheControl?: string;

      /** An MD5 hash of the content. This hash is used to verify the integrity of the data during transport. When the Content-MD5 header is specified, the File service compares the hash of the content that has arrived with the header value that was sent. If the two hashes do not match, the operation will fail with error code 400 (Bad Request). */
      @header("Content-MD5") contentMd5?: string;

      /** Sets the file's Content-Disposition header. */
      @header("Content-Disposition") contentDisposition?: string;

      /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
      @header("x-ms-lease-id") leaseId?: string;

      ...FileRequestIntentParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      /** Optional, NFS only. The owner of the file or directory. */
      @header("x-ms-owner") owner?: string;

      /** Optional, NFS only. The owning group of the file or directory. */
      @header("x-ms-group") group?: string;

      /** Optional, NFS only. The file mode of the file or directory */
      @header("x-ms-mode") mode?: string;

      /** Optional, NFS only. Type of the file or directory. */
      @header("x-ms-nfs-file-type") nfsFileType?: NfsFileType;

      /** If true, the trailing dot will not be trimmed from the target URI. */
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
      /** The name of the target share. */
      @path shareName: string;

      /** The path of the target directory. */
      @path directory: string;

      /** The path of the target file. */
      @path fileName: string;

      ...TimeoutParameter;

      /** The snapshot parameter is an opaque DateTime value that, when present, specifies the share snapshot to query. */
      @query sharesnapshot?: string;

      /** Return file data only from the specified byte range. */
      @header("Range") range?: string;

      /** When this header is set to true and specified together with the Range header, the service returns the MD5 hash for the range, as long as the range is less than or equal to 4 MB in size. */
      @header("x-ms-range-get-content-md5") getContentMd5?: boolean;

      /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
      @header("x-ms-lease-id") leaseId?: string;

      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
      @header("x-ms-structured-body-get") structuredBodyGet?: string;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Specifying suppported status codes for download operation."
      @statusCode statusCode: 200 | 206;
      @header("Last-Modified") lastModified: string;
      ...MetadataHeaders;
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
      @header("Last-Modified") lastModified: string;
      ...MetadataHeaders;
      @header("x-ms-type") fileType: string;
      @header("Content-Length") contentLength: int64;
      #suppress "@typespec/http/content-type-ignored" "This is a HEAD operation"
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
      /** Specifies the duration of the lease, in seconds, or negative one (-1) for a lease that never expires. A non-infinite lease can be between 15 and 60 seconds. A lease duration cannot be changed using renew or change. */
      @header("x-ms-lease-duration") leaseDuration: int32;
      /** Proposed lease ID, in a GUID string format. The File service returns 400 (Invalid request) if the proposed lease ID is not in the correct format. See Guid Constructor (String) for a list of valid GUID string formats. */
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
      /** The lease ID of the active lease. */
      @header("x-ms-lease-id") leaseId: string;
      /** Proposed lease ID, in a GUID string format. The File service returns 400 (Invalid request) if the proposed lease ID is not in the correct format. See Guid Constructor (String) for a list of valid GUID string formats. */
      @header("x-ms-proposed-lease-id") proposedLeaseId: string;
      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
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
      /** For a break operation, proposed duration the lease should continue before it is broken, in seconds, between 0 and 60. This break period is only used if it is shorter than the time remaining on the lease. If longer, the time remaining on the lease is used. A new lease will not be available before the break period has expired, but the lease may be held for longer than the break period. If this header does not appear with a break operation, a fixed-duration lease breaks after the remaining lease period elapses, and an infinite lease breaks immediately. */
      @header("x-ms-lease-break-period") leaseBreakPeriod?: int32;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @statusCode statusCode: 202;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      /** Approximate time remaining in the lease period, in seconds. */
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
      /** Specifies the range of bytes to be written. Both the start and end of the range must be specified. For an update operation, the range can be up to 4 MB in size. For a clear operation, the range can be up to the value of the file's full size. */
      @header("x-ms-range") targetRange: string;
      /** Specify one of the following options: - Update: Writes the bytes specified by the request body into the specified range. The Range and Content-Length headers must match to perform the update. - Clear: Clears the specified range and releases the space used in storage for that range. */
      @header("x-ms-write") fileRangeWrite: "update" | "clear";
      @header("Content-Length") contentLength: int64;
      ...TimeoutParameter;
      /** An MD5 hash of the content. This hash is used to verify the integrity of data during transport. When the Content-MD5 header is specified, the File service compares the hash of the content that has arrived with the header value that was sent. */
      @header("Content-MD5") contentMd5?: string;
      /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      /** If true, the trailing dot will not be trimmed from the target URI. */
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
      /** Optional. Used for structured put operations. */
      @header("x-ms-structured-body-put") structuredBodyPut?: string;
      /** Optional. Used for structured put operations to specify content length. */
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
      /** Specifies the range of bytes to be written. Both the start and end of the range must be specified. */
      @header("x-ms-range") targetRange: string;
      /** Specifies the URL of the source file or blob, up to 2 KB in length. */
      @header("x-ms-copy-source") copySource: string;
      /** Bytes of source data in the specified range. */
      @header("x-ms-source-range") sourceRange: string;
      @header("Content-Length") contentLength: int64;
      ...TimeoutParameter;
      /** Specify the CRC64 hash of the source content. */
      @header("x-ms-source-content-crc64") sourceContentCrc64?: string;
      /** Specify the CRC64 hash value to check for source content integrity. */
      @header("x-ms-source-if-match-crc64") sourceIfMatchCrc64?: string;

      /** Specify the CRC64 hash value to check for source content mismatch. */
      @header("x-ms-source-if-none-match-crc64")
      sourceIfNoneMatchCrc64?: string;

      /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
      @header("x-ms-lease-id") leaseId?: string;
      /** Specify the lease ID for the source if applicable. */
      @header("x-ms-source-lease-id") sourceLeaseId?: string;

      /** Only one of the x-ms-copy-source-authorization, x-ms-source-lease-id or x-ms-source-if-match-crc64 should be specified. */
      @header("x-ms-copy-source-authorization")
      copySourceAuthorization?: string;

      ...FileRequestIntentParameter;

      /** If true, the trailing dot will not be trimmed from the source URI. */
      @header("x-ms-source-allow-trailing-dot")
      sourceAllowTrailingDot?: boolean;

      /** If true, the trailing dot will not be trimmed from the target URI. */
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
      /** Return file data only from the specified byte range. */
      @header("Range") range?: string;
      /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
      @header("x-ms-lease-id") leaseId?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
      @header("Last-Modified") lastModified: string;
      @header("ETag") etag: string;
      /** The length of the file. */
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
      /** Specifies the URL of the source file or blob, up to 2 KB in length. */
      @header("x-ms-copy-source") copySource: string;
      ...TimeoutParameter;
      ...MetadataHeaders;
      @header("x-ms-file-permission") filePermission?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;

      /** Specifies the option to copy file security descriptor from source file or to set it using the value which is defined by the header value of x-ms-file-permission or x-ms-file-permission-key. */
      @header("x-ms-file-permission-copy-mode")
      filePermissionCopyMode?: PermissionCopyModeType;

      /** A boolean value that specifies whether the ReadOnly attribute on a preexisting destination file should be respected or overridden. */
      @header("x-ms-file-copy-ignore-read-only")
      fileCopyIgnoreReadOnly?: boolean;

      @header("x-ms-file-attributes") fileAttributes?: string;
      /** Specifies either the option to copy file attributes from a source file(source) to a target file or a list of attributes to set on a target file. */
      @header("x-ms-file-copy-file-attributes") fileCopyFileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** Specifies either the option to copy file creation time from a source file(source) to a target file or a time value in ISO 8601 format to set as creation time on a target file. */
      @header("x-ms-file-copy-file-creation-time")
      fileCopyFileCreationTime?: string;

      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** Specifies either the option to copy file last write time from a source file(source) to a target file or a time value in ISO 8601 format to set as last write time on a target file. */
      @header("x-ms-file-copy-file-last-write-time")
      fileCopyFileLastWriteTime?: string;

      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** Specifies either the option to copy file change time from a source file(source) to a target file or a time value in ISO 8601 format to set as change time on a target file. */
      @header("x-ms-file-copy-file-change-time")
      fileCopyFileChangeTime?: string;

      /** Optional. Sets the archive attribute on the destination file. This attribute is only valid when specified in a copy operation from Blob Storage to File Storage. */
      @header("x-ms-file-copy-set-archive-attribute")
      fileCopySetArchiveAttribute?: boolean;

      /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
      @header("x-ms-lease-id") leaseId?: string;
      /** Required if the source file has an active lease. The lease ID specified for this header must match the lease ID of the source file. */
      @header("x-ms-source-lease-id") sourceLeaseId?: string;

      /** Only Bearer type is supported. Credentials should be a valid OAuth access token to copy source. */
      @header("x-ms-copy-source-authorization")
      copySourceAuthorization?: string;

      ...FileRequestIntentParameter;

      @header("x-ms-file-permission-format")
      filePermissionFormat?: FilePermissionFormat;

      /** If true, the trailing dot will not be trimmed from the source URI. */
      @header("x-ms-source-allow-trailing-dot")
      sourceAllowTrailingDot?: boolean;

      /** If true, the trailing dot will not be trimmed from the target URI. */
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
      /** Optional, NFS only. The owner of the file or directory. */
      @header("x-ms-owner") owner?: string;
      /** Optional, NFS only. The owning group of the file or directory. */
      @header("x-ms-group") group?: string;
      /** Optional, NFS only. The file mode of the file or directory */
      @header("x-ms-mode") mode?: string;

      /** Specifies mode copy option for the file. */
      @header("x-ms-file-copy-mode-copy-mode")
      fileCopyModeCopyMode?: ModeCopyMode;

      /** Specifies owner copy option for the file. */
      @header("x-ms-file-copy-owner-copy-mode")
      fileCopyOwnerCopyMode?: OwnerCopyMode;
    },
    {
      @statusCode statusCode: 202;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      /** String identifier for this copy operation. Use with Get File or Get File Properties to check the status of this copy operation, or pass to Abort Copy File to abort a pending copy. */
      @header("x-ms-copy-id") copyId: string;
      /** State of the copy operation identified by x-ms-copy-id. */
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
      /** Must be the literal "abort" to abort the pending copy operation. */
      @header("x-ms-copy-action") copyActionAbort: "abort";
      /** The copy identifier provided in the x-ms-copy-id header of the original Copy File operation. */
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
      /** The snapshot parameter is an opaque DateTime value that, when present, specifies the share snapshot to query. */
      @query sharesnapshot?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
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
      /** Specifies handle ID opened on the file or directory to be closed. Asterisk ('*') is a wildcard that specifies all handles. */
      @header("x-ms-handle-id") handleId: string;
      ...TimeoutParameter;
      ...MarkerParameter;
      @query sharesnapshot?: string;
      ...FileRequestIntentParameter;
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
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
      /** Required. Specifies the URI-style path of the source file, up to 2 KB in length. */
      @header("x-ms-rename-source") renameSource: string;
      ...TimeoutParameter;

      /** Boolean. Default value is false. Set to true to indicate that the destination file should be overwritten, even if it already exists and has the read-only attribute set. */
      @header("x-ms-file-rename-replace-if-exists")
      renameReplaceIfExists?: boolean;

      /** Boolean. Default value is false. Set to true to overwrite the destination file even if it has the read-only attribute set. */
      @header("x-ms-file-rename-ignore-read-only")
      renameIgnoreReadOnly?: boolean;

      /** Required if the source file has an active lease. The lease ID specified for this header must match the lease ID of the source file. */
      @header("x-ms-source-lease-id") sourceLeaseId?: string;
      /** Required if the destination file has an active lease. The lease ID specified must match the lease ID of the destination file. */
      @header("x-ms-destination-lease-id") destinationLeaseId?: string;
      ...FileRequestIntentParameter;

      @header("x-ms-source-allow-trailing-dot")
      sourceAllowTrailingDot?: boolean;

      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;
    },
    {
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
      /** Optional, NFS only. The owner of the file or directory. */
      @header("x-ms-owner") owner?: string;
      /** Optional, NFS only. The owning group of the file or directory. */
      @header("x-ms-group") group?: string;
      /** Optional, NFS only. The file mode of the file or directory */
      @header("x-ms-mode") mode?: string;
      /** NFS only. Required. The path to the original file, the symbolic link is pointing to. The path is of type string which is not resolved and is stored as is. The path can be absolute path or the relative path depending on the content stored in the symbolic link file. */
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
      ...MetadataHeaders;
      @header("ETag") etag: string;
      @header("Last-Modified") lastModified: string;
      @header("x-ms-file-attributes") fileAttributes?: string;
      @header("x-ms-file-creation-time") fileCreationTime?: string;
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
      @header("x-ms-file-change-time") fileChangeTime?: string;
      @header("x-ms-file-permission-key") filePermissionKey?: string;
      @header("x-ms-file-id") fileId?: string;
      @header("x-ms-file-parent-id") fileParentId?: string;
      /** The path to the original file, the symbolic link is pointing to. */
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

      /** If true, the trailing dot will not be trimmed from the target URI. */
      @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean;

      /** NFS only. Required. Specifies the path of the target file to which the link will be created, up to 2 KiB in length. It should be full path of the target from the root.The target file must be in the same share and hence the same storage account. */
      @header("x-ms-target-file") targetFile: string;
    },
    {
      @statusCode statusCode: 201;

      /** The ETag of the file. */
      @header("ETag") etag: string;

      /** The last modified time of the file. */
      @header("Last-Modified") lastModified: string;

      /** The file permission key. */
      @header("x-ms-file-permission-key") filePermissionKey?: string;

      /** The file attributes. */
      @header("x-ms-file-attributes") fileAttributes?: string;

      /** The file creation time. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** The file last write time. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** The file change time. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** The fileId of the directory. */
      @header("x-ms-file-id") fileId?: string;

      /** The parent fileId of the directory. */
      @header("x-ms-file-parent-id") fileParentId?: string;
    }
  >;
}
