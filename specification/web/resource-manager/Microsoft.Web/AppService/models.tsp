import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Versioning;

namespace Microsoft.Web;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@mediaTypeHint("application/json")
scalar stringApplicationJson extends string;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model ArmBadRequestResponse {
  ...TypeSpec.Http.Response<400>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model ArmNotFoundResponse {
  ...TypeSpec.Http.Response<404>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model ArmConflictResponse {
  ...TypeSpec.Http.Response<409>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model ArmTooManyRequestsResponse {
  ...TypeSpec.Http.Response<429>;
}

/**
 * Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment.
 */
union LoadBalancingMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Web: "Web",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Publishing: "Publishing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Web, Publishing`: "Web, Publishing",
}

/**
 * Upgrade Preference
 */
union UpgradePreference {
  string,

  /**
   * No preference on when this App Service Environment will be upgraded
   */
  None: "None",

  /**
   * This App Service Environment will be upgraded before others in the same region that have Upgrade Preference 'Late'
   */
  Early: "Early",

  /**
   * This App Service Environment will be upgraded after others in the same region that have Upgrade Preference 'Early'
   */
  Late: "Late",

  /**
   * ASEv3 only. Once an upgrade is available, this App Service Environment will wait 10 days for the upgrade to be manually initiated. After 10 days the upgrade will begin automatically
   */
  Manual: "Manual",
}

/**
 * Whether an upgrade is available for this App Service Environment.
 */
union UpgradeAvailability {
  string,

  /**
   * No upgrade is currently available for this App Service Environment
   */
  None: "None",

  /**
   * An upgrade is ready to be manually initiated on this App Service Environment
   */
  Ready: "Ready",
}

/**
 * SCM type.
 */
union ScmType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dropbox: "Dropbox",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tfs: "Tfs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocalGit: "LocalGit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GitHub: "GitHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CodePlexGit: "CodePlexGit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CodePlexHg: "CodePlexHg",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BitbucketGit: "BitbucketGit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BitbucketHg: "BitbucketHg",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ExternalGit: "ExternalGit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ExternalHg: "ExternalHg",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OneDrive: "OneDrive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VSO: "VSO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VSTSRM: "VSTSRM",
}

/**
 * Defines what this IP filter will be used for. This is to support IP filtering on proxies.
 */
union IpFilterTag {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  XffProxy: "XffProxy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServiceTag: "ServiceTag",
}

/**
 * Default action for main access restriction if no rules are matched.
 */
union DefaultAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deny: "Deny",
}

/**
 * MinTlsVersion: configures the minimum version of TLS required for SSL requests
 */
