import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace KeyVault;

/**
 * Reflects the deletion recovery level currently in effect for certificates in
 * the current vault. If it contains 'Purgeable', the certificate can be
 * permanently deleted by a privileged user; otherwise, only the system can purge
 * the certificate, at the end of the retention interval.
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
 * The type of key pair to be used for the certificate.
 */
union JsonWebKeyType {
  string,

  /** Elliptic Curve. */
  EC: "EC",

  /** Elliptic Curve with a private key which is not exportable from the HSM. */
  EC_HSM: "EC-HSM",

  /** RSA (https://tools.ietf.org/html/rfc3447). */
  RSA: "RSA",

  /** RSA with a private key which is not exportable from the HSM. */
  RSA_HSM: "RSA-HSM",

  /** Octet sequence (used to represent symmetric keys). */
  oct: "oct",

  /** Octet sequence with a private key which is not exportable from the HSM. */
  oct_HSM: "oct-HSM",
}

/**
 * Elliptic curve name. For valid values, see JsonWebKeyCurveName.
 */
union JsonWebKeyCurveName {
  string,

  /** The NIST P-256 elliptic curve, AKA SECG curve SECP256R1. */
  P_256: "P-256",

  /** The NIST P-384 elliptic curve, AKA SECG curve SECP384R1. */
  P_384: "P-384",

  /** The NIST P-521 elliptic curve, AKA SECG curve SECP521R1. */
  P_521: "P-521",

  /** The SECG SECP256K1 elliptic curve. */
  P_256K: "P-256K",
}

/**
 * Supported usages of a certificate key.
 */
union KeyUsageType {
  string,

  /** Indicates that the certificate key can be used as a digital signature. */
  digitalSignature: "digitalSignature",

  /** Indicates that the certificate key can be used for authentication. */
  nonRepudiation: "nonRepudiation",

  /** Indicates that the certificate key can be used for key encryption. */
  keyEncipherment: "keyEncipherment",

  /** Indicates that the certificate key can be used for data encryption. */
  dataEncipherment: "dataEncipherment",

  /** Indicates that the certificate key can be used to determine key agreement, such as a key created using the Diffie-Hellman key agreement algorithm. */
  keyAgreement: "keyAgreement",

  /** Indicates that the certificate key can be used to sign certificates. */
  keyCertSign: "keyCertSign",

  /** Indicates that the certificate key can be used to sign a certificate revocation list. */
  cRLSign: "cRLSign",

  /** Indicates that the certificate key can be used for encryption only. */
  encipherOnly: "encipherOnly",

  /** Indicates that the certificate key can be used for decryption only. */
  decipherOnly: "decipherOnly",
}

/**
 * The type of the action.
 */
union ActionType {
  string,

  /** A certificate policy that will email certificate contacts. */
  EmailContacts: "EmailContacts",

  /** A certificate policy that will auto-renew a certificate. */
  AutoRenew: "AutoRenew",
}

/**
 * The certificate list result.
 */
@friendlyName("CertificateListResult")
model CertificateListResult is Azure.Core.Page<CertificateItem>;

/**
 * The certificate item containing certificate metadata.
 */
@resource("certificates")
model CertificateItem {
  /**
   * Certificate identifier.
   */
  @visibility("read")
  @key // The ID isn't really the key; it should be the certificate name, but we don't have this attribute on the model
  id: string;

  /**
   * The certificate management attributes.
   */
  attributes?: CertificateAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;

  /**
   * Thumbprint of the certificate.
   */
  @encodedName("application/json", "x5t")
  x509Thumbprint?: bytes;
}

/**
 * The certificate management attributes.
 */
