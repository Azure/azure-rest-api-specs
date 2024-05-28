import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace KeyVaultClient;

/**
 * JsonWebKey Key Type (kty), as defined in
 * https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40.
 */
enum JsonWebKeyType {
  /**
   * Elliptic Curve.
   */
  EC,

  /**
   * Elliptic Curve with a private key which is stored in the HSM.
   */
  `EC-HSM`,

  /**
   * RSA (https://tools.ietf.org/html/rfc3447)
   */
  RSA,

  /**
   * RSA with a private key which is stored in the HSM.
   */
  `RSA-HSM`,

  /**
   * Octet sequence (used to represent symmetric keys)
   */
  oct,

  /**
   * Octet sequence (used to represent symmetric keys) which is stored the HSM.
   */
  `oct-HSM`,
}

/**
 * JSON web key operations. For more information, see JsonWebKeyOperation.
 */
enum JsonWebKeyOperation {
  encrypt,
  decrypt,
  sign,
  verify,
  wrapKey,
  unwrapKey,
  `import`,
  export,
}

/**
 * Reflects the deletion recovery level currently in effect for keys in the
 * current vault. If it contains 'Purgeable' the key can be permanently deleted by
 * a privileged user; otherwise, only the system can purge the key, at the end of
 * the retention interval.
 */
enum DeletionRecoveryLevel {
  /**
   * Denotes a vault state in which deletion is an irreversible operation, without
   * the possibility for recovery. This level corresponds to no protection being
   * available against a Delete operation; the data is irretrievably lost upon
   * accepting a Delete operation at the entity level or higher (vault, resource
   * group, subscription etc.)
   */
  Purgeable,

  /**
   * Denotes a vault state in which deletion is recoverable, and which also permits
   * immediate and permanent deletion (i.e. purge). This level guarantees the
   * recoverability of the deleted entity during the retention interval (90 days),
   * unless a Purge operation is requested, or the subscription is cancelled. System
   * wil permanently delete it after 90 days, if not recovered
   */
  `Recoverable+Purgeable`,

  /**
   * Denotes a vault state in which deletion is recoverable without the possibility
   * for immediate and permanent deletion (i.e. purge). This level guarantees the
   * recoverability of the deleted entity during the retention interval(90 days) and
   * while the subscription is still available. System wil permanently delete it
   * after 90 days, if not recovered
   */
  Recoverable,

  /**
   * Denotes a vault and subscription state in which deletion is recoverable within
   * retention interval (90 days), immediate and permanent deletion (i.e. purge) is
   * not permitted, and in which the subscription itself  cannot be permanently
   * canceled. System wil permanently delete it after 90 days, if not recovered
   */
  `Recoverable+ProtectedSubscription`,

  /**
   * Denotes a vault state in which deletion is recoverable, and which also permits
   * immediate and permanent deletion (i.e. purge when 7<= SoftDeleteRetentionInDays
   * < 90). This level guarantees the recoverability of the deleted entity during
   * the retention interval, unless a Purge operation is requested, or the
   * subscription is cancelled.
   */
  `CustomizedRecoverable+Purgeable`,

  /**
   * Denotes a vault state in which deletion is recoverable without the possibility
   * for immediate and permanent deletion (i.e. purge when 7<=
   * SoftDeleteRetentionInDays < 90).This level guarantees the recoverability of the
   * deleted entity during the retention interval and while the subscription is
   * still available.
   */
  CustomizedRecoverable,

  /**
   * Denotes a vault and subscription state in which deletion is recoverable,
   * immediate and permanent deletion (i.e. purge) is not permitted, and in which
   * the subscription itself cannot be permanently canceled when 7<=
   * SoftDeleteRetentionInDays < 90. This level guarantees the recoverability of the
   * deleted entity during the retention interval, and also reflects the fact that
   * the subscription itself cannot be cancelled.
   */
  `CustomizedRecoverable+ProtectedSubscription`,
}

/**
 * Elliptic curve name. For valid values, see JsonWebKeyCurveName.
 */
enum JsonWebKeyCurveName {
  /**
   * The NIST P-256 elliptic curve, AKA SECG curve SECP256R1.
   */
  `P-256`,

  /**
   * The NIST P-384 elliptic curve, AKA SECG curve SECP384R1.
   */
  `P-384`,

  /**
   * The NIST P-521 elliptic curve, AKA SECG curve SECP521R1.
   */
  `P-521`,

  /**
   * The SECG SECP256K1 elliptic curve.
   */
  `P-256K`,
}

