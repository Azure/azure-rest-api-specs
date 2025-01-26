import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace KeyVault;

/**
 * JsonWebKey Key Type (kty), as defined in https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40.
 */
union JsonWebKeyType {
  string,

  /**
   * Elliptic Curve.
   */
  EC: "EC",

  /**
   * Elliptic Curve with a private key which is stored in the HSM.
   */
  EC_HSM: "EC-HSM",

  /**
   * RSA (https://tools.ietf.org/html/rfc3447)
   */
  RSA: "RSA",

  /**
   * RSA with a private key which is stored in the HSM.
   */
  RSA_HSM: "RSA-HSM",

  /**
   * Octet sequence (used to represent symmetric keys)
   */
  oct: "oct",

  /**
   * Octet sequence (used to represent symmetric keys) which is stored the HSM.
   */
  oct_HSM: "oct-HSM",
}

/**
 * JSON web key operations. For more information, see JsonWebKeyOperation.
 */
union JsonWebKeyOperation {
  string,

  /** Indicates that the key can be used to encrypt. */
  encrypt: "encrypt",

  /** Indicates that the key can be used to decrypt. */
  decrypt: "decrypt",

  /** Indicates that the key can be used to sign. */
  sign: "sign",

  /** Indicates that the key can be used to verify. */
  verify: "verify",

  /** Indicates that the key can be used to wrap another key. */
  wrapKey: "wrapKey",

  /** Indicates that the key can be used to unwrap another key. */
  unwrapKey: "unwrapKey",

  /** Indicates that the key can be imported during creation. */
  `import`: "import",

  /** Indicates that the private component of the key can be exported. */
  export: "export",
}

/**
 * Reflects the deletion recovery level currently in effect for certificates in the current vault. If it contains 'Purgeable', the certificate can be permanently deleted by a privileged user; otherwise, only the system can purge the certificate, at the end of the retention interval.
 */
union DeletionRecoveryLevel {
  string,

  /**
   * Denotes a vault state in which deletion is an irreversible operation, without the possibility for recovery. This level corresponds to no protection being available against a Delete operation; the data is irretrievably lost upon accepting a Delete operation at the entity level or higher (vault, resource group, subscription etc.)
   */
  Purgeable: "Purgeable",

  /**
   * Denotes a vault state in which deletion is recoverable, and which also permits immediate and permanent deletion (i.e. purge). This level guarantees the recoverability of the deleted entity during the retention interval (90 days), unless a Purge operation is requested, or the subscription is cancelled. System wil permanently delete it after 90 days, if not recovered
   */
  RecoverablePurgeable: "Recoverable+Purgeable",

  /**
   * Denotes a vault state in which deletion is recoverable without the possibility for immediate and permanent deletion (i.e. purge). This level guarantees the recoverability of the deleted entity during the retention interval(90 days) and while the subscription is still available. System wil permanently delete it after 90 days, if not recovered
   */
  Recoverable: "Recoverable",

  /**
   * Denotes a vault and subscription state in which deletion is recoverable within retention interval (90 days), immediate and permanent deletion (i.e. purge) is not permitted, and in which the subscription itself  cannot be permanently canceled. System wil permanently delete it after 90 days, if not recovered
   */
  RecoverableProtectedSubscription: "Recoverable+ProtectedSubscription",

  /**
   * Denotes a vault state in which deletion is recoverable, and which also permits immediate and permanent deletion (i.e. purge when 7 <= SoftDeleteRetentionInDays < 90). This level guarantees the recoverability of the deleted entity during the retention interval, unless a Purge operation is requested, or the subscription is cancelled.
   */
  CustomizedRecoverablePurgeable: "CustomizedRecoverable+Purgeable",

  /**
   * Denotes a vault state in which deletion is recoverable without the possibility for immediate and permanent deletion (i.e. purge when 7 <= SoftDeleteRetentionInDays < 90).This level guarantees the recoverability of the deleted entity during the retention interval and while the subscription is still available.
   */
  CustomizedRecoverable: "CustomizedRecoverable",

