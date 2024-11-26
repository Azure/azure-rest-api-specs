import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DesktopVirtualization;

/**
 * The current provisioning state.
 */
union ProvisioningState {
  string,

  /**
   *  Provisioning Successful
   */
  Succeeded: "Succeeded",

  /**
   * Provisioning in Progress
   */
  Provisioning: "Provisioning",

  /**
   * Provisioning Failed
   */
  Failed: "Failed",

  /**
   * Provisioning was Canceled
   */
  Canceled: "Canceled",
}

/**
 * Is package timestamped so it can ignore the certificate expiry date
 */
union PackageTimestamped {
  string,

  /**
   * Package is timestamped
   */
  Timestamped: "Timestamped",

  /**
   * Package is not timestamped, use certificate expiry date
   */
  NotTimestamped: "NotTimestamped",
}

/**
 * Parameter indicating how the health check should behave if this package fails staging
 */
union FailHealthCheckOnStagingFailure {
  string,

  /**
   * Health Check will report unhealthy
   */
  Unhealthy: "Unhealthy",

  /**
   * Health Check will report NeedsAssistance
   */
  NeedsAssistance: "NeedsAssistance",

  /**
   * Health Check will not report failure
   */
  DoNotFail: "DoNotFail",
}

/**
 * Resource Type of ApplicationGroup.
 */
union ApplicationGroupType {
  string,

  /**
   * Application group is Remote and can launch individual applications without a Desktop.
   */
  RemoteApp: "RemoteApp",

  /**
   * Application Group delivers a full expected Desktop experience
   */
  Desktop: "Desktop",
}

/**
 * HostPool type for desktop.
 */
union HostPoolType {
  string,

  /**
   * Users will be assigned a SessionHost either by administrators (PersonalDesktopAssignmentType = Direct) or upon connecting to the pool (PersonalDesktopAssignmentType = Automatic). They will always be redirected to their assigned SessionHost.
   */
  Personal: "Personal",

  /**
   * Users get a new (random) SessionHost every time it connects to the HostPool.
   */
  Pooled: "Pooled",

  /**
   * Users assign their own machines, load balancing logic remains the same as Personal. PersonalDesktopAssignmentType must be Direct.
   */
  BYODesktop: "BYODesktop",
}

/**
 * PersonalDesktopAssignment type for HostPool.
 */
union PersonalDesktopAssignmentType {
  string,

  /**
   * Automatically assigns an available personal desktop to the user.
   */
  Automatic: "Automatic",

  /**
   * Manually assigns a specific personal desktop to the user.
   */
  Direct: "Direct",
}

/**
 * The type of the load balancer.
 */
union LoadBalancerType {
  string,

  /**
   * Uses BreadthFirst algorithm for load balancing.
   */
  BreadthFirst: "BreadthFirst",

  /**
   * Uses DepthFirst algorithm for load balancing.
   */
  DepthFirst: "DepthFirst",

  /**
   * Maintains persistent conenctions.
   */
  Persistent: "Persistent",
}

/**
 * The type of resetting the token.
 */
union RegistrationTokenOperation {
  string,

  /**
   * Delete operation
   */
  Delete: "Delete",

  /**
   * No Operation
   */
  None: "None",

  /**
   * Update Operation
   */
  Update: "Update",
}

/**
 * The type of single sign on Secret Type.
 */
union SSOSecretType {
  string,

  /**
   * The SSO Secret is a Shared Key.
   */
  SharedKey: "SharedKey",

  /**
   * The SSO Secret is a Certificate.
   */
  Certificate: "Certificate",

  /**
   * The SSO Secret is a SharedKey that is stored in KeyVault.
   */
  SharedKeyInKeyVault: "SharedKeyInKeyVault",

  /**
   * The SSO Secret is a Certificate that is stored in KeyVault.
   */
  CertificateInKeyVault: "CertificateInKeyVault",
}

/**
 * The type of preferred application group type, default to Desktop Application Group
 */
union PreferredAppGroupType {
  string,

  /**
   *  Internal Use Only
   */
  None: "None",

  /**
   * Use Desktop Application Group
   */
  Desktop: "Desktop",

  /**
   * Use RailApplications (RemoteApp)
   */
  RailApplications: "RailApplications",
}

/**
 * Enabled to allow this resource to be access from the public network
 */
union HostpoolPublicNetworkAccess {
  string,

  /**
   * Allows this resource to be accessed from the public network
   */
  Enabled: "Enabled",

  /**
   * Prevents this resource from being accessed from the public network
   */
  Disabled: "Disabled",

  /**
   * Allows SessionHosts to be accessed from the public network
   */
  EnabledForSessionHostsOnly: "EnabledForSessionHostsOnly",

  /**
   * Allows Clients to be accessed from the public network
   */
  EnabledForClientsOnly: "EnabledForClientsOnly",
}

/**
 * The type of maintenance for session host components.
 */
union SessionHostComponentUpdateType {
  string,

  /**
   * Agent and other agent side components are delivery schedule is controlled by WVD Infra.
   */
  Default: "Default",

  /**
   * TenantAdmin have opted in for Scheduled Component Update feature.
   */
  Scheduled: "Scheduled",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,

  /**
   * Connection is Pending
   */
  Pending: "Pending",

  /**
   * Connection was Approved
   */
  Approved: "Approved",

  /**
   * Connection was rejected
   */
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
union PrivateEndpointConnectionProvisioningState {
  string,

  /**
   * Provisioning was successful
   */
  Succeeded: "Succeeded",

  /**
   * A PrivateEndpointConnection is being created
   */
  Creating: "Creating",

  /**
   * A PrivateEndpointConnection is being deleted
   */
  Deleting: "Deleting",

  /**
   * Provisioning failed
   */
  Failed: "Failed",
}

/**
 * Managed Private UDP Connection Settings
 */
union ManagedPrivateUDP {
  string,

  /**
   * AVD-wide settings are used to determine connection availability
   */
  Default: "Default",

  /**
   * UDP will attempt this connection type when making connections.
   */
  Enabled: "Enabled",

  /**
   * UDP will not attempt this connection type when making connections
   */
  Disabled: "Disabled",
}

/**
 * Direct UDP Connection Settings
 */
union DirectUDP {
  string,

  /**
   * AVD-wide settings are used to determine connection availability
   */
  Default: "Default",

  /**
   * UDP will attempt this connection type when making connections.
   */
  Enabled: "Enabled",

  /**
   * UDP will not attempt this connection type when making connections
   */
  Disabled: "Disabled",
}

/**
 * Public UDP Connection Settings
 */
union PublicUDP {
  string,

  /**
   * AVD-wide settings are used to determine connection availability
   */
  Default: "Default",

  /**
   * UDP will attempt this connection type when making connections.
   */
  Enabled: "Enabled",

  /**
   * UDP will not attempt this connection type when making connections
   */
  Disabled: "Disabled",
}

/**
 * Relay UDP Connection Settings
 */
union RelayUDP {
  string,

  /**
   * AVD-wide settings are used to determine connection availability
   */
  Default: "Default",

  /**
   * UDP will attempt this connection type when making connections.
   */
  Enabled: "Enabled",

  /**
   * UDP will not attempt this connection type when making connections
   */
  Disabled: "Disabled",
}

/**
 * HostPool type for desktop.
 */
union ScalingHostPoolType {
  string,

  /**
   * Users get a new (random) SessionHost every time it connects to the HostPool.
   */
  Pooled: "Pooled",
}

/**
 * Days of Week that the Scaling Schedule is active.
 */
union ScalingScheduleDaysOfWeekItem {
  string,

