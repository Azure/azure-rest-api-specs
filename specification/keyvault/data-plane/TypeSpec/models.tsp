import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace KeyVault;

/**
 * Reflects the deletion recovery level currently in effect for secrets in the
 * current vault. If it contains 'Purgeable', the secret can be permanently
 * deleted by a privileged user; otherwise, only the system can purge the secret,
 * at the end of the retention interval.
 */
union DeletionRecoveryLevel {
  string,

  /**
   * Denotes a vault state in which deletion is an irreversible operation, without
   * the possibility for recovery. This level corresponds to no protection being
   * available against a Delete operation; the data is irretrievably lost upon
   * accepting a Delete operation at the entity level or higher (vault, resource
   * group, subscription etc.)
   */
  Purgeable: "Purgeable",

  /**
   * Denotes a vault state in which deletion is recoverable, and which also permits
   * immediate and permanent deletion (i.e. purge). This level guarantees the
   * recoverability of the deleted entity during the retention interval (90 days),
   * unless a Purge operation is requested, or the subscription is cancelled. System
   * wil permanently delete it after 90 days, if not recovered
   */
  Recoverable_Purgeable: "Recoverable+Purgeable",

  /**
   * Denotes a vault state in which deletion is recoverable without the possibility
   * for immediate and permanent deletion (i.e. purge). This level guarantees the
   * recoverability of the deleted entity during the retention interval(90 days) and
   * while the subscription is still available. System wil permanently delete it
   * after 90 days, if not recovered
   */
  Recoverable: "Recoverable",

  /**
   * Denotes a vault and subscription state in which deletion is recoverable within
   * retention interval (90 days), immediate and permanent deletion (i.e. purge) is
   * not permitted, and in which the subscription itself  cannot be permanently
   * canceled. System wil permanently delete it after 90 days, if not recovered
   */
  Recoverable_ProtectedSubscription: "Recoverable+ProtectedSubscription",

  /**
   * Denotes a vault state in which deletion is recoverable, and which also permits
   * immediate and permanent deletion (i.e. purge when 7<= SoftDeleteRetentionInDays
   * < 90). This level guarantees the recoverability of the deleted entity during
   * the retention interval, unless a Purge operation is requested, or the
   * subscription is cancelled.
   */
  CustomizedRecoverable_Purgeable: "CustomizedRecoverable+Purgeable",

  /**
   * Denotes a vault state in which deletion is recoverable without the possibility
   * for immediate and permanent deletion (i.e. purge when 7<=
   * SoftDeleteRetentionInDays < 90).This level guarantees the recoverability of the
   * deleted entity during the retention interval and while the subscription is
   * still available.
   */
  CustomizedRecoverable: "CustomizedRecoverable",

  /**
   * Denotes a vault and subscription state in which deletion is recoverable,
   * immediate and permanent deletion (i.e. purge) is not permitted, and in which
   * the subscription itself cannot be permanently canceled when 7<=
   * SoftDeleteRetentionInDays < 90. This level guarantees the recoverability of the
   * deleted entity during the retention interval, and also reflects the fact that
   * the subscription itself cannot be cancelled.
   */
  CustomizedRecoverable_ProtectedSubscription: "CustomizedRecoverable+ProtectedSubscription",
}

/**
 * The secret set parameters.
 */
model SecretSetParameters {
  /**
   * The value of the secret.
   */
  value: string;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * Type of the secret value such as a password.
   */
  contentType?: string;

  /**
   * The secret management attributes.
   */
  @encodedName("application/json", "attributes")
  secretAttributes?: SecretAttributes;
}

/**
 * The secret management attributes.
 */
model SecretAttributes extends Attributes {
  /**
   * softDelete data retention days. Value should be >=7 and <=90 when softDelete
   * enabled, otherwise 0.
   */
  @visibility("read")
  recoverableDays?: int32;

  /**
   * Reflects the deletion recovery level currently in effect for secrets in the
   * current vault. If it contains 'Purgeable', the secret can be permanently
   * deleted by a privileged user; otherwise, only the system can purge the secret,
   * at the end of the retention interval.
   */
  @visibility("read")
  recoveryLevel?: DeletionRecoveryLevel;
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
 * A secret consisting of a value, id and its attributes.
 */
model SecretBundle {
  /**
   * The secret value.
   */
  value?: string;

  /**
   * The secret id.
   */
  id?: string;

  /**
   * The content type of the secret.
   */
  contentType?: string;

  /**
   * The secret management attributes.
   */
  attributes?: SecretAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * If this is a secret backing a KV certificate, then this field specifies the
   * corresponding key backing the KV certificate.
   */
  @visibility("read")
  kid?: string;

  /**
   * True if the secret's lifetime is managed by key vault. If this is a secret
   * backing a certificate, then managed will be true.
   */
  @visibility("read")
  managed?: boolean;
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
 * A Deleted Secret consisting of its previous id, attributes and its tags, as
 * well as information on when it will be purged.
 */
model DeletedSecretBundle extends SecretBundle {
  /**
   * The url of the recovery object, used to identify and recover the deleted secret.
   */
  recoveryId?: string;

  /**
   * The time when the secret is scheduled to be purged, in UTC
   */
  @visibility("read")
  scheduledPurgeDate?: plainTime;

  /**
   * The time when the secret was deleted, in UTC
   */
  @visibility("read")
  deletedDate?: plainTime;
}

/**
 * The secret update parameters.
 */
model SecretUpdateParameters {
  /**
   * Type of the secret value such as a password.
   */
  contentType?: string;

  /**
   * The secret management attributes.
   */
  @encodedName("application/json", "attributes")
  secretAttributes?: SecretAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;
}

/**
 * The secret list result.
 */
@friendlyName("SecretListResult")
model SecretListResult is Azure.Core.Page<SecretItem>;

/**
 * The secret item containing secret metadata.
 */
@resource("secrets")
model SecretItem {
  /**
   * Secret identifier.
   */
  @key // The ID isn't really the key; it should be the certificate name, but we don't have this attribute on the model
  id: string;

  /**
   * The secret management attributes.
   */
  attributes?: SecretAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * Type of the secret value such as a password.
   */
  contentType?: string;

  /**
   * True if the secret's lifetime is managed by key vault. If this is a key backing
   * a certificate, then managed will be true.
   */
  @visibility("read")
  managed?: boolean;
}

/**
 * The deleted secret list result
 */
@friendlyName("DeletedSecretListResult")
model DeletedSecretListResult is Azure.Core.Page<DeletedSecretItem>;

/**
 * The deleted secret item containing metadata about the deleted secret.
 */
@resource("deletedsecrets")
model DeletedSecretItem {
  ...SecretItem;

  /**
   * The url of the recovery object, used to identify and recover the deleted secret.
   */
  recoveryId?: string;

  /**
   * The time when the secret is scheduled to be purged, in UTC
   */
  @visibility("read")
  scheduledPurgeDate?: plainTime;

  /**
   * The time when the secret was deleted, in UTC
   */
  @visibility("read")
  deletedDate?: plainTime;
}

/**
 * The backup secret result, containing the backup blob.
 */
model BackupSecretResult {
  /**
   * The backup blob containing the backed up secret.
   */
  @visibility("read")
  value?: bytes;
}

/**
 * The secret restore parameters.
 */
model SecretRestoreParameters {
  /**
   * The backup blob associated with a secret bundle.
   */
  @encodedName("application/json", "value")
  secretBundleBackup: bytes;
}

/**
 * Properties of the key backing a certificate.
 */
model SecretProperties {
  /**
   * The media type (MIME type).
   */
  contentType?: string;
}
