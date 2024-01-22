import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CertificateRegistration;

interface Operations extends Azure.ResourceManager.Operations {}

enum AppServiceCertificateNotRenewableReason {
  RegistrationStatusNotSupportedForRenewal,
  ExpirationNotInRenewalTimeRange,
  SubscriptionNotActive,
}

enum DomainNotRenewableReasons {
  RegistrationStatusNotSupportedForRenewal,
  ExpirationNotInRenewalTimeRange,
  SubscriptionNotActive,
}

/**
 * Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment.
 */
enum LoadBalancingMode {
  None,
  Web,
  Publishing,
  `Web, Publishing`,
}

/**
 * SCM type.
 */
enum ScmType {
  None,
  Dropbox,
  Tfs,
  LocalGit,
  GitHub,
  CodePlexGit,
  CodePlexHg,
  BitbucketGit,
  BitbucketHg,
  ExternalGit,
  ExternalHg,
  OneDrive,
  VSO,
  VSTSRM,
}

/**
 * Defines what this IP filter will be used for. This is to support IP filtering on proxies.
 */
enum IpFilterTag {
  Default,
  XffProxy,
  ServiceTag,
}

/**
 * MinTlsVersion: configures the minimum version of TLS required for SSL requests
 */
enum SupportedTlsVersions {
  `1.0`,
  `1.1`,
  `1.2`,
}

/**
 * State of FTP / FTPS service
 */
enum FtpsState {
  AllAllowed,
  FtpsOnly,
  Disabled,
}

/**
* The type of route this is:
DEFAULT - By default, every app has routes to the local address ranges specified by RFC1918
INHERITED - Routes inherited from the real Virtual Network routes
STATIC - Static route set on the app only

These values will be used for syncing an app's routes with those from a Virtual Network.
*/
enum RouteType {
  DEFAULT,
  INHERITED,
  STATIC,
}

enum ProviderOsTypeSelected {
  Windows,
  Linux,
  WindowsFunctions,
  LinuxFunctions,
  All,
}

enum ProviderStackOsType {
  Windows,
  Linux,
  All,
}

/**
 * Name of a resource type this recommendation applies, e.g. Subscription, ServerFarm, Site.
 */
enum ResourceScopeType {
  ServerFarm,
  Subscription,
  WebSite,
}

/**
 * Resource type used for verification.
 */
enum CheckNameResourceTypes {
  Site,
  Slot,
  HostingEnvironment,
  PublishingUser,
  `Microsoft.Web/sites`,
  `Microsoft.Web/sites/slots`,
  `Microsoft.Web/hostingEnvironments`,
  `Microsoft.Web/publishingUsers`,
}

/**
 * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
 */
enum InAvailabilityReasonType {
  Invalid,
  AlreadyExists,
}

enum SkuName {
  Free,
  Shared,
  Basic,
  Standard,
  Premium,
  Dynamic,
  Isolated,
  IsolatedV2,
  PremiumV2,
  PremiumV3,
  PremiumContainer,
  ElasticPremium,
  ElasticIsolated,
}

/**
 * Resource type used for verification.
 */
enum ValidateResourceTypes {
  ServerFarm,
  Site,
  `Microsoft.Web/hostingEnvironments`,
}

/**
 * The status of the static site build.
 */
enum BuildStatus {
  WaitingForDeployment,
  Uploading,
  Deploying,
  Ready,
  Failed,
  Deleting,
  Detached,
}

/**
 * The trigger type of the function
 */
enum TriggerTypes {
  HttpTrigger,
  Unknown,
}

/**
 * The status of the custom domain
 */
enum CustomDomainStatus {
  RetrievingValidationToken,
  Validating,
  Adding,
  Ready,
  Failed,
  Deleting,
}

/**
 * Database type (e.g. SqlAzure / MySql).
 */
enum DatabaseType {
  SqlAzure,
  MySql,
  LocalMySql,
  PostgreSql,
}

/**
* Name of the format. Valid values are: 
FileZilla3
WebDeploy -- default
Ftp
*/
enum PublishingProfileFormat {
  FileZilla3,
  WebDeploy,
  Ftp,
}

/**
 * Status of the Key Vault secret.
 */
@fixed
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
 * Certificate product type.
 */
@fixed
enum CertificateProductType {
  StandardDomainValidatedSsl,
  StandardDomainValidatedWildCardSsl,
}

/**
 * Status of certificate order.
 */
@fixed
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  InProgress,
  Deleting,
}

/**
 * Current order status.
 */
@fixed
enum CertificateOrderStatus {
  Pendingissuance,
  Issued,
  Revoked,
  Canceled,
  Denied,
  Pendingrevocation,
  PendingRekey,
  Unused,
  Expired,
  NotSubmitted,
}

/**
 * Action type.
 */
@fixed
enum CertificateOrderActionType {
  CertificateIssued,
  CertificateOrderCanceled,
  CertificateOrderCreated,
  CertificateRevoked,
  DomainValidationComplete,
  FraudDetected,
  OrgNameChange,
  OrgValidationComplete,
  SanDrop,
  FraudCleared,
  CertificateExpired,
  CertificateExpirationWarning,
  FraudDocumentationRequired,
  Unknown,
}

/**
 * Whether this detector is an Analysis Detector or not.
 */
@fixed
enum DetectorType {
  Detector,
  Analysis,
  CategoryOverview,
}

/**
 * Rendering Type
 */
@fixed
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
@fixed
enum InsightStatus {
  Critical,
  Warning,
  Info,
  Success,
  None,
}

/**
 * Valid values are Regular domain: Azure will charge the full price of domain registration, SoftDeleted: Purchasing this domain will simply restore it and this operation will not cost anything.
 */
@fixed
enum DomainType {
  Regular,
  SoftDeleted,
}

/**
 * Domain registration status.
 */
@fixed
enum DomainStatus {
  Active,
  Awaiting,
  Cancelled,
  Confiscated,
  Disabled,
  Excluded,
  Expired,
  Failed,
  Held,
  Locked,
  Parked,
  Pending,
  Reserved,
  Reverted,
  Suspended,
  Transferred,
  Unknown,
  Unlocked,
  Unparked,
  Updated,
  JsonConverterFailed,
}

/**
 * Type of the Azure resource the hostname is assigned to.
 */
@fixed
enum AzureResourceType {
  Website,
  TrafficManager,
}

/**
 * Type of the DNS record.
 */
@fixed
enum CustomHostNameDnsRecordType {
  CName,
  A,
}

/**
 * Type of the hostname.
 */
@fixed
enum HostNameType {
  Verified,
  Managed,
}

/**
 * Current DNS type
 */
@fixed
enum DnsType {
  AzureDns,
  DefaultDomainRegistrarDns,
}

/**
 * Current status of the App Service Environment.
 */
@fixed
enum HostingEnvironmentStatus {
  Preparing,
  Ready,
  Scaling,
  Deleting,
}

/**
 * Shared/dedicated workers.
 */
@fixed
enum ComputeModeOptions {
  Shared,
  Dedicated,
  Dynamic,
}

/**
 * Size of the machines.
 */
@fixed
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
 * The current status of the operation.
 */
@fixed
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
@fixed
enum StatusOptions {
  Ready,
  Pending,
  Creating,
}

/**
 * State indicating whether the app has exceeded its quota usage. Read-only.
 */
@fixed
enum UsageState {
  Normal,
  Exceeded,
}

/**
 * Management information availability state for the app.
 */
@fixed
enum SiteAvailabilityState {
  Normal,
  Limited,
  DisasterRecoveryMode,
}

/**
 * SSL type.
 */
@fixed
enum SslState {
  Disabled,
  SniEnabled,
  IpBasedEnabled,
}

/**
 * Indicates whether the hostname is a standard or repository hostname.
 */
@fixed
enum HostType {
  Standard,
  Repository,
}

/**
 * Type of database.
 */
@fixed
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
@fixed
enum ManagedPipelineMode {
  Integrated,
  Classic,
}

/**
 * Site load balancing.
 */
@fixed
enum SiteLoadBalancing {
  WeightedRoundRobin,
  LeastRequests,
  LeastResponseTime,
  WeightedTotalTraffic,
  RequestHash,
  PerSiteRoundRobin,
}

/**
 * Predefined action to be taken.
 */
@fixed
enum AutoHealActionType {
  Recycle,
  LogEvent,
  CustomAction,
}

/**
 * Type of storage.
 */
@fixed
enum AzureStorageType {
  AzureFiles,
  AzureBlob,
}

/**
 * State of the storage account.
 */
@fixed
enum AzureStorageState {
  Ok,
  InvalidCredentials,
  InvalidShare,
  NotValidated,
}

/**
* This composes with ClientCertEnabled setting.
- ClientCertEnabled: false means ClientCert is ignored.
- ClientCertEnabled: true and ClientCertMode: Required means ClientCert is required.
- ClientCertEnabled: true and ClientCertMode: Optional means ClientCert is optional or accepted.
*/
@fixed
enum ClientCertMode {
  Required,
  Optional,
  OptionalInteractiveUser,
}

/**
 * Site redundancy mode
 */
@fixed
enum RedundancyMode {
  None,
  Manual,
  Failover,
  ActiveActive,
  GeoRedundant,
}

/**
 * Type of managed service identity.
 */
@fixed
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * Represents the type of the Detector
 */
@fixed
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
@fixed
enum SolutionType {
  QuickSolution,
  DeepInvestigation,
  BestPractices,
}

/**
 * Provisioning state of the Kubernetes Environment.
 */
@fixed
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

@fixed
enum StorageType {
  LocalNode,
  NetworkFileSystem,
}

@fixed
enum FrontEndServiceType {
  NodePort,
  LoadBalancer,
}

/**
 * Function App stack preferred OS.
 */
@fixed
enum StackPreferredOs {
  Windows,
  Linux,
}

/**
 * Level indicating how critical this recommendation can impact.
 */
@fixed
enum NotificationLevel {
  Critical,
  Warning,
  Information,
  NonUrgentSuggestion,
}

/**
 * List of channels that this recommendation can apply.
 */
@fixed
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
@fixed
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
@fixed
enum StagingEnvironmentPolicy {
  Enabled,
  Disabled,
}

/**
 * DNS verification test result.
 */
@fixed
enum DnsVerificationTestResult {
  Passed,
  Failed,
  Skipped,
}

/**
 * The unit of time for how often the backup should be executed (e.g. for weekly backup, this should be set to Day and FrequencyInterval should be set to 7)
 */
@fixed
enum FrequencyUnit {
  Day,
  Hour,
}

/**
 * Backup status.
 */
@fixed
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
@fixed
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
@fixed
enum UnauthenticatedClientAction {
  RedirectToLoginPage,
  AllowAnonymous,
}

/**
* The default authentication provider to use when multiple providers are configured.
This setting is only needed if multiple providers are configured and the unauthenticated client
action is set to "RedirectToLoginPage".
*/
@fixed
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
@fixed
enum UnauthenticatedClientActionV2 {
  RedirectToLoginPage,
  AllowAnonymous,
  Return401,
  Return403,
}

/**
 * The convention used when determining the session cookie's expiration.
 */
@fixed
enum CookieExpirationConvention {
  FixedTime,
  IdentityProviderDerived,
}

/**
 * The convention used to determine the url of the request made.
 */
@fixed
enum ForwardProxyConvention {
  NoProxy,
  Standard,
  Custom,
}

@fixed
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
@fixed
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
@fixed
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
@fixed
enum WebJobType {
  Continuous,
  Triggered,
}

/**
 * Provisioning state
 */
@fixed
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
@fixed
enum MSDeployLogEntryType {
  Message,
  Warning,
  Error,
}

@fixed
enum SiteRuntimeState {
  READY,
  STOPPED,
  UNKNOWN,
}

/**
 * Name of app.
 */
@fixed
enum CloneAbilityResult {
  Cloneable,
  PartiallyCloneable,
  NotCloneable,
}

/**
 * The type of migration operation to be done
 */
@fixed
enum MySqlMigrationType {
  LocalToRemote,
  RemoteToLocal,
}

/**
 * Public Certificate Location
 */
@fixed
enum PublicCertificateLocation {
  CurrentUserMy,
  LocalMachineMy,
  Unknown,
}

/**
 * Site extension type.
 */
@fixed
enum SiteExtensionType {
  Gallery,
  WebRoot,
}

/**
 * Job status.
 */
@fixed
enum TriggeredWebJobStatus {
  Success,
  Failed,
  Error,
}

/**
 * AppServiceCertificateOrder resource specific properties
 */
model AppServiceCertificateOrderProperties {
  /**
   * State of the Key Vault secret.
   */
  certificates?: Record<AppServiceCertificate>;

  /**
   * Certificate distinguished name.
   */
  @visibility("read", "create")
  distinguishedName?: string;

  /**
   * Domain verification token.
   */
  @visibility("read")
  domainVerificationToken?: string;

  /**
   * Duration in years (must be 1).
   */
  @visibility("read", "create")
  validityInYears?: int32 = 1;

  /**
   * Certificate key size.
   */
  @visibility("read", "create")
  keySize?: int32 = 2048;

  /**
   * Certificate product type.
   */
  @visibility("read", "create")
  productType: CertificateProductType;

  /**
   * <code>true</code> if the certificate should be automatically renewed when it expires; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * Status of certificate order.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Current order status.
   */
  @visibility("read")
  status?: CertificateOrderStatus;

  /**
   * Signed certificate.
   */
  @visibility("read")
  signedCertificate?: CertificateDetails;

  /**
   * Last CSR that was created for this order.
   */
  @visibility("read", "create")
  csr?: string;

  /**
   * Intermediate certificate.
   */
  @visibility("read")
  intermediate?: CertificateDetails;

  /**
   * Root certificate.
   */
  @visibility("read")
  root?: CertificateDetails;

  /**
   * Current serial number of the certificate.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Certificate last issuance time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCertificateIssuanceTime?: utcDateTime;

  /**
   * Certificate expiration time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * <code>true</code> if private key is external; otherwise, <code>false</code>.
   */
  @visibility("read")
  isPrivateKeyExternal?: boolean;

  /**
   * Reasons why App Service Certificate is not renewable at the current moment.
   */
  @visibility("read")
  appServiceCertificateNotRenewableReasons?: AppServiceCertificateNotRenewableReason[];

  /**
   * Time stamp when the certificate would be auto renewed next
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextAutoRenewalTimeStamp?: utcDateTime;

  /**
   * Contact info
   */
  @visibility("read")
  contact?: CertificateOrderContact;
}

/**
 * Key Vault container for a certificate that is purchased through Azure.
 */
model AppServiceCertificate {
  /**
   * Key Vault resource Id.
   */
  keyVaultId?: string;

  /**
   * Key Vault secret name.
   */
  keyVaultSecretName?: string;

  /**
   * Status of the Key Vault secret.
   */
  @visibility("read")
  provisioningState?: KeyVaultSecretStatus;
}

/**
 * SSL certificate details.
 */
model CertificateDetails {
  /**
   * Certificate Version.
   */
  @visibility("read")
  version?: int32;

  /**
   * Certificate Serial Number.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Certificate Thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Certificate Subject.
   */
  @visibility("read")
  subject?: string;

  /**
   * Date Certificate is valid from.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notBefore?: utcDateTime;

  /**
   * Date Certificate is valid to.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notAfter?: utcDateTime;

  /**
   * Certificate Signature algorithm.
   */
  @visibility("read")
  signatureAlgorithm?: string;

  /**
   * Certificate Issuer.
   */
  @visibility("read")
  issuer?: string;

  /**
   * Raw certificate data.
   */
  @visibility("read")
  rawData?: string;
}

model CertificateOrderContact {
  email?: string;
  nameFirst?: string;
  nameLast?: string;
  phone?: string;
}

/**
 * Azure resource. This resource is tracked in Azure Resource Manager
 */
