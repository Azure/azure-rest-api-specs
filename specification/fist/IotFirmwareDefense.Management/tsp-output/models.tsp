import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace fist;

enum Status {
  Pending,
  Extracting,
  Analyzing,
  Ready,
  Error,
}

enum ProvisioningState {
  Accepted,
  Succeeded,
  Canceled,
  Failed,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum IsUpdateAvailable {
  True,
  False,
}

enum NxFlag {
  True,
  False,
}

enum PieFlag {
  True,
  False,
}

enum RelroFlag {
  True,
  False,
}

enum CanaryFlag {
  True,
  False,
}

enum StrippedFlag {
  True,
  False,
}

enum IsExpired {
  True,
  False,
}

enum IsSelfSigned {
  True,
  False,
}

enum IsWeakSignature {
  True,
  False,
}

enum IsShortKeySize {
  True,
  False,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

@doc("List of firmwares")
model FirmwareList is Azure.Core.Page<Firmware>;

@doc("Firmware definition")
model Firmware {
  ...ProxyResource;

  @doc("The properties of a firmware")
  properties?: FirmwareProperties;
}

@doc("Firmware properties.")
model FirmwareProperties {
  @doc("File name for a firmware that user uploaded.")
  fileName?: string;

  @doc("Firmware vendor.")
  vendor?: string;

  @doc("Firmware model.")
  `model`?: string;

  @doc("Firmware version.")
  version?: string;

  @doc("User-specified description of the firmware.")
  description?: string;

  @doc("File size of the uploaded firmware image.")
  fileSize?: int32;

  @doc("The status of firmware scan.")
  status?: Status;

  @doc("A list of errors or other messages generated during firmware analysis")
  statusMessages?: unknown[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("Firmware definition")
model FirmwareUpdateDefinition {
  @doc("The editable properties of a firmware")
  properties?: FirmwareProperties;
}

@doc("Url data for creating or accessing a blob file.")
model UrlToken {
  @doc("SAS URL for creating or accessing a blob file.")
  @visibility("read")
  url?: string;

  @doc("SAS URL for file uploading. Kept for backwards compatibility")
  @visibility("read")
  uploadUrl?: string;
}

@doc("Summary result after scanning the firmware.")
model FirmwareSummary {
  @doc("Total extracted size of the firmware in bytes.")
  extractedSize?: int32;

  @doc("Firmware file size in bytes.")
  fileSize?: int32;

  @doc("Extracted file count.")
  extractedFileCount?: int32;

  @doc("Components count.")
  componentCount?: int32;

  @doc("Binary count")
  binaryCount?: int32;

  @doc("Time used for analysis")
  analysisTimeSeconds?: int32;

  @doc("The number of root file systems found.")
  rootFileSystems?: int32;
}

@doc("List result for components")
model ComponentList is Azure.Core.Page<Component>;

@doc("Component of a firmware.")
model Component {
  @doc("ID for the component.")
  componentId?: string;

  @doc("Name for the component.")
  componentName?: string;

  @doc("Version for the component.")
  version?: string;

  @doc("License for the component.")
  license?: string;

  @doc("Release date for the component.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  releaseDate?: utcDateTime;

  @doc("Paths of the component.")
  paths?: string[];

  @doc("Flag if new update is available for the component.")
  isUpdateAvailable?: IsUpdateAvailable;
}

@doc("List result for binary hardening")
model BinaryHardeningList is Azure.Core.Page<BinaryHardening>;

@doc("Binary hardening of a firmware.")
model BinaryHardening {
  @doc("ID for the binary hardening result.")
  binaryHardeningId?: string;

  @doc("Binary hardening features.")
  features?: BinaryHardeningFeatures;

  @doc("The architecture of the uploaded firmware.")
  architecture?: string;

  @doc("path for binary hardening.")
  path?: string;

  @doc("class for binary hardening.")
  class?: string;

  @doc("The runpath of the uploaded firmware.")
  runpath?: string;

  @doc("The rpath of the uploaded firmware.")
  rpath?: string;
}

@doc("Binary hardening features.")
model BinaryHardeningFeatures {
  @doc("NX flag.")
  nx?: NxFlag;

  @doc("PIE flag.")
  pie?: PieFlag;

  @doc("RELRO flag.")
  relro?: RelroFlag;

  @doc("Canary flag.")
  canary?: CanaryFlag;

  @doc("Stripped flag.")
  stripped?: StrippedFlag;
}

@doc("Binary hardening summary percentages.")
model BinaryHardeningSummary {
  @doc("Total number of binaries that were analyzed")
  totalFiles?: int32;

  @doc("NX summary percentage")
  nx?: int32;

  @doc("PIE summary percentage")
  pie?: int32;

  @doc("RELRO summary percentage")
  relro?: int32;

  @doc("Canary summary percentage")
  canary?: int32;

  @doc("Stripped summary percentage")
  stripped?: int32;
}

@doc("Password hashes list")
model PasswordHashList is Azure.Core.Page<PasswordHash>;

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
}

@doc("List result for CVE")
model CveList is Azure.Core.Page<Cve>;

@doc("Known CVEs of a firmware.")
model Cve {
  @doc("ID of CVE")
  cveId?: string;

  @doc("Component of CVE")
  component?: unknown;

  @doc("Severity of CVE")
  severity?: string;

  @doc("Name of CVE")
  name?: string;

  @doc("""
A single CVSS score to represent the CVE. If a V3 score is specified, then it
will use the V3 score. Otherwise if the V2 score is specified it will be the V2
score
""")
  cvssScore?: string;

  @doc("Cvss version of CVE")
  cvssVersion?: string;

  @doc("Cvss V2 score of CVE")
  cvssV2Score?: string;

  @doc("Cvss V3 score of CVE")
  cvssV3Score?: string;

  @doc("Publish date of CVE")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishDate?: utcDateTime;

  @doc("Updated date of CVE")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedDate?: utcDateTime;

  @doc("The list of CVE links.")
  @visibility("read")
  links?: CveLink[];

  @doc("Description of CVE")
  description?: string;
}

@doc("Link for CVE")
model CveLink {
  @doc("Href of CVE link")
  href?: string;

  @doc("Label of CVE link")
  label?: string;
}

@doc("CVE summary values.")
model CveSummary {
  @doc("The total number of critical severity CVEs detected")
  critical?: int32;

  @doc("The total number of high severity CVEs detected")
  high?: int32;

  @doc("The total number of medium severity CVEs detected")
  medium?: int32;

  @doc("The total number of low severity CVEs detected")
  low?: int32;

  @doc("The total number of unknown severity CVEs detected")
  `unknown`?: int32;

  @doc("The total number of undefined severity CVEs detected")
  undefined?: int32;
}

@doc("Cryptographic certificate summary values.")
model CryptoCertificateSummary {
  @doc("Total number of certificates found.")
  totalCertificates?: int32;

  @doc("Total number of paired private keys found for the certificates.")
  pairedKeys?: int32;

  @doc("Total number of expired certificates found.")
  expired?: int32;

  @doc("Total number of nearly expired certificates found.")
  expiringSoon?: int32;

  @doc("Total number of certificates found using a weak signature algorithm.")
  weakSignature?: int32;

  @doc("Total number of certificates found that are self-signed.")
  selfSigned?: int32;

  @doc("""
Total number of certificates found that have an insecure key size for the key
algorithm.
""")
  shortKeySize?: int32;
}

@doc("Cryptographic key summary values.")
model CryptoKeySummary {
  @doc("Total number of cryptographic keys found.")
  totalKeys?: int32;

  @doc("Total number of (non-certificate) public keys found.")
  publicKeys?: int32;

  @doc("Total number of private keys found.")
  privateKeys?: int32;

  @doc("Total number of keys found that have a matching paired key or certificate.")
  pairedKeys?: int32;

  @doc("Total number of keys found that have an insecure key size for the algorithm.")
  shortKeySize?: int32;
}

@doc("Crypto certificates list")
model CryptoCertificateList is Azure.Core.Page<CryptoCertificate>;

@doc("Crypto certificate properties")
model CryptoCertificate {
  @doc("ID for the certificate.")
  cryptoCertId?: string;

  @doc("Name of the certificate.")
  name?: string;

  @doc("Subject information of the certificate.")
  subject?: CryptoCertificateEntity;

  @doc("Issuer information of the certificate.")
  issuer?: CryptoCertificateEntity;

  @doc("Issue date for the certificate.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issuedDate?: utcDateTime;

  @doc("Expiration date for the certificate.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Role of the certificate (Root CA, etc)")
  role?: string;

  @doc("The signature algorithm used in the certificate.")
  signatureAlgorithm?: string;

  @doc("Size of the certificate's key in bits")
  keySize?: int32;

  @doc("Key algorithm used in the certificate.")
  keyAlgorithm?: string;

  @doc("Encoding used for the certificate.")
  encoding?: string;

  @doc("Serial number of the certificate.")
  serialNumber?: string;

  @doc("Fingerprint of the certificate.")
  fingerprint?: string;

  @doc("List of functions the certificate can fulfill.")
  usage?: string[];

  @doc("List of files paths for this certificate")
  @visibility("read")
  filePaths?: string[];

  @doc("A matching paired private key.")
  pairedKey?: PairedKey;

  @doc("Indicates if the certificate is expired.")
  isExpired?: IsExpired;

  @doc("Indicates if the certificate was self-signed.")
  isSelfSigned?: IsSelfSigned;

  @doc("Indicates the signature algorithm used is insecure.")
  isWeakSignature?: IsWeakSignature;

  @doc("""
Indicates the certificate's key size is considered too small to be secure for
the key algorithm.
""")
  isShortKeySize?: IsShortKeySize;
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
  id?: string;

  @doc("The type indicating whether the paired object is a key or certificate.")
  type?: string;

  @doc("Additional paired key properties")
  additionalProperties?: unknown;
}

@doc("Crypto keys list")
model CryptoKeyList is Azure.Core.Page<CryptoKey>;

@doc("Crypto key properties")
model CryptoKey {
  @doc("ID for the key.")
  cryptoKeyId?: string;

  @doc("Type of the key (public or private).")
  keyType?: string;

  @doc("Size of the key in bits.")
  keySize?: int32;

  @doc("Key algorithm name.")
  keyAlgorithm?: string;

  @doc("Functions the key can fulfill.")
  usage?: string[];

  @doc("List of files paths for this key.")
  @visibility("read")
  filePaths?: string[];

  @doc("A matching paired key or certificate.")
  pairedKey?: PairedKey;

  @doc("Indicates the key size is considered too small to be secure for the algorithm.")
  isShortKeySize?: IsShortKeySize;
}

@doc("Return a list of firmware analysis workspaces.")
model WorkspaceList is Azure.Core.Page<Workspace>;

@doc("Firmware analysis workspace.")
model Workspace {
  ...TrackedResource;

  @doc("Workspace properties.")
  properties?: WorkspaceProperties;
}

@doc("Workspace properties.")
model WorkspaceProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("Firmware analysis workspace.")
model WorkspaceUpdateDefinition {
  @doc("The editable workspace properties.")
  properties?: WorkspaceProperties;
}

@doc("Properties for generating an upload URL")
model GenerateUploadUrlRequest {
  @doc("A unique ID for the firmware to be uploaded.")
  firmwareId?: string;
}

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}

@doc("Component for CVE")
model CveComponent {
  @doc("ID of CVE component")
  componentId?: string;

  @doc("Name of CVE component")
  name?: string;

  @doc("Version of CVE component")
  version?: string;
}
