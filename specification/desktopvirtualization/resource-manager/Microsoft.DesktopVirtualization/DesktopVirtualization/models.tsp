import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;
using Versioning;
using Azure.ResourceManager;

namespace Microsoft.DesktopVirtualization;

/**
 * The type of management for the hostpool
 */
union ManagementType {
  string,

  /**
   * Automated management of the hostpool
   */
  Automated: "Automated",

  /**
   * Standard management of the hostpool
   */
  Standard: "Standard",
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
   * Resume the hostpool update
   */
  Resume: "Resume",
}

/**
 * Action types for controlling hostpool provisioning.
 */
union HostPoolProvisioningAction {
  string,

  /**
   * Cancel the hostpool provisioning.
   */
  Cancel: "Cancel",
}

/**
 * Provisioning state of the Session Host Configuration.
 */
union ProvisioningStateSHC {
  string,

  /**
   *  Provisioning Successful
   */
  Succeeded: "Succeeded",

  /**
   * Provisioning Failed
   */
  Failed: "Failed",

  /**
   * Provisioning was Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning in Progress
   */
  Provisioning: "Provisioning",
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
   * TrustedLaunch allows for secure boot and vTpm
   */
  TrustedLaunch: "TrustedLaunch",

  /**
   * Confidential Virtual Machine security protocol
   */
  ConfidentialVM: "ConfidentialVM",
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
 * The type of image session hosts use in the hostpool.
 */
union type {
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
union packageTimestamped {
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
union failHealthCheckOnStagingFailure {
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
   * Maintains persistent connections.
   */
  Persistent: "Persistent",

  /**
   * Maintains multiple persistents connections.
   */
  MultiplePersistent: "MultiplePersistent",
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
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

  /**
   * Users will be assigned a SessionHost either by administrators (PersonalDesktopAssignmentType = Direct) or upon connecting to the pool (PersonalDesktopAssignmentType = Automatic). They will always be redirected to their assigned SessionHost.
   */
  Personal: "Personal",
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
   * X86 Compiled Hybrid Portable Executable for ARM64
   */
  x86a64: "x86a64",

  /**
   * Select all listed applications, no filters
   */
  ALL: "ALL",
}

/**
 * Operation status for SessionHostManagementUpdate.
 */
union SessionHostManagementProvisioningOperationStatus {
  string,

  /**
   * The operation is scheduled.
   */
  Scheduled: "Scheduled",

  /**
   * The operation is currently validating the provisioning.
   */
  ValidatingSessionHostProvisioning: "ValidatingSessionHostProvisioning",

  /**
   * Canceling the operation.
   */
  Cancelling: "Cancelling",

  /**
   * The operation is currently provisioning session hosts.
   */
  ProvisioningSessionHosts: "ProvisioningSessionHosts",

  /**
   * The operation succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The operation failed.
   */
  Failed: "Failed",

  /**
   * The operation is canceled.
   */
  Canceled: "Canceled",
}

/**
 * Operation status for SessionHostManagementUpdate.
 */
@renamedFrom(
  Versions.v2025_04_01_preview,
  "SessionHostManagementUpdateOperationStatus"
)
union updateStatus {
  string,

  /**
   * The operation has an error.
   */
  Error: "Error",

  /**
   * The operation is scheduled.
   */
  Scheduled: "Scheduled",

  /**
   * The operation is currently updating Session Hosts.
   */
  UpdatingSessionHosts: "UpdatingSessionHosts",

  /**
   * The operation is validating the update.
   */
  ValidatingSessionHostUpdate: "ValidatingSessionHostUpdate",

  /**
   * The operation is paused.
   */
  Paused: "Paused",

  /**
   * The operation is pausing.
   */
  Pausing: "Pausing",

  /**
   * Canceling the operation.
   */
  Cancelling: "Cancelling",

  /**
   * The operation succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The operation failed.
   */
  Failed: "Failed",

  /**
   * The operation is canceled
   */
  Cancelled: "Cancelled",
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
   * Verifies that the AppAttachService is healthy (there were no issues during package staging). The AppAttachService is used to enable the staging/registration (and eventual de-registration/destaging) of MSIX apps that have been set up by the tenant admin. This checks whether the component had any failures during package staging. Failures in staging will prevent some MSIX apps from working properly for the end user. If this check fails, it is non fatal and the machine still can service connections, main issue may be certain apps will not work for end-users. (Currently Enabled)
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

  /**
   * Start VM on Connect is enabled
   */
  Enable: "Enable",

  /**
   * Start VM on Connect is disabled, must use rampUpAutoStartHosts or turn on manually
   */
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
 * The desired scaling method to be used to scale the hosts in the assigned host pool.
 */
union ScalingMethodType {
  string,

  /**
   * Scaling will manage hosts in the host pool by power managing the hosts, but will not change the host pool size.
   */
  PowerManage: "PowerManage",

