import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DesktopVirtualization;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * HostPool type for desktop.
 */
enum ScalingHostPoolType {
  /**
   * Users get a new (random) SessionHost every time it connects to the HostPool.
   */
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

/**
 * Load balancing algorithm for ramp up period.
 */
enum SessionHostLoadBalancingAlgorithm {
  BreadthFirst,
  DepthFirst,
}

/**
 * Specifies when to stop hosts during ramp down period.
 */
enum StopHostsWhen {
  ZeroSessions,
  ZeroActiveSessions,
}

/**
 * The desired startup behavior during the ramp up period for personal vms in the hostpool.
 */
enum StartupBehavior {
  /**
   * Session hosts will not be started by the service. This setting depends on Start VM on Connect to be enabled to start the session hosts.
   */
  None,

  /**
   * Session hosts with an assigned user will be started during Ramp Up
   */
  WithAssignedUser,

  /**
   * All personal session hosts in the hostpool will be started during ramp up.
   */
  All,
}

/**
 * The desired configuration of Start VM On Connect for the hostpool during the ramp up phase. If this is disabled, session hosts must be turned on using rampUpAutoStartHosts or by turning them on manually.
 */
enum SetStartVMOnConnect {
  Enable,
  Disable,
}

/**
 * Action to be taken after a user disconnect during the ramp up period.
 */
enum SessionHandlingOperation {
  None,
  Deallocate,
  Hibernate,
}

/**
 * Resource Type of ApplicationGroup.
 */
enum ApplicationGroupType {
  RemoteApp,
  Desktop,
}

/**
 * Resource Type of Application.
 */
enum RemoteApplicationType {
  InBuilt,
  MsixApplication,
}

/**
 * Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all.
 */
enum CommandLineSetting {
  DoNotAllow,
  Allow,
  Require,
}

/**
 * HostPool type for desktop.
 */
enum HostPoolType {
  /**
   * Users will be assigned a SessionHost either by administrators (PersonalDesktopAssignmentType = Direct) or upon connecting to the pool (PersonalDesktopAssignmentType = Automatic). They will always be redirected to their assigned SessionHost.
   */
  Personal,

  /**
   * Users get a new (random) SessionHost every time it connects to the HostPool.
   */
  Pooled,

  /**
   * Users assign their own machines, load balancing logic remains the same as Personal. PersonalDesktopAssignmentType must be Direct.
   */
  BYODesktop,
}

/**
 * PersonalDesktopAssignment type for HostPool.
 */
enum PersonalDesktopAssignmentType {
  Automatic,
  Direct,
}

/**
 * The type of the load balancer.
 */
enum LoadBalancerType {
  BreadthFirst,
  DepthFirst,
  Persistent,
}

/**
 * The type of resetting the token.
 */
enum RegistrationTokenOperation {
  Delete,
  None,
  Update,
}

/**
 * The type of single sign on Secret Type.
 */
enum SSOSecretType {
  SharedKey,
  Certificate,
  SharedKeyInKeyVault,
  CertificateInKeyVault,
}

/**
 * The type of preferred application group type, default to Desktop Application Group
 */
enum PreferredAppGroupType {
  None,
  Desktop,
  RailApplications,
}

/**
 * Enabled allows this resource to be accessed from both public and private networks, Disabled allows this resource to only be accessed via private endpoints
 */
enum HostpoolPublicNetworkAccess {
  Enabled,
  Disabled,
  EnabledForSessionHostsOnly,
  EnabledForClientsOnly,
}

/**
 * The type of maintenance for session host components.
 */
enum SessionHostComponentUpdateType {
  /**
   * Agent and other agent side components are delivery schedule is controlled by WVD Infra.
   */
  Default,

  /**
   * TenantAdmin have opted in for Scheduled Component Update feature.
   */
  Scheduled,
}

/**
 * Application type of application.
 */
enum ApplicationType {
  RemoteApp,
  Desktop,
}

/**
 * State of user session.
 */
enum SessionState {
  Unknown,
  Active,
  Disconnected,
  Pending,
  LogOff,
  UserProfileDiskMounted,
}

/**
 * Status for a SessionHost.
 */
enum Status {
  /**
   * Session Host has passed all the health checks and is available to handle connections.
   */
  Available,

