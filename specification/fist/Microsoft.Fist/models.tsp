import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.IoTFirmwareDefense;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The status of firmware scan.
 */
enum Status {
  Pending,
  Extracting,
  Analyzing,
  Ready,
  Error,
}

/**
 * Provisioning state of the resource.
 */
enum ProvisioningState {
  Accepted,
  Succeeded,
  Canceled,
  Failed,
}

/**
 * Describes the type of summary.
 */
enum SummaryType {
  Firmware,
  CVE,
  BinaryHardening,
  CryptoCertificate,
  CryptoKey,
}

enum SummaryName {
  Firmware,
  CVE,
  BinaryHardening,
  CryptoCertificate,
  CryptoKey,
}

/**
 * List of binary hardening results.
 */
model BinaryHardeningListResult is Azure.Core.Page<BinaryHardeningResource>;

/**
 * binary hardening analysis result resource
 */
model BinaryHardeningResource extends Resource {
  /**
   * The properties of a binary hardening result found within a firmware image
   */
  @extension("x-ms-client-flatten", true)
  properties?: BinaryHardeningResult;
}

/**
 * Binary hardening of a firmware.
 */
model BinaryHardeningResult {
  /**
   * ID for the binary hardening result.
   */
  binaryHardeningId?: string;

  /**
   * Binary hardening features.
   */
  @extension("x-ms-client-flatten", true)
  features?: BinaryHardeningFeatures;

  /**
   * The architecture of the uploaded firmware.
   */
  architecture?: string;

  /**
   * The executable path.
   */
  filePath?: string;

  /**
   * The executable class to indicate 32 or 64 bit.
   */
  class?: string;

  /**
   * The runpath of the uploaded firmware.
   */
  runpath?: string;

  /**
   * The rpath of the uploaded firmware.
   */
  rpath?: string;
}

/**
 * Binary hardening features.
 */