model CertificateAttributes {
  ...Attributes;

  /**
   * softDelete data retention days. Value should be >=7 and <=90 when softDelete
   * enabled, otherwise 0.
   */
  @visibility("read")
  recoverableDays?: int32;

  /**
   * Reflects the deletion recovery level currently in effect for certificates in
   * the current vault. If it contains 'Purgeable', the certificate can be
   * permanently deleted by a privileged user; otherwise, only the system can purge
   * the certificate, at the end of the retention interval.
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
  @encode("unixTimestamp", int32)
  notBefore?: utcDateTime;

  /**
   * Expiry date in UTC.
   */
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
 * A Deleted Certificate consisting of its previous id, attributes and its tags,
 * as well as information on when it will be purged.
 */
model DeletedCertificateBundle {
  ...CertificateBundle;

  /**
   * The url of the recovery object, used to identify and recover the deleted
   * certificate.
   */
  recoveryId?: string;

  /**
   * The time when the certificate is scheduled to be purged, in UTC
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  scheduledPurgeDate?: utcDateTime;

  /**
   * The time when the certificate was deleted, in UTC
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  deletedDate?: utcDateTime;
}

/**
 * A certificate bundle consists of a certificate (X509) plus its attributes.
 */
model CertificateBundle {
  /**
   * The certificate id.
   */
  @visibility("read")
  id?: string;

  /**
   * The key id.
   */
  @visibility("read")
  kid?: string;

  /**
   * The secret id.
   */
  @visibility("read")
  sid?: string;

  /**
   * Thumbprint of the certificate.
   */
  @visibility("read")
  @encodedName("application/json", "x5t")
  x509Thumbprint?: bytes;

  /**
   * The management policy.
   */
  @visibility("read")
  policy?: CertificatePolicy;

  /**
   * CER contents of x509 certificate.
   */
  cer?: bytes;

  /**
   * The content type of the secret. eg. 'application/x-pem-file' or
   * 'application/x-pkcs12',
   */
  contentType?: string;

  /**
   * The certificate attributes.
   */
  attributes?: CertificateAttributes;

  /**
   * Application specific metadata in the form of key-value pairs
   */
  tags?: Record<string>;
}

/**
 * Management policy for a certificate.
 */
model CertificatePolicy {
  /**
   * The certificate id.
   */
  @visibility("read")
  id?: string;

  /**
   * Properties of the key backing a certificate.
   */
  @encodedName("application/json", "key_props")
  keyProperties?: KeyProperties;

  /**
   * Properties of the secret backing a certificate.
   */
  @encodedName("application/json", "secret_props")
  secretProperties?: SecretProperties;

  /**
   * Properties of the X509 component of a certificate.
   */
  @encodedName("application/json", "x509_props")
  x509CertificateProperties?: X509CertificateProperties;

  /**
   * Actions that will be performed by Key Vault over the lifetime of a certificate.
   */
  @encodedName("application/json", "lifetime_actions")
  lifetimeActions?: LifetimeAction[];

  /**
   * Parameters for the issuer of the X509 component of a certificate.
   */
  @encodedName("application/json", "issuer")
  issuerParameters?: IssuerParameters;

  /**
   * The certificate attributes.
   */
  attributes?: CertificateAttributes;
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
 * Properties of the key backing a certificate.
 */
model SecretProperties {
  /**
   * The media type (MIME type).
   */
  contentType?: string;
}

/**
 * Properties of the X509 component of a certificate.
 */
model X509CertificateProperties {
  /**
   * The subject name. Should be a valid X509 distinguished Name.
   */
  subject?: string;

  /**
   * The enhanced key usage.
   */
  ekus?: string[];

  /**
   * The subject alternative names.
   */
  @encodedName("application/json", "sans")
  subjectAlternativeNames?: SubjectAlternativeNames;

  /**
   * Defines how the certificate's key may be used.
   */
  @encodedName("application/json", "key_usage")
  keyUsage?: KeyUsageType[];

  /**
   * The duration that the certificate is valid in months.
   */
  @encodedName("application/json", "validity_months")
  validityInMonths?: int32;
}

/**
 * The subject alternate names of a X509 object.
 */
model SubjectAlternativeNames {
  /**
   * Email addresses.
   */
  emails?: string[];

  /**
   * Domain names.
   */
  @encodedName("application/json", "dns_names")
  dnsNames?: string[];

  /**
   * User principal names.
   */
  upns?: string[];
}

/**
 * Action and its trigger that will be performed by Key Vault over the lifetime of
 * a certificate.
 */
model LifetimeAction {
  /**
   * The condition that will execute the action.
   */
  trigger?: Trigger;

  /**
   * The action that will be executed.
   */
  action?: Action;
}

/**
 * A condition to be satisfied for an action to be executed.
 */
model Trigger {
  /**
   * Percentage of lifetime at which to trigger. Value should be between 1 and 99.
   */
  @maxValue(99)
  @minValue(1)
  @encodedName("application/json", "lifetime_percentage")
  lifetimePercentage?: int32;

  /**
   * Days before expiry to attempt renewal. Value should be between 1 and
   * validity_in_months multiplied by 27. If validity_in_months is 36, then value
   * should be between 1 and 972 (36 * 27).
   */
  @encodedName("application/json", "days_before_expiry")
  daysBeforeExpiry?: int32;
}

/**
 * The action that will be executed.
 */
model Action {
  /**
   * The type of the action.
   */
  @encodedName("application/json", "action_type")
  actionType?: ActionType;
}

/**
 * Parameters for the issuer of the X509 component of a certificate.
 */
model IssuerParameters {
  /**
   * Name of the referenced issuer object or reserved names; for example, 'Self' or
   * 'Unknown'.
   */
  name?: string;

  /**
   * Certificate type as supported by the provider (optional); for example 'OV-SSL',
   * 'EV-SSL'
   */
  @encodedName("application/json", "cty")
  certificateType?: string;

  /**
   * Indicates if the certificates generated under this policy should be published
   * to certificate transparency logs.
   */
  @encodedName("application/json", "cert_transparency")
  certificateTransparency?: boolean;
}

/**
 * The contacts for the vault certificates.
 */
model Contacts {
  /**
   * Identifier for the contacts collection.
   */
  @visibility("read")
  id?: string;

  /**
   * The contact list for the vault certificates.
   */
  @encodedName("application/json", "contacts")
  contactList?: Contact[];
}

/**
 * The contact information for the vault certificates.
 */
model Contact {
  /**
   * Email address.
   */
  @encodedName("application/json", "email")
  emailAddress?: string;

  /**
   * Name.
   */
  name?: string;

  /**
   * Phone number.
   */
  phone?: string;
}

/**
 * The certificate issuer list result.
 */
@friendlyName("CertificateIssuerListResult")
model CertificateIssuerListResult is Azure.Core.Page<CertificateIssuerItem>;

/**
 * The certificate issuer item containing certificate issuer metadata.
 */
@resource("certificates/issuers")
model CertificateIssuerItem {
  /**
   * Certificate Identifier.
   */
  @visibility("read")
  @key
  id: string;

  /**
   * The issuer provider.
   */
  provider?: string;
}

/**
 * The certificate issuer set parameters.
 */
model CertificateIssuerSetParameters {
  /**
   * The issuer provider.
   */
  provider: string;

  /**
   * The credentials to be used for the issuer.
   */
  credentials?: IssuerCredentials;

  /**
   * Details of the organization as provided to the issuer.
   */
  @encodedName("application/json", "org_details")
  organizationDetails?: OrganizationDetails;

  /**
   * Attributes of the issuer object.
   */
  attributes?: IssuerAttributes;
}

/**
 * The credentials to be used for the certificate issuer.
 */
model IssuerCredentials {
  /**
   * The user name/account name/account id.
   */
  @encodedName("application/json", "account_id")
  accountId?: string;

  /**
   * The password/secret/account key.
   */
  @encodedName("application/json", "pwd")
  password?: string;
}

/**
 * Details of the organization of the certificate issuer.
 */
model OrganizationDetails {
  /**
   * Id of the organization.
   */
  id?: string;

  /**
   * Details of the organization administrator.
   */
  @encodedName("application/json", "admin_details")
  adminDetails?: AdministratorDetails[];
}

/**
 * Details of the organization administrator of the certificate issuer.
 */
model AdministratorDetails {
  /**
   * First name.
   */
  @encodedName("application/json", "first_name")
  firstName?: string;

  /**
   * Last name.
   */
  @encodedName("application/json", "last_name")
  lastName?: string;

  /**
   * Email address.
   */
  @encodedName("application/json", "email")
  emailAddress?: string;

  /**
   * Phone number.
   */
  phone?: string;
}

/**
 * The attributes of an issuer managed by the Key Vault service.
 */
model IssuerAttributes {
  /**
   * Determines whether the issuer is enabled.
   */
  enabled?: boolean;

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
 * The issuer for Key Vault certificate.
 */
model IssuerBundle {
  /**
   * Identifier for the issuer object.
   */
  @visibility("read")
  id?: string;

  /**
   * The issuer provider.
   */
  provider?: string;

  /**
   * The credentials to be used for the issuer.
   */
  credentials?: IssuerCredentials;

  /**
   * Details of the organization as provided to the issuer.
   */
  @encodedName("application/json", "org_details")
  organizationDetails?: OrganizationDetails;

  /**
   * Attributes of the issuer object.
   */
  attributes?: IssuerAttributes;
}

/**
 * The certificate issuer update parameters.
 */
model CertificateIssuerUpdateParameters {
  /**
   * The issuer provider.
   */
  provider?: string;

  /**
   * The credentials to be used for the issuer.
   */
  credentials?: IssuerCredentials;

  /**
   * Details of the organization as provided to the issuer.
   */
  @encodedName("application/json", "org_details")
  organizationDetails?: OrganizationDetails;

  /**
   * Attributes of the issuer object.
   */
  attributes?: IssuerAttributes;
}

/**
 * The certificate create parameters.
 */
model CertificateCreateParameters {
  /**
   * The management policy for the certificate.
   */
  @encodedName("application/json", "policy")
  certificatePolicy?: CertificatePolicy;

  /**
   * The attributes of the certificate (optional).
   */
  @encodedName("application/json", "attributes")
  certificateAttributes?: CertificateAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;
}

/**
 * A certificate operation is returned in case of asynchronous requests.
 */
model CertificateOperation {
  /**
   * The certificate id.
   */
  @visibility("read")
  id?: string;

  /**
   * Parameters for the issuer of the X509 component of a certificate.
   */
  @encodedName("application/json", "issuer")
  issuerParameters?: IssuerParameters;

  /**
   * The certificate signing request (CSR) that is being used in the certificate
   * operation.
   */
  csr?: bytes;

  /**
   * Indicates if cancellation was requested on the certificate operation.
   */
  @encodedName("application/json", "cancellation_requested")
  cancellationRequested?: boolean;

  /**
   * Status of the certificate operation.
   */
  status?: string;

  /**
   * The status details of the certificate operation.
   */
  @encodedName("application/json", "status_details")
  statusDetails?: string;

  /**
   * Error encountered, if any, during the certificate operation.
   */
  error?: Error;

  /**
   * Location which contains the result of the certificate operation.
   */
  target?: string;

  /**
   * Identifier for the certificate operation.
   */
  @encodedName("application/json", "request_id")
  requestId?: string;
}

/**
 * The certificate import parameters.
 */
model CertificateImportParameters {
  /**
   * Base64 encoded representation of the certificate object to import. This
   * certificate needs to contain the private key.
   */
  @encodedName("application/json", "value")
  base64EncodedCertificate: string;

  /**
   * If the private key in base64EncodedCertificate is encrypted, the password used
   * for encryption.
   */
  @encodedName("application/json", "pwd")
  password?: string;

  /**
   * The management policy for the certificate.
   */
  @encodedName("application/json", "policy")
  certificatePolicy?: CertificatePolicy;

  /**
   * The attributes of the certificate (optional).
   */
  @encodedName("application/json", "attributes")
  certificateAttributes?: CertificateAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;
}

/**
 * The certificate update parameters.
 */
model CertificateUpdateParameters {
  /**
   * The management policy for the certificate.
   */
  @encodedName("application/json", "policy")
  certificatePolicy?: CertificatePolicy;

  /**
   * The attributes of the certificate (optional).
   */
  @encodedName("application/json", "attributes")
  certificateAttributes?: CertificateAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;
}

/**
 * The certificate operation update parameters.
 */
model CertificateOperationUpdateParameter {
  /**
   * Indicates if cancellation was requested on the certificate operation.
   */
  @encodedName("application/json", "cancellation_requested")
  cancellationRequested: boolean;
}

/**
 * The certificate merge parameters
 */
model CertificateMergeParameters {
  /**
   * The certificate or the certificate chain to merge.
   */
  @encodedName("application/json", "x5c")
  x509Certificates: bytes[];

  /**
   * The attributes of the certificate (optional).
   */
  @encodedName("application/json", "attributes")
  certificateAttributes?: CertificateAttributes;

  /**
   * Application specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;
}

/**
 * The backup certificate result, containing the backup blob.
 */
model BackupCertificateResult {
  /**
   * The backup blob containing the backed up certificate.
   */
  value?: bytes;
}

/**
 * The certificate restore parameters.
 */
model CertificateRestoreParameters {
  /**
   * The backup blob associated with a certificate bundle.
   */
  @encodedName("application/json", "value")
  certificateBundleBackup: bytes;
}

/**
 * A list of certificates that have been deleted in this vault.
 */
@friendlyName("DeletedCertificateListResult")
model DeletedCertificateListResult is Azure.Core.Page<DeletedCertificateItem>;

/**
 * The deleted certificate item containing metadata about the deleted certificate.
 */
@resource("deletedcertificates")
model DeletedCertificateItem {
  ...CertificateItem;

  /**
   * The url of the recovery object, used to identify and recover the deleted
   * certificate.
   */
  recoveryId: string;

  /**
   * The time when the certificate is scheduled to be purged, in UTC
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  scheduledPurgeDate?: utcDateTime;

  /**
   * The time when the certificate was deleted, in UTC
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  deletedDate?: utcDateTime;
}

/**
 * The pending certificate signing request result.
 */
model PendingCertificateSigningRequestResult {
  /**
   * The pending certificate signing request as Base64 encoded string.
   */
  @visibility("read")
  value?: string;
}