union SupportedTlsVersions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.0`: "1.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.1`: "1.1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.2`: "1.2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1.3`: "1.3",
}

/**
 * The minimum strength TLS cipher suite allowed for an application
 */
union TlsCipherSuites {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_AES_256_GCM_SHA384: "TLS_AES_256_GCM_SHA384",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_AES_128_GCM_SHA256: "TLS_AES_128_GCM_SHA256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384: "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256: "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256: "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384: "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256: "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384: "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256: "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA: "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA: "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_RSA_WITH_AES_256_GCM_SHA384: "TLS_RSA_WITH_AES_256_GCM_SHA384",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_RSA_WITH_AES_128_GCM_SHA256: "TLS_RSA_WITH_AES_128_GCM_SHA256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_RSA_WITH_AES_256_CBC_SHA256: "TLS_RSA_WITH_AES_256_CBC_SHA256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_RSA_WITH_AES_128_CBC_SHA256: "TLS_RSA_WITH_AES_128_CBC_SHA256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_RSA_WITH_AES_256_CBC_SHA: "TLS_RSA_WITH_AES_256_CBC_SHA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TLS_RSA_WITH_AES_128_CBC_SHA: "TLS_RSA_WITH_AES_128_CBC_SHA",
}

/**
 * State of FTP / FTPS service
 */
union FtpsState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllAllowed: "AllAllowed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FtpsOnly: "FtpsOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Mounting protocol to use for the storage account.
 */
union AzureStorageProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Smb: "Smb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Http: "Http",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Nfs: "Nfs",
}

/**
 * Property to select Azure Storage type. Available options: blobContainer.
 */
union FunctionsDeploymentStorageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blobContainer: "blobContainer",
}

/**
 * Property to select authentication type to access the selected storage account. Available options: SystemAssignedIdentity, UserAssignedIdentity, StorageAccountConnectionString.
 */
union AuthenticationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssignedIdentity: "SystemAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssignedIdentity: "UserAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StorageAccountConnectionString: "StorageAccountConnectionString",
}

/**
 * Function app runtime name. Available options: dotnet-isolated, node, java, powershell, python, custom
 */
union RuntimeName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `dotnet-isolated`: "dotnet-isolated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  node: "node",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  java: "java",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  powershell: "powershell",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  python: "python",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  custom: "custom",
}

/**
 * Function app site update strategy type. Available options: Recreate, RollingUpdate
 */
@added(Versions.v2025_05_01)
union SiteUpdateStrategyType {
  string,

  /**
   * If the app is under load and a deployment or site state update occurs, all pods will be removed
   * and will need to be Recreated all at once. This is the default behavior.
   */
  Recreate: "Recreate",

  /**
   * If the app is under load and a deployment or site state update occurs, pods will be drained in
   * batches and gradually replaced, thus minimizing impact to throughput.
   */
  RollingUpdate: "RollingUpdate",
}

/**
 * Sets the log level for the Dapr sidecar. Allowed values are debug, info, warn, error. Default is info.
 */
union DaprLogLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  info: "info",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  debug: "debug",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  warn: "warn",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  error: "error",
}

/**
 * The type of route this is:
 * DEFAULT - By default, every app has routes to the local address ranges specified by RFC1918
 * INHERITED - Routes inherited from the real Virtual Network routes
 * STATIC - Static route set on the app only
 *
 * These values will be used for syncing an app's routes with those from a Virtual Network.
 */
union RouteType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DEFAULT: "DEFAULT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  INHERITED: "INHERITED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  STATIC: "STATIC",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProviderOsTypeSelected {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Linux: "Linux",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WindowsFunctions: "WindowsFunctions",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LinuxFunctions: "LinuxFunctions",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  All: "All",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProviderStackOsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Linux: "Linux",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  All: "All",
}

/**
 * Name of a resource type this recommendation applies, e.g. Subscription, ServerFarm, Site.
 */
union ResourceScopeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServerFarm: "ServerFarm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Subscription: "Subscription",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WebSite: "WebSite",
}

/**
 * Resource type used for verification.
 */
union CheckNameResourceTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Site: "Site",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Slot: "Slot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HostingEnvironment: "HostingEnvironment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PublishingUser: "PublishingUser",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Microsoft.Web/sites`: "Microsoft.Web/sites",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Microsoft.Web/sites/slots`: "Microsoft.Web/sites/slots",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Microsoft.Web/hostingEnvironments`: "Microsoft.Web/hostingEnvironments",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Microsoft.Web/publishingUsers`: "Microsoft.Web/publishingUsers",
}

/**
 * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
 */
union InAvailabilityReasonType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlreadyExists: "AlreadyExists",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Free: "Free",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Shared: "Shared",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dynamic: "Dynamic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Isolated: "Isolated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsolatedV2: "IsolatedV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PremiumV2: "PremiumV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PremiumV3: "PremiumV3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PremiumContainer: "PremiumContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ElasticPremium: "ElasticPremium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ElasticIsolated: "ElasticIsolated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FlexConsumption: "FlexConsumption",
}

/**
 * Resource type used for verification.
 */
union ValidateResourceTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ServerFarm: "ServerFarm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Site: "Site",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `Microsoft.Web/hostingEnvironments`: "Microsoft.Web/hostingEnvironments",
}

/**
 * State indicating the status of the enterprise grade CDN serving traffic to the static web app.
 */
union EnterpriseGradeCdnStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabling: "Enabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabling: "Disabling",
}

/**
 * The status of the static site build.
 */
union BuildStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForDeployment: "WaitingForDeployment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uploading: "Uploading",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deploying: "Deploying",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Detached: "Detached",
}

/**
 * The trigger type of the function
 */
union TriggerTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HttpTrigger: "HttpTrigger",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union BasicAuthName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  default: "default",
}

/**
 * The status of the custom domain
 */
union CustomDomainStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RetrievingValidationToken: "RetrievingValidationToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Validating: "Validating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Adding: "Adding",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
}

/**
 * Database type (e.g. SqlAzure / MySql).
 */
union DatabaseType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SqlAzure: "SqlAzure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MySql: "MySql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocalMySql: "LocalMySql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostgreSql: "PostgreSql",
}

/**
 * Deployment build status.
 */
union DeploymentBuildStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TimedOut: "TimedOut",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RuntimeFailed: "RuntimeFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BuildAborted: "BuildAborted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BuildFailed: "BuildFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BuildRequestReceived: "BuildRequestReceived",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BuildPending: "BuildPending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BuildInProgress: "BuildInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BuildSuccessful: "BuildSuccessful",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostBuildRestartRequired: "PostBuildRestartRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StartPolling: "StartPolling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StartPollingWithRestart: "StartPollingWithRestart",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RuntimeStarting: "RuntimeStarting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RuntimeSuccessful: "RuntimeSuccessful",
}

/**
 * Name of the format. Valid values are:
 * FileZilla3
 * WebDeploy -- default
 * Ftp
 */
union PublishingProfileFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FileZilla3: "FileZilla3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WebDeploy: "WebDeploy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ftp: "Ftp",
}

/**
 * The workflow state.
 */
union WorkflowState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
}

/**
 * The key type.
 */
union KeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Secondary: "Secondary",
}

/**
 * The workflow status.
 */
union WorkflowStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Paused: "Paused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Waiting: "Waiting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Skipped: "Skipped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cancelled: "Cancelled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Faulted: "Faulted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TimedOut: "TimedOut",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Aborted: "Aborted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ignored: "Ignored",
}

/**
 * The parameter type.
 */
union ParameterType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  String: "String",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecureString: "SecureString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Int: "Int",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Float: "Float",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Bool: "Bool",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Array: "Array",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Object: "Object",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecureObject: "SecureObject",
}

/**
 * The workflow trigger provisioning state.
 */
union WorkflowTriggerProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Created: "Created",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registering: "Registering",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registered: "Registered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unregistering: "Unregistering",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unregistered: "Unregistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
}

/**
 * The recurrence frequency.
 */
union RecurrenceFrequency {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Second: "Second",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Minute: "Minute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hour: "Hour",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Day: "Day",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Week: "Week",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Month: "Month",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Year: "Year",
}

/**
 * The workflow provisioning state.
 */
union WorkflowProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Created: "Created",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registering: "Registering",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registered: "Registered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unregistering: "Unregistering",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unregistered: "Unregistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Renewing: "Renewing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Waiting: "Waiting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
}

/**
 * Open authentication policy provider type.
 */
union OpenAuthenticationProviderType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AAD: "AAD",
}

/**
 * The sku name.
 */
union WorkflowSkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Free: "Free",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Shared: "Shared",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
}

/**
 * The workflow kind.
 */
union Kind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stateful: "Stateful",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stateless: "Stateless",
}

/**
 * Provisioning state of the App Service Plan.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  InProgress,
  Deleting,
}

/**
 * Current status of the App Service Environment.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum HostingEnvironmentStatus {
  Preparing,
  Ready,
  Scaling,
  Deleting,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CustomDnsSuffixProvisioningState {
  Succeeded,
  Failed,
  Degraded,
  InProgress,
}

/**
 * Shared/dedicated workers.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ComputeModeOptions {
  Shared,
  Dedicated,
  Dynamic,
}

/**
 * Size of the machines.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum WorkerSizeOptions {
  Small,
  Medium,
  Large,
  D1,
  D2,
  D3,
  SmallV3,
  MediumV3,
  LargeV3,
  NestedSmall,
  NestedSmallLinux,
  Default,
}

/**
 * State indicating whether the app has exceeded its quota usage. Read-only.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum UsageState {
  Normal,
  Exceeded,
}

/**
 * Management information availability state for the app.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SiteAvailabilityState {
  Normal,
  Limited,
  DisasterRecoveryMode,
}

/**
 * SSL type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SslState {
  Disabled,
  SniEnabled,
  IpBasedEnabled,
}

/**
 * Indicates whether the hostname is a standard or repository hostname.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum HostType {
  Standard,
  Repository,
}

/**
 * Type of database.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ConnectionStringType {
  MySql,
  SQLServer,
  SQLAzure,
  Custom,
  NotificationHub,
  ServiceBus,
  EventHub,
  ApiHub,
  DocDb,
  RedisCache,
  PostgreSQL,
}

/**
 * Managed pipeline mode.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagedPipelineMode {
  Integrated,
  Classic,
}

/**
 * Site load balancing.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SiteLoadBalancing {
  WeightedRoundRobin,
  LeastRequests,
  LeastResponseTime,
  WeightedTotalTraffic,
  RequestHash,
  PerSiteRoundRobin,
  LeastRequestsWithTieBreaker,
}

/**
 * Predefined action to be taken.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutoHealActionType {
  Recycle,
  LogEvent,
  CustomAction,
}

/**
 * Type of storage.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AzureStorageType {
  AzureFiles,
  AzureBlob,
}

/**
 * State of the storage account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AzureStorageState {
  Ok,
  InvalidCredentials,
  InvalidShare,
  NotValidated,
}

/**
 * This composes with ClientCertEnabled setting.
 * - ClientCertEnabled: false means ClientCert is ignored.
 * - ClientCertEnabled: true and ClientCertMode: Required means ClientCert is required.
 * - ClientCertEnabled: true and ClientCertMode: Optional means ClientCert is optional or accepted.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ClientCertMode {
  Required,
  Optional,
  OptionalInteractiveUser,
}

/**
 * Specifies the IP mode of the app.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IPMode {
  IPv4,
  IPv6,
  IPv4AndIPv6,
}

/**
 * Site redundancy mode
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RedundancyMode {
  None,
  Manual,
  Failover,
  ActiveActive,
  GeoRedundant,
}

/**
 * Specifies the scope of uniqueness for the default hostname during resource creation
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutoGeneratedDomainNameLabelScope {
  TenantReuse,
  SubscriptionReuse,
  ResourceGroupReuse,
  NoReuse,
}

/**
 * Type of managed service identity.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The current status of the operation.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum OperationStatus {
  InProgress,
  Failed,
  Succeeded,
  TimedOut,
  Created,
}

/**
 * App Service plan status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum StatusOptions {
  Ready,
  Pending,
  Creating,
}

/**
 * Status of the Key Vault secret.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyVaultSecretStatus {
  Initialized,
  WaitingOnCertificateOrder,
  Succeeded,
  CertificateOrderFailed,
  OperationNotPermittedOnKeyVault,
  AzureServiceUnauthorizedToAccessKeyVault,
  KeyVaultDoesNotExist,
  KeyVaultSecretDoesNotExist,
  UnknownError,
  ExternalPrivateKey,
  Unknown,
}

/**
 * Whether this detector is an Analysis Detector or not.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DetectorType {
  Detector,
  Analysis,
  CategoryOverview,
}

/**
 * Rendering Type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RenderingType {
  NoGraph,
  Table,
  TimeSeries,
  TimeSeriesPerInstance,
  PieChart,
  DataSummary,
  Email,
  Insights,
  DynamicInsight,
  Markdown,
  Detector,
  DropDown,
  Card,
  Solution,
  Guage,
  Form,
  ChangeSets,
  ChangeAnalysisOnboarding,
  ChangesView,
  AppInsight,
  DependencyGraph,
  DownTime,
  SummaryCard,
  SearchComponent,
  AppInsightEnablement,
}

/**
 * Level of the most severe insight generated by the detector.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum InsightStatus {
  Critical,
  Warning,
  Info,
  Success,
  None,
}

/**
 * Represents the type of the Detector
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IssueType {
  ServiceIncident,
  AppDeployment,
  AppCrash,
  RuntimeIssueDetected,
  AseDeployment,
  UserIssue,
  PlatformIssue,
  Other,
}

/**
 * Type of Solution
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SolutionType {
  QuickSolution,
  DeepInvestigation,
  BestPractices,
}

/**
 * Provisioning state of the Kubernetes Environment.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KubeEnvironmentProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Waiting,
  InitializationInProgress,
  InfrastructureSetupInProgress,
  InfrastructureSetupComplete,
  ScheduledForDelete,
  UpgradeRequested,
  UpgradeFailed,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum StorageType {
  LocalNode,
  NetworkFileSystem,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FrontEndServiceType {
  NodePort,
  LoadBalancer,
}

/**
 * Function App stack preferred OS.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum StackPreferredOs {
  Windows,
  Linux,
}

/**
 * Level indicating how critical this recommendation can impact.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum NotificationLevel {
  Critical,
  Warning,
  Information,
  NonUrgentSuggestion,
}

/**
 * List of channels that this recommendation can apply.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum Channels {
  Notification,
  Api,
  Email,
  Webhook,
  All,
}

/**
 * App Service plans this offer is restricted to.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AppServicePlanRestrictions {
  None,
  Free,
  Shared,
  Basic,
  Standard,
  Premium,
}

/**
 * State indicating whether staging environments are allowed or not allowed for a static web app.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum StagingEnvironmentPolicy {
  Enabled,
  Disabled,
}

/**
 * DNS verification test result.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DnsVerificationTestResult {
  Passed,
  Failed,
  Skipped,
}

/**
 * The unit of time for how often the backup should be executed (e.g. for weekly backup, this should be set to Day and FrequencyInterval should be set to 7)
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FrequencyUnit {
  Day,
  Hour,
}

/**
 * Backup status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum BackupItemStatus {
  InProgress,
  Failed,
  Succeeded,
  TimedOut,
  Created,
  Skipped,
  PartiallySucceeded,
  DeleteInProgress,
  DeleteFailed,
  Deleted,
}

/**
 * Operation type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum BackupRestoreOperationType {
  Default,
  Clone,
  Relocation,
  Snapshot,
  CloudFS,
}

/**
 * The action to take when an unauthenticated client attempts to access the app.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum UnauthenticatedClientAction {
  RedirectToLoginPage,
  AllowAnonymous,
}

/**
 * The default authentication provider to use when multiple providers are configured.
 * This setting is only needed if multiple providers are configured and the unauthenticated client
 * action is set to "RedirectToLoginPage".
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum BuiltInAuthenticationProvider {
  AzureActiveDirectory,
  Facebook,
  Google,
  MicrosoftAccount,
  Twitter,
  Github,
}

/**
 * The action to take when an unauthenticated client attempts to access the app.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum UnauthenticatedClientActionV2 {
  RedirectToLoginPage,
  AllowAnonymous,
  Return401,
  Return403,
}

/**
 * The convention used when determining the session cookie's expiration.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CookieExpirationConvention {
  FixedTime,
  IdentityProviderDerived,
}

/**
 * The convention used to determine the url of the request made.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ForwardProxyConvention {
  NoProxy,
  Standard,
  Custom,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResolveStatus {
  Initialized,
  Resolved,
  InvalidSyntax,
  MSINotEnabled,
  VaultNotFound,
  SecretNotFound,
  SecretVersionNotFound,
  AccessToKeyVaultDenied,
  OtherReasons,
  FetchTimedOut,
  UnauthorizedClient,
}

/**
 * Log level.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum LogLevel {
  Off,
  Verbose,
  Information,
  Warning,
  Error,
}

/**
 * Job status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ContinuousWebJobStatus {
  Initializing,
  Starting,
  Running,
  PendingRestart,
  Stopped,
}

/**
 * Job type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum WebJobType {
  Continuous,
  Triggered,
}

/**
 * Provisioning state
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum MSDeployProvisioningState {
  accepted,
  running,
  succeeded,
  failed,
  canceled,
}

/**
 * Log entry type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum MSDeployLogEntryType {
  Message,
  Warning,
  Error,
}

/**
 * Azure resource type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AzureResourceType {
  Website,
  TrafficManager,
}

/**
 * Custom DNS record type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CustomHostNameDnsRecordType {
  CName,
  A,
}

/**
 * Hostname type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum HostNameType {
  Verified,
  Managed,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SiteRuntimeState {
  READY,
  STOPPED,
  UNKNOWN,
}

/**
 * Name of app.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CloneAbilityResult {
  Cloneable,
  PartiallyCloneable,
  NotCloneable,
}

/**
 * The type of migration operation to be done
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum MySqlMigrationType {
  LocalToRemote,
  RemoteToLocal,
}

/**
 * Public Certificate Location
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PublicCertificateLocation {
  CurrentUserMy,
  LocalMachineMy,
  Unknown,
}

/**
 * Auth Type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AuthType {
  Anonymous,
  UserCredentials,
  SystemIdentity,
  UserAssigned,
}

/**
 * Site extension type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SiteExtensionType {
  Gallery,
  WebRoot,
}

/**
 * Job status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum TriggeredWebJobStatus {
  Success,
  Failed,
  Error,
}

/**
 * Gets or sets the workflow health state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum WorkflowHealthState {
  NotSpecified,
  Healthy,
  Unhealthy,
  Unknown,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DaysOfWeek {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

/**
 * The day of the week.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DayOfWeek {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

/**
 * Collection of App Service Environments.
 */
model AppServiceEnvironmentCollection
  is Azure.Core.Page<AppServiceEnvironmentResource>;

/**
 * Description of an App Service Environment.
 */
model AppServiceEnvironment {
  /**
   * Provisioning state of the App Service Environment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Current status of the App Service Environment.
   */
  @visibility(Lifecycle.Read)
  status?: HostingEnvironmentStatus;

  /**
   * Description of the Virtual Network.
   */
  virtualNetwork: VirtualNetworkProfile;

  /**
   * Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment.
   */
  internalLoadBalancingMode?: LoadBalancingMode;

  /**
   * Front-end VM size, e.g. "Medium", "Large".
   */
  multiSize?: string;

  /**
   * Number of front-end instances.
   */
  @visibility(Lifecycle.Read)
  multiRoleCount?: int32;

  /**
   * Number of IP SSL addresses reserved for the App Service Environment.
   */
  ipsslAddressCount?: int32;

  /**
   * DNS suffix of the App Service Environment.
   */
  dnsSuffix?: string;

  /**
   * Maximum number of VMs in the App Service Environment.
   */
  @visibility(Lifecycle.Read)
  maximumNumberOfMachines?: int32;

  /**
   * Scale factor for front-ends.
   */
  frontEndScaleFactor?: int32;

  /**
   * <code>true</code> if the App Service Environment is suspended; otherwise, <code>false</code>. The environment can be suspended, e.g. when the management endpoint is no longer available
   *  (most likely because NSG blocked the incoming traffic).
   */
  @visibility(Lifecycle.Read)
  suspended?: boolean;

  /**
   * Custom settings for changing the behavior of the App Service Environment.
   */
  @identifiers(#["name"])
  clusterSettings?: NameValuePair[];

  /**
   * User added ip ranges to whitelist on ASE db
   */
  userWhitelistedIpRanges?: string[];

  /**
   * Flag that displays whether an ASE has linux workers or not
   */
  @visibility(Lifecycle.Read)
  hasLinuxWorkers?: boolean;

  /**
   * Upgrade Preference
   */
  upgradePreference?: UpgradePreference = UpgradePreference.None;

  /**
   * Dedicated Host Count
   */
  dedicatedHostCount?: int32;

  /**
   * Whether or not this App Service Environment is zone-redundant.
   */
  zoneRedundant?: boolean;

  /**
   * Full view of the custom domain suffix configuration for ASEv3.
   */
  customDnsSuffixConfiguration?: CustomDnsSuffixConfiguration;

  /**
   * Full view of networking configuration for an ASE.
   */
  networkingConfiguration?: AseV3NetworkingConfiguration;

  /**
   * Whether an upgrade is available for this App Service Environment.
   */
  @visibility(Lifecycle.Read)
  upgradeAvailability?: UpgradeAvailability;
}

/**
 * Specification for using a Virtual Network.
 */
model VirtualNetworkProfile {
  /**
   * Resource id of the Virtual Network.
   */
  id: string;

  /**
   * Name of the Virtual Network (read-only).
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type of the Virtual Network (read-only).
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Subnet within the Virtual Network.
   */
  subnet?: string;
}

/**
 * Name value pair.
 */
model NameValuePair {
  /**
   * Pair name.
   */
  name?: string;

  /**
   * Pair value.
   */
  value?: string;
}

/**
 * CustomDnsSuffixConfiguration resource specific properties
 */
model CustomDnsSuffixConfigurationProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: CustomDnsSuffixProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningDetails?: string;

  /**
   * The default custom domain suffix to use for all sites deployed on the ASE.
   */
  dnsSuffix?: string;

  /**
   * The URL referencing the Azure Key Vault certificate secret that should be used as the default SSL/TLS certificate for sites with the custom domain suffix.
   */
  certificateUrl?: string;

  /**
   * The user-assigned identity to use for resolving the key vault certificate reference. If not specified, the system-assigned ASE identity will be used if available.
   */
  keyVaultReferenceIdentity?: string;
}

/**
 * Azure proxy only resource. This resource is not tracked by Azure Resource Manager.
 */
model ProxyOnlyResource {
  /**
   * Resource Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource Name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Kind of resource.
   */
  kind?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * AseV3NetworkingConfiguration resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AseV3NetworkingConfigurationProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  windowsOutboundIpAddresses?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  linuxOutboundIpAddresses?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  externalInboundIpAddresses?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  internalInboundIpAddresses?: string[];

  /**
   * Property to enable and disable new private endpoint connection creation on ASE
   */
  allowNewPrivateEndpointConnections?: boolean;

  /**
   * Property to enable and disable FTP on ASEV3
   */
  ftpEnabled?: boolean;

  /**
   * Property to enable and disable Remote Debug on ASEV3
   */
  remoteDebugEnabled?: boolean;

  /**
   * Customer provided Inbound IP Address. Only able to be set on Ase create.
   */
  inboundIpAddressOverride?: string;
}

/**
 * App Service error response.
 */
@error
model DefaultErrorResponse {
  /**
   * Error model.
   */
  @visibility(Lifecycle.Read)
  error?: DefaultErrorResponseError;
}

/**
 * Error model.
 */
@error
model DefaultErrorResponseError {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  details?: DefaultErrorResponseErrorDetailsItem[];

  /**
   * More information to debug error.
   */
  @visibility(Lifecycle.Read)
  innererror?: string;
}

/**
 * Detailed errors.
 */
model DefaultErrorResponseErrorDetailsItem {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  target?: string;
}

/**
 * ARM resource for a app service environment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AppServiceEnvironmentPatchResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AppServiceEnvironment;
}

/**
 * Collection of stamp capacities.
 */
@@Azure.ResourceManager.identifiers(StampCapacityCollection.value, #["name"]);
model StampCapacityCollection is Azure.Core.Page<StampCapacity>;

/**
 * Stamp capacity information.
 */
model StampCapacity {
  /**
   * Name of the stamp.
   */
  name?: string;

  /**
   * Available capacity (# of machines, bytes of storage etc...).
   */
  availableCapacity?: int64;

  /**
   * Total capacity (# of machines, bytes of storage etc...).
   */
  totalCapacity?: int64;

  /**
   * Name of the unit.
   */
  unit?: string;

  /**
   * Shared/dedicated workers.
   */
  computeMode?: ComputeModeOptions;

  /**
   * Size of the machines.
   */
  workerSize?: WorkerSizeOptions;

  /**
   * Size ID of machines:
   * 0 - Small
   * 1 - Medium
   * 2 - Large
   */
  workerSizeId?: int32;

  /**
   * If <code>true</code>, it includes basic apps.
   * Basic apps are not used for capacity allocation.
   */
  excludeFromCapacityAllocation?: boolean;

  /**
   * <code>true</code> if capacity is applicable for all apps; otherwise, <code>false</code>.
   */
  isApplicableForAllComputeModes?: boolean;

  /**
   * Shared or Dedicated.
   */
  siteMode?: string;

  /**
   * Is this a linux stamp capacity
   */
  isLinux?: boolean;
}

/**
 * AddressResponse resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AddressResponseProperties {
  /**
   * Main public virtual IP.
   */
  serviceIpAddress?: string;

  /**
   * Virtual Network internal IP address of the App Service Environment if it is in internal load-balancing mode.
   */
  internalIpAddress?: string;

  /**
   * IP addresses appearing on outbound connections.
   */
  outboundIpAddresses?: string[];

  /**
   * Additional virtual IPs.
   */
  @identifiers(#["virtualIP"])
  vipMappings?: VirtualIPMapping[];
}

/**
 * Virtual IP mapping.
 */
model VirtualIPMapping {
  /**
   * Virtual IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualIP?: string;

  /**
   * Internal HTTP port.
   */
  internalHttpPort?: int32;

  /**
   * Internal HTTPS port.
   */
  internalHttpsPort?: int32;

  /**
   * Is virtual IP mapping in use.
   */
  inUse?: boolean;

  /**
   * name of the service that virtual IP is assigned to
   */
  serviceName?: string;
}

/**
 * Collection of App Service apps.
 */
model WebAppCollection is Azure.Core.Page<Site>;

/**
 * Site resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteProperties {
  /**
   * Current state of the app.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * Hostnames associated with the app.
   */
  @visibility(Lifecycle.Read)
  hostNames?: string[];

  /**
   * Name of the repository site.
   */
  @visibility(Lifecycle.Read)
  repositorySiteName?: string;

  /**
   * State indicating whether the app has exceeded its quota usage. Read-only.
   */
  @visibility(Lifecycle.Read)
  usageState?: UsageState;

  /**
   * <code>true</code> if the app is enabled; otherwise, <code>false</code>. Setting this value to false disables the app (takes the app offline).
   */
  enabled?: boolean;

  /**
   * Enabled hostnames for the app.Hostnames need to be assigned (see HostNames) AND enabled. Otherwise,
   * the app is not served on those hostnames.
   */
  @visibility(Lifecycle.Read)
  enabledHostNames?: string[];

  /**
   * Management information availability state for the app.
   */
  @visibility(Lifecycle.Read)
  availabilityState?: SiteAvailabilityState;

  /**
   * Hostname SSL states are used to manage the SSL bindings for app's hostnames.
   */
  @identifiers(#["name"])
  hostNameSslStates?: HostNameSslState[];

  /**
   * Resource ID of the associated App Service plan, formatted as: "/subscriptions/{subscriptionID}/resourceGroups/{groupName}/providers/Microsoft.Web/serverfarms/{appServicePlanName}".
   */
  serverFarmId?: string;

  /**
   * <code>true</code> if reserved; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  reserved?: boolean = false;

  /**
   * Obsolete: Hyper-V sandbox.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isXenon?: boolean = false;

  /**
   * Hyper-V sandbox.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hyperV?: boolean = false;

  /**
   * Last time the app was modified, in UTC. Read-only.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  /**
   * Property to configure various DNS related settings for a site.
   */
  dnsConfiguration?: SiteDnsConfig;

  /**
   * Property to configure various outbound traffic routing options over virtual network for a site
   */
  outboundVnetRouting?: OutboundVnetRouting;

  /**
   * Configuration of an App Service app. This property is not returned in response to normal create and read requests since it may contain sensitive information.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  siteConfig?: SiteConfig;

  /**
   * Configuration specific of the Azure Function app.
   */
  functionAppConfig?: FunctionAppConfig;

  /**
   * Dapr configuration of the app.
   */
  daprConfig?: DaprConfig;

  /**
   * Workload profile name for function app to execute on.
   */
  workloadProfileName?: string;

  /**
   * Function app resource requirements.
   */
  resourceConfig?: ResourceConfig;

  /**
   * Azure Traffic Manager hostnames associated with the app. Read-only.
   */
  @visibility(Lifecycle.Read)
  trafficManagerHostNames?: string[];

  /**
   * <code>true</code> to stop SCM (KUDU) site when the app is stopped; otherwise, <code>false</code>. The default is <code>false</code>.
   */
  scmSiteAlsoStopped?: boolean = false;

  /**
   * Specifies which deployment slot this app will swap into. Read-only.
   */
  @visibility(Lifecycle.Read)
  targetSwapSlot?: string;

  /**
   * App Service Environment to use for the app.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * <code>true</code> to enable client affinity; <code>false</code> to stop sending session affinity cookies, which route client requests in the same session to the same instance. Default is <code>true</code>.
   */
  clientAffinityEnabled?: boolean = false;

  /**
   * <code>true</code> to enable client affinity partitioning using CHIPS cookies, this will add the <code>partitioned</code> property to the affinity cookies; <code>false</code> to stop sending partitioned affinity cookies. Default is <code>false</code>.
   */
  clientAffinityPartitioningEnabled?: boolean;

  /**
   * <code>true</code> to override client affinity cookie domain with X-Forwarded-Host request header. <code>false</code> to use default domain. Default is <code>false</code>.
   */
  clientAffinityProxyEnabled?: boolean;

  /**
   * <code>true</code> to enable client certificate authentication (TLS mutual authentication); otherwise, <code>false</code>. Default is <code>false</code>.
   */
  clientCertEnabled?: boolean;

  /**
   * This composes with ClientCertEnabled setting.
   * - ClientCertEnabled: false means ClientCert is ignored.
   * - ClientCertEnabled: true and ClientCertMode: Required means ClientCert is required.
   * - ClientCertEnabled: true and ClientCertMode: Optional means ClientCert is optional or accepted.
   */
  clientCertMode?: ClientCertMode;

  /**
   * client certificate authentication comma-separated exclusion paths
   */
  clientCertExclusionPaths?: string;

  /**
   * Specifies the IP mode of the app.
   */
  ipMode?: IPMode;

  /**
   * Whether to use end to end encryption between the FrontEnd and the Worker
   */
  endToEndEncryptionEnabled?: boolean;

  /**
   * Whether to enable ssh access.
   */
  sshEnabled?: boolean;

  /**
   * <code>true</code> to disable the public hostnames of the app; otherwise, <code>false</code>.
   *  If <code>true</code>, the app is only accessible via API management process.
   */
  hostNamesDisabled?: boolean;

  /**
   * Unique identifier that verifies the custom domains assigned to the app. Customer will add this id to a txt record for verification.
   */
  customDomainVerificationId?: string;

  /**
   * List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from tenants that site can be hosted with current settings. Read-only.
   */
  @visibility(Lifecycle.Read)
  outboundIpAddresses?: string;

  /**
   * List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from all tenants except dataComponent. Read-only.
   */
  @visibility(Lifecycle.Read)
  possibleOutboundIpAddresses?: string;

  /**
   * Size of the function container.
   */
  containerSize?: int32;

  /**
   * Maximum allowed daily memory-time quota (applicable on dynamic apps only).
   */
  dailyMemoryTimeQuota?: int32;

  /**
   * App suspended till in case memory-time quota is exceeded.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspendedTill?: utcDateTime;

  /**
   * Maximum number of workers.
   * This only applies to Functions container.
   */
  @visibility(Lifecycle.Read)
  maxNumberOfWorkers?: int32;

  /**
   * If specified during app creation, the app is cloned from a source app.
   */
  @visibility(Lifecycle.Create)
  cloningInfo?: CloningInfo;

  /**
   * Name of the resource group the app belongs to. Read-only.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * <code>true</code> if the app is a default container; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isDefaultContainer?: boolean;

  /**
   * Default hostname of the app. Read-only.
   */
  @visibility(Lifecycle.Read)
  defaultHostName?: string;

  /**
   * Status of the last deployment slot swap operation.
   */
  @visibility(Lifecycle.Read)
  slotSwapStatus?: SlotSwapStatus;

  /**
   * HttpsOnly: configures a web site to accept only https requests. Issues redirect for
   * http requests
   */
  httpsOnly?: boolean;

  /**
   * Site redundancy mode
   */
  redundancyMode?: RedundancyMode;

  /**
   * Specifies an operation id if this site has a pending operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  inProgressOperationId?: string;

  /**
   * Property to allow or block all public traffic. Allowed Values: 'Enabled', 'Disabled' or an empty string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicNetworkAccess?: string;

  /**
   * Checks if Customer provided storage account is required
   */
  storageAccountRequired?: boolean;

  /**
   * Identity to use for Key Vault Reference authentication.
   */
  keyVaultReferenceIdentity?: string;

  /**
   * Specifies the scope of uniqueness for the default hostname during resource creation
   */
  autoGeneratedDomainNameLabelScope?: AutoGeneratedDomainNameLabelScope;

  /**
   * Azure Resource Manager ID of the Virtual network and subnet to be joined by Regional VNET Integration.
   * This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}
   */
  virtualNetworkSubnetId?: string;

  /**
   * Azure Resource Manager ID of the customer's selected Managed Environment on which to host this app. This must be of the form /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.App/managedEnvironments/{managedEnvironmentName}
   */
  managedEnvironmentId?: string;

  /**
   * Current SKU of application based on associated App Service Plan. Some valid SKU values are Free, Shared, Basic, Dynamic, FlexConsumption, Standard, Premium, PremiumV2, PremiumV3, Isolated, IsolatedV2
   */
  @visibility(Lifecycle.Read)
  sku?: string;
}

/**
 * SSL-enabled hostname.
 */
model HostNameSslState {
  /**
   * Hostname.
   */
  name?: string;

  /**
   * SSL type.
   */
  sslState?: SslState;

  /**
   * Virtual IP address assigned to the hostname if IP based SSL is enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualIP?: string;

  /**
   * SSL certificate thumbprint.
   */
  thumbprint?: string;

  /**
   * Set to <code>true</code> to update existing hostname.
   */
  toUpdate?: boolean;

  /**
   * Indicates whether the hostname is a standard or repository hostname.
   */
  hostType?: HostType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteDnsConfig {
  /**
   * List of custom DNS servers to be used by an app for lookups. Maximum 5 dns servers can be set.
   */
  dnsServers?: string[];

  /**
   * Alternate DNS server to be used by apps. This property replicates the WEBSITE_DNS_ALT_SERVER app setting.
   */
  dnsAltServer?: string;

  /**
   * Timeout for a single dns lookup in seconds. Allowed range: 1-30. Default is 3.
   */
  dnsRetryAttemptTimeout?: int32;

  /**
   * Total number of retries for dns lookup. Allowed range: 1-5. Default is 3.
   */
  dnsRetryAttemptCount?: int32;

  /**
   * Custom time for DNS to be cached in seconds. Allowed range: 0-60. Default is 30 seconds. 0 means caching disabled.
   */
  dnsMaxCacheTimeout?: int32;

  /**
   * Indicates that sites using Virtual network custom DNS servers are still sorting the list of DNS servers. Read-Only.
   */
  @visibility(Lifecycle.Read)
  dnsLegacySortOrder?: boolean;
}

/**
 * Outbound traffic options over virtual network.
 */
model OutboundVnetRouting {
  /**
   * Enables all other routing options defined in OutboundVnetRouting if this setting is set to true.
   */
  allTraffic?: boolean;

  /**
   * This causes all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied. Previously called VnetRouteAllEnabled.
   */
  applicationTraffic?: boolean;

  /**
   * Enables accessing content over virtual network. Previously called VnetContentShareEnabled
   */
  contentShareTraffic?: boolean;

  /**
   * Enables pulling image over Virtual Network. Previously called VnetImagePullEnabled.
   */
  imagePullTraffic?: boolean;

  /**
   * Enables Backup and Restore operations over virtual network. Previously called VnetBackupRestoreEnabled
   */
  backupRestoreTraffic?: boolean;
}

/**
 * Configuration of an App Service app.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteConfig {
  /**
   * Number of workers.
   */
  numberOfWorkers?: int32;

  /**
   * Default documents.
   */
  defaultDocuments?: string[];

  /**
   * .NET Framework version.
   */
  netFrameworkVersion?: string = "v4.6";

  /**
   * Version of PHP.
   */
  phpVersion?: string;

  /**
   * Version of Python.
   */
  pythonVersion?: string;

  /**
   * Version of Node.js.
   */
  nodeVersion?: string;

  /**
   * Version of PowerShell.
   */
  powerShellVersion?: string;

  /**
   * Linux App Framework and version
   */
  linuxFxVersion?: string;

  /**
   * Xenon App Framework and version
   */
  windowsFxVersion?: string;

  /**
   * <code>true</code> if request tracing is enabled; otherwise, <code>false</code>.
   */
  requestTracingEnabled?: boolean;

  /**
   * Request tracing expiration time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestTracingExpirationTime?: utcDateTime;

  /**
   * <code>true</code> if remote debugging is enabled; otherwise, <code>false</code>.
   */
  remoteDebuggingEnabled?: boolean;

  /**
   * Remote debugging version.
   */
  remoteDebuggingVersion?: string;

  /**
   * <code>true</code> if HTTP logging is enabled; otherwise, <code>false</code>.
   */
  httpLoggingEnabled?: boolean;

  /**
   * Flag to use Managed Identity Creds for ACR pull
   */
  acrUseManagedIdentityCreds?: boolean;

  /**
   * If using user managed identity, the user managed identity ClientId
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  acrUserManagedIdentityID?: string;

  /**
   * HTTP logs directory size limit.
   */
  logsDirectorySizeLimit?: int32;

  /**
   * <code>true</code> if detailed error logging is enabled; otherwise, <code>false</code>.
   */
  detailedErrorLoggingEnabled?: boolean;

  /**
   * Publishing user name.
   */
  publishingUsername?: string;

  /**
   * Application settings. This property is not returned in response to normal create and read requests since it may contain sensitive information.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @identifiers(#["name"])
  appSettings?: NameValuePair[];

  /**
   * Application metadata. This property cannot be retrieved, since it may contain secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @identifiers(#["name"])
  metadata?: NameValuePair[];

  /**
   * Connection strings. This property is not returned in response to normal create and read requests since it may contain sensitive information.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @identifiers(#["name"])
  connectionStrings?: ConnStringInfo[];

  /**
   * Site MachineKey.
   */
  @visibility(Lifecycle.Read)
  machineKey?: SiteMachineKey;

  /**
   * Handler mappings.
   */
  @identifiers(#["extension"])
  handlerMappings?: HandlerMapping[];

  /**
   * Document root.
   */
  documentRoot?: string;

  /**
   * SCM type.
   */
  scmType?: ScmType;

  /**
   * <code>true</code> to use 32-bit worker process; otherwise, <code>false</code>.
   */
  use32BitWorkerProcess?: boolean;

  /**
   * <code>true</code> if WebSocket is enabled; otherwise, <code>false</code>.
   */
  webSocketsEnabled?: boolean;

  /**
   * <code>true</code> if Always On is enabled; otherwise, <code>false</code>.
   */
  alwaysOn?: boolean;

  /**
   * Java version.
   */
  javaVersion?: string;

  /**
   * Java container.
   */
  javaContainer?: string;

  /**
   * Java container version.
   */
  javaContainerVersion?: string;

  /**
   * App command line to launch.
   */
  appCommandLine?: string;

  /**
   * Managed pipeline mode.
   */
  managedPipelineMode?: ManagedPipelineMode;

  /**
   * Virtual applications.
   */
  @identifiers(#["virtualPath"])
  virtualApplications?: VirtualApplication[];

  /**
   * Site load balancing.
   */
  loadBalancing?: SiteLoadBalancing;

  /**
   * This is work around for polymorphic types.
   */
  experiments?: Experiments;

  /**
   * Site limits.
   */
  limits?: SiteLimits;

  /**
   * <code>true</code> if Auto Heal is enabled; otherwise, <code>false</code>.
   */
  autoHealEnabled?: boolean;

  /**
   * Auto Heal rules.
   */
  autoHealRules?: AutoHealRules;

  /**
   * Tracing options.
   */
  tracingOptions?: string;

  /**
   * Virtual Network name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vnetName?: string;

  /**
   * Virtual Network Route All enabled. This causes all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied.
   */
  vnetRouteAllEnabled?: boolean;

  /**
   * The number of private ports assigned to this app. These will be assigned dynamically on runtime.
   */
  vnetPrivatePortsCount?: int32;

  /**
   * Cross-Origin Resource Sharing (CORS) settings.
   */
  cors?: CorsSettings;

  /**
   * Push endpoint settings.
   */
  push?: PushSettings;

  /**
   * Information about the formal API definition for the app.
   */
  apiDefinition?: ApiDefinitionInfo;

  /**
   * Azure API management settings linked to the app.
   */
  apiManagementConfig?: ApiManagementConfig;

  /**
   * Auto-swap slot name.
   */
  autoSwapSlotName?: string;

  /**
   * <code>true</code> to enable local MySQL; otherwise, <code>false</code>.
   */
  localMySqlEnabled?: boolean = false;

  /**
   * Managed Service Identity Id
   */
  managedServiceIdentityId?: int32;

  /**
   * Explicit Managed Service Identity Id
   */
  xManagedServiceIdentityId?: int32;

  /**
   * Identity to use for Key Vault Reference authentication.
   */
  keyVaultReferenceIdentity?: string;

  /**
   * IP security restrictions for main.
   */
  @identifiers(#["name"])
  ipSecurityRestrictions?: IpSecurityRestriction[];

  /**
   * Default action for main access restriction if no rules are matched.
   */
  ipSecurityRestrictionsDefaultAction?: DefaultAction;

  /**
   * IP security restrictions for scm.
   */
  @identifiers(#["name"])
  scmIpSecurityRestrictions?: IpSecurityRestriction[];

  /**
   * Default action for scm access restriction if no rules are matched.
   */
  scmIpSecurityRestrictionsDefaultAction?: DefaultAction;

  /**
   * IP security restrictions for scm to use main.
   */
  scmIpSecurityRestrictionsUseMain?: boolean;

  /**
   * Http20Enabled: configures a web site to allow clients to connect over http2.0
   */
  http20Enabled?: boolean = true;

  /**
   * Http20ProxyFlag: Configures a website to allow http2.0 to pass be proxied all the way to the app. 0 = disabled, 1 = pass through all http2 traffic, 2 = pass through gRPC only.
   */
  http20ProxyFlag?: int32 = 0;

  /**
   * MinTlsVersion: configures the minimum version of TLS required for SSL requests
   */
  minTlsVersion?: SupportedTlsVersions;

  /**
   * The minimum strength TLS cipher suite allowed for an application
   */
  minTlsCipherSuite?: TlsCipherSuites;

  /**
   * ScmMinTlsVersion: configures the minimum version of TLS required for SSL requests for SCM site
   */
  scmMinTlsVersion?: SupportedTlsVersions;

  /**
   * State of FTP / FTPS service
   */
  ftpsState?: FtpsState;

  /**
   * Number of preWarmed instances.
   * This setting only applies to the Consumption and Elastic Plans
   */
  @maxValue(10)
  @minValue(0)
  preWarmedInstanceCount?: int32;

  /**
   * Maximum number of workers that a site can scale out to.
   * This setting only applies to the Consumption and Elastic Premium Plans
   */
  @minValue(0)
  functionAppScaleLimit?: int32;

  /**
   * Maximum number of workers that a site can scale out to.
   * This setting only applies to apps in plans where ElasticScaleEnabled is <code>true</code>
   */
  @minValue(0)
  elasticWebAppScaleLimit?: int32;

  /**
   * Health check path
   */
  healthCheckPath?: string;

  /**
   * Gets or sets a value indicating whether functions runtime scale monitoring is enabled. When enabled,
   * the ScaleController will not monitor event sources directly, but will instead call to the
   * runtime to get scale status.
   */
  functionsRuntimeScaleMonitoringEnabled?: boolean;

  /**
   * Sets the time zone a site uses for generating timestamps. Compatible with Linux and Windows App Service. Setting the WEBSITE_TIME_ZONE app setting takes precedence over this config. For Linux, expects tz database values https://www.iana.org/time-zones (for a quick reference see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). For Windows, expects one of the time zones listed under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones
   */
  websiteTimeZone?: string;

  /**
   * Number of minimum instance count for a site
   * This setting only applies to the Elastic Plans
   */
  @maxValue(20)
  @minValue(0)
  minimumElasticInstanceCount?: int32;

  /**
   * List of Azure Storage Accounts.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureStorageAccounts?: Record<AzureStorageInfoValue>;

  /**
   * Property to allow or block all public traffic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicNetworkAccess?: string;
}

/**
 * Database connection string information.
 */
model ConnStringInfo {
  /**
   * Name of connection string.
   */
  name?: string;

  /**
   * Connection string value.
   */
  connectionString?: string;

  /**
   * Type of database.
   */
  type?: ConnectionStringType;
}

/**
 * MachineKey of an app.
 */
model SiteMachineKey {
  /**
   * MachineKey validation.
   */
  validation?: string;

  /**
   * Validation key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationKey?: string;

  /**
   * Algorithm used for decryption.
   */
  decryption?: string;

  /**
   * Decryption key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  decryptionKey?: string;
}

/**
 * The IIS handler mappings used to define which handler processes HTTP requests with certain extension.
 * For example, it is used to configure php-cgi.exe process to handle all HTTP requests with *.php extension.
 */
model HandlerMapping {
  /**
   * Requests with this extension will be handled using the specified FastCGI application.
   */
  extension?: string;

  /**
   * The absolute path to the FastCGI application.
   */
  scriptProcessor?: string;

  /**
   * Command-line arguments to be passed to the script processor.
   */
  arguments?: string;
}

/**
 * Virtual application in an app.
 */
model VirtualApplication {
  /**
   * Virtual path.
   */
  virtualPath?: string;

  /**
   * Physical path.
   */
  physicalPath?: string;

  /**
   * <code>true</code> if preloading is enabled; otherwise, <code>false</code>.
   */
  preloadEnabled?: boolean;

  /**
   * Virtual directories for virtual application.
   */
  @identifiers(#["virtualPath"])
  virtualDirectories?: VirtualDirectory[];
}

/**
 * Directory for virtual application.
 */
model VirtualDirectory {
  /**
   * Path to virtual application.
   */
  virtualPath?: string;

  /**
   * Physical path.
   */
  physicalPath?: string;
}

/**
 * Routing rules in production experiments.
 */
model Experiments {
  /**
   * List of ramp-up rules.
   */
  @identifiers(#["name"])
  rampUpRules?: RampUpRule[];
}

/**
 * Routing rules for ramp up testing. This rule allows to redirect static traffic % to a slot or to gradually change routing % based on performance.
 */
model RampUpRule {
  /**
   * Hostname of a slot to which the traffic will be redirected if decided to. E.g. myapp-stage.azurewebsites.net.
   */
  actionHostName?: string;

  /**
   * Percentage of the traffic which will be redirected to <code>ActionHostName</code>.
   */
  reroutePercentage?: float64;

  /**
   * In auto ramp up scenario this is the step to add/remove from <code>ReroutePercentage</code> until it reaches \n<code>MinReroutePercentage</code> or
   * <code>MaxReroutePercentage</code>. Site metrics are checked every N minutes specified in <code>ChangeIntervalInMinutes</code>.\nCustom decision algorithm
   * can be provided in TiPCallback site extension which URL can be specified in <code>ChangeDecisionCallbackUrl</code>.
   */
  changeStep?: float64;

  /**
   * Specifies interval in minutes to reevaluate ReroutePercentage.
   */
  changeIntervalInMinutes?: int32;

  /**
   * Specifies lower boundary above which ReroutePercentage will stay.
   */
  minReroutePercentage?: float64;

  /**
   * Specifies upper boundary below which ReroutePercentage will stay.
   */
  maxReroutePercentage?: float64;

  /**
   * Custom decision algorithm can be provided in TiPCallback site extension which URL can be specified.
   */
  changeDecisionCallbackUrl?: string;

  /**
   * Name of the routing rule. The recommended name would be to point to the slot which will receive the traffic in the experiment.
   */
  name?: string;
}

/**
 * Metric limits set on an app.
 */
model SiteLimits {
  /**
   * Maximum allowed CPU usage percentage.
   */
  maxPercentageCpu?: float64;

  /**
   * Maximum allowed memory usage in MB.
   */
  maxMemoryInMb?: int64;

  /**
   * Maximum allowed disk size usage in MB.
   */
  maxDiskSizeInMb?: int64;
}

/**
 * Rules that can be defined for auto-heal.
 */
model AutoHealRules {
  /**
   * Conditions that describe when to execute the auto-heal actions.
   */
  triggers?: AutoHealTriggers;

  /**
   * Actions to be executed when a rule is triggered.
   */
  actions?: AutoHealActions;
}

/**
 * Triggers for auto-heal.
 */
model AutoHealTriggers {
  /**
   * A rule based on total requests.
   */
  requests?: RequestsBasedTrigger;

  /**
   * A rule based on private bytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateBytesInKB?: int32;

  /**
   * A rule based on status codes.
   */
  @identifiers(#["path"])
  statusCodes?: StatusCodesBasedTrigger[];

  /**
   * A rule based on request execution time.
   */
  slowRequests?: SlowRequestsBasedTrigger;

  /**
   * A rule based on multiple Slow Requests Rule with path
   */
  @identifiers(#["path"])
  slowRequestsWithPath?: SlowRequestsBasedTrigger[];

  /**
   * A rule based on status codes ranges.
   */
  @identifiers(#["path"])
  statusCodesRange?: StatusCodesRangeBasedTrigger[];
}

/**
 * Trigger based on total requests.
 */
model RequestsBasedTrigger {
  /**
   * Request Count.
   */
  count?: int32;

  /**
   * Time interval.
   */
  timeInterval?: string;
}

/**
 * Trigger based on status code.
 */
model StatusCodesBasedTrigger {
  /**
   * HTTP status code.
   */
  status?: int32;

  /**
   * Request Sub Status.
   */
  subStatus?: int32;

  /**
   * Win32 error code.
   */
  win32Status?: int32;

  /**
   * Request Count.
   */
  count?: int32;

  /**
   * Time interval.
   */
  timeInterval?: string;

  /**
   * Request Path
   */
  path?: string;
}

/**
 * Trigger based on request execution time.
 */
model SlowRequestsBasedTrigger {
  /**
   * Time taken.
   */
  timeTaken?: string;

  /**
   * Request Path.
   */
  path?: string;

  /**
   * Request Count.
   */
  count?: int32;

  /**
   * Time interval.
   */
  timeInterval?: string;
}

/**
 * Trigger based on range of status codes.
 */
model StatusCodesRangeBasedTrigger {
  /**
   * HTTP status code.
   */
  statusCodes?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: string;

  /**
   * Request Count.
   */
  count?: int32;

  /**
   * Time interval.
   */
  timeInterval?: string;
}

/**
 * Actions which to take by the auto-heal module when a rule is triggered.
 */
model AutoHealActions {
  /**
   * Predefined action to be taken.
   */
  actionType?: AutoHealActionType;

  /**
   * Custom action to be taken.
   */
  customAction?: AutoHealCustomAction;

  /**
   * Minimum time the process must execute
   * before taking the action
   */
  minProcessExecutionTime?: string;
}

/**
 * Custom action to be executed
 * when an auto heal rule is triggered.
 */
model AutoHealCustomAction {
  /**
   * Executable to be run.
   */
  exe?: string;

  /**
   * Parameters for the executable.
   */
  parameters?: string;
}

/**
 * Cross-Origin Resource Sharing (CORS) settings for the app.
 */
model CorsSettings {
  /**
   * Gets or sets the list of origins that should be allowed to make cross-origin
   * calls (for example: http://example.com:12345). Use "*" to allow all.
   */
  allowedOrigins?: string[];

  /**
   * Gets or sets whether CORS requests with credentials are allowed. See
   * https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS#Requests_with_credentials
   * for more details.
   */
  supportCredentials?: boolean;
}

/**
 * Push settings for the App.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PushSettings extends ProxyOnlyResource {
  /**
   * PushSettings resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: PushSettingsProperties;
}

/**
 * PushSettings resource specific properties
 */
model PushSettingsProperties {
  /**
   * Gets or sets a flag indicating whether the Push endpoint is enabled.
   */
  isPushEnabled: boolean;

  /**
   * Gets or sets a JSON string containing a list of tags that are whitelisted for use by the push registration endpoint.
   */
  tagWhitelistJson?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("""
    Gets or sets a JSON string containing a list of tags that require user authentication to be used in the push registration endpoint.
    Tags can consist of alphanumeric characters and the following:
    '_', '@', '#', '.', ':', '-'. 
    Validation should be performed at the PushRequestHandler.
    """)
  tagsRequiringAuth?: string;

  /**
   * Gets or sets a JSON string containing a list of dynamic tags that will be evaluated from user claims in the push registration endpoint.
   */
  dynamicTagsJson?: string;
}

/**
 * Information about the formal API definition for the app.
 */
model ApiDefinitionInfo {
  /**
   * The URL of the API definition.
   */
  url?: string;
}

/**
 * Azure API management (APIM) configuration linked to the app.
 */
model ApiManagementConfig {
  /**
   * APIM-Api Identifier.
   */
  id?: string;
}

/**
 * IP security restriction on an app.
 */
model IpSecurityRestriction {
  /**
   * IP address the security restriction is valid for.
   * It can be in form of pure ipv4 address (required SubnetMask property) or
   * CIDR notation such as ipv4/mask (leading bit match). For CIDR,
   * SubnetMask property must not be specified.
   */
  ipAddress?: string;

  /**
   * Subnet mask for the range of IP addresses the restriction is valid for.
   */
  subnetMask?: string;

  /**
   * Virtual network resource id
   */
  vnetSubnetResourceId?: string;

  /**
   * (internal) Vnet traffic tag
   */
  vnetTrafficTag?: int32;

  /**
   * (internal) Subnet traffic tag
   */
  subnetTrafficTag?: int32;

  /**
   * Allow or Deny access for this IP range.
   */
  action?: string;

  /**
   * Defines what this IP filter will be used for. This is to support IP filtering on proxies.
   */
  tag?: IpFilterTag;

  /**
   * Priority of IP restriction rule.
   */
  priority?: int32;

  /**
   * IP restriction rule name.
   */
  name?: string;

  /**
   * IP restriction rule description.
   */
  description?: string;

  /**
   * IP restriction rule headers.
   * X-Forwarded-Host (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-Host#Examples).
   * The matching logic is ..
   * - If the property is null or empty (default), all hosts(or lack of) are allowed.
   * - A value is compared using ordinal-ignore-case (excluding port number).
   * - Subdomain wildcards are permitted but don't match the root domain. For example, *.contoso.com matches the subdomain foo.contoso.com
   *  but not the root domain contoso.com or multi-level foo.bar.contoso.com
   * - Unicode host names are allowed but are converted to Punycode for matching.
   *
   * X-Forwarded-For (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For#Examples).
   * The matching logic is ..
   * - If the property is null or empty (default), any forwarded-for chains (or lack of) are allowed.
   * - If any address (excluding port number) in the chain (comma separated) matches the CIDR defined by the property.
   *
   * X-Azure-FDID and X-FD-HealthProbe.
   * The matching logic is exact match.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<string[]>;
}

/**
 * Azure Files or Blob Storage access information value for dictionary storage.
 */
model AzureStorageInfoValue {
  /**
   * Type of storage.
   */
  type?: AzureStorageType;

  /**
   * Name of the storage account.
   */
  accountName?: string;

  /**
   * Name of the file share (container name, for Blob storage).
   */
  shareName?: string;

  /**
   * Access key for the storage account.
   */
  @secret
  accessKey?: string;

  /**
   * Path to mount the storage within the site's runtime environment.
   */
  mountPath?: string;

  /**
   * State of the storage account.
   */
  @visibility(Lifecycle.Read)
  state?: AzureStorageState;

  /**
   * Mounting protocol to use for the storage account.
   */
  protocol?: AzureStorageProtocol;
}

/**
 * Function app configuration.
 */
model FunctionAppConfig {
  /**
   * Function app deployment configuration.
   */
  deployment?: FunctionsDeployment;

  /**
   * Function app runtime settings.
   */
  runtime?: FunctionsRuntime;

  /**
   * Function app scale and concurrency settings.
   */
  scaleAndConcurrency?: FunctionsScaleAndConcurrency;

  /**
   * Function app site update strategy configuration.
   */
  @added(Versions.v2025_05_01)
  siteUpdateStrategy?: FunctionsSiteUpdateStrategy;
}

/**
 * Configuration section for the function app deployment.
 */
model FunctionsDeployment {
  /**
   * Storage for deployed package used by the function app.
   */
  storage?: FunctionsDeploymentStorage;
}

/**
 * Storage for deployed package used by the function app.
 */
model FunctionsDeploymentStorage {
  /**
   * Property to select Azure Storage type. Available options: blobContainer.
   */
  type?: FunctionsDeploymentStorageType;

  /**
   * Property to set the URL for the selected Azure Storage type. Example: For blobContainer, the value could be https://<storageAccountName>.blob.core.windows.net/<containerName>.
   */
  value?: url;

  /**
   * Authentication method to access the storage account for deployment.
   */
  authentication?: FunctionsDeploymentStorageAuthentication;
}

/**
 * Authentication method to access the storage account for deployment.
 */
model FunctionsDeploymentStorageAuthentication {
  /**
   * Property to select authentication type to access the selected storage account. Available options: SystemAssignedIdentity, UserAssignedIdentity, StorageAccountConnectionString.
   */
  type?: AuthenticationType;

  /**
   * Use this property for UserAssignedIdentity. Set the resource ID of the identity. Do not set a value for this property when using other authentication type.
   */
  userAssignedIdentityResourceId?: string;

  /**
   * Use this property for StorageAccountConnectionString. Set the name of the app setting that has the storage account connection string. Do not set a value for this property when using other authentication type.
   */
  storageAccountConnectionStringName?: string;
}

/**
 * Function app runtime name and version.
 */
model FunctionsRuntime {
  /**
   * Function app runtime name. Available options: dotnet-isolated, node, java, powershell, python, custom
   */
  name?: RuntimeName;

  /**
   * Function app runtime version. Example: 8 (for dotnet-isolated)
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: string | null;
}

/**
 * Scale and concurrency settings for the function app.
 */
model FunctionsScaleAndConcurrency {
  /**
   * 'Always Ready' configuration for the function app.
   */
  alwaysReady?: FunctionsAlwaysReadyConfig[];

  /**
   * The maximum number of instances for the function app.
   */
  maximumInstanceCount?: int32;

  /**
   * Set the amount of memory allocated to each instance of the function app in MB. CPU and network bandwidth are allocated proportionally.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceMemoryMB?: int32;

  /**
   * Scale and concurrency settings for the function app triggers.
   */
  triggers?: FunctionsScaleAndConcurrencyTriggers;
}

/**
 * Function app site update strategy configuration for deployments and site config updates.
 */
@added(Versions.v2025_05_01)
model FunctionsSiteUpdateStrategy {
  /**
   * Function app site update strategy type. Available options: Recreate, RollingUpdate
   */
  type?: SiteUpdateStrategyType;
}

/**
 * Sets the number of 'Always Ready' instances for a function group or a specific function.
 */
model FunctionsAlwaysReadyConfig {
  /**
   * Either a function group or a function name is required. For additional information see https://aka.ms/flexconsumption/alwaysready.
   */
  name?: string;

  /**
   * Sets the number of 'Always Ready' instances for a given function group or a specific function. For additional information see https://aka.ms/flexconsumption/alwaysready.
   */
  instanceCount?: int32;
}

/**
 * Scale and concurrency settings for the function app triggers.
 */
model FunctionsScaleAndConcurrencyTriggers {
  /**
   * Scale and concurrency settings for the HTTP trigger.
   */
  http?: FunctionsScaleAndConcurrencyTriggersHttp;
}

/**
 * Scale and concurrency settings for the HTTP trigger.
 */
model FunctionsScaleAndConcurrencyTriggersHttp {
  /**
   * The maximum number of concurrent HTTP trigger invocations per instance.
   */
  perInstanceConcurrency?: int32;
}

/**
 * App Dapr configuration.
 */
model DaprConfig {
  /**
   * Boolean indicating if the Dapr side car is enabled
   */
  enabled?: boolean = false;

  /**
   * Dapr application identifier
   */
  appId?: string;

  /**
   * Tells Dapr which port your application is listening on
   */
  appPort?: int32;

  /**
   * Dapr max size of http header read buffer in KB to handle when sending multi-KB headers. Default is 65KB.
   */
  httpReadBufferSize?: int32;

  /**
   * Increasing max size of request body http servers parameter in MB to handle uploading of big files. Default is 4 MB.
   */
  httpMaxRequestSize?: int32;

  /**
   * Sets the log level for the Dapr sidecar. Allowed values are debug, info, warn, error. Default is info.
   */
  logLevel?: DaprLogLevel;

  /**
   * Enables API logging for the Dapr sidecar
   */
  enableApiLogging?: boolean;
}

/**
 * Function app resource requirements.
 */
model ResourceConfig {
  /**
   * Required CPU in cores, e.g. 0.5
   */
  cpu?: float64;

  /**
   * Required memory, e.g. "1Gi"
   */
  memory?: string;
}

/**
 * Specification for an App Service Environment to use for this resource.
 */
model HostingEnvironmentProfile {
  /**
   * Resource ID of the App Service Environment.
   */
  id?: string;

  /**
   * Name of the App Service Environment.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type of the App Service Environment.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Information needed for cloning operation.
 */
model CloningInfo {
  /**
   * Correlation ID of cloning operation. This ID ties multiple cloning operations
   * together to use the same snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  correlationId?: string;

  /**
   * <code>true</code> to overwrite destination app; otherwise, <code>false</code>.
   */
  overwrite?: boolean;

  /**
   * <code>true</code> to clone custom hostnames from source app; otherwise, <code>false</code>.
   */
  cloneCustomHostNames?: boolean;

  /**
   * <code>true</code> to clone source control from source app; otherwise, <code>false</code>.
   */
  cloneSourceControl?: boolean;

  /**
   * ARM resource ID of the source app. App resource ID is of the form
   * /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName} for production slots and
   * /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slotName} for other slots.
   */
  sourceWebAppId: string;

  /**
   * Location of source app ex: West US or North Europe
   */
  sourceWebAppLocation?: string;

  /**
   * App Service Environment.
   */
  hostingEnvironment?: string;

  /**
   * Application setting overrides for cloned app. If specified, these settings override the settings cloned
   * from source app. Otherwise, application settings from source app are retained.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  appSettingsOverrides?: Record<string>;

  /**
   * <code>true</code> to configure load balancing for source and destination app.
   */
  configureLoadBalancing?: boolean;

  /**
   * ARM resource ID of the Traffic Manager profile to use, if it exists. Traffic Manager resource ID is of the form
   * /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficManagerProfiles/{profileName}.
   */
  trafficManagerProfileId?: string;

  /**
   * Name of Traffic Manager profile to create. This is only needed if Traffic Manager profile does not already exist.
   */
  trafficManagerProfileName?: string;
}

/**
 * The status of the last successful slot swap operation.
 */
model SlotSwapStatus {
  /**
   * The time the last successful slot swap completed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestampUtc?: utcDateTime;

  /**
   * The source slot of the last swap operation.
   */
  @visibility(Lifecycle.Read)
  sourceSlotName?: string;

  /**
   * The destination slot of the last swap operation.
   */
  @visibility(Lifecycle.Read)
  destinationSlotName?: string;
}

/**
 * Managed service identity.
 */
model ManagedServiceIdentity {
  /**
   * Type of managed service identity.
   */
  type?: ManagedServiceIdentityType;

  /**
   * Tenant of managed service identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Principal Id of managed service identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The list of user assigned identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * User Assigned identity.
 */
model UserAssignedIdentity {
  /**
   * Principal Id of user assigned identity
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Client Id of user assigned identity
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Extended Location.
 */
model ExtendedLocation {
  /**
   * Name of extended location.
   */
  name?: string;

  /**
   * Type of extended location.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Diagnostics for an App Service Environment.
 */
model HostingEnvironmentDiagnostics {
  /**
   * Name/identifier of the diagnostics.
   */
  name?: string;

  /**
   * Diagnostics output.
   */
  diagnosticsOutput?: string;
}

/**
 * Collection of Inbound Environment Endpoints
 */
model InboundEnvironmentEndpointCollection
  is Azure.Core.Page<InboundEnvironmentEndpoint>;

/**
 * The IP Addresses and Ports that require inbound network access to and within the subnet of the App Service Environment.
 */
model InboundEnvironmentEndpoint {
  /**
   * Short text describing the purpose of the network traffic.
   */
  description?: string;

  /**
   * The IP addresses that network traffic will originate from in cidr notation.
   */
  endpoints?: string[];

  /**
   * The ports that network traffic will arrive to the App Service Environment at.
   */
  ports?: string[];
}

/**
 * Collection of worker pools.
 */
model WorkerPoolCollection is Azure.Core.Page<WorkerPoolResource>;

/**
 * Worker pool of an App Service Environment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkerPool {
  /**
   * Worker size ID for referencing this worker pool.
   */
  workerSizeId?: int32;

  /**
   * Shared or dedicated app hosting.
   */
  computeMode?: ComputeModeOptions;

  /**
   * VM size of the worker pool instances.
   */
  workerSize?: string;

  /**
   * Number of instances in the worker pool.
   */
  workerCount?: int32;

  /**
   * Names of all instances in the worker pool (read only).
   */
  @visibility(Lifecycle.Read)
  instanceNames?: string[];
}

/**
 * Description of a SKU for a scalable resource.
 */
model SkuDescription {
  /**
   * Name of the resource SKU.
   */
  name?: string;

  /**
   * Service tier of the resource SKU.
   */
  tier?: string;

  /**
   * Size specifier of the resource SKU.
   */
  size?: string;

  /**
   * Family code of the resource SKU.
   */
  family?: string;

  /**
   * Current number of instances assigned to the resource.
   */
  capacity?: int32;

  /**
   * Min, max, and default scale values of the SKU.
   */
  skuCapacity?: SkuCapacity;

  /**
   * Locations of the SKU.
   */
  locations?: string[];

  /**
   * Capabilities of the SKU, e.g., is traffic manager enabled?
   */
  @identifiers(#["name"])
  capabilities?: Capability[];
}

/**
 * Description of the App Service plan scale options.
 */
model SkuCapacity {
  /**
   * Minimum number of workers for this App Service plan SKU.
   */
  minimum?: int32;

  /**
   * Maximum number of workers for this App Service plan SKU.
   */
  maximum?: int32;

  /**
   * Maximum number of Elastic workers for this App Service plan SKU.
   */
  elasticMaximum?: int32;

  /**
   * Default number of workers for this App Service plan SKU.
   */
  default?: int32;

  /**
   * Available scale configurations for an App Service plan.
   */
  scaleType?: string;
}

/**
 * Describes the capabilities/features allowed for a specific SKU.
 */
model Capability {
  /**
   * Name of the SKU capability.
   */
  name?: string;

  /**
   * Value of the SKU capability.
   */
  value?: string;

  /**
   * Reason of the SKU capability.
   */
  reason?: string;
}

/**
 * Collection of metric definitions.
 */
model ResourceMetricDefinitionCollection
  is Azure.Core.Page<ResourceMetricDefinition>;

/**
 * Metadata for the metrics.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceMetricDefinition extends ProxyOnlyResource {
  /**
   * ResourceMetricDefinition resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ResourceMetricDefinitionProperties;
}

/**
 * ResourceMetricDefinition resource specific properties
 */
model ResourceMetricDefinitionProperties {
  /**
   * Unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Primary aggregation type.
   */
  @visibility(Lifecycle.Read)
  primaryAggregationType?: string;

  /**
   * List of time grains supported for the metric together with retention period.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  metricAvailabilities?: ResourceMetricAvailability[];

  /**
   * Resource URI.
   */
  @visibility(Lifecycle.Read)
  resourceUri?: string;

  /**
   * Resource metric definition properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  properties?: Record<string>;
}

/**
 * Metrics availability and retention.
 */
model ResourceMetricAvailability {
  /**
   * Time grain .
   */
  @visibility(Lifecycle.Read)
  timeGrain?: string;

  /**
   * Retention period for the current time grain.
   */
  @visibility(Lifecycle.Read)
  retention?: string;
}

/**
 * Collection of SKU information.
 */
@@Azure.ResourceManager.identifiers(SkuInfoCollection.value,
  #["/sku/name", "resourceType"]
);
model SkuInfoCollection is Azure.Core.Page<SkuInfo>;

/**
 * SKU discovery information.
 */
model SkuInfo {
  /**
   * Resource type that this SKU applies to.
   */
  resourceType?: string;

  /**
   * Name and tier of the SKU.
   */
  sku?: SkuDescription;

  /**
   * Min, max, and default scale values of the SKU.
   */
  capacity?: SkuCapacity;
}

/**
 * Collection of usages.
 */
model UsageCollection is Azure.Core.Page<Usage>;

/**
 * Usage of the quota resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Usage extends ProxyOnlyResource {
  /**
   * Usage resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: UsageProperties;
}

/**
 * Usage resource specific properties
 */
model UsageProperties {
  /**
   * Friendly name shown in the UI.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Name of the quota resource.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * Units of measurement for the quota resource.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * The current value of the resource counter.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int64;

  /**
   * The resource limit.
   */
  @visibility(Lifecycle.Read)
  limit?: int64;

  /**
   * Next reset time for the resource counter.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  /**
   * Compute mode used for this usage.
   */
  @visibility(Lifecycle.Read)
  computeMode?: ComputeModeOptions;

  /**
   * Site mode used for this usage.
   */
  @visibility(Lifecycle.Read)
  siteMode?: string;
}

/**
 * An operation on a resource.
 */
model Operation {
  /**
   * Operation ID.
   */
  id?: string;

  /**
   * Operation name.
   */
  name?: string;

  /**
   * The current status of the operation.
   */
  status?: OperationStatus;

  /**
   * Any errors associate with the operation.
   */
  @identifiers(#[])
  errors?: ErrorEntity[];

  /**
   * Time when operation has started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Time when operation has been updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedTime?: utcDateTime;

  /**
   * Time when operation will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Applicable only for stamp operation ids.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  geoMasterOperationId?: string;
}

/**
 * Body of the error response returned from the API.
 */
model ErrorEntity {
  /**
   * Type of error.
   */
  extendedCode?: string;

  /**
   * Message template.
   */
  messageTemplate?: string;

  /**
   * Parameters for the template.
   */
  parameters?: string[];

  /**
   * Inner errors.
   */
  @identifiers(#[])
  innerErrors?: ErrorEntity[];

  /**
   * Error Details.
   */
  @identifiers(#[])
  details?: ErrorEntity[];

  /**
   * The error target.
   */
  target?: string;

  /**
   * Basic error code.
   */
  code?: string;

  /**
   * Any details of the error.
   */
  message?: string;
}

/**
 * Collection of Outbound Environment Endpoints
 */
@@Azure.ResourceManager.identifiers(OutboundEnvironmentEndpointCollection.value,
  #["category"]
);
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

/**
 * Endpoints accessed for a common purpose that the App Service Environment requires outbound network access to.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The type of service accessed by the App Service Environment, e.g., Azure Storage, Azure SQL Database, and Azure Active Directory.
   */
  category?: string;

  /**
   * The endpoints that the App Service Environment reaches the service at.
   */
  @identifiers(#["domainName"])
  endpoints?: EndpointDependency[];
}

/**
 * A domain name that a service is reached at, including details of the current connection status.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency.
   */
  domainName?: string;

  /**
   * The IP Addresses and Ports used when connecting to DomainName.
   */
  @identifiers(#["ipAddress", "port"])
  endpointDetails?: EndpointDetail[];
}

/**
 * Current TCP connectivity information from the App Service Environment to a single endpoint.
 */
model EndpointDetail {
  /**
   * An IP Address that Domain Name currently resolves to.
   */
  ipAddress?: string;

  /**
   * The port an endpoint is connected to.
   */
  port?: int32;

  /**
   * The time in milliseconds it takes for a TCP connection to be created from the App Service Environment to this IpAddress at this Port.
   */
  latency?: float64;

  /**
   * Whether it is possible to create a TCP connection from the App Service Environment to this IpAddress at this Port.
   */
  isAccessible?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateEndpointConnectionCollection
  is Azure.Core.Page<RemotePrivateEndpointConnectionARMResource>;

/**
 * RemotePrivateEndpointConnectionARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemotePrivateEndpointConnectionARMResourceProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * PrivateEndpoint of a remote private endpoint connection
   */
  privateEndpoint?: ArmIdWrapper;

  /**
   * The state of a private link connection
   */
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;

  /**
   * Private IPAddresses mapped to the remote private endpoint
   */
  ipAddresses?: string[];
}

/**
 * A wrapper for an ARM resource id
 */
model ArmIdWrapper {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * The state of a private link connection
 */
model PrivateLinkConnectionState {
  /**
   * Status of a private link connection
   */
  status?: string;

  /**
   * Description of a private link connection
   */
  description?: string;

  /**
   * ActionsRequired for a private link connection
   */
  actionsRequired?: string;
}

/**
 * Wrapper for a collection of private link resources
 */
model PrivateLinkResourcesWrapper {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id: string;

  /**
   * Name of a private link resource
   */
  name: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Properties of a private link resource
   */
  properties: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource
 */
model PrivateLinkResourceProperties {
  /**
   * GroupId of a private link resource
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * RequiredMembers of a private link resource
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * RequiredZoneNames of a private link resource
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * Collection of App Service plans.
 */
model AppServicePlanCollection is Azure.Core.Page<AppServicePlan>;

/**
 * AppServicePlan resource specific properties
 */
model AppServicePlanProperties {
  /**
   * Target worker tier assigned to the App Service plan.
   */
  workerTierName?: string;

  /**
   * App Service plan status.
   */
  @visibility(Lifecycle.Read)
  status?: StatusOptions;

  /**
   * App Service plan subscription.
   */
  @visibility(Lifecycle.Read)
  subscription?: string;

  /**
   * Specification for the App Service Environment to use for the App Service plan.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * Maximum number of instances that can be assigned to this App Service plan.
   */
  @visibility(Lifecycle.Read)
  maximumNumberOfWorkers?: int32;

  /**
   * The number of instances that are assigned to this App Service plan.
   */
  @visibility(Lifecycle.Read)
  numberOfWorkers?: int32;

  /**
   * Geographical location for the App Service plan.
   */
  @visibility(Lifecycle.Read)
  geoRegion?: string;

  /**
   * If <code>true</code>, apps assigned to this App Service plan can be scaled independently.
   * If <code>false</code>, apps assigned to this App Service plan will scale to all instances of the plan.
   */
  perSiteScaling?: boolean;

  /**
   * ServerFarm supports ElasticScale. Apps in this plan will scale as if the ServerFarm was ElasticPremium sku
   */
  elasticScaleEnabled?: boolean;

  /**
   * Maximum number of total workers allowed for this ElasticScaleEnabled App Service Plan
   */
  maximumElasticWorkerCount?: int32;

  /**
   * Number of apps assigned to this App Service plan.
   */
  @visibility(Lifecycle.Read)
  numberOfSites?: int32;

  /**
   * If <code>true</code>, this App Service Plan owns spot instances.
   */
  isSpot?: boolean;

  /**
   * The time when the server farm expires. Valid only if it is a spot server farm.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  spotExpirationTime?: utcDateTime;

  /**
   * The time when the server farm free offer expires.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  freeOfferExpirationTime?: utcDateTime;

  /**
   * Resource group of the App Service plan.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * If Linux app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  reserved?: boolean;

  /**
   * Obsolete: If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isXenon?: boolean;

  /**
   * If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hyperV?: boolean;

  /**
   * Scaling worker count.
   */
  targetWorkerCount?: int32;

  /**
   * Scaling worker size ID.
   */
  targetWorkerSizeId?: int32;

  /**
   * Provisioning state of the App Service Plan.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Specification for the Kubernetes Environment to use for the App Service plan.
   */
  kubeEnvironmentProfile?: KubeEnvironmentProfile;

  /**
   * If <code>true</code>, this App Service Plan will perform availability zone balancing.
   * If <code>false</code>, this App Service Plan will not perform availability zone balancing.
   */
  zoneRedundant?: boolean;

  /**
   * If <code>true</code>, this App Service Plan will attempt to scale asynchronously if there are insufficient workers to scale synchronously.
   * If <code>false</code>, this App Service Plan will only attempt sync scaling.
   */
  asyncScalingEnabled?: boolean;

  /**
   * Identity to use by platform for various features and integrations using managed identity.
   */
  planDefaultIdentity?: DefaultIdentity;

  /**
   * Whether this server farm is in custom mode.
   */
  isCustomMode?: boolean;

  /**
   * Registry adapters associated with this App Service plan.
   */
  @identifiers(#[])
  registryAdapters?: RegistryAdapter[];

  /**
   * Install scripts associated with this App Service plan.
   */
  installScripts?: InstallScript[];

  /**
   * All network settings for the server farm.
   */
  network?: ServerFarmNetworkSettings;

  /**
   * Storage mounts associated with this App Service plan.
   */
  storageMounts?: StorageMount[];

  /**
   * If <code>true</code>, RDP access is enabled for this App Service plan. Only applicable for IsCustomMode ASPs.
   * If <code>false</code>, RDP access is disabled.
   */
  rdpEnabled?: boolean;
}

/**
 * Specification for a Kubernetes Environment to use for this resource.
 */
model KubeEnvironmentProfile {
  /**
   * Resource ID of the Kubernetes Environment.
   */
  id?: string;

  /**
   * Name of the Kubernetes Environment.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type of the Kubernetes Environment.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Collection of CSM usage quotas.
 */
@@Azure.ResourceManager.identifiers(CsmUsageQuotaCollection.value, #["name"]);
model CsmUsageQuotaCollection is Azure.Core.Page<CsmUsageQuota>;

/**
 * Usage of the quota resource.
 */
model CsmUsageQuota {
  /**
   * Units of measurement for the quota resource.
   */
  unit?: string;

  /**
   * Next reset time for the resource counter.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  /**
   * The current value of the resource counter.
   */
  currentValue?: int64;

  /**
   * The resource limit.
   */
  limit?: int64;

  /**
   * Quota name.
   */
  name?: LocalizableString;
}

/**
 * Localizable string object containing the name and a localized value.
 */
model LocalizableString {
  /**
   * Non-localized name.
   */
  value?: string;

  /**
   * Localized name.
   */
  localizedValue?: string;
}

/**
 * ARM resource for a app service plan.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AppServicePlanPatchResource extends ProxyOnlyResource {
  /**
   * AppServicePlanPatchResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AppServicePlanPatchResourceProperties;

  /**
   * Managed service identity.
   */
  identity?: ManagedServiceIdentity;
}

/**
 * AppServicePlanPatchResource resource specific properties
 */
model AppServicePlanPatchResourceProperties {
  /**
   * Target worker tier assigned to the App Service plan.
   */
  workerTierName?: string;

  /**
   * App Service plan status.
   */
  @visibility(Lifecycle.Read)
  status?: StatusOptions;

  /**
   * App Service plan subscription.
   */
  @visibility(Lifecycle.Read)
  subscription?: string;

  /**
   * Specification for the App Service Environment to use for the App Service plan.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * Maximum number of instances that can be assigned to this App Service plan.
   */
  @visibility(Lifecycle.Read)
  maximumNumberOfWorkers?: int32;

  /**
   * The number of instances that are assigned to this App Service plan.
   */
  @visibility(Lifecycle.Read)
  numberOfWorkers?: int32;

  /**
   * Geographical location for the App Service plan.
   */
  @visibility(Lifecycle.Read)
  geoRegion?: string;

  /**
   * If <code>true</code>, apps assigned to this App Service plan can be scaled independently.
   * If <code>false</code>, apps assigned to this App Service plan will scale to all instances of the plan.
   */
  perSiteScaling?: boolean = false;

  /**
   * ServerFarm supports ElasticScale. Apps in this plan will scale as if the ServerFarm was ElasticPremium sku
   */
  elasticScaleEnabled?: boolean;

  /**
   * Maximum number of total workers allowed for this ElasticScaleEnabled App Service Plan
   */
  maximumElasticWorkerCount?: int32;

  /**
   * Number of apps assigned to this App Service plan.
   */
  @visibility(Lifecycle.Read)
  numberOfSites?: int32;

  /**
   * If <code>true</code>, this App Service Plan owns spot instances.
   */
  isSpot?: boolean;

  /**
   * The time when the server farm expires. Valid only if it is a spot server farm.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  spotExpirationTime?: utcDateTime;

  /**
   * The time when the server farm free offer expires.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  freeOfferExpirationTime?: utcDateTime;

  /**
   * Resource group of the App Service plan.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * If Linux app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  reserved?: boolean = false;

  /**
   * Obsolete: If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isXenon?: boolean = false;

  /**
   * If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hyperV?: boolean = false;

  /**
   * Scaling worker count.
   */
  targetWorkerCount?: int32;

  /**
   * Scaling worker size ID.
   */
  targetWorkerSizeId?: int32;

  /**
   * Provisioning state of the App Service Plan.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Specification for the Kubernetes Environment to use for the App Service plan.
   */
  kubeEnvironmentProfile?: KubeEnvironmentProfile;

  /**
   * If <code>true</code>, this App Service Plan will perform availability zone balancing.
   * If <code>false</code>, this App Service Plan will not perform availability zone balancing.
   */
  zoneRedundant?: boolean = false;
}

/**
 * HybridConnection resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HybridConnectionProperties {
  /**
   * The name of the Service Bus namespace.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceBusNamespace?: string;

  /**
   * The name of the Service Bus relay.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  relayName?: string;

  /**
   * The ARM URI to the Service Bus relay.
   */
  relayArmUri?: string;

  /**
   * The hostname of the endpoint.
   */
  hostname?: string;

  /**
   * The port of the endpoint.
   */
  port?: int32;

  /**
   * The name of the Service Bus key which has Send permissions. This is used to authenticate to Service Bus.
   */
  sendKeyName?: string;

  /**
   * The value of the Service Bus key. This is used to authenticate to Service Bus. In ARM this key will not be returned
   * normally, use the POST /listKeys API instead.
   */
  sendKeyValue?: string;

  /**
   * The suffix for the service bus endpoint. By default this is .servicebus.windows.net
   */
  serviceBusSuffix?: string;
}

/**
 * Hybrid Connection key contract. This has the send key name and value for a Hybrid Connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HybridConnectionKey extends ProxyOnlyResource {
  /**
   * HybridConnectionKey resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: HybridConnectionKeyProperties;
}

/**
 * HybridConnectionKey resource specific properties
 */
model HybridConnectionKeyProperties {
  /**
   * The name of the send key.
   */
  @visibility(Lifecycle.Read)
  sendKeyName?: string;

  /**
   * The value of the send key.
   */
  @visibility(Lifecycle.Read)
  sendKeyValue?: string;
}

/**
 * Collection of resources.
 */
model ResourceCollection {
  /** Collection of resources. */
  @TypeSpec.pageItems
  value: string[];

  /** Link to next page of resources. */
  @TypeSpec.nextLink
  nextLink?: string;
}

/**
 * HybridConnectionLimits resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HybridConnectionLimitsProperties {
  /**
   * The current number of Hybrid Connections.
   */
  @visibility(Lifecycle.Read)
  current?: int32;

  /**
   * The maximum number of Hybrid Connections allowed.
   */
  @visibility(Lifecycle.Read)
  maximum?: int32;
}

/**
 * Collection of hostname bindings.
 */
model HybridConnectionCollection is Azure.Core.Page<HybridConnection>;

/**
 * Virtual Network information contract.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VnetInfo {
  /**
   * The Virtual Network's resource ID.
   */
  vnetResourceId?: string;

  /**
   * The client certificate thumbprint.
   */
  @visibility(Lifecycle.Read)
  certThumbprint?: string;

  /**
   * A certificate file (.cer) blob containing the public key of the private key used to authenticate a \nPoint-To-Site VPN connection.
   */
  certBlob?: string;

  /**
   * The routes that this Virtual Network connection uses.
   */
  @visibility(Lifecycle.Read)
  routes?: VnetRoute[];

  /**
   * <code>true</code> if a resync is required; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  resyncRequired?: boolean;

  /**
   * DNS servers to be used by this Virtual Network. This should be a comma-separated list of IP addresses.
   */
  dnsServers?: string;

  /**
   * Flag that is used to denote if this is VNET injection
   */
  isSwift?: boolean;
}

/**
 * VnetRoute resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VnetRouteProperties {
  /**
   * The starting address for this route. This may also include a CIDR notation, in which case the end address must not be specified.
   */
  startAddress?: string;

  /**
   * The ending address for this route. If the start address is specified in CIDR notation, this must be omitted.
   */
  endAddress?: string;

  /**
   * The type of route this is:
   * DEFAULT - By default, every app has routes to the local address ranges specified by RFC1918
   * INHERITED - Routes inherited from the real Virtual Network routes
   * STATIC - Static route set on the app only
   *
   * These values will be used for syncing an app's routes with those from a Virtual Network.
   */
  routeType?: RouteType;
}

/**
 * VnetGateway resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VnetGatewayProperties {
  /**
   * The Virtual Network name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vnetName?: string;

  /**
   * The URI where the VPN package can be downloaded.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  vpnPackageUri: string;
}

/**
 * Collection of certificates.
 */
model CertificateCollection is Azure.Core.Page<Certificate>;

/**
 * Certificate resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CertificateProperties {
  /**
   * Certificate password.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password?: string;

  /**
   * Friendly name of the certificate.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;

  /**
   * Subject name of the certificate.
   */
  @visibility(Lifecycle.Read)
  subjectName?: string;

  /**
   * Host names the certificate applies to.
   */
  hostNames?: string[];

  /**
   * Pfx blob.
   */
  pfxBlob?: bytes;

  /**
   * App name.
   */
  @visibility(Lifecycle.Read)
  siteName?: string;

  /**
   * Self link.
   */
  @visibility(Lifecycle.Read)
  selfLink?: string;

  /**
   * Certificate issuer.
   */
  @visibility(Lifecycle.Read)
  issuer?: string;

  /**
   * Certificate issue Date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueDate?: utcDateTime;

  /**
   * Certificate expiration date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Certificate thumbprint.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Is the certificate valid?.
   */
  @visibility(Lifecycle.Read)
  valid?: boolean;

  /**
   * Raw bytes of .cer file
   */
  @visibility(Lifecycle.Read)
  cerBlob?: bytes;

  /**
   * Public key hash.
   */
  @visibility(Lifecycle.Read)
  publicKeyHash?: string;

  /**
   * Specification for the App Service Environment to use for the certificate.
   */
  @visibility(Lifecycle.Read)
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * Azure Key Vault Csm resource Id.
   */
  keyVaultId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * Azure Key Vault secret name.
   */
  keyVaultSecretName?: string;

  /**
   * Status of the Key Vault secret.
   */
  @visibility(Lifecycle.Read)
  keyVaultSecretStatus?: KeyVaultSecretStatus;

  /**
   * Resource ID of the associated App Service plan.
   */
  serverFarmId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Web/serverfarms";
    }
  ]>;

  /**
   * CNAME of the certificate to be issued via free certificate
   */
  canonicalName?: string;

  /**
   * Method of domain validation for free cert
   */
  domainValidationMethod?: string;
}

/**
 * ARM resource for a certificate.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CertificatePatchResource extends ProxyOnlyResource {
  /**
   * CertificatePatchResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: CertificatePatchResourceProperties;
}

/**
 * CertificatePatchResource resource specific properties
 */
model CertificatePatchResourceProperties {
  /**
   * Certificate password.
   */
  @visibility(Lifecycle.Read)
  password?: string;

  /**
   * Friendly name of the certificate.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;

  /**
   * Subject name of the certificate.
   */
  @visibility(Lifecycle.Read)
  subjectName?: string;

  /**
   * Host names the certificate applies to.
   */
  hostNames?: string[];

  /**
   * Pfx blob.
   */
  pfxBlob?: bytes;

  /**
   * App name.
   */
  @visibility(Lifecycle.Read)
  siteName?: string;

  /**
   * Self link.
   */
  @visibility(Lifecycle.Read)
  selfLink?: string;

  /**
   * Certificate issuer.
   */
  @visibility(Lifecycle.Read)
  issuer?: string;

  /**
   * Certificate issue Date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueDate?: utcDateTime;

  /**
   * Certificate expiration date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Certificate thumbprint.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Is the certificate valid?.
   */
  @visibility(Lifecycle.Read)
  valid?: boolean;

  /**
   * Raw bytes of .cer file
   */
  @visibility(Lifecycle.Read)
  cerBlob?: bytes;

  /**
   * Public key hash.
   */
  @visibility(Lifecycle.Read)
  publicKeyHash?: string;

  /**
   * Specification for the App Service Environment to use for the certificate.
   */
  @visibility(Lifecycle.Read)
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * Key Vault Csm resource Id.
   */
  keyVaultId?: string;

  /**
   * Key Vault secret name.
   */
  keyVaultSecretName?: string;

  /**
   * Status of the Key Vault secret.
   */
  @visibility(Lifecycle.Read)
  keyVaultSecretStatus?: KeyVaultSecretStatus;

  /**
   * Resource ID of the associated App Service plan, formatted as: "/subscriptions/{subscriptionID}/resourceGroups/{groupName}/providers/Microsoft.Web/serverfarms/{appServicePlanName}".
   */
  serverFarmId?: string;

  /**
   * CNAME of the certificate to be issued via free certificate
   */
  canonicalName?: string;

  /**
   * Method of domain validation for free cert
   */
  domainValidationMethod?: string;
}

/**
 * Collection of deleted apps.
 */
model DeletedWebAppCollection is Azure.Core.Page<DeletedSite>;

/**
 * DeletedSite resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedSiteProperties {
  /**
   * Numeric id for the deleted site
   */
  @visibility(Lifecycle.Read)
  deletedSiteId?: int32;

  /**
   * Time in UTC when the app was deleted.
   */
  @visibility(Lifecycle.Read)
  deletedTimestamp?: string;

  /**
   * Subscription containing the deleted site
   */
  @visibility(Lifecycle.Read)
  subscription?: string;

  /**
   * ResourceGroup that contained the deleted site
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * Name of the deleted site
   */
  @visibility(Lifecycle.Read)
  deletedSiteName?: string;

  /**
   * Slot of the deleted site
   */
  @visibility(Lifecycle.Read)
  slot?: string;

  /**
   * Kind of site that was deleted
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Geo Region of the deleted site
   */
  @visibility(Lifecycle.Read)
  geoRegionName?: string;
}

/**
 * Collection of detector responses
 */
model DetectorResponseCollection is Azure.Core.Page<DetectorResponse>;

/**
 * DetectorResponse resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DetectorResponseProperties {
  /**
   * metadata for the detector
   */
  metadata?: DetectorInfo;

  /**
   * Data Set
   */
  @identifiers(#[])
  dataset?: DiagnosticData[];

  /**
   * Indicates status of the most severe insight.
   */
  status?: Status;

  /**
   * Additional configuration for different data providers to be used by the UI
   */
  @identifiers(#["providerName"])
  dataProvidersMetadata?: DataProviderMetadata[];

  /**
   * Suggested utterances where the detector can be applicable.
   */
  suggestedUtterances?: QueryUtterancesResults;
}

/**
 * Definition of Detector
 */
model DetectorInfo {
  /**
   * Id of detector
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of detector
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Short description of the detector and its purpose.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Author of the detector.
   */
  @visibility(Lifecycle.Read)
  author?: string;

  /**
   * Problem category. This serves for organizing group for detectors.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * List of Support Topics for which this detector is enabled.
   */
  @visibility(Lifecycle.Read)
  supportTopicList?: SupportTopic[];

  /**
   * Analysis Types for which this detector should apply to.
   */
  @visibility(Lifecycle.Read)
  analysisType?: string[];

  /**
   * Whether this detector is an Analysis Detector or not.
   */
  @visibility(Lifecycle.Read)
  type?: DetectorType;

  /**
   * Defines score of a detector to power ML based matching.
   */
  @visibility(Lifecycle.Read)
  score?: float32;
}

/**
 * Defines a unique Support Topic
 */
model SupportTopic {
  /**
   * Support Topic Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Unique resource Id
   */
  @visibility(Lifecycle.Read)
  pesId?: string;
}

/**
 * Set of data with rendering instructions
 */
model DiagnosticData {
  /**
   * Data in table form
   */
  table?: DataTableResponseObject;

  /**
   * Properties that describe how the table should be rendered
   */
  renderingProperties?: Rendering;
}

/**
 * Data Table which defines columns and raw row values
 */
model DataTableResponseObject {
  /**
   * Name of the table
   */
  tableName?: string;

  /**
   * List of columns with data types
   */
  @identifiers(#["columnName"])
  columns?: DataTableResponseColumn[];

  /**
   * Raw row values
   */
  @identifiers(#[])
  rows?: string[][];
}

/**
 * Column definition
 */
model DataTableResponseColumn {
  /**
   * Name of the column
   */
  columnName?: string;

  /**
   * Data type which looks like 'String' or 'Int32'.
   */
  dataType?: string;

  /**
   * Column Type
   */
  columnType?: string;
}

/**
 * Instructions for rendering the data
 */
model Rendering {
  /**
   * Rendering Type
   */
  type?: RenderingType;

  /**
   * Title of data
   */
  title?: string;

  /**
   * Description of the data that will help it be interpreted
   */
  description?: string;
}

/**
 * Identify the status of the most severe insight generated by the detector.
 */
model Status {
  /**
   * Descriptive message.
   */
  message?: string;

  /**
   * Level of the most severe insight generated by the detector.
   */
  statusId?: InsightStatus;
}

/**
 * Additional configuration for a data providers
 */
model DataProviderMetadata {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  providerName?: string;

  /**
   * Settings for the data provider
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["key"])
  propertyBag?: KeyValuePairStringObject[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KeyValuePairStringObject {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  key?: string;

  /**
   * Any object
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  value?: unknown;
}

/**
 * Suggested utterances where the detector can be applicable
 */
model QueryUtterancesResults {
  /**
   * Search Query.
   */
  query?: string;

  /**
   * Array of utterance results for search query.
   */
  @identifiers(#[])
  results?: QueryUtterancesResult[];
}

/**
 * Result for utterances query.
 */
model QueryUtterancesResult {
  /**
   * A sample utterance.
   */
  sampleUtterance?: SampleUtterance;

  /**
   * Score of a sample utterance.
   */
  score?: float32;
}

/**
 * Sample utterance.
 */
model SampleUtterance {
  /**
   * Text attribute of sample utterance.
   */
  text?: string;

  /**
   * Links attribute of sample utterance.
   */
  links?: string[];

  /**
   * Question id of sample utterance (for stackoverflow questions titles).
   */
  qid?: string;
}

/**
 * Collection of Diagnostic Categories
 */
model DiagnosticCategoryCollection is Azure.Core.Page<DiagnosticCategory>;

/**
 * DiagnosticCategory resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiagnosticCategoryProperties {
  /**
   * Description of the diagnostic category
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Collection of Diagnostic Analyses
 */
model DiagnosticAnalysisCollection is Azure.Core.Page<AnalysisDefinition>;

/**
 * AnalysisDefinition resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AnalysisDefinitionProperties {
  /**
   * Description of the Analysis
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Class representing a diagnostic analysis done on an application
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiagnosticAnalysis extends ProxyOnlyResource {
  /**
   * DiagnosticAnalysis resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: DiagnosticAnalysisProperties;
}

/**
 * DiagnosticAnalysis resource specific properties
 */
model DiagnosticAnalysisProperties {
  /**
   * Start time of the period
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the period
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * List of time periods.
   */
  @identifiers(#[])
  abnormalTimePeriods?: AbnormalTimePeriod[];

  /**
   * Data by each detector
   */
  @identifiers(#["source"])
  payload?: AnalysisData[];

  /**
   * Data by each detector for detectors that did not corelate
   */
  @identifiers(#["displayName"])
  nonCorrelatedDetectors?: DetectorDefinition[];
}

/**
 * Class representing Abnormal Time Period identified in diagnosis
 */
model AbnormalTimePeriod {
  /**
   * Start time of the downtime
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the downtime
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * List of Possible Cause of downtime
   */
  @identifiers(#[])
  events?: DetectorAbnormalTimePeriod[];

  /**
   * List of proposed solutions
   */
  solutions?: Solution[];
}

/**
 * Class representing Abnormal Time Period detected.
 */
model DetectorAbnormalTimePeriod {
  /**
   * Start time of the correlated event
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the correlated event
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Message describing the event
   */
  message?: string;

  /**
   * Represents the name of the Detector
   */
  source?: string;

  /**
   * Represents the rank of the Detector
   */
  priority?: float64;

  /**
   * Downtime metadata
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  metaData?: NameValuePair[][];

  /**
   * Represents the type of the Detector
   */
  type?: IssueType;

  /**
   * List of proposed solutions
   */
  solutions?: Solution[];
}

/**
 * Class Representing Solution for problems detected.
 */
model Solution {
  /**
   * Solution Id.
   */
  id?: float64;

  /**
   * Display Name of the solution
   */
  displayName?: string;

  /**
   * Order of the solution.
   */
  order?: float64;

  /**
   * Description of the solution
   */
  description?: string;

  /**
   * Type of Solution
   */
  type?: SolutionType;

  /**
   * Solution Data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  data?: NameValuePair[][];

  /**
   * Solution Metadata.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  metadata?: NameValuePair[][];
}

/**
 * Class Representing Detector Evidence used for analysis
 */
model AnalysisData {
  /**
   * Name of the Detector
   */
  source?: string;

  /**
   * Detector Definition
   */
  detectorDefinition?: DetectorDefinition;

  /**
   * Source Metrics
   */
  @identifiers(#["name"])
  metrics?: DiagnosticMetricSet[];

  /**
   * Additional Source Data
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  data?: NameValuePair[][];

  /**
   * Detector Meta Data
   */
  detectorMetaData?: ResponseMetaData;
}

/**
 * Class representing detector definition
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DetectorDefinition {
  /**
   * Display name of the detector
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Description of the detector
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Detector Rank
   */
  @visibility(Lifecycle.Read)
  rank?: float64;

  /**
   * Flag representing whether detector is enabled or not.
   */
  @visibility(Lifecycle.Read)
  isEnabled?: boolean;
}

/**
 * Class representing Diagnostic Metric information
 */
model DiagnosticMetricSet {
  /**
   * Name of the metric
   */
  name?: string;

  /**
   * Metric's unit
   */
  unit?: string;

  /**
   * Start time of the period
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the period
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Presented time grain. Supported grains at the moment are PT1M, PT1H, P1D
   */
  timeGrain?: string;

  /**
   * Collection of metric values for the selected period based on the {Microsoft.Web.Hosting.Administration.DiagnosticMetricSet.TimeGrain}
   */
  @identifiers(#[])
  values?: DiagnosticMetricSample[];
}

/**
 * Class representing Diagnostic Metric
 */
model DiagnosticMetricSample {
  /**
   * Time at which metric is measured
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Role Instance. Null if this counter is not per instance
   * This is returned and should be whichever instance name we desire to be returned
   * i.e. CPU and Memory return RDWORKERNAME (LargeDed..._IN_0)
   * where RDWORKERNAME is Machine name below and RoleInstance name in parenthesis
   */
  roleInstance?: string;

  /**
   * Total value of the metric. If multiple measurements are made this will have sum of all.
   */
  total?: float64;

  /**
   * Maximum of the metric sampled during the time period
   */
  maximum?: float64;

  /**
   * Minimum of the metric sampled during the time period
   */
  minimum?: float64;

  /**
   * Whether the values are aggregates across all workers or not
   */
  isAggregated?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResponseMetaData {
  /**
   * Source of the Data
   */
  dataSource?: DataSource;
}

/**
 * Class representing data source used by the detectors
 */
model DataSource {
  /**
   * Instructions if any for the data source
   */
  instructions?: string[];

  /**
   * Datasource Uri Links
   */
  @identifiers(#["name"])
  dataSourceUri?: NameValuePair[];
}

/**
 * Collection of Diagnostic Detectors
 */
model DiagnosticDetectorCollection
  is Azure.Core.Page<DetectorDefinitionResource>;

/**
 * Class representing Response from Diagnostic Detectors
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiagnosticDetectorResponse extends ProxyOnlyResource {
  /**
   * DiagnosticDetectorResponse resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: DiagnosticDetectorResponseProperties;
}

/**
 * DiagnosticDetectorResponse resource specific properties
 */
model DiagnosticDetectorResponseProperties {
  /**
   * Start time of the period
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the period
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Flag representing Issue was detected.
   */
  issueDetected?: boolean;

  /**
   * Detector's definition
   */
  detectorDefinition?: DetectorDefinition;

  /**
   * Metrics provided by the detector
   */
  @identifiers(#["name"])
  metrics?: DiagnosticMetricSet[];

  /**
   * List of Correlated events found by the detector
   */
  @identifiers(#[])
  abnormalTimePeriods?: DetectorAbnormalTimePeriod[];

  /**
   * Additional Data that detector wants to send.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  data?: NameValuePair[][];

  /**
   * Meta Data
   */
  responseMetaData?: ResponseMetaData;
}

/**
 * A snapshot of an app.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Snapshot extends ProxyOnlyResource {
  /**
   * Snapshot resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SnapshotProperties;
}

/**
 * Snapshot resource specific properties
 */
model SnapshotProperties {
  /**
   * The time the snapshot was taken.
   */
  @visibility(Lifecycle.Read)
  time?: string;
}

/**
 * Collection of Kubernetes Environments
 */
model KubeEnvironmentCollection is Azure.Core.Page<KubeEnvironment>;

/**
 * KubeEnvironment resource specific properties
 */
model KubeEnvironmentProperties {
  /**
   * Provisioning state of the Kubernetes Environment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KubeEnvironmentProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility(Lifecycle.Read)
  deploymentErrors?: string;

  /**
   * Only visible within Vnet/Subnet
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  internalLoadBalancerEnabled?: boolean;

  /**
   * Default Domain Name for the cluster
   */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /**
   * Static IP of the KubeEnvironment
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  staticIp?: string;

  /**
   * Type of Kubernetes Environment. Only supported for Container App Environments with value as Managed
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentType?: string;

  /**
   * Cluster configuration which determines the ARC cluster
   * components types. Eg: Choosing between BuildService kind,
   * FrontEnd Service ArtifactsStorageType etc.
   */
  arcConfiguration?: ArcConfiguration;

  /**
   * Cluster configuration which enables the log daemon to export
   * app logs to a destination. Currently only "log-analytics" is
   * supported
   */
  appLogsConfiguration?: AppLogsConfiguration;

  /**
   * Cluster configuration for Container Apps Environments to configure Dapr Instrumentation Key and VNET Configuration
   */
  containerAppsConfiguration?: ContainerAppsConfiguration;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  aksResourceID?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ArcConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactsStorageType?: StorageType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactStorageClassName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactStorageMountPath?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactStorageNodeName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  artifactStorageAccessMode?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontEndServiceConfiguration?: FrontEndConfiguration;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  kubeConfig?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FrontEndConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: FrontEndServiceType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AppLogsConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destination?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logAnalyticsConfiguration?: LogAnalyticsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LogAnalyticsConfiguration {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customerId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  sharedKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContainerAppsConfiguration {
  /**
   * Azure Monitor instrumentation key used by Dapr to export Service to Service communication telemetry
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  daprAIInstrumentationKey?: string;

  /**
   * IP range in CIDR notation that can be reserved for environment infrastructure IP addresses. It must not overlap with any other Subnet IP ranges.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  platformReservedCidr?: string;

  /**
   * An IP address from the IP range defined by platformReservedCidr that will be reserved for the internal DNS server
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  platformReservedDnsIP?: string;

  /**
   * Resource ID of a subnet for control plane infrastructure components. This subnet must be in the same VNET as the subnet defined in appSubnetResourceId. Must not overlap with the IP range defined in platformReservedCidr, if defined.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  controlPlaneSubnetResourceId?: string;

  /**
   * Resource ID of a subnet for control plane infrastructure components. This subnet must be in the same VNET as the subnet defined in appSubnetResourceId. Must not overlap with the IP range defined in platformReservedCidr, if defined.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  appSubnetResourceId?: string;

  /**
   * CIDR notation IP range assigned to the Docker bridge network. It must not overlap with any Subnet IP ranges or the IP range defined in platformReservedCidr, if defined.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dockerBridgeCidr?: string;
}

/**
 * ARM resource for a KubeEnvironment when patching
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KubeEnvironmentPatchResource extends ProxyOnlyResource {
  /**
   * KubeEnvironmentPatchResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: KubeEnvironmentPatchResourceProperties;
}

/**
 * KubeEnvironmentPatchResource resource specific properties
 */
model KubeEnvironmentPatchResourceProperties {
  /**
   * Provisioning state of the Kubernetes Environment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KubeEnvironmentProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility(Lifecycle.Read)
  deploymentErrors?: string;

  /**
   * Only visible within Vnet/Subnet
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  internalLoadBalancerEnabled?: boolean;

  /**
   * Default Domain Name for the cluster
   */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /**
   * Static IP of the KubeEnvironment
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  staticIp?: string;

  /**
   * Cluster configuration which determines the ARC cluster
   * components types. Eg: Choosing between BuildService kind,
   * FrontEnd Service ArtifactsStorageType etc.
   */
  arcConfiguration?: ArcConfiguration;

  /**
   * Cluster configuration which enables the log daemon to export
   * app logs to a destination. Currently only "log-analytics" is
   * supported
   */
  appLogsConfiguration?: AppLogsConfiguration;

  /**
   * Cluster configuration for Container Apps Environments to configure Dapr Instrumentation Key and VNET Configuration
   */
  containerAppsConfiguration?: ContainerAppsConfiguration;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  aksResourceID?: string;
}

/**
 * Collection of Application Stacks
 */
model ApplicationStackCollection is Azure.Core.Page<ApplicationStackResource>;

/**
 * ARM resource for a ApplicationStack.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationStackResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ApplicationStack;
}

/**
 * Application stack.
 */
model ApplicationStack {
  /**
   * Application stack name.
   */
  name?: string;

  /**
   * Application stack display name.
   */
  display?: string;

  /**
   * Application stack dependency.
   */
  dependency?: string;

  /**
   * List of major versions available.
   */
  @identifiers(#["runtimeVersion"])
  majorVersions?: StackMajorVersion[];

  /**
   * List of frameworks associated with application stack.
   */
  @identifiers(#["name"])
  frameworks?: ApplicationStack[];

  /**
   * <code>true</code> if this is the stack is deprecated; otherwise, <code>false</code>.
   */
  @identifiers(#["name"])
  isDeprecated?: ApplicationStack[];
}

/**
 * Application stack major version.
 */
model StackMajorVersion {
  /**
   * Application stack major version (display only).
   */
  displayVersion?: string;

  /**
   * Application stack major version (runtime only).
   */
  runtimeVersion?: string;

  /**
   * <code>true</code> if this is the default major version; otherwise, <code>false</code>.
   */
  isDefault?: boolean;

  /**
   * Minor versions associated with the major version.
   */
  @identifiers(#["runtimeVersion"])
  minorVersions?: StackMinorVersion[];

  /**
   * <code>true</code> if this supports Application Insights; otherwise, <code>false</code>.
   */
  applicationInsights?: boolean;

  /**
   * <code>true</code> if this stack is in Preview, otherwise <code>false</code>.
   */
  isPreview?: boolean;

  /**
   * <code>true</code> if this stack has been deprecated, otherwise <code>false</code>.
   */
  isDeprecated?: boolean;

  /**
   * <code>true</code> if this stack should be hidden for new customers on portal, otherwise <code>false</code>.
   */
  isHidden?: boolean;

  /**
   * <appSettings>
   *  <appSetting name="FUNCTIONS_WORKER_RUNTIME" value="dotnet" />
   * </appSettings>
   *  Example: All the function apps need AppSetting: "FUNCTIONS_WORKER_RUNTIME" to be set stack name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  appSettingsDictionary?: Record<unknown>;

  /**
   * <siteConfigProperties>
   *  <siteConfigProperty name="Use32BitWorkerProcess" value="false" />
   * </siteConfigProperties>
   *  Example: All Linux Function Apps, need Use32BitWorkerProcess to be set to 0
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  siteConfigPropertiesDictionary?: Record<unknown>;
}

/**
 * Application stack minor version.
 */
model StackMinorVersion {
  /**
   * Application stack minor version (display only).
   */
  displayVersion?: string;

  /**
   * Application stack minor version (runtime only).
   */
  runtimeVersion?: string;

  /**
   * <code>true</code> if this is the default minor version; otherwise, <code>false</code>.
   */
  isDefault?: boolean;

  /**
   * <code>true</code> if this supports Remote Debugging, otherwise <code>false</code>.
   */
  isRemoteDebuggingEnabled?: boolean;
}

/**
 * Collection of Function app Stacks
 */
model FunctionAppStackCollection is Azure.Core.Page<FunctionAppStack>;

/**
 * Function App Stack.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FunctionAppStack extends ProxyOnlyResource {
  /**
   * Function App stack location.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * FunctionAppStack resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: FunctionAppStackProperties;
}

/**
 * FunctionAppStack resource specific properties
 */
model FunctionAppStackProperties {
  /**
   * Function App stack (display only).
   */
  @visibility(Lifecycle.Read)
  displayText?: string;

  /**
   * Function App stack name.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * List of major versions available.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["value"])
  majorVersions?: FunctionAppMajorVersion[];

  /**
   * Function App stack preferred OS.
   */
  @visibility(Lifecycle.Read)
  preferredOs?: StackPreferredOs;
}

/**
 * Function App stack major version.
 */
model FunctionAppMajorVersion {
  /**
   * Function App stack major version (display only).
   */
  @visibility(Lifecycle.Read)
  displayText?: string;

  /**
   * Function App stack major version name.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * Minor versions associated with the major version.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["value"])
  minorVersions?: FunctionAppMinorVersion[];
}

/**
 * Function App stack minor version.
 */
model FunctionAppMinorVersion {
  /**
   * Function App stack (display only).
   */
  @visibility(Lifecycle.Read)
  displayText?: string;

  /**
   * Function App stack name.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * Settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  stackSettings?: FunctionAppRuntimes;
}

/**
 * Function App stack runtimes.
 */
model FunctionAppRuntimes {
  /**
   * Linux-specific settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  linuxRuntimeSettings?: FunctionAppRuntimeSettings;

  /**
   * Windows-specific settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  windowsRuntimeSettings?: FunctionAppRuntimeSettings;
}

/**
 * Function App runtime settings.
 */
model FunctionAppRuntimeSettings {
  /**
   * Function App stack minor version (runtime only).
   */
  @visibility(Lifecycle.Read)
  runtimeVersion?: string;

  /**
   * <code>true</code> if remote debugging is supported for the stack; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  remoteDebuggingSupported?: boolean;

  /**
   * Application Insights settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  appInsightsSettings?: AppInsightsWebAppStackSettings;

  /**
   * GitHub Actions settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  gitHubActionSettings?: GitHubActionWebAppStackSettings;

  /**
   * Application settings associated with the minor version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  appSettingsDictionary?: Record<string>;

  /**
   * Configuration settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  siteConfigPropertiesDictionary?: SiteConfigPropertiesDictionary;

  /**
   * List of supported Functions extension versions.
   */
  @visibility(Lifecycle.Read)
  supportedFunctionsExtensionVersions?: string[];

  /**
   * <code>true</code> if the stack is in preview; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isPreview?: boolean;

  /**
   * <code>true</code> if the stack is deprecated; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isDeprecated?: boolean;

  /**
   * <code>true</code> if the stack should be hidden; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isHidden?: boolean;

  /**
   * End-of-life date for the minor version.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * <code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isAutoUpdate?: boolean;

  /**
   * <code>true</code> if the minor version is early-access; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isEarlyAccess?: boolean;

  /**
   * <code>true</code> if the minor version the default; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isDefault?: boolean;
}

/**
 * App Insights Web App stack settings.
 */
model AppInsightsWebAppStackSettings {
  /**
   * <code>true</code> if remote Application Insights is supported for the stack; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isSupported?: boolean;

  /**
   * <code>true</code> if Application Insights is disabled by default for the stack; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isDefaultOff?: boolean;
}

/**
 * GitHub Actions Web App stack settings.
 */
model GitHubActionWebAppStackSettings {
  /**
   * <code>true</code> if GitHub Actions is supported for the stack; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isSupported?: boolean;

  /**
   * The minor version that is supported for GitHub Actions.
   */
  @visibility(Lifecycle.Read)
  supportedVersion?: string;
}

/**
 * Site config properties dictionary.
 */
model SiteConfigPropertiesDictionary {
  /**
   * <code>true</code> if use32BitWorkerProcess should be set to true for the stack; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  use32BitWorkerProcess?: boolean;

  /**
   * LinuxFxVersion configuration setting.
   */
  @visibility(Lifecycle.Read)
  linuxFxVersion?: string;

  /**
   * JavaVersion configuration setting.
   */
  @visibility(Lifecycle.Read)
  javaVersion?: string;

  /**
   * PowerShellVersion configuration setting.
   */
  @visibility(Lifecycle.Read)
  powerShellVersion?: string;
}

/**
 * Collection of Web app Stacks
 */
model WebAppStackCollection is Azure.Core.Page<WebAppStack>;

/**
 * Web App stack.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WebAppStack extends ProxyOnlyResource {
  /**
   * Web App stack location.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * WebAppStack resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: WebAppStackProperties;
}

/**
 * WebAppStack resource specific properties
 */
model WebAppStackProperties {
  /**
   * Web App stack (display only).
   */
  @visibility(Lifecycle.Read)
  displayText?: string;

  /**
   * Web App stack name.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * List of major versions available.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["value"])
  majorVersions?: WebAppMajorVersion[];

  /**
   * Web App stack preferred OS.
   */
  @visibility(Lifecycle.Read)
  preferredOs?: StackPreferredOs;
}

/**
 * Web App stack major version.
 */
model WebAppMajorVersion {
  /**
   * Web App stack major version (display only).
   */
  @visibility(Lifecycle.Read)
  displayText?: string;

  /**
   * Web App stack major version name.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * Minor versions associated with the major version.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["value"])
  minorVersions?: WebAppMinorVersion[];
}

/**
 * Web App stack minor version.
 */
model WebAppMinorVersion {
  /**
   * Web App stack minor version (display only).
   */
  @visibility(Lifecycle.Read)
  displayText?: string;

  /**
   * Web App stack major version name.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * Settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  stackSettings?: WebAppRuntimes;
}

/**
 * Web App stack runtimes.
 */
model WebAppRuntimes {
  /**
   * Linux-specific settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  linuxRuntimeSettings?: WebAppRuntimeSettings;

  /**
   * Windows-specific settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  windowsRuntimeSettings?: WebAppRuntimeSettings;

  /**
   * Linux-specific settings associated with the Java container minor version.
   */
  @visibility(Lifecycle.Read)
  linuxContainerSettings?: LinuxJavaContainerSettings;

  /**
   * Windows-specific settings associated with the Java container minor version.
   */
  @visibility(Lifecycle.Read)
  windowsContainerSettings?: WindowsJavaContainerSettings;
}

/**
 * Web App runtime settings.
 */
model WebAppRuntimeSettings {
  /**
   * Web App stack minor version (runtime only).
   */
  @visibility(Lifecycle.Read)
  runtimeVersion?: string;

  /**
   * <code>true</code> if remote debugging is supported for the stack; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  remoteDebuggingSupported?: boolean;

  /**
   * Application Insights settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  appInsightsSettings?: AppInsightsWebAppStackSettings;

  /**
   * GitHub Actions settings associated with the minor version.
   */
  @visibility(Lifecycle.Read)
  gitHubActionSettings?: GitHubActionWebAppStackSettings;

  /**
   * <code>true</code> if the stack is in preview; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isPreview?: boolean;

  /**
   * <code>true</code> if the stack is deprecated; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isDeprecated?: boolean;

  /**
   * <code>true</code> if the stack should be hidden; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isHidden?: boolean;

  /**
   * End-of-life date for the minor version.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * <code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isAutoUpdate?: boolean;

  /**
   * <code>true</code> if the minor version is early-access; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isEarlyAccess?: boolean;
}

/**
 * Linux Java Container settings.
 */
model LinuxJavaContainerSettings {
  /**
   * Java 11 version (runtime only).
   */
  @visibility(Lifecycle.Read)
  java11Runtime?: string;

  /**
   * Java 8 version (runtime only).
   */
  @visibility(Lifecycle.Read)
  java8Runtime?: string;

  /**
   * <code>true</code> if the stack is in preview; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isPreview?: boolean;

  /**
   * <code>true</code> if the stack is deprecated; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isDeprecated?: boolean;

  /**
   * <code>true</code> if the stack should be hidden; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isHidden?: boolean;

  /**
   * End-of-life date for the minor version.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * <code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isAutoUpdate?: boolean;

  /**
   * <code>true</code> if the minor version is early-access; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isEarlyAccess?: boolean;
}

/**
 * Windows Java Container settings.
 */
model WindowsJavaContainerSettings {
  /**
   * Java container (runtime only).
   */
  @visibility(Lifecycle.Read)
  javaContainer?: string;

  /**
   * Java container version (runtime only).
   */
  @visibility(Lifecycle.Read)
  javaContainerVersion?: string;

  /**
   * <code>true</code> if the stack is in preview; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isPreview?: boolean;

  /**
   * <code>true</code> if the stack is deprecated; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isDeprecated?: boolean;

  /**
   * <code>true</code> if the stack should be hidden; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isHidden?: boolean;

  /**
   * End-of-life date for the minor version.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * <code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isAutoUpdate?: boolean;

  /**
   * <code>true</code> if the minor version is early-access; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isEarlyAccess?: boolean;
}

/**
 * Collection of Azure resource manager operation metadata.
 */
model CsmOperationCollection {
  /**
   * Collection of resources.
   */
  @pageItems
  @identifiers(#["name"])
  value: CsmOperationDescription[];

  /**
   * Link to next page of resources.
   */
  @doc("Link to next page of resources.")
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Description of an operation available for Microsoft.Web resource provider.
 */
model CsmOperationDescription {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isDataAction?: boolean;

  /**
   * Meta data about operation used for display in portal.
   */
  display?: CsmOperationDisplay;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  origin?: string;

  /**
   * Properties available for a Microsoft.Web resource provider operation.
   */
  properties?: CsmOperationDescriptionProperties;
}

/**
 * Meta data about operation used for display in portal.
 */
model CsmOperationDisplay {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  operation?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;
}

/**
 * Properties available for a Microsoft.Web resource provider operation.
 */
model CsmOperationDescriptionProperties {
  /**
   * Resource metrics service provided by Microsoft.Insights resource provider.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Resource metrics service provided by Microsoft.Insights resource provider.
 */
model ServiceSpecification {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  metricSpecifications?: MetricSpecification[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  logSpecifications?: LogSpecification[];
}

/**
 * Definition of a single resource metric.
 */
model MetricSpecification {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayDescription?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  unit?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aggregationType?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportsInstanceLevelAggregation?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableRegionalMdmAccount?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceMdmAccount?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceMdmNamespace?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metricFilterPattern?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fillGapWithZero?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isInternal?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["name"])
  dimensions?: Dimension[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  category?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  availabilities?: MetricAvailability[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportedTimeGrainTypes?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  supportedAggregationTypes?: string[];
}

/**
 * Dimension of a resource metric. For e.g. instance specific HTTP requests for a web app,
 * where instance name is dimension of the metric HTTP request
 */
model Dimension {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  internalName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  toBeExportedForShoebox?: boolean;
}

/**
 * Retention policy of a resource metric.
 */
model MetricAvailability {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeGrain?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blobDuration?: string;
}

/**
 * Log Definition of a single resource metric.
 */
model LogSpecification {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blobDuration?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logFilterPattern?: string;
}

/**
 * Collection of recommendations.
 */
model RecommendationCollection is Azure.Core.Page<Recommendation>;

/**
 * Represents a recommendation result generated by the recommendation engine.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Recommendation extends ProxyOnlyResource {
  /**
   * Recommendation resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: RecommendationProperties;
}

/**
 * Recommendation resource specific properties
 */
model RecommendationProperties {
  /**
   * Timestamp when this instance was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * A GUID value that each recommendation object is associated with.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  recommendationId?: string;

  /**
   * Full ARM resource ID string that this recommendation object is associated with.
   */
  resourceId?: string;

  /**
   * Name of a resource type this recommendation applies, e.g. Subscription, ServerFarm, Site.
   */
  resourceScope?: ResourceScopeType;

  /**
   * Unique name of the rule.
   */
  ruleName?: string;

  /**
   * UI friendly name of the rule (may not be unique).
   */
  displayName?: string;

  /**
   * Recommendation text.
   */
  message?: string;

  /**
   * Level indicating how critical this recommendation can impact.
   */
  level?: NotificationLevel;

  /**
   * List of channels that this recommendation can apply.
   */
  channels?: Channels;

  /**
   * The list of category tags that this recommendation belongs to.
   */
  @visibility(Lifecycle.Read)
  categoryTags?: string[];

  /**
   * Name of action recommended by this object.
   */
  actionName?: string;

  /**
   * True if this recommendation is still valid (i.e. "actionable"). False if it is invalid.
   */
  enabled?: int32;

  /**
   * The list of states of this recommendation. If it's null then it should be considered "Active".
   */
  states?: string[];

  /**
   * The beginning time in UTC of a range that the recommendation refers to.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time in UTC of a range that the recommendation refers to.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * When to notify this recommendation next in UTC. Null means that this will never be notified anymore.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextNotificationTime?: utcDateTime;

  /**
   * Date and time in UTC when this notification expires.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notificationExpirationTime?: utcDateTime;

  /**
   * Last timestamp in UTC this instance was actually notified. Null means that this recommendation hasn't been notified yet.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notifiedTime?: utcDateTime;

  /**
   * A metric value measured by the rule.
   */
  score?: float64;

  /**
   * True if this is associated with a dynamically added rule
   */
  isDynamic?: boolean;

  /**
   * Extension name of the portal if exists.
   */
  extensionName?: string;

  /**
   * Deep link to a blade on the portal.
   */
  bladeName?: string;

  /**
   * Forward link to an external document associated with the rule.
   */
  forwardLink?: string;
}

/**
 * RecommendationRule resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecommendationRuleProperties {
  /**
   * Unique name of the rule.
   */
  recommendationName?: string;

  /**
   * UI friendly name of the rule.
   */
  displayName?: string;

  /**
   * Localized name of the rule (Good for UI).
   */
  message?: string;

  /**
   * Recommendation ID of an associated recommendation object tied to the rule, if exists.
   * If such an object doesn't exist, it is set to null.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  recommendationId?: string;

  /**
   * Localized detailed description of the rule.
   */
  description?: string;

  /**
   * Name of action that is recommended by this rule in string.
   */
  actionName?: string;

  /**
   * Level of impact indicating how critical this rule is.
   */
  level?: NotificationLevel;

  /**
   * List of available channels that this rule applies.
   */
  channels?: Channels;

  /**
   * The list of category tags that this recommendation rule belongs to.
   */
  @visibility(Lifecycle.Read)
  categoryTags?: string[];

  /**
   * True if this is associated with a dynamically added rule
   */
  isDynamic?: boolean;

  /**
   * Extension name of the portal if exists. Applicable to dynamic rule only.
   */
  extensionName?: string;

  /**
   * Deep link to a blade on the portal. Applicable to dynamic rule only.
   */
  bladeName?: string;

  /**
   * Forward link to an external document associated with the rule. Applicable to dynamic rule only.
   */
  forwardLink?: string;
}

/**
 * Collection of resource health metadata.
 */
model ResourceHealthMetadataCollection
  is Azure.Core.Page<ResourceHealthMetadata>;

/**
 * ResourceHealthMetadata resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceHealthMetadataProperties {
  /**
   * The category that the resource matches in the RHC Policy File
   */
  category?: string;

  /**
   * Is there a health signal for the resource
   */
  signalAvailability?: boolean;
}

/**
 * User resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UserProperties {
  /**
   * Username used for publishing.
   */
  publishingUserName: string;

  /**
   * Password used for publishing.
   */
  @secret
  publishingPassword?: string;

  /**
   * Password hash used for publishing.
   */
  @secret
  publishingPasswordHash?: string;

  /**
   * Password hash salt used for publishing.
   */
  @secret
  publishingPasswordHashSalt?: string;

  /**
   * Url of SCM site.
   */
  scmUri?: string;
}

/**
 * Collection of source controls.
 */
model SourceControlCollection is Azure.Core.Page<SourceControl>;

/**
 * SourceControl resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SourceControlProperties {
  /**
   * OAuth access token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  token?: string;

  /**
   * OAuth access token secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tokenSecret?: string;

  /**
   * OAuth refresh token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  refreshToken?: string;

  /**
   * OAuth token expiration.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;
}

/**
 * Collection of Billing Meters
 */
model BillingMeterCollection is Azure.Core.Page<BillingMeter>;

/**
 * App Service billing entity that contains information about meter which the Azure billing system utilizes to charge users for services.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingMeter extends ProxyOnlyResource {
  /**
   * BillingMeter resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BillingMeterProperties;
}

/**
 * BillingMeter resource specific properties
 */
model BillingMeterProperties {
  /**
   * Meter GUID onboarded in Commerce
   */
  meterId?: string;

  /**
   * Azure Location of billable resource
   */
  billingLocation?: string;

  /**
   * Short Name from App Service Azure pricing Page
   */
  shortName?: string;

  /**
   * Friendly name of the meter
   */
  friendlyName?: string;

  /**
   * App Service ResourceType meter used for
   */
  resourceType?: string;

  /**
   * App Service OS type meter used for
   */
  osType?: string;

  /**
   * Meter Multiplier
   */
  multiplier?: float64;
}

/**
 * Resource name availability request content.
 */
model ResourceNameAvailabilityRequest {
  /**
   * Resource name to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type: CheckNameResourceTypes;

  /**
   * Is fully qualified domain name.
   */
  isFqdn?: boolean;

  /**
   * Azure Resource Manager ID of the customer's selected Container Apps Environment on which to host the Function app. This must be of the form /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.App/managedEnvironments/{managedEnvironmentName}
   */
  environmentId?: string;
}

/**
 * Information regarding availability of a resource name.
 */
model ResourceNameAvailability {
  /**
   * <code>true</code> indicates name is valid and available. <code>false</code> indicates the name is invalid, unavailable, or both.
   */
  nameAvailable?: boolean;

  /**
   * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
   */
  reason?: InAvailabilityReasonType;

  /**
   * If reason == invalid, provide the user with the reason why the given name is invalid, and provide the resource naming requirements so that the user can select a valid name. If reason == AlreadyExists, explain that resource name is already in use, and direct them to select a different name.
   */
  message?: string;
}

/**
 * Collection of custom hostname sites
 */
model CustomHostnameSitesCollection is Azure.Core.Page<CustomHostnameSites>;

/**
 * A hostname and its assigned sites
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CustomHostnameSites extends ProxyOnlyResource {
  /**
   * CustomHostnameSites resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: CustomHostnameSitesProperties;
}

/**
 * CustomHostnameSites resource specific properties
 */
model CustomHostnameSitesProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customHostname?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  region?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  siteResourceIds?: Identifier[];
}

/**
 * Identifier resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IdentifierProperties {
  /**
   * String representation of the identity.
   */
  id?: string;
}

/**
 * List of available locations (regions or App Service Environments) for
 * deployment of App Service resources.
 */
model DeploymentLocations {
  /**
   * Available regions.
   */
  locations?: GeoRegion[];

  /**
   * Available App Service Environments with full descriptions of the environments.
   */
  @identifiers(#[])
  hostingEnvironments?: AppServiceEnvironment[];

  /**
   * Available App Service Environments with basic information.
   */
  @identifiers(#["name"])
  hostingEnvironmentDeploymentInfos?: HostingEnvironmentDeploymentInfo[];
}

/**
 * Geographical region.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GeoRegion extends ProxyOnlyResource {
  /**
   * GeoRegion resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: GeoRegionProperties;
}

/**
 * GeoRegion resource specific properties
 */
model GeoRegionProperties {
  /**
   * Region description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Display name for region.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Display name for region.
   */
  @visibility(Lifecycle.Read)
  orgDomain?: string;
}

/**
 * Information needed to create resources on an App Service Environment.
 */
model HostingEnvironmentDeploymentInfo {
  /**
   * Name of the App Service Environment.
   */
  name?: string;

  /**
   * Location of the App Service Environment.
   */
  location?: string;
}

/**
 * Collection of ASE regions.
 */
model AseRegionCollection is Azure.Core.Page<AseRegion>;

/**
 * ASE region.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AseRegion extends ProxyOnlyResource {
  /**
   * ASE region resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AseRegionProperties;
}

/**
 * ASE region resource specific properties
 */
model AseRegionProperties {
  /**
   * Display name for region.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Is region standard.
   */
  @visibility(Lifecycle.Read)
  standard?: boolean;

  /**
   * Dedicated host enabled.
   */
  @visibility(Lifecycle.Read)
  dedicatedHost?: boolean;

  /**
   * Zone redundant deployment enabled.
   */
  @visibility(Lifecycle.Read)
  zoneRedundant?: boolean;

  /**
   * Available Skus in region.
   */
  availableSku?: string[];

  /**
   * Available OSs in region.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availableOS?: string[];
}

/**
 * Collection of geographical regions.
 */
model GeoRegionCollection is Azure.Core.Page<GeoRegion>;

/**
 * Identifies an object.
 */
model NameIdentifier {
  /**
   * Name of the object.
   */
  name?: string;
}

/**
 * Collection of identifiers.
 */
model IdentifierCollection is Azure.Core.Page<Identifier>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DnlResourceNameAvailabilityRequest {
  /**
   * Resource group name
   */
  resourceGroupName?: string;

  /**
   * Indicates the endpoint name reuse scope.The default value is TenantReuse.
   * Supported values are TenantReuse, SubscriptionReuse, ResourceGroupReuse, NoReuse
   */
  autoGeneratedDomainNameLabelScope?: string;

  /**
   * Resource name to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type: CheckNameResourceTypes;
}

/**
 * Information regarding availability of a resource name for DNL apps with regionalized default hostnames.
 */
model DnlResourceNameAvailability {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostName?: string;

  /**
   * <code>true</code> indicates name is valid and available. <code>false</code> indicates the name is invalid, unavailable, or both.
   */
  nameAvailable?: boolean;

  /**
   * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
   */
  reason?: InAvailabilityReasonType;

  /**
   * If reason == invalid, provide the user with the reason why the given name is invalid, and provide the resource naming requirements so that the user can select a valid name. If reason == AlreadyExists, explain that resource name is already in use, and direct them to select a different name.
   */
  message?: string;
}

/**
 * Collection of premier add-on offers.
 */
model PremierAddOnOfferCollection is Azure.Core.Page<PremierAddOnOffer>;

/**
 * Premier add-on offer.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PremierAddOnOffer extends ProxyOnlyResource {
  /**
   * PremierAddOnOffer resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: PremierAddOnOfferProperties;
}

/**
 * PremierAddOnOffer resource specific properties
 */
model PremierAddOnOfferProperties {
  /**
   * Premier add on SKU.
   */
  sku?: string;

  /**
   * Premier add on offer Product.
   */
  product?: string;

  /**
   * Premier add on offer Vendor.
   */
  vendor?: string;

  /**
   * <code>true</code> if promotion code is required; otherwise, <code>false</code>.
   */
  promoCodeRequired?: boolean;

  /**
   * Premier add on offer Quota.
   */
  quota?: int32;

  /**
   * App Service plans this offer is restricted to.
   */
  webHostingPlanRestrictions?: AppServicePlanRestrictions;

  /**
   * Privacy policy URL.
   */
  privacyPolicyUrl?: string;

  /**
   * Legal terms URL.
   */
  legalTermsUrl?: string;

  /**
   * Marketplace publisher.
   */
  marketplacePublisher?: string;

  /**
   * Marketplace offer.
   */
  marketplaceOffer?: string;
}

/**
 * Collection of SKU information.
 */
model SkuInfos {
  /**
   * Resource type that this SKU applies to.
   */
  resourceType?: string;

  /**
   * List of SKUs the subscription is able to use.
   */
  @identifiers(#["name"])
  skus?: GlobalCsmSkuDescription[];
}

/**
 * A Global SKU Description.
 */
model GlobalCsmSkuDescription {
  /**
   * Name of the resource SKU.
   */
  name?: string;

  /**
   * Service Tier of the resource SKU.
   */
  tier?: string;

  /**
   * Size specifier of the resource SKU.
   */
  size?: string;

  /**
   * Family code of the resource SKU.
   */
  family?: string;

  /**
   * Min, max, and default scale values of the SKU.
   */
  capacity?: SkuCapacity;

  /**
   * Locations of the SKU.
   */
  locations?: string[];

  /**
   * Capabilities of the SKU, e.g., is traffic manager enabled?
   */
  @identifiers(#["name"])
  capabilities?: Capability[];
}

/**
 * The required set of inputs to validate a VNET
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VnetParameters extends ProxyOnlyResource {
  /**
   * VnetParameters resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: VnetParametersProperties;
}

/**
 * VnetParameters resource specific properties
 */
model VnetParametersProperties {
  /**
   * The Resource Group of the VNET to be validated
   */
  vnetResourceGroup?: string;

  /**
   * The name of the VNET to be validated
   */
  vnetName?: string;

  /**
   * The subnet name to be validated
   */
  vnetSubnetName?: string;

  /**
   * The ARM Resource ID of the subnet to validate
   */
  subnetResourceId?: string;
}

/**
 * A class that describes the reason for a validation failure.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VnetValidationFailureDetails extends ProxyOnlyResource {
  /**
   * VnetValidationFailureDetails resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: VnetValidationFailureDetailsProperties;
}

/**
 * VnetValidationFailureDetails resource specific properties
 */
model VnetValidationFailureDetailsProperties {
  /**
   * Text describing the validation outcome.
   */
  message?: string;

  /**
   * A flag describing whether or not validation failed.
   */
  failed?: boolean;

  /**
   * A list of tests that failed in the validation.
   */
  failedTests?: VnetValidationTestFailure[];

  /**
   * A list of warnings generated during validation.
   */
  warnings?: VnetValidationTestFailure[];
}

/**
 * A class that describes a test that failed during NSG and UDR validation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VnetValidationTestFailure extends ProxyOnlyResource {
  /**
   * VnetValidationTestFailure resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: VnetValidationTestFailureProperties;
}

/**
 * VnetValidationTestFailure resource specific properties
 */
model VnetValidationTestFailureProperties {
  /**
   * The name of the test that failed.
   */
  testName?: string;

  /**
   * The details of what caused the failure, e.g. the blocking rule name, etc.
   */
  details?: string;
}

/**
 * Object with a list of the resources that need to be moved and the resource group they should be moved to.
 */
model CsmMoveResourceEnvelope {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxLength(90)
  @minLength(1)
  @pattern(" ^[-\\w\\._\\(\\)]+[^\\.]$")
  targetResourceGroup?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resources?: string[];
}

/**
 * Resource validation request content.
 */
model ValidateRequest {
  /**
   * Resource name to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type: ValidateResourceTypes;

  /**
   * Expected location of the resource.
   */
  location: string;

  /**
   * Properties of the resource to validate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: ValidateProperties;
}

/**
 * App properties used for validation.
 */
model ValidateProperties {
  /**
   * ARM resource ID of an App Service plan that would host the app.
   */
  serverFarmId?: string;

  /**
   * Name of the target SKU for the App Service plan.
   */
  skuName?: string;

  /**
   * <code>true</code> if App Service plan is for Linux workers; otherwise, <code>false</code>.
   */
  needLinuxWorkers?: boolean;

  /**
   * <code>true</code> if App Service plan is for Spot instances; otherwise, <code>false</code>.
   */
  isSpot?: boolean;

  /**
   * Target capacity of the App Service plan (number of VMs).
   */
  @minValue(1)
  capacity?: int32;

  /**
   * Name of App Service Environment where app or App Service plan should be created.
   */
  hostingEnvironment?: string;

  /**
   * <code>true</code> if App Service plan is running as a windows container
   */
  isXenon?: boolean;

  /**
   * Base URL of the container registry
   */
  containerRegistryBaseUrl?: string;

  /**
   * Username for to access the container registry
   */
  containerRegistryUsername?: string;

  /**
   * Password for to access the container registry
   */
  containerRegistryPassword?: string;

  /**
   * Repository name (image name)
   */
  containerImageRepository?: string;

  /**
   * Image tag
   */
  containerImageTag?: string;

  /**
   * Platform (windows or linux)
   */
  containerImagePlatform?: string;

  /**
   * App Service Environment Properties
   */
  appServiceEnvironment?: AppServiceEnvironment;
}

/**
 * Describes the result of resource validation.
 */
model ValidateResponse {
  /**
   * Result of validation.
   */
  status?: string;

  /**
   * Error details for the case when validation fails.
   */
  error?: ValidateResponseError;
}

/**
 * Error details for when validation fails.
 */
model ValidateResponseError {
  /**
   * Validation error code.
   */
  code?: string;

  /**
   * Validation error message.
   */
  message?: string;
}

/**
 * Request entity for previewing the Static Site workflow
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSitesWorkflowPreviewRequest extends ProxyOnlyResource {
  /**
   * StaticSitesWorkflowPreviewRequest resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSitesWorkflowPreviewRequestProperties;
}

/**
 * StaticSitesWorkflowPreviewRequest resource specific properties
 */
model StaticSitesWorkflowPreviewRequestProperties {
  /**
   * URL for the repository of the static site.
   */
  repositoryUrl?: string;

  /**
   * The target branch in the repository.
   */
  branch?: string;

  /**
   * Build properties to configure on the repository.
   */
  buildProperties?: StaticSiteBuildProperties;
}

/**
 * Build properties for the static site.
 */
model StaticSiteBuildProperties {
  /**
   * The path to the app code within the repository.
   */
  appLocation?: string;

  /**
   * The path to the api code within the repository.
   */
  apiLocation?: string;

  /**
   * Deprecated: The path of the app artifacts after building (deprecated in favor of OutputLocation)
   */
  appArtifactLocation?: string;

  /**
   * The output path of the app after building.
   */
  outputLocation?: string;

  /**
   * A custom command to run during deployment of the static content application.
   */
  appBuildCommand?: string;

  /**
   * A custom command to run during deployment of the Azure Functions API application.
   */
  apiBuildCommand?: string;

  /**
   * Skip Github Action workflow generation.
   */
  skipGithubActionWorkflowGeneration?: boolean;

  /**
   * Github Action secret name override.
   */
  githubActionSecretNameOverride?: string;
}

/**
 * Preview for the Static Site Workflow to be generated
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSitesWorkflowPreview extends ProxyOnlyResource {
  /**
   * StaticSitesWorkflowPreview resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSitesWorkflowPreviewProperties;
}

/**
 * StaticSitesWorkflowPreview resource specific properties
 */
model StaticSitesWorkflowPreviewProperties {
  /**
   * The path for the workflow file to be generated
   */
  @visibility(Lifecycle.Read)
  path?: string;

  /**
   * The contents for the workflow file to be generated
   */
  @visibility(Lifecycle.Read)
  contents?: string;
}

/**
 * Collection of static sites.
 */
model StaticSiteCollection is Azure.Core.Page<StaticSiteARMResource>;

/**
 * A static site.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSite {
  /**
   * The default autogenerated hostname for the static site.
   */
  @visibility(Lifecycle.Read)
  defaultHostname?: string;

  /**
   * URL for the repository of the static site.
   */
  repositoryUrl?: string;

  /**
   * The target branch in the repository.
   */
  branch?: string;

  /**
   * The custom domains associated with this static site.
   */
  @visibility(Lifecycle.Read)
  customDomains?: string[];

  /**
   * A user's github repository token. This is used to setup the Github Actions workflow file and API secrets.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  repositoryToken?: string;

  /**
   * Build properties to configure on the repository.
   */
  buildProperties?: StaticSiteBuildProperties;

  /**
   * Private endpoint connections
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: ResponseMessageEnvelopeRemotePrivateEndpointConnection[];

  /**
   * State indicating whether staging environments are allowed or not allowed for a static web app.
   */
  stagingEnvironmentPolicy?: StagingEnvironmentPolicy;

  /**
   * <code>false</code> if config file is locked for this static web app; otherwise, <code>true</code>.
   */
  allowConfigFileUpdates?: boolean;

  /**
   * Template options for generating a new repository.
   */
  templateProperties?: StaticSiteTemplateOptions;

  /**
   * The content distribution endpoint for the static site.
   */
  @visibility(Lifecycle.Read)
  contentDistributionEndpoint?: string;

  /**
   * Identity to use for Key Vault Reference authentication.
   */
  @visibility(Lifecycle.Read)
  keyVaultReferenceIdentity?: string;

  /**
   * User provided function apps registered with the static site
   */
  @visibility(Lifecycle.Read)
  userProvidedFunctionApps?: StaticSiteUserProvidedFunctionApp[];

  /**
   * Backends linked to the static side
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  linkedBackends?: StaticSiteLinkedBackend[];

  /**
   * The provider that submitted the last deployment to the primary environment of the static site.
   */
  provider?: string;

  /**
   * State indicating the status of the enterprise grade CDN serving traffic to the static web app.
   */
  enterpriseGradeCdnStatus?: EnterpriseGradeCdnStatus;

  /**
   * State indicating whether public traffic are allowed or not for a static web app. Allowed Values: 'Enabled', 'Disabled' or an empty string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicNetworkAccess?: string;

  /**
   * Database connections for the static site
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  databaseConnections?: DatabaseConnectionOverview[];
}

/**
 * Message envelope that contains the common Azure resource manager properties and the resource provider specific content.
 */
model ResponseMessageEnvelopeRemotePrivateEndpointConnection {
  /**
   * Resource Id. Typically ID is populated only for responses to GET requests. Caller is responsible for passing in this
   * value for GET requests only.
   * For example: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupId}/providers/Microsoft.Web/sites/{sitename}
   */
  id?: string;

  /**
   * Name of resource.
   */
  name?: string;

  /**
   * Type of resource e.g "Microsoft.Web/sites".
   */
  type?: string;

  /**
   * Geographical region resource belongs to e.g. SouthCentralUS, SouthEastAsia.
   */
  location?: string;

  /**
   * Tags associated with resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Azure resource manager plan.
   */
  plan?: ArmPlan;

  /**
   * Resource specific properties.
   */
  properties?: RemotePrivateEndpointConnection;

  /**
   * SKU description of the resource.
   */
  sku?: SkuDescription;

  /**
   * Azure-AsyncOperation Status info.
   */
  status?: string;

  /**
   * Azure-AsyncOperation Error info.
   */
  error?: ErrorEntity;

  /**
   * MSI resource
   */
  identity?: ManagedServiceIdentity;

  /**
   * Logical Availability Zones the service is hosted in
   */
  zones?: string[];
}

/**
 * The plan object in Azure Resource Manager, represents a marketplace plan.
 */
model ArmPlan {
  /**
   * The name.
   */
  name?: string;

  /**
   * The publisher.
   */
  publisher?: string;

  /**
   * The product.
   */
  product?: string;

  /**
   * The promotion code.
   */
  promotionCode?: string;

  /**
   * Version of product.
   */
  version?: string;
}

/**
 * A remote private endpoint connection
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemotePrivateEndpointConnection extends ProxyOnlyResource {
  /**
   * RemotePrivateEndpointConnection resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: RemotePrivateEndpointConnectionProperties;
}

/**
 * RemotePrivateEndpointConnection resource specific properties
 */
model RemotePrivateEndpointConnectionProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * PrivateEndpoint of a remote private endpoint connection
   */
  privateEndpoint?: ArmIdWrapper;

  /**
   * The state of a private link connection
   */
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;

  /**
   * Private IPAddresses mapped to the remote private endpoint
   */
  ipAddresses?: string[];
}

/**
 * Template Options for the static site.
 */
model StaticSiteTemplateOptions {
  /**
   * URL of the template repository. The newly generated repository will be based on this one.
   */
  templateRepositoryUrl?: string;

  /**
   * Owner of the newly generated repository.
   */
  owner?: string;

  /**
   * Name of the newly generated repository.
   */
  repositoryName?: string;

  /**
   * Description of the newly generated repository.
   */
  description?: string;

  /**
   * Whether or not the newly generated repository is a private repository. Defaults to false (i.e. public).
   */
  isPrivate?: boolean;
}

/**
 * A static site user provided function.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteUserProvidedFunctionApp extends ProxyOnlyResource {
  /**
   * StaticSiteUserProvidedFunctionApp resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSiteUserProvidedFunctionAppProperties;
}

/**
 * StaticSiteUserProvidedFunctionApp resource specific properties
 */
model StaticSiteUserProvidedFunctionAppProperties {
  /**
   * The resource id of the function app registered with the static site
   */
  functionAppResourceId?: string;

  /**
   * The region of the function app registered with the static site
   */
  functionAppRegion?: string;

  /**
   * The date and time on which the function app was registered with the static site.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;
}

/**
 * Static Site Linked Backend ARM resource.
 */
model StaticSiteLinkedBackend {
  /**
   * The resource id of the backend linked to the static site
   */
  backendResourceId?: string;

  /**
   * The region of the backend linked to the static site
   */
  region?: string;

  /**
   * The date and time on which the backend was linked to the static site.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The provisioning state of the linking process.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Static Site Database Connection overview.
 */
model DatabaseConnectionOverview {
  /**
   * The resource id of the database.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * If present, the identity is used in conjunction with connection string to connect to the database. Use of the system-assigned managed identity is indicated with the string 'SystemAssigned', while use of a user-assigned managed identity is indicated with the resource id of the managed identity resource.
   */
  @visibility(Lifecycle.Read)
  connectionIdentity?: string;

  /**
   * The region of the database resource.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * A list of configuration files associated with this database connection.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["fileName"])
  configurationFiles?: StaticSiteDatabaseConnectionConfigurationFileOverview[];

  /**
   * If present, the name of this database connection resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * A database connection configuration file
 */
model StaticSiteDatabaseConnectionConfigurationFileOverview {
  /**
   * The name of the configuration file.
   */
  @visibility(Lifecycle.Read)
  fileName?: string;

  /**
   * The Base64 encoding of the file contents.
   */
  @visibility(Lifecycle.Read)
  contents?: string;

  /**
   * The type of configuration file.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * ARM resource for a static site when patching
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSitePatchResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSite;
}

/**
 * Collection of static site custom users.
 */
model StaticSiteUserCollection is Azure.Core.Page<StaticSiteUserARMResource>;

/**
 * Static Site User ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteUserARMResource extends ProxyOnlyResource {
  /**
   * StaticSiteUserARMResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSiteUserARMResourceProperties;
}

/**
 * StaticSiteUserARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteUserARMResourceProperties {
  /**
   * The identity provider for the static site user.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The user id for the static site user.
   */
  @visibility(Lifecycle.Read)
  userId?: string;

  /**
   * The display name for the static site user.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The roles for the static site user, in free-form string format
   */
  roles?: string;
}

/**
 * Collection of static site builds.
 */
model StaticSiteBuildCollection is Azure.Core.Page<StaticSiteBuildARMResource>;

/**
 * StaticSiteBuildARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteBuildARMResourceProperties {
  /**
   * An identifier for the static site build.
   */
  @visibility(Lifecycle.Read)
  buildId?: string;

  /**
   * The source branch.
   */
  @visibility(Lifecycle.Read)
  sourceBranch?: string;

  /**
   * The title of a pull request that a static site build is related to.
   */
  @visibility(Lifecycle.Read)
  pullRequestTitle?: string;

  /**
   * The hostname for a static site build.
   */
  @visibility(Lifecycle.Read)
  hostname?: string;

  /**
   * When this build was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  /**
   * When this build was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * The status of the static site build.
   */
  @visibility(Lifecycle.Read)
  status?: BuildStatus;

  /**
   * User provided function apps registered with the static site build
   */
  @visibility(Lifecycle.Read)
  userProvidedFunctionApps?: StaticSiteUserProvidedFunctionApp[];

  /**
   * Backends linked to the static side build
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  linkedBackends?: StaticSiteLinkedBackend[];

  /**
   * Database connections for the static site build
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  databaseConnections?: DatabaseConnectionOverview[];
}

/**
 * String dictionary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StringDictionary extends ProxyOnlyResource {
  /**
   * Settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<string>;
}

/**
 * Collection of static site database connections.
 */
model DatabaseConnectionCollection is Azure.Core.Page<DatabaseConnection>;

/**
 * DatabaseConnection resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseConnectionProperties {
  /**
   * The resource id of the database.
   */
  resourceId: string;

  /**
   * If present, the identity is used in conjunction with connection string to connect to the database. Use of the system-assigned managed identity is indicated with the string 'SystemAssigned', while use of a user-assigned managed identity is indicated with the resource id of the managed identity resource.
   */
  connectionIdentity?: string;

  /**
   * The connection string to use to connect to the database.
   */
  connectionString?: string;

  /**
   * The region of the database resource.
   */
  region: string;

  /**
   * A list of configuration files associated with this database connection.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["fileName"])
  configurationFiles?: StaticSiteDatabaseConnectionConfigurationFileOverview[];
}

/**
 * Static Site Database Connection Request Properties resource when patching
 */
model DatabaseConnectionPatchRequest {
  /**
   * DatabaseConnectionPatchRequest resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: DatabaseConnectionPatchRequestProperties;
}

/**
 * DatabaseConnectionPatchRequest resource specific properties
 */
model DatabaseConnectionPatchRequestProperties {
  /**
   * The resource id of the database.
   */
  resourceId?: string;

  /**
   * If present, the identity is used in conjunction with connection string to connect to the database. Use of the system-assigned managed identity is indicated with the string 'SystemAssigned', while use of a user-assigned managed identity is indicated with the resource id of the managed identity resource.
   */
  connectionIdentity?: string;

  /**
   * The connection string to use to connect to the database.
   */
  connectionString?: string;

  /**
   * The region of the database resource.
   */
  region?: string;
}

/**
 * Collection of static site functions.
 */
model StaticSiteFunctionOverviewCollection
  is Azure.Core.Page<StaticSiteFunctionOverviewARMResource>;

/**
 * Static Site Function Overview ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteFunctionOverviewARMResource extends ProxyOnlyResource {
  /**
   * StaticSiteFunctionOverviewARMResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSiteFunctionOverviewARMResourceProperties;
}

/**
 * StaticSiteFunctionOverviewARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteFunctionOverviewARMResourceProperties {
  /**
   * The name for the function
   */
  @visibility(Lifecycle.Read)
  functionName?: string;

  /**
   * The trigger type of the function
   */
  @visibility(Lifecycle.Read)
  triggerType?: TriggerTypes;
}

/**
 * Collection of static site user provided function apps.
 */
model StaticSiteUserProvidedFunctionAppsCollection
  is Azure.Core.Page<StaticSiteUserProvidedFunctionAppARMResource>;

/**
 * StaticSiteUserProvidedFunctionAppARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteUserProvidedFunctionAppARMResourceProperties {
  /**
   * The resource id of the function app registered with the static site
   */
  functionAppResourceId?: string;

  /**
   * The region of the function app registered with the static site
   */
  functionAppRegion?: string;

  /**
   * The date and time on which the function app was registered with the static site.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;
}

/**
 * Static site zip deployment ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteZipDeploymentARMResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSiteZipDeployment;
}

/**
 * A static site zip deployment.
 */
model StaticSiteZipDeployment {
  /**
   * URL for the zipped app content
   */
  appZipUrl?: string;

  /**
   * URL for the zipped api content
   */
  apiZipUrl?: string;

  /**
   * A title to label the deployment
   */
  deploymentTitle?: string;

  /**
   * The provider submitting this deployment
   */
  provider?: string;

  /**
   * The language of the api content, if it exists
   */
  functionLanguage?: string;
}

/**
 * Collection of static site basic auth.
 */
model StaticSiteBasicAuthPropertiesCollection
  is Azure.Core.Page<StaticSiteBasicAuthPropertiesARMResource>;

/**
 * StaticSiteBasicAuthPropertiesARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteBasicAuthPropertiesARMResourceProperties {
  /**
   * The password for basic auth.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password?: string;

  /**
   * Url to the secret in Key Vault.
   */
  secretUrl?: string;

  /**
   * State indicating if basic auth is enabled and for what environments it is active.
   */
  applicableEnvironmentsMode: string;

  /**
   * The list of enabled environments for Basic Auth if ApplicableEnvironmentsMode is set to SpecifiedEnvironments.
   */
  environments?: string[];

  /**
   * State indicating if basic auth has a secret and what type it is.
   */
  @visibility(Lifecycle.Read)
  secretState?: string;
}

/**
 * Static sites user roles invitation resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteUserInvitationRequestResource extends ProxyOnlyResource {
  /**
   * StaticSiteUserInvitationRequestResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSiteUserInvitationRequestResourceProperties;
}

/**
 * StaticSiteUserInvitationRequestResource resource specific properties
 */
model StaticSiteUserInvitationRequestResourceProperties {
  /**
   * The domain name for the static site custom domain.
   */
  domain?: string;

  /**
   * The identity provider for the static site user.
   */
  provider?: string;

  /**
   * The user id for the static site user.
   */
  userDetails?: string;

  /**
   * The roles for the static site user, in free-form string format
   */
  roles?: string;

  /**
   * The number of hours the sas token stays valid
   */
  numHoursToExpiration?: int32;
}

/**
 * Static sites user roles invitation link resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteUserInvitationResponseResource extends ProxyOnlyResource {
  /**
   * StaticSiteUserInvitationResponseResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSiteUserInvitationResponseResourceProperties;
}

/**
 * StaticSiteUserInvitationResponseResource resource specific properties
 */
model StaticSiteUserInvitationResponseResourceProperties {
  /**
   * The expiration time of the invitation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresOn?: utcDateTime;

  /**
   * The url for the invitation link
   */
  @visibility(Lifecycle.Read)
  invitationUrl?: string;
}

/**
 * Collection of static site custom domains.
 */
model StaticSiteCustomDomainOverviewCollection
  is Azure.Core.Page<StaticSiteCustomDomainOverviewARMResource>;

/**
 * StaticSiteCustomDomainOverviewARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteCustomDomainOverviewARMResourceProperties {
  /**
   * The domain name for the static site custom domain.
   */
  @visibility(Lifecycle.Read)
  domainName?: string;

  /**
   * The date and time on which the custom domain was created for the static site.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The status of the custom domain
   */
  @visibility(Lifecycle.Read)
  status?: CustomDomainStatus;

  /**
   * The TXT record validation token
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  validationToken?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * Static Site Custom Domain Request Properties ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteCustomDomainRequestPropertiesARMResource
  extends ProxyOnlyResource {
  /**
   * StaticSiteCustomDomainRequestPropertiesARMResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSiteCustomDomainRequestPropertiesARMResourceProperties;
}

/**
 * StaticSiteCustomDomainRequestPropertiesARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteCustomDomainRequestPropertiesARMResourceProperties {
  /**
   * Validation method for adding a custom domain
   */
  validationMethod?: string = "cname-delegation";
}

/**
 * String list resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StringList extends ProxyOnlyResource {
  /**
   * List of string resources.
   */
  properties?: string[];
}

/**
 * Static Site Reset Properties ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteResetPropertiesARMResource extends ProxyOnlyResource {
  /**
   * StaticSiteResetPropertiesARMResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StaticSiteResetPropertiesARMResourceProperties;
}

/**
 * StaticSiteResetPropertiesARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteResetPropertiesARMResourceProperties {
  /**
   * The token which proves admin privileges to the repository.
   */
  repositoryToken?: string;

  /**
   * Determines whether the repository should be updated with the new properties.
   */
  shouldUpdateRepository?: boolean;
}

/**
 * StaticSiteLinkedBackendARMResource resource specific properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticSiteLinkedBackendARMResourceProperties {
  /**
   * The resource id of the backend linked to the static site
   */
  backendResourceId?: string;

  /**
   * The region of the backend linked to the static site
   */
  region?: string;

  /**
   * The date and time on which the backend was linked to the static site.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The provisioning state of the linking process.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Collection of static site linked backends.
 */
model StaticSiteLinkedBackendsCollection
  is Azure.Core.Page<StaticSiteLinkedBackendARMResource>;

/**
 * ARM resource for a site.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SitePatchResource extends ProxyOnlyResource {
  /**
   * SitePatchResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SitePatchResourceProperties;

  /**
   * Managed service identity.
   */
  identity?: ManagedServiceIdentity;
}

/**
 * SitePatchResource resource specific properties
 */
model SitePatchResourceProperties {
  /**
   * Current state of the app.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * Hostnames associated with the app.
   */
  @visibility(Lifecycle.Read)
  hostNames?: string[];

  /**
   * Name of the repository site.
   */
  @visibility(Lifecycle.Read)
  repositorySiteName?: string;

  /**
   * State indicating whether the app has exceeded its quota usage. Read-only.
   */
  @visibility(Lifecycle.Read)
  usageState?: UsageState;

  /**
   * <code>true</code> if the app is enabled; otherwise, <code>false</code>. Setting this value to false disables the app (takes the app offline).
   */
  enabled?: boolean;

  /**
   * Enabled hostnames for the app.Hostnames need to be assigned (see HostNames) AND enabled. Otherwise,
   * the app is not served on those hostnames.
   */
  @visibility(Lifecycle.Read)
  enabledHostNames?: string[];

  /**
   * Management information availability state for the app.
   */
  @visibility(Lifecycle.Read)
  availabilityState?: SiteAvailabilityState;

  /**
   * Hostname SSL states are used to manage the SSL bindings for app's hostnames.
   */
  @identifiers(#["name"])
  hostNameSslStates?: HostNameSslState[];

  /**
   * Resource ID of the associated App Service plan, formatted as: "/subscriptions/{subscriptionID}/resourceGroups/{groupName}/providers/Microsoft.Web/serverfarms/{appServicePlanName}".
   */
  serverFarmId?: string;

  /**
   * <code>true</code> if reserved; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  reserved?: boolean = false;

  /**
   * Obsolete: Hyper-V sandbox.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isXenon?: boolean = false;

  /**
   * Hyper-V sandbox.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hyperV?: boolean = false;

  /**
   * Last time the app was modified, in UTC. Read-only.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  /**
   * Property to configure various DNS related settings for a site.
   */
  dnsConfiguration?: SiteDnsConfig;

  /**
   * Configuration of the app.
   */
  siteConfig?: SiteConfig;

  /**
   * Azure Traffic Manager hostnames associated with the app. Read-only.
   */
  @visibility(Lifecycle.Read)
  trafficManagerHostNames?: string[];

  /**
   * <code>true</code> to stop SCM (KUDU) site when the app is stopped; otherwise, <code>false</code>. The default is <code>false</code>.
   */
  scmSiteAlsoStopped?: boolean = false;

  /**
   * Specifies which deployment slot this app will swap into. Read-only.
   */
  @visibility(Lifecycle.Read)
  targetSwapSlot?: string;

  /**
   * App Service Environment to use for the app.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * <code>true</code> to enable client affinity; <code>false</code> to stop sending session affinity cookies, which route client requests in the same session to the same instance. Default is <code>true</code>.
   */
  clientAffinityEnabled?: boolean;

  /**
   * <code>true</code> to override client affinity cookie domain with X-Forwarded-Host request header. <code>false</code> to use default domain. Default is <code>false</code>.
   */
  clientAffinityProxyEnabled?: boolean;

  /**
   * <code>true</code> to enable client certificate authentication (TLS mutual authentication); otherwise, <code>false</code>. Default is <code>false</code>.
   */
  clientCertEnabled?: boolean;

  /**
   * This composes with ClientCertEnabled setting.
   * - ClientCertEnabled: false means ClientCert is ignored.
   * - ClientCertEnabled: true and ClientCertMode: Required means ClientCert is required.
   * - ClientCertEnabled: true and ClientCertMode: Optional means ClientCert is optional or accepted.
   */
  clientCertMode?: ClientCertMode;

  /**
   * client certificate authentication comma-separated exclusion paths
   */
  clientCertExclusionPaths?: string;

  /**
   * <code>true</code> to disable the public hostnames of the app; otherwise, <code>false</code>.\n If <code>true</code>, the app is only accessible via API management process.
   */
  hostNamesDisabled?: boolean;

  /**
   * Unique identifier that verifies the custom domains assigned to the app. Customer will add this id to a txt record for verification.
   */
  customDomainVerificationId?: string;

  /**
   * List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from tenants that site can be hosted with current settings. Read-only.
   */
  @visibility(Lifecycle.Read)
  outboundIpAddresses?: string;

  /**
   * List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from all tenants except dataComponent. Read-only.
   */
  @visibility(Lifecycle.Read)
  possibleOutboundIpAddresses?: string;

  /**
   * Size of the function container.
   */
  containerSize?: int32;

  /**
   * Maximum allowed daily memory-time quota (applicable on dynamic apps only).
   */
  dailyMemoryTimeQuota?: int32;

  /**
   * App suspended till in case memory-time quota is exceeded.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspendedTill?: utcDateTime;

  /**
   * Maximum number of workers.
   * This only applies to Functions container.
   */
  @visibility(Lifecycle.Read)
  maxNumberOfWorkers?: int32;

  /**
   * If specified during app creation, the app is cloned from a source app.
   */
  @visibility(Lifecycle.Create)
  cloningInfo?: CloningInfo;

  /**
   * Name of the resource group the app belongs to. Read-only.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * <code>true</code> if the app is a default container; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isDefaultContainer?: boolean;

  /**
   * Default hostname of the app. Read-only.
   */
  @visibility(Lifecycle.Read)
  defaultHostName?: string;

  /**
   * Status of the last deployment slot swap operation.
   */
  @visibility(Lifecycle.Read)
  slotSwapStatus?: SlotSwapStatus;

  /**
   * HttpsOnly: configures a web site to accept only https requests. Issues redirect for
   * http requests
   */
  httpsOnly?: boolean;

  /**
   * Site redundancy mode
   */
  redundancyMode?: RedundancyMode;

  /**
   * Specifies an operation id if this site has a pending operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  inProgressOperationId?: string;

  /**
   * Property to allow or block all public traffic. Allowed Values: 'Enabled', 'Disabled' or an empty string.
   */
  publicNetworkAccess?: string;

  /**
   * Checks if Customer provided storage account is required
   */
  storageAccountRequired?: boolean;

  /**
   * Identity to use for Key Vault Reference authentication.
   */
  keyVaultReferenceIdentity?: string;

  /**
   * Azure Resource Manager ID of the Virtual network and subnet to be joined by Regional VNET Integration.
   * This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}
   */
  virtualNetworkSubnetId?: string;
}

/**
 * Custom domain analysis.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CustomHostnameAnalysisResult extends ProxyOnlyResource {
  /**
   * CustomHostnameAnalysisResult resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: CustomHostnameAnalysisResultProperties;
}

/**
 * CustomHostnameAnalysisResult resource specific properties
 */
model CustomHostnameAnalysisResultProperties {
  /**
   * <code>true</code> if hostname is already verified; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isHostnameAlreadyVerified?: boolean;

  /**
   * DNS verification test result.
   */
  @visibility(Lifecycle.Read)
  customDomainVerificationTest?: DnsVerificationTestResult;

  /**
   * Raw failure information if DNS verification fails.
   */
  @visibility(Lifecycle.Read)
  customDomainVerificationFailureInfo?: ErrorEntity;

  /**
   * <code>true</code> if there is a conflict on a scale unit; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  hasConflictOnScaleUnit?: boolean;

  /**
   * <code>true</code> if there is a conflict across subscriptions; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  hasConflictAcrossSubscription?: boolean;

  /**
   * Name of the conflicting app on scale unit if it's within the same subscription.
   */
  @visibility(Lifecycle.Read)
  conflictingAppResourceId?: string;

  /**
   * CName records controller can see for this hostname.
   */
  cNameRecords?: string[];

  /**
   * TXT records controller can see for this hostname.
   */
  txtRecords?: string[];

  /**
   * A records controller can see for this hostname.
   */
  aRecords?: string[];

  /**
   * Alternate CName records controller can see for this hostname.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alternateCNameRecords?: string[];

  /**
   * Alternate TXT records controller can see for this hostname.
   */
  alternateTxtRecords?: string[];
}

/**
 * Deployment slot parameters.
 */
model CsmSlotEntity {
  /**
   * Destination deployment slot during swap operation.
   */
  targetSlot: string;

  /**
   * <code>true</code> to preserve Virtual Network to the slot during swap; otherwise, <code>false</code>.
   */
  preserveVnet: boolean;
}

/**
 * Description of a backup which will be performed.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupRequest extends ProxyOnlyResource {
  /**
   * BackupRequest resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BackupRequestProperties;
}

/**
 * BackupRequest resource specific properties
 */
model BackupRequestProperties {
  /**
   * Name of the backup.
   */
  backupName?: string;

  /**
   * True if the backup schedule is enabled (must be included in that case), false if the backup schedule should be disabled.
   */
  enabled?: boolean;

  /**
   * SAS URL to the container.
   */
  storageAccountUrl: string;

  /**
   * Schedule for the backup if it is executed periodically.
   */
  backupSchedule?: BackupSchedule;

  /**
   * Databases included in the backup.
   */
  @identifiers(#["name"])
  databases?: DatabaseBackupSetting[];
}

/**
 * Description of a backup schedule. Describes how often should be the backup performed and what should be the retention policy.
 */
model BackupSchedule {
  /**
   * How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and FrequencyUnit should be set to Day)
   */
  frequencyInterval: int32 = 7;

  /**
   * The unit of time for how often the backup should be executed (e.g. for weekly backup, this should be set to Day and FrequencyInterval should be set to 7)
   */
  frequencyUnit: FrequencyUnit = FrequencyUnit.Day;

  /**
   * True if the retention policy should always keep at least one backup in the storage account, regardless how old it is; false otherwise.
   */
  keepAtLeastOneBackup: boolean = true;

  /**
   * After how many days backups should be deleted.
   */
  retentionPeriodInDays: int32 = 30;

  /**
   * When the schedule should start working.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Last time when this schedule was triggered.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutionTime?: utcDateTime;
}

/**
 * Database backup settings.
 */
model DatabaseBackupSetting {
  /**
   * Database type (e.g. SqlAzure / MySql).
   */
  databaseType: DatabaseType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;

  /**
   * Contains a connection string name that is linked to the SiteConfig.ConnectionStrings.
   * This is used during restore with overwrite connection strings options.
   */
  connectionStringName?: string;

  /**
   * Contains a connection string to a database which is being backed up or restored. If the restore should happen to a new database, the database name inside is the new one.
   */
  connectionString?: string;
}

/**
 * BackupItem resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupItemProperties {
  /**
   * Id of the backup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: int32;

  /**
   * SAS URL for the storage account container which contains this backup.
   */
  @visibility(Lifecycle.Read)
  storageAccountUrl?: string;

  /**
   * Name of the blob which contains data for this backup.
   */
  @visibility(Lifecycle.Read)
  blobName?: string;

  /**
   * Name of this backup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Backup status.
   */
  @visibility(Lifecycle.Read)
  status?: BackupItemStatus;

  /**
   * Size of the backup in bytes.
   */
  @visibility(Lifecycle.Read)
  sizeInBytes?: int64;

  /**
   * Timestamp of the backup creation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Details regarding this backup. Might contain an error message.
   */
  @visibility(Lifecycle.Read)
  log?: string;

  /**
   * List of databases included in the backup.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  databases?: DatabaseBackupSetting[];

  /**
   * True if this backup has been created due to a schedule being triggered.
   */
  @visibility(Lifecycle.Read)
  scheduled?: boolean;

  /**
   * Timestamp of a last restore operation which used this backup.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRestoreTimeStamp?: utcDateTime;

  /**
   * Timestamp when this backup finished.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishedTimeStamp?: utcDateTime;

  /**
   * Unique correlation identifier. Please use this along with the timestamp while communicating with Azure support.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * Size of the original web app which has been backed up.
   */
  @visibility(Lifecycle.Read)
  websiteSizeInBytes?: int64;
}

/**
 * Collection of backup items.
 */
model BackupItemCollection is Azure.Core.Page<BackupItem>;

/**
 * Description of a restore request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestoreRequest extends ProxyOnlyResource {
  /**
   * RestoreRequest resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: RestoreRequestProperties;
}

/**
 * RestoreRequest resource specific properties
 */
model RestoreRequestProperties {
  /**
   * SAS URL to the container.
   */
  storageAccountUrl: string;

  /**
   * Name of a blob which contains the backup.
   */
  blobName?: string;

  /**
   * <code>true</code> if the restore operation can overwrite target app; otherwise, <code>false</code>. <code>true</code> is needed if trying to restore over an existing app.
   */
  overwrite: boolean;

  /**
   * Name of an app.
   */
  siteName?: string;

  /**
   * Collection of databases which should be restored. This list has to match the list of databases included in the backup.
   */
  @identifiers(#["name"])
  databases?: DatabaseBackupSetting[];

  /**
   * Changes a logic when restoring an app with custom domains. <code>true</code> to remove custom domains automatically. If <code>false</code>, custom domains are added to \nthe app's object when it is being restored, but that might fail due to conflicts during the operation.
   */
  ignoreConflictingHostNames?: boolean = false;

  /**
   * Ignore the databases and only restore the site content
   */
  ignoreDatabases?: boolean = false;

  /**
   * Specify app service plan that will own restored site.
   */
  appServicePlan?: string;

  /**
   * Operation type.
   */
  operationType?: BackupRestoreOperationType = BackupRestoreOperationType.Default;

  /**
   * <code>true</code> if SiteConfig.ConnectionStrings should be set in new app; otherwise, <code>false</code>.
   */
  adjustConnectionStrings?: boolean;

  /**
   * App Service Environment name, if needed (only when restoring an app to an App Service Environment).
   */
  hostingEnvironment?: string;
}

/**
 * Publishing Credentials Policies entity collection ARM resource.
 */
model PublishingCredentialsPoliciesCollection
  is Azure.Core.Page<CsmPublishingCredentialsPoliciesEntity>;

/**
 * CsmPublishingCredentialsPoliciesEntity resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CsmPublishingCredentialsPoliciesEntityProperties {
  /**
   * <code>true</code> to allow access to a publishing method; otherwise, <code>false</code>.
   */
  allow: boolean;
}

/**
 * Collection of site configurations.
 */
model SiteConfigResourceCollection is Azure.Core.Page<SiteConfigResource>;

/**
 * Configuration settings for the Azure App Service Authentication / Authorization feature.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteAuthSettings extends ProxyOnlyResource {
  /**
   * SiteAuthSettings resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SiteAuthSettingsProperties;
}

/**
 * SiteAuthSettings resource specific properties
 */
model SiteAuthSettingsProperties {
  /**
   * <code>true</code> if the Authentication / Authorization feature is enabled for the current app; otherwise, <code>false</code>.
   */
  enabled?: boolean;

  /**
   * The RuntimeVersion of the Authentication / Authorization feature in use for the current app.
   * The setting in this value can control the behavior of certain features in the Authentication / Authorization module.
   */
  runtimeVersion?: string;

  /**
   * The action to take when an unauthenticated client attempts to access the app.
   */
  unauthenticatedClientAction?: UnauthenticatedClientAction;

  /**
   * <code>true</code> to durably store platform-specific security tokens that are obtained during login flows; otherwise, <code>false</code>.
   *  The default is <code>false</code>.
   */
  tokenStoreEnabled?: boolean;

  /**
   * External URLs that can be redirected to as part of logging in or logging out of the app. Note that the query string part of the URL is ignored.
   * This is an advanced setting typically only needed by Windows Store application backends.
   * Note that URLs within the current domain are always implicitly allowed.
   */
  allowedExternalRedirectUrls?: string[];

  /**
   * The default authentication provider to use when multiple providers are configured.
   * This setting is only needed if multiple providers are configured and the unauthenticated client
   * action is set to "RedirectToLoginPage".
   */
  defaultProvider?: BuiltInAuthenticationProvider;

  /**
   * The number of hours after session token expiration that a session token can be used to
   * call the token refresh API. The default is 72 hours.
   */
  tokenRefreshExtensionHours?: float64;

  /**
   * The Client ID of this relying party application, known as the client_id.
   * This setting is required for enabling OpenID Connection authentication with Azure Active Directory or
   * other 3rd party OpenID Connect providers.
   * More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
   */
  clientId?: string;

  /**
   * The Client Secret of this relying party application (in Azure Active Directory, this is also referred to as the Key).
   * This setting is optional. If no client secret is configured, the OpenID Connect implicit auth flow is used to authenticate end users.
   * Otherwise, the OpenID Connect Authorization Code Flow is used to authenticate end users.
   * More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientSecret?: string;

  /**
   * The app setting name that contains the client secret of the relying party application.
   */
  clientSecretSettingName?: string;

  /**
   * An alternative to the client secret, that is the thumbprint of a certificate used for signing purposes. This property acts as
   * a replacement for the Client Secret. It is also optional.
   */
  clientSecretCertificateThumbprint?: string;

  /**
   * The OpenID Connect Issuer URI that represents the entity which issues access tokens for this application.
   * When using Azure Active Directory, this value is the URI of the directory tenant, e.g. `https://sts.windows.net/{tenant-guid}/`.
   * This URI is a case-sensitive identifier for the token issuer.
   * More information on OpenID Connect Discovery: http://openid.net/specs/openid-connect-discovery-1_0.html
   */
  issuer?: string;

  /**
   * Gets a value indicating whether the issuer should be a valid HTTPS url and be validated as such.
   */
  validateIssuer?: boolean;

  /**
   * Allowed audience values to consider when validating JSON Web Tokens issued by
   * Azure Active Directory. Note that the <code>ClientID</code> value is always considered an
   * allowed audience, regardless of this setting.
   */
  allowedAudiences?: string[];

  /**
   * Login parameters to send to the OpenID Connect authorization endpoint when
   * a user logs in. Each parameter must be in the form "key=value".
   */
  additionalLoginParams?: string[];

  /**
   * Gets a JSON string containing the Azure AD Acl settings.
   */
  aadClaimsAuthorization?: string;

  /**
   * The OpenID Connect Client ID for the Google web application.
   * This setting is required for enabling Google Sign-In.
   * Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
   */
  googleClientId?: string;

  /**
   * The client secret associated with the Google web application.
   * This setting is required for enabling Google Sign-In.
   * Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  googleClientSecret?: string;

  /**
   * The app setting name that contains the client secret associated with
   * the Google web application.
   */
  googleClientSecretSettingName?: string;

  /**
   * The OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication.
   * This setting is optional. If not specified, "openid", "profile", and "email" are used as default scopes.
   * Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  googleOAuthScopes?: string[];

  /**
   * The App ID of the Facebook app used for login.
   * This setting is required for enabling Facebook Login.
   * Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
   */
  facebookAppId?: string;

  /**
   * The App Secret of the Facebook app used for Facebook Login.
   * This setting is required for enabling Facebook Login.
   * Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  facebookAppSecret?: string;

  /**
   * The app setting name that contains the app secret used for Facebook Login.
   */
  facebookAppSecretSettingName?: string;

  /**
   * The OAuth 2.0 scopes that will be requested as part of Facebook Login authentication.
   * This setting is optional.
   * Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  facebookOAuthScopes?: string[];

  /**
   * The Client Id of the GitHub app used for login.
   * This setting is required for enabling Github login
   */
  gitHubClientId?: string;

  /**
   * The Client Secret of the GitHub app used for Github Login.
   * This setting is required for enabling Github login.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  gitHubClientSecret?: string;

  /**
   * The app setting name that contains the client secret of the Github
   * app used for GitHub Login.
   */
  gitHubClientSecretSettingName?: string;

  /**
   * The OAuth 2.0 scopes that will be requested as part of GitHub Login authentication.
   * This setting is optional
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  gitHubOAuthScopes?: string[];

  /**
   * The OAuth 1.0a consumer key of the Twitter application used for sign-in.
   * This setting is required for enabling Twitter Sign-In.
   * Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  twitterConsumerKey?: string;

  /**
   * The OAuth 1.0a consumer secret of the Twitter application used for sign-in.
   * This setting is required for enabling Twitter Sign-In.
   * Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  twitterConsumerSecret?: string;

  /**
   * The app setting name that contains the OAuth 1.0a consumer secret of the Twitter
   * application used for sign-in.
   */
  twitterConsumerSecretSettingName?: string;

  /**
   * The OAuth 2.0 client ID that was created for the app used for authentication.
   * This setting is required for enabling Microsoft Account authentication.
   * Microsoft Account OAuth documentation: https://dev.onedrive.com/auth/msa_oauth.htm
   */
  microsoftAccountClientId?: string;

  /**
   * The OAuth 2.0 client secret that was created for the app used for authentication.
   * This setting is required for enabling Microsoft Account authentication.
   * Microsoft Account OAuth documentation: https://dev.onedrive.com/auth/msa_oauth.htm
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  microsoftAccountClientSecret?: string;

  /**
   * The app setting name containing the OAuth 2.0 client secret that was created for the
   * app used for authentication.
   */
  microsoftAccountClientSecretSettingName?: string;

  /**
   * The OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication.
   * This setting is optional. If not specified, "wl.basic" is used as the default scope.
   * Microsoft Account Scopes and permissions documentation: https://msdn.microsoft.com/en-us/library/dn631845.aspx
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  microsoftAccountOAuthScopes?: string[];

  /**
   * "true" if the auth config settings should be read from a file,
   * "false" otherwise
   */
  isAuthFromFile?: string;

  /**
   * The path of the config file containing auth settings.
   * If the path is relative, base will the site's root directory.
   */
  authFilePath?: string;

  /**
   * The ConfigVersion of the Authentication / Authorization feature in use for the current app.
   * The setting in this value can control the behavior of the control plane for Authentication / Authorization.
   */
  configVersion?: string;
}