  /** Sunday */
  Sunday: "Sunday",

  /** Monday */
  Monday: "Monday",

  /** Tuesday */
  Tuesday: "Tuesday",

  /** Wednesday */
  Wednesday: "Wednesday",

  /** Thursday */
  Thursday: "Thursday",

  /** Friday */
  Friday: "Friday",

  /** Saturday */
  Saturday: "Saturday",
}

/**
 * Load balancing algorithm for ramp up period.
 */
union SessionHostLoadBalancingAlgorithm {
  string,

  /**
   * Breadth First Algorithm for Load Balancing
   */
  BreadthFirst: "BreadthFirst",

  /**
   * Depth First Algorithm for Load Balancing
   */
  DepthFirst: "DepthFirst",
}

/**
 * Specifies when to stop hosts during ramp down period.
 */
union StopHostsWhen {
  string,

  /**
   * Zero Total Sessions
   */
  ZeroSessions: "ZeroSessions",

  /**
   * Zero Active Sessions
   */
  ZeroActiveSessions: "ZeroActiveSessions",
}

/**
 * Enabled to allow this resource to be access from the public network
 */
union PublicNetworkAccess {
  string,

  /**
   * This resource is accessible from the public network.
   */
  Enabled: "Enabled",

  /**
   * This resource is not accessible from the public network.
   */
  Disabled: "Disabled",
}

/**
 * Resource Type of Application.
 */
union RemoteApplicationType {
  string,

  /**
   * Built-in applications
   */
  InBuilt: "InBuilt",

  /**
   * Imported MSIX application packages
   */
  MsixApplication: "MsixApplication",
}

/**
 * Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all.
 */
union CommandLineSetting {
  string,

  /**
   * Cannot be launched with command line arguments.
   */
  DoNotAllow: "DoNotAllow",

  /**
   * Can optionally be launched with command line arguments.
   */
  Allow: "Allow",

  /**
   * Required to be launched with command line arguments.
   */
  Require: "Require",
}

/**
 * Possible device architectures that an app attach package can be configured for
 */
union AppAttachPackageArchitectures {
  string,

  /**
   * ARM 32-bit
   */
  ARM: "ARM",

  /**
   * ARM 64-bit
   */
  ARM64: "ARM64",

  /**
   * 32-bit x86
   */
  x86: "x86",

  /**
   * 64-bit
   */
  x64: "x64",

  /**
   * Any architecture can be used
   */
  Neutral: "Neutral",

  /**
   * X86 CHPE for ARM64
   */
  x86a64: "x86a64",

  /**
   * Select all listed applications, no filters
   */
  ALL: "ALL",
}

/**
 * Status for a SessionHost.
 */
union Status {
  string,

  /**
   * Session Host has passed all the health checks and is available to handle connections.
   */
  Available: "Available",

  /**
   * Session Host is either turned off or has failed critical health checks which is causing service not to be able to route connections to this session host. Note this replaces previous 'NoHeartBeat' status.
   */
  Unavailable: "Unavailable",

  /**
   * Session Host is shutdown - RD Agent reported session host to be stopped or deallocated.
   */
  Shutdown: "Shutdown",

  /**
   * The Session Host is unavailable because it is currently disconnected.
   */
  Disconnected: "Disconnected",

  /**
   * Session Host is unavailable because currently an upgrade of RDAgent/side-by-side stack is in progress. Note: this state will be removed once the upgrade completes and the host is able to accept connections.
   */
  Upgrading: "Upgrading",

  /**
   * Session Host is unavailable because the critical component upgrade (agent, side-by-side stack, etc.) failed.
   */
  UpgradeFailed: "UpgradeFailed",

  /**
   * The Session Host is not heart beating.
   */
  NoHeartbeat: "NoHeartbeat",

  /**
   * SessionHost is not joined to domain.
   */
  NotJoinedToDomain: "NotJoinedToDomain",

  /**
   * SessionHost's domain trust relationship lost
   */
  DomainTrustRelationshipLost: "DomainTrustRelationshipLost",

  /**
   * SxS stack installed on the SessionHost is not ready to receive connections.
   */
  SxSStackListenerNotReady: "SxSStackListenerNotReady",

  /**
   * FSLogix is in an unhealthy state on the session host.
   */
  FSLogixNotHealthy: "FSLogixNotHealthy",

  /**
   * New status to inform admins that the health on their endpoint needs to be fixed. The connections might not fail, as these issues are not fatal.
   */
  NeedsAssistance: "NeedsAssistance",
}

/**
 * Update state of a SessionHost.
 */
union UpdateState {
  string,

  /**
   * Update is initializing
   */
  Initial: "Initial",

  /**
   * Update is pending
   */
  Pending: "Pending",

  /**
   * Update has started
   */
  Started: "Started",

  /**
   * Update has succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Update has failed
   */
  Failed: "Failed",
}

/**
 * Represents the name of the health check operation performed.
 */
union HealthCheckName {
  string,

  /**
   * Verifies the SessionHost is joined to a domain. If this check fails is classified as fatal as no connection can succeed if the SessionHost is not joined to the domain. (Currently Enabled)
   */
  DomainJoinedCheck: "DomainJoinedCheck",

  /**
   * Verifies the SessionHost is not experiencing domain trust issues that will prevent authentication on SessionHost at connection time when session is created. If this check fails is classified as fatal as no connection can succeed if we cannot reach the domain for authentication on the SessionHost. (Currently Enabled)
   */
  DomainTrustCheck: "DomainTrustCheck",

  /**
   * Verifies the FSLogix service is up and running to make sure users' profiles are loaded in the session. If this check fails is classified as fatal as even if the connection can succeed, user experience is bad as the user profile cannot be loaded and user will get a temporary profile in the session. (Currently Disabled)
   */
  FSLogixHealthCheck: "FSLogixHealthCheck",

  /**
   * Verifies that the SxS stack is up and running so connections can succeed. If this check fails is classified as fatal as no connection can succeed if the SxS stack is not ready. (Currently Enabled)
   */
  SxSStackListenerCheck: "SxSStackListenerCheck",

  /**
   * Verifies that the required WVD service and Geneva URLs are reachable from the SessionHost. These URLs are: RdTokenUri, RdBrokerURI, RdDiagnosticsUri and storage blob URLs for agent monitoring (geneva). If this check fails, it is non fatal and the machine still can service connections, main issue may be that monitoring agent is unable to store warm path data (logs, operations ...). (Currently Disabled)
   */
  UrlsAccessibleCheck: "UrlsAccessibleCheck",

  /**
   * Verifies that the required Geneva agent is running. If this check fails, it is non fatal and the machine still can service connections, main issue may be that monitoring agent is missing or running (possibly) older version. (Currently Enabled)
   */
  MonitoringAgentCheck: "MonitoringAgentCheck",

  /**
   * Verifies the domain the SessionHost is joined to is still reachable. If this check fails is classified as fatal as no connection can succeed if the domain the SessionHost is joined is not reachable at the time of connection. (Currently Disabled)
   */
  DomainReachable: "DomainReachable",

  /**
   * Verifies whether the WebRTCRedirector component is healthy. The WebRTCRedirector component is used to optimize video and audio performance in Microsoft Teams. This checks whether the component is still running, and whether there is a higher version available. If this check fails, it is non fatal and the machine still can service connections, main issue may be the WebRTCRedirector component has to be restarted or updated. (Currently Disabled)
   */
  WebRTCRedirectorCheck: "WebRTCRedirectorCheck",

