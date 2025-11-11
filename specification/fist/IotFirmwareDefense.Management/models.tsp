import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using Versioning;

@versioned(Versions)
namespace Microsoft.IoTFirmwareDefense;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of a firmware analysis job.")
union Status {
  @doc("The analysis job is queued")
  Pending: "Pending",

  @doc("The firmware is currently being extracted")
  Extracting: "Extracting",

  @doc("Analysis is being run on the firmware")
  Analyzing: "Analyzing",

  @doc("Analysis job results are ready")
  Ready: "Ready",

  @doc("An error occurred while running firmware analysis")
  Error: "Error",

  string,
}

@doc("The status of a firmware analysis job.")
union ProvisioningState {
  string,

  @doc("The request has successfully completed.")
  Succeeded: "Succeeded",

  @doc("There was an error during the request.")
  Failed: "Failed",

  @doc("The request was canceled.")
  Canceled: "Canceled",

  @doc("The request is queued and awaiting execution")
  Pending: "Pending",

  @doc("The Firmware is currently being extracted.")
  Extracting: "Extracting",

  @doc("Analysis is being run on the firmware")
  Analyzing: "Analyzing",
}

@doc("Describes the type of summary.")
union SummaryType {
  @doc("The summary contains information about the submitted firmware")
  Firmware: "Firmware",

  @doc("The summary contains information about the Common Vulnerabilities and Exposures analysis results")
  CommonVulnerabilitiesAndExposures: "CommonVulnerabilitiesAndExposures",

  @doc("The summary contains information about the binary hardening analysis results")
  BinaryHardening: "BinaryHardening",

  @doc("The summary contains information about the cryptographic certificate analysis results")
  CryptoCertificate: "CryptoCertificate",

  @doc("The summary contains information about the cryptographic key analysis results")
  CryptoKey: "CryptoKey",

  string,
}

@doc("String to indicate if the executable is 32 or 64 bit.")
union ExecutableClass {
  @doc("The binary is 32-bit.")
  x86: "x86",

  @doc("The binary is 64-bit.")
  x64: "x64",

  string,
}