  /**
   * Session Host is either turned off or has failed critical health checks which is causing service not to be able to route connections to this session host. Note this replaces previous 'NoHeartBeat' status.
   */
  Unavailable,

  /**
   * Session Host is shutdown - RD Agent reported session host to be stopped or deallocated.
   */
  Shutdown,

  /**
   * The Session Host is unavailable because it is currently disconnected.
   */
  Disconnected,

  /**
   * Session Host is unavailable because currently an upgrade of RDAgent/side-by-side stack is in progress. Note: this state will be removed once the upgrade completes and the host is able to accept connections.
   */
  Upgrading,

  /**
   * Session Host is unavailable because the critical component upgrade (agent, side-by-side stack, etc.) failed.
   */
  UpgradeFailed,

  /**
   * The Session Host is not heart beating.
   */
  NoHeartbeat,

  /**
   * SessionHost is not joined to domain.
   */
  NotJoinedToDomain,

  /**
   * SessionHost's domain trust relationship lost
   */
  DomainTrustRelationshipLost,

  /**
   * SxS stack installed on the SessionHost is not ready to receive connections.
   */
  SxSStackListenerNotReady,

  /**
   * FSLogix is in an unhealthy state on the session host.
   */
  FSLogixNotHealthy,

  /**
   * New status to inform admins that the health on their endpoint needs to be fixed. The connections might not fail, as these issues are not fatal.
   */
  NeedsAssistance,
}

/**
 * Update state of a SessionHost.
 */
enum UpdateState {
  Initial,
  Pending,
  Started,
  Succeeded,
  Failed,
}

/**
 * Represents the name of the health check operation performed.
 */
enum HealthCheckName {
  /**
   * Verifies the SessionHost is joined to a domain. If this check fails is classified as fatal as no connection can succeed if the SessionHost is not joined to the domain. (Currently Enabled)
   */
  DomainJoinedCheck,

  /**
   * Verifies the SessionHost is not experiencing domain trust issues that will prevent authentication on SessionHost at connection time when session is created. If this check fails is classified as fatal as no connection can succeed if we cannot reach the domain for authentication on the SessionHost. (Currently Enabled)
   */
  DomainTrustCheck,

  /**
   * Verifies the FSLogix service is up and running to make sure users' profiles are loaded in the session. If this check fails is classified as fatal as even if the connection can succeed, user experience is bad as the user profile cannot be loaded and user will get a temporary profile in the session. (Currently Disabled)
   */
  FSLogixHealthCheck,

  /**
   * Verifies that the SxS stack is up and running so connections can succeed. If this check fails is classified as fatal as no connection can succeed if the SxS stack is not ready. (Currently Enabled)
   */
  SxSStackListenerCheck,

  /**
   * Verifies that the required WVD service and Geneva URLs are reachable from the SessionHost. These URLs are: RdTokenUri, RdBrokerURI, RdDiagnosticsUri and storage blob URLs for agent monitoring (geneva). If this check fails, it is non fatal and the machine still can service connections, main issue may be that monitoring agent is unable to store warm path data (logs, operations ...). (Currently Disabled)
   */
  UrlsAccessibleCheck,

  /**
   * Verifies that the required Geneva agent is running. If this check fails, it is non fatal and the machine still can service connections, main issue may be that monitoring agent is missing or running (possibly) older version. (Currently Enabled)
   */
  MonitoringAgentCheck,

  /**
   * Verifies the domain the SessionHost is joined to is still reachable. If this check fails is classified as fatal as no connection can succeed if the domain the SessionHost is joined is not reachable at the time of connection. (Currently Disabled)
   */
  DomainReachable,

  /**
   * Verifies whether the WebRTCRedirector component is healthy. The WebRTCRedirector component is used to optimize video and audio performance in Microsoft Teams. This checks whether the component is still running, and whether there is a higher version available. If this check fails, it is non fatal and the machine still can service connections, main issue may be the WebRTCRedirector component has to be restarted or updated. (Currently Disabled)
   */
  WebRTCRedirectorCheck,

  /**
   * Verifies the value of SecurityLayer registration key. If the value is 0 (SecurityLayer.RDP) this check fails with Error code = NativeMethodErrorCode.E_FAIL and is fatal. If the value is 1 (SecurityLayer.Negotiate) this check fails with Error code = NativeMethodErrorCode.ERROR_SUCCESS and is non fatal. (Currently Disabled)
   */
  SupportedEncryptionCheck,