/**
 * algorithm identifier
 */
enum JsonWebKeyEncryptionAlgorithm {
  `RSA-OAEP`,
  `RSA-OAEP-256`,
  RSA1_5,
  A128GCM,
  A192GCM,
  A256GCM,
  A128KW,
  A192KW,
  A256KW,
  A128CBC,
  A192CBC,
  A256CBC,
  A128CBCPAD,
  A192CBCPAD,
  A256CBCPAD,
}

/**
 * The signing/verification algorithm identifier. For more information on possible
 * algorithm types, see JsonWebKeySignatureAlgorithm.
 */
enum JsonWebKeySignatureAlgorithm {
  /**
   * RSASSA-PSS using SHA-256 and MGF1 with SHA-256, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  PS256,

  /**
   * RSASSA-PSS using SHA-384 and MGF1 with SHA-384, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  PS384,

  /**
   * RSASSA-PSS using SHA-512 and MGF1 with SHA-512, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  PS512,

  /**
   * RSASSA-PKCS1-v1_5 using SHA-256, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  RS256,

  /**
   * RSASSA-PKCS1-v1_5 using SHA-384, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  RS384,

  /**
   * RSASSA-PKCS1-v1_5 using SHA-512, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  RS512,

  /**
   * Reserved
   */
  RSNULL,

  /**
   * ECDSA using P-256 and SHA-256, as described in
   * https://tools.ietf.org/html/rfc7518.
   */
  ES256,

  /**
   * ECDSA using P-384 and SHA-384, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  ES384,

  /**
   * ECDSA using P-521 and SHA-512, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  ES512,

  /**
   * ECDSA using P-256K and SHA-256, as described in
   * https://tools.ietf.org/html/rfc7518
   */
  ES256K,
}

/**
 * The encryption algorithm to use to protected the exported key material
 */
enum KeyEncryptionAlgorithm {
  CKM_RSA_AES_KEY_WRAP,
  RSA_AES_KEY_WRAP_256,
  RSA_AES_KEY_WRAP_384,
}

/**
 * The type of the action. The value should be compared case-insensitively.
 */
@fixed
enum ActionType {
  /**
   * Rotate the key based on the key policy.
   */
  Rotate,

  /**
   * Trigger Event Grid events. Defaults to 30 days before expiry. Key Vault only.
   */
  Notify,
}

/**
 * The key create parameters.
 */
model KeyCreateParameters {
  /**
   * The type of key to create. For valid values, see JsonWebKeyType.
   */
  kty: JsonWebKeyType;

  /**
   * The key size in bits. For example: 2048, 3072, or 4096 for RSA.
   */
  @encodedName("application/json", "key_size")
  keySize?: int32;

  /**
   * The public exponent for a RSA key.
   */
  @encodedName("application/json", "public_exponent")
  publicExponent?: int32;

  @encodedName("application/json", "key_ops")
  keyOps?: JsonWebKeyOperation[];

  /**
   * The attributes of a key managed by the key vault service.
   */
  @encodedName("application/json", "attributes")
  keyAttributes?: KeyAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * Elliptic curve name. For valid values, see JsonWebKeyCurveName.
   */
  @encodedName("application/json", "crv")
  curve?: JsonWebKeyCurveName;

  /**
   * The policy rules under which the key can be exported.
   */
  @encodedName("application/json", "release_policy")
  releasePolicy?: KeyReleasePolicy;
}

/**
 * The attributes of a key managed by the key vault service.
 */
model KeyAttributes extends Attributes {
  /**
   * softDelete data retention days. Value should be >=7 and <=90 when softDelete
   * enabled, otherwise 0.
   */
  @visibility("read")
  recoverableDays?: int32;

  /**
   * Reflects the deletion recovery level currently in effect for keys in the
   * current vault. If it contains 'Purgeable' the key can be permanently deleted by
   * a privileged user; otherwise, only the system can purge the key, at the end of
   * the retention interval.
   */
  @visibility("read")
  recoveryLevel?: DeletionRecoveryLevel;

  /**
   * Indicates if the private key can be exported. Release policy must be provided
   * when creating the first version of an exportable key.
   */
  exportable?: boolean;

  /**
   * The underlying HSM Platform.
   */
  @visibility("read")
  hsmPlatform?: string;
}

/**
 * The object attributes managed by the KeyVault service.
 */
