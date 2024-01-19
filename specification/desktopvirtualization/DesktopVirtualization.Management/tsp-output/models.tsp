import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DesktopVirtualization;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("The private endpoint connection status.")
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

@doc("HostPool type for desktop.")
enum ScalingHostPoolType {
  @doc("Users get a new (random) SessionHost every time it connects to the HostPool.")
  Pooled,
}

enum ScalingScheduleDaysOfWeekItem {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

@doc("Load balancing algorithm for ramp up period.")
enum SessionHostLoadBalancingAlgorithm {
  BreadthFirst,
  DepthFirst,
}

@doc("Specifies when to stop hosts during ramp down period.")
enum StopHostsWhen {
  ZeroSessions,
  ZeroActiveSessions,
}

@doc("The desired startup behavior during the ramp up period for personal vms in the hostpool.")
enum StartupBehavior {
  @doc("Session hosts will not be started by the service. This setting depends on Start VM on Connect to be enabled to start the session hosts.")
  None,
  @doc("Session hosts with an assigned user will be started during Ramp Up")
  WithAssignedUser,
  @doc("All personal session hosts in the hostpool will be started during ramp up.")
  All,
}

@doc("The desired configuration of Start VM On Connect for the hostpool during the ramp up phase. If this is disabled, session hosts must be turned on using rampUpAutoStartHosts or by turning them on manually.")
enum SetStartVMOnConnect {
  Enable,
  Disable,
}

@doc("Action to be taken after a user disconnect during the ramp up period.")
enum SessionHandlingOperation {
  None,
  Deallocate,
  Hibernate,
}

@doc("Resource Type of ApplicationGroup.")
enum ApplicationGroupType {
  RemoteApp,
  Desktop,
}

@doc("Resource Type of Application.")
enum RemoteApplicationType {
  InBuilt,
  MsixApplication,
}

@doc("Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all.")
enum CommandLineSetting {
  DoNotAllow,
  Allow,
  Require,
}

@doc("HostPool type for desktop.")
enum HostPoolType {
  @doc("Users will be assigned a SessionHost either by administrators (PersonalDesktopAssignmentType = Direct) or upon connecting to the pool (PersonalDesktopAssignmentType = Automatic). They will always be redirected to their assigned SessionHost.")
  Personal,
  @doc("Users get a new (random) SessionHost every time it connects to the HostPool.")
  Pooled,
  @doc("Users assign their own machines, load balancing logic remains the same as Personal. PersonalDesktopAssignmentType must be Direct.")
  BYODesktop,
}

@doc("PersonalDesktopAssignment type for HostPool.")
enum PersonalDesktopAssignmentType {
  Automatic,
  Direct,
}

@doc("The type of the load balancer.")
enum LoadBalancerType {
  BreadthFirst,
  DepthFirst,
  Persistent,
}

@doc("The type of resetting the token.")
enum RegistrationTokenOperation {
  Delete,
  None,
  Update,
}

@doc("The type of single sign on Secret Type.")
enum SSOSecretType {
  SharedKey,
  Certificate,
  SharedKeyInKeyVault,
  CertificateInKeyVault,
}

@doc("The type of preferred application group type, default to Desktop Application Group")
enum PreferredAppGroupType {
  None,
  Desktop,
  RailApplications,
}

@doc("Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints")
enum HostpoolPublicNetworkAccess {
  Enabled,
  Disabled,
  EnabledForSessionHostsOnly,
  EnabledForClientsOnly,
}

@doc("The type of maintenance for session host components.")
enum SessionHostComponentUpdateType {
  @doc("Agent and other agent side components are delivery schedule is controlled by WVD Infra.")
  Default,
  @doc("TenantAdmin have opted in for Scheduled Component Update feature.")
  Scheduled,
}

@doc("Application type of application.")
enum ApplicationType {
  RemoteApp,
  Desktop,
}

@doc("State of user session.")
enum SessionState {
  Unknown,
  Active,
  Disconnected,
  Pending,
  LogOff,
  UserProfileDiskMounted,
}

@doc("Status for a SessionHost.")
enum Status {
  @doc("Session Host has passed all the health checks and is available to handle connections.")
  Available,
  @doc("Session Host is either turned off or has failed critical health checks which is causing service not to be able to route connections to this session host. Note this replaces previous 'NoHeartBeat' status.")
  Unavailable,
  @doc("Session Host is shutdown - RD Agent reported session host to be stopped or deallocated.")
  Shutdown,
  @doc("The Session Host is unavailable because it is currently disconnected.")
  Disconnected,
  @doc("Session Host is unavailable because currently an upgrade of RDAgent/side-by-side stack is in progress. Note: this state will be removed once the upgrade completes and the host is able to accept connections.")
  Upgrading,
  @doc("Session Host is unavailable because the critical component upgrade (agent, side-by-side stack, etc.) failed.")
  UpgradeFailed,
  @doc("The Session Host is not heart beating.") NoHeartbeat,
  @doc("SessionHost is not joined to domain.") NotJoinedToDomain,
  @doc("SessionHost's domain trust relationship lost")
  DomainTrustRelationshipLost,
  @doc("SxS stack installed on the SessionHost is not ready to receive connections.")
  SxSStackListenerNotReady,
  @doc("FSLogix is in an unhealthy state on the session host.")
  FSLogixNotHealthy,
  @doc("New status to inform admins that the health on their endpoint needs to be fixed. The connections might not fail, as these issues are not fatal.")
  NeedsAssistance,
}

@doc("Update state of a SessionHost.")
enum UpdateState {
  Initial,
  Pending,
  Started,
  Succeeded,
  Failed,
}

@doc("Represents the name of the health check operation performed.")
enum HealthCheckName {
  @doc("Verifies the SessionHost is joined to a domain. If this check fails is classified as fatal as no connection can succeed if the SessionHost is not joined to the domain. (Currently Enabled)")
  DomainJoinedCheck,
  @doc("Verifies the SessionHost is not experiencing domain trust issues that will prevent authentication on SessionHost at connection time when session is created. If this check fails is classified as fatal as no connection can succeed if we cannot reach the domain for authentication on the SessionHost. (Currently Enabled)")
  DomainTrustCheck,
  @doc("Verifies the FSLogix service is up and running to make sure users' profiles are loaded in the session. If this check fails is classified as fatal as even if the connection can succeed, user experience is bad as the user profile cannot be loaded and user will get a temporary profile in the session. (Currently Disabled)")
  FSLogixHealthCheck,
  @doc("Verifies that the SxS stack is up and running so connections can succeed. If this check fails is classified as fatal as no connection can succeed if the SxS stack is not ready. (Currently Enabled)")
  SxSStackListenerCheck,
  @doc("Verifies that the required WVD service and Geneva URLs are reachable from the SessionHost. These URLs are: RdTokenUri, RdBrokerURI, RdDiagnosticsUri and storage blob URLs for agent monitoring (geneva). If this check fails, it is non fatal and the machine still can service connections, main issue may be that monitoring agent is unable to store warm path data (logs, operations ...). (Currently Disabled)")
  UrlsAccessibleCheck,
  @doc("Verifies that the required Geneva agent is running. If this check fails, it is non fatal and the machine still can service connections, main issue may be that monitoring agent is missing or running (possibly) older version. (Currently Enabled)")
  MonitoringAgentCheck,
  @doc("Verifies the domain the SessionHost is joined to is still reachable. If this check fails is classified as fatal as no connection can succeed if the domain the SessionHost is joined is not reachable at the time of connection. (Currently Disabled)")
  DomainReachable,
  @doc("Verifies whether the WebRTCRedirector component is healthy. The WebRTCRedirector component is used to optimize video and audio performance in Microsoft Teams. This checks whether the component is still running, and whether there is a higher version available. If this check fails, it is non fatal and the machine still can service connections, main issue may be the WebRTCRedirector component has to be restarted or updated. (Currently Disabled)")
  WebRTCRedirectorCheck,
  @doc("Verifies the value of SecurityLayer registration key. If the value is 0 (SecurityLayer.RDP) this check fails with Error code = NativeMethodErrorCode.E_FAIL and is fatal. If the value is 1 (SecurityLayer.Negotiate) this check fails with Error code = NativeMethodErrorCode.ERROR_SUCCESS and is non fatal. (Currently Disabled)")
  SupportedEncryptionCheck,
  @doc("Verifies the metadata service is accessible and return compute properties. (Currently Enabled)")
  MetaDataServiceCheck,
  @doc("Verifies that the AppAttachService is healthy (there were no issues during package staging). The AppAttachService is used to enable the staging/registration (and eventual deregistration/destaging) of MSIX apps that have been set up by the tenant admin. This checks whether the component had any failures during package staging. Failures in staging will prevent some MSIX apps from working properly for the end user. If this check fails, it is non fatal and the machine still can service connections, main issue may be certain apps will not work for end-users. (Currently Enabled)")
  AppAttachHealthCheck,
}

@doc("Represents the Health state of the health check we performed.")
enum HealthCheckResult {
  @doc("Health check result is not currently known.") Unknown,
  @doc("Health check passed.") HealthCheckSucceeded,
  @doc("Health check failed.") HealthCheckFailed,
  @doc("We received a Shutdown notification.") SessionHostShutdown,
}

@doc("Day of the week.")
@fixed
enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

@doc("Supported operation of this resource provider.")
model ResourceProviderOperation {
  @doc("Operation name, in format of {provider}/{resource}/{operation}")
  name?: string;

  @doc("Display metadata associated with the operation.")
  display?: ResourceProviderOperationDisplay;

  @doc("Is a data action.")
  isDataAction?: boolean;

  @doc("Properties of the operation")
  properties?: OperationProperties;
}

@doc("Display metadata associated with the operation.")
model ResourceProviderOperationDisplay {
  @doc("Resource provider: Microsoft Desktop Virtualization.")
  provider?: string;

  @doc("Resource on which the operation is performed.")
  resource?: string;

  @doc("Type of operation: get, read, delete, etc.")
  operation?: string;

  @doc("Description of this operation.")
  description?: string;
}

@doc("Properties of the operation")
model OperationProperties {
  @doc("Service specification payload")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification payload")
model ServiceSpecification {
  @doc("Specifications of the Log for Azure Monitoring")
  logSpecifications?: LogSpecification[];
}

@doc("Specifications of the Log for Azure Monitoring")
model LogSpecification {
  @doc("Name of the log")
  name?: string;

  @doc("Localized friendly display name of the log")
  displayName?: string;

  @doc("Blob duration of the log")
  blobDuration?: string;
}

@doc("Cloud error object.")
@error
model CloudError {
  @doc("Cloud error object properties.")
  error?: CloudErrorProperties;
}

@doc("Cloud error object properties.")
model CloudErrorProperties {
  @doc("Error code")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  message?: string;
}

@doc("Schema for Workspace properties.")
model WorkspaceProperties {
  @doc("ObjectId of Workspace. (internal use)")
  @visibility("read")
  objectId?: string;

  @doc("Description of Workspace.")
  description?: string;

  @doc("Friendly name of Workspace.")
  friendlyName?: string;

  @doc("List of applicationGroup resource Ids.")
  applicationGroupReferences?: string[];

  @doc("Is cloud pc resource.")
  @visibility("read")
  cloudPcResource?: boolean;

  @doc("Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("List of private endpoint connection associated with the specified resource")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("The Private Endpoint Connection resource.")
model PrivateEndpointConnection extends Resource {
  @doc("Resource properties.")
  properties?: PrivateEndpointConnectionProperties;
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The resource model definition containing the full set of allowed properties for a resource. Except properties bag, there cannot be a top level property outside of this set.")
model ResourceModelWithAllowedPropertySet {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("The geo-location where the resource lives")
  @visibility("read", "create")
  location?: string;

  @doc("The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.")
  @visibility("read", "create", "update")
  managedBy?: string;

  @doc("Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.")
  @visibility("read", "create")
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  @doc("The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields. ")
  @visibility("read")
  etag?: string;

  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  identity?: ResourceModelWithAllowedPropertySetIdentity;

  @doc("The resource model definition representing SKU")
  sku?: Sku;

  plan?: ResourceModelWithAllowedPropertySetPlan;
}

model ResourceModelWithAllowedPropertySetIdentity extends Identity {}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: "SystemAssigned";
}

@doc("The resource model definition representing SKU")
model Sku {
  @doc("The name of the SKU. Ex - P3. It is typically a letter+number code")
  name: string;

  @doc("This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.")
  tier?: SkuTier;

  @doc("The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code. ")
  size?: string;

  @doc("If the service has different generations of hardware, for the same SKU, then that can be captured here.")
  family?: string;

  @doc("If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.")
  capacity?: int32;
}

model ResourceModelWithAllowedPropertySetPlan extends Plan {}

@doc("Plan for the resource.")
model Plan {
  @doc("A user defined name of the 3rd Party Artifact that is being procured.")
  name: string;

  @doc("The publisher of the 3rd Party Artifact that is being bought. E.g. NewRelic")
  publisher: string;

  @doc("The 3rd Party artifact that is being procured. E.g. NewRelic. Product maps to the OfferID specified for the artifact at the time of Data Market onboarding. ")
  product: string;

  @doc("A publisher provided promotion code as provisioned in Data Market for the said product/artifact.")
  promotionCode?: string;

  @doc("The version of the desired product/artifact.")
  version?: string;
}

@doc("Workspace properties that can be patched.")
model WorkspacePatch {
  @doc("tags to be updated")
  tags?: Record<string>;

  @doc("Detailed properties for Workspace")
  properties?: WorkspacePatchProperties;
}

@doc("Workspace properties that can be patched.")
model WorkspacePatchProperties {
  @doc("Description of Workspace.")
  description?: string;

  @doc("Friendly name of Workspace.")
  friendlyName?: string;

  @doc("List of applicationGroup links.")
  applicationGroupReferences?: string[];

  @doc("Enabled to allow this resource to be access from the public network")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("A list of private link resources")
model PrivateLinkResourceListResult is Azure.Core.Page<PrivateLinkResource>;

@doc("A private link resource")
model PrivateLinkResource extends Resource {
  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("Scaling plan properties.")
model ScalingPlanProperties {
  @doc("ObjectId of scaling plan. (internal use)")
  @visibility("read")
  objectId?: string;

  @doc("Description of scaling plan.")
  description?: string;

  @doc("User friendly name of scaling plan.")
  friendlyName?: string;

  @doc("Timezone of the scaling plan.")
  timeZone: string;

  @doc("HostPool type for desktop.")
  hostPoolType?: ScalingHostPoolType;

  @doc("Exclusion tag for scaling plan.")
  exclusionTag?: string;

  @doc("List of ScalingPlanPooledSchedule definitions.")
  schedules?: ScalingSchedule[];

  @doc("List of ScalingHostPoolReference definitions.")
  hostPoolReferences?: ScalingHostPoolReference[];
}

@doc("A ScalingPlanPooledSchedule.")
model ScalingSchedule {
  @doc("Name of the ScalingPlanPooledSchedule.")
  name?: string;

  @doc("Set of days of the week on which this schedule is active.")
  daysOfWeek?: ScalingScheduleDaysOfWeekItem[];

  @doc("Starting time for ramp up period.")
  rampUpStartTime?: Time;

  @doc("Load balancing algorithm for ramp up period.")
  rampUpLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  @doc("Minimum host percentage for ramp up period.")
  @maxValue(100)
  rampUpMinimumHostsPct?: int32;

  @doc("Capacity threshold for ramp up period.")
  @maxValue(100)
  @minValue(1)
  rampUpCapacityThresholdPct?: int32;

  @doc("Starting time for peak period.")
  peakStartTime?: Time;

  @doc("Load balancing algorithm for peak period.")
  peakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  @doc("Starting time for ramp down period.")
  rampDownStartTime?: Time;

  @doc("Load balancing algorithm for ramp down period.")
  rampDownLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  @doc("Minimum host percentage for ramp down period.")
  @maxValue(100)
  rampDownMinimumHostsPct?: int32;

  @doc("Capacity threshold for ramp down period.")
  @maxValue(100)
  @minValue(1)
  rampDownCapacityThresholdPct?: int32;

  @doc("Should users be logged off forcefully from hosts.")
  rampDownForceLogoffUsers?: boolean;

  @doc("Specifies when to stop hosts during ramp down period.")
  rampDownStopHostsWhen?: StopHostsWhen;

  @doc("Number of minutes to wait to stop hosts during ramp down period.")
  rampDownWaitTimeMinutes?: int32;

  @doc("Notification message for users during ramp down period.")
  rampDownNotificationMessage?: string;

  @doc("Starting time for off-peak period.")
  offPeakStartTime?: Time;

  @doc("Load balancing algorithm for off-peak period.")
  offPeakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;
}

@doc("The time for a scaling action to occur.")
model Time {
  @doc("The hour.")
  @maxValue(23)
  hour: int32;

  @doc("The minute.")
  @maxValue(59)
  minute: int32;
}

@doc("Scaling plan reference to hostpool.")
model ScalingHostPoolReference {
  @doc("Arm path of referenced hostpool.")
  hostPoolArmPath?: string;

  @doc("Is the scaling plan enabled for this hostpool.")
  scalingPlanEnabled?: boolean;
}

@doc("Scaling plan properties that can be patched.")
model ScalingPlanPatch {
  @doc("tags to be updated")
  tags?: Record<string>;

  @doc("Detailed properties for scaling plan")
  properties?: ScalingPlanPatchProperties;
}

@doc("Scaling plan properties.")
model ScalingPlanPatchProperties {
  @doc("Description of scaling plan.")
  description?: string;

  @doc("User friendly name of scaling plan.")
  friendlyName?: string;

  @doc("Timezone of the scaling plan.")
  timeZone?: string;

  @doc("Exclusion tag for scaling plan.")
  exclusionTag?: string;

  @doc("List of ScalingSchedule definitions.")
  schedules?: ScalingSchedule[];

  @doc("List of ScalingHostPoolReference definitions.")
  hostPoolReferences?: ScalingHostPoolReference[];
}

@doc("A ScalingPlanPooledSchedule.")
model ScalingPlanPooledScheduleProperties {
  @doc("Set of days of the week on which this schedule is active.")
  daysOfWeek?: DayOfWeek[];

  @doc("Starting time for ramp up period.")
  rampUpStartTime?: Time;

  @doc("Load balancing algorithm for ramp up period.")
  rampUpLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  @doc("Minimum host percentage for ramp up period.")
  @maxValue(100)
  rampUpMinimumHostsPct?: int32;

  @doc("Capacity threshold for ramp up period.")
  @maxValue(100)
  @minValue(1)
  rampUpCapacityThresholdPct?: int32;

  @doc("Starting time for peak period.")
  peakStartTime?: Time;

  @doc("Load balancing algorithm for peak period.")
  peakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  @doc("Starting time for ramp down period.")
  rampDownStartTime?: Time;

  @doc("Load balancing algorithm for ramp down period.")
  rampDownLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;

  @doc("Minimum host percentage for ramp down period.")
  @maxValue(100)
  rampDownMinimumHostsPct?: int32;

  @doc("Capacity threshold for ramp down period.")
  @maxValue(100)
  @minValue(1)
  rampDownCapacityThresholdPct?: int32;

  @doc("Should users be logged off forcefully from hosts.")
  rampDownForceLogoffUsers?: boolean;

  @doc("Specifies when to stop hosts during ramp down period.")
  rampDownStopHostsWhen?: StopHostsWhen;

  @doc("Number of minutes to wait to stop hosts during ramp down period.")
  rampDownWaitTimeMinutes?: int32;

  @doc("Notification message for users during ramp down period.")
  rampDownNotificationMessage?: string;

  @doc("Starting time for off-peak period.")
  offPeakStartTime?: Time;

  @doc("Load balancing algorithm for off-peak period.")
  offPeakLoadBalancingAlgorithm?: SessionHostLoadBalancingAlgorithm;
}

@doc("ScalingPlanPooledSchedule properties that can be patched.")
model ScalingPlanPooledSchedulePatch extends Resource {
  @doc("Detailed properties for ScalingPlanPooledSchedule")
  properties?: ScalingPlanPooledScheduleProperties;
}

@doc("A ScalingPlanPersonalSchedule.")
model ScalingPlanPersonalScheduleProperties {
  @doc("Set of days of the week on which this schedule is active.")
  daysOfWeek?: DayOfWeek[];

  @doc("Starting time for ramp up period.")
  rampUpStartTime?: Time;

  @doc("The desired startup behavior during the ramp up period for personal vms in the hostpool.")
  rampUpAutoStartHosts?: StartupBehavior;

  @doc("The desired configuration of Start VM On Connect for the hostpool during the ramp up phase. If this is disabled, session hosts must be turned on using rampUpAutoStartHosts or by turning them on manually.")
  rampUpStartVMOnConnect?: SetStartVMOnConnect;

  @doc("Action to be taken after a user disconnect during the ramp up period.")
  rampUpActionOnDisconnect?: SessionHandlingOperation;

  @doc("The time in minutes to wait before performing the desired session handling action when a user disconnects during the ramp up period.")
  rampUpMinutesToWaitOnDisconnect?: int32;

  @doc("Action to be taken after a logoff during the ramp up period.")
  rampUpActionOnLogoff?: SessionHandlingOperation;

  @doc("The time in minutes to wait before performing the desired session handling action when a user logs off during the ramp up period.")
  rampUpMinutesToWaitOnLogoff?: int32;

  @doc("Starting time for peak period.")
  peakStartTime?: Time;

  @doc("The desired configuration of Start VM On Connect for the hostpool during the peak phase.")
  peakStartVMOnConnect?: SetStartVMOnConnect;

  @doc("Action to be taken after a user disconnect during the peak period.")
  peakActionOnDisconnect?: SessionHandlingOperation;

  @doc("The time in minutes to wait before performing the desired session handling action when a user disconnects during the peak period.")
  peakMinutesToWaitOnDisconnect?: int32;

  @doc("Action to be taken after a logoff during the peak period.")
  peakActionOnLogoff?: SessionHandlingOperation;

  @doc("The time in minutes to wait before performing the desired session handling action when a user logs off during the peak period.")
  peakMinutesToWaitOnLogoff?: int32;

  @doc("Starting time for ramp down period.")
  rampDownStartTime?: Time;

  @doc("The desired configuration of Start VM On Connect for the hostpool during the ramp down phase.")
  rampDownStartVMOnConnect?: SetStartVMOnConnect;

  @doc("Action to be taken after a user disconnect during the ramp down period.")
  rampDownActionOnDisconnect?: SessionHandlingOperation;

  @doc("The time in minutes to wait before performing the desired session handling action when a user disconnects during the ramp down period.")
  rampDownMinutesToWaitOnDisconnect?: int32;

  @doc("Action to be taken after a logoff during the ramp down period.")
  rampDownActionOnLogoff?: SessionHandlingOperation;

  @doc("The time in minutes to wait before performing the desired session handling action when a user logs off during the ramp down period.")
  rampDownMinutesToWaitOnLogoff?: int32;

  @doc("Starting time for off-peak period.")
  offPeakStartTime?: Time;

  @doc("The desired configuration of Start VM On Connect for the hostpool during the off-peak phase.")
  offPeakStartVMOnConnect?: SetStartVMOnConnect;

  @doc("Action to be taken after a user disconnect during the off-peak period.")
  offPeakActionOnDisconnect?: SessionHandlingOperation;

  @doc("The time in minutes to wait before performing the desired session handling action when a user disconnects during the off-peak period.")
  offPeakMinutesToWaitOnDisconnect?: int32;

  @doc("Action to be taken after a logoff during the off-peak period.")
  offPeakActionOnLogoff?: SessionHandlingOperation;

  @doc("The time in minutes to wait before performing the desired session handling action when a user logs off during the off-peak period.")
  offPeakMinutesToWaitOnLogoff?: int32;
}

@doc("ScalingPlanPersonalSchedule properties that can be patched.")
model ScalingPlanPersonalSchedulePatch {
  @doc("Detailed properties for ScalingPlanPersonalSchedule")
  properties?: ScalingPlanPersonalScheduleProperties;
}

@doc("Schema for ApplicationGroup properties.")
model ApplicationGroupProperties {
  @doc("ObjectId of ApplicationGroup. (internal use)")
  @visibility("read")
  objectId?: string;

  @doc("Description of ApplicationGroup.")
  description?: string;

  @doc("Friendly name of ApplicationGroup.")
  friendlyName?: string;

  @doc("HostPool arm path of ApplicationGroup.")
  hostPoolArmPath: string;

  @doc("Workspace arm path of ApplicationGroup.")
  @visibility("read")
  workspaceArmPath?: string;

  @doc("Resource Type of ApplicationGroup.")
  applicationGroupType: ApplicationGroupType;

  @doc("Is cloud pc resource.")
  @visibility("read")
  cloudPcResource?: boolean;

  @doc("Boolean representing whether the applicationGroup is show in the feed.")
  showInFeed?: boolean;
}

@doc("ApplicationGroup properties that can be patched.")
model ApplicationGroupPatch extends Resource {
  @doc("tags to be updated")
  tags?: Record<string>;

  @doc("ApplicationGroup properties that can be patched.")
  properties?: ApplicationGroupPatchProperties;
}

@doc("ApplicationGroup properties that can be patched.")
model ApplicationGroupPatchProperties {
  @doc("Description of ApplicationGroup.")
  description?: string;

  @doc("Friendly name of ApplicationGroup.")
  friendlyName?: string;

  @doc("Boolean representing whether the applicationGroup is show in the feed.")
  showInFeed?: boolean;
}

@doc("List of StartMenuItem definitions.")
model StartMenuItemList is Azure.Core.Page<StartMenuItem>;

@doc("Represents a StartMenuItem definition.")
model StartMenuItem extends Resource {
  @doc("Detailed properties for StartMenuItem")
  properties?: StartMenuItemProperties;
}

@doc("Schema for StartMenuItem properties.")
model StartMenuItemProperties {
  @doc("Alias of StartMenuItem.")
  appAlias?: string;

  @doc("Path to the file of StartMenuItem.")
  filePath?: string;

  @doc("Command line arguments for StartMenuItem.")
  commandLineArguments?: string;

  @doc("Path to the icon.")
  iconPath?: string;

  @doc("Index of the icon.")
  iconIndex?: int32;
}

@doc("Schema for Application properties.")
model ApplicationProperties {
  @doc("ObjectId of Application. (internal use)")
  @visibility("read")
  objectId?: string;

  @doc("Description of Application.")
  description?: string;

  @doc("Friendly name of Application.")
  friendlyName?: string;

  @doc("Specifies a path for the executable file for the application.")
  filePath?: string;

  @doc("Specifies the package family name for MSIX applications")
  @visibility("read", "create")
  msixPackageFamilyName?: string;

  @doc("Specifies the package application Id for MSIX applications")
  @visibility("read", "create")
  msixPackageApplicationId?: string;

  @doc("Resource Type of Application.")
  @visibility("read", "create")
  applicationType?: RemoteApplicationType;

  @doc("Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all.")
  commandLineSetting: CommandLineSetting;

  @doc("Command Line Arguments for Application.")
  commandLineArguments?: string;

  @doc("Specifies whether to show the RemoteApp program in the RD Web Access server.")
  showInPortal?: boolean;

  @doc("Path to icon.")
  iconPath?: string;

  @doc("Index of the icon.")
  iconIndex?: int32;

  @doc("Hash of the icon.")
  @visibility("read")
  iconHash?: string;

  @doc("the icon a 64 bit string as a byte array.")
  @visibility("read")
  iconContent?: string;
}

@doc("Application properties that can be patched.")
model ApplicationPatch {
  @doc("tags to be updated")
  tags?: Record<string>;

  @doc("Detailed properties for Application")
  properties?: ApplicationPatchProperties;
}

@doc("Application properties that can be patched.")
model ApplicationPatchProperties {
  @doc("Description of Application.")
  description?: string;

  @doc("Friendly name of Application.")
  friendlyName?: string;

  @doc("Specifies a path for the executable file for the application.")
  filePath?: string;

  @doc("Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all.")
  commandLineSetting?: CommandLineSetting;

  @doc("Command Line Arguments for Application.")
  commandLineArguments?: string;

  @doc("Specifies whether to show the RemoteApp program in the RD Web Access server.")
  showInPortal?: boolean;

  @doc("Path to icon.")
  iconPath?: string;

  @doc("Index of the icon.")
  iconIndex?: int32;

  @doc("Specifies the package family name for MSIX applications")
  msixPackageFamilyName?: string;

  @doc("Specifies the package application Id for MSIX applications")
  msixPackageApplicationId?: string;

  @doc("Resource Type of Application.")
  applicationType?: RemoteApplicationType;
}

@doc("Schema for Desktop properties.")
model DesktopProperties {
  @doc("ObjectId of Desktop. (internal use)")
  @visibility("read")
  objectId?: string;

  @doc("Description of Desktop.")
  description?: string;

  @doc("Friendly name of Desktop.")
  friendlyName?: string;

  @doc("Hash of the icon.")
  @visibility("read")
  iconHash?: string;

  @doc("The icon a 64 bit string as a byte array.")
  @visibility("read")
  iconContent?: string;
}

@doc("Desktop properties that can be patched.")
model DesktopPatch {
  @doc("tags to be updated")
  tags?: Record<string>;

  @doc("Detailed properties for Desktop")
  properties?: DesktopPatchProperties;
}

@doc("Desktop properties that can be patched.")
model DesktopPatchProperties {
  @doc("Description of Desktop.")
  description?: string;

  @doc("Friendly name of Desktop.")
  friendlyName?: string;
}

@doc("Properties of HostPool.")
model HostPoolProperties {
  @doc("ObjectId of HostPool. (internal use)")
  @visibility("read")
  objectId?: string;

  @doc("Friendly name of HostPool.")
  friendlyName?: string;

  @doc("Description of HostPool.")
  description?: string;

  @doc("HostPool type for desktop.")
  hostPoolType: HostPoolType;

  @doc("PersonalDesktopAssignment type for HostPool.")
  personalDesktopAssignmentType?: PersonalDesktopAssignmentType;

  @doc("Custom rdp property of HostPool.")
  customRdpProperty?: string;

  @doc("The max session limit of HostPool.")
  maxSessionLimit?: int32;

  @doc("The type of the load balancer.")
  loadBalancerType: LoadBalancerType;

  @doc("The ring number of HostPool.")
  ring?: int32;

  @doc("Is validation environment.")
  validationEnvironment?: boolean;

  @doc("The registration info of HostPool.")
  registrationInfo?: RegistrationInfo;

  @doc("VM template for sessionhosts configuration within hostpool.")
  vmTemplate?: string;

  @doc("List of applicationGroup links.")
  @visibility("read")
  applicationGroupReferences?: string[];

  @doc("URL to customer ADFS server for signing WVD SSO certificates.")
  ssoadfsAuthority?: string;

  @doc("ClientId for the registered Relying Party used to issue WVD SSO certificates.")
  ssoClientId?: string;

  @doc("Path to Azure KeyVault storing the secret used for communication to ADFS.")
  ssoClientSecretKeyVaultPath?: string;

  @doc("The type of single sign on Secret Type.")
  ssoSecretType?: SSOSecretType;

  @doc("The type of preferred application group type, default to Desktop Application Group")
  preferredAppGroupType: PreferredAppGroupType;

  @doc("The flag to turn on/off StartVMOnConnect feature.")
  startVMOnConnect?: boolean;

  @doc("Is cloud pc resource.")
  @visibility("read")
  cloudPcResource?: boolean;

  @doc("Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints")
  publicNetworkAccess?: HostpoolPublicNetworkAccess;

  @doc("The session host configuration for updating agent, monitoring agent, and stack component.")
  agentUpdate?: AgentUpdateProperties;

  @doc("List of private endpoint connection associated with the specified resource")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("Represents a RegistrationInfo definition.")
model RegistrationInfo {
  @doc("Expiration time of registration token.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  @doc("The registration token base64 encoded string.")
  token?: string;

  @doc("The type of resetting the token.")
  registrationTokenOperation?: RegistrationTokenOperation;
}

@doc("The session host configuration for updating agent, monitoring agent, and stack component.")
model AgentUpdateProperties {
  @doc("The type of maintenance for session host components.")
  type?: SessionHostComponentUpdateType;

  @doc("Whether to use localTime of the virtual machine.")
  useSessionHostLocalTime?: boolean;

  @doc("Time zone for maintenance as defined in https://docs.microsoft.com/en-us/dotnet/api/system.timezoneinfo.findsystemtimezonebyid?view=net-5.0. Must be set if useLocalTime is true.")
  maintenanceWindowTimeZone?: string;

  @doc("List of maintenance windows. Maintenance windows are 2 hours long.")
  maintenanceWindows?: MaintenanceWindowProperties[];
}

@doc("Maintenance window starting hour and day of week.")
model MaintenanceWindowProperties {
  @doc("The update start hour of the day. (0 - 23)")
  hour?: int32;

  @doc("Day of the week.")
  dayOfWeek?: DayOfWeek;
}

@doc("HostPool properties that can be patched.")
model HostPoolPatch extends Resource {
  @doc("tags to be updated")
  tags?: Record<string>;

  @doc("HostPool properties that can be patched.")
  properties?: HostPoolPatchProperties;
}

@doc("Properties of HostPool.")
model HostPoolPatchProperties {
  @doc("Friendly name of HostPool.")
  friendlyName?: string;

  @doc("Description of HostPool.")
  description?: string;

  @doc("Custom rdp property of HostPool.")
  customRdpProperty?: string;

  @doc("The max session limit of HostPool.")
  maxSessionLimit?: int32;

  @doc("PersonalDesktopAssignment type for HostPool.")
  personalDesktopAssignmentType?: PersonalDesktopAssignmentType;

  @doc("The type of the load balancer.")
  loadBalancerType?: LoadBalancerType;

  @doc("The ring number of HostPool.")
  ring?: int32;

  @doc("Is validation environment.")
  validationEnvironment?: boolean;

  @doc("The registration info of HostPool.")
  registrationInfo?: RegistrationInfoPatch;

  @doc("VM template for sessionhosts configuration within hostpool.")
  vmTemplate?: string;

  @doc("URL to customer ADFS server for signing WVD SSO certificates.")
  ssoadfsAuthority?: string;

  @doc("ClientId for the registered Relying Party used to issue WVD SSO certificates.")
  ssoClientId?: string;

  @doc("Path to Azure KeyVault storing the secret used for communication to ADFS.")
  ssoClientSecretKeyVaultPath?: string;

  @doc("The type of single sign on Secret Type.")
  ssoSecretType?: SSOSecretType;

  @doc("The type of preferred application group type, default to Desktop Application Group")
  preferredAppGroupType?: PreferredAppGroupType;

  @doc("The flag to turn on/off StartVMOnConnect feature.")
  startVMOnConnect?: boolean;

  @doc("Enabled to allow this resource to be access from the public network")
  publicNetworkAccess?: HostpoolPublicNetworkAccess;

  @doc("The session host configuration for updating agent, monitoring agent, and stack component.")
  agentUpdate?: AgentUpdatePatchProperties;
}

@doc("Represents a RegistrationInfo definition.")
model RegistrationInfoPatch {
  @doc("Expiration time of registration token.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  @doc("The type of resetting the token.")
  registrationTokenOperation?: RegistrationTokenOperation;
}

@doc("The session host configuration for updating agent, monitoring agent, and stack component.")
model AgentUpdatePatchProperties {
  @doc("The type of maintenance for session host components.")
  type?: SessionHostComponentUpdateType;

  @doc("Whether to use localTime of the virtual machine.")
  useSessionHostLocalTime?: boolean;

  @doc("Time zone for maintenance as defined in https://docs.microsoft.com/en-us/dotnet/api/system.timezoneinfo.findsystemtimezonebyid?view=net-5.0. Must be set if useLocalTime is true.")
  maintenanceWindowTimeZone?: string;

  @doc("List of maintenance windows. Maintenance windows are 2 hours long.")
  maintenanceWindows?: MaintenanceWindowPatchProperties[];
}

@doc("Maintenance window starting hour and day of week.")
model MaintenanceWindowPatchProperties {
  @doc("The update start hour of the day. (0 - 23)")
  hour?: int32;

  @doc("Day of the week.")
  dayOfWeek?: DayOfWeek;
}

@doc("Schema for UserSession properties.")
model UserSessionProperties {
  @doc("ObjectId of user session. (internal use)")
  @visibility("read")
  objectId?: string;

  @doc("The user principal name.")
  userPrincipalName?: string;

  @doc("Application type of application.")
  applicationType?: ApplicationType;

  @doc("State of user session.")
  sessionState?: SessionState;

  @doc("The active directory user name.")
  activeDirectoryUserName?: string;

  @doc("The timestamp of the user session create.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;
}

@doc("Schema for SessionHost properties.")
model SessionHostProperties {
  @doc("ObjectId of SessionHost. (internal use)")
  @visibility("read")
  objectId?: string;

  @doc("Last heart beat from SessionHost.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartBeat?: utcDateTime;

  @doc("Number of sessions on SessionHost.")
  sessions?: int32;

  @doc("Version of agent on SessionHost.")
  agentVersion?: string;

  @doc("Allow a new session.")
  allowNewSession?: boolean;

  @doc("Virtual Machine Id of SessionHost's underlying virtual machine.")
  @visibility("read")
  virtualMachineId?: string;

  @doc("Resource Id of SessionHost's underlying virtual machine.")
  @visibility("read")
  resourceId?: string;

  @doc("User assigned to SessionHost.")
  assignedUser?: string;

  @doc("Friendly name of SessionHost")
  friendlyName?: string;

  @doc("Status for a SessionHost.")
  status?: Status;

  @doc("The timestamp of the status.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  statusTimestamp?: utcDateTime;

  @doc("The version of the OS on the session host.")
  osVersion?: string;

  @doc("The version of the side by side stack on the session host.")
  sxSStackVersion?: string;

  @doc("Update state of a SessionHost.")
  updateState?: UpdateState;

  @doc("The timestamp of the last update.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;

  @doc("The error message.")
  updateErrorMessage?: string;

  @doc("List of SessionHostHealthCheckReports")
  @visibility("read")
  sessionHostHealthCheckResults?: SessionHostHealthCheckReport[];
}

@doc("The report for session host information.")
model SessionHostHealthCheckReport {
  @doc("Represents the name of the health check operation performed.")
  @visibility("read")
  healthCheckName?: HealthCheckName;

  @doc("Represents the Health state of the health check we performed.")
  @visibility("read")
  healthCheckResult?: HealthCheckResult;

  @doc("Additional detailed information on the failure.")
  @visibility("read")
  additionalFailureDetails?: SessionHostHealthCheckFailureDetails;
}

@doc("Contains details on the failure.")
model SessionHostHealthCheckFailureDetails {
  @doc("Failure message: hints on what is wrong and how to recover.")
  @visibility("read")
  message?: string;

  @doc("Error code corresponding for the failure.")
  @visibility("read")
  errorCode?: int32;

  @doc("The timestamp of the last update.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHealthCheckDateTime?: utcDateTime;
}

@doc("SessionHost properties that can be patched.")
model SessionHostPatch extends Resource {
  @doc("Detailed properties for SessionHost")
  properties?: SessionHostPatchProperties;
}

@doc("SessionHost properties that can be patched.")
model SessionHostPatchProperties {
  @doc("Allow a new session.")
  allowNewSession?: boolean;

  @doc("User assigned to SessionHost.")
  assignedUser?: string;

  @doc("Friendly name of SessionHost")
  friendlyName?: string;
}

@doc("Schema for MSIX Package properties.")
model MsixPackageProperties {
  @doc("VHD/CIM image path on Network Share.")
  imagePath?: string;

  @doc("Package Name from appxmanifest.xml. ")
  packageName?: string;

  @doc("Package Family Name from appxmanifest.xml. Contains Package Name and Publisher name. ")
  packageFamilyName?: string;

  @doc("User friendly Name to be displayed in the portal. ")
  displayName?: string;

  @doc("Relative Path to the package inside the image. ")
  packageRelativePath?: string;

  @doc("Specifies how to register Package in feed.")
  isRegularRegistration?: boolean;

  @doc("Make this version of the package the active one across the hostpool. ")
  isActive?: boolean;

  @doc("List of package dependencies. ")
  packageDependencies?: MsixPackageDependencies[];

  @doc("Package Version found in the appxmanifest.xml. ")
  version?: string;

  @doc("Date Package was last updated, found in the appxmanifest.xml. ")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  @doc("List of package applications. ")
  packageApplications?: MsixPackageApplications[];
}

@doc("Schema for MSIX Package Dependencies properties.")
model MsixPackageDependencies {
  @doc("Name of package dependency.")
  dependencyName?: string;

  @doc("Name of dependency publisher.")
  publisher?: string;

  @doc("Dependency version required.")
  minVersion?: string;
}

@doc("Schema for MSIX Package Application properties.")
model MsixPackageApplications {
  @doc("Package Application Id, found in appxmanifest.xml.")
  appId?: string;

  @doc("Description of Package Application.")
  description?: string;

  @doc("Used to activate Package Application. Consists of Package Name and ApplicationID. Found in appxmanifest.xml.")
  appUserModelID?: string;

  @doc("User friendly name.")
  friendlyName?: string;

  @doc("User friendly name.")
  iconImageName?: string;

  @doc("the icon a 64 bit string as a byte array.")
  rawIcon?: string;

  @doc("the icon a 64 bit string as a byte array.")
  rawPng?: string;
}

@doc("MSIX Package properties that can be patched.")
model MsixPackagePatch extends Resource {
  @doc("Detailed properties for MSIX Package")
  properties?: MsixPackagePatchProperties;
}

@doc("MSIX Package properties that can be patched.")
model MsixPackagePatchProperties {
  @doc("Set a version of the package to be active across hostpool. ")
  isActive?: boolean;

  @doc("Set Registration mode. Regular or Delayed.")
  isRegularRegistration?: boolean;

  @doc("Display name for MSIX Package.")
  displayName?: string;
}

@doc("Represents URI referring to MSIX Image")
model MsixImageURI {
  @doc("URI to Image")
  uri?: string;
}

@doc("List of MSIX package properties retrieved from MSIX Image expansion.")
model ExpandMsixImageList is Azure.Core.Page<ExpandMsixImage>;

@doc("Represents the definition of contents retrieved after expanding the MSIX Image. ")
model ExpandMsixImage extends Resource {
  @doc("Detailed properties for ExpandMsixImage")
  properties?: ExpandMsixImageProperties;
}

@doc("Schema for Expand MSIX Image properties.")
model ExpandMsixImageProperties {
  @doc("Alias of MSIX Package.")
  packageAlias?: string;

  @doc("VHD/CIM image path on Network Share.")
  imagePath?: string;

  @doc("Package Name from appxmanifest.xml. ")
  packageName?: string;

  @doc("Package Family Name from appxmanifest.xml. Contains Package Name and Publisher name. ")
  packageFamilyName?: string;

  @doc("Package Full Name from appxmanifest.xml. ")
  packageFullName?: string;

  @doc("User friendly Name to be displayed in the portal. ")
  displayName?: string;

  @doc("Relative Path to the package inside the image. ")
  packageRelativePath?: string;

  @doc("Specifies how to register Package in feed.")
  isRegularRegistration?: boolean;

  @doc("Make this version of the package the active one across the hostpool. ")
  isActive?: boolean;

  @doc("List of package dependencies. ")
  packageDependencies?: MsixPackageDependencies[];

  @doc("Package Version found in the appxmanifest.xml. ")
  version?: string;

  @doc("Date Package was last updated, found in the appxmanifest.xml. ")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  @doc("List of package applications. ")
  packageApplications?: MsixPackageApplications[];
}

@doc("Represents message sent to a UserSession.")
model SendMessage {
  @doc("Title of message.")
  messageTitle?: string;

  @doc("Body of message.")
  messageBody?: string;
}