  /**
   * Denotes a vault and subscription state in which deletion is recoverable, immediate and permanent deletion (i.e. purge) is not permitted, and in which the subscription itself cannot be permanently canceled when 7 <= SoftDeleteRetentionInDays < 90. This level guarantees the recoverability of the deleted entity during the retention interval, and also reflects the fact that the subscription itself cannot be cancelled.
   */
  CustomizedRecoverableProtectedSubscription: "CustomizedRecoverable+ProtectedSubscription",
}

/**
 * Elliptic curve name. For valid values, see JsonWebKeyCurveName.
 */
union JsonWebKeyCurveName {
  string,

  /** The NIST P-256 elliptic curve, AKA SECG curve SECP256R1. */
  P256: "P-256",

  /** The NIST P-384 elliptic curve, AKA SECG curve SECP384R1. */
  P384: "P-384",

  /** The NIST P-521 elliptic curve, AKA SECG curve SECP521R1. */
  P521: "P-521",

  /** The SECG SECP256K1 elliptic curve. */
  P256_K: "P-256K",
}

/**
 * An algorithm used for encryption and decryption.
 */
union JsonWebKeyEncryptionAlgorithm {
  string,

  /**
   * [Not recommended] RSAES using Optimal Asymmetric Encryption Padding (OAEP), as described in https://tools.ietf.org/html/rfc3447, with the default parameters specified by RFC 3447 in Section A.2.1. Those default parameters are using a hash function of SHA-1 and a mask generation function of MGF1 with SHA-1. Microsoft recommends using RSA_OAEP_256 or stronger algorithms for enhanced security. Microsoft does *not* recommend RSA_OAEP, which is included solely for backwards compatibility. RSA_OAEP utilizes SHA1, which has known collision problems.
   */
  RSA_OAEP: "RSA-OAEP",

  /**
   * RSAES using Optimal Asymmetric Encryption Padding with a hash function of SHA-256 and a mask generation function of MGF1 with SHA-256.
   */
  RSA_OAEP256: "RSA-OAEP-256",

  /** [Not recommended] RSAES-PKCS1-V1_5 key encryption, as described in https://tools.ietf.org/html/rfc3447. Microsoft recommends using RSA_OAEP_256 or stronger algorithms for enhanced security. Microsoft does *not* recommend RSA_1_5, which is included solely for backwards compatibility. Cryptographic standards no longer consider RSA with the PKCS#1 v1.5 padding scheme secure for encryption. */
  RSA1_5: "RSA1_5",

  /** 128-bit AES-GCM. */
  A128_GCM: "A128GCM",

  /** 192-bit AES-GCM. */
  A192_GCM: "A192GCM",

  /** 256-bit AES-GCM. */
  A256_GCM: "A256GCM",

  /** 128-bit AES key wrap. */
  A128_KW: "A128KW",

  /** 192-bit AES key wrap. */
  A192_KW: "A192KW",

  /** 256-bit AES key wrap. */
  A256_KW: "A256KW",

  /** 128-bit AES-CBC. */
  A128_CBC: "A128CBC",

  /** 192-bit AES-CBC. */
  A192_CBC: "A192CBC",

  /** 256-bit AES-CBC. */
  A256_CBC: "A256CBC",

  /** 128-bit AES-CBC with PKCS padding. */
  A128_CBCPAD: "A128CBCPAD",

  /** 192-bit AES-CBC with PKCS padding. */
  A192_CBCPAD: "A192CBCPAD",

  /** 256-bit AES-CBC with PKCS padding. */
  A256_CBCPAD: "A256CBCPAD",

  /** CKM AES key wrap. */
  @added(KeyVault.Versions.`v7.6_preview.1`)
  CKM_AES_KEY_WRAP: "CKM_AES_KEY_WRAP",

  /** CKM AES key wrap with padding. */
  @added(KeyVault.Versions.`v7.6_preview.1`)
  CKM_AES_KEY_WRAP_PAD: "CKM_AES_KEY_WRAP_PAD",
}

/**
 * The signing/verification algorithm identifier. For more information on possible algorithm types, see JsonWebKeySignatureAlgorithm.
 */
union JsonWebKeySignatureAlgorithm {
  string,

