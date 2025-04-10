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
 * Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
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

  /**
   * Users will be assigned a SessionHost either by administrators (PersonalDesktopAssignmentType = Direct) or upon connecting to the pool (PersonalDesktopAssignmentType = Automatic). They will always be redirected to their assigned SessionHost.
   */
  Personal: "Personal",
}

/**
 * The desired scaling method to be used to scale the hosts in the assigned host pool.
 */
union ScalingMethod {
  string,

  /**
   * Scaling will manage hosts in the host pool by power managing the hosts, but will not change the host pool size.
   */
  PowerManage: "PowerManage",

  /**
   * Scaling will manage the hosts in the host pool by power managing the hosts, as well as creating and deleting hosts to modify the host pool size. This requires the create delete object to be set, and the assigned hostpool to have a session host config property.
   */
  CreateDeletePowerManage: "CreateDeletePowerManage",
}

/**
 * Load balancing algorithm for ramp up period.
 */
union SessionHostLoadBalancingAlgorithm {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BreadthFirst: "BreadthFirst",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DepthFirst: "DepthFirst",
}

/**
 * Specifies when to stop hosts during ramp down period.
 */
union StopHostsWhen {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ZeroSessions: "ZeroSessions",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ZeroActiveSessions: "ZeroActiveSessions",
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enable: "Enable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disable: "Disable",
}

/**
 * Action to be taken after a user disconnect during the ramp up period.
 */
union SessionHandlingOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deallocate: "Deallocate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hibernate: "Hibernate",
}

/**
 * Resource Type of ApplicationGroup.
 */
union ApplicationGroupType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemoteApp: "RemoteApp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Desktop: "Desktop",
}

/**
 * Resource Type of Application.
 */
union RemoteApplicationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InBuilt: "InBuilt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MsixApplication: "MsixApplication",
}

/**
 * Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all.
 */
union CommandLineSetting {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DoNotAllow: "DoNotAllow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Require: "Require",
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Automatic: "Automatic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Direct: "Direct",
}

/**
 * The type of the load balancer.
 */
union LoadBalancerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BreadthFirst: "BreadthFirst",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DepthFirst: "DepthFirst",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Persistent: "Persistent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MultiplePersistent: "MultiplePersistent",
}

/**
 * The type of resetting the token.
 */
union RegistrationTokenOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Update: "Update",
}

/**
 * The type of management for this hostpool, Automated or Standard. The default value is Automated.
 */
union ManagementType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Automated: "Automated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
}

/**
 * The type of single sign on Secret Type.
 */
union SSOSecretType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SharedKey: "SharedKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Certificate: "Certificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SharedKeyInKeyVault: "SharedKeyInKeyVault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CertificateInKeyVault: "CertificateInKeyVault",
}

/**
 * The type of preferred application group type, default to Desktop Application Group
 */
union PreferredAppGroupType {
  string,

  /**
   * This value is read only, it is not accepted on input.
   */
  None: "None",

  /**
   * Users access the full Windows desktop from a session host. Available with pooled or personal host pools.
   */
  Desktop: "Desktop",

  /**
   * Users access individual applications you select and publish to the application group. Available with pooled host pools only.
   */
  RailApplications: "RailApplications",
}

/**
 * Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints
 */
union HostpoolPublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EnabledForSessionHostsOnly: "EnabledForSessionHostsOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
 * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
 */
union ManagedPrivateUDP {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
 */
union DirectUDP {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
 */
union PublicUDP {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
 */
union RelayUDP {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Action types for controlling hostpool update.
 */
union HostPoolUpdateAction {
  string,

  /**
   * Start the hostpool update.
   */
  Start: "Start",

  /**
   * Pause the hostpool update.
   */
  Pause: "Pause",

  /**
   * Cancel the hostpool update.
   */
  Cancel: "Cancel",

  /**
   * Retry the hostpool update.
   */
  Retry: "Retry",

  /**
   * Resume the hostpool update.
   */
  Resume: "Resume",
}

/**
 * Provisioning state of the Session Host Configuration.
 */
union ProvisioningStateSHC {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
}

/**
 * The disk type used by virtual machine in hostpool session host.
 */
union VirtualMachineDiskType {
  string,

  /**
   * Standard HDD locally redundant storage. Best for backup, non-critical, and infrequent access.
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Premium SSD locally redundant storage. Best for production and performance sensitive workloads.
   */
  Premium_LRS: "Premium_LRS",

  /**
   * Standard SSD locally redundant storage. Best for web servers, lightly used enterprise applications and dev/test.
   */
  StandardSSD_LRS: "StandardSSD_LRS",
}

/**
 * The type of image session hosts use in the hostpool.
 */
union Type {
  string,

  /**
   * Using default marketplace images offered by Azure Marketplace.
   */
  Marketplace: "Marketplace",

  /**
   * Using a custom image.
   */
  Custom: "Custom",
}

/**
 * The type of domain join done by the virtual machine.
 */
union DomainJoinType {
  string,

  /**
   * Using microsoft active directory.
   */
  ActiveDirectory: "ActiveDirectory",