model Attributes {
  /**
   * Determines whether the object is enabled.
   */
  enabled?: boolean;

  /**
   * Not before date in UTC.
   */
  @encodedName("application/json", "nbf")
  notBefore?: plainTime;

  /**
   * Expiry date in UTC.
   */
  @encodedName("application/json", "exp")
  expires?: plainTime;

  /**
   * Creation time in UTC.
   */
  @visibility("read")
  created?: plainTime;

  /**
   * Last updated time in UTC.
   */
  @visibility("read")
  updated?: plainTime;
}

/**
 * The policy rules under which the key can be exported.
 */
model KeyReleasePolicy {
  /**
   * Content type and version of key release policy
   */
  contentType?: string = "application/json; charset=utf-8";

  /**
   * Defines the mutability state of the policy. Once marked immutable, this flag
   * cannot be reset and the policy cannot be changed under any circumstances.
   */
  immutable?: boolean;

  /**
   * Blob encoding the policy rules under which the key can be released. Blob must
   * be base64 URL encoded.
   */
  @encodedName("application/json", "data")
  encodedPolicy?: bytes;
}

/**
 * A KeyBundle consisting of a WebKey plus its attributes.
 */
model KeyBundle {
  /**
   * The Json web key.
   */
  key?: JsonWebKey;

  /**
   * The key management attributes.
   */
  attributes?: KeyAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * True if the key's lifetime is managed by key vault. If this is a key backing a
   * certificate, then managed will be true.
   */
  @visibility("read")
  managed?: boolean;

  /**
   * The policy rules under which the key can be exported.
   */
  @encodedName("application/json", "release_policy")
  releasePolicy?: KeyReleasePolicy;
}

/**
 * As of http://tools.ietf.org/html/draft-ietf-jose-json-web-key-18
 */
model JsonWebKey {
  /**
   * Key identifier.
   */
  kid?: string;

  /**
   * JsonWebKey Key Type (kty), as defined in
   * https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40.
   */
  kty?: JsonWebKeyType;

  @encodedName("application/json", "key_ops")
  keyOps?: string[];

  /**
   * RSA modulus.
   */
  n?: bytes;

  /**
   * RSA public exponent.
   */
  e?: bytes;

  /**
   * RSA private exponent, or the D component of an EC private key.
   */
  d?: bytes;

  /**
   * RSA private key parameter.
   */
  @encodedName("application/json", "dp")
  DP?: bytes;

  /**
   * RSA private key parameter.
   */
  @encodedName("application/json", "dq")
  DQ?: bytes;

  /**
   * RSA private key parameter.
   */
  @encodedName("application/json", "qi")
  QI?: bytes;

  /**
   * RSA secret prime.
   */
  p?: bytes;

  /**
   * RSA secret prime, with p < q.
   */
  q?: bytes;

  /**
   * Symmetric key.
   */
  k?: bytes;

  /**
   * Protected Key, used with 'Bring Your Own Key'.
   */
  @encodedName("application/json", "key_hsm")
  t?: bytes;

  /**
   * Elliptic curve name. For valid values, see JsonWebKeyCurveName.
   */
  crv?: JsonWebKeyCurveName;

  /**
   * X component of an EC public key.
   */
  x?: bytes;

  /**
   * Y component of an EC public key.
   */
  y?: bytes;
}

/**
 * The key vault error exception.
 */
@error
model KeyVaultError {
  /**
   * The key vault server error.
   */
  @visibility("read")
  error?: Error;
}

/**
 * The key vault server error.
 */
model Error {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The key vault server error.
   */
  @visibility("read")
  @encodedName("application/json", "innererror")
  innerError?: Error;
}

/**
 * The key import parameters.
 */
model KeyImportParameters {
  /**
   * Whether to import as a hardware key (HSM) or software key.
   */
  @encodedName("application/json", "Hsm")
  hsm?: boolean;

  /**
   * The Json web key
   */
  key: JsonWebKey;

  /**
   * The key management attributes.
   */
  @encodedName("application/json", "attributes")
  keyAttributes?: KeyAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * The policy rules under which the key can be exported.
   */
  @encodedName("application/json", "release_policy")
  releasePolicy?: KeyReleasePolicy;
}

/**
 * A DeletedKeyBundle consisting of a WebKey plus its Attributes and deletion info
 */
model DeletedKeyBundle extends KeyBundle {
  /**
   * The url of the recovery object, used to identify and recover the deleted key.
   */
  recoveryId?: string;

  /**
   * The time when the key is scheduled to be purged, in UTC
   */
  @visibility("read")
  scheduledPurgeDate?: plainTime;

  /**
   * The time when the key was deleted, in UTC
   */
  @visibility("read")
  deletedDate?: plainTime;
}