  /**
   * Scaling will manage hosts in the host pool by power managing the hosts, as well as creating and deleting hosts that will change the host pool size. This requires the createDelete property to be set, and the assigned hostpool to have a session host config property.
   */
  CreateDeletePowerManage: "CreateDeletePowerManage",
}

/**
 * The desired scaling method to be used to scale the hosts in the assigned host pool.
 */
union ScalingMethodPatchType {
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
 * Policy on whether a Canary VM(a single VM to validate the configuration) should be provisioned during a session host provisioning operation.
 */
union CanaryPolicy {
  string,

  /**
   * Decided by service whether to provision Canary VM.
   */
  Auto: "Auto",

  /**
   * Never provision Canary VM.
   */
  Never: "Never",

  /**
   * Always provision Canary VM.
   */
  Always: "Always",
}

/**
 * The policy that should be applied when the Session Host provisioning operation fails.
 */
union FailedSessionHostCleanupPolicySHC {
  string,

  /**
   * Keep All.
   */
  KeepAll: "KeepAll",

  /**
   * Keep One.
   */
  KeepOne: "KeepOne",

  /**
   * Keep None.
   */
  KeepNone: "KeepNone",
}

/**
 * Specifies the ephemeral disk settings for operating system disk.
 */
union DiffDiskOption {
  string,

  /**
   * Operating system disk local setting.
   */
  Local: "Local",
}

/**
 * Gets or sets specifies the ephemeral disk placement for operating system disk. The defaulting behavior is: CacheDisk if one is configured for the VM size otherwise ResourceDisk is used. Refer to the VM size documentation for Windows VM at https://docs.microsoft.com/azure/virtual-machines/windows/sizes and Linux VM at https://docs.microsoft.com/azure/virtual-machines/linux/sizes to check which VM sizes exposes a cache disk. Possible values include: 'CacheDisk', 'ResourceDisk'.
 */
union DiffDiskPlacement {
  string,

  /**
   * Cache disk placement
   */
  CacheDisk: "CacheDisk",