/**
 * SiteAuthSettingsV2 resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteAuthSettingsV2Properties {
  /**
   * The configuration settings of the platform of App Service Authentication/Authorization.
   */
  platform?: AuthPlatform;

  /**
   * The configuration settings that determines the validation flow of users using App Service Authentication/Authorization.
   */
  globalValidation?: GlobalValidation;

  /**
   * The configuration settings of each of the identity providers used to configure App Service Authentication/Authorization.
   */
  identityProviders?: IdentityProviders;

  /**
   * The configuration settings of the login flow of users using App Service Authentication/Authorization.
   */
  login?: Login;

  /**
   * The configuration settings of the HTTP requests for authentication and authorization requests made against App Service Authentication/Authorization.
   */
  httpSettings?: HttpSettings;
}

/**
 * The configuration settings of the platform of App Service Authentication/Authorization.
 */
model AuthPlatform {
  /**
   * <code>true</code> if the Authentication / Authorization feature is enabled for the current app; otherwise, <code>false</code>.
   */
  enabled?: boolean;

  /**
   * The RuntimeVersion of the Authentication / Authorization feature in use for the current app.
   * The setting in this value can control the behavior of certain features in the Authentication / Authorization module.
   */
  runtimeVersion?: string;

  /**
   * The path of the config file containing auth settings if they come from a file.
   * If the path is relative, base will the site's root directory.
   */
  configFilePath?: string;
}