  /**
   * Using microsoft azure active directory.
   */
  AzureActiveDirectory: "AzureActiveDirectory",
}

/**
 * The security type used by virtual machine in hostpool session host. Default is Standard.
 */
union VirtualMachineSecurityType {
  string,

  /**
   * Standard security protocol. No additional parameters
   */
  Standard: "Standard",

  /**
   * TrustedLaunch allows for secure boot adn vTPM
   */
  TrustedLaunch: "TrustedLaunch",

  /**
   * Confidential Virtual Machine security protocol
   */
  ConfidentialVM: "ConfidentialVM",
}

/**
 * Application type of application.
 */
union ApplicationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemoteApp: "RemoteApp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Desktop: "Desktop",
}

/**
 * State of user session.
 */
union SessionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LogOff: "LogOff",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserProfileDiskMounted: "UserProfileDiskMounted",
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Initial: "Initial",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Started: "Started",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
 * Possible device architectures that an app attach package can be configured for
 */
union AppAttachPackageArchitectures {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ARM: "ARM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ARM64: "ARM64",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x86: "x86",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x64: "x64",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Neutral: "Neutral",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x86a64: "x86a64",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ALL: "ALL",
}

/**
 * The current provisioning state.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Is package timestamped so it can ignore the certificate expiry date
 */
union PackageTimestamped {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Timestamped: "Timestamped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotTimestamped: "NotTimestamped",
}

/**
 * Parameter indicating how the health check should behave if this package fails staging
 */
union FailHealthCheckOnStagingFailure {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unhealthy: "Unhealthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NeedsAssistance: "NeedsAssistance",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DoNotFail: "DoNotFail",
}

/**
 * Hostpool update fault type.
 */
union FaultType {
  string,

  /**
   * Fault caused by service error.
   */
  ServiceError: "ServiceError",

