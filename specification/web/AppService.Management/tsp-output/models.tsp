import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.AppService;

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

enum LoadBalancingMode {
  None,
  Web,
  Publishing,
  `Web, Publishing`,
}

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

enum IpFilterTag {
  Default,
  XffProxy,
  ServiceTag,
}

enum SupportedTlsVersions {
  `1.0`,
  `1.1`,
  `1.2`,
}

enum FtpsState {
  AllAllowed,
  FtpsOnly,
  Disabled,
}

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

enum ResourceScopeType {
  ServerFarm,
  Subscription,
  WebSite,
}

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

enum ValidateResourceTypes {
  ServerFarm,
  Site,
  `Microsoft.Web/hostingEnvironments`,
}

enum BuildStatus {
  WaitingForDeployment,
  Uploading,
  Deploying,
  Ready,
  Failed,
  Deleting,
  Detached,
}

enum TriggerTypes {
  HttpTrigger,
  Unknown,
}

enum CustomDomainStatus {
  RetrievingValidationToken,
  Validating,
  Adding,
  Ready,
  Failed,
  Deleting,
}

enum DatabaseType {
  SqlAzure,
  MySql,
  LocalMySql,
  PostgreSql,
}

enum PublishingProfileFormat {
  FileZilla3,
  WebDeploy,
  Ftp,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum CertificateProductType {
  StandardDomainValidatedSsl,
  StandardDomainValidatedWildCardSsl,
}
@Azure.Core.fixed
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  InProgress,
  Deleting,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
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
@Azure.Core.fixed
enum DetectorType {
  Detector,
  Analysis,
  CategoryOverview,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum InsightStatus {
  Critical,
  Warning,
  Info,
  Success,
  None,
}
@Azure.Core.fixed
enum DomainType {
  Regular,
  SoftDeleted,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum AzureResourceType {
  Website,
  TrafficManager,
}
@Azure.Core.fixed
enum CustomHostNameDnsRecordType {
  CName,
  A,
}
@Azure.Core.fixed
enum HostNameType {
  Verified,
  Managed,
}
@Azure.Core.fixed
enum DnsType {
  AzureDns,
  DefaultDomainRegistrarDns,
}
@Azure.Core.fixed
enum HostingEnvironmentStatus {
  Preparing,
  Ready,
  Scaling,
  Deleting,
}
@Azure.Core.fixed
enum ComputeModeOptions {
  Shared,
  Dedicated,
  Dynamic,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum OperationStatus {
  InProgress,
  Failed,
  Succeeded,
  TimedOut,
  Created,
}
@Azure.Core.fixed
enum StatusOptions {
  Ready,
  Pending,
  Creating,
}
@Azure.Core.fixed
enum UsageState {
  Normal,
  Exceeded,
}
@Azure.Core.fixed
enum SiteAvailabilityState {
  Normal,
  Limited,
  DisasterRecoveryMode,
}
@Azure.Core.fixed
enum SslState {
  Disabled,
  SniEnabled,
  IpBasedEnabled,
}
@Azure.Core.fixed
enum HostType {
  Standard,
  Repository,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum ManagedPipelineMode {
  Integrated,
  Classic,
}
@Azure.Core.fixed
enum SiteLoadBalancing {
  WeightedRoundRobin,
  LeastRequests,
  LeastResponseTime,
  WeightedTotalTraffic,
  RequestHash,
  PerSiteRoundRobin,
}
@Azure.Core.fixed
enum AutoHealActionType {
  Recycle,
  LogEvent,
  CustomAction,
}
@Azure.Core.fixed
enum AzureStorageType {
  AzureFiles,
  AzureBlob,
}
@Azure.Core.fixed
enum AzureStorageState {
  Ok,
  InvalidCredentials,
  InvalidShare,
  NotValidated,
}
@Azure.Core.fixed
enum ClientCertMode {
  Required,
  Optional,
  OptionalInteractiveUser,
}
@Azure.Core.fixed
enum RedundancyMode {
  None,
  Manual,
  Failover,
  ActiveActive,
  GeoRedundant,
}
@Azure.Core.fixed
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum SolutionType {
  QuickSolution,
  DeepInvestigation,
  BestPractices,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum StorageType {
  LocalNode,
  NetworkFileSystem,
}
@Azure.Core.fixed
enum FrontEndServiceType {
  NodePort,
  LoadBalancer,
}
@Azure.Core.fixed
enum StackPreferredOs {
  Windows,
  Linux,
}
@Azure.Core.fixed
enum NotificationLevel {
  Critical,
  Warning,
  Information,
  NonUrgentSuggestion,
}
@Azure.Core.fixed
enum Channels {
  Notification,
  Api,
  Email,
  Webhook,
  All,
}
@Azure.Core.fixed
enum AppServicePlanRestrictions {
  None,
  Free,
  Shared,
  Basic,
  Standard,
  Premium,
}
@Azure.Core.fixed
enum StagingEnvironmentPolicy {
  Enabled,
  Disabled,
}
@Azure.Core.fixed
enum DnsVerificationTestResult {
  Passed,
  Failed,
  Skipped,
}
@Azure.Core.fixed
enum FrequencyUnit {
  Day,
  Hour,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum BackupRestoreOperationType {
  Default,
  Clone,
  Relocation,
  Snapshot,
  CloudFS,
}
@Azure.Core.fixed
enum UnauthenticatedClientAction {
  RedirectToLoginPage,
  AllowAnonymous,
}
@Azure.Core.fixed
enum BuiltInAuthenticationProvider {
  AzureActiveDirectory,
  Facebook,
  Google,
  MicrosoftAccount,
  Twitter,
  Github,
}
@Azure.Core.fixed
enum UnauthenticatedClientActionV2 {
  RedirectToLoginPage,
  AllowAnonymous,
  Return401,
  Return403,
}
@Azure.Core.fixed
enum CookieExpirationConvention {
  FixedTime,
  IdentityProviderDerived,
}
@Azure.Core.fixed
enum ForwardProxyConvention {
  NoProxy,
  Standard,
  Custom,
}
@Azure.Core.fixed
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
@Azure.Core.fixed
enum LogLevel {
  Off,
  Verbose,
  Information,
  Warning,
  Error,
}
@Azure.Core.fixed
enum ContinuousWebJobStatus {
  Initializing,
  Starting,
  Running,
  PendingRestart,
  Stopped,
}
@Azure.Core.fixed
enum WebJobType {
  Continuous,
  Triggered,
}
@Azure.Core.fixed
enum MSDeployProvisioningState {
  accepted,
  running,
  succeeded,
  failed,
  canceled,
}
@Azure.Core.fixed
enum MSDeployLogEntryType {
  Message,
  Warning,
  Error,
}
@Azure.Core.fixed
enum SiteRuntimeState {
  READY,
  STOPPED,
  UNKNOWN,
}
@Azure.Core.fixed
enum CloneAbilityResult {
  Cloneable,
  PartiallyCloneable,
  NotCloneable,
}
@Azure.Core.fixed
enum MySqlMigrationType {
  LocalToRemote,
  RemoteToLocal,
}
@Azure.Core.fixed
enum PublicCertificateLocation {
  CurrentUserMy,
  LocalMachineMy,
  Unknown,
}
@Azure.Core.fixed
enum SiteExtensionType {
  Gallery,
  WebRoot,
}
@Azure.Core.fixed
enum TriggeredWebJobStatus {
  Success,
  Failed,
  Error,
}

@doc("AppServiceCertificateOrder resource specific properties")
model AppServiceCertificateOrderProperties {
  @doc("State of the Key Vault secret.")
  certificates?: Record<AppServiceCertificate>;

  @doc("Certificate distinguished name.")
  @visibility("read", "create")
  distinguishedName?: string;

  @doc("Domain verification token.")
  @visibility("read")
  domainVerificationToken?: string;

  @doc("Duration in years (must be 1).")
  @visibility("read", "create")
  validityInYears?: int32;

  @doc("Certificate key size.")
  @visibility("read", "create")
  keySize?: int32;

  @doc("Certificate product type.")
  @visibility("read", "create")
  productType: CertificateProductType;

  @doc("<code>true</code> if the certificate should be automatically renewed when it expires; otherwise, <code>false</code>.")
  autoRenew?: boolean;

  @doc("Status of certificate order.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Current order status.")
  @visibility("read")
  status?: CertificateOrderStatus;

  @doc("Signed certificate.")
  @visibility("read")
  signedCertificate?: CertificateDetails;

  @doc("Last CSR that was created for this order.")
  @visibility("read", "create")
  csr?: string;

  @doc("Intermediate certificate.")
  @visibility("read")
  intermediate?: CertificateDetails;

  @doc("Root certificate.")
  @visibility("read")
  root?: CertificateDetails;

  @doc("Current serial number of the certificate.")
  @visibility("read")
  serialNumber?: string;

  @doc("Certificate last issuance time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCertificateIssuanceTime?: utcDateTime;

  @doc("Certificate expiration time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  @doc("<code>true</code> if private key is external; otherwise, <code>false</code>.")
  @visibility("read")
  isPrivateKeyExternal?: boolean;

  @doc("Reasons why App Service Certificate is not renewable at the current moment.")
  @visibility("read")
  appServiceCertificateNotRenewableReasons?: AppServiceCertificateNotRenewableReason[];

  @doc("Time stamp when the certificate would be auto renewed next")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextAutoRenewalTimeStamp?: utcDateTime;

  @doc("Contact info")
  @visibility("read")
  contact?: CertificateOrderContact;
}

@doc("Key Vault container for a certificate that is purchased through Azure.")
model AppServiceCertificate {
  @doc("Key Vault resource Id.")
  keyVaultId?: string;

  @doc("Key Vault secret name.")
  keyVaultSecretName?: string;

  @doc("Status of the Key Vault secret.")
  @visibility("read")
  provisioningState?: KeyVaultSecretStatus;
}

@doc("SSL certificate details.")
model CertificateDetails {
  @doc("Certificate Version.")
  @visibility("read")
  version?: int32;

  @doc("Certificate Serial Number.")
  @visibility("read")
  serialNumber?: string;

  @doc("Certificate Thumbprint.")
  @visibility("read")
  thumbprint?: string;

  @doc("Certificate Subject.")
  @visibility("read")
  subject?: string;

  @doc("Date Certificate is valid from.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notBefore?: utcDateTime;

  @doc("Date Certificate is valid to.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notAfter?: utcDateTime;

  @doc("Certificate Signature algorithm.")
  @visibility("read")
  signatureAlgorithm?: string;

  @doc("Certificate Issuer.")
  @visibility("read")
  issuer?: string;

  @doc("Raw certificate data.")
  @visibility("read")
  rawData?: string;
}

model CertificateOrderContact {
  email?: string;
  nameFirst?: string;
  nameLast?: string;
  phone?: string;
}

@doc("App Service error response.")
@error
model DefaultErrorResponse {
  @doc("Error model.")
  @visibility("read")
  error?: DefaultErrorResponseError;
}

@doc("Error model.")
model DefaultErrorResponseError {
  @doc("Standardized string to programmatically identify the error.")
  @visibility("read")
  code?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  message?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  target?: string;

  details?: DefaultErrorResponseErrorDetailsItem[];

  @doc("More information to debug error.")
  @visibility("read")
  innererror?: string;
}

@doc("Detailed errors.")
model DefaultErrorResponseErrorDetailsItem {
  @doc("Standardized string to programmatically identify the error.")
  @visibility("read")
  code?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  message?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  target?: string;
}

@doc("Azure proxy only resource. This resource is not tracked by Azure Resource Manager.")
model ProxyOnlyResource {
  @doc("Resource Id.")
  @visibility("read")
  id?: string;

  @doc("Resource Name.")
  @visibility("read")
  name?: string;

  @doc("Kind of resource.")
  kind?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;
}

@doc("Class representing certificate reissue request.")
model ReissueCertificateOrderRequest {
  ...ProxyOnlyResource;

  @doc("ReissueCertificateOrderRequest resource specific properties")
  properties?: ReissueCertificateOrderRequestProperties;
}

@doc("ReissueCertificateOrderRequest resource specific properties")
model ReissueCertificateOrderRequestProperties {
  @doc("Certificate Key Size.")
  keySize?: int32;

  @doc("Delay in hours to revoke existing certificate after the new certificate is issued.")
  delayExistingRevokeInHours?: int32;

  @doc("Csr to be used for re-key operation.")
  csr?: string;

  @doc("Should we change the ASC type (from managed private key to external private key and vice versa).")
  isPrivateKeyExternal?: boolean;
}

@doc("Class representing certificate renew request.")
model RenewCertificateOrderRequest {
  ...ProxyOnlyResource;

  @doc("RenewCertificateOrderRequest resource specific properties")
  properties?: RenewCertificateOrderRequestProperties;
}

@doc("RenewCertificateOrderRequest resource specific properties")
model RenewCertificateOrderRequestProperties {
  @doc("Certificate Key Size.")
  keySize?: int32;

  @doc("Csr to be used for re-key operation.")
  csr?: string;

  @doc("Should we change the ASC type (from managed private key to external private key and vice versa).")
  isPrivateKeyExternal?: boolean;
}

@doc("Identifies an object.")
model NameIdentifier {
  @doc("Name of the object.")
  name?: string;
}

@doc("Site seal request.")
model SiteSealRequest {
  @doc("If <code>true</code> use the light color theme for site seal; otherwise, use the default color theme.")
  lightTheme?: boolean;

  @doc("Locale of site seal.")
  locale?: string;
}

@doc("Site seal")
model SiteSeal {
  @doc("HTML snippet")
  html: string;
}

@doc("Certificate order action.")
model CertificateOrderAction {
  ...ProxyOnlyResource;

  @doc("CertificateOrderAction resource specific properties")
  properties?: CertificateOrderActionProperties;
}

@doc("CertificateOrderAction resource specific properties")
model CertificateOrderActionProperties {
  @doc("Action type.")
  @visibility("read")
  actionType?: CertificateOrderActionType;

  @doc("Time at which the certificate action was performed.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;
}

@doc("SSL certificate email.")
model CertificateEmail {
  ...ProxyOnlyResource;

  @doc("CertificateEmail resource specific properties")
  properties?: CertificateEmailProperties;
}

@doc("CertificateEmail resource specific properties")
model CertificateEmailProperties {
  @doc("Email id.")
  emailId?: string;

  @doc("Time stamp.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;
}

@doc("DetectorResponse resource specific properties")
model DetectorResponseProperties {
  @doc("metadata for the detector")
  metadata?: DetectorInfo;

  @doc("Data Set")
  dataset?: DiagnosticData[];

  @doc("Indicates status of the most severe insight.")
  status?: Status;

  @doc("Additional configuration for different data providers to be used by the UI")
  dataProvidersMetadata?: DataProviderMetadata[];

  @doc("Suggested utterances where the detector can be applicable.")
  suggestedUtterances?: QueryUtterancesResults;
}

@doc("Definition of Detector")
model DetectorInfo {
  @doc("Id of detector")
  @visibility("read")
  id?: string;

  @doc("Name of detector")
  @visibility("read")
  name?: string;

  @doc("Short description of the detector and its purpose.")
  @visibility("read")
  description?: string;

  @doc("Author of the detector.")
  @visibility("read")
  author?: string;

  @doc("Problem category. This serves for organizing group for detectors.")
  @visibility("read")
  category?: string;

  @doc("List of Support Topics for which this detector is enabled.")
  @visibility("read")
  supportTopicList?: SupportTopic[];

  @doc("Analysis Types for which this detector should apply to.")
  @visibility("read")
  analysisType?: string[];

  @doc("Whether this detector is an Analysis Detector or not.")
  @visibility("read")
  type?: DetectorType;

  @doc("Defines score of a detector to power ML based matching.")
  @visibility("read")
  score?: float32;
}

@doc("Defines a unique Support Topic")
model SupportTopic {
  @doc("Support Topic Id")
  @visibility("read")
  id?: string;

  @doc("Unique resource Id")
  @visibility("read")
  pesId?: string;
}

@doc("Set of data with rendering instructions")
model DiagnosticData {
  @doc("Data in table form")
  table?: DataTableResponseObject;

  @doc("Properties that describe how the table should be rendered")
  renderingProperties?: Rendering;
}

@doc("Data Table which defines columns and raw row values")
model DataTableResponseObject {
  @doc("Name of the table")
  tableName?: string;

  @doc("List of columns with data types")
  columns?: DataTableResponseColumn[];

  @doc("Raw row values")
  rows?: string[][];
}

@doc("Column definition")
model DataTableResponseColumn {
  @doc("Name of the column")
  columnName?: string;

  @doc("Data type which looks like 'String' or 'Int32'.")
  dataType?: string;

  @doc("Column Type")
  columnType?: string;
}

@doc("Instructions for rendering the data")
model Rendering {
  @doc("Rendering Type")
  type?: RenderingType;

  @doc("Title of data")
  title?: string;

  @doc("Description of the data that will help it be interpreted")
  description?: string;
}

@doc("Identify the status of the most severe insight generated by the detector.")
model Status {
  @doc("Descriptive message.")
  message?: string;

  @doc("Level of the most severe insight generated by the detector.")
  statusId?: InsightStatus;
}

@doc("Additional configuration for a data providers")
model DataProviderMetadata {
  providerName?: string;

  @doc("Settings for the data provider")
  @visibility("read")
  propertyBag?: KeyValuePairStringObject[];
}

model KeyValuePairStringObject {
  @visibility("read")
  key?: string;

  @doc("Any object")
  @visibility("read")
  value?: Record<unknown>;
}

@doc("Suggested utterances where the detector can be applicable")
model QueryUtterancesResults {
  @doc("Search Query.")
  query?: string;

  @doc("Array of utterance results for search query.")
  results?: QueryUtterancesResult[];
}

@doc("Result for utterances query.")
model QueryUtterancesResult {
  @doc("A sample utterance.")
  sampleUtterance?: SampleUtterance;

  @doc("Score of a sample utterance.")
  score?: float32;
}

@doc("Sample utterance.")
model SampleUtterance {
  @doc("Text attribute of sample utterance.")
  text?: string;

  @doc("Links attribute of sample utterance.")
  links?: string[];

  @doc("Question id of sample utterance (for stackoverflow questions titles).")
  qid?: string;
}

@doc("Collection of Azure resource manager operation metadata.")
model CsmOperationCollection is Azure.Core.Page<CsmOperationDescription>;

@doc("Description of an operation available for Microsoft.Web resource provider.")
model CsmOperationDescription {
  name?: string;
  isDataAction?: boolean;

  @doc("Meta data about operation used for display in portal.")
  display?: CsmOperationDisplay;

  origin?: string;

  @doc("Properties available for a Microsoft.Web resource provider operation.")
  properties?: CsmOperationDescriptionProperties;
}

@doc("Meta data about operation used for display in portal.")
model CsmOperationDisplay {
  provider?: string;
  resource?: string;
  operation?: string;
  description?: string;
}

@doc("Properties available for a Microsoft.Web resource provider operation.")
model CsmOperationDescriptionProperties {
  @doc("Resource metrics service provided by Microsoft.Insights resource provider.")
  serviceSpecification?: ServiceSpecification;
}

@doc("Resource metrics service provided by Microsoft.Insights resource provider.")
model ServiceSpecification {
  metricSpecifications?: MetricSpecification[];
  logSpecifications?: LogSpecification[];
}

@doc("Definition of a single resource metric.")
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

@doc("""
Dimension of a resource metric. For e.g. instance specific HTTP requests for a web app, 
where instance name is dimension of the metric HTTP request
""")
model Dimension {
  name?: string;
  displayName?: string;
  internalName?: string;
  toBeExportedForShoebox?: boolean;
}

@doc("Retention policy of a resource metric.")
model MetricAvailability {
  timeGrain?: string;
  blobDuration?: duration;
}

@doc("Log Definition of a single resource metric.")
model LogSpecification {
  name?: string;
  displayName?: string;
  blobDuration?: duration;
  logFilterPattern?: string;
}

@doc("Domain availability check result.")
model DomainAvailabilityCheckResult {
  @doc("Name of the domain.")
  name?: string;

  @doc("<code>true</code> if domain can be purchased using CreateDomain API; otherwise, <code>false</code>.")
  available?: boolean;

  @doc("Valid values are Regular domain: Azure will charge the full price of domain registration, SoftDeleted: Purchasing this domain will simply restore it and this operation will not cost anything.")
  domainType?: DomainType;
}

@doc("Domain resource specific properties")
model DomainProperties {
  @doc("Administrative contact.")
  @visibility("create")
  contactAdmin: Contact;

  @doc("Billing contact.")
  @visibility("create")
  contactBilling: Contact;

  @doc("Registrant contact.")
  @visibility("create")
  contactRegistrant: Contact;

  @doc("Technical contact.")
  @visibility("create")
  contactTech: Contact;

  @doc("Domain registration status.")
  @visibility("read")
  registrationStatus?: DomainStatus;

  @doc("Domain provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Name servers.")
  @visibility("read")
  nameServers?: string[];

  @doc("<code>true</code> if domain privacy is enabled for this domain; otherwise, <code>false</code>.")
  privacy?: boolean;

  @doc("Domain creation timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Domain expiration timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  @doc("Timestamp when the domain was renewed last time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRenewedTime?: utcDateTime;

  @doc("<code>true</code> if the domain should be automatically renewed; otherwise, <code>false</code>.")
  autoRenew?: boolean;

  @doc("""
<code>true</code> if Azure can assign this domain to App Service apps; otherwise, <code>false</code>. This value will be <code>true</code> if domain registration status is active and 
 it is hosted on name servers Azure has programmatic access to.
""")
  @visibility("read")
  readyForDnsRecordManagement?: boolean;

  @doc("All hostnames derived from the domain and assigned to Azure resources.")
  @visibility("read")
  managedHostNames?: HostName[];

  @doc("Legal agreement consent.")
  @visibility("create")
  consent: DomainPurchaseConsent;

  @doc("Reasons why domain is not renewable.")
  @visibility("read")
  domainNotRenewableReasons?: DomainNotRenewableReasons[];

  @doc("Current DNS type")
  dnsType?: DnsType;

  @doc("Azure DNS Zone to use")
  dnsZoneId?: string;

  @doc("Target DNS type (would be used for migration)")
  targetDnsType?: DnsType;

  @visibility("read", "create")
  authCode?: string;
}

@doc("""
Contact information for domain registration. If 'Domain Privacy' option is not selected then the contact information is made publicly available through the Whois 
directories as per ICANN requirements.
""")
model Contact {
  @doc("Mailing address.")
  addressMailing?: Address;

  @doc("Email address.")
  email: string;

  @doc("Fax number.")
  fax?: string;

  @doc("Job title.")
  jobTitle?: string;

  @doc("First name.")
  nameFirst: string;

  @doc("Last name.")
  nameLast: string;

  @doc("Middle name.")
  nameMiddle?: string;

  @doc("Organization contact belongs to.")
  organization?: string;

  @doc("Phone number.")
  phone: string;
}

@doc("Address information for domain registration.")
model Address {
  @doc("First line of an Address.")
  address1: string;

  @doc("The second line of the Address. Optional.")
  address2?: string;

  @doc("The city for the address.")
  city: string;

  @doc("The country for the address.")
  country: string;

  @doc("The postal code for the address.")
  postalCode: string;

  @doc("The state or province for the address.")
  state: string;
}

@doc("Details of a hostname derived from a domain.")
model HostName {
  @doc("Name of the hostname.")
  name?: string;

  @doc("List of apps the hostname is assigned to. This list will have more than one app only if the hostname is pointing to a Traffic Manager.")
  siteNames?: string[];

  @doc("Name of the Azure resource the hostname is assigned to. If it is assigned to a Traffic Manager then it will be the Traffic Manager name otherwise it will be the app name.")
  azureResourceName?: string;

  @doc("Type of the Azure resource the hostname is assigned to.")
  azureResourceType?: AzureResourceType;

  @doc("Type of the DNS record.")
  customHostNameDnsRecordType?: CustomHostNameDnsRecordType;

  @doc("Type of the hostname.")
  hostNameType?: HostNameType;
}

@doc("Domain purchase consent object, representing acceptance of applicable legal agreements.")
model DomainPurchaseConsent {
  @doc("List of applicable legal agreement keys. This list can be retrieved using ListLegalAgreements API under <code>TopLevelDomain</code> resource.")
  agreementKeys?: string[];

  @doc("Client IP address.")
  agreedBy?: string;

  @doc("Timestamp when the agreements were accepted.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  agreedAt?: utcDateTime;
}

@doc("Single sign-on request information for domain management.")
model DomainControlCenterSsoRequest {
  @doc("URL where the single sign-on request is to be made.")
  @visibility("read")
  url?: string;

  @doc("Post parameter key.")
  @visibility("read")
  postParameterKey?: string;

  @doc("Post parameter value. Client should use 'application/x-www-form-urlencoded' encoding for this value.")
  @visibility("read")
  postParameterValue?: string;
}

@doc("Domain recommendation search parameters.")
model DomainRecommendationSearchParameters {
  @doc("Keywords to be used for generating domain recommendations.")
  keywords?: string;

  @doc("Maximum number of recommendations.")
  maxDomainRecommendations?: int32;
}

@doc("Collection of domain name identifiers.")
model NameIdentifierCollection is Azure.Core.Page<NameIdentifier>;

@doc("DomainOwnershipIdentifier resource specific properties")
model DomainOwnershipIdentifierProperties {
  @doc("Ownership Id.")
  ownershipId?: string;
}

@doc("TopLevelDomain resource specific properties")
model TopLevelDomainProperties {
  @doc("If <code>true</code>, then the top level domain supports domain privacy; otherwise, <code>false</code>.")
  privacy?: boolean;
}

@doc("Options for retrieving the list of top level domain legal agreements.")
model TopLevelDomainAgreementOption {
  @doc("If <code>true</code>, then the list of agreements will include agreements for domain privacy as well; otherwise, <code>false</code>.")
  includePrivacy?: boolean;

  @doc("If <code>true</code>, then the list of agreements will include agreements for domain transfer as well; otherwise, <code>false</code>.")
  forTransfer?: boolean;
}

@doc("Collection of top-level domain legal agreements.")
model TldLegalAgreementCollection is Azure.Core.Page<TldLegalAgreement>;

@doc("Legal agreement for a top level domain.")
model TldLegalAgreement {
  @doc("Unique identifier for the agreement.")
  agreementKey: string;

  @doc("Agreement title.")
  title: string;

  @doc("Agreement details.")
  content: string;

  @doc("URL where a copy of the agreement details is hosted.")
  url?: string;
}

@doc("Description of an App Service Environment.")
model AppServiceEnvironment {
  @doc("Provisioning state of the App Service Environment.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Current status of the App Service Environment.")
  @visibility("read")
  status?: HostingEnvironmentStatus;

  @doc("Description of the Virtual Network.")
  virtualNetwork: VirtualNetworkProfile;

  @doc("Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment.")
  internalLoadBalancingMode?: LoadBalancingMode;

  @doc("Front-end VM size, e.g. \"Medium\", \"Large\".")
  multiSize?: string;

  @doc("Number of front-end instances.")
  @visibility("read")
  multiRoleCount?: int32;

  @doc("Number of IP SSL addresses reserved for the App Service Environment.")
  ipsslAddressCount?: int32;

  @doc("DNS suffix of the App Service Environment.")
  dnsSuffix?: string;

  @doc("Maximum number of VMs in the App Service Environment.")
  @visibility("read")
  maximumNumberOfMachines?: int32;

  @doc("Scale factor for front-ends.")
  frontEndScaleFactor?: int32;

  @doc("""
<code>true</code> if the App Service Environment is suspended; otherwise, <code>false</code>. The environment can be suspended, e.g. when the management endpoint is no longer available
 (most likely because NSG blocked the incoming traffic).
""")
  @visibility("read")
  suspended?: boolean;

  @doc("Custom settings for changing the behavior of the App Service Environment.")
  clusterSettings?: NameValuePair[];

  @doc("User added ip ranges to whitelist on ASE db")
  userWhitelistedIpRanges?: string[];

  @doc("Flag that displays whether an ASE has linux workers or not")
  @visibility("read")
  hasLinuxWorkers?: boolean;

  @doc("Dedicated Host Count")
  dedicatedHostCount?: int32;

  @doc("Whether or not this App Service Environment is zone-redundant.")
  zoneRedundant?: boolean;
}

@doc("Specification for using a Virtual Network.")
model VirtualNetworkProfile {
  @doc("Resource id of the Virtual Network.")
  id: string;

  @doc("Name of the Virtual Network (read-only).")
  @visibility("read")
  name?: string;

  @doc("Resource type of the Virtual Network (read-only).")
  @visibility("read")
  type?: string;

  @doc("Subnet within the Virtual Network.")
  subnet?: string;
}

@doc("Name value pair.")
model NameValuePair {
  @doc("Pair name.")
  name?: string;

  @doc("Pair value.")
  value?: string;
}

@doc("Collection of stamp capacities.")
model StampCapacityCollection is Azure.Core.Page<StampCapacity>;

@doc("Stamp capacity information.")
model StampCapacity {
  @doc("Name of the stamp.")
  name?: string;

  @doc("Available capacity (# of machines, bytes of storage etc...).")
  availableCapacity?: int32;

  @doc("Total capacity (# of machines, bytes of storage etc...).")
  totalCapacity?: int32;

  @doc("Name of the unit.")
  unit?: string;

  @doc("Shared/dedicated workers.")
  computeMode?: ComputeModeOptions;

  @doc("Size of the machines.")
  workerSize?: WorkerSizeOptions;

  @doc("""
Size ID of machines: 
0 - Small
1 - Medium
2 - Large
""")
  workerSizeId?: int32;

  @doc("""
If <code>true</code>, it includes basic apps.
Basic apps are not used for capacity allocation.
""")
  excludeFromCapacityAllocation?: boolean;

  @doc("<code>true</code> if capacity is applicable for all apps; otherwise, <code>false</code>.")
  isApplicableForAllComputeModes?: boolean;

  @doc("Shared or Dedicated.")
  siteMode?: string;

  @doc("Is this a linux stamp capacity")
  isLinux?: boolean;
}

@doc("Describes main public IP address and any extra virtual IPs.")
model AddressResponse {
  ...ProxyOnlyResource;

  @doc("AddressResponse resource specific properties")
  properties?: AddressResponseProperties;
}

@doc("AddressResponse resource specific properties")
model AddressResponseProperties {
  @doc("Main public virtual IP.")
  serviceIpAddress?: string;

  @doc("Virtual Network internal IP address of the App Service Environment if it is in internal load-balancing mode.")
  internalIpAddress?: string;

  @doc("IP addresses appearing on outbound connections.")
  outboundIpAddresses?: string[];

  @doc("Additional virtual IPs.")
  vipMappings?: VirtualIPMapping[];
}

@doc("Virtual IP mapping.")
model VirtualIPMapping {
  @doc("Virtual IP address.")
  virtualIP?: string;

  @doc("Internal HTTP port.")
  internalHttpPort?: int32;

  @doc("Internal HTTPS port.")
  internalHttpsPort?: int32;

  @doc("Is virtual IP mapping in use.")
  inUse?: boolean;

  @doc("name of the service that virtual IP is assigned to")
  serviceName?: string;
}

@doc("AseV3NetworkingConfiguration resource specific properties")
model AseV3NetworkingConfigurationProperties {
  @visibility("read")
  windowsOutboundIpAddresses?: string[];

  @visibility("read")
  linuxOutboundIpAddresses?: string[];

  @visibility("read")
  externalInboundIpAddresses?: string[];

  @visibility("read")
  internalInboundIpAddresses?: string[];

  @doc("Property to enable and disable new private endpoint connection creation on ASE")
  allowNewPrivateEndpointConnections?: boolean;
}

@doc("Diagnostics for an App Service Environment.")
model HostingEnvironmentDiagnostics {
  @doc("Name/identifier of the diagnostics.")
  name?: string;

  @doc("Diagnostics output.")
  diagnosticsOutput?: string;
}

@doc("Collection of Inbound Environment Endpoints")
model InboundEnvironmentEndpointCollection
  is Azure.Core.Page<InboundEnvironmentEndpoint>;

@doc("The IP Addresses and Ports that require inbound network access to and within the subnet of the App Service Environment.")
model InboundEnvironmentEndpoint {
  @doc("Short text describing the purpose of the network traffic.")
  description?: string;

  @doc("The IP addresses that network traffic will originate from in cidr notation.")
  endpoints?: string[];

  @doc("The ports that network traffic will arrive to the App Service Environment at.")
  ports?: string[];
}

@doc("Worker pool of an App Service Environment.")
model WorkerPool {
  @doc("Worker size ID for referencing this worker pool.")
  workerSizeId?: int32;

  @doc("Shared or dedicated app hosting.")
  computeMode?: ComputeModeOptions;

  @doc("VM size of the worker pool instances.")
  workerSize?: string;

  @doc("Number of instances in the worker pool.")
  workerCount?: int32;

  @doc("Names of all instances in the worker pool (read only).")
  @visibility("read")
  instanceNames?: string[];
}

@doc("Description of a SKU for a scalable resource.")
model SkuDescription {
  @doc("Name of the resource SKU.")
  name?: string;

  @doc("Service tier of the resource SKU.")
  tier?: string;

  @doc("Size specifier of the resource SKU.")
  size?: string;

  @doc("Family code of the resource SKU.")
  family?: string;

  @doc("Current number of instances assigned to the resource.")
  capacity?: int32;

  @doc("Min, max, and default scale values of the SKU.")
  skuCapacity?: SkuCapacity;

  @doc("Locations of the SKU.")
  locations?: string[];

  @doc("Capabilities of the SKU, e.g., is traffic manager enabled?")
  capabilities?: Capability[];
}

@doc("Description of the App Service plan scale options.")
model SkuCapacity {
  @doc("Minimum number of workers for this App Service plan SKU.")
  minimum?: int32;

  @doc("Maximum number of workers for this App Service plan SKU.")
  maximum?: int32;

  @doc("Maximum number of Elastic workers for this App Service plan SKU.")
  elasticMaximum?: int32;

  @doc("Default number of workers for this App Service plan SKU.")
  default?: int32;

  @doc("Available scale configurations for an App Service plan.")
  scaleType?: string;
}

@doc("Describes the capabilities/features allowed for a specific SKU.")
model Capability {
  @doc("Name of the SKU capability.")
  name?: string;

  @doc("Value of the SKU capability.")
  value?: string;

  @doc("Reason of the SKU capability.")
  reason?: string;
}

@doc("Collection of metric definitions.")
model ResourceMetricDefinitionCollection
  is Azure.Core.Page<ResourceMetricDefinition>;

@doc("Metadata for the metrics.")
model ResourceMetricDefinition {
  ...ProxyOnlyResource;

  @doc("ResourceMetricDefinition resource specific properties")
  properties?: ResourceMetricDefinitionProperties;
}

@doc("ResourceMetricDefinition resource specific properties")
model ResourceMetricDefinitionProperties {
  @doc("Unit of the metric.")
  @visibility("read")
  unit?: string;

  @doc("Primary aggregation type.")
  @visibility("read")
  primaryAggregationType?: string;

  @doc("List of time grains supported for the metric together with retention period.")
  @visibility("read")
  metricAvailabilities?: ResourceMetricAvailability[];

  @doc("Resource URI.")
  @visibility("read")
  resourceUri?: string;

  @doc("Resource metric definition properties.")
  @visibility("read")
  properties?: Record<string>;
}

@doc("Metrics availability and retention.")
model ResourceMetricAvailability {
  @doc("Time grain .")
  @visibility("read")
  timeGrain?: string;

  @doc("Retention period for the current time grain.")
  @visibility("read")
  retention?: string;
}

@doc("Collection of SKU information.")
model SkuInfoCollection is Azure.Core.Page<SkuInfo>;

@doc("SKU discovery information.")
model SkuInfo {
  @doc("Resource type that this SKU applies to.")
  resourceType?: string;

  @doc("Name and tier of the SKU.")
  sku?: SkuDescription;

  @doc("Min, max, and default scale values of the SKU.")
  capacity?: SkuCapacity;
}

@doc("Collection of usages.")
model UsageCollection is Azure.Core.Page<Usage>;

@doc("Usage of the quota resource.")
model Usage {
  ...ProxyOnlyResource;

  @doc("Usage resource specific properties")
  properties?: UsageProperties;
}

@doc("Usage resource specific properties")
model UsageProperties {
  @doc("Friendly name shown in the UI.")
  @visibility("read")
  displayName?: string;

  @doc("Name of the quota resource.")
  @visibility("read")
  resourceName?: string;

  @doc("Units of measurement for the quota resource.")
  @visibility("read")
  unit?: string;

  @doc("The current value of the resource counter.")
  @visibility("read")
  currentValue?: int32;

  @doc("The resource limit.")
  @visibility("read")
  limit?: int32;

  @doc("Next reset time for the resource counter.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  @doc("Compute mode used for this usage.")
  @visibility("read")
  computeMode?: ComputeModeOptions;

  @doc("Site mode used for this usage.")
  @visibility("read")
  siteMode?: string;
}

@doc("Body of the error response returned from the API.")
model ErrorEntity {
  @doc("Type of error.")
  extendedCode?: string;

  @doc("Message template.")
  messageTemplate?: string;

  @doc("Parameters for the template.")
  parameters?: string[];

  @doc("Inner errors.")
  innerErrors?: ErrorEntity[];

  @doc("Error Details.")
  details?: ErrorEntity[];

  @doc("The error target.")
  target?: string;

  @doc("Basic error code.")
  code?: string;

  @doc("Any details of the error.")
  message?: string;
}

@doc("Collection of Outbound Environment Endpoints")
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

@doc("Endpoints accessed for a common purpose that the App Service Environment requires outbound network access to.")
model OutboundEnvironmentEndpoint {
  @doc("The type of service accessed by the App Service Environment, e.g., Azure Storage, Azure SQL Database, and Azure Active Directory.")
  category?: string;

  @doc("The endpoints that the App Service Environment reaches the service at.")
  endpoints?: EndpointDependency[];
}

@doc("A domain name that a service is reached at, including details of the current connection status.")
model EndpointDependency {
  @doc("The domain name of the dependency.")
  domainName?: string;

  @doc("The IP Addresses and Ports used when connecting to DomainName.")
  endpointDetails?: EndpointDetail[];
}

@doc("Current TCP connectivity information from the App Service Environment to a single endpoint.")
model EndpointDetail {
  @doc("An IP Address that Domain Name currently resolves to.")
  ipAddress?: string;

  @doc("The port an endpoint is connected to.")
  port?: int32;

  @doc("The time in milliseconds it takes for a TCP connection to be created from the App Service Environment to this IpAddress at this Port.")
  latency?: float32;

  @doc("Whether it is possible to create a TCP connection from the App Service Environment to this IpAddress at this Port.")
  isAccessible?: boolean;
}

@doc("RemotePrivateEndpointConnectionARMResource resource specific properties")
model RemotePrivateEndpointConnectionARMResourceProperties {
  @visibility("read")
  provisioningState?: string;

  @doc("PrivateEndpoint of a remote private endpoint connection")
  privateEndpoint?: ArmIdWrapper;

  @doc("The state of a private link connection")
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;

  @doc("Private IPAddresses mapped to the remote private endpoint")
  ipAddresses?: string[];
}

@doc("A wrapper for an ARM resource id")
model ArmIdWrapper {
  @visibility("read")
  id?: string;
}

@doc("The state of a private link connection")
model PrivateLinkConnectionState {
  @doc("Status of a private link connection")
  status?: string;

  @doc("Description of a private link connection")
  description?: string;

  @doc("ActionsRequired for a private link connection")
  actionsRequired?: string;
}

@doc("Private Endpoint Connection Approval ARM resource.")
model PrivateLinkConnectionApprovalRequestResource {
  ...ProxyOnlyResource;

  @doc("Core resource properties")
  properties?: PrivateLinkConnectionApprovalRequest;
}

@doc("A request to approve or reject a private endpoint connection")
model PrivateLinkConnectionApprovalRequest {
  @doc("The state of a private link connection")
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;
}

@doc("Wrapper for a collection of private link resources")
model PrivateLinkResourcesWrapper {
  value: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource {
  id: string;

  @doc("Name of a private link resource")
  name: string;

  type: string;

  @doc("Properties of a private link resource")
  properties: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource")
model PrivateLinkResourceProperties {
  @doc("GroupId of a private link resource")
  @visibility("read")
  groupId?: string;

  @doc("RequiredMembers of a private link resource")
  @visibility("read")
  requiredMembers?: string[];

  @doc("RequiredZoneNames of a private link resource")
  @visibility("read")
  requiredZoneNames?: string[];
}

@doc("AppServicePlan resource specific properties")
model AppServicePlanProperties {
  @doc("Target worker tier assigned to the App Service plan.")
  workerTierName?: string;

  @doc("App Service plan status.")
  @visibility("read")
  status?: StatusOptions;

  @doc("App Service plan subscription.")
  @visibility("read")
  subscription?: string;

  @doc("Specification for the App Service Environment to use for the App Service plan.")
  @visibility("read", "create")
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  @doc("Maximum number of instances that can be assigned to this App Service plan.")
  @visibility("read")
  maximumNumberOfWorkers?: int32;

  @doc("Geographical location for the App Service plan.")
  @visibility("read")
  geoRegion?: string;

  @doc("""
If <code>true</code>, apps assigned to this App Service plan can be scaled independently.
If <code>false</code>, apps assigned to this App Service plan will scale to all instances of the plan.
""")
  perSiteScaling?: boolean;

  @doc("ServerFarm supports ElasticScale. Apps in this plan will scale as if the ServerFarm was ElasticPremium sku")
  elasticScaleEnabled?: boolean;

  @doc("Maximum number of total workers allowed for this ElasticScaleEnabled App Service Plan")
  maximumElasticWorkerCount?: int32;

  @doc("Number of apps assigned to this App Service plan.")
  @visibility("read")
  numberOfSites?: int32;

  @doc("If <code>true</code>, this App Service Plan owns spot instances.")
  isSpot?: boolean;

  @doc("The time when the server farm expires. Valid only if it is a spot server farm.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  spotExpirationTime?: utcDateTime;

  @doc("The time when the server farm free offer expires.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  freeOfferExpirationTime?: utcDateTime;

  @doc("Resource group of the App Service plan.")
  @visibility("read")
  resourceGroup?: string;

  @doc("If Linux app service plan <code>true</code>, <code>false</code> otherwise.")
  @visibility("read", "create")
  reserved?: boolean;

  @doc("Obsolete: If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.")
  @visibility("read", "create")
  isXenon?: boolean;

  @doc("If Hyper-V container app service plan <code>true</code>, <code>false</code> otherwise.")
  @visibility("read", "create")
  hyperV?: boolean;

  @doc("Scaling worker count.")
  targetWorkerCount?: int32;

  @doc("Scaling worker size ID.")
  targetWorkerSizeId?: int32;

  @doc("Provisioning state of the App Service Plan.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Specification for the Kubernetes Environment to use for the App Service plan.")
  kubeEnvironmentProfile?: KubeEnvironmentProfile;

  @doc("""
If <code>true</code>, this App Service Plan will perform availability zone balancing.
If <code>false</code>, this App Service Plan will not perform availability zone balancing.
""")
  zoneRedundant?: boolean;
}

@doc("Specification for an App Service Environment to use for this resource.")
model HostingEnvironmentProfile {
  @doc("Resource ID of the App Service Environment.")
  id?: string;

  @doc("Name of the App Service Environment.")
  @visibility("read")
  name?: string;

  @doc("Resource type of the App Service Environment.")
  @visibility("read")
  type?: string;
}

@doc("Specification for a Kubernetes Environment to use for this resource.")
model KubeEnvironmentProfile {
  @doc("Resource ID of the Kubernetes Environment.")
  id?: string;

  @doc("Name of the Kubernetes Environment.")
  @visibility("read")
  name?: string;

  @doc("Resource type of the Kubernetes Environment.")
  @visibility("read")
  type?: string;
}

@doc("Extended Location.")
model ExtendedLocation {
  @doc("Name of extended location.")
  name?: string;

  @doc("Type of extended location.")
  @visibility("read")
  type?: string;
}

@doc("Site resource specific properties")
model SiteProperties {
  @doc("Current state of the app.")
  @visibility("read")
  state?: string;

  @doc("Hostnames associated with the app.")
  @visibility("read")
  hostNames?: string[];

  @doc("Name of the repository site.")
  @visibility("read")
  repositorySiteName?: string;

  @doc("State indicating whether the app has exceeded its quota usage. Read-only.")
  @visibility("read")
  usageState?: UsageState;

  @doc("<code>true</code> if the app is enabled; otherwise, <code>false</code>. Setting this value to false disables the app (takes the app offline).")
  enabled?: boolean;

  @doc("""
Enabled hostnames for the app.Hostnames need to be assigned (see HostNames) AND enabled. Otherwise,
the app is not served on those hostnames.
""")
  @visibility("read")
  enabledHostNames?: string[];

  @doc("Management information availability state for the app.")
  @visibility("read")
  availabilityState?: SiteAvailabilityState;

  @doc("Hostname SSL states are used to manage the SSL bindings for app's hostnames.")
  hostNameSslStates?: HostNameSslState[];

  @doc("Resource ID of the associated App Service plan, formatted as: \"/subscriptions/{subscriptionID}/resourceGroups/{groupName}/providers/Microsoft.Web/serverfarms/{appServicePlanName}\".")
  serverFarmId?: string;

  @doc("<code>true</code> if reserved; otherwise, <code>false</code>.")
  @visibility("read", "create")
  reserved?: boolean;

  @doc("Obsolete: Hyper-V sandbox.")
  @visibility("read", "create")
  isXenon?: boolean;

  @doc("Hyper-V sandbox.")
  @visibility("read", "create")
  hyperV?: boolean;

  @doc("Last time the app was modified, in UTC. Read-only.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTimeUtc?: utcDateTime;

  @doc("Configuration of the app.")
  siteConfig?: SiteConfigProperties;

  @doc("Azure Traffic Manager hostnames associated with the app. Read-only.")
  @visibility("read")
  trafficManagerHostNames?: string[];

  @doc("<code>true</code> to stop SCM (KUDU) site when the app is stopped; otherwise, <code>false</code>. The default is <code>false</code>.")
  scmSiteAlsoStopped?: boolean;

  @doc("Specifies which deployment slot this app will swap into. Read-only.")
  @visibility("read")
  targetSwapSlot?: string;

  @doc("App Service Environment to use for the app.")
  @visibility("read", "create")
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  @doc("<code>true</code> to enable client affinity; <code>false</code> to stop sending session affinity cookies, which route client requests in the same session to the same instance. Default is <code>true</code>.")
  clientAffinityEnabled?: boolean;

  @doc("<code>true</code> to enable client certificate authentication (TLS mutual authentication); otherwise, <code>false</code>. Default is <code>false</code>.")
  clientCertEnabled?: boolean;

  @doc("""
This composes with ClientCertEnabled setting.
- ClientCertEnabled: false means ClientCert is ignored.
- ClientCertEnabled: true and ClientCertMode: Required means ClientCert is required.
- ClientCertEnabled: true and ClientCertMode: Optional means ClientCert is optional or accepted.
""")
  clientCertMode?: ClientCertMode;

  @doc("client certificate authentication comma-separated exclusion paths")
  clientCertExclusionPaths?: string;

  @doc("""
<code>true</code> to disable the public hostnames of the app; otherwise, <code>false</code>.
 If <code>true</code>, the app is only accessible via API management process.
""")
  hostNamesDisabled?: boolean;

  @doc("Unique identifier that verifies the custom domains assigned to the app. Customer will add this id to a txt record for verification.")
  customDomainVerificationId?: string;

  @doc("List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from tenants that site can be hosted with current settings. Read-only.")
  @visibility("read")
  outboundIpAddresses?: string;

  @doc("List of IP addresses that the app uses for outbound connections (e.g. database access). Includes VIPs from all tenants except dataComponent. Read-only.")
  @visibility("read")
  possibleOutboundIpAddresses?: string;

  @doc("Size of the function container.")
  containerSize?: int32;

  @doc("Maximum allowed daily memory-time quota (applicable on dynamic apps only).")
  dailyMemoryTimeQuota?: int32;

  @doc("App suspended till in case memory-time quota is exceeded.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspendedTill?: utcDateTime;

  @doc("""
Maximum number of workers.
This only applies to Functions container.
""")
  @visibility("read")
  maxNumberOfWorkers?: int32;

  @doc("If specified during app creation, the app is cloned from a source app.")
  @visibility("create")
  cloningInfo?: CloningInfo;

  @doc("Name of the resource group the app belongs to. Read-only.")
  @visibility("read")
  resourceGroup?: string;

  @doc("<code>true</code> if the app is a default container; otherwise, <code>false</code>.")
  @visibility("read")
  isDefaultContainer?: boolean;

  @doc("Default hostname of the app. Read-only.")
  @visibility("read")
  defaultHostName?: string;

  @doc("Status of the last deployment slot swap operation.")
  @visibility("read")
  slotSwapStatus?: SlotSwapStatus;

  @doc("""
HttpsOnly: configures a web site to accept only https requests. Issues redirect for
http requests
""")
  httpsOnly?: boolean;

  @doc("Site redundancy mode")
  redundancyMode?: RedundancyMode;

  @doc("Specifies an operation id if this site has a pending operation.")
  @visibility("read")
  inProgressOperationId?: string;

  @doc("Checks if Customer provided storage account is required")
  storageAccountRequired?: boolean;

  @doc("Identity to use for Key Vault Reference authentication.")
  keyVaultReferenceIdentity?: string;

  @doc("""
Azure Resource Manager ID of the Virtual network and subnet to be joined by Regional VNET Integration.
This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}
""")
  virtualNetworkSubnetId?: string;
}

@doc("SSL-enabled hostname.")
model HostNameSslState {
  @doc("Hostname.")
  name?: string;

  @doc("SSL type.")
  sslState?: SslState;

  @doc("Virtual IP address assigned to the hostname if IP based SSL is enabled.")
  virtualIP?: string;

  @doc("SSL certificate thumbprint.")
  thumbprint?: string;

  @doc("Set to <code>true</code> to update existing hostname.")
  toUpdate?: boolean;

  @doc("Indicates whether the hostname is a standard or repository hostname.")
  hostType?: HostType;
}

@doc("Configuration of an App Service app.")
model SiteConfigProperties {
  @doc("Number of workers.")
  numberOfWorkers?: int32;

  @doc("Default documents.")
  defaultDocuments?: string[];

  @doc(".NET Framework version.")
  netFrameworkVersion?: string;

  @doc("Version of PHP.")
  phpVersion?: string;

  @doc("Version of Python.")
  pythonVersion?: string;

  @doc("Version of Node.js.")
  nodeVersion?: string;

  @doc("Version of PowerShell.")
  powerShellVersion?: string;

  @doc("Linux App Framework and version")
  linuxFxVersion?: string;

  @doc("Xenon App Framework and version")
  windowsFxVersion?: string;

  @doc("<code>true</code> if request tracing is enabled; otherwise, <code>false</code>.")
  requestTracingEnabled?: boolean;

  @doc("Request tracing expiration time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestTracingExpirationTime?: utcDateTime;

  @doc("<code>true</code> if remote debugging is enabled; otherwise, <code>false</code>.")
  remoteDebuggingEnabled?: boolean;

  @doc("Remote debugging version.")
  remoteDebuggingVersion?: string;

  @doc("<code>true</code> if HTTP logging is enabled; otherwise, <code>false</code>.")
  httpLoggingEnabled?: boolean;

  @doc("Flag to use Managed Identity Creds for ACR pull")
  acrUseManagedIdentityCreds?: boolean;

  @doc("If using user managed identity, the user managed identity ClientId")
  acrUserManagedIdentityID?: string;

  @doc("HTTP logs directory size limit.")
  logsDirectorySizeLimit?: int32;

  @doc("<code>true</code> if detailed error logging is enabled; otherwise, <code>false</code>.")
  detailedErrorLoggingEnabled?: boolean;

  @doc("Publishing user name.")
  publishingUsername?: string;

  @doc("Application settings.")
  appSettings?: NameValuePair[];

  @doc("Connection strings.")
  connectionStrings?: ConnStringInfo[];

  @doc("Site MachineKey.")
  @visibility("read")
  machineKey?: SiteMachineKey;

  @doc("Handler mappings.")
  handlerMappings?: HandlerMapping[];

  @doc("Document root.")
  documentRoot?: string;

  @doc("SCM type.")
  scmType?: ScmType;

  @doc("<code>true</code> to use 32-bit worker process; otherwise, <code>false</code>.")
  use32BitWorkerProcess?: boolean;

  @doc("<code>true</code> if WebSocket is enabled; otherwise, <code>false</code>.")
  webSocketsEnabled?: boolean;

  @doc("<code>true</code> if Always On is enabled; otherwise, <code>false</code>.")
  alwaysOn?: boolean;

  @doc("Java version.")
  javaVersion?: string;

  @doc("Java container.")
  javaContainer?: string;

  @doc("Java container version.")
  javaContainerVersion?: string;

  @doc("App command line to launch.")
  appCommandLine?: string;

  @doc("Managed pipeline mode.")
  managedPipelineMode?: ManagedPipelineMode;

  @doc("Virtual applications.")
  virtualApplications?: VirtualApplication[];

  @doc("Site load balancing.")
  loadBalancing?: SiteLoadBalancing;

  @doc("This is work around for polymorphic types.")
  experiments?: Experiments;

  @doc("Site limits.")
  limits?: SiteLimits;

  @doc("<code>true</code> if Auto Heal is enabled; otherwise, <code>false</code>.")
  autoHealEnabled?: boolean;

  @doc("Auto Heal rules.")
  autoHealRules?: AutoHealRules;

  @doc("Tracing options.")
  tracingOptions?: string;

  @doc("Virtual Network name.")
  @visibility("read", "create")
  vnetName?: string;

  @doc("Virtual Network Route All enabled. This causes all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied.")
  vnetRouteAllEnabled?: boolean;

  @doc("The number of private ports assigned to this app. These will be assigned dynamically on runtime.")
  vnetPrivatePortsCount?: int32;

  @doc("Cross-Origin Resource Sharing (CORS) settings.")
  cors?: CorsSettings;

  @doc("Push endpoint settings.")
  push?: PushSettings;

  @doc("Information about the formal API definition for the app.")
  apiDefinition?: ApiDefinitionInfo;

  @doc("Azure API management settings linked to the app.")
  apiManagementConfig?: ApiManagementConfig;

  @doc("Auto-swap slot name.")
  autoSwapSlotName?: string;

  @doc("<code>true</code> to enable local MySQL; otherwise, <code>false</code>.")
  localMySqlEnabled?: boolean;

  @doc("Managed Service Identity Id")
  managedServiceIdentityId?: int32;

  @doc("Explicit Managed Service Identity Id")
  xManagedServiceIdentityId?: int32;

  @doc("Identity to use for Key Vault Reference authentication.")
  keyVaultReferenceIdentity?: string;

  @doc("IP security restrictions for main.")
  ipSecurityRestrictions?: IpSecurityRestriction[];

  @doc("IP security restrictions for scm.")
  scmIpSecurityRestrictions?: IpSecurityRestriction[];

  @doc("IP security restrictions for scm to use main.")
  scmIpSecurityRestrictionsUseMain?: boolean;

  @doc("Http20Enabled: configures a web site to allow clients to connect over http2.0")
  http20Enabled?: boolean;

  @doc("MinTlsVersion: configures the minimum version of TLS required for SSL requests")
  minTlsVersion?: SupportedTlsVersions;

  @doc("ScmMinTlsVersion: configures the minimum version of TLS required for SSL requests for SCM site")
  scmMinTlsVersion?: SupportedTlsVersions;

  @doc("State of FTP / FTPS service")
  ftpsState?: FtpsState;

  @doc("""
Number of preWarmed instances.
This setting only applies to the Consumption and Elastic Plans
""")
  @maxValue(10)
  preWarmedInstanceCount?: int32;

  @doc("""
Maximum number of workers that a site can scale out to.
This setting only applies to the Consumption and Elastic Premium Plans
""")
  functionAppScaleLimit?: int32;

  @doc("Health check path")
  healthCheckPath?: string;

  @doc("""
Gets or sets a value indicating whether functions runtime scale monitoring is enabled. When enabled,
the ScaleController will not monitor event sources directly, but will instead call to the
runtime to get scale status.
""")
  functionsRuntimeScaleMonitoringEnabled?: boolean;

  @doc("Sets the time zone a site uses for generating timestamps. Compatible with Linux and Windows App Service. Setting the WEBSITE_TIME_ZONE app setting takes precedence over this config. For Linux, expects tz database values https://www.iana.org/time-zones (for a quick reference see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). For Windows, expects one of the time zones listed under HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Time Zones")
  websiteTimeZone?: string;

  @doc("""
Number of minimum instance count for a site
This setting only applies to the Elastic Plans
""")
  @maxValue(20)
  minimumElasticInstanceCount?: int32;

  @doc("List of Azure Storage Accounts.")
  azureStorageAccounts?: Record<AzureStorageInfoValue>;

  @doc("Property to allow or block all public traffic.")
  publicNetworkAccess?: string;
}

@doc("Database connection string information.")
model ConnStringInfo {
  @doc("Name of connection string.")
  name?: string;

  @doc("Connection string value.")
  connectionString?: string;

  @doc("Type of database.")
  type?: ConnectionStringType;
}

@doc("MachineKey of an app.")
model SiteMachineKey {
  @doc("MachineKey validation.")
  validation?: string;

  @doc("Validation key.")
  validationKey?: string;

  @doc("Algorithm used for decryption.")
  decryption?: string;

  @doc("Decryption key.")
  decryptionKey?: string;
}

@doc("""
The IIS handler mappings used to define which handler processes HTTP requests with certain extension. 
For example, it is used to configure php-cgi.exe process to handle all HTTP requests with *.php extension.
""")
model HandlerMapping {
  @doc("Requests with this extension will be handled using the specified FastCGI application.")
  extension?: string;

  @doc("The absolute path to the FastCGI application.")
  scriptProcessor?: string;

  @doc("Command-line arguments to be passed to the script processor.")
  arguments?: string;
}

@doc("Virtual application in an app.")
model VirtualApplication {
  @doc("Virtual path.")
  virtualPath?: string;

  @doc("Physical path.")
  physicalPath?: string;

  @doc("<code>true</code> if preloading is enabled; otherwise, <code>false</code>.")
  preloadEnabled?: boolean;

  @doc("Virtual directories for virtual application.")
  virtualDirectories?: VirtualDirectory[];
}

@doc("Directory for virtual application.")
model VirtualDirectory {
  @doc("Path to virtual application.")
  virtualPath?: string;

  @doc("Physical path.")
  physicalPath?: string;
}

@doc("Routing rules in production experiments.")
model Experiments {
  @doc("List of ramp-up rules.")
  rampUpRules?: RampUpRule[];
}

@doc("Routing rules for ramp up testing. This rule allows to redirect static traffic % to a slot or to gradually change routing % based on performance.")
model RampUpRule {
  @doc("Hostname of a slot to which the traffic will be redirected if decided to. E.g. myapp-stage.azurewebsites.net.")
  actionHostName?: string;

  @doc("Percentage of the traffic which will be redirected to <code>ActionHostName</code>.")
  reroutePercentage?: float32;

  @doc("""
In auto ramp up scenario this is the step to add/remove from <code>ReroutePercentage</code> until it reaches \\n<code>MinReroutePercentage</code> or 
<code>MaxReroutePercentage</code>. Site metrics are checked every N minutes specified in <code>ChangeIntervalInMinutes</code>.\\nCustom decision algorithm 
can be provided in TiPCallback site extension which URL can be specified in <code>ChangeDecisionCallbackUrl</code>.
""")
  changeStep?: float32;

  @doc("Specifies interval in minutes to reevaluate ReroutePercentage.")
  changeIntervalInMinutes?: int32;

  @doc("Specifies lower boundary above which ReroutePercentage will stay.")
  minReroutePercentage?: float32;

  @doc("Specifies upper boundary below which ReroutePercentage will stay.")
  maxReroutePercentage?: float32;

  @doc("""
Custom decision algorithm can be provided in TiPCallback site extension which URL can be specified. See TiPCallback site extension for the scaffold and contracts.
https://www.siteextensions.net/packages/TiPCallback/
""")
  changeDecisionCallbackUrl?: string;

  @doc("Name of the routing rule. The recommended name would be to point to the slot which will receive the traffic in the experiment.")
  name?: string;
}

@doc("Metric limits set on an app.")
model SiteLimits {
  @doc("Maximum allowed CPU usage percentage.")
  maxPercentageCpu?: float32;

  @doc("Maximum allowed memory usage in MB.")
  maxMemoryInMb?: int32;

  @doc("Maximum allowed disk size usage in MB.")
  maxDiskSizeInMb?: int32;
}

@doc("Rules that can be defined for auto-heal.")
model AutoHealRules {
  @doc("Conditions that describe when to execute the auto-heal actions.")
  triggers?: AutoHealTriggers;

  @doc("Actions to be executed when a rule is triggered.")
  actions?: AutoHealActions;
}

@doc("Triggers for auto-heal.")
model AutoHealTriggers {
  @doc("A rule based on total requests.")
  requests?: RequestsBasedTrigger;

  @doc("A rule based on private bytes.")
  privateBytesInKB?: int32;

  @doc("A rule based on status codes.")
  statusCodes?: StatusCodesBasedTrigger[];

  @doc("A rule based on request execution time.")
  slowRequests?: SlowRequestsBasedTrigger;

  @doc("A rule based on multiple Slow Requests Rule with path")
  slowRequestsWithPath?: SlowRequestsBasedTrigger[];

  @doc("A rule based on status codes ranges.")
  statusCodesRange?: StatusCodesRangeBasedTrigger[];
}

@doc("Trigger based on total requests.")
model RequestsBasedTrigger {
  @doc("Request Count.")
  count?: int32;

  @doc("Time interval.")
  timeInterval?: string;
}

@doc("Trigger based on status code.")
model StatusCodesBasedTrigger {
  @doc("HTTP status code.")
  status?: int32;

  @doc("Request Sub Status.")
  subStatus?: int32;

  @doc("Win32 error code.")
  win32Status?: int32;

  @doc("Request Count.")
  count?: int32;

  @doc("Time interval.")
  timeInterval?: string;

  @doc("Request Path")
  path?: string;
}

@doc("Trigger based on request execution time.")
model SlowRequestsBasedTrigger {
  @doc("Time taken.")
  timeTaken?: string;

  @doc("Request Path.")
  path?: string;

  @doc("Request Count.")
  count?: int32;

  @doc("Time interval.")
  timeInterval?: string;
}

@doc("Trigger based on range of status codes.")
model StatusCodesRangeBasedTrigger {
  @doc("HTTP status code.")
  statusCodes?: string;

  path?: string;

  @doc("Request Count.")
  count?: int32;

  @doc("Time interval.")
  timeInterval?: string;
}

@doc("Actions which to take by the auto-heal module when a rule is triggered.")
model AutoHealActions {
  @doc("Predefined action to be taken.")
  actionType?: AutoHealActionType;

  @doc("Custom action to be taken.")
  customAction?: AutoHealCustomAction;

  @doc("""
Minimum time the process must execute
before taking the action
""")
  minProcessExecutionTime?: string;
}

@doc("""
Custom action to be executed
when an auto heal rule is triggered.
""")
model AutoHealCustomAction {
  @doc("Executable to be run.")
  exe?: string;

  @doc("Parameters for the executable.")
  parameters?: string;
}

@doc("Cross-Origin Resource Sharing (CORS) settings for the app.")
model CorsSettings {
  @doc("""
Gets or sets the list of origins that should be allowed to make cross-origin
calls (for example: http://example.com:12345). Use \"*\" to allow all.
""")
  allowedOrigins?: string[];

  @doc("""
Gets or sets whether CORS requests with credentials are allowed. See 
https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS#Requests_with_credentials
for more details.
""")
  supportCredentials?: boolean;
}

@doc("Push settings for the App.")
model PushSettings {
  ...ProxyOnlyResource;

  @doc("PushSettings resource specific properties")
  properties?: PushSettingsProperties;
}

@doc("PushSettings resource specific properties")
model PushSettingsProperties {
  @doc("Gets or sets a flag indicating whether the Push endpoint is enabled.")
  isPushEnabled: boolean;

  @doc("Gets or sets a JSON string containing a list of tags that are whitelisted for use by the push registration endpoint.")
  tagWhitelistJson?: string;

  @doc("""
Gets or sets a JSON string containing a list of tags that require user authentication to be used in the push registration endpoint.
Tags can consist of alphanumeric characters and the following:
'_', '@', '#', '.', ':', '-'. 
Validation should be performed at the PushRequestHandler.
""")
  tagsRequiringAuth?: string;

  @doc("Gets or sets a JSON string containing a list of dynamic tags that will be evaluated from user claims in the push registration endpoint.")
  dynamicTagsJson?: string;
}

@doc("Information about the formal API definition for the app.")
model ApiDefinitionInfo {
  @doc("The URL of the API definition.")
  url?: string;
}

@doc("Azure API management (APIM) configuration linked to the app.")
model ApiManagementConfig {
  @doc("APIM-Api Identifier.")
  id?: string;
}

@doc("IP security restriction on an app.")
model IpSecurityRestriction {
  @doc("""
IP address the security restriction is valid for.
It can be in form of pure ipv4 address (required SubnetMask property) or
CIDR notation such as ipv4/mask (leading bit match). For CIDR,
SubnetMask property must not be specified.
""")
  ipAddress?: string;

  @doc("Subnet mask for the range of IP addresses the restriction is valid for.")
  subnetMask?: string;

  @doc("Virtual network resource id")
  vnetSubnetResourceId?: string;

  @doc("(internal) Vnet traffic tag")
  vnetTrafficTag?: int32;

  @doc("(internal) Subnet traffic tag")
  subnetTrafficTag?: int32;

  @doc("Allow or Deny access for this IP range.")
  action?: string;

  @doc("Defines what this IP filter will be used for. This is to support IP filtering on proxies.")
  tag?: IpFilterTag;

  @doc("Priority of IP restriction rule.")
  priority?: int32;

  @doc("IP restriction rule name.")
  name?: string;

  @doc("IP restriction rule description.")
  description?: string;

  @doc("""
IP restriction rule headers.
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
""")
  headers?: Record<string[]>;
}

@doc("Azure Files or Blob Storage access information value for dictionary storage.")
model AzureStorageInfoValue {
  @doc("Type of storage.")
  type?: AzureStorageType;

  @doc("Name of the storage account.")
  accountName?: string;

  @doc("Name of the file share (container name, for Blob storage).")
  shareName?: string;

  @doc("Access key for the storage account.")
  accessKey?: string;

  @doc("Path to mount the storage within the site's runtime environment.")
  mountPath?: string;

  @doc("State of the storage account.")
  @visibility("read")
  state?: AzureStorageState;
}

@doc("Information needed for cloning operation.")
model CloningInfo {
  @doc("""
Correlation ID of cloning operation. This ID ties multiple cloning operations
together to use the same snapshot.
""")
  correlationId?: string;

  @doc("<code>true</code> to overwrite destination app; otherwise, <code>false</code>.")
  overwrite?: boolean;

  @doc("<code>true</code> to clone custom hostnames from source app; otherwise, <code>false</code>.")
  cloneCustomHostNames?: boolean;

  @doc("<code>true</code> to clone source control from source app; otherwise, <code>false</code>.")
  cloneSourceControl?: boolean;

  @doc("""
ARM resource ID of the source app. App resource ID is of the form 
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName} for production slots and 
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slotName} for other slots.
""")
  sourceWebAppId: string;

  @doc("Location of source app ex: West US or North Europe")
  sourceWebAppLocation?: string;

  @doc("App Service Environment.")
  hostingEnvironment?: string;

  @doc("""
Application setting overrides for cloned app. If specified, these settings override the settings cloned 
from source app. Otherwise, application settings from source app are retained.
""")
  appSettingsOverrides?: Record<string>;

  @doc("<code>true</code> to configure load balancing for source and destination app.")
  configureLoadBalancing?: boolean;

  @doc("""
ARM resource ID of the Traffic Manager profile to use, if it exists. Traffic Manager resource ID is of the form 
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficManagerProfiles/{profileName}.
""")
  trafficManagerProfileId?: string;

  @doc("Name of Traffic Manager profile to create. This is only needed if Traffic Manager profile does not already exist.")
  trafficManagerProfileName?: string;
}

@doc("The status of the last successful slot swap operation.")
model SlotSwapStatus {
  @doc("The time the last successful slot swap completed.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestampUtc?: utcDateTime;

  @doc("The source slot of the last swap operation.")
  @visibility("read")
  sourceSlotName?: string;

  @doc("The destination slot of the last swap operation.")
  @visibility("read")
  destinationSlotName?: string;
}

@doc("User Assigned identity.")
model UserAssignedIdentity {
  @doc("Principal Id of user assigned identity")
  @visibility("read")
  principalId?: string;

  @doc("Client Id of user assigned identity")
  @visibility("read")
  clientId?: string;
}

@doc("Collection of CSM usage quotas.")
model CsmUsageQuotaCollection is Azure.Core.Page<CsmUsageQuota>;

@doc("Usage of the quota resource.")
model CsmUsageQuota {
  @doc("Units of measurement for the quota resource.")
  unit?: string;

  @doc("Next reset time for the resource counter.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  @doc("The current value of the resource counter.")
  currentValue?: int32;

  @doc("The resource limit.")
  limit?: int32;

  @doc("Quota name.")
  name?: LocalizableString;
}

@doc("Localizable string object containing the name and a localized value.")
model LocalizableString {
  @doc("Non-localized name.")
  value?: string;

  @doc("Localized name.")
  localizedValue?: string;
}

@doc("HybridConnection resource specific properties")
model HybridConnectionProperties {
  @doc("The name of the Service Bus namespace.")
  @visibility("read", "create")
  serviceBusNamespace?: string;

  @doc("The name of the Service Bus relay.")
  @visibility("read", "create")
  relayName?: string;

  @doc("The ARM URI to the Service Bus relay.")
  relayArmUri?: string;

  @doc("The hostname of the endpoint.")
  hostname?: string;

  @doc("The port of the endpoint.")
  port?: int32;

  @doc("The name of the Service Bus key which has Send permissions. This is used to authenticate to Service Bus.")
  sendKeyName?: string;

  @doc("""
The value of the Service Bus key. This is used to authenticate to Service Bus. In ARM this key will not be returned
normally, use the POST /listKeys API instead.
""")
  sendKeyValue?: string;

  @doc("The suffix for the service bus endpoint. By default this is .servicebus.windows.net")
  serviceBusSuffix?: string;
}

@doc("Hybrid Connection key contract. This has the send key name and value for a Hybrid Connection.")
model HybridConnectionKey {
  ...ProxyOnlyResource;

  @doc("HybridConnectionKey resource specific properties")
  properties?: HybridConnectionKeyProperties;
}

@doc("HybridConnectionKey resource specific properties")
model HybridConnectionKeyProperties {
  @doc("The name of the send key.")
  @visibility("read")
  sendKeyName?: string;

  @doc("The value of the send key.")
  @visibility("read")
  sendKeyValue?: string;
}

@doc("Collection of resources.")
model ResourceCollection is Azure.Core.Page<string>;

@doc("HybridConnectionLimits resource specific properties")
model HybridConnectionLimitsProperties {
  @doc("The current number of Hybrid Connections.")
  @visibility("read")
  current?: int32;

  @doc("The maximum number of Hybrid Connections allowed.")
  @visibility("read")
  maximum?: int32;
}

@doc("Collection of hostname bindings.")
model HybridConnectionCollection is Azure.Core.Page<HybridConnection>;

@doc("Virtual Network information contract.")
model VnetInfo {
  @doc("The Virtual Network's resource ID.")
  vnetResourceId?: string;

  @doc("The client certificate thumbprint.")
  @visibility("read")
  certThumbprint?: string;

  @doc("""
A certificate file (.cer) blob containing the public key of the private key used to authenticate a 
Point-To-Site VPN connection.
""")
  certBlob?: string;

  @doc("The routes that this Virtual Network connection uses.")
  @visibility("read")
  routes?: VnetRoute[];

  @doc("<code>true</code> if a resync is required; otherwise, <code>false</code>.")
  @visibility("read")
  resyncRequired?: boolean;

  @doc("DNS servers to be used by this Virtual Network. This should be a comma-separated list of IP addresses.")
  dnsServers?: string;

  @doc("Flag that is used to denote if this is VNET injection")
  isSwift?: boolean;
}

@doc("Virtual Network route contract used to pass routing information for a Virtual Network.")
model VnetRoute {
  ...ProxyOnlyResource;

  @doc("VnetRoute resource specific properties")
  properties?: VnetRouteProperties;
}

@doc("VnetRoute resource specific properties")
model VnetRouteProperties {
  @doc("The starting address for this route. This may also include a CIDR notation, in which case the end address must not be specified.")
  startAddress?: string;

  @doc("The ending address for this route. If the start address is specified in CIDR notation, this must be omitted.")
  endAddress?: string;

  @doc("""
The type of route this is:
DEFAULT - By default, every app has routes to the local address ranges specified by RFC1918
INHERITED - Routes inherited from the real Virtual Network routes
STATIC - Static route set on the app only

These values will be used for syncing an app's routes with those from a Virtual Network.
""")
  routeType?: RouteType;
}

@doc("VnetGateway resource specific properties")
model VnetGatewayProperties {
  @doc("The Virtual Network name.")
  @visibility("read", "create")
  vnetName?: string;

  @doc("The URI where the VPN package can be downloaded.")
  @visibility("create", "update")
  vpnPackageUri: string;
}

@doc("Certificate resource specific properties")
model CertificateProperties {
  @doc("Certificate password.")
  @visibility("create")
  password?: string;

  @doc("Friendly name of the certificate.")
  @visibility("read")
  friendlyName?: string;

  @doc("Subject name of the certificate.")
  @visibility("read")
  subjectName?: string;

  @doc("Host names the certificate applies to.")
  hostNames?: string[];

  @doc("Pfx blob.")
  pfxBlob?: bytes;

  @doc("App name.")
  @visibility("read")
  siteName?: string;

  @doc("Self link.")
  @visibility("read")
  selfLink?: string;

  @doc("Certificate issuer.")
  @visibility("read")
  issuer?: string;

  @doc("Certificate issue Date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueDate?: utcDateTime;

  @doc("Certificate expiration date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Certificate thumbprint.")
  @visibility("read")
  thumbprint?: string;

  @doc("Is the certificate valid?.")
  @visibility("read")
  valid?: boolean;

  @doc("Raw bytes of .cer file")
  @visibility("read")
  cerBlob?: bytes;

  @doc("Public key hash.")
  @visibility("read")
  publicKeyHash?: string;

  @doc("Specification for the App Service Environment to use for the certificate.")
  @visibility("read")
  hostingEnvironmentProfile?: HostingEnvironmentProfile;

  @doc("Key Vault Csm resource Id.")
  keyVaultId?: string;

  @doc("Key Vault secret name.")
  keyVaultSecretName?: string;

  @doc("Status of the Key Vault secret.")
  @visibility("read")
  keyVaultSecretStatus?: KeyVaultSecretStatus;

  @doc("Resource ID of the associated App Service plan, formatted as: \"/subscriptions/{subscriptionID}/resourceGroups/{groupName}/providers/Microsoft.Web/serverfarms/{appServicePlanName}\".")
  serverFarmId?: string;

  @doc("CNAME of the certificate to be issued via free certificate")
  canonicalName?: string;

  @doc("Method of domain validation for free cert")
  domainValidationMethod?: string;
}

@doc("DeletedSite resource specific properties")
model DeletedSiteProperties {
  @doc("Numeric id for the deleted site")
  @visibility("read")
  deletedSiteId?: int32;

  @doc("Time in UTC when the app was deleted.")
  @visibility("read")
  deletedTimestamp?: string;

  @doc("Subscription containing the deleted site")
  @visibility("read")
  subscription?: string;

  @doc("ResourceGroup that contained the deleted site")
  @visibility("read")
  resourceGroup?: string;

  @doc("Name of the deleted site")
  @visibility("read")
  deletedSiteName?: string;

  @doc("Slot of the deleted site")
  @visibility("read")
  slot?: string;

  @doc("Kind of site that was deleted")
  @visibility("read")
  kind?: string;

  @doc("Geo Region of the deleted site")
  @visibility("read")
  geoRegionName?: string;
}

@doc("DiagnosticCategory resource specific properties")
model DiagnosticCategoryProperties {
  @doc("Description of the diagnostic category")
  @visibility("read")
  description?: string;
}

@doc("AnalysisDefinition resource specific properties")
model AnalysisDefinitionProperties {
  @doc("Description of the Analysis")
  @visibility("read")
  description?: string;
}

@doc("Class representing a diagnostic analysis done on an application")
model DiagnosticAnalysis {
  ...ProxyOnlyResource;

  @doc("DiagnosticAnalysis resource specific properties")
  properties?: DiagnosticAnalysisProperties;
}

@doc("DiagnosticAnalysis resource specific properties")
model DiagnosticAnalysisProperties {
  @doc("Start time of the period")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the period")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("List of time periods.")
  abnormalTimePeriods?: AbnormalTimePeriod[];

  @doc("Data by each detector")
  payload?: AnalysisData[];

  @doc("Data by each detector for detectors that did not corelate")
  nonCorrelatedDetectors?: DetectorDefinition[];
}

@doc("Class representing Abnormal Time Period identified in diagnosis")
model AbnormalTimePeriod {
  @doc("Start time of the downtime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the downtime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("List of Possible Cause of downtime")
  events?: DetectorAbnormalTimePeriod[];

  @doc("List of proposed solutions")
  solutions?: Solution[];
}

@doc("Class representing Abnormal Time Period detected.")
model DetectorAbnormalTimePeriod {
  @doc("Start time of the correlated event")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the correlated event")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Message describing the event")
  message?: string;

  @doc("Represents the name of the Detector")
  source?: string;

  @doc("Represents the rank of the Detector")
  priority?: float32;

  @doc("Downtime metadata")
  metaData?: NameValuePair[][];

  @doc("Represents the type of the Detector")
  type?: IssueType;

  @doc("List of proposed solutions")
  solutions?: Solution[];
}

@doc("Class Representing Solution for problems detected.")
model Solution {
  @doc("Solution Id.")
  id?: float32;

  @doc("Display Name of the solution")
  displayName?: string;

  @doc("Order of the solution.")
  order?: float32;

  @doc("Description of the solution")
  description?: string;

  @doc("Type of Solution")
  type?: SolutionType;

  @doc("Solution Data.")
  data?: NameValuePair[][];

  @doc("Solution Metadata.")
  metadata?: NameValuePair[][];
}

@doc("Class Representing Detector Evidence used for analysis")
model AnalysisData {
  @doc("Name of the Detector")
  source?: string;

  @doc("Detector Definition")
  detectorDefinition?: DetectorDefinition;

  @doc("Source Metrics")
  metrics?: DiagnosticMetricSet[];

  @doc("Additional Source Data")
  data?: NameValuePair[][];

  @doc("Detector Meta Data")
  detectorMetaData?: ResponseMetaData;
}

@doc("Class representing detector definition")
model DetectorDefinition {
  @doc("Display name of the detector")
  @visibility("read")
  displayName?: string;

  @doc("Description of the detector")
  @visibility("read")
  description?: string;

  @doc("Detector Rank")
  @visibility("read")
  rank?: float32;

  @doc("Flag representing whether detector is enabled or not.")
  @visibility("read")
  isEnabled?: boolean;
}

@doc("Class representing Diagnostic Metric information")
model DiagnosticMetricSet {
  @doc("Name of the metric")
  name?: string;

  @doc("Metric's unit")
  unit?: string;

  @doc("Start time of the period")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the period")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Presented time grain. Supported grains at the moment are PT1M, PT1H, P1D")
  timeGrain?: string;

  @doc("Collection of metric values for the selected period based on the {Microsoft.Web.Hosting.Administration.DiagnosticMetricSet.TimeGrain}")
  values?: DiagnosticMetricSample[];
}

@doc("Class representing Diagnostic Metric")
model DiagnosticMetricSample {
  @doc("Time at which metric is measured")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("""
Role Instance. Null if this counter is not per instance 
This is returned and should be whichever instance name we desire to be returned
i.e. CPU and Memory return RDWORKERNAME (LargeDed..._IN_0) 
where RDWORKERNAME is Machine name below and RoleInstance name in parenthesis
""")
  roleInstance?: string;

  @doc("Total value of the metric. If multiple measurements are made this will have sum of all.")
  total?: float32;

  @doc("Maximum of the metric sampled during the time period")
  maximum?: float32;

  @doc("Minimum of the metric sampled during the time period")
  minimum?: float32;

  @doc("Whether the values are aggregates across all workers or not")
  isAggregated?: boolean;
}

model ResponseMetaData {
  @doc("Source of the Data")
  dataSource?: DataSource;
}

@doc("Class representing data source used by the detectors")
model DataSource {
  @doc("Instructions if any for the data source")
  instructions?: string[];

  @doc("Datasource Uri Links")
  dataSourceUri?: NameValuePair[];
}

@doc("Class representing Response from Diagnostic Detectors")
model DiagnosticDetectorResponse {
  ...ProxyOnlyResource;

  @doc("DiagnosticDetectorResponse resource specific properties")
  properties?: DiagnosticDetectorResponseProperties;
}

@doc("DiagnosticDetectorResponse resource specific properties")
model DiagnosticDetectorResponseProperties {
  @doc("Start time of the period")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the period")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Flag representing Issue was detected.")
  issueDetected?: boolean;

  @doc("Detector's definition")
  detectorDefinition?: DetectorDefinition;

  @doc("Metrics provided by the detector")
  metrics?: DiagnosticMetricSet[];

  @doc("List of Correlated events found by the detector")
  abnormalTimePeriods?: DetectorAbnormalTimePeriod[];

  @doc("Additional Data that detector wants to send.")
  data?: NameValuePair[][];

  @doc("Meta Data")
  responseMetaData?: ResponseMetaData;
}

@doc("A snapshot of an app.")
model Snapshot {
  ...ProxyOnlyResource;

  @doc("Snapshot resource specific properties")
  properties?: SnapshotProperties;
}

@doc("Snapshot resource specific properties")
model SnapshotProperties {
  @doc("The time the snapshot was taken.")
  @visibility("read")
  time?: string;
}

@doc("KubeEnvironment resource specific properties")
model KubeEnvironmentProperties {
  @doc("Provisioning state of the Kubernetes Environment.")
  @visibility("read")
  provisioningState?: KubeEnvironmentProvisioningState;

  @doc("Any errors that occurred during deployment or deployment validation")
  @visibility("read")
  deploymentErrors?: string;

  @doc("Only visible within Vnet/Subnet")
  @visibility("read", "create")
  internalLoadBalancerEnabled?: boolean;

  @doc("Default Domain Name for the cluster")
  @visibility("read")
  defaultDomain?: string;

  @doc("Static IP of the KubeEnvironment")
  @visibility("read", "create")
  staticIp?: string;

  @doc("""
Cluster configuration which determines the ARC cluster
components types. Eg: Choosing between BuildService kind,
FrontEnd Service ArtifactsStorageType etc.
""")
  arcConfiguration?: ArcConfiguration;

  @doc("""
Cluster configuration which enables the log daemon to export
app logs to a destination. Currently only \"log-analytics\" is
supported
""")
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

@doc("Collection of Application Stacks")
model ApplicationStackCollection is Azure.Core.Page<ApplicationStackResource>;

@doc("ARM resource for a ApplicationStack.")
model ApplicationStackResource {
  ...ProxyOnlyResource;

  @doc("Core resource properties")
  properties?: ApplicationStack;
}

@doc("Application stack.")
model ApplicationStack {
  @doc("Application stack name.")
  name?: string;

  @doc("Application stack display name.")
  display?: string;

  @doc("Application stack dependency.")
  dependency?: string;

  @doc("List of major versions available.")
  majorVersions?: StackMajorVersion[];

  @doc("List of frameworks associated with application stack.")
  frameworks?: ApplicationStack[];

  @doc("<code>true</code> if this is the stack is deprecated; otherwise, <code>false</code>.")
  isDeprecated?: ApplicationStack[];
}

@doc("Application stack major version.")
model StackMajorVersion {
  @doc("Application stack major version (display only).")
  displayVersion?: string;

  @doc("Application stack major version (runtime only).")
  runtimeVersion?: string;

  @doc("<code>true</code> if this is the default major version; otherwise, <code>false</code>.")
  isDefault?: boolean;

  @doc("Minor versions associated with the major version.")
  minorVersions?: StackMinorVersion[];

  @doc("<code>true</code> if this supports Application Insights; otherwise, <code>false</code>.")
  applicationInsights?: boolean;

  @doc("<code>true</code> if this stack is in Preview, otherwise <code>false</code>.")
  isPreview?: boolean;

  @doc("<code>true</code> if this stack has been deprecated, otherwise <code>false</code>.")
  isDeprecated?: boolean;

  @doc("<code>true</code> if this stack should be hidden for new customers on portal, otherwise <code>false</code>.")
  isHidden?: boolean;

  @doc("""
<appSettings>
 <appSetting name=\"FUNCTIONS_WORKER_RUNTIME\" value=\"dotnet\" />
</appSettings>
 Example: All the function apps need AppSetting: \"FUNCTIONS_WORKER_RUNTIME\" to be set stack name
""")
  appSettingsDictionary?: Record<Record<unknown>>;

  @doc("""
<siteConfigProperties>
 <siteConfigProperty name=\"Use32BitWorkerProcess\" value=\"false\" />
</siteConfigProperties>
 Example: All Linux Function Apps, need Use32BitWorkerProcess to be set to 0
""")
  siteConfigPropertiesDictionary?: Record<Record<unknown>>;
}

@doc("Application stack minor version.")
model StackMinorVersion {
  @doc("Application stack minor version (display only).")
  displayVersion?: string;

  @doc("Application stack minor version (runtime only).")
  runtimeVersion?: string;

  @doc("<code>true</code> if this is the default minor version; otherwise, <code>false</code>.")
  isDefault?: boolean;

  @doc("<code>true</code> if this supports Remote Debugging, otherwise <code>false</code>.")
  isRemoteDebuggingEnabled?: boolean;
}

@doc("Collection of Function app Stacks")
model FunctionAppStackCollection is Azure.Core.Page<FunctionAppStack>;

@doc("Function App Stack.")
model FunctionAppStack {
  ...ProxyOnlyResource;

  @doc("Function App stack location.")
  @visibility("read")
  location?: string;

  @doc("FunctionAppStack resource specific properties")
  properties?: FunctionAppStackProperties;
}

@doc("FunctionAppStack resource specific properties")
model FunctionAppStackProperties {
  @doc("Function App stack (display only).")
  @visibility("read")
  displayText?: string;

  @doc("Function App stack name.")
  @visibility("read")
  value?: string;

  @doc("List of major versions available.")
  @visibility("read")
  majorVersions?: FunctionAppMajorVersion[];

  @doc("Function App stack preferred OS.")
  @visibility("read")
  preferredOs?: StackPreferredOs;
}

@doc("Function App stack major version.")
model FunctionAppMajorVersion {
  @doc("Function App stack major version (display only).")
  @visibility("read")
  displayText?: string;

  @doc("Function App stack major version name.")
  @visibility("read")
  value?: string;

  @doc("Minor versions associated with the major version.")
  @visibility("read")
  minorVersions?: FunctionAppMinorVersion[];
}

@doc("Function App stack minor version.")
model FunctionAppMinorVersion {
  @doc("Function App stack (display only).")
  @visibility("read")
  displayText?: string;

  @doc("Function App stack name.")
  @visibility("read")
  value?: string;

  @doc("Settings associated with the minor version.")
  @visibility("read")
  stackSettings?: FunctionAppRuntimes;
}

@doc("Function App stack runtimes.")
model FunctionAppRuntimes {
  @doc("Linux-specific settings associated with the minor version.")
  @visibility("read")
  linuxRuntimeSettings?: FunctionAppRuntimeSettings;

  @doc("Windows-specific settings associated with the minor version.")
  @visibility("read")
  windowsRuntimeSettings?: FunctionAppRuntimeSettings;
}

@doc("Function App runtime settings.")
model FunctionAppRuntimeSettings {
  @doc("Function App stack minor version (runtime only).")
  @visibility("read")
  runtimeVersion?: string;

  @doc("<code>true</code> if remote debugging is supported for the stack; otherwise, <code>false</code>.")
  @visibility("read")
  remoteDebuggingSupported?: boolean;

  @doc("Application Insights settings associated with the minor version.")
  @visibility("read")
  appInsightsSettings?: AppInsightsWebAppStackSettings;

  @doc("GitHub Actions settings associated with the minor version.")
  @visibility("read")
  gitHubActionSettings?: GitHubActionWebAppStackSettings;

  @doc("Application settings associated with the minor version.")
  @visibility("read")
  appSettingsDictionary?: Record<string>;

  @doc("Configuration settings associated with the minor version.")
  @visibility("read")
  siteConfigPropertiesDictionary?: SiteConfigPropertiesDictionary;

  @doc("List of supported Functions extension versions.")
  @visibility("read")
  supportedFunctionsExtensionVersions?: string[];

  @doc("<code>true</code> if the stack is in preview; otherwise, <code>false</code>.")
  @visibility("read")
  isPreview?: boolean;

  @doc("<code>true</code> if the stack is deprecated; otherwise, <code>false</code>.")
  @visibility("read")
  isDeprecated?: boolean;

  @doc("<code>true</code> if the stack should be hidden; otherwise, <code>false</code>.")
  @visibility("read")
  isHidden?: boolean;

  @doc("End-of-life date for the minor version.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  @doc("<code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.")
  @visibility("read")
  isAutoUpdate?: boolean;

  @doc("<code>true</code> if the minor version is early-access; otherwise, <code>false</code>.")
  @visibility("read")
  isEarlyAccess?: boolean;

  @doc("<code>true</code> if the minor version the default; otherwise, <code>false</code>.")
  @visibility("read")
  isDefault?: boolean;
}

@doc("App Insights Web App stack settings.")
model AppInsightsWebAppStackSettings {
  @doc("<code>true</code> if remote Application Insights is supported for the stack; otherwise, <code>false</code>.")
  @visibility("read")
  isSupported?: boolean;

  @doc("<code>true</code> if Application Insights is disabled by default for the stack; otherwise, <code>false</code>.")
  @visibility("read")
  isDefaultOff?: boolean;
}

@doc("GitHub Actions Web App stack settings.")
model GitHubActionWebAppStackSettings {
  @doc("<code>true</code> if GitHub Actions is supported for the stack; otherwise, <code>false</code>.")
  @visibility("read")
  isSupported?: boolean;

  @doc("The minor version that is supported for GitHub Actions.")
  @visibility("read")
  supportedVersion?: string;
}

@doc("Site config properties dictionary.")
model SiteConfigPropertiesDictionary {
  @doc("<code>true</code> if use32BitWorkerProcess should be set to true for the stack; otherwise, <code>false</code>.")
  @visibility("read")
  use32BitWorkerProcess?: boolean;

  @doc("LinuxFxVersion configuration setting.")
  @visibility("read")
  linuxFxVersion?: string;

  @doc("JavaVersion configuration setting.")
  @visibility("read")
  javaVersion?: string;

  @doc("PowerShellVersion configuration setting.")
  @visibility("read")
  powerShellVersion?: string;
}

@doc("Collection of Web app Stacks")
model WebAppStackCollection is Azure.Core.Page<WebAppStack>;

@doc("Web App stack.")
model WebAppStack {
  ...ProxyOnlyResource;

  @doc("Web App stack location.")
  @visibility("read")
  location?: string;

  @doc("WebAppStack resource specific properties")
  properties?: WebAppStackProperties;
}

@doc("WebAppStack resource specific properties")
model WebAppStackProperties {
  @doc("Web App stack (display only).")
  @visibility("read")
  displayText?: string;

  @doc("Web App stack name.")
  @visibility("read")
  value?: string;

  @doc("List of major versions available.")
  @visibility("read")
  majorVersions?: WebAppMajorVersion[];

  @doc("Web App stack preferred OS.")
  @visibility("read")
  preferredOs?: StackPreferredOs;
}

@doc("Web App stack major version.")
model WebAppMajorVersion {
  @doc("Web App stack major version (display only).")
  @visibility("read")
  displayText?: string;

  @doc("Web App stack major version name.")
  @visibility("read")
  value?: string;

  @doc("Minor versions associated with the major version.")
  @visibility("read")
  minorVersions?: WebAppMinorVersion[];
}

@doc("Web App stack minor version.")
model WebAppMinorVersion {
  @doc("Web App stack minor version (display only).")
  @visibility("read")
  displayText?: string;

  @doc("Web App stack major version name.")
  @visibility("read")
  value?: string;

  @doc("Settings associated with the minor version.")
  @visibility("read")
  stackSettings?: WebAppRuntimes;
}

@doc("Web App stack runtimes.")
model WebAppRuntimes {
  @doc("Linux-specific settings associated with the minor version.")
  @visibility("read")
  linuxRuntimeSettings?: WebAppRuntimeSettings;

  @doc("Windows-specific settings associated with the minor version.")
  @visibility("read")
  windowsRuntimeSettings?: WebAppRuntimeSettings;

  @doc("Linux-specific settings associated with the Java container minor version.")
  @visibility("read")
  linuxContainerSettings?: LinuxJavaContainerSettings;

  @doc("Windows-specific settings associated with the Java container minor version.")
  @visibility("read")
  windowsContainerSettings?: WindowsJavaContainerSettings;
}

@doc("Web App runtime settings.")
model WebAppRuntimeSettings {
  @doc("Web App stack minor version (runtime only).")
  @visibility("read")
  runtimeVersion?: string;

  @doc("<code>true</code> if remote debugging is supported for the stack; otherwise, <code>false</code>.")
  @visibility("read")
  remoteDebuggingSupported?: boolean;

  @doc("Application Insights settings associated with the minor version.")
  @visibility("read")
  appInsightsSettings?: AppInsightsWebAppStackSettings;

  @doc("GitHub Actions settings associated with the minor version.")
  @visibility("read")
  gitHubActionSettings?: GitHubActionWebAppStackSettings;

  @doc("<code>true</code> if the stack is in preview; otherwise, <code>false</code>.")
  @visibility("read")
  isPreview?: boolean;

  @doc("<code>true</code> if the stack is deprecated; otherwise, <code>false</code>.")
  @visibility("read")
  isDeprecated?: boolean;

  @doc("<code>true</code> if the stack should be hidden; otherwise, <code>false</code>.")
  @visibility("read")
  isHidden?: boolean;

  @doc("End-of-life date for the minor version.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  @doc("<code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.")
  @visibility("read")
  isAutoUpdate?: boolean;

  @doc("<code>true</code> if the minor version is early-access; otherwise, <code>false</code>.")
  @visibility("read")
  isEarlyAccess?: boolean;
}

@doc("Linux Java Container settings.")
model LinuxJavaContainerSettings {
  @doc("Java 11 version (runtime only).")
  @visibility("read")
  java11Runtime?: string;

  @doc("Java 8 version (runtime only).")
  @visibility("read")
  java8Runtime?: string;

  @doc("<code>true</code> if the stack is in preview; otherwise, <code>false</code>.")
  @visibility("read")
  isPreview?: boolean;

  @doc("<code>true</code> if the stack is deprecated; otherwise, <code>false</code>.")
  @visibility("read")
  isDeprecated?: boolean;

  @doc("<code>true</code> if the stack should be hidden; otherwise, <code>false</code>.")
  @visibility("read")
  isHidden?: boolean;

  @doc("End-of-life date for the minor version.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  @doc("<code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.")
  @visibility("read")
  isAutoUpdate?: boolean;

  @doc("<code>true</code> if the minor version is early-access; otherwise, <code>false</code>.")
  @visibility("read")
  isEarlyAccess?: boolean;
}

@doc("Windows Java Container settings.")
model WindowsJavaContainerSettings {
  @doc("Java container (runtime only).")
  @visibility("read")
  javaContainer?: string;

  @doc("Java container version (runtime only).")
  @visibility("read")
  javaContainerVersion?: string;

  @doc("<code>true</code> if the stack is in preview; otherwise, <code>false</code>.")
  @visibility("read")
  isPreview?: boolean;

  @doc("<code>true</code> if the stack is deprecated; otherwise, <code>false</code>.")
  @visibility("read")
  isDeprecated?: boolean;

  @doc("<code>true</code> if the stack should be hidden; otherwise, <code>false</code>.")
  @visibility("read")
  isHidden?: boolean;

  @doc("End-of-life date for the minor version.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  @doc("<code>true</code> if the stack version is auto-updated; otherwise, <code>false</code>.")
  @visibility("read")
  isAutoUpdate?: boolean;

  @doc("<code>true</code> if the minor version is early-access; otherwise, <code>false</code>.")
  @visibility("read")
  isEarlyAccess?: boolean;
}

@doc("Collection of recommendations.")
model RecommendationCollection is Azure.Core.Page<Recommendation>;

@doc("Represents a recommendation result generated by the recommendation engine.")
model Recommendation {
  ...ProxyOnlyResource;

  @doc("Recommendation resource specific properties")
  properties?: RecommendationProperties;
}

@doc("Recommendation resource specific properties")
model RecommendationProperties {
  @doc("Timestamp when this instance was created.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("A GUID value that each recommendation object is associated with.")
  recommendationId?: string;

  @doc("Full ARM resource ID string that this recommendation object is associated with.")
  resourceId?: string;

  @doc("Name of a resource type this recommendation applies, e.g. Subscription, ServerFarm, Site.")
  resourceScope?: ResourceScopeType;

  @doc("Unique name of the rule.")
  ruleName?: string;

  @doc("UI friendly name of the rule (may not be unique).")
  displayName?: string;

  @doc("Recommendation text.")
  message?: string;

  @doc("Level indicating how critical this recommendation can impact.")
  level?: NotificationLevel;

  @doc("List of channels that this recommendation can apply.")
  channels?: Channels;

  @doc("The list of category tags that this recommendation belongs to.")
  @visibility("read")
  categoryTags?: string[];

  @doc("Name of action recommended by this object.")
  actionName?: string;

  @doc("True if this recommendation is still valid (i.e. \"actionable\"). False if it is invalid.")
  enabled?: int32;

  @doc("The list of states of this recommendation. If it's null then it should be considered \"Active\".")
  states?: string[];

  @doc("The beginning time in UTC of a range that the recommendation refers to.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time in UTC of a range that the recommendation refers to.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("When to notify this recommendation next in UTC. Null means that this will never be notified anymore.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextNotificationTime?: utcDateTime;

  @doc("Date and time in UTC when this notification expires.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notificationExpirationTime?: utcDateTime;

  @doc("Last timestamp in UTC this instance was actually notified. Null means that this recommendation hasn't been notified yet.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notifiedTime?: utcDateTime;

  @doc("A metric value measured by the rule.")
  score?: float32;

  @doc("True if this is associated with a dynamically added rule")
  isDynamic?: boolean;

  @doc("Extension name of the portal if exists.")
  extensionName?: string;

  @doc("Deep link to a blade on the portal.")
  bladeName?: string;

  @doc("Forward link to an external document associated with the rule.")
  forwardLink?: string;
}

@doc("RecommendationRule resource specific properties")
model RecommendationRuleProperties {
  @doc("Unique name of the rule.")
  recommendationName?: string;

  @doc("UI friendly name of the rule.")
  displayName?: string;

  @doc("Localized name of the rule (Good for UI).")
  message?: string;

  @doc("""
Recommendation ID of an associated recommendation object tied to the rule, if exists.
If such an object doesn't exist, it is set to null.
""")
  recommendationId?: string;

  @doc("Localized detailed description of the rule.")
  description?: string;

  @doc("Name of action that is recommended by this rule in string.")
  actionName?: string;

  @doc("Level of impact indicating how critical this rule is.")
  level?: NotificationLevel;

  @doc("List of available channels that this rule applies.")
  channels?: Channels;

  @doc("The list of category tags that this recommendation rule belongs to.")
  @visibility("read")
  categoryTags?: string[];

  @doc("True if this is associated with a dynamically added rule")
  isDynamic?: boolean;

  @doc("Extension name of the portal if exists. Applicable to dynamic rule only.")
  extensionName?: string;

  @doc("Deep link to a blade on the portal. Applicable to dynamic rule only.")
  bladeName?: string;

  @doc("Forward link to an external document associated with the rule. Applicable to dynamic rule only.")
  forwardLink?: string;
}

@doc("ResourceHealthMetadata resource specific properties")
model ResourceHealthMetadataProperties {
  @doc("The category that the resource matches in the RHC Policy File")
  category?: string;

  @doc("Is there a health signal for the resource")
  signalAvailability?: boolean;
}

@doc("User resource specific properties")
model UserProperties {
  @doc("Username used for publishing.")
  publishingUserName: string;

  @doc("Password used for publishing.")
  @secret
  publishingPassword?: string;

  @doc("Password hash used for publishing.")
  @secret
  publishingPasswordHash?: string;

  @doc("Password hash salt used for publishing.")
  @secret
  publishingPasswordHashSalt?: string;

  @doc("Url of SCM site.")
  scmUri?: string;
}

@doc("SourceControl resource specific properties")
model SourceControlProperties {
  @doc("OAuth access token.")
  token?: string;

  @doc("OAuth access token secret.")
  tokenSecret?: string;

  @doc("OAuth refresh token.")
  refreshToken?: string;

  @doc("OAuth token expiration.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;
}

@doc("Collection of Billing Meters")
model BillingMeterCollection is Azure.Core.Page<BillingMeter>;

@doc("App Service billing entity that contains information about meter which the Azure billing system utilizes to charge users for services.")
model BillingMeter {
  ...ProxyOnlyResource;

  @doc("BillingMeter resource specific properties")
  properties?: BillingMeterProperties;
}

@doc("BillingMeter resource specific properties")
model BillingMeterProperties {
  @doc("Meter GUID onboarded in Commerce")
  meterId?: string;

  @doc("Azure Location of billable resource")
  billingLocation?: string;

  @doc("Short Name from App Service Azure pricing Page")
  shortName?: string;

  @doc("Friendly name of the meter")
  friendlyName?: string;

  @doc("App Service ResourceType meter used for")
  resourceType?: string;

  @doc("App Service OS type meter used for")
  osType?: string;

  @doc("Meter Multiplier")
  multiplier?: float32;
}

@doc("Resource name availability request content.")
model ResourceNameAvailabilityRequest {
  @doc("Resource name to verify.")
  name: string;

  @doc("Resource type used for verification.")
  type: CheckNameResourceTypes;

  @doc("Is fully qualified domain name.")
  isFqdn?: boolean;
}

@doc("Information regarding availability of a resource name.")
model ResourceNameAvailability {
  @doc("<code>true</code> indicates name is valid and available. <code>false</code> indicates the name is invalid, unavailable, or both.")
  nameAvailable?: boolean;

  @doc("<code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.")
  reason?: InAvailabilityReasonType;

  @doc("If reason == invalid, provide the user with the reason why the given name is invalid, and provide the resource naming requirements so that the user can select a valid name. If reason == AlreadyExists, explain that resource name is already in use, and direct them to select a different name.")
  message?: string;
}

@doc("""
List of available locations (regions or App Service Environments) for
deployment of App Service resources.
""")
model DeploymentLocations {
  @doc("Available regions.")
  locations?: GeoRegion[];

  @doc("Available App Service Environments with full descriptions of the environments.")
  hostingEnvironments?: AppServiceEnvironment[];

  @doc("Available App Service Environments with basic information.")
  hostingEnvironmentDeploymentInfos?: HostingEnvironmentDeploymentInfo[];
}

@doc("Geographical region.")
model GeoRegion {
  ...ProxyOnlyResource;

  @doc("GeoRegion resource specific properties")
  properties?: GeoRegionProperties;
}

@doc("GeoRegion resource specific properties")
model GeoRegionProperties {
  @doc("Region description.")
  @visibility("read")
  description?: string;

  @doc("Display name for region.")
  @visibility("read")
  displayName?: string;

  @doc("Display name for region.")
  @visibility("read")
  orgDomain?: string;
}

@doc("Information needed to create resources on an App Service Environment.")
model HostingEnvironmentDeploymentInfo {
  @doc("Name of the App Service Environment.")
  name?: string;

  @doc("Location of the App Service Environment.")
  location?: string;
}

@doc("Collection of geographical regions.")
model GeoRegionCollection is Azure.Core.Page<GeoRegion>;

@doc("Identifier resource specific properties")
model IdentifierProperties {
  @doc("String representation of the identity.")
  @projectedName("json", "id")
  value?: string;
}

@doc("Collection of premier add-on offers.")
model PremierAddOnOfferCollection is Azure.Core.Page<PremierAddOnOffer>;

@doc("Premier add-on offer.")
model PremierAddOnOffer {
  ...ProxyOnlyResource;

  @doc("PremierAddOnOffer resource specific properties")
  properties?: PremierAddOnOfferProperties;
}

@doc("PremierAddOnOffer resource specific properties")
model PremierAddOnOfferProperties {
  @doc("Premier add on SKU.")
  sku?: string;

  @doc("Premier add on offer Product.")
  product?: string;

  @doc("Premier add on offer Vendor.")
  vendor?: string;

  @doc("<code>true</code> if promotion code is required; otherwise, <code>false</code>.")
  promoCodeRequired?: boolean;

  @doc("Premier add on offer Quota.")
  quota?: int32;

  @doc("App Service plans this offer is restricted to.")
  webHostingPlanRestrictions?: AppServicePlanRestrictions;

  @doc("Privacy policy URL.")
  privacyPolicyUrl?: string;

  @doc("Legal terms URL.")
  legalTermsUrl?: string;

  @doc("Marketplace publisher.")
  marketplacePublisher?: string;

  @doc("Marketplace offer.")
  marketplaceOffer?: string;
}

@doc("Collection of SKU information.")
model SkuInfos {
  @doc("Resource type that this SKU applies to.")
  resourceType?: string;

  @doc("List of SKUs the subscription is able to use.")
  skus?: GlobalCsmSkuDescription[];
}

@doc("A Global SKU Description.")
model GlobalCsmSkuDescription {
  @doc("Name of the resource SKU.")
  name?: string;

  @doc("Service Tier of the resource SKU.")
  tier?: string;

  @doc("Size specifier of the resource SKU.")
  size?: string;

  @doc("Family code of the resource SKU.")
  family?: string;

  @doc("Min, max, and default scale values of the SKU.")
  capacity?: SkuCapacity;

  @doc("Locations of the SKU.")
  locations?: string[];

  @doc("Capabilities of the SKU, e.g., is traffic manager enabled?")
  capabilities?: Capability[];
}

@doc("The required set of inputs to validate a VNET")
model VnetParameters {
  ...ProxyOnlyResource;

  @doc("VnetParameters resource specific properties")
  properties?: VnetParametersProperties;
}

@doc("VnetParameters resource specific properties")
model VnetParametersProperties {
  @doc("The Resource Group of the VNET to be validated")
  vnetResourceGroup?: string;

  @doc("The name of the VNET to be validated")
  vnetName?: string;

  @doc("The subnet name to be validated")
  vnetSubnetName?: string;

  @doc("The ARM Resource ID of the subnet to validate")
  subnetResourceId?: string;
}

@doc("A class that describes the reason for a validation failure.")
model VnetValidationFailureDetails {
  ...ProxyOnlyResource;

  @doc("VnetValidationFailureDetails resource specific properties")
  properties?: VnetValidationFailureDetailsProperties;
}

@doc("VnetValidationFailureDetails resource specific properties")
model VnetValidationFailureDetailsProperties {
  @doc("Text describing the validation outcome.")
  message?: string;

  @doc("A flag describing whether or not validation failed.")
  failed?: boolean;

  @doc("A list of tests that failed in the validation.")
  failedTests?: VnetValidationTestFailure[];

  @doc("A list of warnings generated during validation.")
  warnings?: VnetValidationTestFailure[];
}

@doc("A class that describes a test that failed during NSG and UDR validation.")
model VnetValidationTestFailure {
  ...ProxyOnlyResource;

  @doc("VnetValidationTestFailure resource specific properties")
  properties?: VnetValidationTestFailureProperties;
}

@doc("VnetValidationTestFailure resource specific properties")
model VnetValidationTestFailureProperties {
  @doc("The name of the test that failed.")
  testName?: string;

  @doc("The details of what caused the failure, e.g. the blocking rule name, etc.")
  details?: string;
}

@doc("Resource validation request content.")
model ValidateRequest {
  @doc("Resource name to verify.")
  name: string;

  @doc("Resource type used for verification.")
  type: ValidateResourceTypes;

  @doc("Expected location of the resource.")
  location: string;

  @doc("Properties of the resource to validate.")
  properties: ValidateProperties;
}

@doc("App properties used for validation.")
model ValidateProperties {
  @doc("ARM resource ID of an App Service plan that would host the app.")
  serverFarmId?: string;

  @doc("Name of the target SKU for the App Service plan.")
  skuName?: string;

  @doc("<code>true</code> if App Service plan is for Linux workers; otherwise, <code>false</code>.")
  needLinuxWorkers?: boolean;

  @doc("<code>true</code> if App Service plan is for Spot instances; otherwise, <code>false</code>.")
  isSpot?: boolean;

  @doc("Target capacity of the App Service plan (number of VMs).")
  @minValue(1)
  capacity?: int32;

  @doc("Name of App Service Environment where app or App Service plan should be created.")
  hostingEnvironment?: string;

  @doc("<code>true</code> if App Service plan is running as a windows container")
  isXenon?: boolean;

  @doc("Base URL of the container registry")
  containerRegistryBaseUrl?: string;

  @doc("Username for to access the container registry")
  containerRegistryUsername?: string;

  @doc("Password for to access the container registry")
  containerRegistryPassword?: string;

  @doc("Repository name (image name)")
  containerImageRepository?: string;

  @doc("Image tag")
  containerImageTag?: string;

  @doc("Platform (windows or linux)")
  containerImagePlatform?: string;

  @doc("App Service Environment Properties")
  appServiceEnvironment?: AppServiceEnvironment;
}

@doc("Describes the result of resource validation.")
model ValidateResponse {
  @doc("Result of validation.")
  status?: string;

  @doc("Error details for the case when validation fails.")
  error?: ValidateResponseError;
}

@doc("Error details for when validation fails.")
model ValidateResponseError {
  @doc("Validation error code.")
  code?: string;

  @doc("Validation error message.")
  message?: string;
}

@doc("Request entity for previewing the Static Site workflow")
model StaticSitesWorkflowPreviewRequest {
  ...ProxyOnlyResource;

  @doc("StaticSitesWorkflowPreviewRequest resource specific properties")
  properties?: StaticSitesWorkflowPreviewRequestProperties;
}

@doc("StaticSitesWorkflowPreviewRequest resource specific properties")
model StaticSitesWorkflowPreviewRequestProperties {
  @doc("URL for the repository of the static site.")
  repositoryUrl?: string;

  @doc("The target branch in the repository.")
  branch?: string;

  @doc("Build properties to configure on the repository.")
  buildProperties?: StaticSiteBuildProperties;
}

@doc("Build properties for the static site.")
model StaticSiteBuildProperties {
  @doc("The path to the app code within the repository.")
  appLocation?: string;

  @doc("The path to the api code within the repository.")
  apiLocation?: string;

  @doc("Deprecated: The path of the app artifacts after building (deprecated in favor of OutputLocation)")
  appArtifactLocation?: string;

  @doc("The output path of the app after building.")
  outputLocation?: string;

  @doc("A custom command to run during deployment of the static content application.")
  appBuildCommand?: string;

  @doc("A custom command to run during deployment of the Azure Functions API application.")
  apiBuildCommand?: string;

  @doc("Skip Github Action workflow generation.")
  skipGithubActionWorkflowGeneration?: boolean;

  @doc("Github Action secret name override.")
  githubActionSecretNameOverride?: string;
}

@doc("Preview for the Static Site Workflow to be generated")
model StaticSitesWorkflowPreview {
  ...ProxyOnlyResource;

  @doc("StaticSitesWorkflowPreview resource specific properties")
  properties?: StaticSitesWorkflowPreviewProperties;
}

@doc("StaticSitesWorkflowPreview resource specific properties")
model StaticSitesWorkflowPreviewProperties {
  @doc("The path for the workflow file to be generated")
  @visibility("read")
  path?: string;

  @doc("The contents for the workflow file to be generated")
  @visibility("read")
  contents?: string;
}

@doc("A static site.")
model StaticSite {
  @doc("The default autogenerated hostname for the static site.")
  @visibility("read")
  defaultHostname?: string;

  @doc("URL for the repository of the static site.")
  repositoryUrl?: string;

  @doc("The target branch in the repository.")
  branch?: string;

  @doc("The custom domains associated with this static site.")
  @visibility("read")
  customDomains?: string[];

  @doc("A user's github repository token. This is used to setup the Github Actions workflow file and API secrets.")
  repositoryToken?: string;

  @doc("Build properties to configure on the repository.")
  buildProperties?: StaticSiteBuildProperties;

  @doc("Private endpoint connections")
  @visibility("read")
  privateEndpointConnections?: ResponseMessageEnvelopeRemotePrivateEndpointConnection[];

  @doc("State indicating whether staging environments are allowed or not allowed for a static web app.")
  stagingEnvironmentPolicy?: StagingEnvironmentPolicy;

  @doc("<code>false</code> if config file is locked for this static web app; otherwise, <code>true</code>.")
  allowConfigFileUpdates?: boolean;

  @doc("Template options for generating a new repository.")
  templateProperties?: StaticSiteTemplateOptions;

  @doc("The content distribution endpoint for the static site.")
  @visibility("read")
  contentDistributionEndpoint?: string;

  @doc("Identity to use for Key Vault Reference authentication.")
  @visibility("read")
  keyVaultReferenceIdentity?: string;

  @doc("User provided function apps registered with the static site")
  @visibility("read")
  userProvidedFunctionApps?: StaticSiteUserProvidedFunctionAppARMResource[];

  @doc("The provider that submitted the last deployment to the primary environment of the static site.")
  @visibility("read")
  provider?: string;
}

@doc("Message envelope that contains the common Azure resource manager properties and the resource provider specific content.")
model ResponseMessageEnvelopeRemotePrivateEndpointConnection {
  @doc("""
Resource Id. Typically ID is populated only for responses to GET requests. Caller is responsible for passing in this
value for GET requests only.
For example: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupId}/providers/Microsoft.Web/sites/{sitename}
""")
  id?: string;

  @doc("Name of resource.")
  name?: string;

  @doc("Type of resource e.g \"Microsoft.Web/sites\".")
  type?: string;

  @doc("Geographical region resource belongs to e.g. SouthCentralUS, SouthEastAsia.")
  location?: string;

  @doc("Tags associated with resource.")
  tags?: Record<string>;

  @doc("Azure resource manager plan.")
  plan?: ArmPlan;

  @doc("Resource specific properties.")
  properties?: RemotePrivateEndpointConnection;

  @doc("SKU description of the resource.")
  sku?: SkuDescription;

  @doc("Azure-AsyncOperation Status info.")
  status?: string;

  @doc("Azure-AsyncOperation Error info.")
  error?: ErrorEntity;

  @doc("MSI resource")
  identity?: ManagedServiceIdentity;

  @doc("Logical Availability Zones the service is hosted in")
  zones?: string[];
}

@doc("The plan object in Azure Resource Manager, represents a marketplace plan.")
model ArmPlan {
  @doc("The name.")
  name?: string;

  @doc("The publisher.")
  publisher?: string;

  @doc("The product.")
  product?: string;

  @doc("The promotion code.")
  promotionCode?: string;

  @doc("Version of product.")
  version?: string;
}

@doc("A remote private endpoint connection")
model RemotePrivateEndpointConnection {
  ...ProxyOnlyResource;

  @doc("RemotePrivateEndpointConnection resource specific properties")
  properties?: RemotePrivateEndpointConnectionProperties;
}

@doc("RemotePrivateEndpointConnection resource specific properties")
model RemotePrivateEndpointConnectionProperties {
  @visibility("read")
  provisioningState?: string;

  @doc("PrivateEndpoint of a remote private endpoint connection")
  privateEndpoint?: ArmIdWrapper;

  @doc("The state of a private link connection")
  privateLinkServiceConnectionState?: PrivateLinkConnectionState;

  @doc("Private IPAddresses mapped to the remote private endpoint")
  ipAddresses?: string[];
}

@doc("Template Options for the static site.")
model StaticSiteTemplateOptions {
  @doc("URL of the template repository. The newly generated repository will be based on this one.")
  templateRepositoryUrl?: string;

  @doc("Owner of the newly generated repository.")
  owner?: string;

  @doc("Name of the newly generated repository.")
  repositoryName?: string;

  @doc("Description of the newly generated repository.")
  description?: string;

  @doc("Whether or not the newly generated repository is a private repository. Defaults to false (i.e. public).")
  isPrivate?: boolean;
}

@doc("StaticSiteUserProvidedFunctionAppARMResource resource specific properties")
model StaticSiteUserProvidedFunctionAppARMResourceProperties {
  @doc("The resource id of the function app registered with the static site")
  functionAppResourceId?: string;

  @doc("The region of the function app registered with the static site")
  functionAppRegion?: string;

  @doc("The date and time on which the function app was registered with the static site.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;
}

@doc("Collection of static site custom users.")
model StaticSiteUserCollection is Azure.Core.Page<StaticSiteUserARMResource>;

@doc("Static Site User ARM resource.")
model StaticSiteUserARMResource {
  ...ProxyOnlyResource;

  @doc("StaticSiteUserARMResource resource specific properties")
  properties?: StaticSiteUserARMResourceProperties;
}

@doc("StaticSiteUserARMResource resource specific properties")
model StaticSiteUserARMResourceProperties {
  @doc("The identity provider for the static site user.")
  @visibility("read")
  provider?: string;

  @doc("The user id for the static site user.")
  @visibility("read")
  userId?: string;

  @doc("The display name for the static site user.")
  @visibility("read")
  displayName?: string;

  @doc("The roles for the static site user, in free-form string format")
  roles?: string;
}

@doc("StaticSiteBuildARMResource resource specific properties")
model StaticSiteBuildARMResourceProperties {
  @doc("An identifier for the static site build.")
  @visibility("read")
  buildId?: string;

  @doc("The source branch.")
  @visibility("read")
  sourceBranch?: string;

  @doc("The title of a pull request that a static site build is related to.")
  @visibility("read")
  pullRequestTitle?: string;

  @doc("The hostname for a static site build.")
  @visibility("read")
  hostname?: string;

  @doc("When this build was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTimeUtc?: utcDateTime;

  @doc("When this build was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedOn?: utcDateTime;

  @doc("The status of the static site build.")
  @visibility("read")
  status?: BuildStatus;

  @doc("User provided function apps registered with the static site build")
  @visibility("read")
  userProvidedFunctionApps?: StaticSiteUserProvidedFunctionAppARMResource[];
}

@doc("String dictionary resource.")
model StringDictionary {
  ...ProxyOnlyResource;

  @doc("Settings.")
  properties?: Record<string>;
}

@doc("Collection of static site functions.")
model StaticSiteFunctionOverviewCollection
  is Azure.Core.Page<StaticSiteFunctionOverviewARMResource>;

@doc("Static Site Function Overview ARM resource.")
model StaticSiteFunctionOverviewARMResource {
  ...ProxyOnlyResource;

  @doc("StaticSiteFunctionOverviewARMResource resource specific properties")
  properties?: StaticSiteFunctionOverviewARMResourceProperties;
}

@doc("StaticSiteFunctionOverviewARMResource resource specific properties")
model StaticSiteFunctionOverviewARMResourceProperties {
  @doc("The name for the function")
  @visibility("read")
  functionName?: string;

  @doc("The trigger type of the function")
  @visibility("read")
  triggerType?: TriggerTypes;
}

@doc("Static site zip deployment ARM resource.")
model StaticSiteZipDeploymentARMResource {
  ...ProxyOnlyResource;

  @doc("Core resource properties")
  properties?: StaticSiteZipDeployment;
}

@doc("A static site zip deployment.")
model StaticSiteZipDeployment {
  @doc("URL for the zipped app content")
  appZipUrl?: string;

  @doc("URL for the zipped api content")
  apiZipUrl?: string;

  @doc("A title to label the deployment")
  deploymentTitle?: string;

  @doc("The provider submitting this deployment")
  provider?: string;

  @doc("The language of the api content, if it exists")
  functionLanguage?: string;
}

@doc("Static sites user roles invitation resource.")
model StaticSiteUserInvitationRequestResource {
  ...ProxyOnlyResource;

  @doc("StaticSiteUserInvitationRequestResource resource specific properties")
  properties?: StaticSiteUserInvitationRequestResourceProperties;
}

@doc("StaticSiteUserInvitationRequestResource resource specific properties")
model StaticSiteUserInvitationRequestResourceProperties {
  @doc("The domain name for the static site custom domain.")
  domain?: string;

  @doc("The identity provider for the static site user.")
  provider?: string;

  @doc("The user id for the static site user.")
  userDetails?: string;

  @doc("The roles for the static site user, in free-form string format")
  roles?: string;

  @doc("The number of hours the sas token stays valid")
  numHoursToExpiration?: int32;
}

@doc("Static sites user roles invitation link resource.")
model StaticSiteUserInvitationResponseResource {
  ...ProxyOnlyResource;

  @doc("StaticSiteUserInvitationResponseResource resource specific properties")
  properties?: StaticSiteUserInvitationResponseResourceProperties;
}

@doc("StaticSiteUserInvitationResponseResource resource specific properties")
model StaticSiteUserInvitationResponseResourceProperties {
  @doc("The expiration time of the invitation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresOn?: utcDateTime;

  @doc("The url for the invitation link")
  @visibility("read")
  invitationUrl?: string;
}

@doc("StaticSiteCustomDomainOverviewARMResource resource specific properties")
model StaticSiteCustomDomainOverviewARMResourceProperties {
  @doc("The domain name for the static site custom domain.")
  @visibility("read")
  domainName?: string;

  @doc("The date and time on which the custom domain was created for the static site.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("The status of the custom domain")
  @visibility("read")
  status?: CustomDomainStatus;

  @doc("The TXT record validation token")
  @visibility("read")
  validationToken?: string;

  @visibility("read")
  errorMessage?: string;
}

@doc("Static Site Custom Domain Request Properties ARM resource.")
model StaticSiteCustomDomainRequestPropertiesARMResource {
  ...ProxyOnlyResource;

  @doc("StaticSiteCustomDomainRequestPropertiesARMResource resource specific properties")
  properties?: StaticSiteCustomDomainRequestPropertiesARMResourceProperties;
}

@doc("StaticSiteCustomDomainRequestPropertiesARMResource resource specific properties")
model StaticSiteCustomDomainRequestPropertiesARMResourceProperties {
  @doc("Validation method for adding a custom domain")
  validationMethod?: string;
}

@doc("String list resource.")
model StringList {
  ...ProxyOnlyResource;

  @doc("List of string resources.")
  properties?: string[];
}

@doc("Static Site Reset Properties ARM resource.")
model StaticSiteResetPropertiesARMResource {
  ...ProxyOnlyResource;

  @doc("StaticSiteResetPropertiesARMResource resource specific properties")
  properties?: StaticSiteResetPropertiesARMResourceProperties;
}

@doc("StaticSiteResetPropertiesARMResource resource specific properties")
model StaticSiteResetPropertiesARMResourceProperties {
  @doc("The token which proves admin privileges to the repository.")
  repositoryToken?: string;

  @doc("Determines whether the repository should be updated with the new properties.")
  shouldUpdateRepository?: boolean;
}

@doc("Custom domain analysis.")
model CustomHostnameAnalysisResult {
  ...ProxyOnlyResource;

  @doc("CustomHostnameAnalysisResult resource specific properties")
  properties?: CustomHostnameAnalysisResultProperties;
}

@doc("CustomHostnameAnalysisResult resource specific properties")
model CustomHostnameAnalysisResultProperties {
  @doc("<code>true</code> if hostname is already verified; otherwise, <code>false</code>.")
  @visibility("read")
  isHostnameAlreadyVerified?: boolean;

  @doc("DNS verification test result.")
  @visibility("read")
  customDomainVerificationTest?: DnsVerificationTestResult;

  @doc("Raw failure information if DNS verification fails.")
  @visibility("read")
  customDomainVerificationFailureInfo?: ErrorEntity;

  @doc("<code>true</code> if there is a conflict on a scale unit; otherwise, <code>false</code>.")
  @visibility("read")
  hasConflictOnScaleUnit?: boolean;

  @doc("<code>true</code> if there is a conflict across subscriptions; otherwise, <code>false</code>.")
  @visibility("read")
  hasConflictAcrossSubscription?: boolean;

  @doc("Name of the conflicting app on scale unit if it's within the same subscription.")
  @visibility("read")
  conflictingAppResourceId?: string;

  @doc("CName records controller can see for this hostname.")
  cNameRecords?: string[];

  @doc("TXT records controller can see for this hostname.")
  txtRecords?: string[];

  @doc("A records controller can see for this hostname.")
  aRecords?: string[];

  @doc("Alternate CName records controller can see for this hostname.")
  alternateCNameRecords?: string[];

  @doc("Alternate TXT records controller can see for this hostname.")
  alternateTxtRecords?: string[];
}

@doc("Deployment slot parameters.")
model CsmSlotEntity {
  @doc("Destination deployment slot during swap operation.")
  targetSlot: string;

  @doc("<code>true</code> to preserve Virtual Network to the slot during swap; otherwise, <code>false</code>.")
  preserveVnet: boolean;
}

@doc("Description of a backup which will be performed.")
model BackupRequest {
  ...ProxyOnlyResource;

  @doc("BackupRequest resource specific properties")
  properties?: BackupRequestProperties;
}

@doc("BackupRequest resource specific properties")
model BackupRequestProperties {
  @doc("Name of the backup.")
  backupName?: string;

  @doc("True if the backup schedule is enabled (must be included in that case), false if the backup schedule should be disabled.")
  enabled?: boolean;

  @doc("SAS URL to the container.")
  storageAccountUrl: string;

  @doc("Schedule for the backup if it is executed periodically.")
  backupSchedule?: BackupSchedule;

  @doc("Databases included in the backup.")
  databases?: DatabaseBackupSetting[];
}

@doc("Description of a backup schedule. Describes how often should be the backup performed and what should be the retention policy.")
model BackupSchedule {
  @doc("How often the backup should be executed (e.g. for weekly backup, this should be set to 7 and FrequencyUnit should be set to Day)")
  frequencyInterval: int32;

  @doc("The unit of time for how often the backup should be executed (e.g. for weekly backup, this should be set to Day and FrequencyInterval should be set to 7)")
  frequencyUnit: FrequencyUnit;

  @doc("True if the retention policy should always keep at least one backup in the storage account, regardless how old it is; false otherwise.")
  keepAtLeastOneBackup: boolean;

  @doc("After how many days backups should be deleted.")
  retentionPeriodInDays: int32;

  @doc("When the schedule should start working.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Last time when this schedule was triggered.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutionTime?: utcDateTime;
}

@doc("Database backup settings.")
model DatabaseBackupSetting {
  @doc("Database type (e.g. SqlAzure / MySql).")
  databaseType: DatabaseType;

  name?: string;

  @doc("""
Contains a connection string name that is linked to the SiteConfig.ConnectionStrings.
This is used during restore with overwrite connection strings options.
""")
  connectionStringName?: string;

  @doc("Contains a connection string to a database which is being backed up or restored. If the restore should happen to a new database, the database name inside is the new one.")
  connectionString?: string;
}

@doc("BackupItem resource specific properties")
model BackupItemProperties {
  @doc("Id of the backup.")
  @visibility("read")
  @projectedName("json", "id")
  backupId?: int32;

  @doc("SAS URL for the storage account container which contains this backup.")
  @visibility("read")
  storageAccountUrl?: string;

  @doc("Name of the blob which contains data for this backup.")
  @visibility("read")
  blobName?: string;

  @doc("Name of this backup.")
  @visibility("read")
  name?: string;

  @doc("Backup status.")
  @visibility("read")
  status?: BackupItemStatus;

  @doc("Size of the backup in bytes.")
  @visibility("read")
  sizeInBytes?: int32;

  @doc("Timestamp of the backup creation.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("Details regarding this backup. Might contain an error message.")
  @visibility("read")
  log?: string;

  @doc("List of databases included in the backup.")
  @visibility("read")
  databases?: DatabaseBackupSetting[];

  @doc("True if this backup has been created due to a schedule being triggered.")
  @visibility("read")
  scheduled?: boolean;

  @doc("Timestamp of a last restore operation which used this backup.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRestoreTimeStamp?: utcDateTime;

  @doc("Timestamp when this backup finished.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishedTimeStamp?: utcDateTime;

  @doc("Unique correlation identifier. Please use this along with the timestamp while communicating with Azure support.")
  @visibility("read")
  correlationId?: string;

  @doc("Size of the original web app which has been backed up.")
  @visibility("read")
  websiteSizeInBytes?: int32;
}

@doc("Description of a restore request.")
model RestoreRequest {
  ...ProxyOnlyResource;

  @doc("RestoreRequest resource specific properties")
  properties?: RestoreRequestProperties;
}

@doc("RestoreRequest resource specific properties")
model RestoreRequestProperties {
  @doc("SAS URL to the container.")
  storageAccountUrl: string;

  @doc("Name of a blob which contains the backup.")
  blobName?: string;

  @doc("<code>true</code> if the restore operation can overwrite target app; otherwise, <code>false</code>. <code>true</code> is needed if trying to restore over an existing app.")
  overwrite: boolean;

  @doc("Name of an app.")
  siteName?: string;

  @doc("Collection of databases which should be restored. This list has to match the list of databases included in the backup.")
  databases?: DatabaseBackupSetting[];

  @doc("""
Changes a logic when restoring an app with custom domains. <code>true</code> to remove custom domains automatically. If <code>false</code>, custom domains are added to 
the app's object when it is being restored, but that might fail due to conflicts during the operation.
""")
  ignoreConflictingHostNames?: boolean;

  @doc("Ignore the databases and only restore the site content")
  ignoreDatabases?: boolean;

  @doc("Specify app service plan that will own restored site.")
  appServicePlan?: string;

  @doc("Operation type.")
  operationType?: BackupRestoreOperationType;

  @doc("<code>true</code> if SiteConfig.ConnectionStrings should be set in new app; otherwise, <code>false</code>.")
  adjustConnectionStrings?: boolean;

  @doc("App Service Environment name, if needed (only when restoring an app to an App Service Environment).")
  hostingEnvironment?: string;
}

@doc("CsmPublishingCredentialsPoliciesEntity resource specific properties")
model CsmPublishingCredentialsPoliciesEntityProperties {
  @doc("<code>true</code> to allow access to a publishing method; otherwise, <code>false</code>.")
  allow: boolean;
}

@doc("Configuration settings for the Azure App Service Authentication / Authorization feature.")
model SiteAuthSettings {
  ...ProxyOnlyResource;

  @doc("SiteAuthSettings resource specific properties")
  properties?: SiteAuthSettingsProperties;
}

@doc("SiteAuthSettings resource specific properties")
model SiteAuthSettingsProperties {
  @doc("<code>true</code> if the Authentication / Authorization feature is enabled for the current app; otherwise, <code>false</code>.")
  enabled?: boolean;

  @doc("""
The RuntimeVersion of the Authentication / Authorization feature in use for the current app.
The setting in this value can control the behavior of certain features in the Authentication / Authorization module.
""")
  runtimeVersion?: string;

  @doc("The action to take when an unauthenticated client attempts to access the app.")
  unauthenticatedClientAction?: UnauthenticatedClientAction;

  @doc("""
<code>true</code> to durably store platform-specific security tokens that are obtained during login flows; otherwise, <code>false</code>.
 The default is <code>false</code>.
""")
  tokenStoreEnabled?: boolean;

  @doc("""
External URLs that can be redirected to as part of logging in or logging out of the app. Note that the query string part of the URL is ignored.
This is an advanced setting typically only needed by Windows Store application backends.
Note that URLs within the current domain are always implicitly allowed.
""")
  allowedExternalRedirectUrls?: string[];

  @doc("""
The default authentication provider to use when multiple providers are configured.
This setting is only needed if multiple providers are configured and the unauthenticated client
action is set to \"RedirectToLoginPage\".
""")
  defaultProvider?: BuiltInAuthenticationProvider;

  @doc("""
The number of hours after session token expiration that a session token can be used to
call the token refresh API. The default is 72 hours.
""")
  tokenRefreshExtensionHours?: float32;

  @doc("""
The Client ID of this relying party application, known as the client_id.
This setting is required for enabling OpenID Connection authentication with Azure Active Directory or 
other 3rd party OpenID Connect providers.
More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
""")
  clientId?: string;

  @doc("""
The Client Secret of this relying party application (in Azure Active Directory, this is also referred to as the Key).
This setting is optional. If no client secret is configured, the OpenID Connect implicit auth flow is used to authenticate end users.
Otherwise, the OpenID Connect Authorization Code Flow is used to authenticate end users.
More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
""")
  clientSecret?: string;

  @doc("The app setting name that contains the client secret of the relying party application.")
  clientSecretSettingName?: string;

  @doc("""
An alternative to the client secret, that is the thumbprint of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret. It is also optional.
""")
  clientSecretCertificateThumbprint?: string;

  @doc("""
The OpenID Connect Issuer URI that represents the entity which issues access tokens for this application.
When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/.
This URI is a case-sensitive identifier for the token issuer.
More information on OpenID Connect Discovery: http://openid.net/specs/openid-connect-discovery-1_0.html
""")
  issuer?: string;

  @doc("Gets a value indicating whether the issuer should be a valid HTTPS url and be validated as such.")
  validateIssuer?: boolean;

  @doc("""
Allowed audience values to consider when validating JWTs issued by 
Azure Active Directory. Note that the <code>ClientID</code> value is always considered an
allowed audience, regardless of this setting.
""")
  allowedAudiences?: string[];

  @doc("""
Login parameters to send to the OpenID Connect authorization endpoint when
a user logs in. Each parameter must be in the form \"key=value\".
""")
  additionalLoginParams?: string[];

  @doc("Gets a JSON string containing the Azure AD Acl settings.")
  aadClaimsAuthorization?: string;

  @doc("""
The OpenID Connect Client ID for the Google web application.
This setting is required for enabling Google Sign-In.
Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
""")
  googleClientId?: string;

  @doc("""
The client secret associated with the Google web application.
This setting is required for enabling Google Sign-In.
Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
""")
  googleClientSecret?: string;

  @doc("""
The app setting name that contains the client secret associated with 
the Google web application.
""")
  googleClientSecretSettingName?: string;

  @doc("""
The OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication.
This setting is optional. If not specified, \"openid\", \"profile\", and \"email\" are used as default scopes.
Google Sign-In documentation: https://developers.google.com/identity/sign-in/web/
""")
  googleOAuthScopes?: string[];

  @doc("""
The App ID of the Facebook app used for login.
This setting is required for enabling Facebook Login.
Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
""")
  facebookAppId?: string;

  @doc("""
The App Secret of the Facebook app used for Facebook Login.
This setting is required for enabling Facebook Login.
Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
""")
  facebookAppSecret?: string;

  @doc("The app setting name that contains the app secret used for Facebook Login.")
  facebookAppSecretSettingName?: string;

  @doc("""
The OAuth 2.0 scopes that will be requested as part of Facebook Login authentication.
This setting is optional.
Facebook Login documentation: https://developers.facebook.com/docs/facebook-login
""")
  facebookOAuthScopes?: string[];

  @doc("""
The Client Id of the GitHub app used for login.
This setting is required for enabling Github login
""")
  gitHubClientId?: string;

  @doc("""
The Client Secret of the GitHub app used for Github Login.
This setting is required for enabling Github login.
""")
  gitHubClientSecret?: string;

  @doc("""
The app setting name that contains the client secret of the Github
app used for GitHub Login.
""")
  gitHubClientSecretSettingName?: string;

  @doc("""
The OAuth 2.0 scopes that will be requested as part of GitHub Login authentication.
This setting is optional
""")
  gitHubOAuthScopes?: string[];

  @doc("""
The OAuth 1.0a consumer key of the Twitter application used for sign-in.
This setting is required for enabling Twitter Sign-In.
Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
""")
  twitterConsumerKey?: string;

  @doc("""
The OAuth 1.0a consumer secret of the Twitter application used for sign-in.
This setting is required for enabling Twitter Sign-In.
Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
""")
  twitterConsumerSecret?: string;

  @doc("""
The app setting name that contains the OAuth 1.0a consumer secret of the Twitter
application used for sign-in.
""")
  twitterConsumerSecretSettingName?: string;

  @doc("""
The OAuth 2.0 client ID that was created for the app used for authentication.
This setting is required for enabling Microsoft Account authentication.
Microsoft Account OAuth documentation: https://dev.onedrive.com/auth/msa_oauth.htm
""")
  microsoftAccountClientId?: string;

  @doc("""
The OAuth 2.0 client secret that was created for the app used for authentication.
This setting is required for enabling Microsoft Account authentication.
Microsoft Account OAuth documentation: https://dev.onedrive.com/auth/msa_oauth.htm
""")
  microsoftAccountClientSecret?: string;

  @doc("""
The app setting name containing the OAuth 2.0 client secret that was created for the
app used for authentication.
""")
  microsoftAccountClientSecretSettingName?: string;

  @doc("""
The OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication.
This setting is optional. If not specified, \"wl.basic\" is used as the default scope.
Microsoft Account Scopes and permissions documentation: https://msdn.microsoft.com/en-us/library/dn631845.aspx
""")
  microsoftAccountOAuthScopes?: string[];

  @doc("""
\"true\" if the auth config settings should be read from a file,
\"false\" otherwise
""")
  isAuthFromFile?: string;

  @doc("""
The path of the config file containing auth settings.
If the path is relative, base will the site's root directory.
""")
  authFilePath?: string;

  @doc("""
The ConfigVersion of the Authentication / Authorization feature in use for the current app.
The setting in this value can control the behavior of the control plane for Authentication / Authorization.
""")
  configVersion?: string;
}

@doc("Configuration settings for the Azure App Service Authentication / Authorization V2 feature.")
model SiteAuthSettingsV2 {
  ...ProxyOnlyResource;

  @doc("SiteAuthSettingsV2 resource specific properties")
  properties?: SiteAuthSettingsV2Properties;
}

@doc("SiteAuthSettingsV2 resource specific properties")
model SiteAuthSettingsV2Properties {
  @doc("The configuration settings of the platform of App Service Authentication/Authorization.")
  platform?: AuthPlatform;

  @doc("The configuration settings that determines the validation flow of users using App Service Authentication/Authorization.")
  globalValidation?: GlobalValidation;

  @doc("The configuration settings of each of the identity providers used to configure App Service Authentication/Authorization.")
  identityProviders?: IdentityProviders;

  @doc("The configuration settings of the login flow of users using App Service Authentication/Authorization.")
  login?: Login;

  @doc("The configuration settings of the HTTP requests for authentication and authorization requests made against App Service Authentication/Authorization.")
  httpSettings?: HttpSettings;
}

@doc("The configuration settings of the platform of App Service Authentication/Authorization.")
model AuthPlatform {
  @doc("<code>true</code> if the Authentication / Authorization feature is enabled for the current app; otherwise, <code>false</code>.")
  enabled?: boolean;

  @doc("""
The RuntimeVersion of the Authentication / Authorization feature in use for the current app.
The setting in this value can control the behavior of certain features in the Authentication / Authorization module.
""")
  runtimeVersion?: string;

  @doc("""
The path of the config file containing auth settings if they come from a file.
If the path is relative, base will the site's root directory.
""")
  configFilePath?: string;
}

@doc("The configuration settings that determines the validation flow of users using App Service Authentication/Authorization.")
model GlobalValidation {
  @doc("<code>true</code> if the authentication flow is required any request is made; otherwise, <code>false</code>.")
  requireAuthentication?: boolean;

  @doc("The action to take when an unauthenticated client attempts to access the app.")
  unauthenticatedClientAction?: UnauthenticatedClientActionV2;

  @doc("""
The default authentication provider to use when multiple providers are configured.
This setting is only needed if multiple providers are configured and the unauthenticated client
action is set to \"RedirectToLoginPage\".
""")
  redirectToProvider?: string;

  @doc("The paths for which unauthenticated flow would not be redirected to the login page.")
  excludedPaths?: string[];
}

@doc("The configuration settings of each of the identity providers used to configure App Service Authentication/Authorization.")
model IdentityProviders {
  @doc("The configuration settings of the Azure Active directory provider.")
  azureActiveDirectory?: AzureActiveDirectory;

  @doc("The configuration settings of the Facebook provider.")
  facebook?: Facebook;

  @doc("The configuration settings of the GitHub provider.")
  gitHub?: GitHub;

  @doc("The configuration settings of the Google provider.")
  google?: Google;

  @doc("The configuration settings of the legacy Microsoft Account provider.")
  legacyMicrosoftAccount?: LegacyMicrosoftAccount;

  @doc("The configuration settings of the Twitter provider.")
  twitter?: Twitter;

  @doc("The configuration settings of the Apple provider.")
  apple?: Apple;

  @doc("The configuration settings of the Azure Static Web Apps provider.")
  azureStaticWebApps?: AzureStaticWebApps;

  @doc("""
The map of the name of the alias of each custom Open ID Connect provider to the
configuration settings of the custom Open ID Connect provider.
""")
  customOpenIdConnectProviders?: Record<CustomOpenIdConnectProvider>;
}

@doc("The configuration settings of the Azure Active directory provider.")
model AzureActiveDirectory {
  @doc("<code>false</code> if the Azure Active Directory provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the Azure Active Directory app registration.")
  registration?: AzureActiveDirectoryRegistration;

  @doc("The configuration settings of the Azure Active Directory login flow.")
  login?: AzureActiveDirectoryLogin;

  @doc("The configuration settings of the Azure Active Directory token validation flow.")
  validation?: AzureActiveDirectoryValidation;

  @doc("""
Gets a value indicating whether the Azure AD configuration was auto-provisioned using 1st party tooling.
This is an internal flag primarily intended to support the Azure Management Portal. Users should not
read or write to this property.
""")
  isAutoProvisioned?: boolean;
}

@doc("The configuration settings of the Azure Active Directory app registration.")
model AzureActiveDirectoryRegistration {
  @doc("""
The OpenID Connect Issuer URI that represents the entity which issues access tokens for this application.
When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://login.microsoftonline.com/v2.0/{tenant-guid}/.
This URI is a case-sensitive identifier for the token issuer.
More information on OpenID Connect Discovery: http://openid.net/specs/openid-connect-discovery-1_0.html
""")
  openIdIssuer?: string;

  @doc("""
The Client ID of this relying party application, known as the client_id.
This setting is required for enabling OpenID Connection authentication with Azure Active Directory or 
other 3rd party OpenID Connect providers.
More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
""")
  clientId?: string;

  @doc("The app setting name that contains the client secret of the relying party application.")
  clientSecretSettingName?: string;

  @doc("""
An alternative to the client secret, that is the thumbprint of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret. It is also optional.
""")
  clientSecretCertificateThumbprint?: string;

  @doc("""
An alternative to the client secret thumbprint, that is the subject alternative name of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret Certificate Thumbprint. It is also optional.
""")
  clientSecretCertificateSubjectAlternativeName?: string;

  @doc("""
An alternative to the client secret thumbprint, that is the issuer of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret Certificate Thumbprint. It is also optional.
""")
  clientSecretCertificateIssuer?: string;
}

@doc("The configuration settings of the Azure Active Directory login flow.")
model AzureActiveDirectoryLogin {
  @doc("""
Login parameters to send to the OpenID Connect authorization endpoint when
a user logs in. Each parameter must be in the form \"key=value\".
""")
  loginParameters?: string[];

  @doc("<code>true</code> if the www-authenticate provider should be omitted from the request; otherwise, <code>false</code>.")
  disableWWWAuthenticate?: boolean;
}

@doc("The configuration settings of the Azure Active Directory token validation flow.")
model AzureActiveDirectoryValidation {
  @doc("The configuration settings of the checks that should be made while validating the JWT Claims.")
  jwtClaimChecks?: JwtClaimChecks;

  @doc("The list of audiences that can make successful authentication/authorization requests.")
  allowedAudiences?: string[];

  @doc("The configuration settings of the default authorization policy.")
  defaultAuthorizationPolicy?: DefaultAuthorizationPolicy;
}

@doc("The configuration settings of the checks that should be made while validating the JWT Claims.")
model JwtClaimChecks {
  @doc("The list of the allowed groups.")
  allowedGroups?: string[];

  @doc("The list of the allowed client applications.")
  allowedClientApplications?: string[];
}

@doc("The configuration settings of the Azure Active Directory default authorization policy.")
model DefaultAuthorizationPolicy {
  @doc("The configuration settings of the Azure Active Directory allowed principals.")
  allowedPrincipals?: AllowedPrincipals;

  @doc("The configuration settings of the Azure Active Directory allowed applications.")
  allowedApplications?: string[];
}

@doc("The configuration settings of the Azure Active Directory allowed principals.")
model AllowedPrincipals {
  @doc("The list of the allowed groups.")
  groups?: string[];

  @doc("The list of the allowed identities.")
  identities?: string[];
}

@doc("The configuration settings of the Facebook provider.")
model Facebook {
  @doc("<code>false</code> if the Facebook provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the app registration for the Facebook provider.")
  registration?: AppRegistration;

  @doc("The version of the Facebook api to be used while logging in.")
  graphApiVersion?: string;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;
}

@doc("The configuration settings of the app registration for providers that have app ids and app secrets")
model AppRegistration {
  @doc("The App ID of the app used for login.")
  appId?: string;

  @doc("The app setting name that contains the app secret.")
  appSecretSettingName?: string;
}

@doc("The configuration settings of the login flow, including the scopes that should be requested.")
model LoginScopes {
  @doc("A list of the scopes that should be requested while authenticating.")
  scopes?: string[];
}

@doc("The configuration settings of the GitHub provider.")
model GitHub {
  @doc("<code>false</code> if the GitHub provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the app registration for the GitHub provider.")
  registration?: ClientRegistration;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;
}

@doc("The configuration settings of the app registration for providers that have client ids and client secrets")
model ClientRegistration {
  @doc("The Client ID of the app used for login.")
  clientId?: string;

  @doc("The app setting name that contains the client secret.")
  clientSecretSettingName?: string;
}

@doc("The configuration settings of the Google provider.")
model Google {
  @doc("<code>false</code> if the Google provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the app registration for the Google provider.")
  registration?: ClientRegistration;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;

  @doc("The configuration settings of the Azure Active Directory token validation flow.")
  validation?: AllowedAudiencesValidation;
}

@doc("The configuration settings of the Allowed Audiences validation flow.")
model AllowedAudiencesValidation {
  @doc("The configuration settings of the allowed list of audiences from which to validate the JWT token.")
  allowedAudiences?: string[];
}

@doc("The configuration settings of the legacy Microsoft Account provider.")
model LegacyMicrosoftAccount {
  @doc("<code>false</code> if the legacy Microsoft Account provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the app registration for the legacy Microsoft Account provider.")
  registration?: ClientRegistration;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;

  @doc("The configuration settings of the legacy Microsoft Account provider token validation flow.")
  validation?: AllowedAudiencesValidation;
}

@doc("The configuration settings of the Twitter provider.")
model Twitter {
  @doc("<code>false</code> if the Twitter provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the app registration for the Twitter provider.")
  registration?: TwitterRegistration;
}

@doc("The configuration settings of the app registration for the Twitter provider.")
model TwitterRegistration {
  @doc("""
The OAuth 1.0a consumer key of the Twitter application used for sign-in.
This setting is required for enabling Twitter Sign-In.
Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
""")
  consumerKey?: string;

  @doc("""
The app setting name that contains the OAuth 1.0a consumer secret of the Twitter
application used for sign-in.
""")
  consumerSecretSettingName?: string;
}

@doc("The configuration settings of the Apple provider.")
model Apple {
  @doc("<code>false</code> if the Apple provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the Apple registration.")
  registration?: AppleRegistration;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;
}

@doc("The configuration settings of the registration for the Apple provider")
model AppleRegistration {
  @doc("The Client ID of the app used for login.")
  clientId?: string;

  @doc("The app setting name that contains the client secret.")
  clientSecretSettingName?: string;
}

@doc("The configuration settings of the Azure Static Web Apps provider.")
model AzureStaticWebApps {
  @doc("<code>false</code> if the Azure Static Web Apps provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the Azure Static Web Apps registration.")
  registration?: AzureStaticWebAppsRegistration;
}

@doc("The configuration settings of the registration for the Azure Static Web Apps provider")
model AzureStaticWebAppsRegistration {
  @doc("The Client ID of the app used for login.")
  clientId?: string;
}

@doc("The configuration settings of the custom Open ID Connect provider.")
model CustomOpenIdConnectProvider {
  @doc("<code>false</code> if the custom Open ID provider provider should not be enabled; otherwise, <code>true</code>.")
  enabled?: boolean;

  @doc("The configuration settings of the app registration for the custom Open ID Connect provider.")
  registration?: OpenIdConnectRegistration;

  @doc("The configuration settings of the login flow of the custom Open ID Connect provider.")
  login?: OpenIdConnectLogin;
}

@doc("The configuration settings of the app registration for the custom Open ID Connect provider.")
model OpenIdConnectRegistration {
  @doc("The client id of the custom Open ID Connect provider.")
  clientId?: string;

  @doc("The authentication credentials of the custom Open ID Connect provider.")
  clientCredential?: OpenIdConnectClientCredential;

  @doc("The configuration settings of the endpoints used for the custom Open ID Connect provider.")
  openIdConnectConfiguration?: OpenIdConnectConfig;
}

@doc("The authentication client credentials of the custom Open ID Connect provider.")
model OpenIdConnectClientCredential {
  @doc("The method that should be used to authenticate the user.")
  method?: "ClientSecretPost";

  @doc("The app setting that contains the client secret for the custom Open ID Connect provider.")
  clientSecretSettingName?: string;
}

@doc("The configuration settings of the endpoints used for the custom Open ID Connect provider.")
model OpenIdConnectConfig {
  @doc("The endpoint to be used to make an authorization request.")
  authorizationEndpoint?: string;

  @doc("The endpoint to be used to request a token.")
  tokenEndpoint?: string;

  @doc("The endpoint that issues the token.")
  issuer?: string;

  @doc("The endpoint that provides the keys necessary to validate the token.")
  certificationUri?: string;

  @doc("The endpoint that contains all the configuration endpoints for the provider.")
  wellKnownOpenIdConfiguration?: string;
}

@doc("The configuration settings of the login flow of the custom Open ID Connect provider.")
model OpenIdConnectLogin {
  @doc("The name of the claim that contains the users name.")
  nameClaimType?: string;

  @doc("A list of the scopes that should be requested while authenticating.")
  scopes?: string[];
}

@doc("The configuration settings of the login flow of users using App Service Authentication/Authorization.")
model Login {
  @doc("The routes that specify the endpoints used for login and logout requests.")
  routes?: LoginRoutes;

  @doc("The configuration settings of the token store.")
  tokenStore?: TokenStore;

  @doc("<code>true</code> if the fragments from the request are preserved after the login request is made; otherwise, <code>false</code>.")
  preserveUrlFragmentsForLogins?: boolean;

  @doc("""
External URLs that can be redirected to as part of logging in or logging out of the app. Note that the query string part of the URL is ignored.
This is an advanced setting typically only needed by Windows Store application backends.
Note that URLs within the current domain are always implicitly allowed.
""")
  allowedExternalRedirectUrls?: string[];

  @doc("The configuration settings of the session cookie's expiration.")
  cookieExpiration?: CookieExpiration;

  @doc("The configuration settings of the nonce used in the login flow.")
  nonce?: Nonce;
}

@doc("The routes that specify the endpoints used for login and logout requests.")
model LoginRoutes {
  @doc("The endpoint at which a logout request should be made.")
  logoutEndpoint?: string;
}

@doc("The configuration settings of the token store.")
model TokenStore {
  @doc("""
<code>true</code> to durably store platform-specific security tokens that are obtained during login flows; otherwise, <code>false</code>.
 The default is <code>false</code>.
""")
  enabled?: boolean;

  @doc("""
The number of hours after session token expiration that a session token can be used to
call the token refresh API. The default is 72 hours.
""")
  tokenRefreshExtensionHours?: float32;

  @doc("The configuration settings of the storage of the tokens if a file system is used.")
  fileSystem?: FileSystemTokenStore;

  @doc("The configuration settings of the storage of the tokens if blob storage is used.")
  azureBlobStorage?: BlobStorageTokenStore;
}

@doc("The configuration settings of the storage of the tokens if a file system is used.")
model FileSystemTokenStore {
  @doc("The directory in which the tokens will be stored.")
  directory?: string;
}

@doc("The configuration settings of the storage of the tokens if blob storage is used.")
model BlobStorageTokenStore {
  @doc("The name of the app setting containing the SAS URL of the blob storage containing the tokens.")
  sasUrlSettingName?: string;
}

@doc("The configuration settings of the session cookie's expiration.")
model CookieExpiration {
  @doc("The convention used when determining the session cookie's expiration.")
  convention?: CookieExpirationConvention;

  @doc("The time after the request is made when the session cookie should expire.")
  timeToExpiration?: string;
}

@doc("The configuration settings of the nonce used in the login flow.")
model Nonce {
  @doc("<code>false</code> if the nonce should not be validated while completing the login flow; otherwise, <code>true</code>.")
  validateNonce?: boolean;

  @doc("The time after the request is made when the nonce should expire.")
  nonceExpirationInterval?: string;
}

@doc("The configuration settings of the HTTP requests for authentication and authorization requests made against App Service Authentication/Authorization.")
model HttpSettings {
  @doc("<code>false</code> if the authentication/authorization responses not having the HTTPS scheme are permissible; otherwise, <code>true</code>.")
  requireHttps?: boolean;

  @doc("The configuration settings of the paths HTTP requests.")
  routes?: HttpSettingsRoutes;

  @doc("The configuration settings of a forward proxy used to make the requests.")
  forwardProxy?: ForwardProxy;
}

@doc("The configuration settings of the paths HTTP requests.")
model HttpSettingsRoutes {
  @doc("The prefix that should precede all the authentication/authorization paths.")
  apiPrefix?: string;
}

@doc("The configuration settings of a forward proxy used to make the requests.")
model ForwardProxy {
  @doc("The convention used to determine the url of the request made.")
  convention?: ForwardProxyConvention;

  @doc("The name of the header containing the host of the request.")
  customHostHeaderName?: string;

  @doc("The name of the header containing the scheme of the request.")
  customProtoHeaderName?: string;
}

@doc("AzureStorageInfo dictionary resource.")
model AzureStoragePropertyDictionaryResource {
  ...ProxyOnlyResource;

  @doc("Azure storage accounts.")
  properties?: Record<AzureStorageInfoValue>;
}

@doc("ApiKVReference resource specific properties")
model ApiKVReferenceProperties {
  reference?: string;
  status?: ResolveStatus;
  vaultName?: string;
  secretName?: string;
  secretVersion?: string;

  @doc("Managed service identity.")
  identityType?: ManagedServiceIdentity;

  details?: string;
  source?: "KeyVault";
  activeVersion?: string;
}

@doc("String dictionary resource.")
model ConnectionStringDictionary {
  ...ProxyOnlyResource;

  @doc("Connection strings.")
  properties?: Record<ConnStringValueTypePair>;
}

@doc("Database connection string value to type pair.")
model ConnStringValueTypePair {
  @doc("Value of pair.")
  value: string;

  @doc("Type of database.")
  type: ConnectionStringType;
}

@doc("SiteLogsConfig resource specific properties")
model SiteLogsConfigProperties {
  @doc("Application logs configuration.")
  applicationLogs?: ApplicationLogsConfig;

  @doc("HTTP logs configuration.")
  httpLogs?: HttpLogsConfig;

  @doc("Failed requests tracing configuration.")
  failedRequestsTracing?: EnabledConfig;

  @doc("Detailed error messages configuration.")
  detailedErrorMessages?: EnabledConfig;
}

@doc("Application logs configuration.")
model ApplicationLogsConfig {
  @doc("Application logs to file system configuration.")
  fileSystem?: FileSystemApplicationLogsConfig;

  @doc("Application logs to azure table storage configuration.")
  azureTableStorage?: AzureTableStorageApplicationLogsConfig;

  @doc("Application logs to blob storage configuration.")
  azureBlobStorage?: AzureBlobStorageApplicationLogsConfig;
}

@doc("Application logs to file system configuration.")
model FileSystemApplicationLogsConfig {
  @doc("Log level.")
  level?: LogLevel;
}

@doc("Application logs to Azure table storage configuration.")
model AzureTableStorageApplicationLogsConfig {
  @doc("Log level.")
  level?: LogLevel;

  @doc("SAS URL to an Azure table with add/query/delete permissions.")
  sasUrl: string;
}

@doc("Application logs azure blob storage configuration.")
model AzureBlobStorageApplicationLogsConfig {
  @doc("Log level.")
  level?: LogLevel;

  @doc("SAS url to a azure blob container with read/write/list/delete permissions.")
  sasUrl?: string;

  @doc("""
Retention in days.
Remove blobs older than X days.
0 or lower means no retention.
""")
  retentionInDays?: int32;
}

@doc("Http logs configuration.")
model HttpLogsConfig {
  @doc("Http logs to file system configuration.")
  fileSystem?: FileSystemHttpLogsConfig;

  @doc("Http logs to azure blob storage configuration.")
  azureBlobStorage?: AzureBlobStorageHttpLogsConfig;
}

@doc("Http logs to file system configuration.")
model FileSystemHttpLogsConfig {
  @doc("""
Maximum size in megabytes that http log files can use.
When reached old log files will be removed to make space for new ones.
Value can range between 25 and 100.
""")
  @maxValue(100)
  @minValue(25)
  retentionInMb?: int32;

  @doc("""
Retention in days.
Remove files older than X days.
0 or lower means no retention.
""")
  retentionInDays?: int32;

  @doc("True if configuration is enabled, false if it is disabled and null if configuration is not set.")
  enabled?: boolean;
}

@doc("Http logs to azure blob storage configuration.")
model AzureBlobStorageHttpLogsConfig {
  @doc("SAS url to a azure blob container with read/write/list/delete permissions.")
  sasUrl?: string;

  @doc("""
Retention in days.
Remove blobs older than X days.
0 or lower means no retention.
""")
  retentionInDays?: int32;

  @doc("True if configuration is enabled, false if it is disabled and null if configuration is not set.")
  enabled?: boolean;
}

@doc("Enabled configuration.")
model EnabledConfig {
  @doc("True if configuration is enabled, false if it is disabled and null if configuration is not set.")
  enabled?: boolean;
}

@doc("""
Names for connection strings, application settings, and external Azure storage account configuration
identifiers to be marked as sticky to the deployment slot and not moved during a swap operation.
This is valid for all deployment slots in an app.
""")
model SlotConfigNames {
  @doc("List of connection string names.")
  connectionStringNames?: string[];

  @doc("List of application settings names.")
  appSettingNames?: string[];

  @doc("List of external Azure storage account identifiers.")
  azureStorageConfigNames?: string[];
}

@doc("Collection of metadata for the app configuration snapshots that can be restored.")
model SiteConfigurationSnapshotInfoCollection
  is Azure.Core.Page<SiteConfigurationSnapshotInfo>;

@doc("A snapshot of a web app configuration.")
model SiteConfigurationSnapshotInfo {
  ...ProxyOnlyResource;

  @doc("SiteConfigurationSnapshotInfo resource specific properties")
  properties?: SiteConfigurationSnapshotInfoProperties;
}

@doc("SiteConfigurationSnapshotInfo resource specific properties")
model SiteConfigurationSnapshotInfoProperties {
  @doc("The time the snapshot was taken.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  @doc("The id of the snapshot")
  @visibility("read")
  snapshotId?: int32;
}

@doc("ContinuousWebJob resource specific properties")
model ContinuousWebJobProperties {
  @doc("Job status.")
  status?: ContinuousWebJobStatus;

  @doc("Detailed status.")
  @projectedName("json", "detailed_status")
  detailedStatus?: string;

  @doc("Log URL.")
  @projectedName("json", "log_url")
  logUrl?: string;

  @doc("Run command.")
  @projectedName("json", "run_command")
  runCommand?: string;

  @doc("Job URL.")
  url?: string;

  @doc("Extra Info URL.")
  @projectedName("json", "extra_info_url")
  extraInfoUrl?: string;

  @doc("Job type.")
  @projectedName("json", "web_job_type")
  webJobType?: WebJobType;

  @doc("Error information.")
  error?: string;

  @doc("Using SDK?")
  @projectedName("json", "using_sdk")
  usingSdk?: boolean;

  @doc("Job settings.")
  settings?: Record<Record<unknown>>;
}

@doc("Deployment resource specific properties")
model DeploymentProperties {
  @doc("Deployment status.")
  status?: int32;

  @doc("Details about deployment status.")
  message?: string;

  @doc("Who authored the deployment.")
  author?: string;

  @doc("Who performed the deployment.")
  deployer?: string;

  @doc("Author email.")
  @projectedName("json", "author_email")
  authorEmail?: string;

  @doc("Start time.")
  @projectedName("json", "start_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time.")
  @projectedName("json", "end_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("True if deployment is currently active, false if completed and null if not started.")
  active?: boolean;

  @doc("Details on deployment.")
  details?: string;
}

@doc("MSDeployStatus resource specific properties")
model MSDeployStatusProperties {
  @doc("Username of deployer")
  @visibility("read")
  deployer?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: MSDeployProvisioningState;

  @doc("Start time of deploy operation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of deploy operation")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Whether the deployment operation has completed")
  @visibility("read")
  complete?: boolean;
}

@doc("MSDeploy ARM PUT information")
model MSDeploy {
  ...ProxyOnlyResource;

  @doc("Core resource properties")
  properties?: MSDeployCore;
}

@doc("MSDeploy ARM PUT core information")
model MSDeployCore {
  @doc("Package URI")
  packageUri?: string;

  @doc("SQL Connection String")
  connectionString?: string;

  @doc("Database Type")
  dbType?: string;

  @doc("URI of MSDeploy Parameters file. Must not be set if SetParameters is used.")
  setParametersXmlFileUri?: string;

  @doc("MSDeploy Parameters. Must not be set if SetParametersXmlFileUri is used.")
  setParameters?: Record<string>;

  @doc("""
Controls whether the MSDeploy operation skips the App_Data directory.
If set to <code>true</code>, the existing App_Data directory on the destination
will not be deleted, and any App_Data directory in the source will be ignored.
Setting is <code>false</code> by default.
""")
  skipAppData?: boolean;

  @doc("""
Sets the AppOffline rule while the MSDeploy operation executes.
Setting is <code>false</code> by default.
""")
  appOffline?: boolean;
}

@doc("MSDeploy log")
model MSDeployLog {
  ...ProxyOnlyResource;

  @doc("MSDeployLog resource specific properties")
  properties?: MSDeployLogProperties;
}

@doc("MSDeployLog resource specific properties")
model MSDeployLogProperties {
  @doc("List of log entry messages")
  @visibility("read")
  entries?: MSDeployLogEntry[];
}

@doc("MSDeploy log entry")
model MSDeployLogEntry {
  @doc("Timestamp of log entry")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  @doc("Log entry type")
  @visibility("read")
  type?: MSDeployLogEntryType;

  @doc("Log entry message")
  @visibility("read")
  message?: string;
}

@doc("FunctionEnvelope resource specific properties")
model FunctionEnvelopeProperties {
  @doc("Function App ID.")
  @projectedName("json", "function_app_id")
  functionAppId?: string;

  @doc("Script root path URI.")
  @projectedName("json", "script_root_path_href")
  scriptRootPathHref?: string;

  @doc("Script URI.")
  @projectedName("json", "script_href")
  scriptHref?: string;

  @doc("Config URI.")
  @projectedName("json", "config_href")
  configHref?: string;

  @doc("Test data URI.")
  @projectedName("json", "test_data_href")
  testDataHref?: string;

  @doc("Secrets file URI.")
  @projectedName("json", "secrets_file_href")
  secretsFileHref?: string;

  @doc("Function URI.")
  href?: string;

  @doc("Config information.")
  config?: Record<unknown>;

  @doc("File list.")
  files?: Record<string>;

  @doc("Test data used when testing via the Azure Portal.")
  @projectedName("json", "test_data")
  testData?: string;

  @doc("The invocation URL")
  @projectedName("json", "invoke_url_template")
  invokeUrlTemplate?: string;

  @doc("The function language")
  language?: string;

  @doc("Gets or sets a value indicating whether the function is disabled")
  isDisabled?: boolean;
}

@doc("Function key info.")
model KeyInfo {
  @doc("Properties of function key info.")
  properties?: KeyInfoProperties;
}

@doc("Properties of function key info.")
model KeyInfoProperties {
  @doc("Key name")
  name?: string;

  @doc("Key value")
  value?: string;
}

@doc("Function secrets.")
model FunctionSecrets {
  @doc("Secret key.")
  key?: string;

  @doc("Trigger URL.")
  @projectedName("json", "trigger_url")
  triggerUrl?: string;
}

@doc("Functions host level keys.")
model HostKeys {
  @doc("Secret key.")
  masterKey?: string;

  @doc("Host level function keys.")
  functionKeys?: Record<string>;

  @doc("System keys.")
  systemKeys?: Record<string>;
}

@doc("HostNameBinding resource specific properties")
model HostNameBindingProperties {
  @doc("App Service app name.")
  @visibility("read", "create")
  siteName?: string;

  @doc("Fully qualified ARM domain resource URI.")
  @visibility("read", "create")
  domainId?: string;

  @doc("Azure resource name.")
  @visibility("read", "create")
  azureResourceName?: string;

  @doc("Azure resource type.")
  @visibility("read", "create")
  azureResourceType?: AzureResourceType;

  @doc("Custom DNS record type.")
  @visibility("read", "create")
  customHostNameDnsRecordType?: CustomHostNameDnsRecordType;

  @doc("Hostname type.")
  @visibility("read", "create")
  hostNameType?: HostNameType;

  @doc("SSL type")
  @visibility("read", "create")
  sslState?: SslState;

  @doc("SSL certificate thumbprint")
  @visibility("read", "create")
  thumbprint?: string;

  @doc("Virtual IP address assigned to the hostname if IP based SSL is enabled.")
  @visibility("read")
  virtualIP?: string;
}

@doc("RelayServiceConnectionEntity resource specific properties")
model RelayServiceConnectionEntityProperties {
  entityName?: string;
  entityConnectionString?: string;
  resourceType?: string;
  resourceConnectionString?: string;
  hostname?: string;
  port?: int32;
  biztalkUri?: string;
}

@doc("WebSiteInstanceStatus resource specific properties")
model WebSiteInstanceStatusProperties {
  state?: SiteRuntimeState;

  @doc("Link to the GetStatusApi in Kudu")
  statusUrl?: string;

  @doc("Link to the Diagnose and Solve Portal")
  detectorUrl?: string;

  @doc("Link to the console to web app instance")
  consoleUrl?: string;

  @doc("Link to the console to web app instance")
  healthCheckUrl?: string;

  @doc("Dictionary of <ContainerInfo>")
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
  systemCpuUsage?: int32;
  onlineCpuCount?: int32;
  throttlingData?: ContainerThrottlingData;
}

model ContainerCpuUsage {
  totalUsage?: int32;
  perCpuUsage?: int32[];
  kernelModeUsage?: int32;
  userModeUsage?: int32;
}

model ContainerThrottlingData {
  periods?: int32;
  throttledPeriods?: int32;
  throttledTime?: int32;
}

model ContainerMemoryStatistics {
  usage?: int32;
  maxUsage?: int32;
  limit?: int32;
}

model ContainerNetworkInterfaceStatistics {
  rxBytes?: int32;
  rxPackets?: int32;
  rxErrors?: int32;
  rxDropped?: int32;
  txBytes?: int32;
  txPackets?: int32;
  txErrors?: int32;
  txDropped?: int32;
}

@doc("ProcessInfo resource specific properties")
model ProcessInfoProperties {
  @doc("ARM Identifier for deployment.")
  @visibility("read")
  identifier?: int32;

  @doc("Deployment name.")
  @projectedName("json", "deployment_name")
  deploymentName?: string;

  @doc("HRef URI.")
  href?: string;

  @doc("Minidump URI.")
  minidump?: string;

  @doc("Is profile running?")
  @projectedName("json", "is_profile_running")
  isProfileRunning?: boolean;

  @doc("Is the IIS Profile running?")
  @projectedName("json", "is_iis_profile_running")
  isIisProfileRunning?: boolean;

  @doc("IIS Profile timeout (seconds).")
  @projectedName("json", "iis_profile_timeout_in_seconds")
  iisProfileTimeoutInSeconds?: float32;

  @doc("Parent process.")
  parent?: string;

  @doc("Child process list.")
  children?: string[];

  @doc("Thread list.")
  threads?: ProcessThreadInfo[];

  @doc("List of open files.")
  @projectedName("json", "open_file_handles")
  openFileHandles?: string[];

  @doc("List of modules.")
  modules?: ProcessModuleInfo[];

  @doc("File name of this process.")
  @projectedName("json", "file_name")
  fileName?: string;

  @doc("Command line.")
  @projectedName("json", "command_line")
  commandLine?: string;

  @doc("User name.")
  @projectedName("json", "user_name")
  userName?: string;

  @doc("Handle count.")
  @projectedName("json", "handle_count")
  handleCount?: int32;

  @doc("Module count.")
  @projectedName("json", "module_count")
  moduleCount?: int32;

  @doc("Thread count.")
  @projectedName("json", "thread_count")
  threadCount?: int32;

  @doc("Start time.")
  @projectedName("json", "start_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Total CPU time.")
  @projectedName("json", "total_cpu_time")
  totalCpuTime?: string;

  @doc("User CPU time.")
  @projectedName("json", "user_cpu_time")
  userCpuTime?: string;

  @doc("Privileged CPU time.")
  @projectedName("json", "privileged_cpu_time")
  privilegedCpuTime?: string;

  @doc("Working set.")
  @projectedName("json", "working_set")
  workingSet?: int32;

  @doc("Peak working set.")
  @projectedName("json", "peak_working_set")
  peakWorkingSet?: int32;

  @doc("Private memory size.")
  @projectedName("json", "private_memory")
  privateMemory?: int32;

  @doc("Virtual memory size.")
  @projectedName("json", "virtual_memory")
  virtualMemory?: int32;

  @doc("Peak virtual memory usage.")
  @projectedName("json", "peak_virtual_memory")
  peakVirtualMemory?: int32;

  @doc("Paged system memory.")
  @projectedName("json", "paged_system_memory")
  pagedSystemMemory?: int32;

  @doc("Non-paged system memory.")
  @projectedName("json", "non_paged_system_memory")
  nonPagedSystemMemory?: int32;

  @doc("Paged memory.")
  @projectedName("json", "paged_memory")
  pagedMemory?: int32;

  @doc("Peak paged memory.")
  @projectedName("json", "peak_paged_memory")
  peakPagedMemory?: int32;

  @doc("Time stamp.")
  @projectedName("json", "time_stamp")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;

  @doc("List of environment variables.")
  @projectedName("json", "environment_variables")
  environmentVariables?: Record<string>;

  @doc("Is this the SCM site?")
  @projectedName("json", "is_scm_site")
  isScmSite?: boolean;

  @doc("Is this a Web Job?")
  @projectedName("json", "is_webjob")
  isWebjob?: boolean;

  @doc("Description of process.")
  description?: string;
}

@doc("Process Thread Information.")
model ProcessThreadInfo {
  ...ProxyOnlyResource;

  @doc("ProcessThreadInfo resource specific properties")
  properties?: ProcessThreadInfoProperties;
}

@doc("ProcessThreadInfo resource specific properties")
model ProcessThreadInfoProperties {
  @doc("Site extension ID.")
  @visibility("read")
  identifier?: int32;

  @doc("HRef URI.")
  href?: string;

  @doc("Process URI.")
  process?: string;

  @doc("Start address.")
  @projectedName("json", "start_address")
  startAddress?: string;

  @doc("Current thread priority.")
  @projectedName("json", "current_priority")
  currentPriority?: int32;

  @doc("Thread priority level.")
  @projectedName("json", "priority_level")
  priorityLevel?: string;

  @doc("Base priority.")
  @projectedName("json", "base_priority")
  basePriority?: int32;

  @doc("Start time.")
  @projectedName("json", "start_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Total processor time.")
  @projectedName("json", "total_processor_time")
  totalProcessorTime?: string;

  @doc("User processor time.")
  @projectedName("json", "user_processor_time")
  userProcessorTime?: string;

  @doc("Thread state.")
  state?: string;

  @doc("Wait reason.")
  @projectedName("json", "wait_reason")
  waitReason?: string;
}

@doc("ProcessModuleInfo resource specific properties")
model ProcessModuleInfoProperties {
  @doc("Base address. Used as module identifier in ARM resource URI.")
  @projectedName("json", "base_address")
  baseAddress?: string;

  @doc("File name.")
  @projectedName("json", "file_name")
  fileName?: string;

  @doc("HRef URI.")
  href?: string;

  @doc("File path.")
  @projectedName("json", "file_path")
  filePath?: string;

  @doc("Module memory size.")
  @projectedName("json", "module_memory_size")
  moduleMemorySize?: int32;

  @doc("File version.")
  @projectedName("json", "file_version")
  fileVersion?: string;

  @doc("File description.")
  @projectedName("json", "file_description")
  fileDescription?: string;

  @doc("Product name.")
  product?: string;

  @doc("Product version.")
  @projectedName("json", "product_version")
  productVersion?: string;

  @doc("Is debug?")
  @projectedName("json", "is_debug")
  isDebug?: boolean;

  @doc("Module language (locale).")
  language?: string;
}

@doc("Collection of Kudu thread information elements.")
model ProcessThreadInfoCollection is Azure.Core.Page<ProcessThreadInfo>;

@doc("Represents whether or not an app is cloneable.")
model SiteCloneability {
  @doc("Name of app.")
  result?: CloneAbilityResult;

  @doc("List of features enabled on app that prevent cloning.")
  blockingFeatures?: SiteCloneabilityCriterion[];

  @doc("""
List of features enabled on app that are non-blocking but cannot be cloned. The app can still be cloned
but the features in this list will not be set up on cloned app.
""")
  unsupportedFeatures?: SiteCloneabilityCriterion[];

  @doc("List of blocking application characteristics.")
  blockingCharacteristics?: SiteCloneabilityCriterion[];
}

@doc("An app cloneability criterion.")
model SiteCloneabilityCriterion {
  @doc("Name of criterion.")
  name?: string;

  @doc("Description of criterion.")
  description?: string;
}

@doc("Options for app content migration.")
model StorageMigrationOptions {
  ...ProxyOnlyResource;

  @doc("StorageMigrationOptions resource specific properties")
  properties?: StorageMigrationOptionsProperties;
}

@doc("StorageMigrationOptions resource specific properties")
model StorageMigrationOptionsProperties {
  @doc("AzureFiles connection string.")
  @visibility("create")
  azurefilesConnectionString: string;

  @doc("AzureFiles share.")
  @visibility("create")
  azurefilesShare: string;

  @doc("<code>true</code>if the app should be switched over; otherwise, <code>false</code>.")
  @visibility("create")
  switchSiteAfterMigration?: boolean;

  @doc("<code>true</code> if the app should be read only during copy operation; otherwise, <code>false</code>.")
  @visibility("create")
  blockWriteAccessToSite?: boolean;
}

@doc("Response for a migration of app content request.")
model StorageMigrationResponse {
  ...ProxyOnlyResource;

  @doc("StorageMigrationResponse resource specific properties")
  properties?: StorageMigrationResponseProperties;
}

@doc("StorageMigrationResponse resource specific properties")
model StorageMigrationResponseProperties {
  @doc("When server starts the migration process, it will return an operation ID identifying that particular migration operation.")
  @visibility("read")
  operationId?: string;
}

@doc("MySQL migration request.")
model MigrateMySqlRequest {
  ...ProxyOnlyResource;

  @doc("MigrateMySqlRequest resource specific properties")
  properties?: MigrateMySqlRequestProperties;
}

@doc("MigrateMySqlRequest resource specific properties")
model MigrateMySqlRequestProperties {
  @doc("Connection string to the remote MySQL database.")
  connectionString: string;

  @doc("The type of migration operation to be done")
  migrationType: MySqlMigrationType;
}

@doc("MigrateMySqlStatus resource specific properties")
model MigrateMySqlStatusProperties {
  @doc("Status of the migration task.")
  @visibility("read")
  migrationOperationStatus?: OperationStatus;

  @doc("Operation ID for the migration task.")
  @visibility("read")
  operationId?: string;

  @doc("True if the web app has in app MySql enabled")
  @visibility("read")
  localMySqlEnabled?: boolean;
}

@doc("SwiftVirtualNetwork resource specific properties")
model SwiftVirtualNetworkProperties {
  @doc("The Virtual Network subnet's resource ID. This is the subnet that this Web App will join. This subnet must have a delegation to Microsoft.Web/serverFarms defined first.")
  subnetResourceId?: string;

  @doc("A flag that specifies if the scale unit this Web App is on supports Swift integration.")
  swiftSupported?: boolean;
}

@doc("NetworkFeatures resource specific properties")
model NetworkFeaturesProperties {
  @doc("The Virtual Network name.")
  @visibility("read")
  virtualNetworkName?: string;

  @doc("The Virtual Network summary view.")
  @visibility("read")
  virtualNetworkConnection?: VnetInfo;

  @doc("The Hybrid Connections summary view.")
  @visibility("read")
  hybridConnections?: RelayServiceConnectionEntity[];

  @doc("The Hybrid Connection V2 (Service Bus) view.")
  @visibility("read")
  hybridConnectionsV2?: HybridConnection[];
}

@doc("Network trace")
model NetworkTrace {
  @doc("Local file path for the captured network trace file.")
  path?: string;

  @doc("Current status of the network trace operation, same as Operation.Status (InProgress/Succeeded/Failed).")
  status?: string;

  @doc("Detailed message of a network trace operation, e.g. error message in case of failure.")
  message?: string;
}

@doc("Collection of performance monitor counters.")
model PerfMonCounterCollection is Azure.Core.Page<PerfMonResponse>;

@doc("Performance monitor API response.")
model PerfMonResponse {
  @doc("The response code.")
  code?: string;

  @doc("The message.")
  message?: string;

  @doc("The performance monitor counters.")
  data?: PerfMonSet;
}

@doc("Metric information.")
model PerfMonSet {
  @doc("Unique key name of the counter.")
  name?: string;

  @doc("Start time of the period.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the period.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Presented time grain.")
  timeGrain?: string;

  @doc("Collection of workers that are active during this time.")
  values?: PerfMonSample[];
}

@doc("Performance monitor sample in a set.")
model PerfMonSample {
  @doc("Point in time for which counter was measured.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  @doc("Name of the server on which the measurement is made.")
  instanceName?: string;

  @doc("Value of counter at a certain time.")
  value?: float32;
}

@doc("Used for getting PHP error logging flag.")
model SitePhpErrorLogFlag {
  ...ProxyOnlyResource;

  @doc("SitePhpErrorLogFlag resource specific properties")
  properties?: SitePhpErrorLogFlagProperties;
}

@doc("SitePhpErrorLogFlag resource specific properties")
model SitePhpErrorLogFlagProperties {
  @doc("Local log_errors setting.")
  localLogErrors?: string;

  @doc("Master log_errors setting.")
  masterLogErrors?: string;

  @doc("Local log_errors_max_len setting.")
  localLogErrorsMaxLength?: string;

  @doc("Master log_errors_max_len setting.")
  masterLogErrorsMaxLength?: string;
}

@doc("PremierAddOn resource specific properties")
model PremierAddOnProperties {
  @doc("Premier add on SKU.")
  sku?: string;

  @doc("Premier add on Product.")
  product?: string;

  @doc("Premier add on Vendor.")
  vendor?: string;

  @doc("Premier add on Marketplace publisher.")
  marketplacePublisher?: string;

  @doc("Premier add on Marketplace offer.")
  marketplaceOffer?: string;
}

@doc("PrivateAccess resource specific properties")
model PrivateAccessProperties {
  @doc("Whether private access is enabled or not.")
  enabled?: boolean;

  @doc("The Virtual Networks (and subnets) allowed to access the site privately.")
  virtualNetworks?: PrivateAccessVirtualNetwork[];
}

@doc("Description of a Virtual Network that is useable for private site access.")
model PrivateAccessVirtualNetwork {
  @doc("The name of the Virtual Network.")
  name?: string;

  @doc("The key (ID) of the Virtual Network.")
  key?: int32;

  @doc("The ARM uri of the Virtual Network")
  resourceId?: string;

  @doc("A List of subnets that access is allowed to on this Virtual Network. An empty array (but not null) is interpreted to mean that all subnets are allowed within this Virtual Network.")
  subnets?: PrivateAccessSubnet[];
}

@doc("Description of a Virtual Network subnet that is useable for private site access.")
model PrivateAccessSubnet {
  @doc("The name of the subnet.")
  name?: string;

  @doc("The key (ID) of the subnet.")
  key?: int32;
}

@doc("PublicCertificate resource specific properties")
model PublicCertificateProperties {
  @doc("Public Certificate byte array")
  blob?: bytes;

  @doc("Public Certificate Location")
  publicCertificateLocation?: PublicCertificateLocation;

  @doc("Certificate Thumbprint")
  @visibility("read")
  thumbprint?: string;
}

@doc("Publishing options for requested profile.")
model CsmPublishingProfileOptions {
  @doc("""
Name of the format. Valid values are: 
FileZilla3
WebDeploy -- default
Ftp
""")
  format?: PublishingProfileFormat;

  @doc("Include the DisasterRecover endpoint if true")
  includeDisasterRecoveryEndpoints?: boolean;
}

@doc("Details about restoring a deleted app.")
model DeletedAppRestoreRequest {
  ...ProxyOnlyResource;

  @doc("DeletedAppRestoreRequest resource specific properties")
  properties?: DeletedAppRestoreRequestProperties;
}

@doc("DeletedAppRestoreRequest resource specific properties")
model DeletedAppRestoreRequestProperties {
  @doc("""
ARM resource ID of the deleted app. Example:
/subscriptions/{subId}/providers/Microsoft.Web/deletedSites/{deletedSiteId}
""")
  deletedSiteId?: string;

  @doc("If true, deleted site configuration, in addition to content, will be restored.")
  recoverConfiguration?: boolean;

  @doc("""
Point in time to restore the deleted app from, formatted as a DateTime string. 
If unspecified, default value is the time that the app was deleted.
""")
  snapshotTime?: string;

  @doc("If true, the snapshot is retrieved from DRSecondary endpoint.")
  useDRSecondary?: boolean;
}

@doc("Details about app recovery operation.")
model SnapshotRestoreRequest {
  ...ProxyOnlyResource;

  @doc("SnapshotRestoreRequest resource specific properties")
  properties?: SnapshotRestoreRequestProperties;
}

@doc("SnapshotRestoreRequest resource specific properties")
model SnapshotRestoreRequestProperties {
  @doc("Point in time in which the app restore should be done, formatted as a DateTime string.")
  snapshotTime?: string;

  @doc("""
Optional. Specifies the web app that snapshot contents will be retrieved from.
If empty, the targeted web app will be used as the source.
""")
  recoverySource?: SnapshotRecoverySource;

  @doc("If <code>true</code> the restore operation can overwrite source app; otherwise, <code>false</code>.")
  overwrite: boolean;

  @doc("If true, site configuration, in addition to content, will be reverted.")
  recoverConfiguration?: boolean;

  @doc("""
If true, custom hostname conflicts will be ignored when recovering to a target web app.
This setting is only necessary when RecoverConfiguration is enabled.
""")
  ignoreConflictingHostNames?: boolean;

  @doc("If true, the snapshot is retrieved from DRSecondary endpoint.")
  useDRSecondary?: boolean;
}

@doc("Specifies the web app that snapshot contents will be retrieved from.")
model SnapshotRecoverySource {
  @doc("Geographical location of the source web app, e.g. SouthEastAsia, SouthCentralUS")
  location?: string;

  @doc("""
ARM resource ID of the source app. 
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName} for production slots and 
/subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slotName} for other slots.
""")
  id?: string;
}

@doc("SiteExtensionInfo resource specific properties")
model SiteExtensionInfoProperties {
  @doc("Site extension ID.")
  @projectedName("json", "extension_id")
  extensionId?: string;

  title?: string;

  @doc("Site extension type.")
  @projectedName("json", "extension_type")
  extensionType?: SiteExtensionType;

  @doc("Summary description.")
  summary?: string;

  @doc("Detailed description.")
  description?: string;

  @doc("Version information.")
  version?: string;

  @doc("Extension URL.")
  @projectedName("json", "extension_url")
  extensionUrl?: string;

  @doc("Project URL.")
  @projectedName("json", "project_url")
  projectUrl?: string;

  @doc("Icon URL.")
  @projectedName("json", "icon_url")
  iconUrl?: string;

  @doc("License URL.")
  @projectedName("json", "license_url")
  licenseUrl?: string;

  @doc("Feed URL.")
  @projectedName("json", "feed_url")
  feedUrl?: string;

  @doc("List of authors.")
  authors?: string[];

  @doc("Installer command line parameters.")
  @projectedName("json", "installer_command_line_params")
  installerCommandLineParams?: string;

  @doc("Published timestamp.")
  @projectedName("json", "published_date_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDateTime?: utcDateTime;

  @doc("Count of downloads.")
  @projectedName("json", "download_count")
  downloadCount?: int32;

  @doc("<code>true</code> if the local version is the latest version; <code>false</code> otherwise.")
  @projectedName("json", "local_is_latest_version")
  localIsLatestVersion?: boolean;

  @doc("Local path.")
  @projectedName("json", "local_path")
  localPath?: string;

  @doc("Installed timestamp.")
  @projectedName("json", "installed_date_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  installedDateTime?: utcDateTime;

  @doc("Provisioning state.")
  provisioningState?: string;

  @doc("Site Extension comment.")
  comment?: string;
}

@doc("Collection of slot differences.")
model SlotDifferenceCollection is Azure.Core.Page<SlotDifference>;

@doc("A setting difference between two deployment slots of an app.")
model SlotDifference {
  ...ProxyOnlyResource;

  @doc("SlotDifference resource specific properties")
  properties?: SlotDifferenceProperties;
}

@doc("SlotDifference resource specific properties")
model SlotDifferenceProperties {
  @doc("Level of the difference: Information, Warning or Error.")
  @visibility("read")
  level?: string;

  @doc("The type of the setting: General, AppSetting or ConnectionString.")
  @visibility("read")
  settingType?: string;

  @doc("Rule that describes how to process the setting difference during a slot swap.")
  @visibility("read")
  diffRule?: string;

  @doc("Name of the setting.")
  @visibility("read")
  settingName?: string;

  @doc("Value of the setting in the current slot.")
  @visibility("read")
  valueInCurrentSlot?: string;

  @doc("Value of the setting in the target slot.")
  @visibility("read")
  valueInTargetSlot?: string;

  @doc("Description of the setting difference.")
  @visibility("read")
  description?: string;
}

@doc("Collection of snapshots which can be used to revert an app to a previous time.")
model SnapshotCollection is Azure.Core.Page<Snapshot>;

@doc("SiteSourceControl resource specific properties")
model SiteSourceControlProperties {
  @doc("Repository or source control URL.")
  @visibility("read", "create")
  repoUrl?: string;

  @doc("Name of branch to use for deployment.")
  @visibility("read", "create")
  branch?: string;

  @doc("<code>true</code> to limit to manual integration; <code>false</code> to enable continuous integration (which configures webhooks into online repos like GitHub).")
  @visibility("read", "create")
  isManualIntegration?: boolean;

  @doc("<code>true</code> if this is deployed via GitHub action.")
  @visibility("read", "create")
  isGitHubAction?: boolean;

  @doc("<code>true</code> to enable deployment rollback; otherwise, <code>false</code>.")
  @visibility("read", "create")
  deploymentRollbackEnabled?: boolean;

  @doc("<code>true</code> for a Mercurial repository; <code>false</code> for a Git repository.")
  @visibility("read", "create")
  isMercurial?: boolean;

  @doc("If GitHub Action is selected, than the associated configuration.")
  gitHubActionConfiguration?: GitHubActionConfiguration;
}

@doc("The GitHub action configuration.")
model GitHubActionConfiguration {
  @doc("GitHub Action code configuration.")
  codeConfiguration?: GitHubActionCodeConfiguration;

  @doc("GitHub Action container configuration.")
  containerConfiguration?: GitHubActionContainerConfiguration;

  @doc("This will help determine the workflow configuration to select.")
  isLinux?: boolean;

  @doc("Workflow option to determine whether the workflow file should be generated and written to the repository.")
  generateWorkflowFile?: boolean;
}

@doc("The GitHub action code configuration.")
model GitHubActionCodeConfiguration {
  @doc("Runtime stack is used to determine the workflow file content for code base apps.")
  runtimeStack?: string;

  @doc("Runtime version is used to determine what build version to set in the workflow file.")
  runtimeVersion?: string;
}

@doc("The GitHub action container configuration.")
model GitHubActionContainerConfiguration {
  @doc("The server URL for the container registry where the build will be hosted.")
  serverUrl?: string;

  @doc("The image name for the build.")
  imageName?: string;

  @doc("The username used to upload the image to the container registry.")
  username?: string;

  @doc("The password used to upload the image to the container registry.")
  password?: string;
}

@doc("TriggeredWebJob resource specific properties")
model TriggeredWebJobProperties {
  @doc("Latest job run information.")
  @projectedName("json", "latest_run")
  latestRun?: TriggeredJobRun;

  @doc("History URL.")
  @projectedName("json", "history_url")
  historyUrl?: string;

  @doc("Scheduler Logs URL.")
  @projectedName("json", "scheduler_logs_url")
  schedulerLogsUrl?: string;

  @doc("Run command.")
  @projectedName("json", "run_command")
  runCommand?: string;

  @doc("Job URL.")
  url?: string;

  @doc("Extra Info URL.")
  @projectedName("json", "extra_info_url")
  extraInfoUrl?: string;

  @doc("Job type.")
  @projectedName("json", "web_job_type")
  webJobType?: WebJobType;

  @doc("Error information.")
  error?: string;

  @doc("Using SDK?")
  @projectedName("json", "using_sdk")
  usingSdk?: boolean;

  @doc("Job settings.")
  settings?: Record<Record<unknown>>;
}

@doc("Triggered Web Job Run Information.")
model TriggeredJobRun {
  @doc("Job ID.")
  @projectedName("json", "web_job_id")
  webJobId?: string;

  @doc("Job name.")
  @projectedName("json", "web_job_name")
  webJobName?: string;

  @doc("Job status.")
  status?: TriggeredWebJobStatus;

  @doc("Start time.")
  @projectedName("json", "start_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time.")
  @projectedName("json", "end_time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Job duration.")
  duration?: duration;

  @doc("Output URL.")
  @projectedName("json", "output_url")
  outputUrl?: string;

  @doc("Error URL.")
  @projectedName("json", "error_url")
  errorUrl?: string;

  @doc("Job URL.")
  url?: string;

  @doc("Job name.")
  @projectedName("json", "job_name")
  jobName?: string;

  @doc("Job trigger.")
  trigger?: string;
}

@doc("TriggeredJobHistory resource specific properties")
model TriggeredJobHistoryProperties {
  @doc("List of triggered web job runs.")
  runs?: TriggeredJobRun[];
}

@doc("WebJob resource specific properties")
model WebJobProperties {
  @doc("Run command.")
  @projectedName("json", "run_command")
  runCommand?: string;

  @doc("Job URL.")
  url?: string;

  @doc("Extra Info URL.")
  @projectedName("json", "extra_info_url")
  extraInfoUrl?: string;

  @doc("Job type.")
  @projectedName("json", "web_job_type")
  webJobType?: WebJobType;

  @doc("Error information.")
  error?: string;

  @doc("Using SDK?")
  @projectedName("json", "using_sdk")
  usingSdk?: boolean;

  @doc("Job settings.")
  settings?: Record<Record<unknown>>;
}

@doc("Github access token for Appservice CLI github integration.")
model AppserviceGithubToken {
  @doc("Github access token for Appservice CLI github integration")
  accessToken?: string;

  @doc("Scope of the github access token")
  scope?: string;

  @doc("token type")
  tokenType?: string;

  @doc("True if valid github token received, False otherwise")
  gotToken?: boolean;

  @doc("Error message if unable to get token")
  errorMessage?: string;
}

@doc("Appservice Github token request content.")
model AppserviceGithubTokenRequest {
  @doc("Code string to exchange for Github Access token")
  code: string;

  @doc("State string used for verification.")
  state: string;
}

@doc("Object with a list of the resources that need to be moved and the resource group they should be moved to.")
model CsmMoveResourceEnvelope {
  @maxLength(90)
  @minLength(1)
  @pattern(" ^[-\\w\\._\\(\\)]+[^\\.]$")
  targetResourceGroup?: string;

  resources?: string[];
}

@doc("A static site user provided function.")
model StaticSiteUserProvidedFunctionApp {
  ...ProxyOnlyResource;

  @doc("StaticSiteUserProvidedFunctionApp resource specific properties")
  properties?: StaticSiteUserProvidedFunctionAppProperties;
}

@doc("StaticSiteUserProvidedFunctionApp resource specific properties")
model StaticSiteUserProvidedFunctionAppProperties {
  @doc("The resource id of the function app registered with the static site")
  functionAppResourceId?: string;

  @doc("The region of the function app registered with the static site")
  functionAppRegion?: string;

  @doc("The date and time on which the function app was registered with the static site.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;
}