/**
 * The configuration settings that determines the validation flow of users using App Service Authentication/Authorization.
 */
model GlobalValidation {
  /**
   * <code>true</code> if the authentication flow is required any request is made; otherwise, <code>false</code>.
   */
  requireAuthentication?: boolean;

  /**
   * The action to take when an unauthenticated client attempts to access the app.
   */
  unauthenticatedClientAction?: UnauthenticatedClientActionV2;

  /**
   * The default authentication provider to use when multiple providers are configured.
   * This setting is only needed if multiple providers are configured and the unauthenticated client
   * action is set to "RedirectToLoginPage".
   */
  redirectToProvider?: string;

  /**
   * The paths for which unauthenticated flow would not be redirected to the login page.
   */
  excludedPaths?: string[];
}

/**
 * The configuration settings of each of the identity providers used to configure App Service Authentication/Authorization.
 */
model IdentityProviders {
  /**
   * The configuration settings of the Azure Active directory provider.
   */
  azureActiveDirectory?: AzureActiveDirectory;

  /**
   * The configuration settings of the Facebook provider.
   */
  facebook?: Facebook;

  /**
   * The configuration settings of the GitHub provider.
   */
  gitHub?: GitHub;

  /**
   * The configuration settings of the Google provider.
   */
  google?: Google;

  /**
   * The configuration settings of the legacy Microsoft Account provider.
   */
  legacyMicrosoftAccount?: LegacyMicrosoftAccount;

  /**
   * The configuration settings of the Twitter provider.
   */
  twitter?: Twitter;

  /**
   * The configuration settings of the Apple provider.
   */
  apple?: Apple;

  /**
   * The configuration settings of the Azure Static Web Apps provider.
   */
  azureStaticWebApps?: AzureStaticWebApps;

  /**
   * The map of the name of the alias of each custom Open ID Connect provider to the
   * configuration settings of the custom Open ID Connect provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customOpenIdConnectProviders?: Record<CustomOpenIdConnectProvider>;
}

/**
 * The configuration settings of the Azure Active directory provider.
 */
model AzureActiveDirectory {
  /**
   * <code>false</code> if the Azure Active Directory provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the Azure Active Directory app registration.
   */
  registration?: AzureActiveDirectoryRegistration;

  /**
   * The configuration settings of the Azure Active Directory login flow.
   */
  login?: AzureActiveDirectoryLogin;

  /**
   * The configuration settings of the Azure Active Directory token validation flow.
   */
  validation?: AzureActiveDirectoryValidation;

  /**
   * Gets a value indicating whether the Azure AD configuration was auto-provisioned using 1st party tooling.
   * This is an internal flag primarily intended to support the Azure Management Portal. Users should not
   * read or write to this property.
   */
  isAutoProvisioned?: boolean;
}

/**
 * The configuration settings of the Azure Active Directory app registration.
 */
model AzureActiveDirectoryRegistration {
  /**
   * The OpenID Connect Issuer URI that represents the entity which issues access tokens for this application.
   * When using Azure Active Directory, this value is the URI of the directory tenant, e.g. `https://login.microsoftonline.com/v2.0/{tenant-guid}/`.
   * This URI is a case-sensitive identifier for the token issuer.
   * More information on OpenID Connect Discovery: http://openid.net/specs/openid-connect-discovery-1_0.html
   */
  openIdIssuer?: string;

  /**
   * The Client ID of this relying party application, known as the client_id.
   * This setting is required for enabling OpenID Connection authentication with Azure Active Directory or
   * other 3rd party OpenID Connect providers.
   * More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
   */
  clientId?: string;

  /**
   * The app setting name that contains the client secret of the relying party application.
   */
  clientSecretSettingName?: string;

  /**
   * An alternative to the client secret, that is the thumbprint of a certificate used for signing purposes. This property acts as
   * a replacement for the Client Secret. It is also optional.
   */
  clientSecretCertificateThumbprint?: string;

  /**
   * An alternative to the client secret thumbprint, that is the subject alternative name of a certificate used for signing purposes. This property acts as
   * a replacement for the Client Secret Certificate Thumbprint. It is also optional.
   */
  clientSecretCertificateSubjectAlternativeName?: string;

  /**
   * An alternative to the client secret thumbprint, that is the issuer of a certificate used for signing purposes. This property acts as
   * a replacement for the Client Secret Certificate Thumbprint. It is also optional.
   */
  clientSecretCertificateIssuer?: string;
}

/**
 * The configuration settings of the Azure Active Directory login flow.
 */
model AzureActiveDirectoryLogin {
  /**
   * Login parameters to send to the OpenID Connect authorization endpoint when
   * a user logs in. Each parameter must be in the form "key=value".
   */
  loginParameters?: string[];

  /**
   * <code>true</code> if the www-authenticate provider should be omitted from the request; otherwise, <code>false</code>.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableWWWAuthenticate?: boolean;
}

/**
 * The configuration settings of the Azure Active Directory token validation flow.
 */
model AzureActiveDirectoryValidation {
  /**
   * The configuration settings of the checks that should be made while validating the JWT Claims.
   */
  jwtClaimChecks?: JwtClaimChecks;

  /**
   * The list of audiences that can make successful authentication/authorization requests.
   */
  allowedAudiences?: string[];

  /**
   * The configuration settings of the default authorization policy.
   */
  defaultAuthorizationPolicy?: DefaultAuthorizationPolicy;
}

/**
 * The configuration settings of the checks that should be made while validating the JWT Claims.
 */
model JwtClaimChecks {
  /**
   * The list of the allowed groups.
   */
  allowedGroups?: string[];

  /**
   * The list of the allowed client applications.
   */
  allowedClientApplications?: string[];
}

/**
 * The configuration settings of the Azure Active Directory default authorization policy.
 */
model DefaultAuthorizationPolicy {
  /**
   * The configuration settings of the Azure Active Directory allowed principals.
   */
  allowedPrincipals?: AllowedPrincipals;

  /**
   * The configuration settings of the Azure Active Directory allowed applications.
   */
  allowedApplications?: string[];
}

/**
 * The configuration settings of the Azure Active Directory allowed principals.
 */
model AllowedPrincipals {
  /**
   * The list of the allowed groups.
   */
  groups?: string[];

  /**
   * The list of the allowed identities.
   */
  identities?: string[];
}

/**
 * The configuration settings of the Facebook provider.
 */
model Facebook {
  /**
   * <code>false</code> if the Facebook provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the app registration for the Facebook provider.
   */
  registration?: AppRegistration;

  /**
   * The version of the Facebook api to be used while logging in.
   */
  graphApiVersion?: string;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;
}

/**
 * The configuration settings of the app registration for providers that have app ids and app secrets
 */
model AppRegistration {
  /**
   * The App ID of the app used for login.
   */
  appId?: string;

  /**
   * The app setting name that contains the app secret.
   */
  appSecretSettingName?: string;
}

/**
 * The configuration settings of the login flow, including the scopes that should be requested.
 */
model LoginScopes {
  /**
   * A list of the scopes that should be requested while authenticating.
   */
  scopes?: string[];
}

/**
 * The configuration settings of the GitHub provider.
 */
model GitHub {
  /**
   * <code>false</code> if the GitHub provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the app registration for the GitHub provider.
   */
  registration?: ClientRegistration;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;
}

/**
 * The configuration settings of the app registration for providers that have client ids and client secrets
 */
model ClientRegistration {
  /**
   * The Client ID of the app used for login.
   */
  clientId?: string;

  /**
   * The app setting name that contains the client secret.
   */
  clientSecretSettingName?: string;
}

/**
 * The configuration settings of the Google provider.
 */
model Google {
  /**
   * <code>false</code> if the Google provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the app registration for the Google provider.
   */
  registration?: ClientRegistration;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;

  /**
   * The configuration settings of the Azure Active Directory token validation flow.
   */
  validation?: AllowedAudiencesValidation;
}

/**
 * The configuration settings of the Allowed Audiences validation flow.
 */
model AllowedAudiencesValidation {
  /**
   * The configuration settings of the allowed list of audiences from which to validate the JWT token.
   */
  allowedAudiences?: string[];
}

/**
 * The configuration settings of the legacy Microsoft Account provider.
 */
model LegacyMicrosoftAccount {
  /**
   * <code>false</code> if the legacy Microsoft Account provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the app registration for the legacy Microsoft Account provider.
   */
  registration?: ClientRegistration;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;

  /**
   * The configuration settings of the legacy Microsoft Account provider token validation flow.
   */
  validation?: AllowedAudiencesValidation;
}

/**
 * The configuration settings of the Twitter provider.
 */
model Twitter {
  /**
   * <code>false</code> if the Twitter provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the app registration for the Twitter provider.
   */
  registration?: TwitterRegistration;
}

/**
 * The configuration settings of the app registration for the Twitter provider.
 */
model TwitterRegistration {
  /**
   * The OAuth 1.0a consumer key of the Twitter application used for sign-in.
   * This setting is required for enabling Twitter Sign-In.
   * Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  consumerKey?: string;

  /**
   * The app setting name that contains the OAuth 1.0a consumer secret of the Twitter
   * application used for sign-in.
   */
  consumerSecretSettingName?: string;
}

/**
 * The configuration settings of the Apple provider.
 */
model Apple {
  /**
   * <code>false</code> if the Apple provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the Apple registration.
   */
  registration?: AppleRegistration;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;
}

/**
 * The configuration settings of the registration for the Apple provider
 */
model AppleRegistration {
  /**
   * The Client ID of the app used for login.
   */
  clientId?: string;

  /**
   * The app setting name that contains the client secret.
   */
  clientSecretSettingName?: string;
}

/**
 * The configuration settings of the Azure Static Web Apps provider.
 */
model AzureStaticWebApps {
  /**
   * <code>false</code> if the Azure Static Web Apps provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the Azure Static Web Apps registration.
   */
  registration?: AzureStaticWebAppsRegistration;
}

/**
 * The configuration settings of the registration for the Azure Static Web Apps provider
 */
model AzureStaticWebAppsRegistration {
  /**
   * The Client ID of the app used for login.
   */
  clientId?: string;
}

/**
 * The configuration settings of the custom Open ID Connect provider.
 */
model CustomOpenIdConnectProvider {
  /**
   * <code>false</code> if the custom Open ID provider provider should not be enabled; otherwise, <code>true</code>.
   */
  enabled?: boolean;

  /**
   * The configuration settings of the app registration for the custom Open ID Connect provider.
   */
  registration?: OpenIdConnectRegistration;

  /**
   * The configuration settings of the login flow of the custom Open ID Connect provider.
   */
  login?: OpenIdConnectLogin;
}

/**
 * The configuration settings of the app registration for the custom Open ID Connect provider.
 */
model OpenIdConnectRegistration {
  /**
   * The client id of the custom Open ID Connect provider.
   */
  clientId?: string;

  /**
   * The authentication credentials of the custom Open ID Connect provider.
   */
  clientCredential?: OpenIdConnectClientCredential;

  /**
   * The configuration settings of the endpoints used for the custom Open ID Connect provider.
   */
  openIdConnectConfiguration?: OpenIdConnectConfig;
}

/**
 * The authentication client credentials of the custom Open ID Connect provider.
 */
model OpenIdConnectClientCredential {
  /**
   * The method that should be used to authenticate the user.
   */
  method?: "ClientSecretPost";

  /**
   * The app setting that contains the client secret for the custom Open ID Connect provider.
   */
  clientSecretSettingName?: string;
}

/**
 * The configuration settings of the endpoints used for the custom Open ID Connect provider.
 */
model OpenIdConnectConfig {
  /**
   * The endpoint to be used to make an authorization request.
   */
  authorizationEndpoint?: string;

  /**
   * The endpoint to be used to request a token.
   */
  tokenEndpoint?: string;

  /**
   * The endpoint that issues the token.
   */
  issuer?: string;

  /**
   * The endpoint that provides the keys necessary to validate the token.
   */
  certificationUri?: string;

  /**
   * The endpoint that contains all the configuration endpoints for the provider.
   */
  wellKnownOpenIdConfiguration?: string;
}

/**
 * The configuration settings of the login flow of the custom Open ID Connect provider.
 */
model OpenIdConnectLogin {
  /**
   * The name of the claim that contains the users name.
   */
  nameClaimType?: string;

  /**
   * A list of the scopes that should be requested while authenticating.
   */
  scopes?: string[];
}

/**
 * The configuration settings of the login flow of users using App Service Authentication/Authorization.
 */
model Login {
  /**
   * The routes that specify the endpoints used for login and logout requests.
   */
  routes?: LoginRoutes;

  /**
   * The configuration settings of the token store.
   */
  tokenStore?: TokenStore;

  /**
   * <code>true</code> if the fragments from the request are preserved after the login request is made; otherwise, <code>false</code>.
   */
  preserveUrlFragmentsForLogins?: boolean;

  /**
   * External URLs that can be redirected to as part of logging in or logging out of the app. Note that the query string part of the URL is ignored.
   * This is an advanced setting typically only needed by Windows Store application backends.
   * Note that URLs within the current domain are always implicitly allowed.
   */
  allowedExternalRedirectUrls?: string[];

  /**
   * The configuration settings of the session cookie's expiration.
   */
  cookieExpiration?: CookieExpiration;

  /**
   * The configuration settings of the nonce used in the login flow.
   */
  nonce?: Nonce;
}

/**
 * The routes that specify the endpoints used for login and logout requests.
 */
model LoginRoutes {
  /**
   * The endpoint at which a logout request should be made.
   */
  logoutEndpoint?: string;
}

/**
 * The configuration settings of the token store.
 */
model TokenStore {
  /**
   * <code>true</code> to durably store platform-specific security tokens that are obtained during login flows; otherwise, <code>false</code>.
   *  The default is <code>false</code>.
   */
  enabled?: boolean;

  /**
   * The number of hours after session token expiration that a session token can be used to
   * call the token refresh API. The default is 72 hours.
   */
  tokenRefreshExtensionHours?: float64;

  /**
   * The configuration settings of the storage of the tokens if a file system is used.
   */
  fileSystem?: FileSystemTokenStore;

  /**
   * The configuration settings of the storage of the tokens if blob storage is used.
   */
  azureBlobStorage?: BlobStorageTokenStore;
}

/**
 * The configuration settings of the storage of the tokens if a file system is used.
 */
model FileSystemTokenStore {
  /**
   * The directory in which the tokens will be stored.
   */
  directory?: string;
}

/**
 * The configuration settings of the storage of the tokens if blob storage is used.
 */
model BlobStorageTokenStore {
  /**
   * The name of the app setting containing the SAS URL of the blob storage containing the tokens.
   */
  sasUrlSettingName?: string;
}

/**
 * The configuration settings of the session cookie's expiration.
 */
model CookieExpiration {
  /**
   * The convention used when determining the session cookie's expiration.
   */
  convention?: CookieExpirationConvention;

  /**
   * The time after the request is made when the session cookie should expire.
   */
  timeToExpiration?: string;
}

/**
 * The configuration settings of the nonce used in the login flow.
 */
model Nonce {
  /**
   * <code>false</code> if the nonce should not be validated while completing the login flow; otherwise, <code>true</code>.
   */
  validateNonce?: boolean;

  /**
   * The time after the request is made when the nonce should expire.
   */
  nonceExpirationInterval?: string;
}

/**
 * The configuration settings of the HTTP requests for authentication and authorization requests made against App Service Authentication/Authorization.
 */
model HttpSettings {
  /**
   * <code>false</code> if the authentication/authorization responses not having the HTTPS scheme are permissible; otherwise, <code>true</code>.
   */
  requireHttps?: boolean;

  /**
   * The configuration settings of the paths HTTP requests.
   */
  routes?: HttpSettingsRoutes;

  /**
   * The configuration settings of a forward proxy used to make the requests.
   */
  forwardProxy?: ForwardProxy;
}

/**
 * The configuration settings of the paths HTTP requests.
 */
model HttpSettingsRoutes {
  /**
   * The prefix that should precede all the authentication/authorization paths.
   */
  apiPrefix?: string;
}

/**
 * The configuration settings of a forward proxy used to make the requests.
 */
model ForwardProxy {
  /**
   * The convention used to determine the url of the request made.
   */
  convention?: ForwardProxyConvention;

  /**
   * The name of the header containing the host of the request.
   */
  customHostHeaderName?: string;

  /**
   * The name of the header containing the scheme of the request.
   */
  customProtoHeaderName?: string;
}

/**
 * AzureStorageInfo dictionary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureStoragePropertyDictionaryResource extends ProxyOnlyResource {
  /**
   * Azure storage accounts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<AzureStorageInfoValue>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApiKVReferenceCollection is Azure.Core.Page<ApiKVReference>;

/**
 * ApiKVReference resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApiKVReferenceProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reference?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: ResolveStatus;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vaultName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretVersion?: string;

  /**
   * Managed service identity.
   */
  identityType?: ManagedServiceIdentity;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  source?: "KeyVault";
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  activeVersion?: string;
}

/**
 * String dictionary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionStringDictionary extends ProxyOnlyResource {
  /**
   * Connection strings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<ConnStringValueTypePair>;
}

/**
 * Database connection string value to type pair.
 */
model ConnStringValueTypePair {
  /**
   * Value of pair.
   */
  value: string;

  /**
   * Type of database.
   */
  type: ConnectionStringType;
}

/**
 * SiteLogsConfig resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteLogsConfigProperties {
  /**
   * Application logs configuration.
   */
  applicationLogs?: ApplicationLogsConfig;

  /**
   * HTTP logs configuration.
   */
  httpLogs?: HttpLogsConfig;

  /**
   * Failed requests tracing configuration.
   */
  failedRequestsTracing?: EnabledConfig;

  /**
   * Detailed error messages configuration.
   */
  detailedErrorMessages?: EnabledConfig;
}

