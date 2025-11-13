import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using Rest;
using Azure.ResourceManager;
using Http;
using TypeSpec.Versioning;

namespace Microsoft.NetApp;
/**
 * Bucket resource
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
@parentResource(Volume)
model Bucket is Azure.ResourceManager.ProxyResource<BucketProperties> {
  ...ResourceNameParameter<
    Resource = Bucket,
    KeyName = "bucketName",
    SegmentName = "buckets",
    NamePattern = "^([a-z]|(\\d(?!\\d{0,2}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})))([a-z\\d]|(\\.(?!(\\.|-)))|(-(?!\\.))){1,61}[a-z\\d]$"
  >;
}

/**
 * List of volume bucket resources
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model BucketList is Azure.Core.Page<Bucket>;

/**
 * Bucket resource properties
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model BucketProperties {
  /**
   * The volume path mounted inside the bucket. The default is the root path '/' if no value is provided when the bucket is created.
   */
  path?: string = "/";

  /**
   * File System user having access to volume data. For Unix, this is the user's uid and gid. For Windows, this is the user's username. Note that the Unix and Windows user details are mutually exclusive, meaning one or other must be supplied, but not both.
   */
  fileSystemUser?: FileSystemUser;

  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * The bucket credentials status. There states:
   *
   * "NoCredentialsSet": Access and Secret key pair have not been generated.
   * "CredentialsExpired": Access and Secret key pair have expired.
   * "Active": The certificate has been installed and credentials are unexpired.
   */
  @visibility(Lifecycle.Read)
  status?: CredentialsStatus;

  /**
   * Properties of the server managing the lifecycle of volume buckets
   */
  server?: BucketServerProperties;

  /**
   * Access permissions for the bucket. Either ReadOnly or ReadWrite. The default is ReadOnly if no value is provided during bucket creation.
   */
  permissions?: BucketPermissions = BucketPermissions.ReadOnly;
}

/**
 * File System user having access to volume data. For Unix, this is the user's uid and gid. For Windows, this is the user's username. Note that the Unix and Windows user details are mutually exclusive, meaning one or other must be supplied, but not both.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model FileSystemUser {
  /**
   * The effective NFS User ID and Group ID when accessing the volume data.
   */
  nfsUser?: NfsUser;

  /**
   * The effective CIFS username when accessing the volume data.
   */
  cifsUser?: CifsUser;
}

/**
 * The effective NFS User ID and Group ID when accessing the volume data.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model NfsUser {
  /**
   * The NFS user's UID
   */
  userId?: int64;

  /**
   * The NFS user's GID
   */
  groupId?: int64;
}

/**
 * The effective CIFS username when accessing the volume data.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model CifsUser {
  /**
   * The CIFS user's username
   */
  username?: string;
}

/**
 * Properties of the server managing the lifecycle of volume buckets
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model BucketServerProperties {
  /**
   * The host part of the bucket URL, resolving to the bucket IP address and allowed by the server certificate.
   */
  fqdn?: string;

  /**
   * Certificate Common Name taken from the certificate installed on the bucket server
   */
  @visibility(Lifecycle.Read)
  @maxLength(64)
  @minLength(1)
  certificateCommonName?: string;

  /**
   * The bucket server's certificate expiry date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  certificateExpiryDate?: utcDateTime;

  /**
   * The bucket server's IPv4 address
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * A base64-encoded PEM file, which includes both the bucket server's certificate and private key. It is used to authenticate the user and allows access to volume data in a read-only manner.
   */
  @maxLength(10240)
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  certificateObject?: string;
}

/**
 * Bucket resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model BucketPatch extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Bucket properties
   */
  properties?: BucketPatchProperties;
}

/**
 * Bucket resource properties for a Patch operation
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model BucketPatchProperties {
  /**
   * The volume path mounted inside the bucket.
   */
  path?: string;

  /**
   * File System user having access to volume data. For Unix, this is the user's uid and gid. For Windows, this is the user's username. Note that the Unix and Windows user details are mutually exclusive, meaning one or other must be supplied, but not both.
   */
  fileSystemUser?: FileSystemUser;

  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * Properties of the server managing the lifecycle of volume buckets
   */
  server?: BucketServerPatchProperties;

  /**
   * Access permissions for the bucket. Either ReadOnly or ReadWrite.
   */
  permissions?: BucketPatchPermissions;
}