model Resource {
  /**
   * Resource Id.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource Name.
   */
  @visibility("read")
  name?: string;

  /**
   * Kind of resource.
   */
  kind?: string;

  /**
   * Resource Location.
   */
  location: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * App Service error response.
 */
@error
model DefaultErrorResponse {
  /**
   * Error model.
   */
  @visibility("read")
  error?: DefaultErrorResponseError;
}

/**
 * Error model.
 */
model DefaultErrorResponseError {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility("read")
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  target?: string;

  details?: DefaultErrorResponseErrorDetailsItem[];

  /**
   * More information to debug error.
   */
  @visibility("read")
  innererror?: string;
}

/**
 * Detailed errors.
 */
model DefaultErrorResponseErrorDetailsItem {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility("read")
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  target?: string;
}

/**
 * ARM resource for a certificate order that is purchased through Azure.
 */
model AppServiceCertificateOrderPatchResource extends ProxyOnlyResource {
  /**
   * AppServiceCertificateOrderPatchResource resource specific properties
   */
  properties?: AppServiceCertificateOrderPatchResourceProperties;
}

/**
 * AppServiceCertificateOrderPatchResource resource specific properties
 */
model AppServiceCertificateOrderPatchResourceProperties {
  /**
   * State of the Key Vault secret.
   */
  certificates?: Record<AppServiceCertificate>;

  /**
   * Certificate distinguished name.
   */
  @visibility("read", "create")
  distinguishedName?: string;

  /**
   * Domain verification token.
   */
  @visibility("read")
  domainVerificationToken?: string;

  /**
   * Duration in years (must be 1).
   */
  @visibility("read", "create")
  validityInYears?: int32 = 1;

  /**
   * Certificate key size.
   */
  @visibility("read", "create")
  keySize?: int32 = 2048;

  /**
   * Certificate product type.
   */
  @visibility("read", "create")
  productType: CertificateProductType;

  /**
   * <code>true</code> if the certificate should be automatically renewed when it expires; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * Status of certificate order.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Current order status.
   */
  @visibility("read")
  status?: CertificateOrderStatus;

  /**
   * Signed certificate.
   */
  @visibility("read")
  signedCertificate?: CertificateDetails;

  /**
   * Last CSR that was created for this order.
   */
  @visibility("read", "create")
  csr?: string;

  /**
   * Intermediate certificate.
   */
  @visibility("read")
  intermediate?: CertificateDetails;

  /**
   * Root certificate.
   */
  @visibility("read")
  root?: CertificateDetails;

  /**
   * Current serial number of the certificate.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Certificate last issuance time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCertificateIssuanceTime?: utcDateTime;

  /**
   * Certificate expiration time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * <code>true</code> if private key is external; otherwise, <code>false</code>.
   */
  @visibility("read")
  isPrivateKeyExternal?: boolean;

  /**
   * Reasons why App Service Certificate is not renewable at the current moment.
   */
  @visibility("read")
  appServiceCertificateNotRenewableReasons?: AppServiceCertificateNotRenewableReason[];

  /**
   * Time stamp when the certificate would be auto renewed next
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextAutoRenewalTimeStamp?: utcDateTime;

  /**
   * Contact info
   */
  @visibility("read")
  contact?: CertificateOrderContact;
}

/**
 * Azure proxy only resource. This resource is not tracked by Azure Resource Manager.
 */
model ProxyOnlyResource {
  /**
   * Resource Id.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource Name.
   */
  @visibility("read")
  name?: string;

  /**
   * Kind of resource.
   */
  kind?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;
}

/**
 * Key Vault container ARM resource for a certificate that is purchased through Azure.
 */
model AppServiceCertificatePatchResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  properties?: AppServiceCertificate;
}

/**
 * Class representing certificate reissue request.
 */
model ReissueCertificateOrderRequest extends ProxyOnlyResource {
  /**
   * ReissueCertificateOrderRequest resource specific properties
   */
  properties?: ReissueCertificateOrderRequestProperties;
}

/**
 * ReissueCertificateOrderRequest resource specific properties
 */
model ReissueCertificateOrderRequestProperties {
  /**
   * Certificate Key Size.
   */
  keySize?: int32;

  /**
   * Delay in hours to revoke existing certificate after the new certificate is issued.
   */
  delayExistingRevokeInHours?: int32;

  /**
   * Csr to be used for re-key operation.
   */
  csr?: string;

  /**
   * Should we change the ASC type (from managed private key to external private key and vice versa).
   */
  isPrivateKeyExternal?: boolean;
}

/**
 * Class representing certificate renew request.
 */
model RenewCertificateOrderRequest extends ProxyOnlyResource {
  /**
   * RenewCertificateOrderRequest resource specific properties
   */
  properties?: RenewCertificateOrderRequestProperties;
}

/**
 * RenewCertificateOrderRequest resource specific properties
 */
model RenewCertificateOrderRequestProperties {
  /**
   * Certificate Key Size.
   */
  keySize?: int32;

  /**
   * Csr to be used for re-key operation.
   */
  csr?: string;

  /**
   * Should we change the ASC type (from managed private key to external private key and vice versa).
   */
  isPrivateKeyExternal?: boolean;
}

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
 * Site seal request.
 */
model SiteSealRequest {
  /**
   * If <code>true</code> use the light color theme for site seal; otherwise, use the default color theme.
   */
  lightTheme?: boolean;

  /**
   * Locale of site seal.
   */
  locale?: string;
}

/**
 * Site seal
 */
model SiteSeal {
  /**
   * HTML snippet
   */
  html: string;
}

/**
 * Certificate order action.
 */
model CertificateOrderAction extends ProxyOnlyResource {
  /**
   * CertificateOrderAction resource specific properties
   */
  properties?: CertificateOrderActionProperties;
}

/**
 * CertificateOrderAction resource specific properties
 */