  /**
   * Fault caused by user error.
   */
  UserError: "UserError",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union OperationTypeSHM {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InitiateSessionHostUpdate: "InitiateSessionHostUpdate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidateSessionHostUpdate: "ValidateSessionHostUpdate",
}

/**
 * Day of the week.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
 * Schema for Workspace properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WorkspaceProperties {
  /**
   * ObjectId of Workspace. (internal use)
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  cloudPcResource?: boolean;

  /**
   * Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * List of private endpoint connection associated with the specified resource
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * The private endpoint connection resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateEndpointConnection extends Resource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of the private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The private endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for private endpoint.
   */
  @visibility(Lifecycle.Read)
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The resource model definition containing the full set of allowed properties for a resource. Except properties bag, there cannot be a top level property outside of this set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceModelWithAllowedPropertySet extends TrackedResource {
  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedBy?: string;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type. E.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  /**
   * The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: ManagedServiceIdentity;

  /**
   * The resource model definition representing SKU
   */
  sku?: Sku;

  /**
   * Plan for the resource.
   */
  plan?: Plan;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
   */
  type: ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

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
 * Workspace properties that can be patched.
 */
model WorkspacePatch {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Detailed properties for Workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * List of private endpoint connection associated with the specified storage account
 */
model PrivateEndpointConnectionListResultWithSystemData
  is Azure.Core.Page<PrivateEndpointConnectionWithSystemData>;

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * List of Workspace definitions.
 */
model WorkspaceList is Azure.Core.Page<Workspace>;

/**
 * Scaling plan properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ScalingPlanProperties {
  /**
   * ObjectId of scaling plan. (internal use)
   */
  @visibility(Lifecycle.Read)
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
   * List of Pooled ScalingSchedule definitions.
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
  daysOfWeek?: DayOfWeek[];

  /**
   * The desired scaling method to be used to scale the hosts in the assigned host pool.
   */
  scalingMethod?: ScalingMethod;

  /**
   * The properties that control how Scaling will manage the size of the hostpool by creating and deleting hosts.
   */
  createDelete?: CreateDeleteProperties;

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
 * The properties that control how Scaling will manage the size of the hostpool by creating and deleting hosts.
 */
model CreateDeleteProperties {
  /**
   * Maximum number of session hosts that may be created by the Scaling Service. This requires the assigned hostpool to have a session host config property.
   */
  rampUpMaximumHostPoolSize?: int32;

  /**
   * Minimum number of session hosts that will be be created by the Scaling Service. Scaling will not delete any hosts when this limit is met. This requires the assigned hostpool to have a session host config property.
   */
  @maxValue(59)
  rampUpMinimumHostPoolSize?: int32;

  /**
   * Maximum number of session hosts that may be created by the Scaling Service. This requires the assigned hostpool to have a session host config property.
   */
  rampDownMaximumHostPoolSize?: int32;

  /**
   * Minimum number of session hosts that will be be created by the Scaling Service. Scaling will not delete any hosts when this limit is met. This requires the assigned hostpool to have a session host config property.
   */
  @maxValue(59)
  rampDownMinimumHostPoolSize?: int32;
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
 * Scaling plan properties that can be patched.
 */
model ScalingPlanPatch {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Detailed properties for scaling plan
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
   * List Pooled ScalingSchedule definitions.
   */
  schedules?: ScalingSchedule[];

  /**
   * List of ScalingHostPoolReference definitions.
   */
  hostPoolReferences?: ScalingHostPoolReference[];
}

/**
 * List of scaling plan definitions.
 */
model ScalingPlanList is Azure.Core.Page<ScalingPlan>;

/**
 * A ScalingPlanPooledSchedule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ScalingPlanPooledScheduleProperties {
  /**
   * Name of the ScalingPlanPooledSchedule.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Set of days of the week on which this schedule is active.
   */
  daysOfWeek: DayOfWeek[];

  /**
   * The desired scaling method to be used to scale the hosts in the assigned host pool.
   */
  scalingMethod?: ScalingMethod;

  /**
   * The properties that control how Scaling will manage the size of the hostpool by creating and deleting hosts.
   */
  createDelete?: CreateDeleteProperties;

  /**
   * Starting time for ramp up period.
   */
  rampUpStartTime: Time;

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
  rampUpCapacityThresholdPct: int32;

  /**
   * Starting time for peak period.
   */
  peakStartTime: Time;

  /**
   * Load balancing algorithm for peak period.
   */
  peakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  /**
   * Starting time for ramp down period.
   */
  rampDownStartTime: Time;

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
  rampDownCapacityThresholdPct: int32;

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
  offPeakStartTime: Time;

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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ScalingPlanPooledSchedulePatchProperties;
}

/**
 * A ScalingPlanPooledSchedule.
 */
model ScalingPlanPooledSchedulePatchProperties {
  /**
   * Name of the ScalingPlanPooledSchedule.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Set of days of the week on which this schedule is active.
   */
  daysOfWeek?: DayOfWeek[];

  /**
   * The desired scaling method to be used to scale the hosts in the assigned host pool.
   */
  scalingMethod?: ScalingMethod;

  /**
   * The properties that control how Scaling will manage the size of the hostpool by creating and deleting hosts.
   */
  createDelete?: CreateDeleteProperties;

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
 * List of ScalingPlanPooledSchedule definitions.
 */
model ScalingPlanPooledScheduleList
  is Azure.Core.Page<ScalingPlanPooledSchedule>;

/**
 * A ScalingPlanPersonalSchedule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ScalingPlanPersonalScheduleProperties {
  /**
   * Set of days of the week on which this schedule is active.
   */
  daysOfWeek: DayOfWeek[];

  /**
   * Starting time for ramp up period.
   */
  rampUpStartTime: Time;

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
  peakStartTime: Time;

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
  rampDownStartTime: Time;

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
  offPeakStartTime: Time;

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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ScalingPlanPersonalSchedulePatchProperties;
}

/**
 * A ScalingPlanPersonalSchedule.
 */
model ScalingPlanPersonalSchedulePatchProperties {
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
 * List of ScalingPlanPersonalSchedule definitions.
 */
model ScalingPlanPersonalScheduleList
  is Azure.Core.Page<ScalingPlanPersonalSchedule>;

/**
 * Schema for ApplicationGroup properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ApplicationGroupProperties {
  /**
   * ObjectId of ApplicationGroup. (internal use)
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  workspaceArmPath?: string;

  /**
   * Resource Type of ApplicationGroup.
   */
  applicationGroupType: ApplicationGroupType;

  /**
   * Is cloud pc resource.
   */
  @visibility(Lifecycle.Read)
  cloudPcResource?: boolean;

  /**
   * Boolean representing whether the applicationGroup is show in the feed.
   */
  showInFeed?: boolean;
}

/**
 * ApplicationGroup properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApplicationGroupPatch extends Resource {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * ApplicationGroup properties that can be patched.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * List of ApplicationGroup definitions.
 */
model ApplicationGroupList is Azure.Core.Page<ApplicationGroup>;

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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * Schema for Application properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ApplicationProperties {
  /**
   * ObjectId of Application. (internal use)
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  msixPackageFamilyName?: string;

  /**
   * Specifies the package application Id for MSIX applications
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  msixPackageApplicationId?: string;

  /**
   * Resource Type of Application.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
  iconHash?: string;

  /**
   * the icon a 64 bit string as a byte array.
   */
  @visibility(Lifecycle.Read)
  iconContent?: bytes;
}

/**
 * Application properties that can be patched.
 */
model ApplicationPatch {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Detailed properties for Application
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * List of Application definitions.
 */
model ApplicationList is Azure.Core.Page<Application>;

/**
 * Schema for Desktop properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DesktopProperties {
  /**
   * ObjectId of Desktop. (internal use)
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  iconHash?: string;

  /**
   * The icon a 64 bit string as a byte array.
   */
  @visibility(Lifecycle.Read)
  iconContent?: bytes;
}

/**
 * Desktop properties that can be patched.
 */
model DesktopPatch {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Detailed properties for Desktop
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * List of Desktop definitions.
 */
model DesktopList is Azure.Core.Page<Desktop>;

/**
 * Properties of HostPool.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model HostPoolProperties {
  /**
   * ObjectId of HostPool. (internal use)
   */
  @visibility(Lifecycle.Read)
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
   * The registration info of HostPool. This is not returned on GET. In order to get the registration token use the retrieveRegistrationToken or listRegistrationTokens POST calls.
   */
  registrationInfo?: RegistrationInfo;

  /**
   * VM template for sessionhosts configuration within hostpool.
   */
  vmTemplate?: string;

  /**
   * The type of management for this hostpool, Automated or Standard. The default value is Automated.
   */
  managementType?: ManagementType;

  /**
   * List of applicationGroup links.
   */
  @visibility(Lifecycle.Read)
  applicationGroupReferences?: string[];

  /**
   * List of App Attach Package links.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
 * Represents a RegistrationInfo definition.  This is not returned on HostPool GET. In order to get the registration token use the retrieveRegistrationToken or listRegistrationTokens POST calls.
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
 * HostPool properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HostPoolPatch extends Resource {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * HostPool properties that can be patched.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
   * The registration info of HostPool.  This is not returned on GET. In order to get the registration token use the retrieveRegistrationToken or listRegistrationTokens POST calls.
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
 * Represents a RegistrationInfo definition.  This is not returned on HostPool GET. In order to get the registration token use the retrieveRegistrationToken or listRegistrationTokens POST calls.
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
 * List of HostPool definitions.
 */
model HostPoolList is Azure.Core.Page<HostPool>;

/**
 * Session host Managements of HostPool.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SessionHostManagementProperties {
  /**
   * Time zone for sessionHostManagement operations as defined in https://docs.microsoft.com/dotnet/api/system.timezoneinfo.findsystemtimezonebyid. Must be set if useLocalTime is true.
   */
  scheduledDateTimeZone: string;

  /**
   * Parameters for a hostpool update.
   */
  update: HostPoolUpdateConfigurationProperties;
}

/**
 * The configurations of a hostpool update.
 */
model HostPoolUpdateConfigurationProperties {
  /**
   * Whether not to save original disk. False by default.
   */
  deleteOriginalVm?: boolean;

  /**
   * The maximum number of virtual machines to be removed during hostpool update.
   */
  @minValue(1)
  maxVmsRemoved: int32;

  /**
   * Grace period before logging off users in minutes.
   */
  logOffDelayMinutes: int32;

  /**
   * Log off message sent to user for logoff. Default value is an empty string.
   */
  @maxLength(260)
  logOffMessage?: string = "";
}

/**
 * Represents a SessionHostManagementPatch definition.
 */
model SessionHostManagementPatch {
  /**
   * Detailed properties for SessionHostManagementPatch
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SessionHostManagementPatchProperties;
}

/**
 * Session host Managements of HostPool.
 */
model SessionHostManagementPatchProperties {
  /**
   * Time zone for sessionHostManagement operations as defined in https://docs.microsoft.com/dotnet/api/system.timezoneinfo.findsystemtimezonebyid. Must be set if useLocalTime is true.
   */
  scheduledDateTimeZone?: string;

  /**
   * Parameters for a hostpool update.
   */
  update?: HostPoolUpdateConfigurationPatchProperties;
}

/**
 * The configurations of a hostpool update.
 */
model HostPoolUpdateConfigurationPatchProperties {
  /**
   * Whether not to save original disk. False by default.
   */
  deleteOriginalVm?: boolean;

  /**
   * The maximum number of virtual machines to be removed during hostpool update.
   */
  @minValue(1)
  maxVmsRemoved?: int32;

  /**
   * Grace period before logging off users in minutes.
   */
  logOffDelayMinutes?: int32;

  /**
   * Log off message sent to user for logoff.
   */
  @maxLength(260)
  logOffMessage?: string;
}

/**
 * List of SessionHostManagement definitions.
 */
model SessionHostManagementList is Azure.Core.Page<SessionHostManagement>;

/**
 * Object containing the definition for properties to be used for a sessionHostUpdate operation.
 */
model UpdateSessionHostsRequestBody {
  /**
   * The timestamp that the update validation is scheduled for. If none is provided, the update will be executed immediately
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledDateTime?: utcDateTime;

  /**
   * The timeZone as defined in https://docs.microsoft.com/dotnet/api/system.timezoneinfo.findsystemtimezonebyid.
   */
  scheduledDateTimeZone?: string;

  /**
   * settings for management information for the hostpool update operation. If none is provided the update will use the settings saved in the sessionHostManagement object.
   */
  update?: HostPoolUpdateConfigurationPatchProperties;
}

/**
 * Represents properties for a hostpool update control request.
 */
model HostPoolUpdateControlParameter {
  /**
   * Action types for controlling hostpool update.
   */
  action: HostPoolUpdateAction;

  /**
   * The cancel message sent to the user on the session host. This is can only be specified if the action is 'Cancel'.
   */
  @maxLength(260)
  cancelMessage?: string;
}

/**
 * The current status of the session host update async operation.
 */
model SessionHostManagementUpdateStatus {
  /**
   * Fully qualified ID for the async operation.
   */
  id?: string;

  /**
   * Name of the async operation.
   */
  name?: string;

  /**
   * Operation status. Current defined values are < Error | Scheduled | UpdatingSessionHosts | ValidatingSessionHostUpdate | Paused | Pausing | Cancelling > | Succeeded | Failed | Canceled
   */
  status: string;

  /**
   * Percent of the operation that is complete.
   */
  @maxValue(100)
  percentComplete?: float32;

  /**
   * The start time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * If present, details of the operation error.
   */
  error?: ErrorDetail;

  /**
   * The custom properties of the SessionHost Update Status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SessionHostManagementUpdateStatusProperties;
}

/**
 * Properties bag to hold custom RP properties for sessionHostManagement Update Statuses.
 */
model SessionHostManagementUpdateStatusProperties {
  /**
   * The Log Analytics.
   */
  correlationId?: string;

  /**
   * Progress information on the sessionHostManagement operation.
   */
  progress?: SessionHostManagementOperationProgress;

  /**
   * The timestamp that the update is scheduled for.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledDateTime?: utcDateTime;

  /**
   * SessionHostManagement properties used for the operation.
   */
  sessionHostManagement?: SessionHostManagement;
}

/**
 * SessionHostManagement Operation Progress information.
 */
model SessionHostManagementOperationProgress {
  /**
   * Time that the sessionHostManagement operation was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executionStartTime?: utcDateTime;

  /**
   * The number of sessionHosts to be started in the sessionHostManagement operation.
   */
  totalSessionHosts?: int32;

  /**
   * The number of sessionHosts in progress in the sessionHostManagement operation.
   */
  sessionHostsInProgress?: int32;

  /**
   * The number of sessionHosts completed in the sessionHostManagement operation.
   */
  sessionHostsCompleted?: int32;

  /**
   * The number of sessionHosts rollback failed in the sessionHostManagement operation.
   */
  sessionHostsRollbackFailed?: int32;
}

/**
 * Session host configurations of HostPool.
 */
model SessionHostConfigurationProperties {
  /**
   * The timestamp of the last update.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  version?: utcDateTime;

  /**
   * Friendly name to describe this version of the SessionHostConfiguration.
   */
  @maxLength(260)
  friendlyName?: string;

  /**
   * Provisioning state of the Session Host Configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateSHC;

  /**
   * Hashtable that lists key/value pair tags to apply to the VMs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  vmTags?: Record<string>;

  /**
   * The Location for the session host to be created in. It will default to the location of the hostpool if not provided.
   */
  vmLocation?: string;

  /**
   * The ResourceGroup for the session hosts to be created in. It will default to the ResourceGroup of the hostpool if not provided.
   */
  vmResourceGroup?: string;

  /**
   * The prefix that should be associated with session host names
   */
  @maxLength(11)
  vmNamePrefix: string;

  /**
   * Value for availability zones to be used by the session host. Should be from [1,2,3].
   */
  availabilityZones?: int32[];

  /**
   * Network information.
   */
  networkInfo: NetworkInfoProperties;

  /**
   * The id of the size of a virtual machine connected to a hostpool. Example: Standard_D2as_v6
   */
  vmSizeId: string;

  /**
   * Disk information.
   */
  diskInfo: DiskInfoProperties;

  /**
   * The uri to the storage blob containing the arm template to be run on the virtual machine after provisioning.
   */
  customConfigurationScriptUrl?: url;

  /**
   * Image configurations of HostPool.
   */
  imageInfo: ImageInfoProperties;

  /**
   * Domain configurations of session hosts.
   */
  domainInfo: DomainInfoProperties;

  /**
   * Security information.
   */
  securityInfo?: SecurityInfoProperties;

  /**
   * Local Admin credentials for session hosts.
   */
  vmAdminCredentials: KeyVaultCredentialsProperties;

  /**
   * Boot Diagnostics information.
   */
  bootDiagnosticsInfo?: BootDiagnosticsInfoProperties;
}

/**
 * Network information.
 */
model NetworkInfoProperties {
  /**
   * The resource ID of the subnet.
   */
  subnetId: Azure.Core.armResourceIdentifier;

  /**
   * The resource ID of the security group. Any allowable/open ports should be specified in the Network Security Group(NSG).
   */
  securityGroupId?: string;
}

/**
 * Disk information.
 */
model DiskInfoProperties {
  /**
   * The disk type used by virtual machine in hostpool session host.
   */
  type: VirtualMachineDiskType;
}

/**
 * Image configurations of session host in a HostPool.
 */
model ImageInfoProperties {
  /**
   * The type of image session hosts use in the hostpool.
   */
  type: Type;

  /**
   * The values to uniquely identify a marketplace image. Only one should be populated based on the image type.
   */
  marketplaceInfo?: MarketplaceInfoProperties;

  /**
   * The values to uniquely identify a custom image. Only one should be populated based on the image type.
   */
  customInfo?: CustomInfoProperties;
}

/**
 * Marketplace image information.
 */
model MarketplaceInfoProperties {
  /**
   * The offer of the image.
   */
  offer: string;

  /**
   * The publisher of the image.
   */
  publisher: string;

  /**
   * The sku of the image.
   */
  sku: string;

  /**
   * The exact version of the image.
   */
  exactVersion: string;
}

/**
 * Custom image information.
 */
model CustomInfoProperties {
  /**
   * The resource id of the custom image.
   */
  resourceId: Azure.Core.armResourceIdentifier;
}

/**
 * Domain configurations of session hosts.
 */
model DomainInfoProperties {
  /**
   * The type of domain join done by the virtual machine.
   */
  joinType: DomainJoinType;

  /**
   * Active directory info. Only one should be populated based on the join type.
   */
  activeDirectoryInfo?: ActiveDirectoryInfoProperties;

  /**
   * Azure active directory info. Only one should be populated based on the join type.
   */
  azureActiveDirectoryInfo?: AzureActiveDirectoryInfoProperties;
}

/**
 * Active directory info. Only one should be populated based on the join type.
 */
model ActiveDirectoryInfoProperties {
  /**
   * Credentials needed to create the virtual machine.
   */
  domainCredentials: KeyVaultCredentialsProperties;

  /**
   * The organizational unit(OU) path.
   */
  ouPath: string;

  /**
   * The domain a virtual machine connected to a hostpool will join.
   */
  domainName?: string;
}

/**
 * Credentials kept in the keyvault.
 */
model KeyVaultCredentialsProperties {
  /**
   * The uri to access the secret that the username is stored in.
   */
  usernameKeyVaultSecretUri: url;

  /**
   * The uri to access the secret that the password is stored in.
   */
  passwordKeyVaultSecretUri: url;
}

/**
 * Azure Active directory info. Only one should be populated based on the join type.
 */
model AzureActiveDirectoryInfoProperties {
  /**
   * The Mobile Device Management(MDM) guid.
   */
  mdmProviderGuid: string;
}

/**
 * Security information.
 */
model SecurityInfoProperties {
  /**
   * The security type used by virtual machine in hostpool session host. Default is Standard.
   */
  type?: VirtualMachineSecurityType;

  /**
   * Whether to use secureBoot on the virtual machine.
   */
  secureBootEnabled?: boolean;

  /**
   * Whether to use vTPM on the virtual machine.
   */
  vTpmEnabled?: boolean;
}

/**
 * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. <br><br> You can easily view the output of your console log. <br><br> Azure also enables you to see a screenshot of the VM from the hypervisor.
 */
model BootDiagnosticsInfoProperties {
  /**
   * Whether boot diagnostics should be enabled on the Virtual Machine.
   */
  enabled?: boolean;

  /**
   * Uri of the storage account to use for placing the console output and screenshot. <br><br>If storageUri is not specified while enabling boot diagnostics, managed storage will be used.
   */
  storageUri?: url;
}

/**
 * Represents a SessionHostConfigurationPatch definition.
 */
model SessionHostConfigurationPatch {
  /**
   * Detailed properties for SessionHostConfigurationPatch
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SessionHostConfigurationPatchProperties;
}

/**
 * Session host configurations of HostPool.
 */
model SessionHostConfigurationPatchProperties {
  /**
   * Friendly name to describe this version of the SessionHostConfiguration.
   */
  @maxLength(260)
  friendlyName?: string;

  /**
   * Hashtable that lists key/value pair tags to apply to the VMs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  vmTags?: Record<string>;

  /**
   * The Location for the session host to be created in
   */
  vmLocation?: string;

  /**
   * The ResourceGroup for the session hosts to be created in. It will default to the ResourceGroup of the hostpool if not provided.
   */
  vmResourceGroup?: string;

  /**
   * The prefix that should be associated with session host names
   */
  @maxLength(11)
  vmNamePrefix?: string;

  /**
   * Value for availability zones to be used by the session host. Should be from [1,2,3].
   */
  availabilityZones?: int32[];

  /**
   * Network information.
   */
  networkInfo?: NetworkInfoPatchProperties;

  /**
   * The id of the size of a virtual machine connected to a hostpool. Example: Standard_D2as_v6
   */
  vmSizeId?: string;

  /**
   * Disk information.
   */
  diskInfo?: DiskInfoPatchProperties;

  /**
   * The uri to the storage blob containing the arm template to be run on the virtual machine after provisioning.
   */
  customConfigurationScriptUrl?: url;

  /**
   * Image configurations of HostPool.
   */
  imageInfo?: ImageInfoPatchProperties;

  /**
   * Domain configurations of session hosts.
   */
  domainInfo?: DomainInfoPatchProperties;

  /**
   * Security information.
   */
  securityInfo?: SecurityInfoPatchProperties;

  /**
   * Local Admin credentials for session hosts.
   */
  vmAdminCredentials?: KeyVaultCredentialsPatchProperties;

  /**
   * Boot Diagnostics information.
   */
  bootDiagnosticsInfo?: BootDiagnosticsInfoPatchProperties;
}

/**
 * Network information.
 */
model NetworkInfoPatchProperties {
  /**
   * The resource ID of the subnet.
   */
  subnetId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource ID of the security group. Any allowable/open ports should be specified in the Network Security Group(NSG).
   */
  securityGroupId?: string;
}

/**
 * Disk information.
 */
model DiskInfoPatchProperties {
  /**
   * The disk type used by virtual machine in hostpool session host.
   */
  type?: VirtualMachineDiskType;
}

/**
 * Image configurations of session host in a HostPool.
 */
model ImageInfoPatchProperties {
  /**
   * The type of image session hosts use in the hostpool.
   */
  type?: Type;

  /**
   * The values to uniquely identify a marketplace image. Only one should be populated based on the image type.
   */
  marketplaceInfo?: MarketplaceInfoPatchProperties;

  /**
   * The values to uniquely identify a custom image. Only one should be populated based on the image type.
   */
  customInfo?: CustomInfoPatchProperties;
}

/**
 * Marketplace image information.
 */
model MarketplaceInfoPatchProperties {
  /**
   * The offer of the image.
   */
  offer?: string;

  /**
   * The publisher of the image.
   */
  publisher?: string;

  /**
   * The sku of the image.
   */
  sku?: string;

  /**
   * The exact version of the image.
   */
  exactVersion?: string;
}

/**
 * Custom image information.
 */
model CustomInfoPatchProperties {
  /**
   * The resource id of the custom image.
   */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Domain configurations of session hosts.
 */
model DomainInfoPatchProperties {
  /**
   * Active directory info. Only one should be populated based on the join type.
   */
  activeDirectoryInfo?: ActiveDirectoryInfoPatchProperties;
}

/**
 * Active directory info. Only one should be populated based on the join type.
 */
model ActiveDirectoryInfoPatchProperties {
  /**
   * Credentials needed to create the virtual machine.
   */
  domainCredentials?: KeyVaultCredentialsPatchProperties;
}

/**
 * Credentials kept in the keyvault.
 */
model KeyVaultCredentialsPatchProperties {
  /**
   * The uri to access the secret that the username is stored in.
   */
  usernameKeyVaultSecretUri?: url;

  /**
   * The uri to access the secret that the password is stored in.
   */
  passwordKeyVaultSecretUri?: url;
}

/**
 * Security information.
 */
model SecurityInfoPatchProperties {
  /**
   * The security type used by virtual machine in hostpool session host.
   */
  type?: VirtualMachineSecurityType;

  /**
   * Whether to use secureBoot on the virtual machine.
   */
  secureBootEnabled?: boolean;

  /**
   * Whether to use vTPM on the virtual machine.
   */
  vTpmEnabled?: boolean;
}

/**
 * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. <br><br> You can easily view the output of your console log. <br><br> Azure also enables you to see a screenshot of the VM from the hypervisor.
 */
model BootDiagnosticsInfoPatchProperties {
  /**
   * Whether boot diagnostics should be enabled on the Virtual Machine.
   */
  enabled?: boolean;

  /**
   * Uri of the storage account to use for placing the console output and screenshot. <br><br>If storageUri is not specified while enabling boot diagnostics, managed storage will be used.
   */
  storageUri?: string;
}

/**
 * List of SessionHostConfiguration definitions.
 */
model SessionHostConfigurationList is Azure.Core.Page<SessionHostConfiguration>;

/**
 * Session host configurations of HostPool.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ActiveSessionHostConfigurationProperties {
  /**
   * The timestamp of the last update.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  version?: utcDateTime;

  /**
   * Friendly name to describe this version of the SessionHostConfiguration.
   */
  @maxLength(260)
  friendlyName?: string;

  /**
   * Hashtable that lists key/value pair tags to apply to the VMs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  vmTags?: Record<string>;

  /**
   * The Location for the session host to be created in. It will default to the location of the hostpool if not provided.
   */
  vmLocation?: string;

  /**
   * The ResourceGroup for the session hosts to be created in. It will default to the ResourceGroup of the hostpool if not provided.
   */
  vmResourceGroup?: string;

  /**
   * The prefix that should be associated with session host names
   */
  @maxLength(11)
  vmNamePrefix: string;

  /**
   * Value for availability zones to be used by the session host. Should be from [1,2,3].
   */
  availabilityZones?: int32[];

  /**
   * Network information.
   */
  networkInfo: NetworkInfoProperties;

  /**
   * The id of the size of a virtual machine connected to a hostpool. Example: Standard_D2as_v6
   */
  vmSizeId: string;

  /**
   * Disk information.
   */
  diskInfo: DiskInfoProperties;

  /**
   * The uri to the storage blob containing the arm template to be run on the virtual machine after provisioning.
   */
  customConfigurationScriptUrl?: url;

  /**
   * Image configurations of HostPool.
   */
  imageInfo: ImageInfoProperties;

  /**
   * Domain configurations of session hosts.
   */
  domainInfo: DomainInfoProperties;

  /**
   * Security information.
   */
  securityInfo?: SecurityInfoProperties;

  /**
   * Local Admin credentials for session hosts.
   */
  vmAdminCredentials: KeyVaultCredentialsProperties;

  /**
   * Boot Diagnostics information.
   */
  bootDiagnosticsInfo?: BootDiagnosticsInfoProperties;
}

/**
 * List of ActiveSessionHostConfiguration definitions.
 */
model ActiveSessionHostConfigurationList
  is Azure.Core.Page<ActiveSessionHostConfiguration>;

/**
 * List of RegistrationToken definitions.
 */
model RegistrationTokenList {
  /**
   * List of RegistrationToken definitions.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: RegistrationTokenMinimal[];

  /**
   * Link to the next page of results.
   */
  @visibility(Lifecycle.Read)
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
 * List of UserSession definitions.
 */
model UserSessionList is Azure.Core.Page<UserSession>;

/**
 * Schema for UserSession properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model UserSessionProperties {
  /**
   * ObjectId of user session. (internal use)
   */
  @visibility(Lifecycle.Read)
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
 * Schema for SessionHost properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SessionHostProperties {
  /**
   * Number of active sessions on SessionHost.
   */
  activeSessions?: int32;

  /**
   * Number of disconnected sessions on SessionHost.
   */
  disconnectedSessions?: int32;

  /**
   * Number of pending sessions on SessionHost.
   */
  pendingSessions?: int32;

  /**
   * ObjectId of SessionHost. (internal use)
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  virtualMachineId?: string;

  /**
   * Resource Id of SessionHost's underlying virtual machine.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;

  /**
   * The error message.
   */
  updateErrorMessage?: string;

  /**
   * The last time update was completed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSessionHostUpdateTime?: utcDateTime;

  /**
   * SessionHostConfiguration version reference at the time the update is initiated, in the format of date time. Example: 2024-04-26T04:56:45Z
   */
  @visibility(Lifecycle.Read)
  sessionHostConfiguration?: string;

  /**
   * List of SessionHostHealthCheckReports
   */
  @visibility(Lifecycle.Read)
  sessionHostHealthCheckResults?: SessionHostHealthCheckReport[];
}

/**
 * The report for session host information.
 */
model SessionHostHealthCheckReport {
  /**
   * Represents the name of the health check operation performed.
   */
  @visibility(Lifecycle.Read)
  healthCheckName?: HealthCheckName;

  /**
   * Represents the Health state of the health check we performed.
   */
  @visibility(Lifecycle.Read)
  healthCheckResult?: HealthCheckResult;

  /**
   * Additional detailed information on the failure.
   */
  @visibility(Lifecycle.Read)
  additionalFailureDetails?: SessionHostHealthCheckFailureDetails;
}

/**
 * Contains details on the failure.
 */
model SessionHostHealthCheckFailureDetails {
  /**
   * Failure message: hints on what is wrong and how to recover.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Error code corresponding for the failure.
   */
  @visibility(Lifecycle.Read)
  errorCode?: int32;

  /**
   * The timestamp of the last update.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
 * List of SessionHost definitions.
 */
model SessionHostList is Azure.Core.Page<SessionHost>;

/**
 * Schema for MSIX Package properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
   * Package Version found in the appxmanifest.xml.
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
 * Schema for MSIX Package Dependencies properties.
 */
model MsixPackageDependencies {
  /**
   * Name of the package dependency. For Msix packages, this is the other packages this package depends upon, for APP-V packages this is the locations of the user and deployment config files
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
 * MSIX Package properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MsixPackagePatch extends Resource {
  /**
   * Detailed properties for MSIX Package
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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

/**
 * List of MSIX Package definitions.
 */
model MsixPackageList is Azure.Core.Page<MsixPackage>;

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
  @visibility(Lifecycle.Read)
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
   * URL of keyvault location to store certificate
   */
  keyVaultURL?: string;

  /**
   * Parameter indicating how the health check should behave if this package fails staging
   */
  failHealthCheckOnStagingFailure?: FailHealthCheckOnStagingFailure;

  /**
   * Specific name of package owner, is "AppAttach" for native app attach packages
   */
  packageOwnerName?: string;

  /**
   * Lookback url to third party control plane, is null for native app attach packages
   */
  packageLookbackUrl?: url;

  /**
   * Field that can be populated with custom data and filtered on in list GET calls
   */
  customData?: string;
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
   * VHD/CIM/APP-V image path on Network Share.
   */
  imagePath?: string;

  /**
   * Package Name from appxmanifest.xml.
   */
  packageName?: string;

  /**
   * Identifier not including the package version, for Msix packages it is the family name from the appxmanifest.xml.
   */
  packageFamilyName?: string;

  /**
   * Identifier including the package version, for Msix packages it is the full name from the appxmanifest.xml.
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  packageDependencies?: MsixPackageDependencies[];

  /**
   * Package Version found in the appxmanifest.xml.
   */
  version?: string;

  /**
   * Date the package source was last updated, for Msix packages this is found in the appxmanifest.xml.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * List of package applications.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
   * Package Version found in the appxmanifest.xml.
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
 * Schema for patchable App Attach Package properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AppAttachPackagePatch extends Resource {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

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
   * URL of keyvault location to store certificate
   */
  keyVaultURL?: string;

  /**
   * Parameter indicating how the health check should behave if this package fails staging
   */
  failHealthCheckOnStagingFailure?: FailHealthCheckOnStagingFailure;

  /**
   * Lookback url to third party control plane, should be null for first party packages
   */
  packageLookbackUrl?: url;

  /**
   * Field that can be populated with custom data and filtered on in list GET calls
   */
  customData?: string;
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
 * Hostpool update fault information.
 */
model HostPoolUpdateFault {
  /**
   * Hostpool update fault type.
   */
  faultType?: FaultType;

  /**
   * Hostpool update fault code.
   */
  faultCode?: string;

  /**
   * Hostpool update fault text.
   */
  faultText?: string;

  /**
   * Hostpool update fault context.
   */
  faultContext?: string;
}
