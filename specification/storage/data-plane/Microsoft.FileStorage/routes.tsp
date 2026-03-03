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
      ...ShareQuotaOptionalHeader;

      /** Specifies the access tier of the share. */
      @header("x-ms-access-tier") accessTier?: ShareAccessTier;

      /** Protocols to enable on the share. */
      @header("x-ms-enabled-protocols") enabledProtocols?: string;

      /** Root squash to set on the share. Only valid for NFS shares. */
      @header("x-ms-root-squash") rootSquash?: ShareRootSquash;

      /** Optional. Used to enable snapshot virtual directory access. */
      @header("x-ms-enable-snapshot-virtual-directory-access")
      enableSnapshotVirtualDirectoryAccess?: boolean;

      ...PaidBurstingRequestHeaders;
      ...FileRequestIntentParameter;

      /** Optional. Specifies the provisioned IOPS of the share. */
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

      /** Optional. Specifies the provisioned bandwidth of the share, in MiBps. */
      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

      /** Optional. Used to enable SMB directory lease. */
      @header("x-ms-enable-smb-directory-lease")
      enableSmbDirectoryLease?: boolean;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      /** The share quota. */
      @header("x-ms-share-quota") shareQuota?: int32;

      /** The provisioned IOPS. */
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

      /** The provisioned bandwidth. */
      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

      /** The included burst IOPS. */
      @header("x-ms-share-included-burst-iops") shareIncludedBurstIops?: int64;

      /** The maximum burst credits for IOPS. */
      @header("x-ms-share-max-burst-credits-for-iops")
      shareMaxBurstCreditsForIops?: int64;
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
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

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

      /** The next allowed quota downgrade time. */
      @header("x-ms-share-next-allowed-quota-downgrade-time")
      shareNextAllowedQuotaDowngradeTime?: string;

      /** The provisioned bandwidth for the share. */
      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

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

      /** The approximate size of the data stored on the share. */
      @header("x-ms-file-share-usage-bytes") shareUsageBytes?: int64;

      /** The approximate size of the data stored on the share snapshot. */
      @header("x-ms-file-share-snapshot-usage-bytes") shareSnapshotUsageBytes?: int64;
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
      @header("x-ms-lease-duration") leaseDuration?: int32;

      /** Proposed lease ID, in a GUID string format. The File service returns 400 (Invalid request) if the proposed lease ID is not in the correct format. See Guid Constructor (String) for a list of valid GUID string formats. */
      @header("x-ms-proposed-lease-id") proposedLeaseId?: string;

      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

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
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
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
      @header("x-ms-proposed-lease-id") proposedLeaseId?: string;

      ...TimeoutParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

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
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

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

      ...LeaseIdParameter;
      ...ShareSnapshotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      /** Approximate time remaining in the lease period, in seconds. */
      @header("x-ms-lease-time") leaseTime?: string;

      /** Uniquely identifies a share's lease */
      @header("x-ms-lease-id") leaseId?: string;
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
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

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

      /** Optional. Used to enable snapshot virtual directory access. */
      @header("x-ms-enable-snapshot-virtual-directory-access")
      enableSnapshotVirtualDirectoryAccess?: boolean;

      ...PaidBurstingRequestHeaders;
      ...FileRequestIntentParameter;
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

      /** Optional. Used to enable SMB directory lease. */
      @header("x-ms-enable-smb-directory-lease")
      enableSmbDirectoryLease?: boolean;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      /** The current share quota. */
      @header("x-ms-share-quota") shareQuota?: int32;

      /** The share provisioned IOPS. */
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

      /** The share provisioned bandwidth in mebibytes per second. */
      @header("x-ms-share-provisioned-bandwidth-mibps")
      shareProvisionedBandwidthMibps?: int32;

      /** The share included burst IOPS. */
      @header("x-ms-share-included-burst-iops") shareIncludedBurstIops?: int32;

      /** The share max burst credits for IOPS. */
      @header("x-ms-share-max-burst-credits-for-iops")
      shareMaxBurstCreditsForIops?: int64;

      /** Approximate time remaining in the share's existing downgrade request. */
      @header("x-ms-share-next-allowed-quota-downgrade-time")
      shareNextAllowedQuotaDowngradeTime?: string;

      /** Approximate time remaining in the share's existing provisioned IOPS downgrade request. */
      @header("x-ms-share-next-allowed-provisioned-iops-downgrade-time")
      shareNextAllowedProvisionedIopsDowngradeTime?: string;

      /** Approximate time remaining in the share's existing provisioned bandwidth downgrade request. */
      @header("x-ms-share-next-allowed-provisioned-bandwidth-downgrade-time")
      shareNextAllowedProvisionedBandwidthDowngradeTime?: string;
    }
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
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
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
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
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
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
    }
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
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
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
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      @header("x-ms-share-quota") shareQuota?: int32;
      @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;
      @header("x-ms-share-provisioned-bandwidth-mibps") shareProvisionedBandwidthMibps?: int32;
      @header("x-ms-share-included-burst-iops") shareIncludedBurstIops?: int32;
      @header("x-ms-share-max-burst-credits-for-iops") shareMaxBurstCreditsForIops?: int64;
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
      ...FileSmtPropertyRequestHeaders;
      ...FilePermissionFormatParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;

      /** SMB only. Default value is New. */
      @header("x-ms-file-property-semantics")
      filePropertySemantics?: FilePropertySemantics;
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
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...FileSmtPropertyResponseHeaders;

      /** Whether server-encrypted. */
      @header("x-ms-server-encrypted") serverEncrypted?: boolean;

      ...NfsResponseHeaders;
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

      @header("x-ms-mode") mode?: string;
      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;
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
  @route("/{shareName}/{directory}?restype=directory&comp=list")
  @get
  listFilesAndDirectoriesSegment is StorageOperationResponseBody<
    {
      @path shareName: string;
      @path directory: string;
      ...PrefixParameter;
      ...ShareSnapshotParameter;
      ...MarkerParameter;
      ...MaxResultsParameter;
      @query include?: string[];
      ...TimeoutParameter;
      @header("x-ms-file-extended-info") fileExtendedInfo?: boolean;
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
      ...RecursiveParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      /** A string describing next handle to be closed. */
      @header("x-ms-marker") marker?: string;

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
      ...TimeoutParameter;
      ...RenameRequestHeaders;

      /** Required if the destination has an active lease. */
      @header("x-ms-destination-lease-id") destinationLeaseId?: string;

      /** If specified, the provided file attributes shall be set. */
      @header("x-ms-file-attributes") fileAttributes?: string;

      /** Creation time for the directory. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** Last write time for the directory. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** Change time for the directory. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** If specified the permission shall be set for the directory. */
      @header("x-ms-file-permission") filePermission?: string;

      ...FilePermissionFormatParameter;

      /** Key of the permission to be set. */
      @header("x-ms-file-permission-key") filePermissionKey?: string;

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
      @header("x-ms-type") fileType: string;

      ...FileContentRequestHeaders;
      ...MetadataHeaders;
      ...FileSmtPropertyRequestHeaders;
      ...FilePermissionFormatParameter;
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;

      /** Optional, NFS only. Type of the file or directory. */
      @header("x-ms-file-file-type") nfsFileType?: NfsFileType;

      /** An MD5 hash of the content. This hash is used to verify the integrity of the data during transport. */
      @header("Content-MD5") contentMd5?: string;

      /** SMB only. Default value is New. */
      @header("x-ms-file-property-semantics")
      filePropertySemantics?: FilePropertySemantics;

      /** Optional. Specifies the content length of the file. */
      @header("Content-Length") optionalContentLength?: int64;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;
      ...NfsResponseHeaders;

      /** An MD5 hash returned for the content. */
      @header("Content-MD5") contentMd5?: string;

      /** Content length of the file. */
      @header("Content-Length") contentLength?: int64;
    }
  >;

  /**
   * Reads or downloads a file from the system, including its metadata and properties.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @get
  download is StorageOperationNoBody<
    {
      /** The name of the target share. */
      @path shareName: string;

      /** The path of the target directory. */
      @path directory: string;

      /** The path of the target file. */
      @path fileName: string;

      ...TimeoutParameter;
      ...RangeHeader;

      /** When this header is set to true and specified together with the Range header, the service returns the MD5 hash for the range, as long as the range is less than or equal to 4 MB in size. */
      @header("x-ms-range-get-content-md5") getContentMd5?: boolean;

      ...LeaseIdParameter;
      ...FileRequestIntentParameter;

      /** Optional. Used for structured get operations. */
      @header("x-ms-structured-body") structuredBodyGet?: string;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Specifying supported status codes for download operation."
      @statusCode statusCode: 200 | 206;
      @header("Last-Modified") lastModified: string;
      ...MetadataHeaders;
      @header("Content-Length") contentLength: int64;
      @header("Content-Type") contentType?: string;
      @header("Content-Range") contentRange?: string;
      @header("ETag") etag: string;
      @header("Content-MD5") contentMd5?: string;
      @header("Content-Encoding") contentEncoding?: string;
      @header("Cache-Control") cacheControl?: string;
      @header("Content-Disposition") contentDisposition?: string;
      @header("Content-Language") contentLanguage?: string;
      @header("Accept-Ranges") acceptRanges?: string;
      ...CopyStatusResponseHeaders;

      /** The MD5 hash of the full file content. */
      @header("x-ms-content-md5") fileContentMd5?: string;

      /** The value of this header indicates whether the file data and application metadata are completely encrypted. */
      @header("x-ms-server-encrypted") serverEncrypted?: boolean;

      ...FileSmtPropertyResponseHeaders;
      ...LeaseResponseHeaders;

      /** Structured body response header. */
      @header("x-ms-structured-body") structuredBody?: string;

      /** Structured content length. */
      @header("x-ms-structured-content-length") structuredContentLength?: int64;

      ...NfsResponseHeaders;

      /** NFS only. The link count. */
      @header("x-ms-link-count") linkCount?: int32;

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
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
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
      ...CopyStatusResponseHeaders;

      /** The value of this header indicates whether the file data and application metadata are completely encrypted. */
      @header("x-ms-server-encrypted") serverEncrypted?: boolean;

      ...FileSmtPropertyResponseHeaders;
      ...LeaseResponseHeaders;
      ...NfsResponseHeaders;

      /** NFS only. The link count. */
      @header("x-ms-link-count") linkCount?: int32;
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
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 202;

      /** NFS only. The link count. */
      @header("x-ms-link-count") linkCount?: int32;
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

      /** Specifies the number of bytes being transmitted. */
      @header("x-ms-content-length") fileContentLength?: int64;

      ...FileContentRequestHeaders;
      ...FileSmtPropertyRequestHeaders;
      ...FilePermissionFormatParameter;
      ...LeaseIdParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      ...RequestServerEncryptedResponseHeader;
      ...FileSmtPropertyResponseHeaders;

      @header("x-ms-mode") mode?: string;
      @header("x-ms-owner") owner?: string;
      @header("x-ms-group") group?: string;

      /** NFS only. The link count. */
      @header("x-ms-link-count") linkCount?: int32;
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
      ...LeaseIdParameter;
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
  @route("/{shareName}/{directory}/{fileName}?comp=lease&acquire")
  @put
  acquireLease is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;

      /** Specifies the duration of the lease, in seconds, or negative one (-1) for a lease that never expires. A non-infinite lease can be between 15 and 60 seconds. A lease duration cannot be changed using renew or change. */
      @header("x-ms-lease-duration") leaseDuration?: int32;

      /** Proposed lease ID, in a GUID string format. */
      @header("x-ms-proposed-lease-id") proposedLeaseId?: string;

      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
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
  @route("/{shareName}/{directory}/{fileName}?comp=lease&change")
  @put
  changeLease is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;

      /** The lease ID of the active lease. */
      @header("x-ms-lease-id") leaseId: string;

      /** Proposed lease ID, in a GUID string format. */
      @header("x-ms-proposed-lease-id") proposedLeaseId?: string;

      ...TimeoutParameter;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      @header("x-ms-lease-id") returnedLeaseId: string;
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
      ...LeaseIdParameter;
      ...FileRequestIntentParameter;
      ...AllowTrailingDotParameter;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      /** Uniquely identifies a file's lease */
      @header("x-ms-lease-id") leaseId?: string;
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

      /** Specifies the range of bytes to be written. Both the start and end of the range must be specified. */
      @header("x-ms-range") targetRange: string;

      /** Specify one of the following options: - Update: Writes the bytes specified by the request body into the specified range. - Clear: Clears the specified range and releases the space used in storage for that range. */
      @header("x-ms-write") fileRangeWrite: "update" | "clear";

      @header("Content-Length") contentLength: int64;
      ...TimeoutParameter;

      /** An MD5 hash of the content. This hash is used to verify the integrity of data during transport. */
      @header("Content-MD5") contentMd5?: string;

      ...LeaseIdParameter;

      /** If the file last write time should be preserved or overwritten. */
      @header("x-ms-file-last-write-time")
      fileLastWriteTimeMode?: FileLastWrittenMode;

      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;

      /** Optional. Used for structured put operations. */
      @header("x-ms-structured-body") structuredBodyPut?: string;

      /** Optional. Used for structured put operations to specify content length. */
      @header("x-ms-structured-content-length") structuredContentLength?: int64;

      @body content?: bytes;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;
      @header("Content-MD5") contentMd5?: string;
      ...RequestServerEncryptedResponseHeader;

      /** The file last write time. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** Structured body response header. */
      @header("x-ms-structured-body") structuredBody?: string;
    },
    "application/octet-stream"
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
      @header("x-ms-source-range") sourceRange?: string;

      /** Only update is supported. */
      @header("x-ms-write") fileRangeWriteFromUrl: "update";

      @header("Content-Length") contentLength: int64;
      ...TimeoutParameter;

      /** Specify the CRC64 hash of the source content. */
      @header("x-ms-source-content-crc64") sourceContentCrc64?: string;

      /** Specify the CRC64 hash value to check for source content integrity. */
      @header("x-ms-source-if-match-crc64") sourceIfMatchCrc64?: string;

      /** Specify the CRC64 hash value to check for source content mismatch. */
      @header("x-ms-source-if-none-match-crc64")
      sourceIfNoneMatchCrc64?: string;

      ...LeaseIdParameter;

      /** Only Bearer type is supported. Credentials should be a valid OAuth access token to copy source. */
      @header("x-ms-copy-source-authorization")
      copySourceAuthorization?: string;

      /** If the file last write time should be preserved or overwritten. */
      @header("x-ms-file-last-write-time")
      fileLastWriteTimeMode?: FileLastWrittenMode;

      ...AllowTrailingDotParameter;
      ...SourceAllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      /** CRC64 hash of the range content. */
      @header("x-ms-content-crc64") contentCrc64?: string;

      ...RequestServerEncryptedResponseHeader;

      /** The file last write time. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
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

      /** The previous snapshot parameter is an opaque DateTime value that specifies a previous file snapshot to compare against. */
      @query prevsharesnapshot?: string;

      ...TimeoutParameter;
      ...RangeHeader;
      ...LeaseIdParameter;
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;

      /** This header is allowed only when PrevShareSnapshot query parameter is set. Determines whether the changed ranges for a file that has been renamed or moved should be listed. */
      @header("x-ms-file-support-rename") supportRename?: boolean;
    },
    {
      ...LastModifiedResponseHeader;
      ...EtagResponseHeader;

      /** The length of the file. */
      @header("x-ms-content-length") fileContentLength: int64;

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

      /** If specified the permission shall be set for the file. */
      @header("x-ms-file-permission") filePermission?: string;

      ...FilePermissionFormatParameter;

      /** Key of the permission to be set. */
      @header("x-ms-file-permission-key") filePermissionKey?: string;

      /** Specifies the option to copy file security descriptor from source file or to set it using the value which is defined by the header value of x-ms-file-permission or x-ms-file-permission-key. */
      @header("x-ms-file-permission-copy-mode")
      filePermissionCopyMode?: PermissionCopyModeType;

      /** A boolean value that specifies whether the ReadOnly attribute on a preexisting destination file should be respected or overridden. */
      @header("x-ms-file-copy-ignore-readonly")
      fileCopyIgnoreReadOnly?: boolean;

      /** If specified, the provided file attributes shall be set. */
      @header("x-ms-file-attributes") fileAttributes?: string;

      /** Creation time for the file. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** Last write time for the file. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** Change time for the file. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** Optional. Sets the archive attribute on the destination file. */
      @header("x-ms-file-copy-set-archive")
      fileCopySetArchiveAttribute?: boolean;

      ...LeaseIdParameter;
      ...AllowTrailingDotParameter;
      ...SourceAllowTrailingDotParameter;
      ...FileRequestIntentParameter;
      ...NfsRequestHeaders;

      /** Specifies mode copy option for the file. */
      @header("x-ms-file-mode-copy-mode")
      fileCopyModeCopyMode?: ModeCopyMode;

      /** Specifies owner copy option for the file. */
      @header("x-ms-file-owner-copy-mode")
      fileCopyOwnerCopyMode?: OwnerCopyMode;
    },
    {
      @statusCode statusCode: 202;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      /** String identifier for this copy operation. */
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
      ...LeaseIdParameter;
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
      ...AllowTrailingDotParameter;
      ...FileRequestIntentParameter;
    },
    {
      /** A string describing next handle to be closed. */
      @header("x-ms-marker") marker?: string;

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
      ...TimeoutParameter;
      ...RenameRequestHeaders;

      /** Required if the destination file has an active lease. */
      @header("x-ms-destination-lease-id") destinationLeaseId?: string;

      /** If specified, the provided file attributes shall be set. */
      @header("x-ms-file-attributes") fileAttributes?: string;

      /** Creation time for the file. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** Last write time for the file. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** Change time for the file. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** If specified the permission shall be set for the file. */
      @header("x-ms-file-permission") filePermission?: string;

      ...FilePermissionFormatParameter;

      /** Key of the permission to be set. */
      @header("x-ms-file-permission-key") filePermissionKey?: string;

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
  @route("/{shareName}/{directory}/{fileName}?restype=symboliclink")
  @put
  createSymbolicLink is StorageOperationNoBody<
    {
      @path shareName: string;
      @path directory: string;
      @path fileName: string;
      ...TimeoutParameter;
      ...MetadataHeaders;

      /** Creation time for the file. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** Last write time for the file. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      ...LeaseIdParameter;

      /** Optional, NFS only. The owner of the file or directory. */
      @header("x-ms-owner") owner?: string;

      /** Optional, NFS only. The owning group of the file or directory. */
      @header("x-ms-group") group?: string;

      /** NFS only. Required. The path to the original file, the symbolic link is pointing to. */
      @header("x-ms-link-text") linkText: string;

      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      /** The file creation time. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** The file last write time. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** The file change time. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** The fileId of the file. */
      @header("x-ms-file-id") fileId?: string;

      /** The parent fileId of the file. */
      @header("x-ms-file-parent-id") fileParentId?: string;

      ...NfsResponseHeaders;
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
      @query sharesnapshot?: string;
      ...FileRequestIntentParameter;
    },
    {
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

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

      /** Dummy type header, must be "file". */
      @header("x-ms-type") fileType: "file";

      ...LeaseIdParameter;

      /** NFS only. Required. Specifies the path of the target file to which the link will be created, up to 2 KiB in length. */
      @header("x-ms-file-target-file") targetFile: string;

      ...FileRequestIntentParameter;
    },
    {
      @statusCode statusCode: 201;
      ...EtagResponseHeader;
      ...LastModifiedResponseHeader;

      /** The file creation time. */
      @header("x-ms-file-creation-time") fileCreationTime?: string;

      /** The file last write time. */
      @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

      /** The file change time. */
      @header("x-ms-file-change-time") fileChangeTime?: string;

      /** The fileId of the file. */
      @header("x-ms-file-id") fileId?: string;

      /** The parent fileId of the file. */
      @header("x-ms-file-parent-id") fileParentId?: string;

      /** Number of hard links to the file. */
      @header("x-ms-link-count") linkCount?: int32;

      ...NfsResponseHeaders;
    }
  >;
}