model CertificateOrderActionProperties {
  /**
   * Action type.
   */
  @visibility("read")
  actionType?: CertificateOrderActionType;

  /**
   * Time at which the certificate action was performed.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;
}

/**
 * SSL certificate email.
 */
model CertificateEmail extends ProxyOnlyResource {
  /**
   * CertificateEmail resource specific properties
   */
  properties?: CertificateEmailProperties;
}

/**
 * CertificateEmail resource specific properties
 */
model CertificateEmailProperties {
  /**
   * Email id.
   */
  emailId?: string;

  /**
   * Time stamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;
}

/**
 * DetectorResponse resource specific properties
 */
model DetectorResponseProperties {
  /**
   * metadata for the detector
   */
  metadata?: DetectorInfo;

  /**
   * Data Set
   */
  dataset?: DiagnosticData[];

  /**
   * Indicates status of the most severe insight.
   */
  status?: Status;

  /**
   * Additional configuration for different data providers to be used by the UI
   */
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
  @visibility("read")
  id?: string;

  /**
   * Name of detector
   */
  @visibility("read")
  name?: string;

  /**
   * Short description of the detector and its purpose.
   */
  @visibility("read")
  description?: string;

  /**
   * Author of the detector.
   */
  @visibility("read")
  author?: string;

  /**
   * Problem category. This serves for organizing group for detectors.
   */
  @visibility("read")
  category?: string;

  /**
   * List of Support Topics for which this detector is enabled.
   */
  @visibility("read")
  supportTopicList?: SupportTopic[];

  /**
   * Analysis Types for which this detector should apply to.
   */
  @visibility("read")
  analysisType?: string[];

  /**
   * Whether this detector is an Analysis Detector or not.
   */
  @visibility("read")
  type?: DetectorType;

  /**
   * Defines score of a detector to power ML based matching.
   */
  @visibility("read")
  score?: float32;
}

/**
 * Defines a unique Support Topic
 */
model SupportTopic {
  /**
   * Support Topic Id
   */
  @visibility("read")
  id?: string;

  /**
   * Unique resource Id
   */
  @visibility("read")
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
  columns?: DataTableResponseColumn[];

  /**
   * Raw row values
   */
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
  providerName?: string;

  /**
   * Settings for the data provider
   */
  @visibility("read")
  propertyBag?: KeyValuePairStringObject[];
}

model KeyValuePairStringObject {
  @visibility("read")
  key?: string;

  /**
   * Any object
   */
  @visibility("read")
  value?: Record<unknown>;
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
 * Description of an operation available for Microsoft.Web resource provider.
 */
model CsmOperationDescription {
  name?: string;
  isDataAction?: boolean;

  /**
   * Meta data about operation used for display in portal.
   */
  display?: CsmOperationDisplay;

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
  provider?: string;
  resource?: string;
  operation?: string;
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
  metricSpecifications?: MetricSpecification[];
  logSpecifications?: LogSpecification[];
}

/**
 * Definition of a single resource metric.
 */
model MetricSpecification {
  name?: string;
  displayName?: string;
  displayDescription?: string;
  unit?: string;
  aggregationType?: string;
  supportsInstanceLevelAggregation?: boolean;
  enableRegionalMdmAccount?: boolean;
  sourceMdmAccount?: string;
  sourceMdmNamespace?: string;
  metricFilterPattern?: string;
  fillGapWithZero?: boolean;
  isInternal?: boolean;
  dimensions?: Dimension[];
  category?: string;
  availabilities?: MetricAvailability[];
  supportedTimeGrainTypes?: string[];
  supportedAggregationTypes?: string[];
}

/**
* Dimension of a resource metric. For e.g. instance specific HTTP requests for a web app, 
where instance name is dimension of the metric HTTP request
*/
model Dimension {
  name?: string;
  displayName?: string;
  internalName?: string;
  toBeExportedForShoebox?: boolean;
}

/**
 * Retention policy of a resource metric.
 */
model MetricAvailability {
  timeGrain?: string;
  blobDuration?: duration;
}

/**
 * Log Definition of a single resource metric.
 */
model LogSpecification {
  name?: string;
  displayName?: string;
  blobDuration?: duration;
  logFilterPattern?: string;
}

/**
 * Domain availability check result.
 */
model DomainAvailabilityCheckResult {
  /**
   * Name of the domain.
   */
  name?: string;

  /**
   * <code>true</code> if domain can be purchased using CreateDomain API; otherwise, <code>false</code>.
   */
  available?: boolean;

  /**
   * Valid values are Regular domain: Azure will charge the full price of domain registration, SoftDeleted: Purchasing this domain will simply restore it and this operation will not cost anything.
   */
  domainType?: DomainType;
}

/**
 * Domain resource specific properties
 */
model DomainProperties {
  /**
   * Administrative contact.
   */
  @visibility("create")
  contactAdmin: Contact;

  /**
   * Billing contact.
   */
  @visibility("create")
  contactBilling: Contact;

  /**
   * Registrant contact.
   */
  @visibility("create")
  contactRegistrant: Contact;

  /**
   * Technical contact.
   */
  @visibility("create")
  contactTech: Contact;

  /**
   * Domain registration status.
   */
  @visibility("read")
  registrationStatus?: DomainStatus;

  /**
   * Domain provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Name servers.
   */
  @visibility("read")
  nameServers?: string[];

  /**
   * <code>true</code> if domain privacy is enabled for this domain; otherwise, <code>false</code>.
   */
  privacy?: boolean;

  /**
   * Domain creation timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Domain expiration timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Timestamp when the domain was renewed last time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRenewedTime?: utcDateTime;

  /**
   * <code>true</code> if the domain should be automatically renewed; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * <code>true</code> if Azure can assign this domain to App Service apps; otherwise, <code>false</code>. This value will be <code>true</code> if domain registration status is active and
   * it is hosted on name servers Azure has programmatic access to.
   */
  @visibility("read")
  readyForDnsRecordManagement?: boolean;

  /**
   * All hostnames derived from the domain and assigned to Azure resources.
   */
  @visibility("read")
  managedHostNames?: HostName[];

  /**
   * Legal agreement consent.
   */
  @visibility("create")
  consent: DomainPurchaseConsent;

  /**
   * Reasons why domain is not renewable.
   */
  @visibility("read")
  domainNotRenewableReasons?: DomainNotRenewableReasons[];

  /**
   * Current DNS type
   */
  dnsType?: DnsType;

  /**
   * Azure DNS Zone to use
   */
  dnsZoneId?: string;

  /**
   * Target DNS type (would be used for migration)
   */
  targetDnsType?: DnsType;

  @visibility("read", "create")
  authCode?: string;
}

/**
* Contact information for domain registration. If 'Domain Privacy' option is not selected then the contact information is made publicly available through the Whois 
directories as per ICANN requirements.
*/
model Contact {
  /**
   * Mailing address.
   */
  addressMailing?: Address;

  /**
   * Email address.
   */
  email: string;

  /**
   * Fax number.
   */
  fax?: string;

  /**
   * Job title.
   */
  jobTitle?: string;

  /**
   * First name.
   */
  nameFirst: string;

  /**
   * Last name.
   */
  nameLast: string;

  /**
   * Middle name.
   */
  nameMiddle?: string;

  /**
   * Organization contact belongs to.
   */
  organization?: string;

  /**
   * Phone number.
   */
  phone: string;
}

/**
 * Address information for domain registration.
 */
model Address {
  /**
   * First line of an Address.
   */
  address1: string;

  /**
   * The second line of the Address. Optional.
   */
  address2?: string;

  /**
   * The city for the address.
   */
  city: string;

  /**
   * The country for the address.
   */
  country: string;

  /**
   * The postal code for the address.
   */
  postalCode: string;

  /**
   * The state or province for the address.
   */
  state: string;
}

/**
 * Details of a hostname derived from a domain.
 */
model HostName {
  /**
   * Name of the hostname.
   */
  name?: string;

  /**
   * List of apps the hostname is assigned to. This list will have more than one app only if the hostname is pointing to a Traffic Manager.
   */
  siteNames?: string[];

  /**
   * Name of the Azure resource the hostname is assigned to. If it is assigned to a Traffic Manager then it will be the Traffic Manager name otherwise it will be the app name.
   */
  azureResourceName?: string;

  /**
   * Type of the Azure resource the hostname is assigned to.
   */
  azureResourceType?: AzureResourceType;

  /**
   * Type of the DNS record.
   */
  customHostNameDnsRecordType?: CustomHostNameDnsRecordType;

  /**
   * Type of the hostname.
   */
  hostNameType?: HostNameType;
}

/**
 * Domain purchase consent object, representing acceptance of applicable legal agreements.
 */
model DomainPurchaseConsent {
  /**
   * List of applicable legal agreement keys. This list can be retrieved using ListLegalAgreements API under <code>TopLevelDomain</code> resource.
   */
  agreementKeys?: string[];

  /**
   * Client IP address.
   */
  agreedBy?: string;

  /**
   * Timestamp when the agreements were accepted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agreedAt?: utcDateTime;
}

/**
 * Single sign-on request information for domain management.
 */
model DomainControlCenterSsoRequest {
  /**
   * URL where the single sign-on request is to be made.
   */
  @visibility("read")
  url?: string;

  /**
   * Post parameter key.
   */
  @visibility("read")
  postParameterKey?: string;

  /**
   * Post parameter value. Client should use 'application/x-www-form-urlencoded' encoding for this value.
   */
  @visibility("read")
  postParameterValue?: string;
}

/**
 * Domain recommendation search parameters.
 */
model DomainRecommendationSearchParameters {
  /**
   * Keywords to be used for generating domain recommendations.
   */
  keywords?: string;

  /**
   * Maximum number of recommendations.
   */
  maxDomainRecommendations?: int32;
}

/**
 * Collection of domain name identifiers.
 */
model NameIdentifierCollection is Azure.Core.Page<NameIdentifier>;

/**
 * ARM resource for a domain.
 */
model DomainPatchResource extends ProxyOnlyResource {
  /**
   * DomainPatchResource resource specific properties
   */
  properties?: DomainPatchResourceProperties;
}

/**
 * DomainPatchResource resource specific properties
 */
model DomainPatchResourceProperties {
  /**
   * Administrative contact.
   */
  @visibility("create")
  contactAdmin: Contact;

  /**
   * Billing contact.
   */
  @visibility("create")
  contactBilling: Contact;

  /**
   * Registrant contact.
   */
  @visibility("create")
  contactRegistrant: Contact;

  /**
   * Technical contact.
   */
  @visibility("create")
  contactTech: Contact;

  /**
   * Domain registration status.
   */
  @visibility("read")
  registrationStatus?: DomainStatus;

  /**
   * Domain provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Name servers.
   */
  @visibility("read")
  nameServers?: string[];

  /**
   * <code>true</code> if domain privacy is enabled for this domain; otherwise, <code>false</code>.
   */
  privacy?: boolean;

  /**
   * Domain creation timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Domain expiration timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Timestamp when the domain was renewed last time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRenewedTime?: utcDateTime;

  /**
   * <code>true</code> if the domain should be automatically renewed; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * <code>true</code> if Azure can assign this domain to App Service apps; otherwise, <code>false</code>. This value will be <code>true</code> if domain registration status is active and
   * it is hosted on name servers Azure has programmatic access to.
   */
  @visibility("read")
  readyForDnsRecordManagement?: boolean;

  /**
   * All hostnames derived from the domain and assigned to Azure resources.
   */
  @visibility("read")
  managedHostNames?: HostName[];

  /**
   * Legal agreement consent.
   */
  @visibility("create")
  consent: DomainPurchaseConsent;

  /**
   * Reasons why domain is not renewable.
   */
  @visibility("read")
  domainNotRenewableReasons?: DomainNotRenewableReasons[];

  /**
   * Current DNS type
   */
  dnsType?: DnsType;

  /**
   * Azure DNS Zone to use
   */
  dnsZoneId?: string;

  /**
   * Target DNS type (would be used for migration)
   */
  targetDnsType?: DnsType;

  @visibility("read", "create")
  authCode?: string;
}

/**
 * DomainOwnershipIdentifier resource specific properties
 */
model DomainOwnershipIdentifierProperties {
  /**
   * Ownership Id.
   */
  ownershipId?: string;
}

/**
 * TopLevelDomain resource specific properties
 */
model TopLevelDomainProperties {
  /**
   * If <code>true</code>, then the top level domain supports domain privacy; otherwise, <code>false</code>.
   */
  privacy?: boolean;
}

/**
 * Options for retrieving the list of top level domain legal agreements.
 */
model TopLevelDomainAgreementOption {
  /**
   * If <code>true</code>, then the list of agreements will include agreements for domain privacy as well; otherwise, <code>false</code>.
   */
  includePrivacy?: boolean;

  /**
   * If <code>true</code>, then the list of agreements will include agreements for domain transfer as well; otherwise, <code>false</code>.
   */
  forTransfer?: boolean;
}

/**
 * Collection of top-level domain legal agreements.
 */
model TldLegalAgreementCollection is Azure.Core.Page<TldLegalAgreement>;

/**
 * Legal agreement for a top level domain.
 */
model TldLegalAgreement {
  /**
   * Unique identifier for the agreement.
   */
  agreementKey: string;

  /**
   * Agreement title.
   */
  title: string;

  /**
   * Agreement details.
   */
  content: string;

  /**
   * URL where a copy of the agreement details is hosted.
   */
  url?: string;
}

/**
 * Description of an App Service Environment.
 */
model AppServiceEnvironment {
  /**
   * Provisioning state of the App Service Environment.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Current status of the App Service Environment.
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  maximumNumberOfMachines?: int32;

  /**
   * Scale factor for front-ends.
   */
  frontEndScaleFactor?: int32;

  /**
* <code>true</code> if the App Service Environment is suspended; otherwise, <code>false</code>. The environment can be suspended, e.g. when the management endpoint is no longer available
 (most likely because NSG blocked the incoming traffic).
*/
  @visibility("read")
  suspended?: boolean;

  /**
   * Custom settings for changing the behavior of the App Service Environment.
   */
  clusterSettings?: NameValuePair[];

  /**
   * User added ip ranges to whitelist on ASE db
   */
  userWhitelistedIpRanges?: string[];

  /**
   * Flag that displays whether an ASE has linux workers or not
   */
  @visibility("read")
  hasLinuxWorkers?: boolean;

  /**
   * Dedicated Host Count
   */
  dedicatedHostCount?: int32;

  /**
   * Whether or not this App Service Environment is zone-redundant.
   */
  zoneRedundant?: boolean;
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
  @visibility("read")
  name?: string;

  /**
   * Resource type of the Virtual Network (read-only).
   */
  @visibility("read")
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
 * ARM resource for a app service environment.
 */
model AppServiceEnvironmentPatchResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  properties?: AppServiceEnvironment;
}

/**
 * Collection of stamp capacities.
 */
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
0 - Small
1 - Medium
2 - Large
*/
  workerSizeId?: int32;

  /**
* If <code>true</code>, it includes basic apps.
Basic apps are not used for capacity allocation.
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
 * Describes main public IP address and any extra virtual IPs.
 */
model AddressResponse extends ProxyOnlyResource {
  /**
   * AddressResponse resource specific properties
   */
  properties?: AddressResponseProperties;
}

/**
 * AddressResponse resource specific properties
 */
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
  vipMappings?: VirtualIPMapping[];
}

/**
 * Virtual IP mapping.
 */
model VirtualIPMapping {
  /**
   * Virtual IP address.
   */
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
 * AseV3NetworkingConfiguration resource specific properties
 */
model AseV3NetworkingConfigurationProperties {
  @visibility("read")
  windowsOutboundIpAddresses?: string[];

  @visibility("read")
  linuxOutboundIpAddresses?: string[];

  @visibility("read")
  externalInboundIpAddresses?: string[];

  @visibility("read")
  internalInboundIpAddresses?: string[];

  /**
   * Property to enable and disable new private endpoint connection creation on ASE
   */
  allowNewPrivateEndpointConnections?: boolean;
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
 * Worker pool of an App Service Environment.
 */
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
  @visibility("read")
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
model ResourceMetricDefinition extends ProxyOnlyResource {
  /**
   * ResourceMetricDefinition resource specific properties
   */
  properties?: ResourceMetricDefinitionProperties;
}

/**
 * ResourceMetricDefinition resource specific properties
 */
model ResourceMetricDefinitionProperties {
  /**
   * Unit of the metric.
   */
  @visibility("read")
  unit?: string;

  /**
   * Primary aggregation type.
   */
  @visibility("read")
  primaryAggregationType?: string;

  /**
   * List of time grains supported for the metric together with retention period.
   */
  @visibility("read")
  metricAvailabilities?: ResourceMetricAvailability[];

  /**
   * Resource URI.
   */
  @visibility("read")
  resourceUri?: string;

  /**
   * Resource metric definition properties.
   */
  @visibility("read")
  properties?: Record<string>;
}

/**
 * Metrics availability and retention.
 */
model ResourceMetricAvailability {
  /**
   * Time grain .
   */
  @visibility("read")
  timeGrain?: string;

  /**
   * Retention period for the current time grain.
   */
  @visibility("read")
  retention?: string;
}

/**
 * Collection of SKU information.
 */
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
model Usage extends ProxyOnlyResource {
  /**
   * Usage resource specific properties
   */
  properties?: UsageProperties;
}

/**
 * Usage resource specific properties
 */
model UsageProperties {
  /**
   * Friendly name shown in the UI.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Name of the quota resource.
   */
  @visibility("read")
  resourceName?: string;

  /**
   * Units of measurement for the quota resource.
   */
  @visibility("read")
  unit?: string;

  /**
   * The current value of the resource counter.
   */
  @visibility("read")
  currentValue?: int64;

  /**
   * The resource limit.
   */
  @visibility("read")
  limit?: int64;

  /**
   * Next reset time for the resource counter.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  /**
   * Compute mode used for this usage.
   */
  @visibility("read")
  computeMode?: ComputeModeOptions;

  /**
   * Site mode used for this usage.
   */
  @visibility("read")
  siteMode?: string;
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
  innerErrors?: ErrorEntity[];

  /**
   * Error Details.
   */
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

/**
 * RemotePrivateEndpointConnectionARMResource resource specific properties
 */
model RemotePrivateEndpointConnectionARMResourceProperties {
  @visibility("read")
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
  @visibility("read")
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
 * Private Endpoint Connection Approval ARM resource.
 */
model PrivateLinkConnectionApprovalRequestResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  properties?: PrivateLinkConnectionApprovalRequest;
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
 * Wrapper for a collection of private link resources
 */
model PrivateLinkResourcesWrapper {
  value: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource {
  id: string;

  /**
   * Name of a private link resource
   */
  name: string;

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
  @visibility("read")
  groupId?: string;

  /**
   * RequiredMembers of a private link resource
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * RequiredZoneNames of a private link resource
   */
  @visibility("read")
  requiredZoneNames?: string[];
}

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
  @visibility("read")
  status?: StatusOptions;

  /**
   * App Service plan subscription.
   */
  @visibility("read")
  subscription?: string;

  /**
   * Specification for the App Service Environment to use for the App Service plan.
   */
  @visibility("read", "create")
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * Maximum number of instances that can be assigned to this App Service plan.
   */
  @visibility("read")
  maximumNumberOfWorkers?: int32;

  /**
   * Geographical location for the App Service plan.
   */
  @visibility("read")
  geoRegion?: string;

  /**
* If <code>true</code>, apps assigned to this App Service plan can be scaled independently.
If <code>false</code>, apps assigned to this App Service plan will scale to all instances of the plan.
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
  @visibility("read")
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
  @visibility("read")
  resourceGroup?: string;

  /**
   * If Linux app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility("read", "create")
  reserved?: boolean;

  /**
   * Obsolete: If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility("read", "create")
  isXenon?: boolean;

  /**
   * If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility("read", "create")
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
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Specification for the Kubernetes Environment to use for the App Service plan.
   */
  kubeEnvironmentProfile?: KubeEnvironmentProfile;

  /**
* If <code>true</code>, this App Service Plan will perform availability zone balancing.
If <code>false</code>, this App Service Plan will not perform availability zone balancing.
*/
  zoneRedundant?: boolean;
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
  @visibility("read")
  name?: string;

  /**
   * Resource type of the App Service Environment.
   */
  @visibility("read")
  type?: string;
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
  @visibility("read")
  name?: string;

  /**
   * Resource type of the Kubernetes Environment.
   */
  @visibility("read")
  type?: string;
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
  @visibility("read")
  type?: string;
}

/**
 * Site resource specific properties
 */
model SiteProperties {
  /**
   * Current state of the app.
   */
  @visibility("read")
  state?: string;

  /**
   * Hostnames associated with the app.
   */
  @visibility("read")
  hostNames?: string[];

  /**
   * Name of the repository site.
   */
  @visibility("read")
  repositorySiteName?: string;

  /**
   * State indicating whether the app has exceeded its quota usage. Read-only.
   */
  @visibility("read")
  usageState?: UsageState;

  /**
   * <code>true</code> if the app is enabled; otherwise, <code>false</code>. Setting this value to false disables the app (takes the app offline).
   */
  enabled?: boolean;

  /**
* Enabled hostnames for the app.Hostnames need to be assigned (see HostNames) AND enabled. Otherwise,
the app is not served on those hostnames.
*/
  @visibility("read")
  enabledHostNames?: string[];

  /**
   * Management information availability state for the app.
   */
  @visibility("read")
  availabilityState?: SiteAvailabilityState;

  /**
   * Hostname SSL states are used to manage the SSL bindings for app's hostnames.
   */
  hostNameSslStates?: HostNameSslState[];

  /**
   * Resource ID of the associated App Service plan, formatted as: "/subscriptions/{subscriptionID}/resourceGroups/{groupName}/providers/Microsoft.Web/serverfarms/{appServicePlanName}".
   */
  serverFarmId?: string;

  /**
   * <code>true</code> if reserved; otherwise, <code>false</code>.
   */
  @visibility("read", "create")
  reserved?: boolean;

  /**
   * Obsolete: Hyper-V sandbox.
   */
  @visibility("read", "create")
  isXenon?: boolean;

  /**
   * Hyper-V sandbox.
   */
  @visibility("read", "create")
  hyperV?: boolean;

  /**
   * Last time the app was modified, in UTC. Read-only.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  /**
   * Configuration of the app.
   */
  siteConfig?: SiteConfigProperties;

  /**
   * Azure Traffic Manager hostnames associated with the app. Read-only.
   */
  @visibility("read")
  trafficManagerHostNames?: string[];

  /**
   * <code>true</code> to stop SCM (KUDU) site when the app is stopped; otherwise, <code>false</code>. The default is <code>false</code>.
   */
  scmSiteAlsoStopped?: boolean;

  /**
   * Specifies which deployment slot this app will swap into. Read-only.
   */
  @visibility("read")
  targetSwapSlot?: string;

  /**
   * App Service Environment to use for the app.
   */
  @visibility("read", "create")
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * <code>true</code> to enable client affinity; <code>false</code> to stop sending session affinity cookies, which route client requests in the same session to the same instance. Default is <code>true</code>.
   */
  clientAffinityEnabled?: boolean;

  /**
   * <code>true</code> to enable client certificate authentication (TLS mutual authentication); otherwise, <code>false</code>. Default is <code>false</code>.
   */
  clientCertEnabled?: boolean;

  /**
* This composes with ClientCertEnabled setting.
- ClientCertEnabled: false means ClientCert is ignored.
- ClientCertEnabled: true and ClientCertMode: Required means ClientCert is required.
- ClientCertEnabled: true and ClientCertMode: Optional means ClientCert is optional or accepted.
*/
  clientCertMode?: ClientCertMode;

  /**
   * client certificate authentication comma-separated exclusion paths
   */
  clientCertExclusionPaths?: string;

  /**
* <code>true</code> to disable the public hostnames of the app; otherwise, <code>false</code>.
 If <code>true</code>, the app is only accessible via API management process.
*/
  hostNamesDisabled?: boolean;

  /**
   * Unique identifier that verifies the custom domains assigned to the app. Customer will add this id to a txt record for verification.
   */
  customDomainVerificationId?: string;

  /**
   * List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from tenants that site can be hosted with current settings. Read-only.
   */
  @visibility("read")
  outboundIpAddresses?: string;

  /**
   * List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from all tenants except dataComponent. Read-only.
   */
  @visibility("read")
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspendedTill?: utcDateTime;

  /**
* Maximum number of workers.
This only applies to Functions container.
*/
  @visibility("read")
  maxNumberOfWorkers?: int32;

  /**
   * If specified during app creation, the app is cloned from a source app.
   */
  @visibility("create")
  cloningInfo?: CloningInfo;

  /**
   * Name of the resource group the app belongs to. Read-only.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * <code>true</code> if the app is a default container; otherwise, <code>false</code>.
   */
  @visibility("read")
  isDefaultContainer?: boolean;

  /**
   * Default hostname of the app. Read-only.
   */
  @visibility("read")
  defaultHostName?: string;

  /**
   * Status of the last deployment slot swap operation.
   */
  @visibility("read")
  slotSwapStatus?: SlotSwapStatus;

  /**
* HttpsOnly: configures a web site to accept only https requests. Issues redirect for
http requests
*/
  httpsOnly?: boolean;

  /**
   * Site redundancy mode
   */
  redundancyMode?: RedundancyMode;

  /**
   * Specifies an operation id if this site has a pending operation.
   */
  @visibility("read")
  inProgressOperationId?: string;

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
This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}
*/
  virtualNetworkSubnetId?: string;
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

/**
 * Configuration of an App Service app.
 */
model SiteConfigProperties {
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
   * Application settings.
   */
  appSettings?: NameValuePair[];

  /**
   * Connection strings.
   */
  connectionStrings?: ConnStringInfo[];

  /**
   * Site MachineKey.
   */
  @visibility("read")
  machineKey?: SiteMachineKey;

  /**
   * Handler mappings.
   */
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
  @visibility("read", "create")
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
  localMySqlEnabled?: boolean;

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
  ipSecurityRestrictions?: IpSecurityRestriction[];

  /**
   * IP security restrictions for scm.
   */
  scmIpSecurityRestrictions?: IpSecurityRestriction[];

  /**
   * IP security restrictions for scm to use main.
   */
  scmIpSecurityRestrictionsUseMain?: boolean;

  /**
   * Http20Enabled: configures a web site to allow clients to connect over http2.0
   */
  http20Enabled?: boolean = true;

  /**
   * MinTlsVersion: configures the minimum version of TLS required for SSL requests
   */
  minTlsVersion?: SupportedTlsVersions;

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
This setting only applies to the Consumption and Elastic Plans
*/
  @maxValue(10)
  preWarmedInstanceCount?: int32;

  /**
* Maximum number of workers that a site can scale out to.
This setting only applies to the Consumption and Elastic Premium Plans
*/
  functionAppScaleLimit?: int32;

  /**
   * Health check path
   */
  healthCheckPath?: string;

  /**
* Gets or sets a value indicating whether functions runtime scale monitoring is enabled. When enabled,
the ScaleController will not monitor event sources directly, but will instead call to the
runtime to get scale status.
*/
  functionsRuntimeScaleMonitoringEnabled?: boolean;

  /**
   * Sets the time zone a site uses for generating timestamps. Compatible with Linux and Windows App Service. Setting the WEBSITE_TIME_ZONE app setting takes precedence over this config. For Linux, expects tz database values https://www.iana.org/time-zones (for a quick reference see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). For Windows, expects one of the time zones listed under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones
   */
  websiteTimeZone?: string;

  /**
* Number of minimum instance count for a site
This setting only applies to the Elastic Plans
*/
  @maxValue(20)
  minimumElasticInstanceCount?: int32;

  /**
   * List of Azure Storage Accounts.
   */
  azureStorageAccounts?: Record<AzureStorageInfoValue>;

  /**
   * Property to allow or block all public traffic.
   */
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
  validationKey?: string;

  /**
   * Algorithm used for decryption.
   */
  decryption?: string;

  /**
   * Decryption key.
   */
  decryptionKey?: string;
}

/**
* The IIS handler mappings used to define which handler processes HTTP requests with certain extension. 
For example, it is used to configure php-cgi.exe process to handle all HTTP requests with *.php extension.
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
<code>MaxReroutePercentage</code>. Site metrics are checked every N minutes specified in <code>ChangeIntervalInMinutes</code>.\nCustom decision algorithm 
can be provided in TiPCallback site extension which URL can be specified in <code>ChangeDecisionCallbackUrl</code>.
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
* Custom decision algorithm can be provided in TiPCallback site extension which URL can be specified. See TiPCallback site extension for the scaffold and contracts.
https://www.siteextensions.net/packages/TiPCallback/
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
  privateBytesInKB?: int32;

  /**
   * A rule based on status codes.
   */
  statusCodes?: StatusCodesBasedTrigger[];

  /**
   * A rule based on request execution time.
   */
  slowRequests?: SlowRequestsBasedTrigger;

  /**
   * A rule based on multiple Slow Requests Rule with path
   */
  slowRequestsWithPath?: SlowRequestsBasedTrigger[];

  /**
   * A rule based on status codes ranges.
   */
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
before taking the action
*/
  minProcessExecutionTime?: string;
}

/**
* Custom action to be executed
when an auto heal rule is triggered.
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
calls (for example: http://example.com:12345). Use "*" to allow all.
*/
  allowedOrigins?: string[];

  /**
* Gets or sets whether CORS requests with credentials are allowed. See 
https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS#Requests_with_credentials
for more details.
*/
  supportCredentials?: boolean;
}

/**
 * Push settings for the App.
 */
model PushSettings extends ProxyOnlyResource {
  /**
   * PushSettings resource specific properties
   */
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

  /**
* Gets or sets a JSON string containing a list of tags that require user authentication to be used in the push registration endpoint.
Tags can consist of alphanumeric characters and the following:
'_', '@', '#', '.', ':', '-'. 
Validation should be performed at the PushRequestHandler.
*/
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
It can be in form of pure ipv4 address (required SubnetMask property) or
CIDR notation such as ipv4/mask (leading bit match). For CIDR,
SubnetMask property must not be specified.
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
X-Forwarded-Host (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-Host#Examples). 
The matching logic is ..
- If the property is null or empty (default), all hosts(or lack of) are allowed.
- A value is compared using ordinal-ignore-case (excluding port number).
- Subdomain wildcards are permitted but don't match the root domain. For example, *.contoso.com matches the subdomain foo.contoso.com
 but not the root domain contoso.com or multi-level foo.bar.contoso.com
- Unicode host names are allowed but are converted to Punycode for matching.

X-Forwarded-For (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For#Examples).
The matching logic is ..
- If the property is null or empty (default), any forwarded-for chains (or lack of) are allowed.
- If any address (excluding port number) in the chain (comma separated) matches the CIDR defined by the property.

X-Azure-FDID and X-FD-HealthProbe.
The matching logic is exact match.
*/
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
  accessKey?: string;

  /**
   * Path to mount the storage within the site's runtime environment.
   */
  mountPath?: string;

  /**
   * State of the storage account.
   */
  @visibility("read")
  state?: AzureStorageState;
}

/**
 * Information needed for cloning operation.
 */
model CloningInfo {
  /**
* Correlation ID of cloning operation. This ID ties multiple cloning operations
together to use the same snapshot.
*/
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
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName} for production slots and 
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slotName} for other slots.
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
from source app. Otherwise, application settings from source app are retained.
*/
  appSettingsOverrides?: Record<string>;

  /**
   * <code>true</code> to configure load balancing for source and destination app.
   */
  configureLoadBalancing?: boolean;

  /**
* ARM resource ID of the Traffic Manager profile to use, if it exists. Traffic Manager resource ID is of the form 
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficManagerProfiles/{profileName}.
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestampUtc?: utcDateTime;

  /**
   * The source slot of the last swap operation.
   */
  @visibility("read")
  sourceSlotName?: string;

  /**
   * The destination slot of the last swap operation.
   */
  @visibility("read")
  destinationSlotName?: string;
}

/**
 * Collection of CSM usage quotas.
 */
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
model AppServicePlanPatchResource extends ProxyOnlyResource {
  /**
   * AppServicePlanPatchResource resource specific properties
   */
  properties?: AppServicePlanPatchResourceProperties;
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
  @visibility("read")
  status?: StatusOptions;

  /**
   * App Service plan subscription.
   */
  @visibility("read")
  subscription?: string;

  /**
   * Specification for the App Service Environment to use for the App Service plan.
   */
  @visibility("read", "create")
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * Maximum number of instances that can be assigned to this App Service plan.
   */
  @visibility("read")
  maximumNumberOfWorkers?: int32;

  /**
   * Geographical location for the App Service plan.
   */
  @visibility("read")
  geoRegion?: string;

  /**
* If <code>true</code>, apps assigned to this App Service plan can be scaled independently.
If <code>false</code>, apps assigned to this App Service plan will scale to all instances of the plan.
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
  @visibility("read")
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
  @visibility("read")
  resourceGroup?: string;

  /**
   * If Linux app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility("read", "create")
  reserved?: boolean;

  /**
   * Obsolete: If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility("read", "create")
  isXenon?: boolean;

  /**
   * If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.
   */
  @visibility("read", "create")
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
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Specification for the Kubernetes Environment to use for the App Service plan.
   */
  kubeEnvironmentProfile?: KubeEnvironmentProfile;

  /**
* If <code>true</code>, this App Service Plan will perform availability zone balancing.
If <code>false</code>, this App Service Plan will not perform availability zone balancing.
*/
  zoneRedundant?: boolean;
}

/**
 * HybridConnection resource specific properties
 */
model HybridConnectionProperties {
  /**
   * The name of the Service Bus namespace.
   */
  @visibility("read", "create")
  serviceBusNamespace?: string;

  /**
   * The name of the Service Bus relay.
   */
  @visibility("read", "create")
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
normally, use the POST /listKeys API instead.
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
model HybridConnectionKey extends ProxyOnlyResource {
  /**
   * HybridConnectionKey resource specific properties
   */
  properties?: HybridConnectionKeyProperties;
}

/**
 * HybridConnectionKey resource specific properties
 */
model HybridConnectionKeyProperties {
  /**
   * The name of the send key.
   */
  @visibility("read")
  sendKeyName?: string;

  /**
   * The value of the send key.
   */
  @visibility("read")
  sendKeyValue?: string;
}

/**
 * Collection of resources.
 */
model ResourceCollection is Azure.Core.Page<string>;

/**
 * HybridConnectionLimits resource specific properties
 */
model HybridConnectionLimitsProperties {
  /**
   * The current number of Hybrid Connections.
   */
  @visibility("read")
  current?: int32;

  /**
   * The maximum number of Hybrid Connections allowed.
   */
  @visibility("read")
  maximum?: int32;
}

/**
 * Collection of hostname bindings.
 */
model HybridConnectionCollection is Azure.Core.Page<HybridConnection>;

/**
 * Virtual Network information contract.
 */
model VnetInfo {
  /**
   * The Virtual Network's resource ID.
   */
  vnetResourceId?: string;

  /**
   * The client certificate thumbprint.
   */
  @visibility("read")
  certThumbprint?: string;

  /**
* A certificate file (.cer) blob containing the public key of the private key used to authenticate a 
Point-To-Site VPN connection.
*/
  certBlob?: string;

  /**
   * The routes that this Virtual Network connection uses.
   */
  @visibility("read")
  routes?: VnetRoute[];

  /**
   * <code>true</code> if a resync is required; otherwise, <code>false</code>.
   */
  @visibility("read")
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
 * Virtual Network route contract used to pass routing information for a Virtual Network.
 */
model VnetRoute extends ProxyOnlyResource {
  /**
   * VnetRoute resource specific properties
   */
  properties?: VnetRouteProperties;
}

/**
 * VnetRoute resource specific properties
 */
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
DEFAULT - By default, every app has routes to the local address ranges specified by RFC1918
INHERITED - Routes inherited from the real Virtual Network routes
STATIC - Static route set on the app only

These values will be used for syncing an app's routes with those from a Virtual Network.
*/
  routeType?: RouteType;
}

/**
 * VnetGateway resource specific properties
 */
model VnetGatewayProperties {
  /**
   * The Virtual Network name.
   */
  @visibility("read", "create")
  vnetName?: string;

  /**
   * The URI where the VPN package can be downloaded.
   */
  @visibility("create", "update")
  vpnPackageUri: string;
}

/**
 * Certificate resource specific properties
 */
model CertificateProperties {
  /**
   * Certificate password.
   */
  @visibility("create")
  password?: string;

  /**
   * Friendly name of the certificate.
   */
  @visibility("read")
  friendlyName?: string;

  /**
   * Subject name of the certificate.
   */
  @visibility("read")
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
  @visibility("read")
  siteName?: string;

  /**
   * Self link.
   */
  @visibility("read")
  selfLink?: string;

  /**
   * Certificate issuer.
   */
  @visibility("read")
  issuer?: string;

  /**
   * Certificate issue Date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueDate?: utcDateTime;

  /**
   * Certificate expiration date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Certificate thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Is the certificate valid?.
   */
  @visibility("read")
  valid?: boolean;

  /**
   * Raw bytes of .cer file
   */
  @visibility("read")
  cerBlob?: bytes;

  /**
   * Public key hash.
   */
  @visibility("read")
  publicKeyHash?: string;

  /**
   * Specification for the App Service Environment to use for the certificate.
   */
  @visibility("read")
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
  @visibility("read")
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
 * ARM resource for a certificate.
 */
model CertificatePatchResource extends ProxyOnlyResource {
  /**
   * CertificatePatchResource resource specific properties
   */
  properties?: CertificatePatchResourceProperties;
}

/**
 * CertificatePatchResource resource specific properties
 */
model CertificatePatchResourceProperties {
  /**
   * Certificate password.
   */
  @visibility("create")
  password?: string;

  /**
   * Friendly name of the certificate.
   */
  @visibility("read")
  friendlyName?: string;

  /**
   * Subject name of the certificate.
   */
  @visibility("read")
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
  @visibility("read")
  siteName?: string;

  /**
   * Self link.
   */
  @visibility("read")
  selfLink?: string;

  /**
   * Certificate issuer.
   */
  @visibility("read")
  issuer?: string;

  /**
   * Certificate issue Date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueDate?: utcDateTime;

  /**
   * Certificate expiration date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Certificate thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Is the certificate valid?.
   */
  @visibility("read")
  valid?: boolean;

  /**
   * Raw bytes of .cer file
   */
  @visibility("read")
  cerBlob?: bytes;

  /**
   * Public key hash.
   */
  @visibility("read")
  publicKeyHash?: string;

  /**
   * Specification for the App Service Environment to use for the certificate.
   */
  @visibility("read")
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
  @visibility("read")
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
 * DeletedSite resource specific properties
 */
model DeletedSiteProperties {
  /**
   * Numeric id for the deleted site
   */
  @visibility("read")
  deletedSiteId?: int32;

  /**
   * Time in UTC when the app was deleted.
   */
  @visibility("read")
  deletedTimestamp?: string;

  /**
   * Subscription containing the deleted site
   */
  @visibility("read")
  subscription?: string;

  /**
   * ResourceGroup that contained the deleted site
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * Name of the deleted site
   */
  @visibility("read")
  deletedSiteName?: string;

  /**
   * Slot of the deleted site
   */
  @visibility("read")
  slot?: string;

  /**
   * Kind of site that was deleted
   */
  @visibility("read")
  kind?: string;

  /**
   * Geo Region of the deleted site
   */
  @visibility("read")
  geoRegionName?: string;
}

/**
 * DiagnosticCategory resource specific properties
 */
model DiagnosticCategoryProperties {
  /**
   * Description of the diagnostic category
   */
  @visibility("read")
  description?: string;
}

/**
 * AnalysisDefinition resource specific properties
 */
model AnalysisDefinitionProperties {
  /**
   * Description of the Analysis
   */
  @visibility("read")
  description?: string;
}

/**
 * Class representing a diagnostic analysis done on an application
 */
model DiagnosticAnalysis extends ProxyOnlyResource {
  /**
   * DiagnosticAnalysis resource specific properties
   */
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
  abnormalTimePeriods?: AbnormalTimePeriod[];

  /**
   * Data by each detector
   */
  payload?: AnalysisData[];

  /**
   * Data by each detector for detectors that did not corelate
   */
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
  data?: NameValuePair[][];

  /**
   * Solution Metadata.
   */
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
  metrics?: DiagnosticMetricSet[];

  /**
   * Additional Source Data
   */
  data?: NameValuePair[][];

  /**
   * Detector Meta Data
   */
  detectorMetaData?: ResponseMetaData;
}

/**
 * Class representing detector definition
 */
model DetectorDefinition {
  /**
   * Display name of the detector
   */
  @visibility("read")
  displayName?: string;

  /**
   * Description of the detector
   */
  @visibility("read")
  description?: string;

  /**
   * Detector Rank
   */
  @visibility("read")
  rank?: float64;

  /**
   * Flag representing whether detector is enabled or not.
   */
  @visibility("read")
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
This is returned and should be whichever instance name we desire to be returned
i.e. CPU and Memory return RDWORKERNAME (LargeDed..._IN_0) 
where RDWORKERNAME is Machine name below and RoleInstance name in parenthesis
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
  dataSourceUri?: NameValuePair[];
}

/**
 * Class representing Response from Diagnostic Detectors
 */
model DiagnosticDetectorResponse extends ProxyOnlyResource {
  /**
   * DiagnosticDetectorResponse resource specific properties
   */
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
  metrics?: DiagnosticMetricSet[];

  /**
   * List of Correlated events found by the detector
   */
  abnormalTimePeriods?: DetectorAbnormalTimePeriod[];

  /**
   * Additional Data that detector wants to send.
   */
  data?: NameValuePair[][];

  /**
   * Meta Data
   */
  responseMetaData?: ResponseMetaData;
}

/**
 * A snapshot of an app.
 */
model Snapshot extends ProxyOnlyResource {
  /**
   * Snapshot resource specific properties
   */
  properties?: SnapshotProperties;
}

/**
 * Snapshot resource specific properties
 */
model SnapshotProperties {
  /**
   * The time the snapshot was taken.
   */
  @visibility("read")
  time?: string;
}

/**
 * KubeEnvironment resource specific properties
 */
model KubeEnvironmentProperties {
  /**
   * Provisioning state of the Kubernetes Environment.
   */
  @visibility("read")
  provisioningState?: KubeEnvironmentProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility("read")
  deploymentErrors?: string;

  /**
   * Only visible within Vnet/Subnet
   */
  @visibility("read", "create")
  internalLoadBalancerEnabled?: boolean;

  /**
   * Default Domain Name for the cluster
   */
  @visibility("read")
  defaultDomain?: string;

  /**
   * Static IP of the KubeEnvironment
   */
  @visibility("read", "create")
  staticIp?: string;

  /**
* Cluster configuration which determines the ARC cluster
components types. Eg: Choosing between BuildService kind,
FrontEnd Service ArtifactsStorageType etc.
*/
  arcConfiguration?: ArcConfiguration;

  /**
* Cluster configuration which enables the log daemon to export
app logs to a destination. Currently only "log-analytics" is
supported
*/
  appLogsConfiguration?: AppLogsConfiguration;

  @visibility("read", "create")
  aksResourceID?: string;
}

model ArcConfiguration {
  @visibility("read", "create")
  artifactsStorageType?: StorageType;

  @visibility("read", "create")
  artifactStorageClassName?: string;

  @visibility("read", "create")
  artifactStorageMountPath?: string;

  @visibility("read", "create")
  artifactStorageNodeName?: string;

  @visibility("read", "create")
  artifactStorageAccessMode?: string;

  frontEndServiceConfiguration?: FrontEndConfiguration;

  @visibility("create", "update")
  kubeConfig?: string;
}

model FrontEndConfiguration {
  kind?: FrontEndServiceType;
}

model AppLogsConfiguration {
  destination?: string;
  logAnalyticsConfiguration?: LogAnalyticsConfiguration;
}

model LogAnalyticsConfiguration {
  customerId?: string;

  @visibility("create", "update")
  sharedKey?: string;
}

/**
 * ARM resource for a KubeEnvironment when patching
 */
model KubeEnvironmentPatchResource extends ProxyOnlyResource {
  /**
   * KubeEnvironmentPatchResource resource specific properties
   */
  properties?: KubeEnvironmentPatchResourceProperties;
}

/**
 * KubeEnvironmentPatchResource resource specific properties
 */
model KubeEnvironmentPatchResourceProperties {
  /**
   * Provisioning state of the Kubernetes Environment.
   */
  @visibility("read")
  provisioningState?: KubeEnvironmentProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility("read")
  deploymentErrors?: string;

  /**
   * Only visible within Vnet/Subnet
   */
  @visibility("read", "create")
  internalLoadBalancerEnabled?: boolean;

  /**
   * Default Domain Name for the cluster
   */
  @visibility("read")
  defaultDomain?: string;

  /**
   * Static IP of the KubeEnvironment
   */
  @visibility("read", "create")
  staticIp?: string;

  /**
* Cluster configuration which determines the ARC cluster
components types. Eg: Choosing between BuildService kind,
FrontEnd Service ArtifactsStorageType etc.
*/
  arcConfiguration?: ArcConfiguration;

  /**
* Cluster configuration which enables the log daemon to export
app logs to a destination. Currently only "log-analytics" is
supported
*/
  appLogsConfiguration?: AppLogsConfiguration;

  @visibility("read", "create")
  aksResourceID?: string;
}

/**
 * Collection of Application Stacks
 */
model ApplicationStackCollection is Azure.Core.Page<ApplicationStackResource>;

/**
 * ARM resource for a ApplicationStack.
 */
model ApplicationStackResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
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
  majorVersions?: StackMajorVersion[];

  /**
   * List of frameworks associated with application stack.
   */
  frameworks?: ApplicationStack[];

  /**
   * <code>true</code> if this is the stack is deprecated; otherwise, <code>false</code>.
   */
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
 <appSetting name="FUNCTIONS_WORKER_RUNTIME" value="dotnet" />
</appSettings>
 Example: All the function apps need AppSetting: "FUNCTIONS_WORKER_RUNTIME" to be set stack name
*/
  appSettingsDictionary?: Record<Record<unknown>>;

  /**
* <siteConfigProperties>
 <siteConfigProperty name="Use32BitWorkerProcess" value="false" />
</siteConfigProperties>
 Example: All Linux Function Apps, need Use32BitWorkerProcess to be set to 0
*/
  siteConfigPropertiesDictionary?: Record<Record<unknown>>;
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
model FunctionAppStack extends ProxyOnlyResource {
  /**
   * Function App stack location.
   */
  @visibility("read")
  location?: string;

  /**
   * FunctionAppStack resource specific properties
   */
  properties?: FunctionAppStackProperties;
}

/**
 * FunctionAppStack resource specific properties
 */
model FunctionAppStackProperties {
  /**
   * Function App stack (display only).
   */
  @visibility("read")
  displayText?: string;

  /**
   * Function App stack name.
   */
  @visibility("read")
  value?: string;

  /**
   * List of major versions available.
   */
  @visibility("read")
  majorVersions?: FunctionAppMajorVersion[];

  /**
   * Function App stack preferred OS.
   */
  @visibility("read")
  preferredOs?: StackPreferredOs;
}

/**
 * Function App stack major version.
 */
model FunctionAppMajorVersion {
  /**
   * Function App stack major version (display only).
   */
  @visibility("read")
  displayText?: string;

  /**
   * Function App stack major version name.
   */
  @visibility("read")
  value?: string;

  /**
   * Minor versions associated with the major version.
   */
  @visibility("read")
  minorVersions?: FunctionAppMinorVersion[];
}

/**
 * Function App stack minor version.
 */
model FunctionAppMinorVersion {
  /**
   * Function App stack (display only).
   */
  @visibility("read")
  displayText?: string;

  /**
   * Function App stack name.
   */
  @visibility("read")
  value?: string;

  /**
   * Settings associated with the minor version.
   */
  @visibility("read")
  stackSettings?: FunctionAppRuntimes;
}

/**
 * Function App stack runtimes.
 */
model FunctionAppRuntimes {
  /**
   * Linux-specific settings associated with the minor version.
   */
  @visibility("read")
  linuxRuntimeSettings?: FunctionAppRuntimeSettings;

  /**
   * Windows-specific settings associated with the minor version.
   */
  @visibility("read")
  windowsRuntimeSettings?: FunctionAppRuntimeSettings;
}

/**
 * Function App runtime settings.
 */
model FunctionAppRuntimeSettings {
  /**
   * Function App stack minor version (runtime only).
   */
  @visibility("read")
  runtimeVersion?: string;

  /**
   * <code>true</code> if remote debugging is supported for the stack; otherwise, <code>false</code>.
   */
  @visibility("read")
  remoteDebuggingSupported?: boolean;

  /**
   * Application Insights settings associated with the minor version.
   */
  @visibility("read")
  appInsightsSettings?: AppInsightsWebAppStackSettings;

  /**
   * GitHub Actions settings associated with the minor version.
   */
  @visibility("read")
  gitHubActionSettings?: GitHubActionWebAppStackSettings;

  /**
   * Application settings associated with the minor version.
   */
  @visibility("read")
  appSettingsDictionary?: Record<string>;

  /**
   * Configuration settings associated with the minor version.
   */
  @visibility("read")
  siteConfigPropertiesDictionary?: SiteConfigPropertiesDictionary;

  /**
   * List of supported Functions extension versions.
   */
  @visibility("read")
  supportedFunctionsExtensionVersions?: string[];

  /**
   * <code>true</code> if the stack is in preview; otherwise, <code>false</code>.
   */
  @visibility("read")
  isPreview?: boolean;

  /**
   * <code>true</code> if the stack is deprecated; otherwise, <code>false</code>.
   */
  @visibility("read")
  isDeprecated?: boolean;

  /**
   * <code>true</code> if the stack should be hidden; otherwise, <code>false</code>.
   */
  @visibility("read")
  isHidden?: boolean;

  /**
   * End-of-life date for the minor version.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * <code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.
   */
  @visibility("read")
  isAutoUpdate?: boolean;

  /**
   * <code>true</code> if the minor version is early-access; otherwise, <code>false</code>.
   */
  @visibility("read")
  isEarlyAccess?: boolean;

  /**
   * <code>true</code> if the minor version the default; otherwise, <code>false</code>.
   */
  @visibility("read")
  isDefault?: boolean;
}

/**
 * App Insights Web App stack settings.
 */
model AppInsightsWebAppStackSettings {
  /**
   * <code>true</code> if remote Application Insights is supported for the stack; otherwise, <code>false</code>.
   */
  @visibility("read")
  isSupported?: boolean;

  /**
   * <code>true</code> if Application Insights is disabled by default for the stack; otherwise, <code>false</code>.
   */
  @visibility("read")
  isDefaultOff?: boolean;
}

/**
 * GitHub Actions Web App stack settings.
 */
model GitHubActionWebAppStackSettings {
  /**
   * <code>true</code> if GitHub Actions is supported for the stack; otherwise, <code>false</code>.
   */
  @visibility("read")
  isSupported?: boolean;

  /**
   * The minor version that is supported for GitHub Actions.
   */
  @visibility("read")
  supportedVersion?: string;
}

/**
 * Site config properties dictionary.
 */
model SiteConfigPropertiesDictionary {
  /**
   * <code>true</code> if use32BitWorkerProcess should be set to true for the stack; otherwise, <code>false</code>.
   */
  @visibility("read")
  use32BitWorkerProcess?: boolean;

  /**
   * LinuxFxVersion configuration setting.
   */
  @visibility("read")
  linuxFxVersion?: string;

  /**
   * JavaVersion configuration setting.
   */
  @visibility("read")
  javaVersion?: string;

  /**
   * PowerShellVersion configuration setting.
   */
  @visibility("read")
  powerShellVersion?: string;
}

/**
 * Collection of Web app Stacks
 */
model WebAppStackCollection is Azure.Core.Page<WebAppStack>;

/**
 * Web App stack.
 */
model WebAppStack extends ProxyOnlyResource {
  /**
   * Web App stack location.
   */
  @visibility("read")
  location?: string;

  /**
   * WebAppStack resource specific properties
   */
  properties?: WebAppStackProperties;
}

/**
 * WebAppStack resource specific properties
 */
model WebAppStackProperties {
  /**
   * Web App stack (display only).
   */
  @visibility("read")
  displayText?: string;

  /**
   * Web App stack name.
   */
  @visibility("read")
  value?: string;

  /**
   * List of major versions available.
   */
  @visibility("read")
  majorVersions?: WebAppMajorVersion[];

  /**
   * Web App stack preferred OS.
   */
  @visibility("read")
  preferredOs?: StackPreferredOs;
}

/**
 * Web App stack major version.
 */
model WebAppMajorVersion {
  /**
   * Web App stack major version (display only).
   */
  @visibility("read")
  displayText?: string;

  /**
   * Web App stack major version name.
   */
  @visibility("read")
  value?: string;

  /**
   * Minor versions associated with the major version.
   */
  @visibility("read")
  minorVersions?: WebAppMinorVersion[];
}

/**
 * Web App stack minor version.
 */
model WebAppMinorVersion {
  /**
   * Web App stack minor version (display only).
   */
  @visibility("read")
  displayText?: string;

  /**
   * Web App stack major version name.
   */
  @visibility("read")
  value?: string;

  /**
   * Settings associated with the minor version.
   */
  @visibility("read")
  stackSettings?: WebAppRuntimes;
}

/**
 * Web App stack runtimes.
 */
model WebAppRuntimes {
  /**
   * Linux-specific settings associated with the minor version.
   */
  @visibility("read")
  linuxRuntimeSettings?: WebAppRuntimeSettings;

  /**
   * Windows-specific settings associated with the minor version.
   */
  @visibility("read")
  windowsRuntimeSettings?: WebAppRuntimeSettings;

  /**
   * Linux-specific settings associated with the Java container minor version.
   */
  @visibility("read")
  linuxContainerSettings?: LinuxJavaContainerSettings;

  /**
   * Windows-specific settings associated with the Java container minor version.
   */
  @visibility("read")
  windowsContainerSettings?: WindowsJavaContainerSettings;
}

/**
 * Web App runtime settings.
 */
model WebAppRuntimeSettings {
  /**
   * Web App stack minor version (runtime only).
   */
  @visibility("read")
  runtimeVersion?: string;

  /**
   * <code>true</code> if remote debugging is supported for the stack; otherwise, <code>false</code>.
   */
  @visibility("read")
  remoteDebuggingSupported?: boolean;

  /**
   * Application Insights settings associated with the minor version.
   */
  @visibility("read")
  appInsightsSettings?: AppInsightsWebAppStackSettings;

  /**
   * GitHub Actions settings associated with the minor version.
   */
  @visibility("read")
  gitHubActionSettings?: GitHubActionWebAppStackSettings;

  /**
   * <code>true</code> if the stack is in preview; otherwise, <code>false</code>.
   */
  @visibility("read")
  isPreview?: boolean;

  /**
   * <code>true</code> if the stack is deprecated; otherwise, <code>false</code>.
   */
  @visibility("read")
  isDeprecated?: boolean;

  /**
   * <code>true</code> if the stack should be hidden; otherwise, <code>false</code>.
   */
  @visibility("read")
  isHidden?: boolean;

  /**
   * End-of-life date for the minor version.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * <code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.
   */
  @visibility("read")
  isAutoUpdate?: boolean;

  /**
   * <code>true</code> if the minor version is early-access; otherwise, <code>false</code>.
   */
  @visibility("read")
  isEarlyAccess?: boolean;
}

/**
 * Linux Java Container settings.
 */
model LinuxJavaContainerSettings {
  /**
   * Java 11 version (runtime only).
   */
  @visibility("read")
  java11Runtime?: string;

  /**
   * Java 8 version (runtime only).
   */
  @visibility("read")
  java8Runtime?: string;

  /**
   * <code>true</code> if the stack is in preview; otherwise, <code>false</code>.
   */
  @visibility("read")
  isPreview?: boolean;

  /**
   * <code>true</code> if the stack is deprecated; otherwise, <code>false</code>.
   */
  @visibility("read")
  isDeprecated?: boolean;

  /**
   * <code>true</code> if the stack should be hidden; otherwise, <code>false</code>.
   */
  @visibility("read")
  isHidden?: boolean;

  /**
   * End-of-life date for the minor version.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * <code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.
   */
  @visibility("read")
  isAutoUpdate?: boolean;

  /**
   * <code>true</code> if the minor version is early-access; otherwise, <code>false</code>.
   */
  @visibility("read")
  isEarlyAccess?: boolean;
}

/**
 * Windows Java Container settings.
 */
model WindowsJavaContainerSettings {
  /**
   * Java container (runtime only).
   */
  @visibility("read")
  javaContainer?: string;

  /**
   * Java container version (runtime only).
   */
  @visibility("read")
  javaContainerVersion?: string;

  /**
   * <code>true</code> if the stack is in preview; otherwise, <code>false</code>.
   */
  @visibility("read")
  isPreview?: boolean;

  /**
   * <code>true</code> if the stack is deprecated; otherwise, <code>false</code>.
   */
  @visibility("read")
  isDeprecated?: boolean;

  /**
   * <code>true</code> if the stack should be hidden; otherwise, <code>false</code>.
   */
  @visibility("read")
  isHidden?: boolean;

  /**
   * End-of-life date for the minor version.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * <code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.
   */
  @visibility("read")
  isAutoUpdate?: boolean;

  /**
   * <code>true</code> if the minor version is early-access; otherwise, <code>false</code>.
   */
  @visibility("read")
  isEarlyAccess?: boolean;
}

/**
 * Collection of recommendations.
 */
model RecommendationCollection is Azure.Core.Page<Recommendation>;

/**
 * Represents a recommendation result generated by the recommendation engine.
 */
model Recommendation extends ProxyOnlyResource {
  /**
   * Recommendation resource specific properties
   */
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
  @visibility("read")
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
If such an object doesn't exist, it is set to null.
*/
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
  @visibility("read")
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
 * ResourceHealthMetadata resource specific properties
 */
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
 * SourceControl resource specific properties
 */
model SourceControlProperties {
  /**
   * OAuth access token.
   */
  token?: string;

  /**
   * OAuth access token secret.
   */
  tokenSecret?: string;

  /**
   * OAuth refresh token.
   */
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
model BillingMeter extends ProxyOnlyResource {
  /**
   * BillingMeter resource specific properties
   */
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
* List of available locations (regions or App Service Environments) for
deployment of App Service resources.
*/
model DeploymentLocations {
  /**
   * Available regions.
   */
  locations?: GeoRegion[];

  /**
   * Available App Service Environments with full descriptions of the environments.
   */
  hostingEnvironments?: AppServiceEnvironment[];

  /**
   * Available App Service Environments with basic information.
   */
  hostingEnvironmentDeploymentInfos?: HostingEnvironmentDeploymentInfo[];
}

/**
 * Geographical region.
 */
model GeoRegion extends ProxyOnlyResource {
  /**
   * GeoRegion resource specific properties
   */
  properties?: GeoRegionProperties;
}

/**
 * GeoRegion resource specific properties
 */
model GeoRegionProperties {
  /**
   * Region description.
   */
  @visibility("read")
  description?: string;

  /**
   * Display name for region.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Display name for region.
   */
  @visibility("read")
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
 * Collection of geographical regions.
 */
model GeoRegionCollection is Azure.Core.Page<GeoRegion>;

/**
 * Identifier resource specific properties
 */
model IdentifierProperties {
  /**
   * String representation of the identity.
   */
  @projectedName("json", "id")
  value?: string;
}

/**
 * Collection of premier add-on offers.
 */
model PremierAddOnOfferCollection is Azure.Core.Page<PremierAddOnOffer>;

/**
 * Premier add-on offer.
 */
model PremierAddOnOffer extends ProxyOnlyResource {
  /**
   * PremierAddOnOffer resource specific properties
   */
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
  capabilities?: Capability[];
}

/**
 * The required set of inputs to validate a VNET
 */
model VnetParameters extends ProxyOnlyResource {
  /**
   * VnetParameters resource specific properties
   */
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
model VnetValidationFailureDetails extends ProxyOnlyResource {
  /**
   * VnetValidationFailureDetails resource specific properties
   */
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
model VnetValidationTestFailure extends ProxyOnlyResource {
  /**
   * VnetValidationTestFailure resource specific properties
   */
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
model StaticSitesWorkflowPreviewRequest extends ProxyOnlyResource {
  /**
   * StaticSitesWorkflowPreviewRequest resource specific properties
   */
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
model StaticSitesWorkflowPreview extends ProxyOnlyResource {
  /**
   * StaticSitesWorkflowPreview resource specific properties
   */
  properties?: StaticSitesWorkflowPreviewProperties;
}

/**
 * StaticSitesWorkflowPreview resource specific properties
 */
model StaticSitesWorkflowPreviewProperties {
  /**
   * The path for the workflow file to be generated
   */
  @visibility("read")
  path?: string;

  /**
   * The contents for the workflow file to be generated
   */
  @visibility("read")
  contents?: string;
}

/**
 * A static site.
 */
model StaticSite {
  /**
   * The default autogenerated hostname for the static site.
   */
  @visibility("read")
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
  @visibility("read")
  customDomains?: string[];

  /**
   * A user's github repository token. This is used to setup the Github Actions workflow file and API secrets.
   */
  repositoryToken?: string;

  /**
   * Build properties to configure on the repository.
   */
  buildProperties?: StaticSiteBuildProperties;

  /**
   * Private endpoint connections
   */
  @visibility("read")
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
  @visibility("read")
  contentDistributionEndpoint?: string;

  /**
   * Identity to use for Key Vault Reference authentication.
   */
  @visibility("read")
  keyVaultReferenceIdentity?: string;

  /**
   * User provided function apps registered with the static site
   */
  @visibility("read")
  userProvidedFunctionApps?: StaticSiteUserProvidedFunctionAppARMResource[];

  /**
   * The provider that submitted the last deployment to the primary environment of the static site.
   */
  @visibility("read")
  provider?: string;
}

/**
 * Message envelope that contains the common Azure resource manager properties and the resource provider specific content.
 */
model ResponseMessageEnvelopeRemotePrivateEndpointConnection {
  /**
* Resource Id. Typically ID is populated only for responses to GET requests. Caller is responsible for passing in this
value for GET requests only.
For example: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupId}/providers/Microsoft.Web/sites/{sitename}
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
model RemotePrivateEndpointConnection extends ProxyOnlyResource {
  /**
   * RemotePrivateEndpointConnection resource specific properties
   */
  properties?: RemotePrivateEndpointConnectionProperties;
}

/**
 * RemotePrivateEndpointConnection resource specific properties
 */
model RemotePrivateEndpointConnectionProperties {
  @visibility("read")
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
 * StaticSiteUserProvidedFunctionAppARMResource resource specific properties
 */
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;
}

/**
 * ARM resource for a static site when patching
 */
model StaticSitePatchResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  properties?: StaticSite;
}

/**
 * Collection of static site custom users.
 */
model StaticSiteUserCollection is Azure.Core.Page<StaticSiteUserARMResource>;

/**
 * Static Site User ARM resource.
 */
model StaticSiteUserARMResource extends ProxyOnlyResource {
  /**
   * StaticSiteUserARMResource resource specific properties
   */
  properties?: StaticSiteUserARMResourceProperties;
}

/**
 * StaticSiteUserARMResource resource specific properties
 */
model StaticSiteUserARMResourceProperties {
  /**
   * The identity provider for the static site user.
   */
  @visibility("read")
  provider?: string;

  /**
   * The user id for the static site user.
   */
  @visibility("read")
  userId?: string;

  /**
   * The display name for the static site user.
   */
  @visibility("read")
  displayName?: string;

  /**
   * The roles for the static site user, in free-form string format
   */
  roles?: string;
}

/**
 * StaticSiteBuildARMResource resource specific properties
 */
model StaticSiteBuildARMResourceProperties {
  /**
   * An identifier for the static site build.
   */
  @visibility("read")
  buildId?: string;

  /**
   * The source branch.
   */
  @visibility("read")
  sourceBranch?: string;

  /**
   * The title of a pull request that a static site build is related to.
   */
  @visibility("read")
  pullRequestTitle?: string;

  /**
   * The hostname for a static site build.
   */
  @visibility("read")
  hostname?: string;

  /**
   * When this build was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  /**
   * When this build was updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  /**
   * The status of the static site build.
   */
  @visibility("read")
  status?: BuildStatus;

  /**
   * User provided function apps registered with the static site build
   */
  @visibility("read")
  userProvidedFunctionApps?: StaticSiteUserProvidedFunctionAppARMResource[];
}

/**
 * String dictionary resource.
 */
model StringDictionary extends ProxyOnlyResource {
  /**
   * Settings.
   */
  properties?: Record<string>;
}

/**
 * Collection of static site functions.
 */
model StaticSiteFunctionOverviewCollection
  is Azure.Core.Page<StaticSiteFunctionOverviewARMResource>;

/**
 * Static Site Function Overview ARM resource.
 */
model StaticSiteFunctionOverviewARMResource extends ProxyOnlyResource {
  /**
   * StaticSiteFunctionOverviewARMResource resource specific properties
   */
  properties?: StaticSiteFunctionOverviewARMResourceProperties;
}

/**
 * StaticSiteFunctionOverviewARMResource resource specific properties
 */
model StaticSiteFunctionOverviewARMResourceProperties {
  /**
   * The name for the function
   */
  @visibility("read")
  functionName?: string;

  /**
   * The trigger type of the function
   */
  @visibility("read")
  triggerType?: TriggerTypes;
}

/**
 * Static site zip deployment ARM resource.
 */
model StaticSiteZipDeploymentARMResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
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
 * Static sites user roles invitation resource.
 */
model StaticSiteUserInvitationRequestResource extends ProxyOnlyResource {
  /**
   * StaticSiteUserInvitationRequestResource resource specific properties
   */
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
model StaticSiteUserInvitationResponseResource extends ProxyOnlyResource {
  /**
   * StaticSiteUserInvitationResponseResource resource specific properties
   */
  properties?: StaticSiteUserInvitationResponseResourceProperties;
}

/**
 * StaticSiteUserInvitationResponseResource resource specific properties
 */
model StaticSiteUserInvitationResponseResourceProperties {
  /**
   * The expiration time of the invitation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresOn?: utcDateTime;

  /**
   * The url for the invitation link
   */
  @visibility("read")
  invitationUrl?: string;
}

/**
 * StaticSiteCustomDomainOverviewARMResource resource specific properties
 */
model StaticSiteCustomDomainOverviewARMResourceProperties {
  /**
   * The domain name for the static site custom domain.
   */
  @visibility("read")
  domainName?: string;

  /**
   * The date and time on which the custom domain was created for the static site.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The status of the custom domain
   */
  @visibility("read")
  status?: CustomDomainStatus;

  /**
   * The TXT record validation token
   */
  @visibility("read")
  validationToken?: string;

  @visibility("read")
  errorMessage?: string;
}

/**
 * Static Site Custom Domain Request Properties ARM resource.
 */
model StaticSiteCustomDomainRequestPropertiesARMResource
  extends ProxyOnlyResource {
  /**
   * StaticSiteCustomDomainRequestPropertiesARMResource resource specific properties
   */
  properties?: StaticSiteCustomDomainRequestPropertiesARMResourceProperties;
}

/**
 * StaticSiteCustomDomainRequestPropertiesARMResource resource specific properties
 */
model StaticSiteCustomDomainRequestPropertiesARMResourceProperties {
  /**
   * Validation method for adding a custom domain
   */
  validationMethod?: string = "cname-delegation";
}

/**
 * String list resource.
 */
model StringList extends ProxyOnlyResource {
  /**
   * List of string resources.
   */
  properties?: string[];
}

/**
 * Static Site Reset Properties ARM resource.
 */
model StaticSiteResetPropertiesARMResource extends ProxyOnlyResource {
  /**
   * StaticSiteResetPropertiesARMResource resource specific properties
   */
  properties?: StaticSiteResetPropertiesARMResourceProperties;
}

/**
 * StaticSiteResetPropertiesARMResource resource specific properties
 */
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
 * ARM resource for a site.
 */
model SitePatchResource extends ProxyOnlyResource {
  /**
   * SitePatchResource resource specific properties
   */
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
  @visibility("read")
  state?: string;

  /**
   * Hostnames associated with the app.
   */
  @visibility("read")
  hostNames?: string[];

  /**
   * Name of the repository site.
   */
  @visibility("read")
  repositorySiteName?: string;

  /**
   * State indicating whether the app has exceeded its quota usage. Read-only.
   */
  @visibility("read")
  usageState?: UsageState;

  /**
   * <code>true</code> if the app is enabled; otherwise, <code>false</code>. Setting this value to false disables the app (takes the app offline).
   */
  enabled?: boolean;

  /**
* Enabled hostnames for the app.Hostnames need to be assigned (see HostNames) AND enabled. Otherwise,
the app is not served on those hostnames.
*/
  @visibility("read")
  enabledHostNames?: string[];

  /**
   * Management information availability state for the app.
   */
  @visibility("read")
  availabilityState?: SiteAvailabilityState;

  /**
   * Hostname SSL states are used to manage the SSL bindings for app's hostnames.
   */
  hostNameSslStates?: HostNameSslState[];

  /**
   * Resource ID of the associated App Service plan, formatted as: "/subscriptions/{subscriptionID}/resourceGroups/{groupName}/providers/Microsoft.Web/serverfarms/{appServicePlanName}".
   */
  serverFarmId?: string;

  /**
   * <code>true</code> if reserved; otherwise, <code>false</code>.
   */
  @visibility("read", "create")
  reserved?: boolean;

  /**
   * Obsolete: Hyper-V sandbox.
   */
  @visibility("read", "create")
  isXenon?: boolean;

  /**
   * Hyper-V sandbox.
   */
  @visibility("read", "create")
  hyperV?: boolean;

  /**
   * Last time the app was modified, in UTC. Read-only.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  /**
   * Configuration of the app.
   */
  siteConfig?: SiteConfigProperties;

  /**
   * Azure Traffic Manager hostnames associated with the app. Read-only.
   */
  @visibility("read")
  trafficManagerHostNames?: string[];

  /**
   * <code>true</code> to stop SCM (KUDU) site when the app is stopped; otherwise, <code>false</code>. The default is <code>false</code>.
   */
  scmSiteAlsoStopped?: boolean;

  /**
   * Specifies which deployment slot this app will swap into. Read-only.
   */
  @visibility("read")
  targetSwapSlot?: string;

  /**
   * App Service Environment to use for the app.
   */
  @visibility("read", "create")
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  /**
   * <code>true</code> to enable client affinity; <code>false</code> to stop sending session affinity cookies, which route client requests in the same session to the same instance. Default is <code>true</code>.
   */
  clientAffinityEnabled?: boolean;

  /**
   * <code>true</code> to enable client certificate authentication (TLS mutual authentication); otherwise, <code>false</code>. Default is <code>false</code>.
   */
  clientCertEnabled?: boolean;

  /**
* This composes with ClientCertEnabled setting.
- ClientCertEnabled: false means ClientCert is ignored.
- ClientCertEnabled: true and ClientCertMode: Required means ClientCert is required.
- ClientCertEnabled: true and ClientCertMode: Optional means ClientCert is optional or accepted.
*/
  clientCertMode?: ClientCertMode;

  /**
   * client certificate authentication comma-separated exclusion paths
   */
  clientCertExclusionPaths?: string;

  /**
* <code>true</code> to disable the public hostnames of the app; otherwise, <code>false</code>.
 If <code>true</code>, the app is only accessible via API management process.
*/
  hostNamesDisabled?: boolean;

  /**
   * Unique identifier that verifies the custom domains assigned to the app. Customer will add this id to a txt record for verification.
   */
  customDomainVerificationId?: string;

  /**
   * List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from tenants that site can be hosted with current settings. Read-only.
   */
  @visibility("read")
  outboundIpAddresses?: string;

  /**
   * List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from all tenants except dataComponent. Read-only.
   */
  @visibility("read")
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspendedTill?: utcDateTime;

  /**
* Maximum number of workers.
This only applies to Functions container.
*/
  @visibility("read")
  maxNumberOfWorkers?: int32;

  /**
   * If specified during app creation, the app is cloned from a source app.
   */
  @visibility("create")
  cloningInfo?: CloningInfo;

  /**
   * Name of the resource group the app belongs to. Read-only.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * <code>true</code> if the app is a default container; otherwise, <code>false</code>.
   */
  @visibility("read")
  isDefaultContainer?: boolean;

  /**
   * Default hostname of the app. Read-only.
   */
  @visibility("read")
  defaultHostName?: string;

  /**
   * Status of the last deployment slot swap operation.
   */
  @visibility("read")
  slotSwapStatus?: SlotSwapStatus;

  /**
* HttpsOnly: configures a web site to accept only https requests. Issues redirect for
http requests
*/
  httpsOnly?: boolean;

  /**
   * Site redundancy mode
   */
  redundancyMode?: RedundancyMode;

  /**
   * Specifies an operation id if this site has a pending operation.
   */
  @visibility("read")
  inProgressOperationId?: string;

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
This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}
*/
  virtualNetworkSubnetId?: string;
}

/**
 * Custom domain analysis.
 */
model CustomHostnameAnalysisResult extends ProxyOnlyResource {
  /**
   * CustomHostnameAnalysisResult resource specific properties
   */
  properties?: CustomHostnameAnalysisResultProperties;
}

/**
 * CustomHostnameAnalysisResult resource specific properties
 */
model CustomHostnameAnalysisResultProperties {
  /**
   * <code>true</code> if hostname is already verified; otherwise, <code>false</code>.
   */
  @visibility("read")
  isHostnameAlreadyVerified?: boolean;

  /**
   * DNS verification test result.
   */
  @visibility("read")
  customDomainVerificationTest?: DnsVerificationTestResult;

  /**
   * Raw failure information if DNS verification fails.
   */
  @visibility("read")
  customDomainVerificationFailureInfo?: ErrorEntity;

  /**
   * <code>true</code> if there is a conflict on a scale unit; otherwise, <code>false</code>.
   */
  @visibility("read")
  hasConflictOnScaleUnit?: boolean;

  /**
   * <code>true</code> if there is a conflict across subscriptions; otherwise, <code>false</code>.
   */
  @visibility("read")
  hasConflictAcrossSubscription?: boolean;

  /**
   * Name of the conflicting app on scale unit if it's within the same subscription.
   */
  @visibility("read")
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
model BackupRequest extends ProxyOnlyResource {
  /**
   * BackupRequest resource specific properties
   */
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
  @visibility("read")
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

  name?: string;

  /**
* Contains a connection string name that is linked to the SiteConfig.ConnectionStrings.
This is used during restore with overwrite connection strings options.
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
model BackupItemProperties {
  /**
   * Id of the backup.
   */
  @visibility("read")
  @projectedName("json", "id")
  backupId?: int32;

  /**
   * SAS URL for the storage account container which contains this backup.
   */
  @visibility("read")
  storageAccountUrl?: string;

  /**
   * Name of the blob which contains data for this backup.
   */
  @visibility("read")
  blobName?: string;

  /**
   * Name of this backup.
   */
  @visibility("read")
  name?: string;

  /**
   * Backup status.
   */
  @visibility("read")
  status?: BackupItemStatus;

  /**
   * Size of the backup in bytes.
   */
  @visibility("read")
  sizeInBytes?: int64;

  /**
   * Timestamp of the backup creation.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Details regarding this backup. Might contain an error message.
   */
  @visibility("read")
  log?: string;

  /**
   * List of databases included in the backup.
   */
  @visibility("read")
  databases?: DatabaseBackupSetting[];

  /**
   * True if this backup has been created due to a schedule being triggered.
   */
  @visibility("read")
  scheduled?: boolean;

  /**
   * Timestamp of a last restore operation which used this backup.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRestoreTimeStamp?: utcDateTime;

  /**
   * Timestamp when this backup finished.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishedTimeStamp?: utcDateTime;

  /**
   * Unique correlation identifier. Please use this along with the timestamp while communicating with Azure support.
   */
  @visibility("read")
  correlationId?: string;

  /**
   * Size of the original web app which has been backed up.
   */
  @visibility("read")
  websiteSizeInBytes?: int64;
}

/**
 * Description of a restore request.
 */
model RestoreRequest extends ProxyOnlyResource {
  /**
   * RestoreRequest resource specific properties
   */
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
  databases?: DatabaseBackupSetting[];

  /**
* Changes a logic when restoring an app with custom domains. <code>true</code> to remove custom domains automatically. If <code>false</code>, custom domains are added to 
the app's object when it is being restored, but that might fail due to conflicts during the operation.
*/
  ignoreConflictingHostNames?: boolean;

  /**
   * Ignore the databases and only restore the site content
   */
  ignoreDatabases?: boolean;

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
 * CsmPublishingCredentialsPoliciesEntity resource specific properties
 */
model CsmPublishingCredentialsPoliciesEntityProperties {
  /**
   * <code>true</code> to allow access to a publishing method; otherwise, <code>false</code>.
   */
  allow: boolean;
}

/**
 * Configuration settings for the Azure App Service Authentication / Authorization feature.
 */
model SiteAuthSettings extends ProxyOnlyResource {
  /**
   * SiteAuthSettings resource specific properties
   */
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
The setting in this value can control the behavior of certain features in the Authentication / Authorization module.
*/
  runtimeVersion?: string;

  /**
   * The action to take when an unauthenticated client attempts to access the app.
   */
  unauthenticatedClientAction?: UnauthenticatedClientAction;

  /**
* <code>true</code> to durably store platform-specific security tokens that are obtained during login flows; otherwise, <code>false</code>.
 The default is <code>false</code>.
*/
  tokenStoreEnabled?: boolean;

  /**
* External URLs that can be redirected to as part of logging in or logging out of the app. Note that the query string part of the URL is ignored.
This is an advanced setting typically only needed by Windows Store application backends.
Note that URLs within the current domain are always implicitly allowed.
*/
  allowedExternalRedirectUrls?: string[];

  /**
* The default authentication provider to use when multiple providers are configured.
This setting is only needed if multiple providers are configured and the unauthenticated client
action is set to "RedirectToLoginPage".
*/
  defaultProvider?: BuiltInAuthenticationProvider;

  /**
* The number of hours after session token expiration that a session token can be used to
call the token refresh API. The default is 72 hours.
*/
  tokenRefreshExtensionHours?: float64;

  /**
* The Client ID of this relying party application, known as the client_id.
This setting is required for enabling OpenID Connection authentication with Azure Active Directory or 
other 3rd party OpenID Connect providers.
More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
*/
  clientId?: string;

  /**
* The Client Secret of this relying party application (in Azure Active Directory, this is also referred to as the Key).
This setting is optional. If no client secret is configured, the OpenID Connect implicit auth flow is used to authenticate end users.
Otherwise, the OpenID Connect Authorization Code Flow is used to authenticate end users.
More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
*/
  clientSecret?: string;

  /**
   * The app setting name that contains the client secret of the relying party application.
   */
  clientSecretSettingName?: string;

  /**
* An alternative to the client secret, that is the thumbprint of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret. It is also optional.
*/
  clientSecretCertificateThumbprint?: string;

  /**
* The OpenID Connect Issuer URI that represents the entity which issues access tokens for this application.
When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/.
This URI is a case-sensitive identifier for the token issuer.
More information on OpenID Connect Discovery: http://openid.net/specs/openid-connect-discovery-1_0.html
*/
  issuer?: string;

  /**
   * Gets a value indicating whether the issuer should be a valid HTTPS url and be validated as such.
   */
  validateIssuer?: boolean;

  /**
* Allowed audience values to consider when validating JWTs issued by 
Azure Active Directory. Note that the <code>ClientID</code> value is always considered an
allowed audience, regardless of this setting.
*/
  allowedAudiences?: string[];

  /**
* Login parameters to send to the OpenID Connect authorization endpoint when
a user logs in. Each parameter must be in the form "key=value".
*/
  additionalLoginParams?: string[];

  /**
   * Gets a JSON string containing the Azure AD Acl settings.
   */
  aadClaimsAuthorization?: string;

  /**
* The OpenID Connect Client ID for the Google web application.
This setting is required for enabling Google Sign-In.
Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
*/
  googleClientId?: string;

  /**
* The client secret associated with the Google web application.
This setting is required for enabling Google Sign-In.
Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
*/
  googleClientSecret?: string;

  /**
* The app setting name that contains the client secret associated with 
the Google web application.
*/
  googleClientSecretSettingName?: string;

  /**
* The OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication.
This setting is optional. If not specified, "openid", "profile", and "email" are used as default scopes.
Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
*/
  googleOAuthScopes?: string[];

  /**
* The App ID of the Facebook app used for login.
This setting is required for enabling Facebook Login.
Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
*/
  facebookAppId?: string;

  /**
* The App Secret of the Facebook app used for Facebook Login.
This setting is required for enabling Facebook Login.
Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
*/
  facebookAppSecret?: string;

  /**
   * The app setting name that contains the app secret used for Facebook Login.
   */
  facebookAppSecretSettingName?: string;

  /**
* The OAuth 2.0 scopes that will be requested as part of Facebook Login authentication.
This setting is optional.
Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
*/
  facebookOAuthScopes?: string[];

  /**
* The Client Id of the GitHub app used for login.
This setting is required for enabling Github login
*/
  gitHubClientId?: string;

  /**
* The Client Secret of the GitHub app used for Github Login.
This setting is required for enabling Github login.
*/
  gitHubClientSecret?: string;

  /**
* The app setting name that contains the client secret of the Github
app used for GitHub Login.
*/
  gitHubClientSecretSettingName?: string;

  /**
* The OAuth 2.0 scopes that will be requested as part of GitHub Login authentication.
This setting is optional
*/
  gitHubOAuthScopes?: string[];

  /**
* The OAuth 1.0a consumer key of the Twitter application used for sign-in.
This setting is required for enabling Twitter Sign-In.
Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
*/
  twitterConsumerKey?: string;

  /**
* The OAuth 1.0a consumer secret of the Twitter application used for sign-in.
This setting is required for enabling Twitter Sign-In.
Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
*/
  twitterConsumerSecret?: string;

  /**
* The app setting name that contains the OAuth 1.0a consumer secret of the Twitter
application used for sign-in.
*/
  twitterConsumerSecretSettingName?: string;

  /**
* The OAuth 2.0 client ID that was created for the app used for authentication.
This setting is required for enabling Microsoft Account authentication.
Microsoft Account OAuth documentation: https://dev.onedrive.com/auth/msa_oauth.htm
*/
  microsoftAccountClientId?: string;

  /**
* The OAuth 2.0 client secret that was created for the app used for authentication.
This setting is required for enabling Microsoft Account authentication.
Microsoft Account OAuth documentation: https://dev.onedrive.com/auth/msa_oauth.htm
*/
  microsoftAccountClientSecret?: string;

  /**
* The app setting name containing the OAuth 2.0 client secret that was created for the
app used for authentication.
*/
  microsoftAccountClientSecretSettingName?: string;

  /**
* The OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication.
This setting is optional. If not specified, "wl.basic" is used as the default scope.
Microsoft Account Scopes and permissions documentation: https://msdn.microsoft.com/en-us/library/dn631845.aspx
*/
  microsoftAccountOAuthScopes?: string[];

  /**
* "true" if the auth config settings should be read from a file,
"false" otherwise
*/
  isAuthFromFile?: string;

  /**
* The path of the config file containing auth settings.
If the path is relative, base will the site's root directory.
*/
  authFilePath?: string;

  /**
* The ConfigVersion of the Authentication / Authorization feature in use for the current app.
The setting in this value can control the behavior of the control plane for Authentication / Authorization.
*/
  configVersion?: string;
}

/**
 * Configuration settings for the Azure App Service Authentication / Authorization V2 feature.
 */
model SiteAuthSettingsV2 extends ProxyOnlyResource {
  /**
   * SiteAuthSettingsV2 resource specific properties
   */
  properties?: SiteAuthSettingsV2Properties;
}

/**
 * SiteAuthSettingsV2 resource specific properties
 */
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
The setting in this value can control the behavior of certain features in the Authentication / Authorization module.
*/
  runtimeVersion?: string;

  /**
* The path of the config file containing auth settings if they come from a file.
If the path is relative, base will the site's root directory.
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
This setting is only needed if multiple providers are configured and the unauthenticated client
action is set to "RedirectToLoginPage".
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
configuration settings of the custom Open ID Connect provider.
*/
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
This is an internal flag primarily intended to support the Azure Management Portal. Users should not
read or write to this property.
*/
  isAutoProvisioned?: boolean;
}

/**
 * The configuration settings of the Azure Active Directory app registration.
 */
model AzureActiveDirectoryRegistration {
  /**
* The OpenID Connect Issuer URI that represents the entity which issues access tokens for this application.
When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://login.microsoftonline.com/v2.0/{tenant-guid}/.
This URI is a case-sensitive identifier for the token issuer.
More information on OpenID Connect Discovery: http://openid.net/specs/openid-connect-discovery-1_0.html
*/
  openIdIssuer?: string;

  /**
* The Client ID of this relying party application, known as the client_id.
This setting is required for enabling OpenID Connection authentication with Azure Active Directory or 
other 3rd party OpenID Connect providers.
More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
*/
  clientId?: string;

  /**
   * The app setting name that contains the client secret of the relying party application.
   */
  clientSecretSettingName?: string;

  /**
* An alternative to the client secret, that is the thumbprint of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret. It is also optional.
*/
  clientSecretCertificateThumbprint?: string;

  /**
* An alternative to the client secret thumbprint, that is the subject alternative name of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret Certificate Thumbprint. It is also optional.
*/
  clientSecretCertificateSubjectAlternativeName?: string;

  /**
* An alternative to the client secret thumbprint, that is the issuer of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret Certificate Thumbprint. It is also optional.
*/
  clientSecretCertificateIssuer?: string;
}

/**
 * The configuration settings of the Azure Active Directory login flow.
 */
model AzureActiveDirectoryLogin {
  /**
* Login parameters to send to the OpenID Connect authorization endpoint when
a user logs in. Each parameter must be in the form "key=value".
*/
  loginParameters?: string[];

  /**
   * <code>true</code> if the www-authenticate provider should be omitted from the request; otherwise, <code>false</code>.
   */
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
This setting is required for enabling Twitter Sign-In.
Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
*/
  consumerKey?: string;

  /**
* The app setting name that contains the OAuth 1.0a consumer secret of the Twitter
application used for sign-in.
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
This is an advanced setting typically only needed by Windows Store application backends.
Note that URLs within the current domain are always implicitly allowed.
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
 The default is <code>false</code>.
*/
  enabled?: boolean;

  /**
* The number of hours after session token expiration that a session token can be used to
call the token refresh API. The default is 72 hours.
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
model AzureStoragePropertyDictionaryResource extends ProxyOnlyResource {
  /**
   * Azure storage accounts.
   */
  properties?: Record<AzureStorageInfoValue>;
}

/**
 * ApiKVReference resource specific properties
 */
model ApiKVReferenceProperties {
  reference?: string;
  status?: ResolveStatus;
  vaultName?: string;
  secretName?: string;
  secretVersion?: string;

  /**
   * Managed service identity.
   */
  identityType?: ManagedServiceIdentity;

  details?: string;
  source?: "KeyVault";
  activeVersion?: string;
}

/**
 * String dictionary resource.
 */
model ConnectionStringDictionary extends ProxyOnlyResource {
  /**
   * Connection strings.
   */
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
  level?: LogLevel;
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
Remove blobs older than X days.
0 or lower means no retention.
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
When reached old log files will be removed to make space for new ones.
Value can range between 25 and 100.
*/
  @maxValue(100)
  @minValue(25)
  retentionInMb?: int32;

  /**
* Retention in days.
Remove files older than X days.
0 or lower means no retention.
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
Remove blobs older than X days.
0 or lower means no retention.
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
identifiers to be marked as sticky to the deployment slot and not moved during a swap operation.
This is valid for all deployment slots in an app.
*/
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
model SiteConfigurationSnapshotInfo extends ProxyOnlyResource {
  /**
   * SiteConfigurationSnapshotInfo resource specific properties
   */
  properties?: SiteConfigurationSnapshotInfoProperties;
}

/**
 * SiteConfigurationSnapshotInfo resource specific properties
 */
model SiteConfigurationSnapshotInfoProperties {
  /**
   * The time the snapshot was taken.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * The id of the snapshot
   */
  @visibility("read")
  snapshotId?: int32;
}

/**
 * ContinuousWebJob resource specific properties
 */
model ContinuousWebJobProperties {
  /**
   * Job status.
   */
  status?: ContinuousWebJobStatus;

  /**
   * Detailed status.
   */
  @projectedName("json", "detailed_status")
  detailedStatus?: string;

  /**
   * Log URL.
   */
  @projectedName("json", "log_url")
  logUrl?: string;

  /**
   * Run command.
   */
  @projectedName("json", "run_command")
  runCommand?: string;

  /**
   * Job URL.
   */
  url?: string;

  /**
   * Extra Info URL.
   */
  @projectedName("json", "extra_info_url")
  extraInfoUrl?: string;

  /**
   * Job type.
   */
  @projectedName("json", "web_job_type")
  webJobType?: WebJobType;

  /**
   * Error information.
   */
  error?: string;

  /**
   * Using SDK?
   */
  @projectedName("json", "using_sdk")
  usingSdk?: boolean;

  /**
   * Job settings.
   */
  settings?: Record<Record<unknown>>;
}

/**
 * Deployment resource specific properties
 */
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
  @projectedName("json", "author_email")
  authorEmail?: string;

  /**
   * Start time.
   */
  @projectedName("json", "start_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time.
   */
  @projectedName("json", "end_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

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
model MSDeployStatusProperties {
  /**
   * Username of deployer
   */
  @visibility("read")
  deployer?: string;

  /**
   * Provisioning state
   */
  @visibility("read")
  provisioningState?: MSDeployProvisioningState;

  /**
   * Start time of deploy operation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of deploy operation
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Whether the deployment operation has completed
   */
  @visibility("read")
  complete?: boolean;
}

/**
 * MSDeploy ARM PUT information
 */
model MSDeploy extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  properties?: MSDeployCore;
}

/**
 * MSDeploy ARM PUT core information
 */
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
  setParameters?: Record<string>;

  /**
* Controls whether the MSDeploy operation skips the App_Data directory.
If set to <code>true</code>, the existing App_Data directory on the destination
will not be deleted, and any App_Data directory in the source will be ignored.
Setting is <code>false</code> by default.
*/
  skipAppData?: boolean;

  /**
* Sets the AppOffline rule while the MSDeploy operation executes.
Setting is <code>false</code> by default.
*/
  appOffline?: boolean;
}

/**
 * MSDeploy log
 */
model MSDeployLog extends ProxyOnlyResource {
  /**
   * MSDeployLog resource specific properties
   */
  properties?: MSDeployLogProperties;
}

/**
 * MSDeployLog resource specific properties
 */
model MSDeployLogProperties {
  /**
   * List of log entry messages
   */
  @visibility("read")
  entries?: MSDeployLogEntry[];
}

/**
 * MSDeploy log entry
 */
model MSDeployLogEntry {
  /**
   * Timestamp of log entry
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * Log entry type
   */
  @visibility("read")
  type?: MSDeployLogEntryType;

  /**
   * Log entry message
   */
  @visibility("read")
  message?: string;
}

/**
 * FunctionEnvelope resource specific properties
 */
model FunctionEnvelopeProperties {
  /**
   * Function App ID.
   */
  @projectedName("json", "function_app_id")
  functionAppId?: string;

  /**
   * Script root path URI.
   */
  @projectedName("json", "script_root_path_href")
  scriptRootPathHref?: string;

  /**
   * Script URI.
   */
  @projectedName("json", "script_href")
  scriptHref?: string;

  /**
   * Config URI.
   */
  @projectedName("json", "config_href")
  configHref?: string;

  /**
   * Test data URI.
   */
  @projectedName("json", "test_data_href")
  testDataHref?: string;

  /**
   * Secrets file URI.
   */
  @projectedName("json", "secrets_file_href")
  secretsFileHref?: string;

  /**
   * Function URI.
   */
  href?: string;

  /**
   * Config information.
   */
  config?: Record<unknown>;

  /**
   * File list.
   */
  files?: Record<string>;

  /**
   * Test data used when testing via the Azure Portal.
   */
  @projectedName("json", "test_data")
  testData?: string;

  /**
   * The invocation URL
   */
  @projectedName("json", "invoke_url_template")
  invokeUrlTemplate?: string;

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
   * Properties of function key info.
   */
  properties?: KeyInfoProperties;
}

/**
 * Properties of function key info.
 */
model KeyInfoProperties {
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
  key?: string;

  /**
   * Trigger URL.
   */
  @projectedName("json", "trigger_url")
  triggerUrl?: string;
}

/**
 * Functions host level keys.
 */
model HostKeys {
  /**
   * Secret key.
   */
  masterKey?: string;

  /**
   * Host level function keys.
   */
  functionKeys?: Record<string>;

  /**
   * System keys.
   */
  systemKeys?: Record<string>;
}

/**
 * HostNameBinding resource specific properties
 */
model HostNameBindingProperties {
  /**
   * App Service app name.
   */
  @visibility("read", "create")
  siteName?: string;

  /**
   * Fully qualified ARM domain resource URI.
   */
  @visibility("read", "create")
  domainId?: string;

  /**
   * Azure resource name.
   */
  @visibility("read", "create")
  azureResourceName?: string;

  /**
   * Azure resource type.
   */
  @visibility("read", "create")
  azureResourceType?: AzureResourceType;

  /**
   * Custom DNS record type.
   */
  @visibility("read", "create")
  customHostNameDnsRecordType?: CustomHostNameDnsRecordType;

  /**
   * Hostname type.
   */
  @visibility("read", "create")
  hostNameType?: HostNameType;

  /**
   * SSL type
   */
  @visibility("read", "create")
  sslState?: SslState;

  /**
   * SSL certificate thumbprint
   */
  @visibility("read", "create")
  thumbprint?: string;

  /**
   * Virtual IP address assigned to the hostname if IP based SSL is enabled.
   */
  @visibility("read")
  virtualIP?: string;
}

/**
 * RelayServiceConnectionEntity resource specific properties
 */
model RelayServiceConnectionEntityProperties {
  entityName?: string;
  entityConnectionString?: string;
  resourceType?: string;
  resourceConnectionString?: string;
  hostname?: string;
  port?: int32;
  biztalkUri?: string;
}

/**
 * WebSiteInstanceStatus resource specific properties
 */
model WebSiteInstanceStatusProperties {
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
  containers?: Record<ContainerInfo>;
}

model ContainerInfo {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  currentTimeStamp?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  previousTimeStamp?: utcDateTime;

  currentCpuStats?: ContainerCpuStatistics;
  previousCpuStats?: ContainerCpuStatistics;
  memoryStats?: ContainerMemoryStatistics;
  name?: string;
  id?: string;
  eth0?: ContainerNetworkInterfaceStatistics;
}

model ContainerCpuStatistics {
  cpuUsage?: ContainerCpuUsage;
  systemCpuUsage?: int64;
  onlineCpuCount?: int32;
  throttlingData?: ContainerThrottlingData;
}

model ContainerCpuUsage {
  totalUsage?: int64;
  perCpuUsage?: int64[];
  kernelModeUsage?: int64;
  userModeUsage?: int64;
}

model ContainerThrottlingData {
  periods?: int32;
  throttledPeriods?: int32;
  throttledTime?: int32;
}

model ContainerMemoryStatistics {
  usage?: int64;
  maxUsage?: int64;
  limit?: int64;
}

model ContainerNetworkInterfaceStatistics {
  rxBytes?: int64;
  rxPackets?: int64;
  rxErrors?: int64;
  rxDropped?: int64;
  txBytes?: int64;
  txPackets?: int64;
  txErrors?: int64;
  txDropped?: int64;
}

/**
 * ProcessInfo resource specific properties
 */
model ProcessInfoProperties {
  /**
   * ARM Identifier for deployment.
   */
  @visibility("read")
  identifier?: int32;

  /**
   * Deployment name.
   */
  @projectedName("json", "deployment_name")
  deploymentName?: string;

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
  @projectedName("json", "is_profile_running")
  isProfileRunning?: boolean;

  /**
   * Is the IIS Profile running?
   */
  @projectedName("json", "is_iis_profile_running")
  isIisProfileRunning?: boolean;

  /**
   * IIS Profile timeout (seconds).
   */
  @projectedName("json", "iis_profile_timeout_in_seconds")
  iisProfileTimeoutInSeconds?: float64;

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
  @projectedName("json", "open_file_handles")
  openFileHandles?: string[];

  /**
   * List of modules.
   */
  modules?: ProcessModuleInfo[];

  /**
   * File name of this process.
   */
  @projectedName("json", "file_name")
  fileName?: string;

  /**
   * Command line.
   */
  @projectedName("json", "command_line")
  commandLine?: string;

  /**
   * User name.
   */
  @projectedName("json", "user_name")
  userName?: string;

  /**
   * Handle count.
   */
  @projectedName("json", "handle_count")
  handleCount?: int32;

  /**
   * Module count.
   */
  @projectedName("json", "module_count")
  moduleCount?: int32;

  /**
   * Thread count.
   */
  @projectedName("json", "thread_count")
  threadCount?: int32;

  /**
   * Start time.
   */
  @projectedName("json", "start_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Total CPU time.
   */
  @projectedName("json", "total_cpu_time")
  totalCpuTime?: string;

  /**
   * User CPU time.
   */
  @projectedName("json", "user_cpu_time")
  userCpuTime?: string;

  /**
   * Privileged CPU time.
   */
  @projectedName("json", "privileged_cpu_time")
  privilegedCpuTime?: string;

  /**
   * Working set.
   */
  @projectedName("json", "working_set")
  workingSet?: int64;

  /**
   * Peak working set.
   */
  @projectedName("json", "peak_working_set")
  peakWorkingSet?: int64;

  /**
   * Private memory size.
   */
  @projectedName("json", "private_memory")
  privateMemory?: int64;

  /**
   * Virtual memory size.
   */
  @projectedName("json", "virtual_memory")
  virtualMemory?: int64;

  /**
   * Peak virtual memory usage.
   */
  @projectedName("json", "peak_virtual_memory")
  peakVirtualMemory?: int64;

  /**
   * Paged system memory.
   */
  @projectedName("json", "paged_system_memory")
  pagedSystemMemory?: int64;

  /**
   * Non-paged system memory.
   */
  @projectedName("json", "non_paged_system_memory")
  nonPagedSystemMemory?: int64;

  /**
   * Paged memory.
   */
  @projectedName("json", "paged_memory")
  pagedMemory?: int64;

  /**
   * Peak paged memory.
   */
  @projectedName("json", "peak_paged_memory")
  peakPagedMemory?: int64;

  /**
   * Time stamp.
   */
  @projectedName("json", "time_stamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;

  /**
   * List of environment variables.
   */
  @projectedName("json", "environment_variables")
  environmentVariables?: Record<string>;

  /**
   * Is this the SCM site?
   */
  @projectedName("json", "is_scm_site")
  isScmSite?: boolean;

  /**
   * Is this a Web Job?
   */
  @projectedName("json", "is_webjob")
  isWebjob?: boolean;

  /**
   * Description of process.
   */
  description?: string;
}

/**
 * Process Thread Information.
 */
model ProcessThreadInfo extends ProxyOnlyResource {
  /**
   * ProcessThreadInfo resource specific properties
   */
  properties?: ProcessThreadInfoProperties;
}

/**
 * ProcessThreadInfo resource specific properties
 */
model ProcessThreadInfoProperties {
  /**
   * Site extension ID.
   */
  @visibility("read")
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
  @projectedName("json", "start_address")
  startAddress?: string;

  /**
   * Current thread priority.
   */
  @projectedName("json", "current_priority")
  currentPriority?: int32;

  /**
   * Thread priority level.
   */
  @projectedName("json", "priority_level")
  priorityLevel?: string;

  /**
   * Base priority.
   */
  @projectedName("json", "base_priority")
  basePriority?: int32;

  /**
   * Start time.
   */
  @projectedName("json", "start_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Total processor time.
   */
  @projectedName("json", "total_processor_time")
  totalProcessorTime?: string;

  /**
   * User processor time.
   */
  @projectedName("json", "user_processor_time")
  userProcessorTime?: string;

  /**
   * Thread state.
   */
  state?: string;

  /**
   * Wait reason.
   */
  @projectedName("json", "wait_reason")
  waitReason?: string;
}

/**
 * ProcessModuleInfo resource specific properties
 */
model ProcessModuleInfoProperties {
  /**
   * Base address. Used as module identifier in ARM resource URI.
   */
  @projectedName("json", "base_address")
  baseAddress?: string;

  /**
   * File name.
   */
  @projectedName("json", "file_name")
  fileName?: string;

  /**
   * HRef URI.
   */
  href?: string;

  /**
   * File path.
   */
  @projectedName("json", "file_path")
  filePath?: string;

  /**
   * Module memory size.
   */
  @projectedName("json", "module_memory_size")
  moduleMemorySize?: int32;

  /**
   * File version.
   */
  @projectedName("json", "file_version")
  fileVersion?: string;

  /**
   * File description.
   */
  @projectedName("json", "file_description")
  fileDescription?: string;

  /**
   * Product name.
   */
  product?: string;

  /**
   * Product version.
   */
  @projectedName("json", "product_version")
  productVersion?: string;

  /**
   * Is debug?
   */
  @projectedName("json", "is_debug")
  isDebug?: boolean;

  /**
   * Module language (locale).
   */
  language?: string;
}

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
  blockingFeatures?: SiteCloneabilityCriterion[];

  /**
* List of features enabled on app that are non-blocking but cannot be cloned. The app can still be cloned
but the features in this list will not be set up on cloned app.
*/
  unsupportedFeatures?: SiteCloneabilityCriterion[];

  /**
   * List of blocking application characteristics.
   */
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
model StorageMigrationOptions extends ProxyOnlyResource {
  /**
   * StorageMigrationOptions resource specific properties
   */
  properties?: StorageMigrationOptionsProperties;
}

/**
 * StorageMigrationOptions resource specific properties
 */
model StorageMigrationOptionsProperties {
  /**
   * AzureFiles connection string.
   */
  @visibility("create")
  azurefilesConnectionString: string;

  /**
   * AzureFiles share.
   */
  @visibility("create")
  azurefilesShare: string;

  /**
   * <code>true</code>if the app should be switched over; otherwise, <code>false</code>.
   */
  @visibility("create")
  switchSiteAfterMigration?: boolean;

  /**
   * <code>true</code> if the app should be read only during copy operation; otherwise, <code>false</code>.
   */
  @visibility("create")
  blockWriteAccessToSite?: boolean;
}

/**
 * Response for a migration of app content request.
 */
model StorageMigrationResponse extends ProxyOnlyResource {
  /**
   * StorageMigrationResponse resource specific properties
   */
  properties?: StorageMigrationResponseProperties;
}

/**
 * StorageMigrationResponse resource specific properties
 */
model StorageMigrationResponseProperties {
  /**
   * When server starts the migration process, it will return an operation ID identifying that particular migration operation.
   */
  @visibility("read")
  operationId?: string;
}

/**
 * MySQL migration request.
 */
model MigrateMySqlRequest extends ProxyOnlyResource {
  /**
   * MigrateMySqlRequest resource specific properties
   */
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
model MigrateMySqlStatusProperties {
  /**
   * Status of the migration task.
   */
  @visibility("read")
  migrationOperationStatus?: OperationStatus;

  /**
   * Operation ID for the migration task.
   */
  @visibility("read")
  operationId?: string;

  /**
   * True if the web app has in app MySql enabled
   */
  @visibility("read")
  localMySqlEnabled?: boolean;
}

/**
 * SwiftVirtualNetwork resource specific properties
 */
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
model NetworkFeaturesProperties {
  /**
   * The Virtual Network name.
   */
  @visibility("read")
  virtualNetworkName?: string;

  /**
   * The Virtual Network summary view.
   */
  @visibility("read")
  virtualNetworkConnection?: VnetInfo;

  /**
   * The Hybrid Connections summary view.
   */
  @visibility("read")
  hybridConnections?: RelayServiceConnectionEntity[];

  /**
   * The Hybrid Connection V2 (Service Bus) view.
   */
  @visibility("read")
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
model SitePhpErrorLogFlag extends ProxyOnlyResource {
  /**
   * SitePhpErrorLogFlag resource specific properties
   */
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
model PremierAddOnPatchResource extends ProxyOnlyResource {
  /**
   * PremierAddOnPatchResource resource specific properties
   */
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
model PrivateAccessProperties {
  /**
   * Whether private access is enabled or not.
   */
  enabled?: boolean;

  /**
   * The Virtual Networks (and subnets) allowed to access the site privately.
   */
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
 * PublicCertificate resource specific properties
 */
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
  @visibility("read")
  thumbprint?: string;
}

/**
 * Publishing options for requested profile.
 */
model CsmPublishingProfileOptions {
  /**
* Name of the format. Valid values are: 
FileZilla3
WebDeploy -- default
Ftp
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
model DeletedAppRestoreRequest extends ProxyOnlyResource {
  /**
   * DeletedAppRestoreRequest resource specific properties
   */
  properties?: DeletedAppRestoreRequestProperties;
}

/**
 * DeletedAppRestoreRequest resource specific properties
 */
model DeletedAppRestoreRequestProperties {
  /**
* ARM resource ID of the deleted app. Example:
/subscriptions/{subId}/providers/Microsoft.Web/deletedSites/{deletedSiteId}
*/
  deletedSiteId?: string;

  /**
   * If true, deleted site configuration, in addition to content, will be restored.
   */
  recoverConfiguration?: boolean;

  /**
* Point in time to restore the deleted app from, formatted as a DateTime string. 
If unspecified, default value is the time that the app was deleted.
*/
  snapshotTime?: string;

  /**
   * If true, the snapshot is retrieved from DRSecondary endpoint.
   */
  useDRSecondary?: boolean;
}

/**
 * Details about app recovery operation.
 */
model SnapshotRestoreRequest extends ProxyOnlyResource {
  /**
   * SnapshotRestoreRequest resource specific properties
   */
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
If empty, the targeted web app will be used as the source.
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
This setting is only necessary when RecoverConfiguration is enabled.
*/
  ignoreConflictingHostNames?: boolean;

  /**
   * If true, the snapshot is retrieved from DRSecondary endpoint.
   */
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
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName} for production slots and 
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slotName} for other slots.
*/
  id?: string;
}

/**
 * SiteExtensionInfo resource specific properties
 */
model SiteExtensionInfoProperties {
  /**
   * Site extension ID.
   */
  @projectedName("json", "extension_id")
  extensionId?: string;

  title?: string;

  /**
   * Site extension type.
   */
  @projectedName("json", "extension_type")
  extensionType?: SiteExtensionType;

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
  @projectedName("json", "extension_url")
  extensionUrl?: string;

  /**
   * Project URL.
   */
  @projectedName("json", "project_url")
  projectUrl?: string;

  /**
   * Icon URL.
   */
  @projectedName("json", "icon_url")
  iconUrl?: string;

  /**
   * License URL.
   */
  @projectedName("json", "license_url")
  licenseUrl?: string;

  /**
   * Feed URL.
   */
  @projectedName("json", "feed_url")
  feedUrl?: string;

  /**
   * List of authors.
   */
  authors?: string[];

  /**
   * Installer command line parameters.
   */
  @projectedName("json", "installer_command_line_params")
  installerCommandLineParams?: string;

  /**
   * Published timestamp.
   */
  @projectedName("json", "published_date_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDateTime?: utcDateTime;

  /**
   * Count of downloads.
   */
  @projectedName("json", "download_count")
  downloadCount?: int32;

  /**
   * <code>true</code> if the local version is the latest version; <code>false</code> otherwise.
   */
  @projectedName("json", "local_is_latest_version")
  localIsLatestVersion?: boolean;

  /**
   * Local path.
   */
  @projectedName("json", "local_path")
  localPath?: string;

  /**
   * Installed timestamp.
   */
  @projectedName("json", "installed_date_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  installedDateTime?: utcDateTime;

  /**
   * Provisioning state.
   */
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
model SlotDifference extends ProxyOnlyResource {
  /**
   * SlotDifference resource specific properties
   */
  properties?: SlotDifferenceProperties;
}

/**
 * SlotDifference resource specific properties
 */
model SlotDifferenceProperties {
  /**
   * Level of the difference: Information, Warning or Error.
   */
  @visibility("read")
  level?: string;

  /**
   * The type of the setting: General, AppSetting or ConnectionString.
   */
  @visibility("read")
  settingType?: string;

  /**
   * Rule that describes how to process the setting difference during a slot swap.
   */
  @visibility("read")
  diffRule?: string;

  /**
   * Name of the setting.
   */
  @visibility("read")
  settingName?: string;

  /**
   * Value of the setting in the current slot.
   */
  @visibility("read")
  valueInCurrentSlot?: string;

  /**
   * Value of the setting in the target slot.
   */
  @visibility("read")
  valueInTargetSlot?: string;

  /**
   * Description of the setting difference.
   */
  @visibility("read")
  description?: string;
}

/**
 * Collection of snapshots which can be used to revert an app to a previous time.
 */
model SnapshotCollection is Azure.Core.Page<Snapshot>;

/**
 * SiteSourceControl resource specific properties
 */
model SiteSourceControlProperties {
  /**
   * Repository or source control URL.
   */
  @visibility("read", "create")
  repoUrl?: string;

  /**
   * Name of branch to use for deployment.
   */
  @visibility("read", "create")
  branch?: string;

  /**
   * <code>true</code> to limit to manual integration; <code>false</code> to enable continuous integration (which configures webhooks into online repos like GitHub).
   */
  @visibility("read", "create")
  isManualIntegration?: boolean;

  /**
   * <code>true</code> if this is deployed via GitHub action.
   */
  @visibility("read", "create")
  isGitHubAction?: boolean;

  /**
   * <code>true</code> to enable deployment rollback; otherwise, <code>false</code>.
   */
  @visibility("read", "create")
  deploymentRollbackEnabled?: boolean;

  /**
   * <code>true</code> for a Mercurial repository; <code>false</code> for a Git repository.
   */
  @visibility("read", "create")
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
  password?: string;
}

/**
 * TriggeredWebJob resource specific properties
 */
model TriggeredWebJobProperties {
  /**
   * Latest job run information.
   */
  @projectedName("json", "latest_run")
  latestRun?: TriggeredJobRun;

  /**
   * History URL.
   */
  @projectedName("json", "history_url")
  historyUrl?: string;

  /**
   * Scheduler Logs URL.
   */
  @projectedName("json", "scheduler_logs_url")
  schedulerLogsUrl?: string;

  /**
   * Run command.
   */
  @projectedName("json", "run_command")
  runCommand?: string;

  /**
   * Job URL.
   */
  url?: string;

  /**
   * Extra Info URL.
   */
  @projectedName("json", "extra_info_url")
  extraInfoUrl?: string;

  /**
   * Job type.
   */
  @projectedName("json", "web_job_type")
  webJobType?: WebJobType;

  /**
   * Error information.
   */
  error?: string;

  /**
   * Using SDK?
   */
  @projectedName("json", "using_sdk")
  usingSdk?: boolean;

  /**
   * Job settings.
   */
  settings?: Record<Record<unknown>>;
}

/**
 * Triggered Web Job Run Information.
 */
model TriggeredJobRun {
  /**
   * Job ID.
   */
  @projectedName("json", "web_job_id")
  webJobId?: string;

  /**
   * Job name.
   */
  @projectedName("json", "web_job_name")
  webJobName?: string;

  /**
   * Job status.
   */
  status?: TriggeredWebJobStatus;

  /**
   * Start time.
   */
  @projectedName("json", "start_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time.
   */
  @projectedName("json", "end_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Job duration.
   */
  duration?: duration;

  /**
   * Output URL.
   */
  @projectedName("json", "output_url")
  outputUrl?: string;

  /**
   * Error URL.
   */
  @projectedName("json", "error_url")
  errorUrl?: string;

  /**
   * Job URL.
   */
  url?: string;

  /**
   * Job name.
   */
  @projectedName("json", "job_name")
  jobName?: string;

  /**
   * Job trigger.
   */
  trigger?: string;
}

/**
 * TriggeredJobHistory resource specific properties
 */
model TriggeredJobHistoryProperties {
  /**
   * List of triggered web job runs.
   */
  runs?: TriggeredJobRun[];
}

/**
 * WebJob resource specific properties
 */
model WebJobProperties {
  /**
   * Run command.
   */
  @projectedName("json", "run_command")
  runCommand?: string;

  /**
   * Job URL.
   */
  url?: string;

  /**
   * Extra Info URL.
   */
  @projectedName("json", "extra_info_url")
  extraInfoUrl?: string;

  /**
   * Job type.
   */
  @projectedName("json", "web_job_type")
  webJobType?: WebJobType;

  /**
   * Error information.
   */
  error?: string;

  /**
   * Using SDK?
   */
  @projectedName("json", "using_sdk")
  usingSdk?: boolean;

  /**
   * Job settings.
   */
  settings?: Record<Record<unknown>>;
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
 * Object with a list of the resources that need to be moved and the resource group they should be moved to.
 */
model CsmMoveResourceEnvelope {
  @maxLength(90)
  @minLength(1)
  @pattern(" ^[-\\w\\._\\(\\)]+[^\\.]$")
  targetResourceGroup?: string;

  resources?: string[];
}

/**
 * A static site user provided function.
 */
model StaticSiteUserProvidedFunctionApp extends ProxyOnlyResource {
  /**
   * StaticSiteUserProvidedFunctionApp resource specific properties
   */
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;
}