@doc("Binary hardening of a firmware.")
model BinaryHardeningResult {
  @doc("ID for the binary hardening result.")
  binaryHardeningId?: string;

  @doc("The security hardening features of the binary.")
  securityHardeningFeatures?: BinaryHardeningFeatures;

  @doc("The architecture of the binary being reported on.")
  executableArchitecture?: string;

  @doc("The path to the binary in the firmware.")
  filePath?: string;

  @doc("The executable class to indicate 32 or 64 bit.")
  executableClass?: ExecutableClass;

  @doc("The runpath property of the uploaded binary, which is a method of specifying additional paths to load objects at runtime.")
  runpath?: string;

  @doc("The rpath property of the uploaded binary, which is a deprecated method of specifying additional paths to load objects at runtime.")
  rpath?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Binary hardening features.")
model BinaryHardeningFeatures {
  @doc("Flag indicating the binary's stack is set to NX (no-execute).")
  noExecute?: boolean;

  @doc("Flag indicating the binary was compiled to be a position independent executable.")
  positionIndependentExecutable?: boolean;

  @doc("Flag indicating the binary has enabled relocation read-only protections.")
  relocationReadOnly?: boolean;

  @doc("Flag indicating if the binary was compiled with stack canaries enabled.")
  canary?: boolean;

  @doc("Flag indicating if debug symbols have been stripped from the binary.")
  stripped?: boolean;
}

@doc("Activities for which the cryptographic certificate can be used.")
union CertificateUsage {
  @doc("This certificate can be used to add a signature to a message")
  DigitalSignature: "digitalSignature",

  @doc("This certificates provides a non-repudiation service that protects against false denial of a message")
  NonRepudiation: "nonRepudiation",

  @doc("A synonym for NonRepudiation used in newer x509 certificates")
  ContentCommitment: "contentCommitment",

  @doc("This certificate can be used to encrypt a private or secret key")
  KeyEncipherment: "keyEncipherment",

  @doc("This certificate can be used to decrypt a private or secret key")
  DataEncipherment: "dataEncipherment",

  @doc("This certificate can be used to perform a key agreement, such as with a Diffie-Hellman key exchange")
  KeyAgreement: "keyAgreement",

  @doc("This certificate can be used to verify a other public keys")
  KeyCertSign: "keyCertSign",

  @doc("This certificate can be used to verify a certificate revocation list")
  CRLSign: "crlSign",

  @doc("This certificate can be only be used to encrypt data")
  EncipherOnly: "encipherOnly",

  @doc("This certificate can only be used to decrypt data")
  DecipherOnly: "decipherOnly",

  @doc("This certificate can be used to authenticate a server in a TLS/SSL connection")
  ServerAuthentication: "serverAuth",

  @doc("This certificate can be used to authenticate a client in a TLS/SSL connection")
  ClientAuthentication: "clientAuth",

  @doc("This certificate can be used to authenticate a code object")
  CodeSigning: "codeSigning",

  @doc("This certificate can be used to authenticate an email address")
  EmailProtection: "emailProtection",

  @doc("This certificate binds the hash of an object to a time")
  TimeStamping: "timeStamping",

  @doc("This certificate can be used to sign OCSP responses")
  OCSPSigning: "ocspSigning",

  string,
}

@doc("Crypto certificate properties")
model CryptoCertificate {
  @doc("ID for the certificate result.")
  cryptoCertId?: string;

  @doc("Name of the certificate.")
  certificateName?: string;

  @doc("Subject information of the certificate.")
  subject?: CryptoCertificateEntity;

  @doc("Issuer information of the certificate.")
  issuer?: CryptoCertificateEntity;

  @doc("Issue date for the certificate.")
  issuedDate?: utcDateTime;

  @doc("Expiration date for the certificate.")
  expirationDate?: utcDateTime;

  @doc("Role of the certificate (Root CA, etc)")
  certificateRole?: string;

  @doc("The signature algorithm used in the certificate.")
  signatureAlgorithm?: string;

  @doc("Size of the certificate's key in bits")
  certificateKeySize?: int64;

  @doc("Key algorithm used in the certificate.")
  certificateKeyAlgorithm?: string;

  @doc("Encoding used for the certificate.")
  encoding?: string;

  @doc("Serial number of the certificate.")
  serialNumber?: string;

  @doc("Fingerprint of the certificate.")
  fingerprint?: string;

  @doc("List of functions the certificate can fulfill.")
  certificateUsage?: CertificateUsage[];

  @doc("List of files where this certificate was found.")
  @visibility(Lifecycle.Read)
  filePaths?: string[];

  @doc("A matching paired private key.")
  pairedKey?: PairedKey;

  @doc("Indicates if the certificate is expired.")
  isExpired?: boolean;

  @doc("Indicates if the certificate is self-signed.")
  isSelfSigned?: boolean;

  @doc("Indicates the signature algorithm used is insecure according to NIST guidance.")
  isWeakSignature?: boolean;

  @doc("Indicates the certificate's key size is considered too small to be secure for the key algorithm according to NIST guidance.")
  isShortKeySize?: boolean;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Information on an entity (distinguished name) in a cryptographic certificate.")
model CryptoCertificateEntity {
  @doc("Common name of the certificate entity.")
  commonName?: string;

  @doc("Organization of the certificate entity.")
  organization?: string;

  @doc("The organizational unit of the certificate entity.")
  organizationalUnit?: string;

  @doc("Geographical state or province of the certificate entity.")
  state?: string;

  @doc("Country code of the certificate entity.")
  country?: string;
}

@doc("Details of a matching paired key or certificate.")
model PairedKey {
  @doc("ID of the paired key or certificate.")
  pairedKeyId?: string;

  @doc("The type indicating whether the paired object is a key or certificate.")
  type?: string;
}

@doc("Different types of cryptographic keys.")
union CryptoKeyType {
  @doc("The key is an asymmetric public key.")
  Public: "Public",

  @doc("The key is an asymmetric private key.")
  Private: "Private",

  string,
}

@doc("Crypto key properties")
model CryptoKey {
  @doc("ID for the key result.")
  cryptoKeyId?: string;

  @doc("Type of the key (public or private).")
  keyType?: CryptoKeyType;

  @doc("Size of the key in bits.")
  cryptoKeySize?: int64;

  @doc("Key algorithm name.")
  keyAlgorithm?: string;

  @doc("Functions the key can fulfill.")
  usage?: string[];

  @doc("List of files where this key was found.")
  @visibility(Lifecycle.Read)
  filePaths?: string[];

  @doc("A matching paired key or certificate.")
  pairedKey?: PairedKey;

  @doc("Indicates the key size is considered too small to be secure for the algorithm according to NIST guidance.")
  isShortKeySize?: boolean;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Common Vulnerability Scoring System values.")
model CvssScore {
  @doc("The version of the Common Vulnerability Scoring System (CVSS).")
  version: int32;

  @doc("The score of the CVE according to the CVSS specified.")
  score?: float32;
}

@doc("Legacy component of a CVE result.")
@added(Versions.v2025_08_02)
model CveComponent {
  @doc("ID of the SBOM component.")
  componentId?: string;

  @doc("Name of the SBOM component.")
  name?: string;

  @doc("Version of the SBOM component.")
  version?: string;
}

@doc("Details of a CVE detected in firmware.")
model CveResult {
  @doc("ID of the CVE result.")
  cveId?: string;

  @doc("ID of the affected SBOM component.")
  componentId?: string;

  @doc("Name of the affected SBOM component.")
  componentName?: string;

  @doc("Version of the affected SBOM component.")
  componentVersion?: string;

  @doc("Severity of the CVE.")
  severity?: string;

  @doc("Name of the CVE.")
  cveName?: string;

  @added(Versions.v2025_08_02)
  @doc("Legacy property for what is now componentName")
  component?: CveComponent;

  @added(Versions.v2025_08_02)
  @doc("Legacy property for the effective CVE score.")
  cvssScore?: string;

  @added(Versions.v2025_08_02)
  @doc("Legacy property for the CVE CVSS version 2 score, if one existed.")
  cvssV2Score?: string;

  @added(Versions.v2025_08_02)
  @doc("Legacy property for the CVE CVSS version 3 score, if one existed.")
  cvssV3Score?: string;

  @added(Versions.v2025_08_02)
  @doc("Legacy property for the what CVSS version score was stored in the cvssScore property")
  cvssVersion?: string;

  @doc("The most recent CVSS score of the CVE.")
  effectiveCvssScore?: float32;

  @doc("The version of the effectiveCvssScore property.")
  effectiveCvssVersion?: int32;

  @doc("All known CVSS scores for the CVE.")
  @extension("x-ms-identifiers", #[])
  cvssScores?: CvssScore[];

  @doc("The list of reference links for the CVE.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #["href"])
  links?: CveLink[];

  @doc("The CVE description.")
  description?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of a reference link for a CVE.")
model CveLink {
  @doc("The destination of the reference link.")
  href?: url;

  @doc("The label of the reference link.")
  label?: string;
}

@doc("Firmware properties.")
model FirmwareProperties {
  @doc("File name for a firmware that user uploaded.")
  fileName?: string;

  @doc("Firmware vendor.")
  @added(Versions.v2025_08_02)
  vendor?: string;

  @doc("Firmware vendor.")
  @removed(Versions.v2025_08_02)
  @renamedFrom(Versions.v2025_08_02, "vendor")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_. ,'\"~=(){}:]*$")
  legacyVendor?: string;

  @doc("Firmware model.")
  @added(Versions.v2025_08_02)
  `model`?: string;

  @doc("Firmware model.")
  @removed(Versions.v2025_08_02)
  @renamedFrom(Versions.v2025_08_02, "model")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_. ,'\"~=(){}:]*$")
  legacyModel?: string;

  @doc("Firmware version.")
  @added(Versions.v2025_08_02)
  version?: string;

  @doc("Firmware version.")
  @removed(Versions.v2025_08_02)
  @renamedFrom(Versions.v2025_08_02, "version")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_. ,'\"~=(){}:]*$")
  legacyVersion?: string;

  @doc("User-specified description of the firmware.")
  description?: string;

  @doc("File size of the uploaded firmware image.")
  fileSize?: int64;

  @doc("The status of firmware scan.")
  status?: Status;

  @doc("A list of errors or other messages generated during firmware analysis")
  @extension("x-ms-identifiers", #[])
  statusMessages?: StatusMessage[];

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Error and status message")
model StatusMessage {
  @doc("The error code")
  errorCode?: int64;

  @doc("The error or status message")
  message?: string;
}

@doc("Firmware definition")
model FirmwareUpdateDefinition {
  @doc("The editable properties of a firmware")
  properties?: FirmwareProperties;
}

@doc("Url data for creating or accessing a blob file.")
model UrlToken {
  @doc("SAS URL for creating or accessing a blob file.")
  @visibility(Lifecycle.Read)
  url?: url;
}

@doc("Password hash properties")
model PasswordHash {
  @doc("ID for password hash")
  passwordHashId?: string;

  @doc("File path of the password hash")
  filePath?: string;

  @doc("Salt of the password hash")
  salt?: string;

  @doc("Hash of the password")
  hash?: string;

  @doc("Context of password hash")
  context?: string;

  @doc("User name of password hash")
  username?: string;

  @doc("Algorithm of the password hash")
  algorithm?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("SBOM component of a firmware.")
model SbomComponent {
  @doc("ID for the component.")
  componentId?: string;

  @doc("Name for the component.")
  componentName?: string;

  @doc("Version for the component.")
  version?: string;

  @doc("License for the component.")
  license?: string;

  @doc("File paths related to the component. Note, relatedFiles should be used instead of this property.")
  filePaths?: string[];

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of an analysis summary.")
@discriminator("summaryType")
model SummaryResourceProperties {
  @doc("The type of summary.")
  summaryType: SummaryType;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of a file detected in the filesystem related to an SBOM component.")
model SbomFileProperties {
  @doc("File path related to the component.")
  filePath: string;

  @doc("The SHA1 hash of the contents at the file path.")
  sha1Sum: string;

  @doc("The SHA256 hash of the contents at the file path.")
  sha256Sum: string;
}

@doc("Workspace properties.")
model WorkspaceProperties {
  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties for generating an upload URL")
model GenerateUploadUrlRequest {
  @doc("A unique ID for the firmware to be uploaded.")
  firmwareId?: string;
}

@doc("Properties for high level summary of firmware analysis results.")
model FirmwareSummary extends SummaryResourceProperties {
  @doc("Total extracted size of the firmware in bytes.")
  extractedSize?: int64;

  @doc("Firmware file size in bytes.")
  fileSize?: int64;

  @doc("Extracted file count.")
  extractedFileCount?: int64;

  @doc("Components count.")
  componentCount?: int64;

  @doc("Binary count")
  binaryCount?: int64;

  @doc("Time used for analysis")
  analysisTimeSeconds?: int64;

  @doc("The number of root file systems found.")
  rootFileSystems?: int64;

  @doc("Describes the type of summary.")
  summaryType: "Firmware";
}

@doc("Properties for a CVE analysis summary.")
model CveSummary extends SummaryResourceProperties {
  @doc("The total number of critical severity CVEs detected")
  criticalCveCount?: int64;

  @doc("The total number of high severity CVEs detected")
  highCveCount?: int64;

  @doc("The total number of medium severity CVEs detected")
  mediumCveCount?: int64;

  @doc("The total number of low severity CVEs detected")
  lowCveCount?: int64;

  @doc("The total number of unknown severity CVEs detected")
  unknownCveCount?: int64;

  @doc("Describes the type of summary object.")
  summaryType: "CommonVulnerabilitiesAndExposures";
}

@doc("Properties for a binary hardening analysis summary.")
model BinaryHardeningSummaryResource extends SummaryResourceProperties {
  @doc("Total number of binaries that were analyzed")
  totalFiles?: int64;

  @doc("Total number of analyzed files that were found to have a nonexecutable stack")
  notExecutableStackCount?: int64;

  @doc("Total number of analyzed files that were compiled to be a position independent executable")
  positionIndependentExecutableCount?: int64;

  @doc("Total number of analyzed files that have enabled relocation read-only protections")
  relocationReadOnlyCount?: int64;

  @doc("Total number of analyzed files that have stack canaries enabled")
  stackCanaryCount?: int64;

  @doc("Total number of analyzed files that have debug symbols stripped")
  strippedBinaryCount?: int64;

  @doc("Describes the type of summary object.")
  summaryType: "BinaryHardening";
}

@doc("Properties for cryptographic certificate summary.")
model CryptoCertificateSummaryResource extends SummaryResourceProperties {
  @doc("Total number of certificates found.")
  totalCertificateCount?: int64;

  @doc("Total number of paired private keys found for the certificates.")
  pairedKeyCount?: int64;

  @doc("Total number of expired certificates found.")
  expiredCertificateCount?: int64;

  @doc("Total number of nearly expired certificates found.")
  expiringSoonCertificateCount?: int64;

  @doc("Total number of certificates found using a weak signature algorithm.")
  weakSignatureCount?: int64;

  @doc("Total number of certificates found that are self-signed.")
  selfSignedCertificateCount?: int64;

  @doc("Total number of certificates found that have an insecure key size for the key algorithm.")
  shortKeySizeCount?: int64;

  @doc("Describes the type of summary.")
  summaryType: "CryptoCertificate";
}

@doc("Properties for cryptographic key summary.")
model CryptoKeySummaryResource extends SummaryResourceProperties {
  @doc("Total number of cryptographic keys found.")
  totalKeyCount?: int64;

  @doc("Total number of (non-certificate) public keys found.")
  publicKeyCount?: int64;

  @doc("Total number of private keys found.")
  privateKeyCount?: int64;

  @doc("Total number of keys found that have a matching paired key or certificate.")
  pairedKeyCount?: int64;

  @doc("Total number of keys found that have an insecure key size for the algorithm.")
  shortKeySizeCount?: int64;

  @doc("Describes the type of summary.")
  summaryType: "CryptoKey";
}

@doc("Properties of a workspaces usage metrics.")
model UsageMetricProperties {
  @doc("The number of firmware analysis jobs that have been submitted in the current month.")
  @visibility(Lifecycle.Read)
  monthlyFirmwareUploadCount: int64;

  @doc("The total number of firmwares that are in the workspace.")
  @visibility(Lifecycle.Read)
  totalFirmwareCount: int64;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
