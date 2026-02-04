import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureFileStorage;

/**
 * Service operations
 */
interface Service {
  /**
   * Sets properties for a storage account's File service endpoint, including properties for Storage Analytics metrics and CORS (Cross-Origin Resource Sharing) rules.
   */
  @route("/?restype=service&comp=properties")
  @put
  setProperties(
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @body storageServiceProperties: StorageServiceProperties,
  ): {
    @statusCode statusCode: 202;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Gets the properties of a storage account's File service, including properties for Storage Analytics metrics and CORS (Cross-Origin Resource Sharing) rules.
   */
  @route("/?restype=service&comp=properties")
  @get
  getProperties(
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @body properties: StorageServiceProperties;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The List Shares Segment operation returns a list of the shares and share snapshots under the specified account.
   */
  @route("/?comp=list")
  @get
  listSharesSegment(
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query prefix?: string,
    @query marker?: string,
    @query maxresults?: int32,
    @query include?: string[], // ListSharesIncludeType values
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @body response: ListSharesResponse;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Retrieves a user delegation key for the File service. This can be used to generate a user delegation SAS.
   */
  @route("/?restype=service&comp=userdelegationkey")
  @post
  getUserDelegationKey(
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @body keyInfo: KeyInfo,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @body userDelegationKey: UserDelegationKey;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };
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
  create(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-share-quota") shareQuota?: int32,
    @header("x-ms-access-tier") accessTier?: ShareAccessTier,
    @header("x-ms-enabled-protocols") enabledProtocols?: string,
    @header("x-ms-root-squash") rootSquash?: ShareRootSquash,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-file-permission") filePermission?: string,
    @header("x-ms-file-attributes") fileAttributes?: string,
    @header("x-ms-file-creation-time") fileCreationTime?: string,
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string,
    @header("x-ms-file-change-time") fileChangeTime?: string,

    @header("x-ms-file-permission-format")
    filePermissionFormat?: FilePermissionFormat,

    @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32,

    @header("x-ms-share-provisioned-bandwidth-mibps")
    shareProvisionedBandwidthMibps?: int32,

    @header("x-ms-paid-bursting-enabled") paidBurstingEnabled?: boolean,
    @header("x-ms-paid-bursting-max-iops") paidBurstingMaxIops?: int64,

    @header("x-ms-paid-bursting-max-bandwidth-mibps")
    paidBurstingMaxBandwidthMibps?: int64,

    @header("x-ms-enable-snapshot-virtual-directory-access")
    enableSnapshotVirtualDirectoryAccess?: boolean,

    @header("x-ms-enable-smb-directory-lease")
    enableSmbDirectoryLease?: boolean,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Returns all user-defined metadata and system properties for the specified share or share snapshot.
   */
  @route("/{shareName}?restype=share")
  @get
  getProperties(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query sharesnapshot?: string,
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-lease-id") leaseId?: string,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("x-ms-meta-*") metadata?: Record<string>;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-share-quota") shareQuota: int32;
    @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32;

    @header("x-ms-share-provisioned-ingress-mbps")
    shareProvisionedIngressMbps?: int32;

    @header("x-ms-share-provisioned-egress-mbps")
    shareProvisionedEgressMbps?: int32;

    @header("x-ms-share-provisioned-bandwidth-mibps")
    shareProvisionedBandwidthMibps?: int32;

    @header("x-ms-share-next-allowed-quota-downgrade-time")
    shareNextAllowedQuotaDowngradeTime?: string;

    @header("x-ms-access-tier") accessTier?: string;
    @header("x-ms-access-tier-change-time") accessTierChangeTime?: string;

    @header("x-ms-access-tier-transition-state")
    accessTierTransitionState?: string;

    @header("x-ms-lease-duration") leaseDuration?: string;
    @header("x-ms-lease-state") leaseState: string;
    @header("x-ms-lease-status") leaseStatus: string;
    @header("x-ms-enabled-protocols") enabledProtocols?: string;
    @header("x-ms-root-squash") rootSquash?: string;

    @header("x-ms-enable-snapshot-virtual-directory-access")
    enableSnapshotVirtualDirectoryAccess?: boolean;

    @header("x-ms-paid-bursting-enabled") paidBurstingEnabled?: boolean;
    @header("x-ms-paid-bursting-max-iops") paidBurstingMaxIops?: int64;

    @header("x-ms-paid-bursting-max-bandwidth-mibps")
    paidBurstingMaxBandwidthMibps?: int64;

    @header("x-ms-included-burst-iops") includedBurstIops?: int64;
    @header("x-ms-max-burst-credits-for-iops") maxBurstCreditsForIops?: int64;

    @header("x-ms-share-next-allowed-provisioned-iops-downgrade-time")
    shareNextAllowedProvisionedIopsDowngradeTime?: string;

    @header("x-ms-share-next-allowed-provisioned-bandwidth-downgrade-time")
    shareNextAllowedProvisionedBandwidthDowngradeTime?: string;

    @header("x-ms-enable-smb-directory-lease")
    enableSmbDirectoryLease?: boolean;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Operation marks the specified share or share snapshot for deletion. The share or share snapshot and any files contained within it are later deleted during garbage collection.
   */
  @route("/{shareName}?restype=share")
  @delete
  delete(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query sharesnapshot?: string,
    @query timeout?: int32,

    @header("x-ms-delete-snapshots")
    deleteSnapshots?: DeleteSnapshotsOptionType,

    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-lease-id") leaseId?: string,
  ): {
    @statusCode statusCode: 202;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&acquire")
  @put
  acquireLease(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-lease-duration") leaseDuration: int32,
    @header("x-ms-proposed-lease-id") proposedLeaseId?: string,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-lease-id") leaseId: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&release")
  @put
  releaseLease(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-lease-id") leaseId: string,
    @query timeout?: int32,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&change")
  @put
  changeLease(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-lease-id") leaseId: string,
    @header("x-ms-proposed-lease-id") proposedLeaseId: string,
    @query timeout?: int32,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-lease-id") leaseId: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&renew")
  @put
  renewLease(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-lease-id") leaseId: string,
    @query timeout?: int32,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-lease-id") leaseId: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease Share operation establishes and manages a lock on a share for delete operations. The lock duration can be 15 to 60 seconds, or can be infinite.
   */
  @route("/{shareName}?restype=share&comp=lease&break")
  @put
  breakLease(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-lease-break-period") leaseBreakPeriod?: int32,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 202;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-lease-time") leaseTime?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Creates a read-only snapshot of a share.
   */
  @route("/{shareName}?restype=share&comp=snapshot")
  @put
  createSnapshot(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("x-ms-snapshot") snapshot: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Create a permission (a security descriptor). This is used to support file level ACLs for SMB shares.
   */
  @route("/{shareName}?restype=share&comp=filepermission")
  @put
  createPermission(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @body permission: SharePermission,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("x-ms-file-permission-key") filePermissionKey: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Returns the permission (security descriptor) for a given permission key. This is used to support file level ACLs for SMB shares.
   */
  @route("/{shareName}?restype=share&comp=filepermission")
  @get
  getPermission(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-file-permission-key") filePermissionKey: string,
    @query timeout?: int32,

    @header("x-ms-file-permission-format")
    filePermissionFormat?: FilePermissionFormat,

    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @body permission: SharePermission;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Sets properties for the specified share.
   */
  @route("/{shareName}?restype=share&comp=properties")
  @put
  setProperties(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-share-quota") shareQuota?: int32,
    @header("x-ms-access-tier") accessTier?: ShareAccessTier,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-root-squash") rootSquash?: ShareRootSquash,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-share-provisioned-iops") shareProvisionedIops?: int32,

    @header("x-ms-share-provisioned-bandwidth-mibps")
    shareProvisionedBandwidthMibps?: int32,

    @header("x-ms-paid-bursting-enabled") paidBurstingEnabled?: boolean,
    @header("x-ms-paid-bursting-max-iops") paidBurstingMaxIops?: int64,

    @header("x-ms-paid-bursting-max-bandwidth-mibps")
    paidBurstingMaxBandwidthMibps?: int64,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Sets one or more user-defined name-value pairs for the specified share.
   */
  @route("/{shareName}?restype=share&comp=metadata")
  @put
  setMetadata(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Returns information about stored access policies specified on the share that may be used with Shared Access Signatures.
   */
  @route("/{shareName}?restype=share&comp=acl")
  @get
  getAccessPolicy(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @body signedIdentifiers: SignedIdentifier[];
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Sets stored access policies for the share that may be used with Shared Access Signatures.
   */
  @route("/{shareName}?restype=share&comp=acl")
  @put
  setAccessPolicy(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @body shareAcl?: SignedIdentifier[],
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Retrieves statistics related to the share.
   */
  @route("/{shareName}?restype=share&comp=stats")
  @get
  getStatistics(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @body shareStats: ShareStats;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Restores a previously deleted share.
   */
  @route("/{shareName}?restype=share&comp=undelete")
  @put
  restore(
    @path shareName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-deleted-share-name") deletedShareName?: string,
    @header("x-ms-deleted-share-version") deletedShareVersion?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };
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
  create(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-file-permission") filePermission?: string,
    @header("x-ms-file-permission-key") filePermissionKey?: string,
    @header("x-ms-file-attributes") fileAttributes?: string,
    @header("x-ms-file-creation-time") fileCreationTime?: string,
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string,
    @header("x-ms-file-change-time") fileChangeTime?: string,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,

    @header("x-ms-file-permission-format")
    filePermissionFormat?: FilePermissionFormat,

    @header("x-ms-posix-permissions") posixPermissions?: string,
    @header("x-ms-posix-umask") posixUmask?: string,
    @header("x-ms-owner") owner?: string,
    @header("x-ms-group") group?: string,
    @header("x-ms-mode") mode?: string,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-file-permission-key") filePermissionKey?: string;
    @header("x-ms-file-attributes") fileAttributes?: string;
    @header("x-ms-file-creation-time") fileCreationTime?: string;
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
    @header("x-ms-file-change-time") fileChangeTime?: string;
    @header("x-ms-file-id") fileId?: string;
    @header("x-ms-file-parent-id") fileParentId?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Returns all system properties for the specified directory, and can also be used to check the existence of a directory.
   */
  @route("/{shareName}/{directory}?restype=directory")
  @get
  getProperties(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query sharesnapshot?: string,
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
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
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Removes the specified empty directory. Note that the directory must be empty before it can be deleted.
   */
  @route("/{shareName}/{directory}?restype=directory")
  @delete
  delete(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 202;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Sets properties for the specified directory.
   */
  @route("/{shareName}/{directory}?restype=directory&comp=properties")
  @put
  setProperties(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-file-permission") filePermission?: string,
    @header("x-ms-file-permission-key") filePermissionKey?: string,
    @header("x-ms-file-attributes") fileAttributes?: string,
    @header("x-ms-file-creation-time") fileCreationTime?: string,
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string,
    @header("x-ms-file-change-time") fileChangeTime?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,

    @header("x-ms-file-permission-format")
    filePermissionFormat?: FilePermissionFormat,

    @header("x-ms-posix-permissions") posixPermissions?: string,
    @header("x-ms-posix-umask") posixUmask?: string,
    @header("x-ms-owner") owner?: string,
    @header("x-ms-group") group?: string,
    @header("x-ms-mode") mode?: string,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-file-permission-key") filePermissionKey?: string;
    @header("x-ms-file-attributes") fileAttributes?: string;
    @header("x-ms-file-creation-time") fileCreationTime?: string;
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
    @header("x-ms-file-change-time") fileChangeTime?: string;
    @header("x-ms-file-id") fileId?: string;
    @header("x-ms-file-parent-id") fileParentId?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Sets one or more user-defined name-value pairs for the specified directory.
   */
  @route("/{shareName}/{directory}?restype=directory&comp=metadata")
  @put
  setMetadata(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Returns a list of files and directories under the specified share or directory. It lists the contents only for a single level of the directory hierarchy.
   */
  @route("/{shareName}/{directory}?restype=directory&comp=list")
  @get
  listFilesAndDirectoriesSegment(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query prefix?: string,
    @query marker?: string,
    @query maxresults?: int32,
    @query include?: string[], // ListFilesIncludeType values
    @query timeout?: int32,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-file-extended-info") fileExtendedInfo?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @body response: ListFilesAndDirectoriesSegmentResponse;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Lists handles for directory.
   */
  @route("/{shareName}/{directory}?comp=listhandles")
  @get
  listHandles(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query marker?: string,
    @query maxresults?: int32,
    @query timeout?: int32,
    @query sharesnapshot?: string,
    @query recursive?: boolean,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @body response: ListHandlesResponse;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Closes all handles open for given directory.
   */
  @route("/{shareName}/{directory}?comp=forceclosehandles")
  @put
  forceCloseHandles(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-handle-id") handleId: string,
    @query timeout?: int32,
    @query marker?: string,
    @query sharesnapshot?: string,
    @query recursive?: boolean,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("x-ms-number-of-handles-closed") numberOfHandlesClosed: int32;
    @header("x-ms-number-of-handles-failed") numberOfHandlesFailed: int32;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Renames a directory. By default, the destination is overwritten and if the destination already exists and has a read-only attribute set, the operation will fail.
   */
  @route("/{shareName}/{directory}?restype=directory&comp=rename")
  @put
  rename(
    @path shareName: string,
    @path directory: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-rename-source") renameSource: string,
    @query timeout?: int32,
    @header("x-ms-file-rename-replace-if-exists")
    renameReplaceIfExists?: boolean,
    @header("x-ms-file-rename-ignore-read-only") renameIgnoreReadOnly?: boolean,
    @header("x-ms-source-lease-id") sourceLeaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-source-allow-trailing-dot") sourceAllowTrailingDot?: boolean,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };
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
  create(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-content-length") contentLength: int64,
    @query timeout?: int32,
    @header("x-ms-type") fileType?: string,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-file-permission") filePermission?: string,
    @header("x-ms-file-permission-key") filePermissionKey?: string,
    @header("x-ms-file-attributes") fileAttributes?: string,
    @header("x-ms-file-creation-time") fileCreationTime?: string,
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string,
    @header("x-ms-file-change-time") fileChangeTime?: string,
    @header("Content-Type") contentType?: string,
    @header("Content-Encoding") contentEncoding?: string,
    @header("Content-Language") contentLanguage?: string,
    @header("Cache-Control") cacheControl?: string,
    @header("Content-MD5") contentMd5?: string,
    @header("Content-Disposition") contentDisposition?: string,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-file-permission-format")
    filePermissionFormat?: FilePermissionFormat,
    @header("x-ms-owner") owner?: string,
    @header("x-ms-group") group?: string,
    @header("x-ms-mode") mode?: string,
    @header("x-ms-nfs-file-type") nfsFileType?: NfsFileType,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-file-permission-key") filePermissionKey?: string;
    @header("x-ms-file-attributes") fileAttributes?: string;
    @header("x-ms-file-creation-time") fileCreationTime?: string;
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
    @header("x-ms-file-change-time") fileChangeTime?: string;
    @header("x-ms-file-id") fileId?: string;
    @header("x-ms-file-parent-id") fileParentId?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Reads or downloads a file from the system, including its metadata and properties.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @get
  download(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @query sharesnapshot?: string,
    @header("Range") range?: string,
    @header("x-ms-range-get-content-md5") getContentMd5?: boolean,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
    @header("x-ms-structured-body-get") structuredBodyGet?: string,
  ): {
    @statusCode statusCode: 200 | 206;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-meta-*") metadata?: Record<string>;
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
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 416 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Returns all user-defined metadata, standard HTTP properties, and system properties for the file.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @head
  getProperties(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query sharesnapshot?: string,
    @query timeout?: int32,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
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
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Removes the file from the storage account.
   */
  @route("/{shareName}/{directory}/{fileName}")
  @delete
  delete(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 202;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Sets HTTP headers on a file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=properties")
  @put
  setHTTPHeaders(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-file-permission") filePermission?: string,
    @header("x-ms-file-permission-key") filePermissionKey?: string,
    @header("x-ms-file-attributes") fileAttributes?: string,
    @header("x-ms-file-creation-time") fileCreationTime?: string,
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string,
    @header("x-ms-file-change-time") fileChangeTime?: string,
    @header("x-ms-file-last-write-time-mode")
    fileLastWriteTimeMode?: FileLastWrittenMode,
    @header("Content-Length") contentLength?: int64,
    @header("Content-Type") contentType?: string,
    @header("Content-Encoding") contentEncoding?: string,
    @header("Content-Language") contentLanguage?: string,
    @header("Cache-Control") cacheControl?: string,
    @header("Content-MD5") contentMd5?: string,
    @header("Content-Disposition") contentDisposition?: string,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-file-permission-format")
    filePermissionFormat?: FilePermissionFormat,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
    @header("x-ms-file-property-semantics")
    filePropertySemantics?: FilePropertySemantics,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-file-permission-key") filePermissionKey?: string;
    @header("x-ms-file-attributes") fileAttributes?: string;
    @header("x-ms-file-creation-time") fileCreationTime?: string;
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
    @header("x-ms-file-change-time") fileChangeTime?: string;
    @header("x-ms-file-id") fileId?: string;
    @header("x-ms-file-parent-id") fileParentId?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Sets one or more user-defined name-value pairs for the specified file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=metadata")
  @put
  setMetadata(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=lease&acquire")
  @put
  acquireLease(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-lease-duration") leaseDuration: int32,
    @header("x-ms-proposed-lease-id") proposedLeaseId?: string,
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-lease-id") leaseId: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=lease&release")
  @put
  releaseLease(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-lease-id") leaseId: string,
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=lease&change")
  @put
  changeLease(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-lease-id") leaseId: string,
    @header("x-ms-proposed-lease-id") proposedLeaseId: string,
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-lease-id") leaseId: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * The Lease File operation establishes and manages a lock on a file for write and delete operations.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=lease&break")
  @put
  breakLease(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-lease-break-period") leaseBreakPeriod?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 202;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-lease-time") leaseTime?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Upload a range of bytes to a file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=range")
  @put
  uploadRange(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-range") targetRange: string,
    @header("x-ms-write") fileRangeWrite: "update" | "clear",
    @header("Content-Length") contentLength: int64,
    @query timeout?: int32,
    @header("Content-MD5") contentMd5?: string,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
    @header("x-ms-structured-body-put") structuredBodyPut?: string,
    @header("x-ms-structured-content-length") structuredContentLength?: int64,
    @body content?: bytes,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("Content-MD5") contentMd5?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 416 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Upload a range of bytes to a file where the contents are read from a URL.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=range&fromURL")
  @put
  uploadRangeFromURL(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-range") targetRange: string,
    @header("x-ms-copy-source") copySource: string,
    @header("x-ms-source-range") sourceRange: string,
    @header("Content-Length") contentLength: int64,
    @query timeout?: int32,
    @header("x-ms-source-content-crc64") sourceContentCrc64?: string,
    @header("x-ms-source-if-match-crc64") sourceIfMatchCrc64?: string,
    @header("x-ms-source-if-none-match-crc64") sourceIfNoneMatchCrc64?: string,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-source-lease-id") sourceLeaseId?: string,
    @header("x-ms-copy-source-authorization") copySourceAuthorization?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-source-allow-trailing-dot") sourceAllowTrailingDot?: boolean,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("Content-MD5") contentMd5?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 412 | 416 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Returns the list of valid page ranges for a file or snapshot of a file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=rangelist")
  @get
  getRangeList(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query sharesnapshot?: string,
    @query timeout?: int32,
    @header("Range") range?: string,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("Last-Modified") lastModified: string;
    @header("ETag") etag: string;
    @header("x-ms-content-length") contentLength: int64;
    @body rangeList: ShareFileRangeList;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 416 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Copies a blob or file to a destination file within the storage account.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=copy")
  @put
  startCopy(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-copy-source") copySource: string,
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-file-permission") filePermission?: string,
    @header("x-ms-file-permission-key") filePermissionKey?: string,
    @header("x-ms-file-permission-copy-mode")
    filePermissionCopyMode?: PermissionCopyModeType,
    @header("x-ms-file-copy-ignore-read-only") fileCopyIgnoreReadOnly?: boolean,
    @header("x-ms-file-attributes") fileAttributes?: string,
    @header("x-ms-file-copy-file-attributes") fileCopyFileAttributes?: string,
    @header("x-ms-file-creation-time") fileCreationTime?: string,
    @header("x-ms-file-copy-file-creation-time")
    fileCopyFileCreationTime?: string,
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string,
    @header("x-ms-file-copy-file-last-write-time")
    fileCopyFileLastWriteTime?: string,
    @header("x-ms-file-change-time") fileChangeTime?: string,
    @header("x-ms-file-copy-file-change-time") fileCopyFileChangeTime?: string,
    @header("x-ms-file-copy-set-archive-attribute")
    fileCopySetArchiveAttribute?: boolean,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-source-lease-id") sourceLeaseId?: string,
    @header("x-ms-copy-source-authorization") copySourceAuthorization?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-file-permission-format")
    filePermissionFormat?: FilePermissionFormat,
    @header("x-ms-source-allow-trailing-dot") sourceAllowTrailingDot?: boolean,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
    @header("x-ms-owner") owner?: string,
    @header("x-ms-group") group?: string,
    @header("x-ms-mode") mode?: string,
    @header("x-ms-file-copy-mode-copy-mode")
    fileCopyModeCopyMode?: ModeCopyMode,
    @header("x-ms-file-copy-owner-copy-mode")
    fileCopyOwnerCopyMode?: OwnerCopyMode,
  ): {
    @statusCode statusCode: 202;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-copy-id") copyId: string;
    @header("x-ms-copy-status") copyStatus: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Aborts a pending Copy File operation, and leaves a destination file with zero length and full metadata.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=copy&copyid")
  @put
  abortCopy(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-copy-action") copyActionAbort: "abort",
    @query copyid: string,
    @query timeout?: int32,
    @header("x-ms-lease-id") leaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 204;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Lists handles for file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=listhandles")
  @get
  listHandles(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query marker?: string,
    @query maxresults?: int32,
    @query timeout?: int32,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @body response: ListHandlesResponse;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Closes all handles open for given file.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=forceclosehandles")
  @put
  forceCloseHandles(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-handle-id") handleId: string,
    @query timeout?: int32,
    @query marker?: string,
    @query sharesnapshot?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("x-ms-number-of-handles-closed") numberOfHandlesClosed: int32;
    @header("x-ms-number-of-handles-failed") numberOfHandlesFailed: int32;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Renames a file. By default, the destination is overwritten and if the destination already exists and has a read-only attribute set, the operation will fail.
   */
  @route("/{shareName}/{directory}/{fileName}?comp=rename")
  @put
  rename(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @header("x-ms-rename-source") renameSource: string,
    @query timeout?: int32,
    @header("x-ms-file-rename-replace-if-exists")
    renameReplaceIfExists?: boolean,
    @header("x-ms-file-rename-ignore-read-only") renameIgnoreReadOnly?: boolean,
    @header("x-ms-source-lease-id") sourceLeaseId?: string,
    @header("x-ms-destination-lease-id") destinationLeaseId?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-source-allow-trailing-dot") sourceAllowTrailingDot?: boolean,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Creates a symbolic link to a target file. NFS only.
   */
  @route("/{shareName}/{directory}/{fileName}?restype=symboliclink")
  @put
  createSymbolicLink(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-file-permission") filePermission?: string,
    @header("x-ms-file-permission-key") filePermissionKey?: string,
    @header("x-ms-file-attributes") fileAttributes?: string,
    @header("x-ms-file-creation-time") fileCreationTime?: string,
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string,
    @header("x-ms-file-change-time") fileChangeTime?: string,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-file-permission-format")
    filePermissionFormat?: FilePermissionFormat,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
    @header("x-ms-owner") owner?: string,
    @header("x-ms-group") group?: string,
    @header("x-ms-mode") mode?: string,
    @header("x-ms-link-text") linkText: string,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-file-permission-key") filePermissionKey?: string;
    @header("x-ms-file-attributes") fileAttributes?: string;
    @header("x-ms-file-creation-time") fileCreationTime?: string;
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
    @header("x-ms-file-change-time") fileChangeTime?: string;
    @header("x-ms-file-id") fileId?: string;
    @header("x-ms-file-parent-id") fileParentId?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Returns the target of a symbolic link. NFS only.
   */
  @route("/{shareName}/{directory}/{fileName}?restype=symboliclink")
  @get
  getSymbolicLink(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
  ): {
    @statusCode statusCode: 200;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
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
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };

  /**
   * Creates a hard link to a target file. NFS only.
   */
  @route("/{shareName}/{directory}/{fileName}?restype=hardlink")
  @put
  createHardLink(
    @path shareName: string,
    @path directory: string,
    @path fileName: string,
    @header("x-ms-version") apiVersion: "2026-04-06",
    @query timeout?: int32,
    @header("x-ms-meta-*") metadata?: Record<string>,
    @header("x-ms-file-request-intent") fileRequestIntent?: ShareTokenIntent,
    @header("x-ms-allow-trailing-dot") allowTrailingDot?: boolean,
    @header("x-ms-target-file") targetFile: string,
  ): {
    @statusCode statusCode: 201;
    @header("x-ms-request-id") requestId: string;
    @header("x-ms-version") version: string;
    @header("ETag") etag: string;
    @header("Last-Modified") lastModified: string;
    @header("x-ms-file-permission-key") filePermissionKey?: string;
    @header("x-ms-file-attributes") fileAttributes?: string;
    @header("x-ms-file-creation-time") fileCreationTime?: string;
    @header("x-ms-file-last-write-time") fileLastWriteTime?: string;
    @header("x-ms-file-change-time") fileChangeTime?: string;
    @header("x-ms-file-id") fileId?: string;
    @header("x-ms-file-parent-id") fileParentId?: string;
  } | {
    @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
    @header("x-ms-error-code") errorCode?: string;
    @body error: StorageError;
  };
}