/**
 * Application logs configuration.
 */
model ApplicationLogsConfig {
  /**
   * Application logs to file system configuration.
   */
  fileSystem?: FileSystemApplicationLogsConfig;

  /**
   * Application logs to azure table storage configuration.
   */
  azureTableStorage?: AzureTableStorageApplicationLogsConfig;

  /**
   * Application logs to blob storage configuration.
   */
  azureBlobStorage?: AzureBlobStorageApplicationLogsConfig;
}

/**
 * Application logs to file system configuration.
 */
model FileSystemApplicationLogsConfig {
  /**
   * Log level.
   */
  level?: LogLevel = LogLevel.Off;
}

/**
 * Application logs to Azure table storage configuration.
 */
model AzureTableStorageApplicationLogsConfig {
  /**
   * Log level.
   */
  level?: LogLevel;

  /**
   * SAS URL to an Azure table with add/query/delete permissions.
   */
  sasUrl: string;
}

/**
 * Application logs azure blob storage configuration.
 */
model AzureBlobStorageApplicationLogsConfig {
  /**
   * Log level.
   */
  level?: LogLevel;

  /**
   * SAS url to a azure blob container with read/write/list/delete permissions.
   */
  sasUrl?: string;

  /**
   * Retention in days.
   * Remove blobs older than X days.
   * 0 or lower means no retention.
   */
  retentionInDays?: int32;
}