  /**
   * RSASSA-PSS using SHA-256 and MGF1 with SHA-256, as described in https://tools.ietf.org/html/rfc7518
   */
  PS256: "PS256",

  /**
   * RSASSA-PSS using SHA-384 and MGF1 with SHA-384, as described in https://tools.ietf.org/html/rfc7518
   */
  PS384: "PS384",

  /**
   * RSASSA-PSS using SHA-512 and MGF1 with SHA-512, as described in https://tools.ietf.org/html/rfc7518
   */
  PS512: "PS512",

  /**
   * RSASSA-PKCS1-v1_5 using SHA-256, as described in https://tools.ietf.org/html/rfc7518
   */
  RS256: "RS256",

  /**
   * RSASSA-PKCS1-v1_5 using SHA-384, as described in https://tools.ietf.org/html/rfc7518
   */
  RS384: "RS384",

  /**
   * RSASSA-PKCS1-v1_5 using SHA-512, as described in https://tools.ietf.org/html/rfc7518
   */
  RS512: "RS512",

  /**
   * Reserved
   */
  RSNULL: "RSNULL",

  /**
   * ECDSA using P-256 and SHA-256, as described in https://tools.ietf.org/html/rfc7518.
   */
  ES256: "ES256",

  /**
   * ECDSA using P-384 and SHA-384, as described in https://tools.ietf.org/html/rfc7518
   */
  ES384: "ES384",

  /**
   * ECDSA using P-521 and SHA-512, as described in https://tools.ietf.org/html/rfc7518
   */
  ES512: "ES512",

  /**
   * ECDSA using P-256K and SHA-256, as described in https://tools.ietf.org/html/rfc7518
   */
  ES256_K: "ES256K",
}

/**
 * The encryption algorithm to use to protected the exported key material
 */
union KeyEncryptionAlgorithm {
  string,

  /** The CKM_RSA_AES_KEY_WRAP key wrap mechanism. */
  CKM_RSA_AES_KEY_WRAP: "CKM_RSA_AES_KEY_WRAP",

  /** The RSA_AES_KEY_WRAP_256 key wrap mechanism. */
  RSA_AES_KEY_WRAP_256: "RSA_AES_KEY_WRAP_256",

  /** The RSA_AES_KEY_WRAP_384 key wrap mechanism. */
  RSA_AES_KEY_WRAP_384: "RSA_AES_KEY_WRAP_384",
}