  /**
   * Verifies the metadata service is accessible and return compute properties. (Currently Enabled)
   */
  MetaDataServiceCheck,

  /**
   * Verifies that the AppAttachService is healthy (there were no issues during package staging). The AppAttachService is used to enable the staging/registration (and eventual deregistration/destaging) of MSIX apps that have been set up by the tenant admin. This checks whether the component had any failures during package staging. Failures in staging will prevent some MSIX apps from working properly for the end user. If this check fails, it is non fatal and the machine still can service connections, main issue may be certain apps will not work for end-users. (Currently Enabled)
   */
  AppAttachHealthCheck,
}

/**
 * Represents the Health state of the health check we performed.
 */
enum HealthCheckResult {
  /**
   * Health check result is not currently known.
   */
  Unknown,

  /**
   * Health check passed.
   */
  HealthCheckSucceeded,

  /**
   * Health check failed.
   */
  HealthCheckFailed,

  /**
   * We received a Shutdown notification.
   */
  SessionHostShutdown,
}

/**
 * Day of the week.
 */
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
 * The Private Endpoint Connection resource.
 */
model PrivateEndpointConnection extends Resource {
  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
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
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
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
}

/**
 * The resource model definition containing the full set of allowed properties for a resource. Except properties bag, there cannot be a top level property outside of this set.
 */
model ResourceModelWithAllowedPropertySet {
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
   * The geo-location where the resource lives
   */
  @visibility("read", "create")
  location?: string;

  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  @visibility("read", "create", "update")
  managedBy?: string;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  @visibility("read", "create")
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  /**
   * The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.
   */
  @visibility("read")
  etag?: string;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  identity?: ResourceModelWithAllowedPropertySetIdentity;

  /**
   * The resource model definition representing SKU
   */
  sku?: Sku;

  plan?: ResourceModelWithAllowedPropertySetPlan;
}

model ResourceModelWithAllowedPropertySetIdentity extends Identity {}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
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
  @extension("x-ms-client-flatten", true)
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
 * A list of private link resources
 */
model PrivateLinkResourceListResult is Azure.Core.Page<PrivateLinkResource>;

/**
 * A private link resource
 */
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
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
  @extension("x-ms-client-flatten", true)
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
model ScalingPlanPooledSchedulePatch extends Resource {
  /**
   * Detailed properties for ScalingPlanPooledSchedule
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScalingPlanPooledScheduleProperties;
}

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
  @extension("x-ms-client-flatten", true)
  properties?: ScalingPlanPersonalScheduleProperties;
}

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
 * ApplicationGroup properties that can be patched.
 */
model ApplicationGroupPatch extends Resource {
  /**
   * tags to be updated
   */
  tags?: Record<string>;

  /**
   * ApplicationGroup properties that can be patched.
   */
  @extension("x-ms-client-flatten", true)
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
 * List of StartMenuItem definitions.
 */
model StartMenuItemList is Azure.Core.Page<StartMenuItem>;

/**
 * Represents a StartMenuItem definition.
 */
model StartMenuItem extends Resource {
  /**
   * Detailed properties for StartMenuItem
   */
  @extension("x-ms-client-flatten", true)
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
  iconContent?: string;
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
  @extension("x-ms-client-flatten", true)
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
  iconContent?: string;
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
  @extension("x-ms-client-flatten", true)
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
model HostPoolPatch extends Resource {
  /**
   * tags to be updated
   */
  tags?: Record<string>;

  /**
   * HostPool properties that can be patched.
   */
  @extension("x-ms-client-flatten", true)
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
model SessionHostPatch extends Resource {
  /**
   * Detailed properties for SessionHost
   */
  @extension("x-ms-client-flatten", true)
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
  rawIcon?: string;

  /**
   * the icon a 64 bit string as a byte array.
   */
  rawPng?: string;
}

/**
 * MSIX Package properties that can be patched.
 */
model MsixPackagePatch extends Resource {
  /**
   * Detailed properties for MSIX Package
   */
  @extension("x-ms-client-flatten", true)
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
model ExpandMsixImage extends Resource {
  /**
   * Detailed properties for ExpandMsixImage
   */
  @extension("x-ms-client-flatten", true)
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