/**
 * Properties of the server managing the lifecycle of volume buckets
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model BucketServerPatchProperties {
  /**
   * The host part of the bucket URL, resolving to the bucket IP address and allowed by the server certificate.
   */
  fqdn?: string;

  /**
   * A base64-encoded PEM file, which includes both the bucket server's certificate and private key. It is used to authenticate the user and allows access to volume data in a read-only manner.
   */
  @maxLength(10240)
  @minLength(1)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  certificateObject?: string;
}

/**
 * The bucket's Access and Secret key pair Expiry Time expressed as the number of days from now.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model BucketCredentialsExpiry {
  /**
   * The number of days from now until the newly generated Access and Secret key pair will expire.
   */
  @minValue(1)
  keyPairExpiryDays?: int32;
}

/**
 * Bucket Access Key, Secret Key, and Expiry date and time of the key pair
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
model BucketGenerateCredentials {
  /**
   * The Access Key that is required along with the Secret Key to access the bucket.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark this property as @secret if this value should be kept private"
  @visibility(Lifecycle.Read)
  accessKey?: string;

  /**
   * The Secret Key that is required along with the Access Key to access the bucket.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark this property as @secret if this value should be kept private"
  @visibility(Lifecycle.Read)
  secretKey?: string;

  /**
   * The bucket's Access and Secret key pair expiry date and time (in UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  keyPairExpiry?: utcDateTime;
}

/**
 * The bucket credentials status. There states:
 *
 * "NoCredentialsSet": Access and Secret key pair have not been generated.
 * "CredentialsExpired": Access and Secret key pair have expired.
 * "Active": The certificate has been installed and credentials are unexpired.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
union CredentialsStatus {
  string,

  /**
   * Access and Secret key pair have not been generated.
   */
  NoCredentialsSet: "NoCredentialsSet",

  /**
   * Access and Secret key pair have expired.
   */
  CredentialsExpired: "CredentialsExpired",

  /**
   * The certificate has been installed on the bucket server and the bucket credentials are unexpired.
   */
  Active: "Active",
}

/**
 * Access permissions for the bucket. Either ReadOnly or ReadWrite. The default is ReadOnly if no value is provided during bucket creation.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
union BucketPermissions {
  string,

  /**
   * Read-only access to bucket.
   */
  ReadOnly: "ReadOnly",

  /**
   * Read-write access to bucket.
   */
  ReadWrite: "ReadWrite",
}

/**
 * Access permissions for the bucket. Either ReadOnly or ReadWrite.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
union BucketPatchPermissions {
  string,

  /**
   * Read-only access to bucket.
   */
  ReadOnly: "ReadOnly",

  /**
   * Read-write access to bucket.
   */
  ReadWrite: "ReadWrite",
}

@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_09_01)
@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface Buckets {
  /**
   * Get the details of the specified volume's bucket. A bucket allows additional services, such as AI services, connect to the volume data contained in those buckets.
   */
  get is ArmResourceRead<Bucket>;

  /**
   * Creates or updates a bucket for a volume. A bucket allows additional services, such as AI services, connect to the volume data contained in those buckets.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Bucket>;

  /**
   * Updates the details of a volume bucket.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Bucket,
    PatchModel = BucketPatch,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Bucket> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a volume's bucket.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Bucket,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Describes all buckets belonging to a volume. Buckets allow additional services, such as AI services, connect to the volume data contained in those buckets.
   */
  list is ArmResourceListByParent<Bucket, Response = ArmResponse<BucketList>>;

  /**
   * Generate the access key and secret key used for accessing the specified volume bucket. Also return expiry date and time of key pair (in UTC).
   */
  generateCredentials is ArmResourceActionSync<
    Bucket,
    BucketCredentialsExpiry,
    ArmResponse<BucketGenerateCredentials>
  >;
}

@@maxLength(Bucket.name, 63);
@@minLength(Bucket.name, 3);
@@doc(Bucket.name, "The name of the bucket");
@@doc(Bucket.properties, "Bucket properties");
@@doc(Buckets.createOrUpdate::parameters.resource,
  "The bucket details including user details, and the volume path that should be mounted inside the bucket."
);
@@doc(Buckets.update::parameters.properties,
  "The bucket details including user details, and the volume path that should be mounted inside the bucket."
);
@@doc(Buckets.generateCredentials::parameters.body,
  "The bucket's Access and Secret key pair expiry time expressed as the number of days from now."
);