  /**
   * Verifies the value of SecurityLayer registration key. If the value is 0 (SecurityLayer.RDP) this check fails with Error code = NativeMethodErrorCode.E_FAIL and is fatal. If the value is 1 (SecurityLayer.Negotiate) this check fails with Error code = NativeMethodErrorCode.ERROR_SUCCESS and is non fatal. (Currently Disabled)
   */
  SupportedEncryptionCheck: "SupportedEncryptionCheck",

  /**
   * Verifies the metadata service is accessible and return compute properties. (Currently Enabled)
   */
  MetaDataServiceCheck: "MetaDataServiceCheck",

  /**
   * Verifies that the AppAttachService is healthy (there were no issues during package staging). The AppAttachService is used to enable the staging/registration (and eventual deregistration/destaging) of MSIX apps that have been set up by the tenant admin. This checks whether the component had any failures during package staging. Failures in staging will prevent some MSIX apps from working properly for the end user. If this check fails, it is non fatal and the machine still can service connections, main issue may be certain apps will not work for end-users. (Currently Enabled)
   */
  AppAttachHealthCheck: "AppAttachHealthCheck",
}

/**
 * Represents the Health state of the health check we performed.
 */
union HealthCheckResult {
  string,

  /**
   * Health check result is not currently known.
   */
  Unknown: "Unknown",

  /**
   * Health check passed.
   */
  HealthCheckSucceeded: "HealthCheckSucceeded",

  /**
   * Health check failed.
   */
  HealthCheckFailed: "HealthCheckFailed",

  /**
   * We received a Shutdown notification.
   */
  SessionHostShutdown: "SessionHostShutdown",
}

/**
 * Application type of application.
 */
union ApplicationType {
  string,

  /**
   * Remote Applications (non-desktop)
   */
  RemoteApp: "RemoteApp",

  /**
   * Desktop Applications
   */
  Desktop: "Desktop",
}

/**
 * State of user session.
 */
union SessionState {
  string,

  /**
   * SessionState is unknown
   */
  Unknown: "Unknown",

  /**
   * Session is active
   */
  Active: "Active",

  /**
   * Session is disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Session is pending connection
   */
  Pending: "Pending",

  /**
   * Session is logging off
   */
  LogOff: "LogOff",

  /**
   * Session has mounted user profile disk
   */
  UserProfileDiskMounted: "UserProfileDiskMounted",
}

/**
 * The desired startup behavior during the ramp up period for personal vms in the hostpool.
 */
union StartupBehavior {
  string,

  /**
   * Session hosts will not be started by the service. This setting depends on Start VM on Connect to be enabled to start the session hosts.
   */
  None: "None",

  /**
   * Session hosts with an assigned user will be started during Ramp Up
   */
  WithAssignedUser: "WithAssignedUser",

  /**
   * All personal session hosts in the hostpool will be started during ramp up.
   */
  All: "All",
}

/**
 * The desired configuration of Start VM On Connect for the hostpool during the ramp up phase. If this is disabled, session hosts must be turned on using rampUpAutoStartHosts or by turning them on manually.
 */
union SetStartVMOnConnect {
  string,
  Enable: "Enable",
  Disable: "Disable",
}

/**
 * Action to be taken after a user disconnect during the ramp up period.
 */
union SessionHandlingOperation {
  string,

  /**
   * No action will be taken after disconnect
   */
  None: "None",

  /**
   * Session Host will be deallocated after disconnect
   */
  Deallocate: "Deallocate",

  /**
   * Session Host will hibernate after disconnect
   */
  Hibernate: "Hibernate",
}

/**
 * Day of the week.
 */
enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * Supported operation of this resource provider.
 */
model ResourceProviderOperation {
  /**
   * Operation name, in format of {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: ResourceProviderOperationDisplay;

  /**
   * Is a data action.
   */
  isDataAction?: boolean;

  /**
   * Properties of the operation
   */
  properties?: OperationProperties;
}

/**
 * Display metadata associated with the operation.
 */
model ResourceProviderOperationDisplay {
  /**
   * Resource provider: Microsoft Desktop Virtualization.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Description of this operation.
   */
  description?: string;
}

/**
 * Properties of the operation
 */
model OperationProperties {
  /**
   * Service specification payload
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Azure Monitoring
   */
  logSpecifications?: LogSpecification[];
}

/**
 * Specifications of the Log for Azure Monitoring
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Localized friendly display name of the log
   */
  displayName?: string;

  /**
   * Blob duration of the log
   */
  blobDuration?: string;
}

/**
 * Cloud error object.
 */
@error
model CloudError {
  /**
   * Cloud error object properties.
   */
  error?: CloudErrorProperties;
}

/**
 * Cloud error object properties.
 */
