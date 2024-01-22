import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
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
 * Flag if new update is available for the component.
 */
enum IsUpdateAvailable {
  True,
  False,
}

/**
 * NX flag.
 */
enum NxFlag {
  True,
  False,
}

/**
 * PIE flag.
 */
enum PieFlag {
  True,
  False,
}

/**
 * RELRO flag.
 */
enum RelroFlag {
  True,
  False,
}

/**
 * Canary flag.
 */
enum CanaryFlag {
  True,
  False,
}

/**
 * Stripped flag.
 */
enum StrippedFlag {
  True,
  False,
}

/**
 * Indicates if the certificate is expired.
 */
enum IsExpired {
  True,
  False,
}

/**
 * Indicates if the certificate was self-signed.
 */
enum IsSelfSigned {
  True,
  False,
}

/**
 * Indicates the signature algorithm used is insecure.
 */
enum IsWeakSignature {
  True,
  False,
}

/**
 * Indicates the key size is considered too small to be secure for the algorithm.
 */
enum IsShortKeySize {
  True,
  False,
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
  statusMessages?: Record<unknown>[];

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

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
 * Firmware definition
 */
model FirmwareUpdateDefinition {
  /**
   * The editable properties of a firmware
   */
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

  /**
   * SAS URL for file uploading. Kept for backwards compatibility
   */
  @visibility("read")
  uploadUrl?: url;
}

/**
 * Summary result after scanning the firmware.
 */
model FirmwareSummary {
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
}

/**
 * List result for components
 */
model ComponentList is Azure.Core.Page<Component>;

/**
 * Component of a firmware.
 */
model Component {
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
   * Release date for the component.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  releaseDate?: utcDateTime;

  /**
   * Paths of the component.
   */
  paths?: string[];

  /**
   * Flag if new update is available for the component.
   */
  isUpdateAvailable?: IsUpdateAvailable;
}

/**
 * List result for binary hardening
 */
model BinaryHardeningList is Azure.Core.Page<BinaryHardening>;

/**
 * Binary hardening of a firmware.
 */
model BinaryHardening {
  /**
   * ID for the binary hardening result.
   */
  binaryHardeningId?: string;

  /**
   * Binary hardening features.
   */
  features?: BinaryHardeningFeatures;

  /**
   * The architecture of the uploaded firmware.
   */
  architecture?: string;

  /**
   * path for binary hardening.
   */
  path?: string;

  /**
   * class for binary hardening.
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
   * NX flag.
   */
  nx?: NxFlag;

  /**
   * PIE flag.
   */
  pie?: PieFlag;

  /**
   * RELRO flag.
   */
  relro?: RelroFlag;

  /**
   * Canary flag.
   */
  canary?: CanaryFlag;

  /**
   * Stripped flag.
   */
  stripped?: StrippedFlag;
}

/**
 * Binary hardening summary percentages.
 */
model BinaryHardeningSummary {
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
}

/**
 * Password hashes list
 */
model PasswordHashList is Azure.Core.Page<PasswordHash>;

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
 * List result for CVE
 */
model CveList is Azure.Core.Page<Cve>;

/**
 * Known CVEs of a firmware.
 */
model Cve {
  /**
   * ID of CVE
   */
  cveId?: string;

  /**
   * Component of CVE
   */
  component?: Record<unknown>;

  /**
   * Severity of CVE
   */
  severity?: string;

  /**
   * Name of CVE
   */
  name?: string;

  /**
   * A single CVSS score to represent the CVE. If a V3 score is specified, then it will use the V3 score. Otherwise if the V2 score is specified it will be the V2 score
   */
  cvssScore?: string;

  /**
   * Cvss version of CVE
   */
  cvssVersion?: string;

  /**
   * Cvss V2 score of CVE
   */
  cvssV2Score?: string;

  /**
   * Cvss V3 score of CVE
   */
  cvssV3Score?: string;

  /**
   * Publish date of CVE
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishDate?: utcDateTime;

  /**
   * Updated date of CVE
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedDate?: utcDateTime;

  /**
   * The list of CVE links.
   */
  @visibility("read")
  links?: CveLink[];

  /**
   * Description of CVE
   */
  description?: string;
}

/**
 * Link for CVE
 */
model CveLink {
  /**
   * Href of CVE link
   */
  href?: string;

  /**
   * Label of CVE link
   */
  label?: string;
}

/**
 * CVE summary values.
 */
model CveSummary {
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
   * The total number of undefined severity CVEs detected
   */
  undefined?: int64;
}

/**
 * Cryptographic certificate summary values.
 */
model CryptoCertificateSummary {
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
}

/**
 * Cryptographic key summary values.
 */
model CryptoKeySummary {
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
}

/**
 * Crypto certificates list
 */
model CryptoCertificateList is Azure.Core.Page<CryptoCertificate>;

/**
 * Crypto certificate properties
 */
model CryptoCertificate {
  /**
   * ID for the certificate.
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
   * List of files paths for this certificate
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
  isExpired?: IsExpired;

  /**
   * Indicates if the certificate was self-signed.
   */
  isSelfSigned?: IsSelfSigned;

  /**
   * Indicates the signature algorithm used is insecure.
   */
  isWeakSignature?: IsWeakSignature;

  /**
   * Indicates the certificate's key size is considered too small to be secure for the key algorithm.
   */
  isShortKeySize?: IsShortKeySize;
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

  /**
   * Additional paired key properties
   */
  additionalProperties?: Record<unknown>;
}

/**
 * Crypto keys list
 */
model CryptoKeyList is Azure.Core.Page<CryptoKey>;

/**
 * Crypto key properties
 */
model CryptoKey {
  /**
   * ID for the key.
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
   * List of files paths for this key.
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
  isShortKeySize?: IsShortKeySize;
}

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
 * Component for CVE
 */
model CveComponent {
  /**
   * ID of CVE component
   */
  componentId?: string;

  /**
   * Name of CVE component
   */
  name?: string;

  /**
   * Version of CVE component
   */
  version?: string;
}