  /**
   * Resource disk placement
   */
  ResourceDisk: "ResourceDisk",
}

/**
 * Day of the week. Modeled as string
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Service already defined this as non-extensible"
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
  @Azure.ResourceManager.identifiers(#["name"])
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
   * URL path to certificate name located in keyVault
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "URL is a valid acronym"
  keyVaultURL?: string;

  /**
   * Parameter indicating how the health check should behave if this package fails staging
   */
  failHealthCheckOnStagingFailure?: failHealthCheckOnStagingFailure;

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
  @Azure.ResourceManager.identifiers(#[])
  packageDependencies?: MsixPackageDependencies[];

  /**
   * Package version found in the appxmanifest.xml.
   */
  version?: string;

  /**
   * Date Package was last updated, found in the appxmanifest.xml.
   */
  lastUpdated?: utcDateTime;

  /**
   * List of package applications.
   */
  @Azure.ResourceManager.identifiers(#[])
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
  isPackageTimestamped?: packageTimestamped;
}

/**
 * Schema for MSIX Package Dependencies properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "ID is a valid acronym"
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
model DiskInfoProperties {
  /**
   * The disk type used by virtual machine in hostpool session host.
   */
  @removed(Versions.v2025_04_01_preview)
  type: VirtualMachineDiskType;

  /**
   * The managed disk parameters.
   */
  @added(Versions.v2025_04_01_preview)
  managedDisk?: ManagedDiskProperties;

  /**
   * Specifies the ephemeral disk settings for the operating system disk used by the virtual machine.
   */
  @added(Versions.v2025_04_01_preview)
  diffDiskSettings?: DiffDiskProperties;
}

/**
 * Managed Disk information.
 */
model ManagedDiskProperties {
  /**
   * Managed Disk information.
   */
  type?: VirtualMachineDiskType;
}

/**
 * Specifies the ephemeral disk settings for the operating system disk used by the virtual machine.
 */
model DiffDiskProperties {
  /**
   * Specifies the ephemeral disk settings for operating system disk.
   */
  option?: DiffDiskOption;

  /**
   * Gets or sets specifies the ephemeral disk placement for operating system disk. The defaulting behavior is: CacheDisk if one is configured for the VM size otherwise ResourceDisk is used. Refer to the VM size documentation for Windows VM at https://docs.microsoft.com/azure/virtual-machines/windows/sizes and Linux VM at https://docs.microsoft.com/azure/virtual-machines/linux/sizes to check which VM sizes exposes a cache disk. Possible values include: 'CacheDisk', 'ResourceDisk'.
   */
  placement?: DiffDiskPlacement;
}

/**
 * Disk information.
 */
@removed(Versions.v2025_04_01_preview)
model DiskInfoPatchProperties {
  /**
   * The disk type used by virtual machine in hostpool session host.
   */
  type?: VirtualMachineDiskType;
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
   * The SKU of the image.
   */
  sku: string;

  /**
   * The version of the image.
   */
  exactVersion: string;
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
   * The SKU of the image.
   */
  sku?: string;

  /**
   * The version of the image.
   */
  exactVersion?: string;
}

/**
 * Custom image information.
 */
model CustomInfoProperties {
  /**
   * The resource ID of the image.
   */
  resourceId: Azure.Core.armResourceIdentifier;
}

/**
 * Custom image information.
 */
model CustomInfoPatchProperties {
  /**
   * The resource ID of the image.
   */
  resourceId?: Azure.Core.armResourceIdentifier;
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
 * Active directory info. Only one should be populated based on the join type
 */
model ActiveDirectoryInfoPatchProperties {
  /**
   * Credentials needed to create the virtual machine.
   */
  domainCredentials?: KeyVaultCredentialsPatchProperties;
}

/**
 * Azure Active directory info. Only one should be populated based on the join type
 */
model AzureActiveDirectoryInfoProperties {
  /**
   * The Mobile Device Management(MDM) guid.
   */
  mdmProviderGuid: string;
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
 * Domain configurations of session hosts.
 */
model DomainInfoPatchProperties {
  /**
   * Active directory info. Only one should be populated based on the join type.
   */
  activeDirectoryInfo?: ActiveDirectoryInfoPatchProperties;
}

/**
 * Image configurations of session host in a HostPool
 */
model ImageInfoProperties {
  /**
   * The type of image session hosts use in the hostpool.
   */
  @clientName("imageType")
  type: type;

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
 * Image configurations of session host in a HostPool
 */
model ImageInfoPatchProperties {
  /**
   * The type of image session hosts use in the hostpool.
   */
  @clientName("imageType")
  type?: type;

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
 * Security Information.
 */
model SecurityInfoProperties {
  /**
   * The security type used by virtual machine in hostpool session host. Default is Standard.
   */
  type?: VirtualMachineSecurityType = VirtualMachineSecurityType.Standard;

  /**
   * Whether to use secureBoot on the virtual machine.
   */
  secureBootEnabled?: boolean;

  /**
   * Whether to use vTpm on the virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "vTpm is acronym in service"
  vTpmEnabled?: boolean;
}

/**
 * Security Information.
 */
model SecurityInfoPatchProperties {
  /**
   * The security type used by virtual machine in hostpool session host. Default is Standard.
   */
  type?: VirtualMachineSecurityType;

  /**
   * Whether to use secureBoot on the virtual machine.
   */
  secureBootEnabled?: boolean;

  /**
   * Whether to use vTpm on the virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "vTpm is an acronym used by service"
  vTpmEnabled?: boolean;
}

/**
 * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. <br><br> You can easily view the output of your console log. <br><br> Azure also enables you to see a screenshot of the VM from the hypervisor
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
 * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. <br><br> You can easily view the output of your console log. <br><br> Azure also enables you to see a screenshot of the VM from the hypervisor
 */
model BootDiagnosticsInfoPatchProperties {
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
 * List of ActiveSessionHostConfiguration definitions.
 */
model ActiveSessionHostConfigurationList
  is Azure.Core.Page<ActiveSessionHostConfiguration>;

/**
 * Represents a ActiveSessionHostConfiguration definition. This has all of the sessionHostConfiguration properties except provisioningState
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
model ActiveSessionHostConfigurationProperties {
  /**
   * The timestamp of the last update.
   */
  @visibility(Lifecycle.Read)
  version?: utcDateTime;

  /**
   * Friendly name to describe this version of the SessionHostConfiguration
   */
  @maxLength(260)
  friendlyName?: string;

  /**
   * Hashtable that lists key/value pair tags to apply to the VMs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Already implemented with Record"
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
   * Image configurations of the HostPool.
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
   * Log off message sent to user for logoff. Default value is an empty string.
   */
  @maxLength(260)
  logOffMessage?: string;
}

/**
 * Session Host Managements of HostPool.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by our service"
model SessionHostManagementProperties {
  /**
   * Time zone for sessionHostManagement operations as defined in https://docs.microsoft.com/dotnet/api/system.timezoneinfo.findsystemtimezonebyid. Must be set if useLocalTime is true.
   */
  scheduledDateTimeZone: string;

  /**
   * Parameters for a hostpool update.
   */
  update: HostPoolUpdateConfigurationProperties;

  /**
   * Parameters that apply when session hosts are provisioned.
   */
  @added(Versions.v2025_04_01_preview)
  provisioning?: SessionHostProvisioningConfigurationProperties;

  /**
   * The policy that should be applied when the Session Host provisioning operation fails.
   */
  @added(Versions.v2025_04_01_preview)
  failedSessionHostCleanupPolicy?: FailedSessionHostCleanupPolicySHC;
}

/**
 * The configuration for session host provisioning operations.
 */
model SessionHostProvisioningConfigurationProperties {
  /**
   * Whether the session host should be set in drain mode following provisioning.
   */
  setDrainMode?: boolean;

  /**
   * The number of session hosts to exist in the Host Pool.
   */
  @minValue(1)
  instanceCount?: int32;

  /**
   * Policy on whether a Canary VM(a single VM to validate the configuration) should be provisioned during a session host provisioning operation.
   */
  canaryPolicy?: CanaryPolicy;
}

/**
 * Represents a SessionHostManagementPatch definition.
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
 * List of ApplicationGroup definitions.
 */
model ApplicationGroupList is Azure.Core.Page<ApplicationGroup>;

/**
 * Schema for ApplicationGroup properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
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
 * The resource model definition containing the full set of allowed properties for a resource. Except properties bag, there cannot be a top level property outside of this set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceModelWithAllowedPropertySet
  extends Azure.ResourceManager.Foundations.TrackedResource {
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
   * Resource Identity
   */
  identity?: ResourceModelWithAllowedPropertySetIdentity;

  /**
   * Selected image SKU
   */
  sku?: ResourceModelWithAllowedPropertySetSku;

  /**
   * Selected user purchase plan
   */
  plan?: ResourceModelWithAllowedPropertySetPlan;
}

/**
 * The resource model definition containing the full set of allowed properties for a resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Standard Common Type"
model ResourceModelWithAllowedPropertySetIdentity extends Identity {}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity. The value must be an UUID.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource. The value must be an UUID.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

/**
 * Resource model definition representing SKU and Properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Standard Common Type"
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

/**
 * Resource model definition representing Plan and Properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Standard Common Type"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a valid acronym"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UDP is a valid acronym"
  managedPrivateUDP?: ManagedPrivateUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UDP is a valid acronym"
  directUDP?: DirectUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UDP is a valid acronym"
  publicUDP?: PublicUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UDP is a valid acronym"
  relayUDP?: RelayUDP;

  /**
   * The type of management for this hostpool, Automated or Standard. The default value is Automated.
   */
  managementType?: ManagementType;
}

/**
 * Represents a RegistrationInfo definition.
 */
model RegistrationInfo {
  /**
   * Expiration time of registration token.
   */
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
  @Azure.ResourceManager.identifiers(#[])
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
model PrivateEndpointConnection
  extends Azure.ResourceManager.CommonTypes.Resource {
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
 * List of scaling plan definitions.
 */
model ScalingPlanList is Azure.Core.Page<ScalingPlan>;

/**
 * Scaling plan properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
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
   * List of ScalingPlanPooledSchedule definitions.
   */
  @Azure.ResourceManager.identifiers(#["name"])
  schedules?: ScalingSchedule[];

  /**
   * List of ScalingHostPoolReference definitions.
   */
  @Azure.ResourceManager.identifiers(#["hostPoolArmPath"])
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
  @added(Versions.v2025_04_01_preview)
  scalingMethod?: ScalingMethodType = ScalingMethodType.PowerManage;

  /**
   * The properties that control how Scaling will manage the size of the hostpool by creating and deleting hosts.
   */
  @added(Versions.v2025_04_01_preview)
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
  @minValue(0)
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
  @minValue(0)
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
#suppress "@azure-tools/typespec-azure-core/no-openapi"
@added(Versions.v2025_04_01_preview)
@OpenAPI.extension("x-nullable", true)
model CreateDeleteProperties {
  /**
   * Maximum number of session hosts that may be created by the Scaling Service. This requires the assigned hostpool to have a session host config property.
   */
  @minValue(0)
  @OpenAPI.extension("x-nullable", true)
  rampUpMaximumHostPoolSize?: int32;

  /**
   * Minimum number of session hosts that will be be created by the Scaling Service. Scaling will not delete any hosts when this limit is met. This requires the assigned hostpool to have a session host config property.
   */
  @minValue(0)
  @maxValue(59)
  @OpenAPI.extension("x-nullable", true)
  rampUpMinimumHostPoolSize?: int32;

  /**
   * Maximum number of session hosts that may be created by the Scaling Service. This requires the assigned hostpool to have a session host config property.
   */
  @minValue(0)
  @OpenAPI.extension("x-nullable", true)
  rampDownMaximumHostPoolSize?: int32;

  /**
   * Minimum number of session hosts that will be be created by the Scaling Service. Scaling will not delete any hosts when this limit is met. This requires the assigned hostpool to have a session host config property.
   */
  @minValue(0)
  @maxValue(59)
  @OpenAPI.extension("x-nullable", true)
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
  @minValue(0)
  hour: int32;

  /**
   * The minute.
   */
  @maxValue(59)
  @minValue(0)
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
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
 * Schema for updatable App Attach Package properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model AppAttachPackagePatch extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "tags are a valid record"
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
   * URL path to certificate name located in keyVault
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "URL is a valid acronym"
  keyVaultURL?: string;

  /**
   * Parameter indicating how the health check should behave if this package fails staging
   */
  failHealthCheckOnStagingFailure?: failHealthCheckOnStagingFailure;

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
 * ApplicationGroup properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model ApplicationGroupPatch extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "tags are a valid record"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by our service"
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
 * List of SessionHostManagement definitions.
 */
model SessionHostManagementList is Azure.Core.Page<SessionHostManagement>;

/**
 * List of SessionHostConfiguration definitions.
 */
model SessionHostConfigurationList is Azure.Core.Page<SessionHostConfiguration>;

/**
 * List of Desktop definitions.
 */
model DesktopList is Azure.Core.Page<Desktop>;

/**
 * Schema for Desktop properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by our service"
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
 * SessionHostManagement properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model SessionHostManagementPatch {
  /**
   * Detailed properties for SessionHostManagement
   */
  properties?: SessionHostManagementPatchProperties;
}

/**
 * SessionHostConfiguration properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model SessionHostConfigurationPatch {
  /**
   * Detailed properties for SessionHostConfiguration
   */
  properties?: SessionHostConfigurationPatchProperties;
}
/**
 * Desktop properties that can be patched.
 */
model DesktopPatch {
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
model StartMenuItem extends Azure.ResourceManager.CommonTypes.Resource {
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
 * Object containing the definition for properties to be used for a sessionHostUpdate operation.
 */
model UpdateSessionHostsRequestBody {
  /**
   * The timestamp that the update validation is scheduled for. If none is provided, the update will be executed immediately
   */
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
 * Object containing control action for hostpool update.
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
 * Object containing control action for hostpool provisioning.
 */
model HostPoolProvisioningControlParameter {
  /**
   * Action types for controlling hostpool update.
   */
  action: HostPoolProvisioningAction;

  /**
   * The cancel message sent to the user on the session host.
   */
  @maxLength(260)
  cancelMessage?: string;
}

@@added(HostPoolPatch.identity, Versions.v2025_04_01_preview);
#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(HostPoolPatch.identity, "x-nullable", true);

/**
 * HostPool properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model HostPoolPatch extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "tags are a valid record"
  tags?: Record<string>;

  /**
   * HostPool properties that can be patched.
   */
  properties?: HostPoolPatchProperties;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  ...ManagedServiceIdentityProperty;
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a valid acronym"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UDP is a valid acronym"
  managedPrivateUDP?: ManagedPrivateUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UDP is a valid acronym"
  directUDP?: DirectUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UDP is a valid acronym"
  publicUDP?: PublicUDP;

  /**
   * Default: AVD-wide settings are used to determine connection availability, Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type, Disabled: UDP will not attempt this connection type when making connections
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UDP is a valid acronym"
  relayUDP?: RelayUDP;
}

/**
 * Represents a RegistrationInfo definition.
 */
model RegistrationInfoPatch {
  /**
   * Expiration time of registration token.
   */
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
  @Azure.ResourceManager.identifiers(#[])
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "URI is a valid acronym"
model MSIXImageURI {
  /**
   * URI to Image
   */
  uri?: url;
}

/**
 * List of MSIX package properties retrieved from MSIX Image expansion.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
model ExpandMsixImageList is Azure.Core.Page<ExpandMsixImage>;

/**
 * Represents the definition of contents retrieved after expanding the MSIX Image.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
model ExpandMsixImage extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Detailed properties for ExpandMsixImage
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
  properties?: ExpandMsixImageProperties;
}

/**
 * Schema for Expand MSIX Image properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
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
  @Azure.ResourceManager.identifiers(#["dependencyName"])
  packageDependencies?: MsixPackageDependencies[];

  /**
   * Package version found in the appxmanifest.xml.
   */
  version?: string;

  /**
   * Date Package was last updated, found in the appxmanifest.xml.
   */
  lastUpdated?: utcDateTime;

  /**
   * List of package applications.
   */
  @Azure.ResourceManager.identifiers(#["appId"])
  packageApplications?: MsixPackageApplications[];

  /**
   * Certificate name found in the appxmanifest.xml.
   */
  certificateName?: string;

  /**
   * Date certificate expires, found in the appxmanifest.xml.
   */
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
  @Azure.ResourceManager.identifiers(#[])
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
  expirationTime?: utcDateTime;

  /**
   * The registration token base64 encoded string.
   */
  token?: string;
}

/**
 * List of private endpoint connection associated with the specified HostPool
 */
model PrivateEndpointConnectionListResultWithSystemData
  is Azure.Core.Page<PrivateEndpointConnectionWithSystemData>;

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult is Azure.Core.Page<PrivateLinkResource>;

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Azure.ResourceManager.CommonTypes.Resource {
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
 * List of SessionHost definitions.
 */
model SessionHostList is Azure.Core.Page<SessionHost>;

/**
 * Schema for SessionHost properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
model SessionHostProperties {
  /**
   * Number of active sessions on SessionHost.
   */
  @added(Versions.v2025_04_01_preview)
  activeSessions?: int32;

  /**
   * Number of disconnected sessions on SessionHost.
   */
  @added(Versions.v2025_04_01_preview)
  disconnectedSessions?: int32;

  /**
   * Number of pending sessions on SessionHost.
   */
  @added(Versions.v2025_04_01_preview)
  pendingSessions?: int32;

  /**
   * ObjectId of SessionHost. (internal use)
   */
  @visibility(Lifecycle.Read)
  objectId?: string;

  /**
   * Last heart beat from SessionHost.
   */
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
  statusTimestamp?: utcDateTime;

  /**
   * The version of the OS on the session host.
   */
  osVersion?: string;

  /**
   * The version of the side by side stack on the session host.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "SxS is a valid acronym"
  sxSStackVersion?: string;

  /**
   * Update state of a SessionHost.
   */
  updateState?: UpdateState;

  /**
   * The timestamp of the last update.
   */
  @visibility(Lifecycle.Read)
  lastUpdateTime?: utcDateTime;

  /**
   * The error message.
   */
  updateErrorMessage?: string;

  /**
   * The last time update was completed.
   */
  @visibility(Lifecycle.Read)
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
  @Azure.ResourceManager.identifiers(#["healthCheckName"])
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
  lastHealthCheckDateTime?: utcDateTime;
}

/**
 * SessionHost properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SessionHostPatch extends Azure.ResourceManager.CommonTypes.Resource {
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
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
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model ScalingPlanPatch {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record type is valid for tags"
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
  @Azure.ResourceManager.identifiers(#["name"])
  schedules?: ScalingSchedule[];

  /**
   * List of ScalingHostPoolReference definitions.
   */
  @Azure.ResourceManager.identifiers(#["hostPoolArmPath"])
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is valid acronym"
  rampUpStartVMOnConnect?: SetStartVMOnConnect = SetStartVMOnConnect.Enable;

  /**
   * Action to be taken after a user disconnect during the ramp up period.
   */
  rampUpActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the ramp up period.
   */
  @minValue(0)
  rampUpMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the ramp up period.
   */
  rampUpActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the ramp up period.
   */
  @minValue(0)
  rampUpMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for peak period.
   */
  peakStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the peak phase.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is valid acronym"
  peakStartVMOnConnect?: SetStartVMOnConnect = SetStartVMOnConnect.Enable;

  /**
   * Action to be taken after a user disconnect during the peak period.
   */
  peakActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the peak period.
   */
  @minValue(0)
  peakMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the peak period.
   */
  peakActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the peak period.
   */
  @minValue(0)
  peakMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for ramp down period.
   */
  rampDownStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the ramp down phase.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is valid acronym"
  rampDownStartVMOnConnect?: SetStartVMOnConnect = SetStartVMOnConnect.Enable;

  /**
   * Action to be taken after a user disconnect during the ramp down period.
   */
  rampDownActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the ramp down period.
   */
  @minValue(0)
  rampDownMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the ramp down period.
   */
  rampDownActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the ramp down period.
   */
  @minValue(0)
  rampDownMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for off-peak period.
   */
  offPeakStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the off-peak phase.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is valid acronym"
  offPeakStartVMOnConnect?: SetStartVMOnConnect = SetStartVMOnConnect.Enable;

  /**
   * Action to be taken after a user disconnect during the off-peak period.
   */
  offPeakActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the off-peak period.
   */
  @minValue(0)
  offPeakMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the off-peak period.
   */
  offPeakActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the off-peak period.
   */
  @minValue(0)
  offPeakMinutesToWaitOnLogoff?: int32;
}

/**
 * ScalingPlanPersonalSchedule properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is valid acronym"
  rampUpStartVMOnConnect?: SetStartVMOnConnect = SetStartVMOnConnect.Enable;

  /**
   * Action to be taken after a user disconnect during the ramp up period.
   */
  rampUpActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the ramp up period.
   */
  @minValue(0)
  rampUpMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the ramp up period.
   */
  rampUpActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the ramp up period.
   */
  @minValue(0)
  rampUpMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for peak period.
   */
  peakStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the peak phase.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is valid acronym"
  peakStartVMOnConnect?: SetStartVMOnConnect = SetStartVMOnConnect.Enable;

  /**
   * Action to be taken after a user disconnect during the peak period.
   */
  peakActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the peak period.
   */
  @minValue(0)
  peakMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the peak period.
   */
  peakActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the peak period.
   */
  @minValue(0)
  peakMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for ramp down period.
   */
  rampDownStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the ramp down phase.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is valid acronym"
  rampDownStartVMOnConnect?: SetStartVMOnConnect = SetStartVMOnConnect.Enable;

  /**
   * Action to be taken after a user disconnect during the ramp down period.
   */
  rampDownActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the ramp down period.
   */
  @minValue(0)
  rampDownMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the ramp down period.
   */
  rampDownActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the ramp down period.
   */
  @minValue(0)
  rampDownMinutesToWaitOnLogoff?: int32;

  /**
   * Starting time for off-peak period.
   */
  offPeakStartTime?: Time;

  /**
   * The desired configuration of Start VM On Connect for the hostpool during the off-peak phase.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is valid acronym"
  offPeakStartVMOnConnect?: SetStartVMOnConnect = SetStartVMOnConnect.Enable;

  /**
   * Action to be taken after a user disconnect during the off-peak period.
   */
  offPeakActionOnDisconnect?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user disconnects during the off-peak period.
   */
  @minValue(0)
  offPeakMinutesToWaitOnDisconnect?: int32;

  /**
   * Action to be taken after a logoff during the off-peak period.
   */
  offPeakActionOnLogoff?: SessionHandlingOperation;

  /**
   * The time in minutes to wait before performing the desired session handling action when a user logs off during the off-peak period.
   */
  @minValue(0)
  offPeakMinutesToWaitOnLogoff?: int32;
}

/**
 * ScalingPlanPersonalSchedule properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model ScalingPlanPersonalSchedulePatch {
  /**
   * Detailed properties for ScalingPlanPersonalSchedule
   */
  properties?: ScalingPlanPersonalSchedulePatchProperties;
}

/**
 * List of ScalingPlanPooledSchedule definitions.
 */
model ScalingPlanPooledScheduleList
  is Azure.Core.Page<ScalingPlanPooledSchedule>;

/**
 * A ScalingPlanPooledSchedule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
model ScalingPlanPooledScheduleProperties {
  /**
   * Name of the ScalingPlanPooledSchedule
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Service already uses this property"
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Set of days of the week on which this schedule is active.
   */
  daysOfWeek?: DayOfWeek[];

  /**
   * The desired scaling method to be used to scale the hosts in the assigned host pool.
   */
  @added(Versions.v2025_04_01_preview)
  scalingMethod?: ScalingMethodType = ScalingMethodType.PowerManage;

  /**
   * The properties that control how Scaling will manage the size of the hostpool by creating and deleting hosts.
   */
  @added(Versions.v2025_04_01_preview)
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
  @minValue(0)
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
  @minValue(0)
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
 * A ScalingPlanPooledSchedule that can be patched.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
model ScalingPlanPooledSchedulePatchProperties {
  /**
   * Name of the ScalingPlanPooledSchedule
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
  @added(Versions.v2025_04_01_preview)
  scalingMethod?: ScalingMethodType;

  /**
   * The properties that control how Scaling will manage the size of the hostpool by creating and deleting hosts.
   */
  @added(Versions.v2025_04_01_preview)
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
  @minValue(0)
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
  @minValue(0)
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
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model ScalingPlanPooledSchedulePatch
  extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Detailed properties for ScalingPlanPooledSchedule
   */
  properties?: ScalingPlanPooledSchedulePatchProperties;
}

/**
 * Workspace properties that can be patched.
 */
/** A patch model */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
model WorkspacePatch {
  /**
   * tags to be updated
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags can be Record"
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
 * Session host configurations of HostPool.
 */
model SessionHostConfigurationProperties {
  /**
   * The timestamp of the last update.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Already implemented with Record"
  vmTags?: Record<string>;

  /**
   * The Location for the session host to be created in. It will default to the location of the hostpool if not provided
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
   * Disk Information
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
   * Security Information
   */
  securityInfo?: SecurityInfoProperties;

  /**
   * Local Admin credentials for session hosts."
   */
  vmAdminCredentials: KeyVaultCredentialsProperties;

  /**
   * Boot Diagnostics Information
   */
  bootDiagnosticsInfo?: BootDiagnosticsInfoProperties;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Already implemented with Record"
  vmTags?: Record<string>;

  /**
   * The Location for the session host to be created in. It will default to the location of the hostpool if not provided
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
   * Disk Information
   */
  @typeChangedFrom(Versions.v2025_04_01_preview, DiskInfoPatchProperties)
  diskInfo?: DiskInfoProperties;

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
   * Security Information
   */
  securityInfo?: SecurityInfoPatchProperties;

  /**
   * Local Admin credentials for session hosts."
   */
  vmAdminCredentials?: KeyVaultCredentialsPatchProperties;

  /**
   * Boot Diagnostics Information
   */
  bootDiagnosticsInfo?: BootDiagnosticsInfoPatchProperties;
}

/**
 * The current status of the session host update async operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
model SessionHostManagementUpdateStatusProperties {
  /**
   * The correlation Id for Log Analytics..
   */
  correlationId?: string;

  /**
   * Progress information on the sessionHostManagement operation.
   */
  progress?: SessionHostManagementOperationProgress;

  /**
   * The timestamp that the update is scheduled for.
   */
  scheduledDateTime?: utcDateTime;

  /**
   * SessionHostManagement properties used for the operation.
   */
  sessionHostManagement?: SessionHostManagement;
}

/**
 * Properties bag for sessionHostManagement Provisioning Statuses.
 */
model SessionHostManagementProvisioningStatusProperties {
  /**
   * The correlation Id for Log Analytics.
   */
  correlationId?: string;

  /**
   * Progress information on the sessionHostManagement operation.
   */
  progress?: SessionHostManagementProvisioningOperationProgress;

  /**
   * The timestamp that the update is scheduled for.
   */
  scheduledDateTime?: utcDateTime;

  /**
   * SessionHostManagement properties used for the operation.
   */
  sessionHostManagement?: SessionHostManagement;
}

/**
 * SessionHostManagement Provisioning Operation Progress information.
 */
model SessionHostManagementProvisioningOperationProgress {
  /**
   * Time that the sessionHostManagement operation was created.
   */
  executionStartTime?: utcDateTime;

  /**
   * The number of sessionHosts in progress in the sessionHostManagement provisioning operation
   */
  sessionHostsInProgress?: int32;

  /**
   * The number of sessionHosts completed in the sessionHostManagement provisioning operation.
   */
  sessionHostsCompleted?: int32;

  /**
   * The final instance count of the host pool for this provisioning operation.
   */
  finalSessionHostsCount?: int32;

  /**
   * The initial instance count of the host pool for this provisioning operation.
   */
  initialSessionHostsCount?: int32;
}

/**
 * SessionHostManagement Operation Progress information.
 */
model SessionHostManagementOperationProgress {
  /**
   * Time that the sessionHostManagement operation was created.
   */
  executionStartTime?: utcDateTime;

  /**
   * The number of sessionHosts to be started in the sessionHostManagement operation.
   */
  totalSessionHosts?: int32;

  /**
   * The number of sessionHosts in progress in the sessionHostManagement operation
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
 * List of MSIX Package definitions.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
model MSIXPackageList is Azure.Core.Page<MSIXPackage>;

/**
 * Schema for MSIX Package properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not supported by service"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
model MSIXPackageProperties {
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
  @Azure.ResourceManager.identifiers(#["dependencyName"])
  packageDependencies?: MsixPackageDependencies[];

  /**
   * Package version found in the appxmanifest.xml.
   */
  version?: string;

  /**
   * Date Package was last updated, found in the appxmanifest.xml.
   */
  lastUpdated?: utcDateTime;

  /**
   * List of package applications.
   */
  @Azure.ResourceManager.identifiers(#["appId"])
  packageApplications?: MsixPackageApplications[];
}

/**
 * MSIX Package properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Some properties can't be patched"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
model MSIXPackagePatch extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Detailed properties for MSIX Package
   */
  properties?: MSIXPackagePatchProperties;
}

/**
 * MSIX Package properties that can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
model MSIXPackagePatchProperties {
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
 * Model used only to spread in the standard `eTag` envelope property for a resource
 *
 * @example
 *
 * ```typespec
 * model Foo is TrackedResource<FooProperties> {
 *   // Only have standard Succeeded, Failed, Cancelled states
 *   ...EntityTagProperty;
 * }
 * ```
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "common types use etag instead of eTag"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "It is a valid property"
model etagProperty {
  @doc("If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Operation status. Current defined values are < Error | Scheduled | UpdatingSessionHosts | ValidatingSessionHostUpdate | Paused | Pausing | Cancelling > | Succeeded | Failed | Canceled
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "It is a valid property"
model StatusProperty {
  /**
   * Operation status. Current defined values are < Error | Scheduled | UpdatingSessionHosts | ValidatingSessionHostUpdate | Paused | Pausing | Cancelling > | Succeeded | Failed | Canceled
   */
  status: updateStatus;
}

/**
 * Operation status.
 */
model ProvisioningOperationStatusProperty {
  /**
   * Operation status.
   */
  status: SessionHostManagementProvisioningOperationStatus;
}

/**
 * Properties bag for sessionHostManagement Update Statuses.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "It is a valid property"
model UpdateStatusProperty {
  /**
   * Properties bag for sessionHostManagement Update Statuses.
   */
  properties?: SessionHostManagementUpdateStatusProperties;
}

/**
 * Properties bag for sessionHostManagement Provisioning Statuses.
 */
model ProvisioningStatusProperty {
  /**
   * The custom properties of the SessionHost Provisioning Status.
   */
  properties?: SessionHostManagementProvisioningStatusProperties;
}

/**
 * A list of REST API operations supported by an Azure Resource Provider. It contains an URL link to get the next set of results.
 */
model ResourceProviderOperationListResult
  is Azure.Core.Page<ResourceProviderOperation>;

@@Azure.ResourceManager.identifiers(ResourceProviderOperationListResult.value,
  #[]
);