model CloudErrorProperties {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * List of App Attach Package definitions.
 */
model AppAttachPackageList is Azure.Core.Page<AppAttachPackage>;

/**
 * Schema for App Attach Package properties.
 */
model AppAttachPackageProperties {
  /**
   * The provisioning state of the App Attach Package.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Detailed properties for App Attach Package
   */
  image?: AppAttachPackageInfoProperties;

  /**
   * List of Hostpool resource Ids.
   */
  hostPoolReferences?: string[];

  /**
   * URL path to certificate name located in keyVault
   */
  keyVaultURL?: string;

  /**
   * Parameter indicating how the health check should behave if this package fails staging
   */
  failHealthCheckOnStagingFailure?: FailHealthCheckOnStagingFailure;
}

/**
 * Schema for Import Package Information properties.
 */
model AppAttachPackageInfoProperties {
  /**
   * Alias of App Attach Package. Assigned at import time
   */
  packageAlias?: string;

  /**
   * VHD/CIM image path on Network Share.
   */
  imagePath?: string;

  /**
   * Package Name from appxmanifest.xml.
   */
  packageName?: string;

  /**
   * Package Family Name from appxmanifest.xml. Contains Package Name and Publisher name.
   */
  packageFamilyName?: string;

  /**
   * Package Full Name from appxmanifest.xml.
   */
  packageFullName?: string;

  /**
   * User friendly Name to be displayed in the portal.
   */
  displayName?: string;

  /**
   * Relative Path to the package inside the image.
   */
  packageRelativePath?: string;

  /**
   * Specifies how to register Package in feed.
   */
  isRegularRegistration?: boolean;

  /**
   * Make this version of the package the active one across the hostpool.
   */
  isActive?: boolean;

  /**
   * List of package dependencies.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  packageDependencies?: MsixPackageDependencies[];

  /**
   * Package version found in the appxmanifest.xml.
   */
  version?: string;

  /**
   * Date Package was last updated, found in the appxmanifest.xml.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * List of package applications.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  packageApplications?: MsixPackageApplications[];

  /**
   * Certificate name found in the appxmanifest.xml.
   */
  certificateName?: string;

  /**
   * Date certificate expires, found in the appxmanifest.xml.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  certificateExpiry?: utcDateTime;

  /**
   * Is package timestamped so it can ignore the certificate expiry date
   */
  isPackageTimestamped?: PackageTimestamped;
}

/**
 * Schema for MSIX Package Dependencies properties.
 */
model MsixPackageDependencies {
  /**
   * Name of package dependency.
   */
  dependencyName?: string;

  /**
   * Name of dependency publisher.
   */
  publisher?: string;

  /**
   * Dependency version required.
   */
  minVersion?: string;
}

/**
 * Schema for MSIX Package Application properties.
 */
model MsixPackageApplications {
  /**
   * Package Application Id, found in appxmanifest.xml.
   */
  appId?: string;

  /**
   * Description of Package Application.
   */
  description?: string;

  /**
   * Used to activate Package Application. Consists of Package Name and ApplicationID. Found in appxmanifest.xml.
   */
  appUserModelID?: string;

  /**
   * User friendly name.
   */
  friendlyName?: string;

  /**
   * User friendly name.
   */
  iconImageName?: string;

  /**
   * the icon a 64 bit string as a byte array.
   */
  rawIcon?: bytes;

  /**
   * the icon a 64 bit string as a byte array.
   */
  rawPng?: bytes;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: Azure.Core.armResourceIdentifier;

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
 * List of ApplicationGroup definitions.
 */
model ApplicationGroupList is Azure.Core.Page<ApplicationGroup>;

/**
 * Schema for ApplicationGroup properties.
 */
model ApplicationGroupProperties {
  /**
   * ObjectId of ApplicationGroup. (internal use)
   */
  @visibility("read")
  objectId?: string;

  /**
   * Description of ApplicationGroup.
   */
  description?: string;

  /**
   * Friendly name of ApplicationGroup.
   */
  friendlyName?: string;

  /**
   * HostPool arm path of ApplicationGroup.
   */
  hostPoolArmPath: string;

  /**
   * Workspace arm path of ApplicationGroup.
   */
  @visibility("read")
  workspaceArmPath?: string;

  /**
   * Resource Type of ApplicationGroup.
   */
  applicationGroupType: ApplicationGroupType;

  /**
   * Is cloud pc resource.
   */
  @visibility("read")
  cloudPcResource?: boolean;

  /**
   * Boolean representing whether the applicationGroup is show in the feed.
   */
  showInFeed?: boolean;
}

/**
 * The resource model definition containing the full set of allowed properties for a resource. Except properties bag, there cannot be a top level property outside of this set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceModelWithAllowedPropertySet
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  @visibility("read", "create", "update")
  managedBy?: string;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type. E.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  @visibility("read", "create")
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  /**
   * The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.
   */
  @visibility("read")
  etag?: string;

  identity?: ResourceModelWithAllowedPropertySetIdentity;
  sku?: ResourceModelWithAllowedPropertySetSku;
  plan?: ResourceModelWithAllowedPropertySetPlan;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceModelWithAllowedPropertySetIdentity extends Identity {}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity. The value must be an UUID.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource. The value must be an UUID.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceModelWithAllowedPropertySetSku extends Sku {}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. E.g. P3. It is typically a letter+number code
   */
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceModelWithAllowedPropertySetPlan extends Plan {}

/**
 * Plan for the resource.
 */
model Plan {
  /**
   * A user defined name of the 3rd Party Artifact that is being procured.
   */
  name: string;

  /**
   * The publisher of the 3rd Party Artifact that is being bought. E.g. NewRelic
   */
  publisher: string;

  /**
   * The 3rd Party artifact that is being procured. E.g. NewRelic. Product maps to the OfferID specified for the artifact at the time of Data Market onboarding.
   */
  product: string;

  /**
   * A publisher provided promotion code as provisioned in Data Market for the said product/artifact.
   */
  promotionCode?: string;

  /**
   * The version of the desired product/artifact.
   */
  version?: string;
}

/**
 * List of HostPool definitions.
 */
model HostPoolList is Azure.Core.Page<HostPool>;

/**
 * Properties of HostPool.
 */
model HostPoolProperties {
  /**
   * ObjectId of HostPool. (internal use)
   */
  @visibility("read")
  objectId?: string;

  /**
   * Friendly name of HostPool.
   */
  friendlyName?: string;

  /**
   * Description of HostPool.
   */
  description?: string;

  /**
   * HostPool type for desktop.
   */
  hostPoolType: HostPoolType;

  /**
   * PersonalDesktopAssignment type for HostPool.
   */
  personalDesktopAssignmentType?: PersonalDesktopAssignmentType;

  /**
   * Custom rdp property of HostPool.
   */
  customRdpProperty?: string;

  /**
   * The max session limit of HostPool.
   */
  maxSessionLimit?: int32;

  /**
   * The type of the load balancer.
   */
  loadBalancerType: LoadBalancerType;

  /**
   * The ring number of HostPool.
   */
  ring?: int32;

  /**
   * Is validation environment.
   */
  validationEnvironment?: boolean;

  /**
   * The registration info of HostPool.
   */
  registrationInfo?: RegistrationInfo;

  /**
   * VM template for sessionhosts configuration within hostpool.
   */
  vmTemplate?: string;

  /**
   * List of applicationGroup links.
   */
  @visibility("read")
  applicationGroupReferences?: string[];

  /**
   * List of App Attach Package links.
   */
  @visibility("read")
  appAttachPackageReferences?: string[];

  /**
   * URL to customer ADFS server for signing WVD SSO certificates.
   */
  ssoadfsAuthority?: string;

  /**
   * ClientId for the registered Relying Party used to issue WVD SSO certificates.
   */
  ssoClientId?: string;

  /**
   * Path to Azure KeyVault storing the secret used for communication to ADFS.
   */
  ssoClientSecretKeyVaultPath?: string;

  /**
   * The type of single sign on Secret Type.
   */
  ssoSecretType?: SSOSecretType;

  /**
   * The type of preferred application group type, default to Desktop Application Group
   */
  preferredAppGroupType: PreferredAppGroupType;

  /**
   * The flag to turn on/off StartVMOnConnect feature.
   */
  startVMOnConnect?: boolean;

  /**
   * Is cloud pc resource.
   */
  @visibility("read")
  cloudPcResource?: boolean;

  /**
   * Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints
   */
  publicNetworkAccess?: HostpoolPublicNetworkAccess;

  /**
   * The session host configuration for updating agent, monitoring agent, and stack component.
   */
  agentUpdate?: AgentUpdateProperties;

  /**
   * List of private endpoint connection associated with the specified resource
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  managedPrivateUDP?: ManagedPrivateUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  directUDP?: DirectUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  publicUDP?: PublicUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  relayUDP?: RelayUDP;
}

/**
 * Represents a RegistrationInfo definition.
 */
model RegistrationInfo {
  /**
   * Expiration time of registration token.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * The registration token base64 encoded string.
   */
  token?: string;

  /**
   * The type of resetting the token.
   */
  registrationTokenOperation?: RegistrationTokenOperation;
}

/**
 * The session host configuration for updating agent, monitoring agent, and stack component.
 */
model AgentUpdateProperties {
  /**
   * The type of maintenance for session host components.
   */
  type?: SessionHostComponentUpdateType;

  /**
   * Whether to use localTime of the virtual machine.
   */
  useSessionHostLocalTime?: boolean;

  /**
   * Time zone for maintenance as defined in https://docs.microsoft.com/en-us/dotnet/api/system.timezoneinfo.findsystemtimezonebyid?view=net-5.0. Must be set if useLocalTime is true.
   */
  maintenanceWindowTimeZone?: string;

  /**
   * List of maintenance windows. Maintenance windows are 2 hours long.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  maintenanceWindows?: MaintenanceWindowProperties[];
}

/**
 * Maintenance window starting hour and day of week.
 */
model MaintenanceWindowProperties {
  /**
   * The update start hour of the day. (0 - 23)
   */
  hour?: int32;

  /**
   * Day of the week.
   */
  dayOfWeek?: DayOfWeek;
}

/**
 * The private endpoint connection resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateEndpointConnection extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of the private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility("read")
  groupIds?: string[];

  /**
   * The private endpoint resource.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The private endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for private endpoint.
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * List of scaling plan definitions.
 */
model ScalingPlanList is Azure.Core.Page<ScalingPlan>;

/**
 * Scaling plan properties.
 */
model ScalingPlanProperties {
  /**
   * ObjectId of scaling plan. (internal use)
   */
  @visibility("read")
  objectId?: string;

  /**
   * Description of scaling plan.
   */
  description?: string;

  /**
   * User friendly name of scaling plan.
   */
  friendlyName?: string;

  /**
   * Timezone of the scaling plan.
   */
  timeZone: string;

  /**
   * HostPool type for desktop.
   */
  hostPoolType?: ScalingHostPoolType = ScalingHostPoolType.Pooled;

  /**
   * Exclusion tag for scaling plan.
   */
  exclusionTag?: string;

  /**
   * List of ScalingPlanPooledSchedule definitions.
   */
  schedules?: ScalingSchedule[];

  /**
   * List of ScalingHostPoolReference definitions.
   */
  hostPoolReferences?: ScalingHostPoolReference[];
}

/**
 * A ScalingPlanPooledSchedule.
 */
model ScalingSchedule {
  /**
   * Name of the ScalingPlanPooledSchedule.
   */
  name?: string;

  /**
   * Set of days of the week on which this schedule is active.
   */
  daysOfWeek?: ScalingScheduleDaysOfWeekItem[];

  /**
   * Starting time for ramp up period.
   */
  rampUpStartTime?: Time;

  /**
   * Load balancing algorithm for ramp up period.
   */
  rampUpLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  /**
   * Minimum host percentage for ramp up period.
   */
  @maxValue(100)
  rampUpMinimumHostsPct?: int32;

  /**
   * Capacity threshold for ramp up period.
   */
  @maxValue(100)
  @minValue(1)
  rampUpCapacityThresholdPct?: int32;

  /**
   * Starting time for peak period.
   */
  peakStartTime?: Time;

  /**
   * Load balancing algorithm for peak period.
   */
  peakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  /**
   * Starting time for ramp down period.
   */
  rampDownStartTime?: Time;

  /**
   * Load balancing algorithm for ramp down period.
   */
  rampDownLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  /**
   * Minimum host percentage for ramp down period.
   */
  @maxValue(100)
  rampDownMinimumHostsPct?: int32;

  /**
   * Capacity threshold for ramp down period.
   */
  @maxValue(100)
  @minValue(1)
  rampDownCapacityThresholdPct?: int32;

  /**
   * Should users be logged off forcefully from hosts.
   */
  rampDownForceLogoffUsers?: boolean;

  /**
   * Specifies when to stop hosts during ramp down period.
   */
  rampDownStopHostsWhen?: StopHostsWhen;

  /**
   * Number of minutes to wait to stop hosts during ramp down period.
   */
  rampDownWaitTimeMinutes?: int32;

  /**
   * Notification message for users during ramp down period.
   */
  rampDownNotificationMessage?: string;

  /**
   * Starting time for off-peak period.
   */
  offPeakStartTime?: Time;

  /**
   * Load balancing algorithm for off-peak period.
   */
  offPeakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;
}

/**
 * The time for a scaling action to occur.
 */
model Time {
  /**
   * The hour.
   */
  @maxValue(23)
  hour: int32;

  /**
   * The minute.
   */
  @maxValue(59)
  minute: int32;
}

/**
 * Scaling plan reference to hostpool.
 */
model ScalingHostPoolReference {
  /**
   * Arm path of referenced hostpool.
   */
  hostPoolArmPath?: string;

  /**
   * Is the scaling plan enabled for this hostpool.
   */
  scalingPlanEnabled?: boolean;
}

/**
 * List of Workspace definitions.
 */
model WorkspaceList is Azure.Core.Page<Workspace>;

/**
 * Schema for Workspace properties.
 */
model WorkspaceProperties {
  /**
   * ObjectId of Workspace. (internal use)
   */
  @visibility("read")
  objectId?: string;

  /**
   * Description of Workspace.
   */
  description?: string;

  /**
   * Friendly name of Workspace.
   */
  friendlyName?: string;

  /**
   * List of applicationGroup resource Ids.
   */
  applicationGroupReferences?: string[];

  /**
   * Is cloud pc resource.
   */
  @visibility("read")
  cloudPcResource?: boolean;

  /**
   * Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * List of private endpoint connection associated with the specified resource
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * Schema for updatable App Attach Package properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AppAttachPackagePatch extends Resource {
  /**
   * Detailed properties for App Attach Package
   */
  properties?: AppAttachPackagePatchProperties;
}

/**
 * Schema for patchable fields on an App Attach Package.
 */
model AppAttachPackagePatchProperties {
  /**
   * Detailed properties for App Attach Package
   */
  image?: AppAttachPackageInfoProperties;

  /**
   * List of Hostpool resource Ids.
   */
  hostPoolReferences?: Azure.Core.armResourceIdentifier[];

  /**
   * URL path to certificate name located in keyVault
   */
  keyVaultURL?: string;

  /**
   * Parameter indicating how the health check should behave if this package fails staging
   */
  failHealthCheckOnStagingFailure?: FailHealthCheckOnStagingFailure;
}

/**
 * ApplicationGroup properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApplicationGroupPatch extends Resource {
  /**
   * tags to be updated
   */
  tags?: Record<string>;

  /**
   * ApplicationGroup properties that can be patched.
   */
  properties?: ApplicationGroupPatchProperties;
}

/**
 * ApplicationGroup properties that can be patched.
 */
model ApplicationGroupPatchProperties {
  /**
   * Description of ApplicationGroup.
   */
  description?: string;

  /**
   * Friendly name of ApplicationGroup.
   */
  friendlyName?: string;

  /**
   * Boolean representing whether the applicationGroup is show in the feed.
   */
  showInFeed?: boolean;
}

/**
 * List of Application definitions.
 */
model ApplicationList is Azure.Core.Page<Application>;

/**
 * Schema for Application properties.
 */
model ApplicationProperties {
  /**
   * ObjectId of Application. (internal use)
   */
  @visibility("read")
  objectId?: string;

  /**
   * Description of Application.
   */
  description?: string;

  /**
   * Friendly name of Application.
   */
  friendlyName?: string;

  /**
   * Specifies a path for the executable file for the application.
   */
  filePath?: string;

  /**
   * Specifies the package family name for MSIX applications
   */
  @visibility("read", "create")
  msixPackageFamilyName?: string;

  /**
   * Specifies the package application Id for MSIX applications
   */
  @visibility("read", "create")
  msixPackageApplicationId?: string;

  /**
   * Resource Type of Application.
   */
  @visibility("read", "create")
  applicationType?: RemoteApplicationType;

  /**
   * Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all.
   */
  commandLineSetting: CommandLineSetting;

  /**
   * Command Line Arguments for Application.
   */
  commandLineArguments?: string;

  /**
   * Specifies whether to show the RemoteApp program in the RD Web Access server.
   */
  showInPortal?: boolean;

  /**
   * Path to icon.
   */
  iconPath?: string;

  /**
   * Index of the icon.
   */
  iconIndex?: int32;

  /**
   * Hash of the icon.
   */
  @visibility("read")
  iconHash?: string;

  /**
   * the icon a 64 bit string as a byte array.
   */
  @visibility("read")
  iconContent?: bytes;
}

/**
 * Application properties that can be patched.
 */
model ApplicationPatch {
  /**
   * tags to be updated
   */
  tags?: Record<string>;

  /**
   * Detailed properties for Application
   */
  properties?: ApplicationPatchProperties;
}

/**
 * Application properties that can be patched.
 */
model ApplicationPatchProperties {
  /**
   * Description of Application.
   */
  description?: string;

  /**
   * Friendly name of Application.
   */
  friendlyName?: string;

  /**
   * Specifies a path for the executable file for the application.
   */
  filePath?: string;

  /**
   * Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all.
   */
  commandLineSetting?: CommandLineSetting;

  /**
   * Command Line Arguments for Application.
   */
  commandLineArguments?: string;

  /**
   * Specifies whether to show the RemoteApp program in the RD Web Access server.
   */
  showInPortal?: boolean;

  /**
   * Path to icon.
   */
  iconPath?: string;

  /**
   * Index of the icon.
   */
  iconIndex?: int32;

  /**
   * Specifies the package family name for MSIX applications
   */
  msixPackageFamilyName?: string;

  /**
   * Specifies the package application Id for MSIX applications
   */
  msixPackageApplicationId?: string;

  /**
   * Resource Type of Application.
   */
  applicationType?: RemoteApplicationType;
}

/**
 * List of Desktop definitions.
 */
model DesktopList is Azure.Core.Page<Desktop>;

/**
 * Schema for Desktop properties.
 */
model DesktopProperties {
  /**
   * ObjectId of Desktop. (internal use)
   */
  @visibility("read")
  objectId?: string;

  /**
   * Description of Desktop.
   */
  description?: string;

  /**
   * Friendly name of Desktop.
   */
  friendlyName?: string;

  /**
   * Hash of the icon.
   */
  @visibility("read")
  iconHash?: string;

  /**
   * The icon a 64 bit string as a byte array.
   */
  @visibility("read")
  iconContent?: bytes;
}

/**
 * Desktop properties that can be patched.
 */
model DesktopPatch {
  /**
   * tags to be updated
   */
  tags?: Record<string>;

  /**
   * Detailed properties for Desktop
   */
  properties?: DesktopPatchProperties;
}

/**
 * Desktop properties that can be patched.
 */
model DesktopPatchProperties {
  /**
   * Description of Desktop.
   */
  description?: string;

  /**
   * Friendly name of Desktop.
   */
  friendlyName?: string;
}

/**
 * List of StartMenuItem definitions.
 */
model StartMenuItemList is Azure.Core.Page<StartMenuItem>;

/**
 * Represents a StartMenuItem definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model StartMenuItem extends Resource {
  /**
   * Detailed properties for StartMenuItem
   */
  properties?: StartMenuItemProperties;
}

/**
 * Schema for StartMenuItem properties.
 */
model StartMenuItemProperties {
  /**
   * Alias of StartMenuItem.
   */
  appAlias?: string;

  /**
   * Path to the file of StartMenuItem.
   */
  filePath?: string;

  /**
   * Command line arguments for StartMenuItem.
   */
  commandLineArguments?: string;

  /**
   * Path to the icon.
   */
  iconPath?: string;

  /**
   * Index of the icon.
   */
  iconIndex?: int32;
}

/**
 * HostPool properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HostPoolPatch extends Resource {
  /**
   * tags to be updated
   */
  tags?: Record<string>;

  /**
   * HostPool properties that can be patched.
   */
  properties?: HostPoolPatchProperties;
}

/**
 * Properties of HostPool.
 */
model HostPoolPatchProperties {
  /**
   * Friendly name of HostPool.
   */
  friendlyName?: string;

  /**
   * Description of HostPool.
   */
  description?: string;

  /**
   * Custom rdp property of HostPool.
   */
  customRdpProperty?: string;

  /**
   * The max session limit of HostPool.
   */
  maxSessionLimit?: int32;

  /**
   * PersonalDesktopAssignment type for HostPool.
   */
  personalDesktopAssignmentType?: PersonalDesktopAssignmentType;

  /**
   * The type of the load balancer.
   */
  loadBalancerType?: LoadBalancerType;

  /**
   * The ring number of HostPool.
   */
  ring?: int32;

  /**
   * Is validation environment.
   */
  validationEnvironment?: boolean;

  /**
   * The registration info of HostPool.
   */
  registrationInfo?: RegistrationInfoPatch;

  /**
   * VM template for sessionhosts configuration within hostpool.
   */
  vmTemplate?: string;

  /**
   * URL to customer ADFS server for signing WVD SSO certificates.
   */
  ssoadfsAuthority?: string;

  /**
   * ClientId for the registered Relying Party used to issue WVD SSO certificates.
   */
  ssoClientId?: string;

  /**
   * Path to Azure KeyVault storing the secret used for communication to ADFS.
   */
  ssoClientSecretKeyVaultPath?: string;

  /**
   * The type of single sign on Secret Type.
   */
  ssoSecretType?: SSOSecretType;

  /**
   * The type of preferred application group type, default to Desktop Application Group
   */
  preferredAppGroupType?: PreferredAppGroupType;

  /**
   * The flag to turn on/off StartVMOnConnect feature.
   */
  startVMOnConnect?: boolean;

  /**
   * Enabled to allow this resource to be access from the public network
   */
  publicNetworkAccess?: HostpoolPublicNetworkAccess;

  /**
   * The session host configuration for updating agent, monitoring agent, and stack component.
   */
  agentUpdate?: AgentUpdatePatchProperties;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  managedPrivateUDP?: ManagedPrivateUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  directUDP?: DirectUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  publicUDP?: PublicUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  relayUDP?: RelayUDP;
}

/**
 * Represents a RegistrationInfo definition.
 */
model RegistrationInfoPatch {
  /**
   * Expiration time of registration token.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * The type of resetting the token.
   */
  registrationTokenOperation?: RegistrationTokenOperation;
}

/**
 * The session host configuration for updating agent, monitoring agent, and stack component.
 */
model AgentUpdatePatchProperties {
  /**
   * The type of maintenance for session host components.
   */
  type?: SessionHostComponentUpdateType;

  /**
   * Whether to use localTime of the virtual machine.
   */
  useSessionHostLocalTime?: boolean;

  /**
   * Time zone for maintenance as defined in https://docs.microsoft.com/en-us/dotnet/api/system.timezoneinfo.findsystemtimezonebyid?view=net-5.0. Must be set if useLocalTime is true.
   */
  maintenanceWindowTimeZone?: string;

  /**
   * List of maintenance windows. Maintenance windows are 2 hours long.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  maintenanceWindows?: MaintenanceWindowPatchProperties[];
}

/**
 * Maintenance window starting hour and day of week.
 */
model MaintenanceWindowPatchProperties {
  /**
   * The update start hour of the day. (0 - 23)
   */
  hour?: int32;

  /**
   * Day of the week.
   */
  dayOfWeek?: DayOfWeek;
}

/**
 * Represents URI referring to MSIX Image
 */
model MsixImageURI {
  /**
   * URI to Image
   */
  uri?: string;
}

/**
 * List of MSIX package properties retrieved from MSIX Image expansion.
 */
model ExpandMsixImageList is Azure.Core.Page<ExpandMsixImage>;

/**
 * Represents the definition of contents retrieved after expanding the MSIX Image.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ExpandMsixImage extends Resource {
  /**
   * Detailed properties for ExpandMsixImage
   */
  properties?: ExpandMsixImageProperties;
}

/**
 * Schema for Expand MSIX Image properties.
 */
model ExpandMsixImageProperties {
  /**
   * Alias of MSIX Package.
   */
  packageAlias?: string;

  /**
   * VHD/CIM image path on Network Share.
   */
  imagePath?: string;

  /**
   * Package Name from appxmanifest.xml.
   */
  packageName?: string;

  /**
   * Package Family Name from appxmanifest.xml. Contains Package Name and Publisher name.
   */
  packageFamilyName?: string;

  /**
   * Package Full Name from appxmanifest.xml.
   */
  packageFullName?: string;

  /**
   * User friendly Name to be displayed in the portal.
   */
  displayName?: string;

  /**
   * Relative Path to the package inside the image.
   */
  packageRelativePath?: string;

  /**
   * Specifies how to register Package in feed.
   */
  isRegularRegistration?: boolean;

  /**
   * Make this version of the package the active one across the hostpool.
   */
  isActive?: boolean;

  /**
   * List of package dependencies.
   */
  packageDependencies?: MsixPackageDependencies[];

  /**
   * Package version found in the appxmanifest.xml.
   */
  version?: string;

  /**
   * Date Package was last updated, found in the appxmanifest.xml.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * List of package applications.
   */
  packageApplications?: MsixPackageApplications[];

  /**
   * Certificate name found in the appxmanifest.xml.
   */
  certificateName?: string;

  /**
   * Date certificate expires, found in the appxmanifest.xml.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  certificateExpiry?: utcDateTime;
}

/**
 * Information to import app attach package
 */
model ImportPackageInfoRequest {
  /**
   * URI to Image
   */
  path?: string;

  /**
   * Possible device architectures that an app attach package can be configured for
   */
  packageArchitecture?: AppAttachPackageArchitectures;
}

/**
 * List of RegistrationToken definitions.
 */
model RegistrationTokenList {
  /**
   * List of RegistrationToken definitions.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  value?: RegistrationTokenMinimal[];

  /**
   * Link to the next page of results.
   */
  @visibility("read")
  nextLink?: string;
}

/**
 * Represents a Minimal set of properties for RegistrationToken definition.
 */
model RegistrationTokenMinimal {
  /**
   * Expiration time of registration token.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * The registration token base64 encoded string.
   */
  token?: string;
}

/**
 * List of private endpoint connection associated with the specified HostPool
 */
model PrivateEndpointConnectionOnHostPoolListResultWithSystemData
  is Azure.Core.Page<PrivateEndpointConnectionOnHostPoolWithSystemData>;

/**
 * List of private endpoint connection associated with the specified Workspace
 */
model PrivateEndpointConnectionOnWorkspaceListResultWithSystemData
  is Azure.Core.Page<PrivateEndpointConnectionOnHostPoolWithSystemData>;

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult is Azure.Core.Page<PrivateLinkResource>;

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * List of SessionHost definitions.
 */
model SessionHostList is Azure.Core.Page<SessionHost>;

/**
 * Schema for SessionHost properties.
 */
model SessionHostProperties {
  /**
   * ObjectId of SessionHost. (internal use)
   */
  @visibility("read")
  objectId?: string;

  /**
   * Last heart beat from SessionHost.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartBeat?: utcDateTime;

  /**
   * Number of sessions on SessionHost.
   */
  sessions?: int32;

  /**
   * Version of agent on SessionHost.
   */
  agentVersion?: string;

  /**
   * Allow a new session.
   */
  allowNewSession?: boolean;

  /**
   * Virtual Machine Id of SessionHost's underlying virtual machine.
   */
  @visibility("read")
  virtualMachineId?: string;

  /**
   * Resource Id of SessionHost's underlying virtual machine.
   */
  @visibility("read")
  resourceId?: string;

  /**
   * User assigned to SessionHost.
   */
  assignedUser?: string;

  /**
   * Friendly name of SessionHost
   */
  friendlyName?: string;

  /**
   * Status for a SessionHost.
   */
  status?: Status;

  /**
   * The timestamp of the status.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  statusTimestamp?: utcDateTime;

  /**
   * The version of the OS on the session host.
   */
  osVersion?: string;

  /**
   * The version of the side by side stack on the session host.
   */
  sxSStackVersion?: string;

  /**
   * Update state of a SessionHost.
   */
  updateState?: UpdateState;

  /**
   * The timestamp of the last update.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;

  /**
   * The error message.
   */
  updateErrorMessage?: string;

  /**
   * List of SessionHostHealthCheckReports
   */
  @visibility("read")
  sessionHostHealthCheckResults?: SessionHostHealthCheckReport[];
}

/**
 * The report for session host information.
 */
model SessionHostHealthCheckReport {
  /**
   * Represents the name of the health check operation performed.
   */
  @visibility("read")
  healthCheckName?: HealthCheckName;

  /**
   * Represents the Health state of the health check we performed.
   */
  @visibility("read")
  healthCheckResult?: HealthCheckResult;

  /**
   * Additional detailed information on the failure.
   */
  @visibility("read")
  additionalFailureDetails?: SessionHostHealthCheckFailureDetails;
}

/**
 * Contains details on the failure.
 */
model SessionHostHealthCheckFailureDetails {
  /**
   * Failure message: hints on what is wrong and how to recover.
   */
  @visibility("read")
  message?: string;

  /**
   * Error code corresponding for the failure.
   */
  @visibility("read")
  errorCode?: int32;

  /**
   * The timestamp of the last update.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHealthCheckDateTime?: utcDateTime;
}

/**
 * SessionHost properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SessionHostPatch extends Resource {
  /**
   * Detailed properties for SessionHost
   */
  properties?: SessionHostPatchProperties;
}

/**
 * SessionHost properties that can be patched.
 */
model SessionHostPatchProperties {
  /**
   * Allow a new session.
   */
  allowNewSession?: boolean;

  /**
   * User assigned to SessionHost.
   */
  assignedUser?: string;

  /**
   * Friendly name of SessionHost
   */
  friendlyName?: string;
}

/**
 * List of UserSession definitions.
 */
model UserSessionList is Azure.Core.Page<UserSession>;

/**
 * Schema for UserSession properties.
 */
model UserSessionProperties {
  /**
   * ObjectId of user session. (internal use)
   */
  @visibility("read")
  objectId?: string;

  /**
   * The user principal name.
   */
  userPrincipalName?: string;

  /**
   * Application type of application.
   */
  applicationType?: ApplicationType;

  /**
   * State of user session.
   */
  sessionState?: SessionState;

  /**
   * The active directory user name.
   */
  activeDirectoryUserName?: string;

  /**
   * The timestamp of the user session create.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;
}

/**
 * Represents message sent to a UserSession.
 */
model SendMessage {
  /**
   * Title of message.
   */
  messageTitle?: string;

  /**
   * Body of message.
   */
  messageBody?: string;
}

/**
 * Scaling plan properties that can be patched.
 */
model ScalingPlanPatch {
  /**
   * tags to be updated
   */
  tags?: Record<string>;

  /**
   * Detailed properties for scaling plan
   */
  properties?: ScalingPlanPatchProperties;
}

/**
 * Scaling plan properties.
 */
model ScalingPlanPatchProperties {
  /**
   * Description of scaling plan.
   */
  description?: string;

  /**
   * User friendly name of scaling plan.
   */
  friendlyName?: string;

  /**
   * Timezone of the scaling plan.
   */
  timeZone?: string;

  /**
   * Exclusion tag for scaling plan.
   */
  exclusionTag?: string;

  /**
   * List of ScalingSchedule definitions.
   */
  schedules?: ScalingSchedule[];

  /**
   * List of ScalingHostPoolReference definitions.
   */
  hostPoolReferences?: ScalingHostPoolReference[];
}

/**
 * List of ScalingPlanPersonalSchedule definitions.
 */
model ScalingPlanPersonalScheduleList
  is Azure.Core.Page<ScalingPlanPersonalSchedule>;

/**
 * A ScalingPlanPersonalSchedule.
 */
model ScalingPlanPersonalScheduleProperties {
  /**
   * Set of days of the week on which this schedule is active.
   */
  daysOfWeek?: DayOfWeek[];

  /**
   * Starting time for ramp up period.
   */
  rampUpStartTime?: Time;

  /**
   * The desired startup behavior during the ramp up period for personal vms in the hostpool.
   */
  rampUpAutoStartHosts?: StartupBehavior;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the ramp up phase. If this is disabled, session hosts must be turned on using rampUpAutoStartHosts or by turning them on manually.
   */
  rampUpStartVMOnConnect?: SetStartVMOnConnect;

  /**
   * Action to be taken after a user disconnect during the ramp up period.
   */
  rampUpActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the ramp up period.
   */
  rampUpMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the ramp up period.
   */
  rampUpActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the ramp up period.
   */
  rampUpMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for peak period.
   */
  peakStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the peak phase.
   */
  peakStartVMOnConnect?: SetStartVMOnConnect;

  /**
   * Action to be taken after a user disconnect during the peak period.
   */
  peakActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the peak period.
   */
  peakMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the peak period.
   */
  peakActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the peak period.
   */
  peakMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for ramp down period.
   */
  rampDownStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the ramp down phase.
   */
  rampDownStartVMOnConnect?: SetStartVMOnConnect;

  /**
   * Action to be taken after a user disconnect during the ramp down period.
   */
  rampDownActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the ramp down period.
   */
  rampDownMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the ramp down period.
   */
  rampDownActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the ramp down period.
   */
  rampDownMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for off-peak period.
   */
  offPeakStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the off-peak phase.
   */
  offPeakStartVMOnConnect?: SetStartVMOnConnect;

  /**
   * Action to be taken after a user disconnect during the off-peak period.
   */
  offPeakActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the off-peak period.
   */
  offPeakMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the off-peak period.
   */
  offPeakActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the off-peak period.
   */
  offPeakMinutesToWaitOnLogoff?: int32;
}

/**
 * ScalingPlanPersonalSchedule properties that can be patched.
 */
model ScalingPlanPersonalSchedulePatch {
  /**
   * Detailed properties for ScalingPlanPersonalSchedule
   */
  properties?: ScalingPlanPersonalScheduleProperties;
}

/**
 * List of ScalingPlanPooledSchedule definitions.
 */
model ScalingPlanPooledScheduleList
  is Azure.Core.Page<ScalingPlanPooledSchedule>;

/**
 * A ScalingPlanPooledSchedule.
 */
model ScalingPlanPooledScheduleProperties {
  /**
   * Set of days of the week on which this schedule is active.
   */
  daysOfWeek?: DayOfWeek[];

  /**
   * Starting time for ramp up period.
   */
  rampUpStartTime?: Time;

  /**
   * Load balancing algorithm for ramp up period.
   */
  rampUpLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  /**
   * Minimum host percentage for ramp up period.
   */
  @maxValue(100)
  rampUpMinimumHostsPct?: int32;

  /**
   * Capacity threshold for ramp up period.
   */
  @maxValue(100)
  @minValue(1)
  rampUpCapacityThresholdPct?: int32;

  /**
   * Starting time for peak period.
   */
  peakStartTime?: Time;

  /**
   * Load balancing algorithm for peak period.
   */
  peakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  /**
   * Starting time for ramp down period.
   */
  rampDownStartTime?: Time;

  /**
   * Load balancing algorithm for ramp down period.
   */
  rampDownLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  /**
   * Minimum host percentage for ramp down period.
   */
  @maxValue(100)
  rampDownMinimumHostsPct?: int32;

  /**
   * Capacity threshold for ramp down period.
   */
  @maxValue(100)
  @minValue(1)
  rampDownCapacityThresholdPct?: int32;

  /**
   * Should users be logged off forcefully from hosts.
   */
  rampDownForceLogoffUsers?: boolean;

  /**
   * Specifies when to stop hosts during ramp down period.
   */
  rampDownStopHostsWhen?: StopHostsWhen;

  /**
   * Number of minutes to wait to stop hosts during ramp down period.
   */
  rampDownWaitTimeMinutes?: int32;

  /**
   * Notification message for users during ramp down period.
   */
  rampDownNotificationMessage?: string;

  /**
   * Starting time for off-peak period.
   */
  offPeakStartTime?: Time;

  /**
   * Load balancing algorithm for off-peak period.
   */
  offPeakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;
}

/**
 * ScalingPlanPooledSchedule properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ScalingPlanPooledSchedulePatch extends Resource {
  /**
   * Detailed properties for ScalingPlanPooledSchedule
   */
  properties?: ScalingPlanPooledScheduleProperties;
}

/**
 * Workspace properties that can be patched.
 */
model WorkspacePatch {
  /**
   * tags to be updated
   */
  tags?: Record<string>;

  /**
   * Detailed properties for Workspace
   */
  properties?: WorkspacePatchProperties;
}

/**
 * Workspace properties that can be patched.
 */
model WorkspacePatchProperties {
  /**
   * Description of Workspace.
   */
  description?: string;

  /**
   * Friendly name of Workspace.
   */
  friendlyName?: string;

  /**
   * List of applicationGroup links.
   */
  applicationGroupReferences?: string[];

  /**
   * Enabled to allow this resource to be access from the public network
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * List of MSIX Package definitions.
 */
model MsixPackageList is Azure.Core.Page<MsixPackage>;

/**
 * Schema for MSIX Package properties.
 */
model MsixPackageProperties {
  /**
   * VHD/CIM image path on Network Share.
   */
  imagePath?: string;

  /**
   * Package Name from appxmanifest.xml.
   */
  packageName?: string;

  /**
   * Package Family Name from appxmanifest.xml. Contains Package Name and Publisher name.
   */
  packageFamilyName?: string;

  /**
   * User friendly Name to be displayed in the portal.
   */
  displayName?: string;

  /**
   * Relative Path to the package inside the image.
   */
  packageRelativePath?: string;

  /**
   * Specifies how to register Package in feed.
   */
  isRegularRegistration?: boolean;

  /**
   * Make this version of the package the active one across the hostpool.
   */
  isActive?: boolean;

  /**
   * List of package dependencies.
   */
  packageDependencies?: MsixPackageDependencies[];

  /**
   * Package version found in the appxmanifest.xml.
   */
  version?: string;

  /**
   * Date Package was last updated, found in the appxmanifest.xml.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * List of package applications.
   */
  packageApplications?: MsixPackageApplications[];
}

/**
 * MSIX Package properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MsixPackagePatch extends Resource {
  /**
   * Detailed properties for MSIX Package
   */
  properties?: MsixPackagePatchProperties;
}

/**
 * MSIX Package properties that can be patched.
 */
model MsixPackagePatchProperties {
  /**
   * Set a version of the package to be active across hostpool.
   */
  isActive?: boolean;

  /**
   * Set Registration mode. Regular or Delayed.
   */
  isRegularRegistration?: boolean;

  /**
   * Display name for MSIX Package.
   */
  displayName?: string;
}