/**
 * The type of the action. The value should be compared case-insensitively.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Intentional enum; originally modelAsString=false"
enum KeyRotationPolicyAction {
  /**
   * Rotate the key based on the key policy.
   */
  Rotate: "Rotate",

  /**
   * Trigger Event Grid events. Defaults to 30 days before expiry. Key Vault only.
   */
  Notify: "Notify",
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

  /**
   * Json web key operations. For more information on possible key operations, see JsonWebKeyOperation.
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
model KeyAttributes {
  ...Attributes;

  /**
   * softDelete data retention days. Value should be >=7 and <=90 when softDelete enabled, otherwise 0.
   */
  @visibility("read")
  recoverableDays?: int32;

  /**
   * Reflects the deletion recovery level currently in effect for keys in the current vault. If it contains 'Purgeable' the key can be permanently deleted by a privileged user; otherwise, only the system can purge the key, at the end of the retention interval.
   */
  @visibility("read")
  recoveryLevel?: DeletionRecoveryLevel;

  /**
   * Indicates if the private key can be exported. Release policy must be provided when creating the first version of an exportable key.
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
  @encode("unixTimestamp", int32)
  notBefore?: utcDateTime;

  /**
   * Expiry date in UTC.
   */
  @encodedName("application/json", "exp")
  @encode("unixTimestamp", int32)
  expires?: utcDateTime;

  /**
   * Creation time in UTC.
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  created?: utcDateTime;

  /**
   * Last updated time in UTC.
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  updated?: utcDateTime;
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
   * Defines the mutability state of the policy. Once marked immutable, this flag cannot be reset and the policy cannot be changed under any circumstances.
   */
  immutable?: boolean;

  /**
   * Blob encoding the policy rules under which the key can be released. Blob must be base64 URL encoded.
   */
  @encodedName("application/json", "data")
  @encode("base64url")
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
   * True if the key's lifetime is managed by key vault. If this is a key backing a certificate, then managed will be true.
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
   * JsonWebKey Key Type (kty), as defined in https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40.
   */
  kty?: JsonWebKeyType;

  /**
   * Json web key operations. For more information on possible key operations, see JsonWebKeyOperation.
   */
  @encodedName("application/json", "key_ops")
  keyOps?: string[];

  /**
   * RSA modulus.
   */
  @encode("base64url")
  n?: bytes;

  /**
   * RSA public exponent.
   */
  @encode("base64url")
  e?: bytes;

  /**
   * RSA private exponent, or the D component of an EC private key.
   */
  @encode("base64url")
  d?: bytes;

  /**
   * RSA private key parameter.
   */
  @encode("base64url")
  dp?: bytes;

  /**
   * RSA private key parameter.
   */
  @encode("base64url")
  dq?: bytes;

  /**
   * RSA private key parameter.
   */
  @encode("base64url")
  qi?: bytes;

  /**
   * RSA secret prime.
   */
  @encode("base64url")
  p?: bytes;

  /**
   * RSA secret prime, with p < q.
   */
  @encode("base64url")
  q?: bytes;

  /**
   * Symmetric key.
   */
  @encode("base64url")
  k?: bytes;

  /**
   * Protected Key, used with 'Bring Your Own Key'.
   */
  @encodedName("application/json", "key_hsm")
  @encode("base64url")
  t?: bytes;

  /**
   * Elliptic curve name. For valid values, see JsonWebKeyCurveName.
   */
  crv?: JsonWebKeyCurveName;

  /**
   * X component of an EC public key.
   */
  @encode("base64url")
  x?: bytes;

  /**
   * Y component of an EC public key.
   */
  @encode("base64url")
  y?: bytes;
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
model DeletedKeyBundle {
  ...KeyBundle;

  /**
   * The url of the recovery object, used to identify and recover the deleted key.
   */
  recoveryId?: string;

  /**
   * The time when the key is scheduled to be purged, in UTC
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  scheduledPurgeDate?: utcDateTime;

  /**
   * The time when the key was deleted, in UTC
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  deletedDate?: utcDateTime;
}

/**
 * The key update parameters.
 */
model KeyUpdateParameters {
  /**
   * Json web key operations. For more information on possible key operations, see JsonWebKeyOperation.
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
@pagedResult
model KeyListResult {
  /**
   * A response message containing a list of keys in the key vault along with a link to the next page of keys.
   */
  @items
  @visibility("read")
  value?: KeyItem[];

  /**
   * The URL to get the next set of keys.
   */
  @nextLink
  @visibility("read")
  nextLink?: string;
}

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
   * True if the key's lifetime is managed by key vault. If this is a key backing a certificate, then managed will be true.
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
  @encode("base64url")
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
  @encode("base64url")
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

  /**
   * The value to operate on.
   */
  @encode("base64url")
  value: bytes;

  /**
   * Cryptographically random, non-repeating initialization vector for symmetric algorithms.
   */
  @encode("base64url")
  iv?: bytes;

  /**
   * Additional data to authenticate but not encrypt/decrypt when using authenticated crypto algorithms.
   */
  @encode("base64url")
  aad?: bytes;

  /**
   * The tag to authenticate when performing decryption with an authenticated algorithm.
   */
  @encode("base64url")
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

  /**
   * The result of the operation.
   */
  @visibility("read")
  @encodedName("application/json", "value")
  @encode("base64url")
  result?: bytes;

  /**
   * Cryptographically random, non-repeating initialization vector for symmetric algorithms.
   */
  @visibility("read")
  @encode("base64url")
  iv?: bytes;

  /**
   * The tag to authenticate when performing decryption with an authenticated algorithm.
   */
  @visibility("read")
  @encodedName("application/json", "tag")
  @encode("base64url")
  authenticationTag?: bytes;

  /**
   * Additional data to authenticate but not encrypt/decrypt when using authenticated crypto algorithms.
   */
  @visibility("read")
  @encodedName("application/json", "aad")
  @encode("base64url")
  additionalAuthenticatedData?: bytes;
}