model BinaryHardeningFeatures {
  /**
   * NX (no-execute) flag.
   */
  nx?: boolean;

  /**
   * PIE (position independent executable) flag.
   */
  pie?: boolean;

  /**
   * RELRO (relocation read-only) flag.
   */
  relro?: boolean;

  /**
   * Canary (stack canaries) flag.
   */
  canary?: boolean;

  /**
   * Stripped flag.
   */
  stripped?: boolean;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * List of crypto certificates.
 */
model CryptoCertificateListResult is Azure.Core.Page<CryptoCertificateResource>;

/**
 * Crypto certificate resource
 */
model CryptoCertificateResource extends Resource {
  /**
   * The properties of a crypto certificate found within a firmware image
   */
  @extension("x-ms-client-flatten", true)
  properties?: CryptoCertificate;
}

/**
 * Crypto certificate properties
 */
model CryptoCertificate {
  /**
   * ID for the certificate result.
   */
  cryptoCertId?: string;

  /**
   * Name of the certificate.
   */
  name?: string;

  /**
   * Subject information of the certificate.
   */
  subject?: CryptoCertificateEntity;

  /**
   * Issuer information of the certificate.
   */
  issuer?: CryptoCertificateEntity;

  /**
   * Issue date for the certificate.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issuedDate?: utcDateTime;

  /**
   * Expiration date for the certificate.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Role of the certificate (Root CA, etc)
   */
  role?: string;

  /**
   * The signature algorithm used in the certificate.
   */
  signatureAlgorithm?: string;

  /**
   * Size of the certificate's key in bits
   */
  keySize?: int64;

  /**
   * Key algorithm used in the certificate.
   */
  keyAlgorithm?: string;

  /**
   * Encoding used for the certificate.
   */
  encoding?: string;

  /**
   * Serial number of the certificate.
   */
  serialNumber?: string;

  /**
   * Fingerprint of the certificate.
   */
  fingerprint?: string;

  /**
   * List of functions the certificate can fulfill.
   */
  usage?: string[];

  /**
   * List of files where this certificate was found.
   */
  @visibility("read")
  filePaths?: string[];

  /**
   * A matching paired private key.
   */
  pairedKey?: PairedKey;

  /**
   * Indicates if the certificate is expired.
   */
  isExpired?: boolean;

  /**
   * Indicates if the certificate is self-signed.
   */
  isSelfSigned?: boolean;

  /**
   * Indicates the signature algorithm used is insecure.
   */
  isWeakSignature?: boolean;

  /**
   * Indicates the certificate's key size is considered too small to be secure for the key algorithm.
   */
  isShortKeySize?: boolean;
}

/**
 * Information on an entity (distinguished name) in a cryptographic certificate.
 */
model CryptoCertificateEntity {
  /**
   * Common name of the certificate entity.
   */
  commonName?: string;

  /**
   * Organization of the certificate entity.
   */
  organization?: string;

  /**
   * The organizational unit of the certificate entity.
   */
  organizationalUnit?: string;

  /**
   * Geographical state or province of the certificate entity.
   */
  state?: string;

  /**
   * Country code of the certificate entity.
   */
  country?: string;
}

/**
 * Details of a matching paired key or certificate.
 */
model PairedKey {
  /**
   * ID of the paired key or certificate.
   */
  id?: string;

  /**
   * The type indicating whether the paired object is a key or certificate.
   */
  type?: string;
}

/**
 * List of crypto keys.
 */
model CryptoKeyListResult is Azure.Core.Page<CryptoKeyResource>;

/**
 * Crypto key resource
 */
model CryptoKeyResource extends Resource {
  /**
   * The properties of a crypto key found within a firmware image
   */
  @extension("x-ms-client-flatten", true)
  properties?: CryptoKey;
}

/**
 * Crypto key properties
 */
model CryptoKey {
  /**
   * ID for the key result.
   */
  cryptoKeyId?: string;

  /**
   * Type of the key (public or private).
   */
  keyType?: string;

  /**
   * Size of the key in bits.
   */
  keySize?: int64;

  /**
   * Key algorithm name.
   */
  keyAlgorithm?: string;

  /**
   * Functions the key can fulfill.
   */
  usage?: string[];

  /**
   * List of files where this key was found.
   */
  @visibility("read")
  filePaths?: string[];

  /**
   * A matching paired key or certificate.
   */
  pairedKey?: PairedKey;

  /**
   * Indicates the key size is considered too small to be secure for the algorithm.
   */
  isShortKeySize?: boolean;
}

/**
 * List of CVE results.
 */
model CveListResult is Azure.Core.Page<CveResource>;

/**
 * CVE analysis result resource
 */
model CveResource extends Resource {
  /**
   * The properties of a CVE result found within a firmware image
   */
  @extension("x-ms-client-flatten", true)
  properties?: CveResult;
}

/**
 * Details of a CVE detected in firmware.
 */
model CveResult {
  /**
   * ID of the CVE result.
   */
  cveId?: string;

  /**
   * The SBOM component for the CVE.
   */
  component?: CveComponent;

  /**
   * Severity of the CVE.
   */
  severity?: string;

  /**
   * Name of the CVE.
   */
  name?: string;

  /**
   * A single CVSS score to represent the CVE. If a V3 score is specified, then it will use the V3 score. Otherwise if the V2 score is specified it will be the V2 score.
   */
  cvssScore?: string;

  /**
   * CVSS version of the CVE.
   */
  cvssVersion?: string;

  /**
   * CVSS V2 score of the CVE.
   */
  cvssV2Score?: string;

  /**
   * CVSS V3 score of the CVE.
   */
  cvssV3Score?: string;

  /**
   * The list of reference links for the CVE.
   */
  @visibility("read")
  links?: CveLink[];

  /**
   * The CVE description.
   */
  description?: string;
}

/**
 * Properties of the SBOM component for a CVE.
 */
model CveComponent {
  /**
   * ID of the SBOM component
   */
  componentId?: string;

  /**
   * Name of the SBOM component
   */
  name?: string;

  /**
   * Version of the SBOM component.
   */
  version?: string;
}

/**
 * Properties of a reference link for a CVE.
 */
model CveLink {
  /**
   * The destination of the reference link.
   */
  href?: url;

  /**
   * The label of the reference link.
   */
  label?: string;
}

/**
 * Firmware properties.
 */
model FirmwareProperties {
  /**
   * File name for a firmware that user uploaded.
   */
  fileName?: string;

  /**
   * Firmware vendor.
   */
  vendor?: string;

  /**
   * Firmware model.
   */
  `model`?: string;

  /**
   * Firmware version.
   */
  version?: string;

  /**
   * User-specified description of the firmware.
   */
  description?: string;

  /**
   * File size of the uploaded firmware image.
   */
  fileSize?: int64;

  /**
   * The status of firmware scan.
   */
  status?: Status = Status.Pending;

  /**
   * A list of errors or other messages generated during firmware analysis
   */
  statusMessages?: StatusMessage[];

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Error and status message
 */
model StatusMessage {
  /**
   * The error code
   */
  errorCode?: int64;

  /**
   * The error or status message
   */
  message?: string;
}

/**
 * Firmware definition
 */
model FirmwareUpdateDefinition {
  /**
   * The editable properties of a firmware
   */
  @extension("x-ms-client-flatten", true)
  properties?: FirmwareProperties;
}

/**
 * Url data for creating or accessing a blob file.
 */
model UrlToken {
  /**
   * SAS URL for creating or accessing a blob file.
   */
  @visibility("read")
  url?: url;
}

/**
 * List of password hash results
 */
model PasswordHashListResult is Azure.Core.Page<PasswordHashResource>;

/**
 * Password hash resource
 */
model PasswordHashResource extends Resource {
  /**
   * The properties of a password hash found within a firmware image
   */
  @extension("x-ms-client-flatten", true)
  properties?: PasswordHash;
}

/**
 * Password hash properties
 */
model PasswordHash {
  /**
   * ID for password hash
   */
  passwordHashId?: string;

  /**
   * File path of the password hash
   */
  filePath?: string;

  /**
   * Salt of the password hash
   */
  salt?: string;

  /**
   * Hash of the password
   */
  hash?: string;

  /**
   * Context of password hash
   */
  context?: string;

  /**
   * User name of password hash
   */
  username?: string;

  /**
   * Algorithm of the password hash
   */
  algorithm?: string;
}

/**
 * List of SBOM results.
 */
model SbomComponentListResult is Azure.Core.Page<SbomComponentResource>;

/**
 * SBOM analysis result resource
 */
model SbomComponentResource extends Resource {
  /**
   * The properties of an SBOM component found within a firmware image
   */
  @extension("x-ms-client-flatten", true)
  properties?: SbomComponent;
}

/**
 * SBOM component of a firmware.
 */
model SbomComponent {
  /**
   * ID for the component.
   */
  componentId?: string;

  /**
   * Name for the component.
   */
  componentName?: string;

  /**
   * Version for the component.
   */
  version?: string;

  /**
   * License for the component.
   */
  license?: string;

  /**
   * File paths related to the component.
   */
  filePaths?: string[];
}

/**
 * Properties of an analysis summary.
 */
@discriminator("summaryType")
model SummaryResourceProperties {}

/**
 * Workspace properties.
 */
model WorkspaceProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Firmware analysis workspace.
 */
model WorkspaceUpdateDefinition {
  /**
   * The editable workspace properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkspaceProperties;
}

/**
 * Properties for generating an upload URL
 */
model GenerateUploadUrlRequest {
  /**
   * A unique ID for the firmware to be uploaded.
   */
  firmwareId?: string;
}

/**
 * Properties for high level summary of firmware analysis results.
 */
model FirmwareSummary extends SummaryResourceProperties {
  /**
   * Total extracted size of the firmware in bytes.
   */
  extractedSize?: int64;

  /**
   * Firmware file size in bytes.
   */
  fileSize?: int64;

  /**
   * Extracted file count.
   */
  extractedFileCount?: int64;

  /**
   * Components count.
   */
  componentCount?: int64;

  /**
   * Binary count
   */
  binaryCount?: int64;

  /**
   * Time used for analysis
   */
  analysisTimeSeconds?: int64;

  /**
   * The number of root file systems found.
   */
  rootFileSystems?: int64;

  /**
   * Describes the type of summary.
   */
  summaryType: "Firmware";
}

/**
 * Properties for a CVE analysis summary.
 */
model CveSummary extends SummaryResourceProperties {
  /**
   * The total number of critical severity CVEs detected
   */
  critical?: int64;

  /**
   * The total number of high severity CVEs detected
   */
  high?: int64;

  /**
   * The total number of medium severity CVEs detected
   */
  medium?: int64;

  /**
   * The total number of low severity CVEs detected
   */
  low?: int64;

  /**
   * The total number of unknown severity CVEs detected
   */
  `unknown`?: int64;

  /**
   * Describes the type of summary.
   */
  summaryType: "CVE";
}

/**
 * Properties for a binary hardening analysis summary.
 */
model BinaryHardeningSummaryResource extends SummaryResourceProperties {
  /**
   * Total number of binaries that were analyzed
   */
  totalFiles?: int64;

  /**
   * NX summary percentage
   */
  nx?: int32;

  /**
   * PIE summary percentage
   */
  pie?: int32;

  /**
   * RELRO summary percentage
   */
  relro?: int32;

  /**
   * Canary summary percentage
   */
  canary?: int32;

  /**
   * Stripped summary percentage
   */
  stripped?: int32;

  /**
   * Describes the type of summary.
   */
  summaryType: "BinaryHardening";
}

/**
 * Properties for cryptographic certificate summary.
 */
model CryptoCertificateSummaryResource extends SummaryResourceProperties {
  /**
   * Total number of certificates found.
   */
  totalCertificates?: int64;

  /**
   * Total number of paired private keys found for the certificates.
   */
  pairedKeys?: int64;

  /**
   * Total number of expired certificates found.
   */
  expired?: int64;

  /**
   * Total number of nearly expired certificates found.
   */
  expiringSoon?: int64;

  /**
   * Total number of certificates found using a weak signature algorithm.
   */
  weakSignature?: int64;

  /**
   * Total number of certificates found that are self-signed.
   */
  selfSigned?: int64;

  /**
   * Total number of certificates found that have an insecure key size for the key algorithm.
   */
  shortKeySize?: int64;

  /**
   * Describes the type of summary.
   */
  summaryType: "CryptoCertificate";
}

/**
 * Properties for cryptographic key summary.
 */
model CryptoKeySummaryResource extends SummaryResourceProperties {
  /**
   * Total number of cryptographic keys found.
   */
  totalKeys?: int64;

  /**
   * Total number of (non-certificate) public keys found.
   */
  publicKeys?: int64;

  /**
   * Total number of private keys found.
   */
  privateKeys?: int64;

  /**
   * Total number of keys found that have a matching paired key or certificate.
   */
  pairedKeys?: int64;

  /**
   * Total number of keys found that have an insecure key size for the algorithm.
   */
  shortKeySize?: int64;

  /**
   * Describes the type of summary.
   */
  summaryType: "CryptoKey";
}