/**
 * Http logs configuration.
 */
model HttpLogsConfig {
  /**
   * Http logs to file system configuration.
   */
  fileSystem?: FileSystemHttpLogsConfig;

  /**
   * Http logs to azure blob storage configuration.
   */
  azureBlobStorage?: AzureBlobStorageHttpLogsConfig;
}

/**
 * Http logs to file system configuration.
 */
model FileSystemHttpLogsConfig {
  /**
   * Maximum size in megabytes that http log files can use.
   * When reached old log files will be removed to make space for new ones.
   * Value can range between 25 and 100.
   */
  @maxValue(100)
  @minValue(25)
  retentionInMb?: int32;

  /**
   * Retention in days.
   * Remove files older than X days.
   * 0 or lower means no retention.
   */
  retentionInDays?: int32;

  /**
   * True if configuration is enabled, false if it is disabled and null if configuration is not set.
   */
  enabled?: boolean;
}

/**
 * Http logs to azure blob storage configuration.
 */
model AzureBlobStorageHttpLogsConfig {
  /**
   * SAS url to a azure blob container with read/write/list/delete permissions.
   */
  sasUrl?: string;

  /**
   * Retention in days.
   * Remove blobs older than X days.
   * 0 or lower means no retention.
   */
  retentionInDays?: int32;

  /**
   * True if configuration is enabled, false if it is disabled and null if configuration is not set.
   */
  enabled?: boolean;
}

