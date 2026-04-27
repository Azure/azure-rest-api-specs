import "@azure-tools/typespec-azure-core";

using Azure.Core;

namespace KeyVault;

/**
 * Operation status.
 */
@lroStatus
union OperationStatus {
  string,

  /** The operation succeeded. */
  @lroSucceeded
  Success: "Success", // The correct response should be "Succeeded", but this has already shipped.

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation failed. */
  @lroFailed
  Failed: "Failed",
}

/**
 * The Security Domain operation status.
 */
model SecurityDomainOperationStatus {
  /**
   * Operation status.
   */
  status?: OperationStatus;

  /**
   * Details of the operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original casing"
  status_details?: string;
}

/**
 * The Security Domain download operation requires customer to provide N certificates (minimum 3 and maximum 10) containing a public key in JWK format.
 */
model CertificateInfoObject {
  /**
   * Certificates needed from customer.
   */
  @maxItems(10)
  @minItems(3)
  certificates: SecurityDomainJsonWebKey[]; // TODO: These need to be unique items

  /**
   * Customer to specify the number of certificates (minimum 2 and maximum 10) to restore Security Domain.
   */
  @maxValue(10)
  @minValue(2)
  required?: int32 = 2;
}

/**
 * A JSON Web Key (JWK) for use in a security domain operation.
 */
model SecurityDomainJsonWebKey {
  /**
   * Key identifier.
   */
  kid: string;

  /**
   * JsonWebKey Key Type (kty), as defined in https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40. For Security Domain this value must be RSA.
   */
  kty: string;

  /**
   * Supported key operations.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original casing"
  key_ops: string[];

  /**
   * RSA modulus.
   */
  n: string;

  /**
   * RSA public exponent.
   */
  e: string;

  /**
   * X509 certificate chain parameter.
   */
  x5c: string[];

  /**
   * Public Key Use Parameter. This is optional and if present must be enc.
   */
  use?: string;

  /**
   * X509 certificate SHA1 thumbprint. This is optional.
   */
  x5t?: string;

  /**
   * X509 certificate SHA256 thumbprint.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original casing"
  `x5t#S256`: string;

  /**
   * Algorithm intended for use with the key.
   */
  alg: string;
}

/**
 * The Security Domain.
 */
model SecurityDomainObject {
  /**
   * The Security Domain.
   */
  value: string;
}

/**
 * Security Domain transfer key.
 */
model TransferKey {
  /**
   * Specifies the format of the transfer key.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original casing"
  key_format?: string = "jwk";

  /**
   * Specifies the transfer key in JWK format.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original casing"
  transfer_key: SecurityDomainJsonWebKey;
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
  @visibility(Lifecycle.Read)
  @encode("unixTimestamp", int32)
  created?: utcDateTime;

  /**
   * Last updated time in UTC.
   */
  @visibility(Lifecycle.Read)
  @encode("unixTimestamp", int32)
  updated?: utcDateTime;
}