/**
 * The key update parameters.
 */
model KeyUpdateParameters {
  /**
   * Json web key operations. For more information on possible key operations, see
   * JsonWebKeyOperation.
   */
  @encodedName("application/json", "key_ops")
  keyOps?: JsonWebKeyOperation[];

  /**
   * The attributes of a key managed by the key vault service.
   */
  @encodedName("application/json", "attributes")
  keyAttributes?: KeyAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * The policy rules under which the key can be exported.
   */
  @encodedName("application/json", "release_policy")
  releasePolicy?: KeyReleasePolicy;
}

/**
 * The key list result.
 */
model KeyListResult is Azure.Core.Page<KeyItem>;

/**
 * The key item containing key metadata.
 */
model KeyItem {
  /**
   * Key identifier.
   */
  kid?: string;

  /**
   * The key management attributes.
   */
  attributes?: KeyAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * True if the key's lifetime is managed by key vault. If this is a key backing a
   * certificate, then managed will be true.
   */
  @visibility("read")
  managed?: boolean;
}

/**
 * The backup key result, containing the backup blob.
 */
model BackupKeyResult {
  /**
   * The backup blob containing the backed up key.
   */
  @visibility("read")
  value?: bytes;
}

/**
 * The key restore parameters.
 */
model KeyRestoreParameters {
  /**
   * The backup blob associated with a key bundle.
   */
  @encodedName("application/json", "value")
  keyBundleBackup: bytes;
}

/**
 * The key operations parameters.
 */
model KeyOperationsParameters {
  /**
   * algorithm identifier
   */
  @encodedName("application/json", "alg")
  algorithm: JsonWebKeyEncryptionAlgorithm;

  value: bytes;

  /**
   * Cryptographically random, non-repeating initialization vector for symmetric
   * algorithms.
   */
  iv?: bytes;

  /**
   * Additional data to authenticate but not encrypt/decrypt when using
   * authenticated crypto algorithms.
   */
  aad?: bytes;

  /**
   * The tag to authenticate when performing decryption with an authenticated
   * algorithm.
   */
  tag?: bytes;
}

/**
 * The key operation result.
 */
model KeyOperationResult {
  /**
   * Key identifier
   */
  @visibility("read")
  kid?: string;

  @visibility("read")
  @encodedName("application/json", "value")
  result?: bytes;

  @visibility("read")
  iv?: bytes;

  @visibility("read")
  @encodedName("application/json", "tag")
  authenticationTag?: bytes;

  @visibility("read")
  @encodedName("application/json", "aad")
  additionalAuthenticatedData?: bytes;
}

/**
 * The key operations parameters.
 */
model KeySignParameters {
  /**
   * The signing/verification algorithm identifier. For more information on possible
   * algorithm types, see JsonWebKeySignatureAlgorithm.
   */
  @encodedName("application/json", "alg")
  algorithm: JsonWebKeySignatureAlgorithm;

  value: bytes;
}

/**
 * The key verify parameters.
 */
model KeyVerifyParameters {
  /**
   * The signing/verification algorithm. For more information on possible algorithm
   * types, see JsonWebKeySignatureAlgorithm.
   */
  @encodedName("application/json", "alg")
  algorithm: JsonWebKeySignatureAlgorithm;

  /**
   * The digest used for signing.
   */
  digest: bytes;

  /**
   * The signature to be verified.
   */
  @encodedName("application/json", "value")
  signature: bytes;
}

/**
 * The key verify result.
 */
model KeyVerifyResult {
  /**
   * True if the signature is verified, otherwise false.
   */
  @visibility("read")
  value?: boolean;
}

/**
 * The release key parameters.
 */
model KeyReleaseParameters {
  /**
   * The attestation assertion for the target of the key release.
   */
  @minLength(1)
  @encodedName("application/json", "target")
  targetAttestationToken: string;

  /**
   * A client provided nonce for freshness.
   */
  nonce?: string;

  /**
   * The encryption algorithm to use to protected the exported key material
   */
  enc?: KeyEncryptionAlgorithm;
}

/**
 * The release result, containing the released key.
 */
model KeyReleaseResult {
  /**
   * A signed object containing the released key.
   */
  @visibility("read")
  value?: string;
}

/**
 * A list of keys that have been deleted in this vault.
 */