/**
 * Enabled configuration.
 */
model EnabledConfig {
  /**
   * True if configuration is enabled, false if it is disabled and null if configuration is not set.
   */
  enabled?: boolean;
}

/**
 * Names for connection strings, application settings, and external Azure storage account configuration
 * identifiers to be marked as sticky to the deployment slot and not moved during a swap operation.
 * This is valid for all deployment slots in an app.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SlotConfigNames {
  /**
   * List of connection string names.
   */
  connectionStringNames?: string[];

  /**
   * List of application settings names.
   */
  appSettingNames?: string[];

  /**
   * List of external Azure storage account identifiers.
   */
  azureStorageConfigNames?: string[];
}

/**
 * Collection of metadata for the app configuration snapshots that can be restored.
 */
model SiteConfigurationSnapshotInfoCollection
  is Azure.Core.Page<SiteConfigurationSnapshotInfo>;

/**
 * A snapshot of a web app configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteConfigurationSnapshotInfo extends ProxyOnlyResource {
  /**
   * SiteConfigurationSnapshotInfo resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SiteConfigurationSnapshotInfoProperties;
}

/**
 * SiteConfigurationSnapshotInfo resource specific properties
 */
model SiteConfigurationSnapshotInfoProperties {
  /**
   * The time the snapshot was taken.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * The id of the snapshot
   */
  @visibility(Lifecycle.Read)
  snapshotId?: int32;
}

/**
 * Collection of Kudu continuous web job information elements.
 */
model ContinuousWebJobCollection is Azure.Core.Page<ContinuousWebJob>;

/**
 * ContinuousWebJob resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContinuousWebJobProperties {
  /**
   * Job status.
   */
  status?: ContinuousWebJobStatus;

  /**
   * Detailed status.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  detailed_status?: string;

  /**
   * Log URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  log_url?: string;

  /**
   * Run command.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  run_command?: string;

  /**
   * Job URL.
   */
  url?: string;

  /**
   * Extra Info URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extra_info_url?: string;

  /**
   * Job type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  web_job_type?: WebJobType;

  /**
   * Error information.
   */
  error?: string;

  /**
   * Using SDK?
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  using_sdk?: boolean;

  /**
   * Job settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: Record<unknown>;
}

/**
 * Deployment status collection ARM resource.
 */
model CsmDeploymentStatusCollection is Azure.Core.Page<CsmDeploymentStatus>;

/**
 * CsmDeploymentStatus resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CsmDeploymentStatusProperties {
  /**
   * Deployment operation id.
   */
  deploymentId?: string;

  /**
   * Deployment build status.
   */
  status?: DeploymentBuildStatus;

  /**
   * Number of site instances currently being provisioned.
   */
  numberOfInstancesInProgress?: int32;

  /**
   * Number of site instances provisioned successfully.
   */
  numberOfInstancesSuccessful?: int32;

  /**
   * Number of site instances failed to provision.
   */
  numberOfInstancesFailed?: int32;

  /**
   * List of URLs pointing to logs for instances which failed to provision.
   */
  failedInstancesLogs?: string[];

  /**
   * List of errors.
   */
  @identifiers(#[])
  errors?: ErrorEntity[];
}

/**
 * Collection of app deployments.
 */
model DeploymentCollection is Azure.Core.Page<Deployment>;

/**
 * Deployment resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeploymentProperties {
  /**
   * Deployment status.
   */
  status?: int32;

  /**
   * Details about deployment status.
   */
  message?: string;

  /**
   * Who authored the deployment.
   */
  author?: string;

  /**
   * Who performed the deployment.
   */
  deployer?: string;

  /**
   * Author email.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  author_email?: string;

  /**
   * Start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  start_time?: utcDateTime;

  /**
   * End time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  end_time?: utcDateTime;

  /**
   * True if deployment is currently active, false if completed and null if not started.
   */
  active?: boolean;

  /**
   * Details on deployment.
   */
  details?: string;
}

/**
 * MSDeployStatus resource specific properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MSDeployStatusProperties {
  /**
   * Username of deployer
   */
  @visibility(Lifecycle.Read)
  deployer?: string;

  /**
   * Provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: MSDeployProvisioningState;

  /**
   * Start time of deploy operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of deploy operation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Whether the deployment operation has completed
   */
  @visibility(Lifecycle.Read)
  complete?: boolean;
}

/**
 * MSDeploy ARM PUT information
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MSDeploy extends ProxyOnlyResource {
  /** Core resource properties */
  properties?: MSDeployCore;
}

/**
 * MSDeploy ARM PUT core information
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MSDeployCore {
  /**
   * Package URI
   */
  packageUri?: string;

  /**
   * SQL Connection String
   */
  connectionString?: string;

  /**
   * Database Type
   */
  dbType?: string;

  /**
   * URI of MSDeploy Parameters file. Must not be set if SetParameters is used.
   */
  setParametersXmlFileUri?: string;

  /**
   * MSDeploy Parameters. Must not be set if SetParametersXmlFileUri is used.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  setParameters?: Record<string>;

  /**
   * Controls whether the MSDeploy operation skips the App_Data directory.
   * If set to <code>true</code>, the existing App_Data directory on the destination
   * will not be deleted, and any App_Data directory in the source will be ignored.
   * Setting is <code>false</code> by default.
   */
  skipAppData?: boolean;

  /**
   * Sets the AppOffline rule while the MSDeploy operation executes.
   * Setting is <code>false</code> by default.
   */
  appOffline?: boolean;
}

/**
 * MSDeploy log
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MSDeployLog extends ProxyOnlyResource {
  /**
   * MSDeployLog resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: MSDeployLogProperties;
}

/**
 * MSDeployLog resource specific properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MSDeployLogProperties {
  /**
   * List of log entry messages
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  entries?: MSDeployLogEntry[];
}

/**
 * MSDeploy log entry
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MSDeployLogEntry {
  /**
   * Timestamp of log entry
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * Log entry type
   */
  @visibility(Lifecycle.Read)
  type?: MSDeployLogEntryType;

  /**
   * Log entry message
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Collection of Kudu function information elements.
 */
model FunctionEnvelopeCollection is Azure.Core.Page<FunctionEnvelope>;

/**
 * FunctionEnvelope resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FunctionEnvelopeProperties {
  /**
   * Function App ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  function_app_id?: string;

  /**
   * Script root path URI.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  script_root_path_href?: string;

  /**
   * Script URI.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  script_href?: string;

  /**
   * Config URI.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  config_href?: string;

  /**
   * Test data URI.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  test_data_href?: string;

  /**
   * Secrets file URI.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secrets_file_href?: string;

  /**
   * Function URI.
   */
  href?: string;

  /**
   * Config information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  config?: unknown;

  /**
   * File list.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  files?: Record<string>;

  /**
   * Test data used when testing via the Azure Portal.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  test_data?: string;

  /**
   * The invocation URL
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  invoke_url_template?: string;

  /**
   * The function language
   */
  language?: string;

  /**
   * Gets or sets a value indicating whether the function is disabled
   */
  isDisabled?: boolean;
}

/**
 * Function key info.
 */
model KeyInfo {
  /**
   * Key name
   */
  name?: string;

  /**
   * Key value
   */
  value?: string;
}

/**
 * Function secrets.
 */