/**
 * The key operations parameters.
 */
model KeySignParameters {
  /**
   * The signing/verification algorithm identifier. For more information on possible algorithm types, see JsonWebKeySignatureAlgorithm.
   */
  @encodedName("application/json", "alg")
  algorithm: JsonWebKeySignatureAlgorithm;

  /**
   * The value to operate on.
   */
  @encode("base64url")
  value: bytes;
}

/**
 * The key verify parameters.
 */
model KeyVerifyParameters {
  /**
   * The signing/verification algorithm. For more information on possible algorithm types, see JsonWebKeySignatureAlgorithm.
   */
  @encodedName("application/json", "alg")
  algorithm: JsonWebKeySignatureAlgorithm;

  /**
   * The digest used for signing.
   */
  @encode("base64url")
  digest: bytes;

  /**
   * The signature to be verified.
   */
  @encodedName("application/json", "value")
  @encode("base64url")
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
@pagedResult
model DeletedKeyListResult {
  /**
   * A response message containing a list of deleted keys in the key vault along with a link to the next page of deleted keys.
   */
  @items
  @visibility("read")
  value?: DeletedKeyItem[];

  /**
   * The URL to get the next set of deleted keys.
   */
  @nextLink
  @visibility("read")
  nextLink?: string;
}

/**
 * The deleted key item containing the deleted key metadata and information about deletion.
 */
model DeletedKeyItem {
  ...KeyItem;

  /**
   * The url of the recovery object, used to identify and recover the deleted key.
   */
  recoveryId?: string;

  /**
   * The time when the key is scheduled to be purged, in UTC
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  scheduledPurgeDate?: utcDateTime;

  /**
   * The time when the key was deleted, in UTC
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  deletedDate?: utcDateTime;
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
   * Actions that will be performed by Key Vault over the lifetime of a key. For preview, lifetimeActions can only have two items at maximum: one for rotate, one for notify. Notification time would be default to 30 days before expiry and it is not configurable.
   */
  lifetimeActions?: LifetimeActions[];

  /**
   * The key rotation policy attributes.
   */
  attributes?: KeyRotationPolicyAttributes;
}

/**
 * Action and its trigger that will be performed by Key Vault over the lifetime of a key.
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
   * Time after creation to attempt to rotate. It only applies to rotate. It will be in ISO 8601 duration format. Example: 90 days : "P90D"
   */
  timeAfterCreate?: string;

  /**
   * Time before expiry to attempt to rotate or notify. It will be in ISO 8601 duration format. Example: 90 days : "P90D"
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
  type?: KeyRotationPolicyAction;
}

/**
 * The key rotation policy attributes.
 */
model KeyRotationPolicyAttributes {
  /**
   * The expiryTime will be applied on the new key version. It should be at least 28 days. It will be in ISO 8601 Format. Examples: 90 days: P90D, 3 months: P3M, 48 hours: PT48H, 1 year and 10 days: P1Y10D
   */
  expiryTime?: string;

  /**
   * The key rotation policy created time in UTC.
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  created?: utcDateTime;

  /**
   * The key rotation policy's last updated time in UTC.
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  updated?: utcDateTime;
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
  @encode("base64url")
  value: bytes;
}

/**
 * Properties of the key pair backing a certificate.
 */
model KeyProperties {
  /**
   * Indicates if the private key can be exported. Release policy must be provided when creating the first version of an exportable key.
   */
  exportable?: boolean;

  /**
   * The type of key pair to be used for the certificate.
   */
  @minLength(1)
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
   * The export key encryption Json web key. This key MUST be a RSA key that supports encryption.
   */
  wrappingKey?: JsonWebKey;

  /**
   * The export key encryption key identifier. This key MUST be a RSA key that supports encryption.
   */
  wrappingKid?: string;

  /**
   * The encryption algorithm to use to protected the exported key material
   */
  @minLength(1)
  enc?: KeyEncryptionAlgorithm;
}