model DeletedKeyListResult is Azure.Core.Page<DeletedKeyItem>;

/**
 * The deleted key item containing the deleted key metadata and information about
 * deletion.
 */
model DeletedKeyItem extends KeyItem {
  /**
   * The url of the recovery object, used to identify and recover the deleted key.
   */
  recoveryId?: string;

  /**
   * The time when the key is scheduled to be purged, in UTC
   */
  @visibility("read")
  scheduledPurgeDate?: plainTime;

  /**
   * The time when the key was deleted, in UTC
   */
  @visibility("read")
  deletedDate?: plainTime;
}

/**
 * Management policy for a key.
 */
model KeyRotationPolicy {
  /**
   * The key policy id.
   */
  @visibility("read")
  id?: string;

  /**
   * Actions that will be performed by Key Vault over the lifetime of a key. For
   * preview, lifetimeActions can only have two items at maximum: one for rotate,
   * one for notify. Notification time would be default to 30 days before expiry and
   * it is not configurable.
   */
  lifetimeActions?: LifetimeActions[];

  /**
   * The key rotation policy attributes.
   */
  attributes?: KeyRotationPolicyAttributes;
}

/**
 * Action and its trigger that will be performed by Key Vault over the lifetime of
 * a key.
 */
model LifetimeActions {
  /**
   * The condition that will execute the action.
   */
  trigger?: LifetimeActionsTrigger;

  /**
   * The action that will be executed.
   */
  action?: LifetimeActionsType;
}

/**
 * A condition to be satisfied for an action to be executed.
 */
model LifetimeActionsTrigger {
  /**
   * Time after creation to attempt to rotate. It only applies to rotate. It will be
   * in ISO 8601 duration format. Example: 90 days : "P90D"
   */
  timeAfterCreate?: string;

  /**
   * Time before expiry to attempt to rotate or notify. It will be in ISO 8601
   * duration format. Example: 90 days : "P90D"
   */
  timeBeforeExpiry?: string;
}

/**
 * The action that will be executed.
 */
model LifetimeActionsType {
  /**
   * The type of the action. The value should be compared case-insensitively.
   */
  type?: ActionType;
}

/**
 * The key rotation policy attributes.
 */
model KeyRotationPolicyAttributes {
  /**
   * The expiryTime will be applied on the new key version. It should be at least 28
   * days. It will be in ISO 8601 Format. Examples: 90 days: P90D, 3 months: P3M, 48
   * hours: PT48H, 1 year and 10 days: P1Y10D
   */
  expiryTime?: string;

  /**
   * The key rotation policy created time in UTC.
   */
  @visibility("read")
  created?: plainTime;

  /**
   * The key rotation policy's last updated time in UTC.
   */
  @visibility("read")
  updated?: plainTime;
}

/**
 * The get random bytes request object.
 */
model GetRandomBytesRequest {
  /**
   * The requested number of random bytes.
   */
  @maxValue(128)
  @minValue(1)
  count: int32;
}

/**
 * The get random bytes response object containing the bytes.
 */
model RandomBytes {
  /**
   * The bytes encoded as a base64url string.
   */
  value: bytes;
}

/**
 * Properties of the key pair backing a certificate.
 */
model KeyProperties {
  /**
   * Indicates if the private key can be exported. Release policy must be provided
   * when creating the first version of an exportable key.
   */
  exportable?: boolean;

  /**
   * The type of key pair to be used for the certificate.
   */
  @encodedName("application/json", "kty")
  keyType?: JsonWebKeyType;

  /**
   * The key size in bits. For example: 2048, 3072, or 4096 for RSA.
   */
  @encodedName("application/json", "key_size")
  keySize?: int32;

  /**
   * Indicates if the same key pair will be used on certificate renewal.
   */
  @encodedName("application/json", "reuse_key")
  reuseKey?: boolean;

  /**
   * Elliptic curve name. For valid values, see JsonWebKeyCurveName.
   */
  @encodedName("application/json", "crv")
  curve?: JsonWebKeyCurveName;
}

/**
 * The export key parameters.
 */
model KeyExportParameters {
  /**
   * The export key encryption Json web key. This key MUST be a RSA key that
   * supports encryption.
   */
  wrappingKey?: JsonWebKey;

  /**
   * The export key encryption key identifier. This key MUST be a RSA key that
   * supports encryption.
   */
  wrappingKid?: string;

  /**
   * The encryption algorithm to use to protected the exported key material
   */
  enc?: KeyEncryptionAlgorithm;
}