model FunctionSecrets {
  /**
   * Secret key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;

  /**
   * Trigger URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trigger_url?: string;
}

/**
 * Functions host level keys.
 */
model HostKeys {
  /**
   * Secret key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  masterKey?: string;

  /**
   * Host level function keys.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  functionKeys?: Record<string>;

  /**
   * System keys.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemKeys?: Record<string>;
}

/**
 * Collection of hostname bindings.
 */
model HostNameBindingCollection is Azure.Core.Page<HostNameBinding>;

/**
 * HostNameBinding resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HostNameBindingProperties {
  /**
   * App Service app name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  siteName?: string;

  /**
   * Fully qualified ARM domain resource URI.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  domainId?: string;

  /**
   * Azure resource name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureResourceName?: string;

  /**
   * Azure resource type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureResourceType?: AzureResourceType;

  /**
   * Custom DNS record type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  customHostNameDnsRecordType?: CustomHostNameDnsRecordType;

  /**
   * Hostname type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hostNameType?: HostNameType;

  /**
   * SSL type
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sslState?: SslState;

  /**
   * SSL certificate thumbprint
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  thumbprint?: string;

  /**
   * Virtual IP address assigned to the hostname if IP based SSL is enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  virtualIP?: string;
}

/**
 * RelayServiceConnectionEntity resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RelayServiceConnectionEntityProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  entityName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  entityConnectionString?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceType?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceConnectionString?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostname?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  port?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  biztalkUri?: string;
}

/**
 * Collection of app instances.
 */
model WebAppInstanceStatusCollection is Azure.Core.Page<WebSiteInstanceStatus>;

/**
 * WebSiteInstanceStatus resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WebSiteInstanceStatusProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  state?: SiteRuntimeState;

  /**
   * Link to the GetStatusApi in Kudu
   */
  statusUrl?: string;

  /**
   * Link to the Diagnose and Solve Portal
   */
  detectorUrl?: string;

  /**
   * Link to the console to web app instance
   */
  consoleUrl?: string;

  /**
   * Link to the console to web app instance
   */
  healthCheckUrl?: string;

  /**
   * Dictionary of <ContainerInfo>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  containers?: Record<ContainerInfo>;

  /**
   * The physical zone that the instance is in
   */
  physicalZone?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContainerInfo {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  currentTimeStamp?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  previousTimeStamp?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  currentCpuStats?: ContainerCpuStatistics;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  previousCpuStats?: ContainerCpuStatistics;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memoryStats?: ContainerMemoryStatistics;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eth0?: ContainerNetworkInterfaceStatistics;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContainerCpuStatistics {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cpuUsage?: ContainerCpuUsage;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemCpuUsage?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  onlineCpuCount?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  throttlingData?: ContainerThrottlingData;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContainerCpuUsage {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  totalUsage?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  perCpuUsage?: int64[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kernelModeUsage?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userModeUsage?: int64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContainerThrottlingData {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  periods?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  throttledPeriods?: int32;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  throttledTime?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContainerMemoryStatistics {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  usage?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxUsage?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  limit?: int64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContainerNetworkInterfaceStatistics {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rxBytes?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rxPackets?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rxErrors?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rxDropped?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  txBytes?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  txPackets?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  txErrors?: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  txDropped?: int64;
}

/**
 * Collection of Kudu process information elements.
 */
model ProcessInfoCollection is Azure.Core.Page<ProcessInfo>;

/**
 * ProcessInfo resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProcessInfoProperties {
  /**
   * ARM Identifier for deployment.
   */
  @visibility(Lifecycle.Read)
  identifier?: int32;

  /**
   * Deployment name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deployment_name?: string;

  /**
   * HRef URI.
   */
  href?: string;

  /**
   * Minidump URI.
   */
  minidump?: string;

  /**
   * Is profile running?
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  is_profile_running?: boolean;

  /**
   * Is the IIS Profile running?
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  is_iis_profile_running?: boolean;

  /**
   * IIS Profile timeout (seconds).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  iis_profile_timeout_in_seconds?: float64;

  /**
   * Parent process.
   */
  parent?: string;

  /**
   * Child process list.
   */
  children?: string[];

  /**
   * Thread list.
   */
  threads?: ProcessThreadInfo[];

  /**
   * List of open files.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  open_file_handles?: string[];

  /**
   * List of modules.
   */
  modules?: ProcessModuleInfo[];

  /**
   * File name of this process.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  file_name?: string;

  /**
   * Command line.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  command_line?: string;

  /**
   * User name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user_name?: string;

  /**
   * Handle count.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  handle_count?: int32;

  /**
   * Module count.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  module_count?: int32;

  /**
   * Thread count.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  thread_count?: int32;

  /**
   * Start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  start_time?: utcDateTime;

  /**
   * Total CPU time.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  total_cpu_time?: string;

  /**
   * User CPU time.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user_cpu_time?: string;

  /**
   * Privileged CPU time.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privileged_cpu_time?: string;

  /**
   * Working set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  working_set?: int64;

  /**
   * Peak working set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  peak_working_set?: int64;

  /**
   * Private memory size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  private_memory?: int64;

  /**
   * Virtual memory size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtual_memory?: int64;

  /**
   * Peak virtual memory usage.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  peak_virtual_memory?: int64;

  /**
   * Paged system memory.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  paged_system_memory?: int64;

  /**
   * Non-paged system memory.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  non_paged_system_memory?: int64;

  /**
   * Paged memory.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  paged_memory?: int64;

  /**
   * Peak paged memory.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  peak_paged_memory?: int64;

  /**
   * Time stamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  time_stamp?: utcDateTime;

  /**
   * List of environment variables.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  environment_variables?: Record<string>;

  /**
   * Is this the SCM site?
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  is_scm_site?: boolean;

  /**
   * Is this a Web Job?
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  is_webjob?: boolean;

  /**
   * Description of process.
   */
  description?: string;
}

/**
 * Process Thread Information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProcessThreadInfo extends ProxyOnlyResource {
  /**
   * ProcessThreadInfo resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ProcessThreadInfoProperties;
}

/**
 * ProcessThreadInfo resource specific properties
 */
model ProcessThreadInfoProperties {
  /**
   * Site extension ID.
   */
  @visibility(Lifecycle.Read)
  identifier?: int32;

  /**
   * HRef URI.
   */
  href?: string;

  /**
   * Process URI.
   */
  process?: string;

  /**
   * Start address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  start_address?: string;

  /**
   * Current thread priority.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  current_priority?: int32;

  /**
   * Thread priority level.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  priority_level?: string;

  /**
   * Base priority.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  base_priority?: int32;

  /**
   * Start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  start_time?: utcDateTime;

  /**
   * Total processor time.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  total_processor_time?: string;

  /**
   * User processor time.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user_processor_time?: string;

  /**
   * Thread state.
   */
  state?: string;

  /**
   * Wait reason.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wait_reason?: string;
}

/**
 * ProcessModuleInfo resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProcessModuleInfoProperties {
  /**
   * Base address. Used as module identifier in ARM resource URI.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  base_address?: string;

  /**
   * File name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  file_name?: string;

  /**
   * HRef URI.
   */
  href?: string;

  /**
   * File path.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  file_path?: string;

  /**
   * Module memory size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  module_memory_size?: int32;

  /**
   * File version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  file_version?: string;

  /**
   * File description.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  file_description?: string;

  /**
   * Product name.
   */
  product?: string;

  /**
   * Product version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  product_version?: string;

  /**
   * Is debug?
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  is_debug?: boolean;

  /**
   * Module language (locale).
   */
  language?: string;
}

/**
 * Collection of Kudu thread information elements.
 */
model ProcessModuleInfoCollection is Azure.Core.Page<ProcessModuleInfo>;

/**
 * Collection of Kudu thread information elements.
 */
model ProcessThreadInfoCollection is Azure.Core.Page<ProcessThreadInfo>;

/**
 * Represents whether or not an app is cloneable.
 */
model SiteCloneability {
  /**
   * Name of app.
   */
  result?: CloneAbilityResult;

  /**
   * List of features enabled on app that prevent cloning.
   */
  @identifiers(#["name"])
  blockingFeatures?: SiteCloneabilityCriterion[];

  /**
   * List of features enabled on app that are non-blocking but cannot be cloned. The app can still be cloned
   * but the features in this list will not be set up on cloned app.
   */
  @identifiers(#["name"])
  unsupportedFeatures?: SiteCloneabilityCriterion[];

  /**
   * List of blocking application characteristics.
   */
  @identifiers(#["name"])
  blockingCharacteristics?: SiteCloneabilityCriterion[];
}

/**
 * An app cloneability criterion.
 */
model SiteCloneabilityCriterion {
  /**
   * Name of criterion.
   */
  name?: string;

  /**
   * Description of criterion.
   */
  description?: string;
}

/**
 * Options for app content migration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageMigrationOptions extends ProxyOnlyResource {
  /**
   * StorageMigrationOptions resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StorageMigrationOptionsProperties;
}

/**
 * StorageMigrationOptions resource specific properties
 */
model StorageMigrationOptionsProperties {
  /**
   * AzureFiles connection string.
   */
  @visibility(Lifecycle.Create)
  azurefilesConnectionString: string;

  /**
   * AzureFiles share.
   */
  @visibility(Lifecycle.Create)
  azurefilesShare: string;

  /**
   * <code>true</code>if the app should be switched over; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Create)
  switchSiteAfterMigration?: boolean = false;

  /**
   * <code>true</code> if the app should be read only during copy operation; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Create)
  blockWriteAccessToSite?: boolean = false;
}

/**
 * Response for a migration of app content request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageMigrationResponse extends ProxyOnlyResource {
  /**
   * StorageMigrationResponse resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StorageMigrationResponseProperties;
}

/**
 * StorageMigrationResponse resource specific properties
 */
model StorageMigrationResponseProperties {
  /**
   * When server starts the migration process, it will return an operation ID identifying that particular migration operation.
   */
  @visibility(Lifecycle.Read)
  operationId?: string;
}

/**
 * MySQL migration request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlRequest extends ProxyOnlyResource {
  /**
   * MigrateMySqlRequest resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: MigrateMySqlRequestProperties;
}

/**
 * MigrateMySqlRequest resource specific properties
 */
model MigrateMySqlRequestProperties {
  /**
   * Connection string to the remote MySQL database.
   */
  connectionString: string;

  /**
   * The type of migration operation to be done
   */
  migrationType: MySqlMigrationType;
}

/**
 * MigrateMySqlStatus resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrateMySqlStatusProperties {
  /**
   * Status of the migration task.
   */
  @visibility(Lifecycle.Read)
  migrationOperationStatus?: OperationStatus;

  /**
   * Operation ID for the migration task.
   */
  @visibility(Lifecycle.Read)
  operationId?: string;

  /**
   * True if the web app has in app MySql enabled
   */
  @visibility(Lifecycle.Read)
  localMySqlEnabled?: boolean;
}

/**
 * SwiftVirtualNetwork resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SwiftVirtualNetworkProperties {
  /**
   * The Virtual Network subnet's resource ID. This is the subnet that this Web App will join. This subnet must have a delegation to Microsoft.Web/serverFarms defined first.
   */
  subnetResourceId?: string;

  /**
   * A flag that specifies if the scale unit this Web App is on supports Swift integration.
   */
  swiftSupported?: boolean;
}

/**
 * NetworkFeatures resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkFeaturesProperties {
  /**
   * The Virtual Network name.
   */
  @visibility(Lifecycle.Read)
  virtualNetworkName?: string;

  /**
   * The Virtual Network summary view.
   */
  @visibility(Lifecycle.Read)
  virtualNetworkConnection?: VnetInfo;

  /**
   * The Hybrid Connections summary view.
   */
  @visibility(Lifecycle.Read)
  hybridConnections?: RelayServiceConnectionEntity[];

  /**
   * The Hybrid Connection V2 (Service Bus) view.
   */
  @visibility(Lifecycle.Read)
  hybridConnectionsV2?: HybridConnection[];
}

/**
 * Network trace
 */
model NetworkTrace {
  /**
   * Local file path for the captured network trace file.
   */
  path?: string;

  /**
   * Current status of the network trace operation, same as Operation.Status (InProgress/Succeeded/Failed).
   */
  status?: string;

  /**
   * Detailed message of a network trace operation, e.g. error message in case of failure.
   */
  message?: string;
}

/**
 * Collection of performance monitor counters.
 */
model PerfMonCounterCollection is Azure.Core.Page<PerfMonResponse>;

/**
 * Performance monitor API response.
 */
model PerfMonResponse {
  /**
   * The response code.
   */
  code?: string;

  /**
   * The message.
   */
  message?: string;

  /**
   * The performance monitor counters.
   */
  data?: PerfMonSet;
}

/**
 * Metric information.
 */
model PerfMonSet {
  /**
   * Unique key name of the counter.
   */
  name?: string;

  /**
   * Start time of the period.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the period.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Presented time grain.
   */
  timeGrain?: string;

  /**
   * Collection of workers that are active during this time.
   */
  @identifiers(#[])
  values?: PerfMonSample[];
}

/**
 * Performance monitor sample in a set.
 */
model PerfMonSample {
  /**
   * Point in time for which counter was measured.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * Name of the server on which the measurement is made.
   */
  instanceName?: string;

  /**
   * Value of counter at a certain time.
   */
  value?: float64;
}

/**
 * Used for getting PHP error logging flag.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SitePhpErrorLogFlag extends ProxyOnlyResource {
  /**
   * SitePhpErrorLogFlag resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SitePhpErrorLogFlagProperties;
}

/**
 * SitePhpErrorLogFlag resource specific properties
 */
model SitePhpErrorLogFlagProperties {
  /**
   * Local log_errors setting.
   */
  localLogErrors?: string;

  /**
   * Master log_errors setting.
   */
  masterLogErrors?: string;

  /**
   * Local log_errors_max_len setting.
   */
  localLogErrorsMaxLength?: string;

  /**
   * Master log_errors_max_len setting.
   */
  masterLogErrorsMaxLength?: string;
}

/**
 * PremierAddOn resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PremierAddOnProperties {
  /**
   * Premier add on SKU.
   */
  sku?: string;

  /**
   * Premier add on Product.
   */
  product?: string;

  /**
   * Premier add on Vendor.
   */
  vendor?: string;

  /**
   * Premier add on Marketplace publisher.
   */
  marketplacePublisher?: string;

  /**
   * Premier add on Marketplace offer.
   */
  marketplaceOffer?: string;
}

/**
 * ARM resource for a PremierAddOn.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PremierAddOnPatchResource extends ProxyOnlyResource {
  /**
   * PremierAddOnPatchResource resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: PremierAddOnPatchResourceProperties;
}

/**
 * PremierAddOnPatchResource resource specific properties
 */
model PremierAddOnPatchResourceProperties {
  /**
   * Premier add on SKU.
   */
  sku?: string;

  /**
   * Premier add on Product.
   */
  product?: string;

  /**
   * Premier add on Vendor.
   */
  vendor?: string;

  /**
   * Premier add on Marketplace publisher.
   */
  marketplacePublisher?: string;

  /**
   * Premier add on Marketplace offer.
   */
  marketplaceOffer?: string;
}

/**
 * PrivateAccess resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateAccessProperties {
  /**
   * Whether private access is enabled or not.
   */
  enabled?: boolean;

  /**
   * The Virtual Networks (and subnets) allowed to access the site privately.
   */
  @identifiers(#["key"])
  virtualNetworks?: PrivateAccessVirtualNetwork[];
}

/**
 * Description of a Virtual Network that is useable for private site access.
 */
model PrivateAccessVirtualNetwork {
  /**
   * The name of the Virtual Network.
   */
  name?: string;

  /**
   * The key (ID) of the Virtual Network.
   */
  key?: int32;

  /**
   * The ARM uri of the Virtual Network
   */
  resourceId?: string;

  /**
   * A List of subnets that access is allowed to on this Virtual Network. An empty array (but not null) is interpreted to mean that all subnets are allowed within this Virtual Network.
   */
  @identifiers(#["key"])
  subnets?: PrivateAccessSubnet[];
}

/**
 * Description of a Virtual Network subnet that is useable for private site access.
 */
model PrivateAccessSubnet {
  /**
   * The name of the subnet.
   */
  name?: string;

  /**
   * The key (ID) of the subnet.
   */
  key?: int32;
}

/**
 * Collection of public certificates
 */
model PublicCertificateCollection is Azure.Core.Page<PublicCertificate>;

/**
 * PublicCertificate resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PublicCertificateProperties {
  /**
   * Public Certificate byte array
   */
  blob?: bytes;

  /**
   * Public Certificate Location
   */
  publicCertificateLocation?: PublicCertificateLocation;

  /**
   * Certificate Thumbprint
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;
}

/**
 * Publishing options for requested profile.
 */
model CsmPublishingProfileOptions {
  /**
   * Name of the format. Valid values are:
   * FileZilla3
   * WebDeploy -- default
   * Ftp
   */
  format?: PublishingProfileFormat;

  /**
   * Include the DisasterRecover endpoint if true
   */
  includeDisasterRecoveryEndpoints?: boolean;
}

/**
 * Details about restoring a deleted app.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeletedAppRestoreRequest extends ProxyOnlyResource {
  /**
   * DeletedAppRestoreRequest resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: DeletedAppRestoreRequestProperties;
}

/**
 * DeletedAppRestoreRequest resource specific properties
 */
model DeletedAppRestoreRequestProperties {
  /**
   * ARM resource ID of the deleted app. Example:
   * /subscriptions/{subId}/providers/Microsoft.Web/deletedSites/{deletedSiteId}
   */
  deletedSiteId?: string;

  /**
   * If true, deleted site configuration, in addition to content, will be restored.
   */
  recoverConfiguration?: boolean;

  /**
   * Point in time to restore the deleted app from, formatted as a DateTime string.
   * If unspecified, default value is the time that the app was deleted.
   */
  snapshotTime?: string;

  /**
   * If true, the snapshot is retrieved from DRSecondary endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useDRSecondary?: boolean;
}

/**
 * Details about app recovery operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SnapshotRestoreRequest extends ProxyOnlyResource {
  /**
   * SnapshotRestoreRequest resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SnapshotRestoreRequestProperties;
}

/**
 * SnapshotRestoreRequest resource specific properties
 */
model SnapshotRestoreRequestProperties {
  /**
   * Point in time in which the app restore should be done, formatted as a DateTime string.
   */
  snapshotTime?: string;

  /**
   * Optional. Specifies the web app that snapshot contents will be retrieved from.
   * If empty, the targeted web app will be used as the source.
   */
  recoverySource?: SnapshotRecoverySource;

  /**
   * If <code>true</code> the restore operation can overwrite source app; otherwise, <code>false</code>.
   */
  overwrite: boolean;

  /**
   * If true, site configuration, in addition to content, will be reverted.
   */
  recoverConfiguration?: boolean;

  /**
   * If true, custom hostname conflicts will be ignored when recovering to a target web app.
   * This setting is only necessary when RecoverConfiguration is enabled.
   */
  ignoreConflictingHostNames?: boolean;

  /**
   * If true, the snapshot is retrieved from DRSecondary endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useDRSecondary?: boolean;
}

/**
 * Specifies the web app that snapshot contents will be retrieved from.
 */
model SnapshotRecoverySource {
  /**
   * Geographical location of the source web app, e.g. SouthEastAsia, SouthCentralUS
   */
  location?: string;

  /**
   * ARM resource ID of the source app.
   * /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName} for production slots and
   * /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slotName} for other slots.
   */
  id?: string;
}

/**
 * Collection of site containers
 */
model SiteContainerCollection is Azure.Core.Page<SiteContainer>;

/**
 * SiteContainer resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteContainerProperties {
  /**
   * Image Name
   */
  image: string;

  /**
   * Target Port
   */
  targetPort?: string;

  /**
   * <code>true</code> if the container is the main site container; <code>false</code> otherwise.
   */
  isMain: boolean;

  /**
   * StartUp Command
   */
  startUpCommand?: string;

  /**
   * Auth Type
   */
  authType?: AuthType;

  /**
   * User Name
   */
  userName?: string;

  /**
   * Password Secret
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  passwordSecret?: string;

  /**
   * UserManagedIdentity ClientId
   */
  userManagedIdentityClientId?: string;

  /**
   * Created Time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Last Modified Time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * List of volume mounts
   */
  @identifiers(#[])
  volumeMounts?: VolumeMount[];

  /**
   * <code>true</code> if all AppSettings and ConnectionStrings have to be passed to the container as environment variables; <code>false</code> otherwise.
   */
  inheritAppSettingsAndConnectionStrings?: boolean;

  /**
   * List of environment variables
   */
  environmentVariables?: EnvironmentVariable[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VolumeMount {
  /**
   * Sub path in the volume where volume is mounted from.
   */
  volumeSubPath: string;

  /**
   * Target path on the container where volume is mounted on
   */
  containerMountPath: string;

  /**
   * Config Data to be mounted on the volume
   */
  data?: string;

  /**
   * Boolean to specify if the mount is read only on the container
   */
  readOnly?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EnvironmentVariable {
  /**
   * Environment variable name
   */
  name: string;

  /**
   * The value of this environment variable must be the name of an AppSetting. The actual value of the environment variable in container will be retrieved from the specified AppSetting at runtime. If the AppSetting is not found, the value will be set to an empty string in the container at runtime.
   */
  value: string;
}

/**
 * Collection of Kudu site extension information elements.
 */
model SiteExtensionInfoCollection is Azure.Core.Page<SiteExtensionInfo>;

/**
 * SiteExtensionInfo resource specific properties
 */
model SiteExtensionInfoProperties {
  /**
   * Site extension ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extension_id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  title?: string;

  /**
   * Site extension type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extension_type?: SiteExtensionType;

  /**
   * Summary description.
   */
  summary?: string;

  /**
   * Detailed description.
   */
  description?: string;

  /**
   * Version information.
   */
  version?: string;

  /**
   * Extension URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extension_url?: string;

  /**
   * Project URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  project_url?: string;

  /**
   * Icon URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  icon_url?: string;

  /**
   * License URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  license_url?: string;

  /**
   * Feed URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  feed_url?: string;

  /**
   * List of authors.
   */
  authors?: string[];

  /**
   * Installer command line parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  installer_command_line_params?: string;

  /**
   * Published timestamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  published_date_time?: utcDateTime;

  /**
   * Count of downloads.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  download_count?: int32;

  /**
   * <code>true</code> if the local version is the latest version; <code>false</code> otherwise.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  local_is_latest_version?: boolean;

  /**
   * Local path.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  local_path?: string;

  /**
   * Installed timestamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  installed_date_time?: utcDateTime;

  /**
   * Provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: string;

  /**
   * Site Extension comment.
   */
  comment?: string;
}

/**
 * Collection of slot differences.
 */
model SlotDifferenceCollection is Azure.Core.Page<SlotDifference>;

/**
 * A setting difference between two deployment slots of an app.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SlotDifference extends ProxyOnlyResource {
  /**
   * SlotDifference resource specific properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SlotDifferenceProperties;
}

/**
 * SlotDifference resource specific properties
 */
model SlotDifferenceProperties {
  /**
   * Level of the difference: Information, Warning or Error.
   */
  @visibility(Lifecycle.Read)
  level?: string;

  /**
   * The type of the setting: General, AppSetting or ConnectionString.
   */
  @visibility(Lifecycle.Read)
  settingType?: string;

  /**
   * Rule that describes how to process the setting difference during a slot swap.
   */
  @visibility(Lifecycle.Read)
  diffRule?: string;

  /**
   * Name of the setting.
   */
  @visibility(Lifecycle.Read)
  settingName?: string;

  /**
   * Value of the setting in the current slot.
   */
  @visibility(Lifecycle.Read)
  valueInCurrentSlot?: string;

  /**
   * Value of the setting in the target slot.
   */
  @visibility(Lifecycle.Read)
  valueInTargetSlot?: string;

  /**
   * Description of the setting difference.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Collection of snapshots which can be used to revert an app to a previous time.
 */
model SnapshotCollection is Azure.Core.Page<Snapshot>;

/**
 * SiteSourceControl resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SiteSourceControlProperties {
  /**
   * Repository or source control URL.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  repoUrl?: string;

  /**
   * Name of branch to use for deployment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  branch?: string;

  /**
   * <code>true</code> to limit to manual integration; <code>false</code> to enable continuous integration (which configures webhooks into online repos like GitHub).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isManualIntegration?: boolean;

  /**
   * <code>true</code> if this is deployed via GitHub action.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isGitHubAction?: boolean;

  /**
   * <code>true</code> to enable deployment rollback; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deploymentRollbackEnabled?: boolean;

  /**
   * <code>true</code> for a Mercurial repository; <code>false</code> for a Git repository.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isMercurial?: boolean;

  /**
   * If GitHub Action is selected, than the associated configuration.
   */
  gitHubActionConfiguration?: GitHubActionConfiguration;
}

/**
 * The GitHub action configuration.
 */
model GitHubActionConfiguration {
  /**
   * GitHub Action code configuration.
   */
  codeConfiguration?: GitHubActionCodeConfiguration;

  /**
   * GitHub Action container configuration.
   */
  containerConfiguration?: GitHubActionContainerConfiguration;

  /**
   * This will help determine the workflow configuration to select.
   */
  isLinux?: boolean;

  /**
   * Workflow option to determine whether the workflow file should be generated and written to the repository.
   */
  generateWorkflowFile?: boolean;
}

/**
 * The GitHub action code configuration.
 */
model GitHubActionCodeConfiguration {
  /**
   * Runtime stack is used to determine the workflow file content for code base apps.
   */
  runtimeStack?: string;

  /**
   * Runtime version is used to determine what build version to set in the workflow file.
   */
  runtimeVersion?: string;
}

/**
 * The GitHub action container configuration.
 */
model GitHubActionContainerConfiguration {
  /**
   * The server URL for the container registry where the build will be hosted.
   */
  serverUrl?: string;

  /**
   * The image name for the build.
   */
  imageName?: string;

  /**
   * The username used to upload the image to the container registry.
   */
  username?: string;

  /**
   * The password used to upload the image to the container registry.
   */
  @secret
  password?: string;
}

/**
 * Collection of Kudu continuous web job information elements.
 */
model TriggeredWebJobCollection is Azure.Core.Page<TriggeredWebJob>;

/**
 * TriggeredWebJob resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TriggeredWebJobProperties {
  /**
   * Latest job run information.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  latest_run?: TriggeredJobRun;

  /**
   * History URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  history_url?: string;

  /**
   * Scheduler Logs URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scheduler_logs_url?: string;

  /**
   * Run command.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  run_command?: string;

  /**
   * Job URL.
   */
  url?: string;

  /**
   * Extra Info URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extra_info_url?: string;

  /**
   * Job type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  web_job_type?: WebJobType;

  /**
   * Error information.
   */
  error?: string;

  /**
   * Using SDK?
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  using_sdk?: boolean;

  /**
   * Property to allow or block all public traffic. Allowed Values: 'Enabled', 'Disabled' or an empty string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicNetworkAccess?: string;

  /**
   * Checks if Customer provided storage account is required
   */
  storageAccountRequired?: boolean;

  /**
   * Job settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: Record<unknown>;
}

/**
 * Triggered Web Job Run Information.
 */
model TriggeredJobRun {
  /**
   * Job ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  web_job_id?: string;

  /**
   * Job name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  web_job_name?: string;

  /**
   * Job status.
   */
  status?: TriggeredWebJobStatus;

  /**
   * Start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  start_time?: utcDateTime;

  /**
   * End time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  end_time?: utcDateTime;

  /**
   * Job duration.
   */
  duration?: string;

  /**
   * Output URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  output_url?: string;

  /**
   * Error URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  error_url?: string;

  /**
   * Job URL.
   */
  url?: string;

  /**
   * Job name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  job_name?: string;

  /**
   * Job trigger.
   */
  trigger?: string;
}

/**
 * Collection of Kudu continuous web job information elements.
 */
model TriggeredJobHistoryCollection is Azure.Core.Page<TriggeredJobHistory>;

/**
 * TriggeredJobHistory resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TriggeredJobHistoryProperties {
  /**
   * List of triggered web job runs.
   */
  @identifiers(#["web_job_id"])
  runs?: TriggeredJobRun[];
}

/**
 * Collection of Kudu web job information elements.
 */
model WebJobCollection is Azure.Core.Page<WebJob>;

/**
 * WebJob resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WebJobProperties {
  /**
   * Run command.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  run_command?: string;

  /**
   * Job URL.
   */
  url?: string;

  /**
   * Extra Info URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extra_info_url?: string;

  /**
   * Job type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  web_job_type?: WebJobType;

  /**
   * Error information.
   */
  error?: string;

  /**
   * Using SDK?
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  using_sdk?: boolean;

  /**
   * Job settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: Record<unknown>;
}

/**
 * The workflow filter.
 */
model WorkflowArtifacts {
  /**
   * Application settings of the workflow.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  appSettings?: unknown;

  /**
   * Files of the app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  files?: Record<unknown>;

  /**
   * Files of the app to delete.
   */
  filesToDelete?: string[];
}

/**
 * Collection of Kudu workflow information elements.
 */
model WorkflowEnvelopeCollection is Azure.Core.Page<WorkflowEnvelope>;

/**
 * Additional workflow properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkflowEnvelopeProperties {
  /**
   * Gets or sets the files.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  files?: Record<unknown>;

  /**
   * Gets or sets the state of the workflow.
   */
  flowState?: WorkflowState;

  /**
   * Gets or sets workflow health.
   */
  health?: WorkflowHealth;
}

/**
 * Represents the workflow health.
 */
model WorkflowHealth {
  /**
   * Gets or sets the workflow health state.
   */
  state: WorkflowHealthState;

  /**
   * Gets or sets the workflow error.
   */
  error?: ErrorEntity;
}

/**
 * The access key regenerate action content.
 */
model RegenerateActionParameter {
  /**
   * The key type.
   */
  keyType?: KeyType;
}

/**
 * Error response indicates Logic service is not able to process the incoming request. The error property contains the error details.
 */
@error
model ErrorResponse {
  /**
   * The error properties.
   */
  error?: ErrorProperties;
}

/**
 * Error properties indicate why the Logic service was not able to process the incoming request. The reason is provided in the error message.
 */
model ErrorProperties {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * The workflow run properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkflowRunProperties {
  /**
   * Gets the wait end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  waitEndTime?: utcDateTime;

  /**
   * Gets the start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the status.
   */
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  /**
   * Gets the code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets the error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  error?: unknown;

  /**
   * Gets the correlation id.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * The run correlation.
   */
  correlation?: Correlation;

  /**
   * Gets the reference to workflow version.
   */
  @visibility(Lifecycle.Read)
  workflow?: ResourceReference;

  /**
   * Gets the fired trigger.
   */
  @visibility(Lifecycle.Read)
  trigger?: WorkflowRunTrigger;

  /**
   * Gets the outputs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  outputs?: Record<WorkflowOutputParameter>;

  /**
   * Gets the response of the flow run.
   */
  @visibility(Lifecycle.Read)
  response?: WorkflowRunTrigger;
}

/**
 * The correlation property.
 */
model Correlation {
  /**
   * The client tracking id.
   */
  clientTrackingId?: string;
}

/**
 * The resource reference.
 */
model ResourceReference {
  /**
   * The resource id.
   */
  id?: string;

  /**
   * Gets the resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The workflow run trigger.
 */
model WorkflowRunTrigger {
  /**
   * Gets the name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets the inputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  inputs?: unknown;

  /**
   * Gets the link to inputs.
   */
  @visibility(Lifecycle.Read)
  inputsLink?: ContentLink;

  /**
   * Gets the outputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  outputs?: unknown;

  /**
   * Gets the link to outputs.
   */
  @visibility(Lifecycle.Read)
  outputsLink?: ContentLink;

  /**
   * Gets the scheduled time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledTime?: utcDateTime;

  /**
   * Gets the start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the tracking id.
   */
  @visibility(Lifecycle.Read)
  trackingId?: string;

  /**
   * The run correlation.
   */
  correlation?: Correlation;

  /**
   * Gets the code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets the status.
   */
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  /**
   * Gets the error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  error?: unknown;

  /**
   * Gets the tracked properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  trackedProperties?: unknown;
}

/**
 * The content link.
 */
model ContentLink {
  /**
   * The content link URI.
   */
  uri?: string;

  /**
   * The content version.
   */
  @visibility(Lifecycle.Read)
  contentVersion?: string;

  /**
   * The content size.
   */
  @visibility(Lifecycle.Read)
  contentSize?: int64;

  /**
   * The content hash.
   */
  @visibility(Lifecycle.Read)
  contentHash?: ContentHash;

  /**
   * The metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  metadata?: unknown;
}

/**
 * The content hash.
 */
model ContentHash {
  /**
   * The algorithm of the content hash.
   */
  algorithm?: string;

  /**
   * The value of the content hash.
   */
  value?: string;
}

/**
 * The workflow output parameter.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkflowOutputParameter extends WorkflowParameter {
  /**
   * Gets the error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  error?: unknown;
}

/**
 * The workflow parameters.
 */
model WorkflowParameter {
  /**
   * The type.
   */
  type?: ParameterType;

  /**
   * The value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

  /**
   * The metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: unknown;

  /**
   * The description.
   */
  description?: string;
}

/**
 * The sub resource type.
 */
model SubResource {
  /**
   * The resource id.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * The workflow run action properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkflowRunActionProperties {
  /**
   * Gets the start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the status.
   */
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  /**
   * Gets the code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets the error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  error?: unknown;

  /**
   * Gets the tracking id.
   */
  @visibility(Lifecycle.Read)
  trackingId?: string;

  /**
   * The correlation properties.
   */
  correlation?: RunActionCorrelation;

  /**
   * Gets the link to inputs.
   */
  @visibility(Lifecycle.Read)
  inputsLink?: ContentLink;

  /**
   * Gets the link to outputs.
   */
  @visibility(Lifecycle.Read)
  outputsLink?: ContentLink;

  /**
   * Gets the tracked properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  trackedProperties?: unknown;

  /**
   * Gets the retry histories.
   */
  @identifiers(#[])
  retryHistory?: RetryHistory[];
}

/**
 * The workflow run action correlation properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RunActionCorrelation extends RunCorrelation {
  /**
   * The action tracking identifier.
   */
  actionTrackingId?: string;
}

/**
 * The correlation properties.
 */
model RunCorrelation {
  /**
   * The client tracking identifier.
   */
  clientTrackingId?: string;

  /**
   * The client keywords.
   */
  clientKeywords?: string[];
}

/**
 * The retry history.
 */
model RetryHistory {
  /**
   * Gets the start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the status code.
   */
  code?: string;

  /**
   * Gets the client request Id.
   */
  clientRequestId?: string;

  /**
   * Gets the service request Id.
   */
  serviceRequestId?: string;

  /**
   * Gets the error response.
   */
  error?: ErrorResponse;
}

/**
 * The expression traces.
 */
model ExpressionTraces {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  @identifiers(#["path"])
  inputs?: ExpressionRoot[];

  /**
   * The link used to get the next page of recommendations.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The expression root.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExpressionRoot extends Expression {
  /**
   * The path.
   */
  path?: string;
}

/**
 * The expression.
 */
model Expression {
  /**
   * The text.
   */
  text?: string;

  /**
   * Anything
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

  /**
   * The sub expressions.
   */
  @identifiers(#[])
  subexpressions?: Expression[];

  /**
   * The azure resource error info.
   */
  error?: AzureResourceErrorInfo;
}

/**
 * The azure resource error info.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureResourceErrorInfo extends ErrorInfo {
  /**
   * The error message.
   */
  message: string;

  /**
   * The error details.
   */
  @identifiers(#["code"])
  details?: AzureResourceErrorInfo[];
}

/**
 * The error info.
 */
model ErrorInfo {
  /**
   * The error code.
   */
  code: string;
}

/**
 * A collection of workflow run action repetitions.
 */
model WorkflowRunActionRepetitionDefinitionCollection
  is Azure.Core.Page<WorkflowRunActionRepetitionDefinition>;

/**
 * The workflow run action repetition properties definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkflowRunActionRepetitionProperties extends OperationResult {
  /**
   * The repetition indexes.
   */
  @identifiers(#["itemIndex"])
  repetitionIndexes?: RepetitionIndex[];
}

/**
 * The workflow run action repetition index.
 */
model RepetitionIndex {
  /**
   * The scope.
   */
  scopeName?: string;

  /**
   * The index.
   */
  itemIndex: int32;
}

/**
 * The operation result definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationResult extends OperationResultProperties {
  /**
   * Gets the tracking id.
   */
  @visibility(Lifecycle.Read)
  trackingId?: string;

  /**
   * Gets the inputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  inputs?: unknown;

  /**
   * Gets the link to inputs.
   */
  @visibility(Lifecycle.Read)
  inputsLink?: ContentLink;

  /**
   * Gets the outputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  outputs?: unknown;

  /**
   * Gets the link to outputs.
   */
  @visibility(Lifecycle.Read)
  outputsLink?: ContentLink;

  /**
   * Gets the tracked properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  trackedProperties?: unknown;

  /**
   * Gets the retry histories.
   */
  @identifiers(#[])
  retryHistory?: RetryHistory[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  iterationCount?: int32;
}

/**
 * The run operation result properties.
 */
model OperationResultProperties {
  /**
   * The start time of the workflow scope repetition.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the workflow scope repetition.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The correlation properties.
   */
  correlation?: RunActionCorrelation;

  /**
   * The status of the workflow scope repetition.
   */
  status?: WorkflowStatus;

  /**
   * The workflow scope repetition code.
   */
  code?: string;

  /**
   * Anything
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  error?: unknown;
}

/**
 * The base resource type.
 */
model WorkflowResource {
  /**
   * The resource id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets the resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource location.
   */
  location?: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The request history.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RequestHistoryProperties {
  /**
   * The time the request started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time the request ended.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The request.
   */
  request?: Request;

  /**
   * The response.
   */
  response?: Response;
}

/**
 * A request.
 */
model Request {
  /**
   * A list of all the headers attached to the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: unknown;

  /**
   * The destination for the request.
   */
  uri?: string;

  /**
   * The HTTP method used for the request.
   */
  method?: string;
}

/**
 * A response.
 */
model Response {
  /**
   * A list of all the headers attached to the response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: unknown;

  /**
   * The status code of the response.
   */
  statusCode?: int32;

  /**
   * Details on the location of the body content.
   */
  bodyLink?: ContentLink;
}

/**
 * The workflow trigger properties.
 */
model WorkflowTriggerProperties {
  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowTriggerProvisioningState;

  /**
   * Gets the created time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Gets the changed time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * Gets the state.
   */
  @visibility(Lifecycle.Read)
  state?: WorkflowState;

  /**
   * Gets the status.
   */
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  /**
   * Gets the last execution time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutionTime?: utcDateTime;

  /**
   * Gets the next execution time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextExecutionTime?: utcDateTime;

  /**
   * Gets the workflow trigger recurrence.
   */
  @visibility(Lifecycle.Read)
  recurrence?: WorkflowTriggerRecurrence;

  /**
   * Gets the reference to workflow.
   */
  @visibility(Lifecycle.Read)
  workflow?: ResourceReference;
}

/**
 * The workflow trigger recurrence.
 */
model WorkflowTriggerRecurrence {
  /**
   * The frequency.
   */
  frequency?: RecurrenceFrequency;

  /**
   * The interval.
   */
  interval?: int32;

  /**
   * The start time.
   */
  startTime?: string;

  /**
   * The end time.
   */
  endTime?: string;

  /**
   * The time zone.
   */
  timeZone?: string;

  /**
   * The recurrence schedule.
   */
  schedule?: RecurrenceSchedule;
}

/**
 * The recurrence schedule.
 */
model RecurrenceSchedule {
  /**
   * The minutes.
   */
  minutes?: int32[];

  /**
   * The hours.
   */
  hours?: int32[];

  /**
   * The days of the week.
   */
  weekDays?: DaysOfWeek[];

  /**
   * The month days.
   */
  monthDays?: int32[];

  /**
   * The monthly occurrences.
   */
  @identifiers(#[])
  monthlyOccurrences?: RecurrenceScheduleOccurrence[];
}

/**
 * The recurrence schedule occurrence.
 */
model RecurrenceScheduleOccurrence {
  /**
   * The day of the week.
   */
  day?: DayOfWeek;

  /**
   * The occurrence.
   */
  occurrence?: int32;
}

/**
 * The workflow trigger history properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkflowTriggerHistoryProperties {
  /**
   * Gets the start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The scheduled time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledTime?: utcDateTime;

  /**
   * Gets the status.
   */
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  /**
   * Gets the code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets the error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  error?: unknown;

  /**
   * Gets the tracking id.
   */
  @visibility(Lifecycle.Read)
  trackingId?: string;

  /**
   * The run correlation.
   */
  correlation?: Correlation;

  /**
   * Gets the link to input parameters.
   */
  @visibility(Lifecycle.Read)
  inputsLink?: ContentLink;

  /**
   * Gets the link to output parameters.
   */
  @visibility(Lifecycle.Read)
  outputsLink?: ContentLink;

  /**
   * The value indicating whether trigger was fired.
   */
  @visibility(Lifecycle.Read)
  fired?: boolean;

  /**
   * Gets the reference to workflow run.
   */
  @visibility(Lifecycle.Read)
  run?: ResourceReference;
}

/**
 * The workflow trigger callback URL.
 */
model WorkflowTriggerCallbackUrl {
  /**
   * Gets the workflow trigger callback URL.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * Gets the workflow trigger callback URL HTTP method.
   */
  @visibility(Lifecycle.Read)
  method?: string;

  /**
   * Gets the workflow trigger callback URL base path.
   */
  @visibility(Lifecycle.Read)
  basePath?: string;

  /**
   * Gets the workflow trigger callback URL relative path.
   */
  @visibility(Lifecycle.Read)
  relativePath?: string;

  /**
   * Gets the workflow trigger callback URL relative path parameters.
   */
  relativePathParameters?: string[];

  /**
   * Gets the workflow trigger callback URL query parameters.
   */
  queries?: WorkflowTriggerListCallbackUrlQueries;
}

/**
 * Gets the workflow trigger callback URL query parameters.
 */
model WorkflowTriggerListCallbackUrlQueries {
  /**
   * The api version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `api-version`?: string;

  /**
   * The SAS permissions.
   */
  sp?: string;

  /**
   * The SAS version.
   */
  sv?: string;

  /**
   * The SAS signature.
   */
  sig?: string;

  /**
   * The SAS timestamp.
   */
  se?: string;
}

/**
 * The JSON schema.
 */
model JsonSchema {
  /**
   * The JSON title.
   */
  title?: string;

  /**
   * The JSON content.
   */
  content?: string;
}

/**
 * The workflow type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Workflow extends WorkflowResource {
  /**
   * The workflow properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: WorkflowProperties;

  /**
   * Managed service identity.
   */
  identity?: ManagedServiceIdentity;
}

/**
 * The workflow properties.
 */
model WorkflowProperties {
  /**
   * Gets the provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  /**
   * Gets the created time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Gets the changed time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The state.
   */
  state?: WorkflowState;

  /**
   * Gets the version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets the access endpoint.
   */
  @visibility(Lifecycle.Read)
  accessEndpoint?: string;

  /**
   * The endpoints configuration.
   */
  endpointsConfiguration?: FlowEndpointsConfiguration;

  /**
   * The access control configuration.
   */
  accessControl?: FlowAccessControlConfiguration;

  /**
   * The sku.
   */
  @visibility(Lifecycle.Read)
  sku?: WorkflowSku;

  /**
   * The integration account.
   */
  integrationAccount?: ResourceReference;

  /**
   * The integration service environment.
   */
  integrationServiceEnvironment?: ResourceReference;

  /**
   * The definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  definition?: unknown;

  /**
   * The parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<WorkflowParameter>;

  /**
   * The workflow kind.
   */
  kind?: Kind;
}

/**
 * The endpoints configuration.
 */
model FlowEndpointsConfiguration {
  /**
   * The workflow endpoints.
   */
  workflow?: FlowEndpoints;

  /**
   * The connector endpoints.
   */
  connector?: FlowEndpoints;
}

/**
 * The flow endpoints configuration.
 */
model FlowEndpoints {
  /**
   * The outgoing ip address.
   */
  @identifiers(#["address"])
  outgoingIpAddresses?: IpAddress[];

  /**
   * The access endpoint ip address.
   */
  @identifiers(#["address"])
  accessEndpointIpAddresses?: IpAddress[];
}

/**
 * The ip address.
 */
model IpAddress {
  /**
   * The address.
   */
  address?: string;
}

/**
 * The access control configuration.
 */
model FlowAccessControlConfiguration {
  /**
   * The access control configuration for invoking workflow triggers.
   */
  triggers?: FlowAccessControlConfigurationPolicy;

  /**
   * The access control configuration for accessing workflow run contents.
   */
  contents?: FlowAccessControlConfigurationPolicy;

  /**
   * The access control configuration for workflow actions.
   */
  actions?: FlowAccessControlConfigurationPolicy;

  /**
   * The access control configuration for workflow management.
   */
  workflowManagement?: FlowAccessControlConfigurationPolicy;
}

/**
 * The access control configuration policy.
 */
model FlowAccessControlConfigurationPolicy {
  /**
   * The allowed caller IP address ranges.
   */
  @identifiers(#[])
  allowedCallerIpAddresses?: IpAddressRange[];

  /**
   * The authentication policies for workflow.
   */
  openAuthenticationPolicies?: OpenAuthenticationAccessPolicies;
}

/**
 * The ip address range.
 */
model IpAddressRange {
  /**
   * The IP address range.
   */
  addressRange?: string;
}

/**
 * AuthenticationPolicy of type Open.
 */
model OpenAuthenticationAccessPolicies {
  /**
   * Open authentication policies.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  policies?: Record<OpenAuthenticationAccessPolicy>;
}

/**
 * Open authentication access policy defined by user.
 */
model OpenAuthenticationAccessPolicy {
  /**
   * Type of provider for OAuth.
   */
  type?: OpenAuthenticationProviderType;

  /**
   * The access policy claims.
   */
  @identifiers(#["name"])
  claims?: OpenAuthenticationPolicyClaim[];
}

/**
 * Open authentication policy claim.
 */
model OpenAuthenticationPolicyClaim {
  /**
   * The name of the claim.
   */
  name?: string;

  /**
   * The value of the claim.
   */
  value?: string;
}

/**
 * The sku type.
 */
model WorkflowSku {
  /**
   * The name.
   */
  name: WorkflowSkuName;

  /**
   * The reference to plan.
   */
  plan?: ResourceReference;
}

/**
 * The workflow version properties.
 */
model WorkflowVersionProperties {
  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  /**
   * Gets the created time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Gets the changed time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The state.
   */
  state?: WorkflowState;

  /**
   * Gets the version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Gets the access endpoint.
   */
  @visibility(Lifecycle.Read)
  accessEndpoint?: string;

  /**
   * The endpoints configuration.
   */
  endpointsConfiguration?: FlowEndpointsConfiguration;

  /**
   * The access control configuration.
   */
  accessControl?: FlowAccessControlConfiguration;

  /**
   * The sku.
   */
  @visibility(Lifecycle.Read)
  sku?: WorkflowSku;

  /**
   * The integration account.
   */
  integrationAccount?: ResourceReference;

  /**
   * The definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  definition?: unknown;

  /**
   * The parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<WorkflowParameter>;
}

/**
 * Describes valid TLS cipher suites.
 */
model CipherSuites {
  /**
   * List of TLS Cipher Suites that are supported by App Service.
   */
  suites?: string[];
}

/**
 * Container App container definition.
 */
model Container {
  /**
   * Container image tag.
   */
  image?: string;

  /**
   * Custom container name.
   */
  name?: string;

  /**
   * Container start command.
   */
  command?: string[];

  /**
   * Container start command arguments.
   */
  args?: string[];

  /**
   * Container environment variables.
   */
  @identifiers(#["name"])
  env?: EnvironmentVar[];

  /**
   * Container resource requirements.
   */
  resources?: ContainerResources;
}

/**
 * Container App container environment variable.
 */
model EnvironmentVar {
  /**
   * Environment variable name.
   */
  name?: string;

  /**
   * Non-secret environment variable value.
   */
  value?: string;

  /**
   * Name of the Container App secret from which to pull the environment variable value.
   */
  secretRef?: string;
}

/**
 * Container App container resource requirements.
 */
model ContainerResources {
  /**
   * Required CPU in cores, e.g. 0.5
   */
  cpu?: float64;

  /**
   * Required memory, e.g. "250Mb"
   */
  memory?: string;
}

/**
 * Container App container Custom scaling rule.
 */
model CustomScaleRule {
  /**
   * Type of the custom scale rule
   * eg: azure-servicebus, redis etc.
   */
  type?: string;

  /**
   * Metadata properties to describe custom scale rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;

  /**
   * Authentication secrets for the custom scale rule.
   */
  @identifiers(#["triggerParameter"])
  auth?: ScaleRuleAuth[];
}

/**
 * Auth Secrets for Container App Scale Rule
 */
model ScaleRuleAuth {
  /**
   * Name of the Container App secret from which to pull the auth params.
   */
  secretRef?: string;

  /**
   * Trigger Parameter that uses the secret
   */
  triggerParameter?: string;
}

/**
 * Container App Dapr configuration.
 */
model Dapr {
  /**
   * Boolean indicating if the Dapr side car is enabled
   */
  enabled?: boolean;

  /**
   * Dapr application identifier
   */
  appId?: string;

  /**
   * Port on which the Dapr side car
   */
  appPort?: int32;

  /**
   * Collection of Dapr components
   */
  @identifiers(#["name"])
  components?: DaprComponent[];
}

/**
 * Dapr component configuration
 */
model DaprComponent {
  /**
   * Component name
   */
  name?: string;

  /**
   * Component type
   */
  type?: string;

  /**
   * Component version
   */
  version?: string;

  /**
   * Component metadata
   */
  @identifiers(#["name"])
  metadata?: DaprMetadata[];
}

/**
 * Container App Dapr component metadata.
 */
model DaprMetadata {
  /**
   * Metadata property name.
   */
  name?: string;

  /**
   * Metadata property value.
   */
  value?: string;

  /**
   * Name of the Container App secret from which to pull the metadata property value.
   */
  secretRef?: string;
}

/**
 * Container App container Custom scaling rule.
 */
model HttpScaleRule {
  /**
   * Metadata properties to describe http scale rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;

  /**
   * Authentication secrets for the custom scale rule.
   */
  @identifiers(#["triggerParameter"])
  auth?: ScaleRuleAuth[];
}

/**
 * A request to approve or reject a private endpoint connection
 */
model PrivateLinkConnectionApprovalRequest {
  /**
   * The state of a private link connection
   */
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;
}

/**
 * Private Endpoint Connection Approval ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkConnectionApprovalRequestResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: PrivateLinkConnectionApprovalRequest;
}

/**
 * Container App container Azure Queue based scaling rule.
 */
model QueueScaleRule {
  /**
   * Queue name.
   */
  queueName?: string;

  /**
   * Queue length.
   */
  queueLength?: int32;

  /**
   * Authentication secrets for the queue scale rule.
   */
  @identifiers(#["triggerParameter"])
  auth?: ScaleRuleAuth[];
}

/**
 * Container App scaling configurations.
 */
model Scale {
  /**
   * Optional. Minimum number of container replicas.
   */
  minReplicas?: int32;

  /**
   * Optional. Maximum number of container replicas. Defaults to 10 if not set.
   */
  maxReplicas?: int32;

  /**
   * Scaling rules.
   */
  @identifiers(#["name"])
  rules?: ScaleRule[];
}

/**
 * Container App container scaling rule.
 */
model ScaleRule {
  /**
   * Scale Rule Name
   */
  name?: string;

  /**
   * Azure Queue based scaling.
   */
  azureQueue?: QueueScaleRule;

  /**
   * Custom scale rule.
   */
  custom?: CustomScaleRule;

  /**
   * HTTP requests based scaling.
   */
  http?: HttpScaleRule;
}

/**
 * Container App versioned application definition.
 * Defines the desired state of an immutable revision.
 * Any changes to this section Will result in a new revision being created
 */
model Template {
  /**
   * User friendly suffix that is appended to the revision name
   */
  revisionSuffix?: string;

  /**
   * List of container definitions for the Container App.
   */
  @identifiers(#["name"])
  containers?: Container[];

  /**
   * Scaling properties for the Container App.
   */
  scale?: Scale;

  /**
   * Dapr configuration for the Container App.
   */
  dapr?: Dapr;
}

/**
 * Github access token for Appservice CLI github integration.
 */
model AppserviceGithubToken {
  /**
   * Github access token for Appservice CLI github integration
   */
  accessToken?: string;

  /**
   * Scope of the github access token
   */
  scope?: string;

  /**
   * token type
   */
  tokenType?: string;

  /**
   * True if valid github token received, False otherwise
   */
  gotToken?: boolean;

  /**
   * Error message if unable to get token
   */
  errorMessage?: string;
}

/**
 * Appservice Github token request content.
 */
model AppserviceGithubTokenRequest {
  /**
   * Code string to exchange for Github Access token
   */
  code: string;

  /**
   * State string used for verification.
   */
  state: string;
}

/**
 * A custom error page for a specific status returned by a web app.
 */
model ErrorPage {
  /**
   * The status code for which the error page will be used
   */
  statusCode?: int32;

  /**
   * The content of the error page. There is a 10kb limit imposed on custom error page content.
   */
  content?: string;

  /**
   * The content type of the error page. For example, 'text/html'
   */
  contentType?: string;

  /**
   * If true, the error page will be shown for all requests with a matching status code, regardless of whether they failed on the App Service FrontEnd load balancer or on the app itself.
   */
  alwaysUse?: boolean;
}

/**
 * The workflow filter.
 */
model WorkflowFilter {
  /**
   * The state of workflows.
   */
  state?: WorkflowState;
}

/**
 * The list of workflows.
 */
model WorkflowListResult {
  /**
   * The list of workflows.
   */
  value?: Workflow[];

  /**
   * The URL to get the next set of results.
   */
  nextLink?: string;
}

/**
 * The workflow run action filter.
 */
model WorkflowRunActionFilter {
  /**
   * The status of workflow run action.
   */
  status?: WorkflowStatus;
}

/**
 * The workflow run filter.
 */
model WorkflowRunFilter {
  /**
   * The status of workflow run.
   */
  status?: WorkflowStatus;
}

/**
 * The workflow trigger filter.
 */
model WorkflowTriggerFilter {
  /**
   * The state of workflow trigger.
   */
  state?: WorkflowState;
}

/**
 * The workflow trigger history filter.
 */
model WorkflowTriggerHistoryFilter {
  /**
   * The status of workflow trigger history.
   */
  status?: WorkflowStatus;
}

/**
 * Type of the registry adapter.
 */
union RegistryAdapterType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Binary: "Binary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  String: "String",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Expand_String: "Expand_String",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Multi_String: "Multi_String",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DWord: "DWord",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  QWord: "QWord",
}

/**
 * Type of the install script.
 */
union InstallScriptType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RemoteAzureBlob: "RemoteAzureBlob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PlatformStorage: "PlatformStorage",
}

/**
 * Type of the storage mount.
 */
union StorageMountType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureFiles: "AzureFiles",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocalStorage: "LocalStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FileShare: "FileShare",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultIdentity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identityType?: ManagedServiceIdentityType;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentityResourceId?: string;
}

/**
 * Represents instance details for an app service plan.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerFarmInstanceDetails {
  /**
   * The server farm name.
   */
  serverFarmName?: string;

  /**
   * The list of server farm instances.
   */
  @identifiers(#[])
  instances?: ServerFarmInstance[];

  /**
   * The total number of instances.
   */
  instanceCount?: int32;
}

/**
 * Represents details of a single instance in a server farm.
 */
model ServerFarmInstance {
  /**
   * The instance name.
   */
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]+$")
  instanceName?: string;

  /**
   * The instance IP address.
   */
  ipAddress?: string;

  /**
   * The instance status.
   */
  status?: string;
}

/**
 * Server Farm RDP connection details.
 */
model ServerFarmRdpDetails {
  /**
   * The RDP password for the server farm.
   */
  @secret
  rdpPassword?: string;

  /**
   * The RDP password expiry date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rdpPasswordExpiry?: utcDateTime;
}

/**
 * Server farm registry adapter configuration.
 */
model RegistryAdapter {
  /**
   * Registry key for the adapter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  registryKey?: string;

  /**
   * Type of the registry adapter.
   */
  type?: RegistryAdapterType;

  /**
   * Key vault reference to the value that will be placed in the registry location
   */
  keyVaultSecretReference?: KeyVaultReferenceWithStatus;
}
/**
 * Object to hold key vault reference and the resolution status
 */
model KeyVaultReferenceWithStatus {
  /**
   * Key vault secret URI.
   */
  secretUri?: string;

  /**
   * Reference status of the key vault secret.
   */
  referenceStatus?: string;
}
/**
 * Server farm install script configuration.
 */
model InstallScript {
  /**
   * Name of the install script.
   */
  name?: string;

  /**
   * Source of the install script.
   */
  source?: InstallScriptSource;
}
/**
 * Object to hold install script reference.
 */
model InstallScriptSource {
  /**
   * Install script source URI where the install script file will be fetched from.
   */
  sourceUri?: string;

  /**
   * Type of the install script.
   */
  type?: InstallScriptType;
}
/**
 * Network settings for an app service plan.
 */
model ServerFarmNetworkSettings {
  /**
   * Azure Resource Manager ID of the Virtual network and subnet to be joined by Regional VNET Integration. This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}
   */
  virtualNetworkSubnetId?: string;
}
/**
 * Server farm storage mount configuration.
 */
model StorageMount {
  /**
   * Name of the storage mount.
   */
  name?: string;

  /**
   * Type of the storage mount.
   */
  type?: StorageMountType;

  /**
   * Source of the fileshare/storage.
   */
  source?: string;

  /**
   * Path on worker where storage will be mounted.
   */
  destinationPath?: string;

  /**
   * KV reference to the credentials to connect to the share.
   */
  credentialsKeyVaultReference?: KeyVaultReferenceWithStatus;
}
