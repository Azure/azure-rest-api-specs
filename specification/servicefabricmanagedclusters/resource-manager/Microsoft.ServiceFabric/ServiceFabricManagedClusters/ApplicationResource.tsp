import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ServiceFabric;
/**
 * The application resource.
 */
@parentResource(ManagedCluster)
model ApplicationResource
  is Azure.ResourceManager.ProxyResource<ApplicationResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationResource,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * Describes the managed identities for an Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Backwards compatibility with existing spec"
  identity?: ManagedIdentity;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Applications {
  /**
   * Get a Service Fabric managed application resource created or in the process of being created in the Service Fabric cluster resource.
   */
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create or update a Service Fabric managed application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ApplicationResource,
    Response = ArmResourceUpdatedResponse<ApplicationResource> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ApplicationResource>> & {
      @bodyRoot
      _: ApplicationResource;
    })
  >;

  /**
   * Updates an application resource of a given managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ApplicationResource,
    PatchModel = ApplicationUpdateParameters,
    Response = ArmResourceUpdatedResponse<ApplicationResource> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ApplicationResource>> & {
      @bodyRoot
      _: ApplicationResource;
    })
  >;

  /**
   * Delete a Service Fabric managed application resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationResource,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all managed application resources created or in the process of being created in the Service Fabric cluster resource.
   */
  list is ArmResourceListByParent<
    ApplicationResource,
    Response = ArmResponse<ApplicationResourceList>
  >;

  /**
   * Get the status of the latest application upgrade. It will query the cluster to find the status of the latest application upgrade.
   */
  @action("fetchUpgradeStatus")
  readUpgrade is ArmResourceActionAsync<
    ApplicationResource,
    void,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Send a request to resume the current application upgrade. This will resume the application upgrade from where it was paused.
   */
  resumeUpgrade is ArmResourceActionAsync<
    ApplicationResource,
    RuntimeResumeApplicationUpgradeParameters,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Send a request to start a rollback of the current application upgrade. This will start rolling back the application to the previous version.
   */
  startRollback is ArmResourceActionAsync<
    ApplicationResource,
    void,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Send a request to update the current application upgrade.
   */
  updateUpgrade is ArmResourceActionAsync<
    ApplicationResource,
    RuntimeUpdateApplicationUpgradeParameters,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Get the status of the deployed application health. It will query the cluster to find the health of the deployed application.
   */
  @added(Versions.v2025_10_01_preview)
  fetchHealth is ArmResourceActionAsync<
    ApplicationResource,
    ApplicationFetchHealthRequest,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Restart a code package instance of a service replica or instance. This is a potentially destabilizing operation that should be used with immense care.
   */
  @added(Versions.v2025_10_01_preview)
  restartDeployedCodePackage is ArmResourceActionAsync<
    ApplicationResource,
    RestartDeployedCodePackageRequest,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;
}

@@doc(ApplicationResource.name, "The name of the application resource.");
@@doc(ApplicationResource.properties, "The application resource properties.");
@@doc(Applications.createOrUpdate::parameters.resource,
  "The application resource."
);
@@doc(Applications.update::parameters.properties,
  "The application resource updated tags."
);
@@doc(Applications.resumeUpgrade::parameters.body,
  "The parameters for resuming an application upgrade."
);
@@doc(Applications.updateUpgrade::parameters.body,
  "The parameters for updating an application upgrade."
);
@@doc(Applications.fetchHealth::parameters.body,
  "The parameters for fetching the health of a deployed application."
);
@@doc(Applications.restartDeployedCodePackage::parameters.body,
  "The parameters for restarting a deployed code package."
);

/**
 * The application resource properties.
 */
model ApplicationResourceProperties {
  /**
   * List of user assigned identities for the application, each mapped to a friendly name.
   */
  @identifiers(#[])
  managedIdentities?: ApplicationUserAssignedIdentity[];

  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Day 0 property, keep as string for backwards compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The version of the application type as defined in the application manifest.
   * This name must be the full Arm Resource ID for the referenced application type version.
   *
   */
  version?: string;

  /**
   * List of application parameters with overridden values from their default values specified in the application manifest.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  parameters?: Record<string>;

  /**
   * Describes the policy for a monitored application upgrade.
   */
  upgradePolicy?: ApplicationUpgradePolicy;
}

/**
 * The list of application resources.
 */
model ApplicationResourceList is Azure.Core.Page<ApplicationResource>;

/**
 * Describes the policy for a monitored application upgrade.
 */
model ApplicationUpgradePolicy {
  /**
   * Defines a health policy used to evaluate the health of an application or one of its children entities.
   *
   */
  applicationHealthPolicy?: ApplicationHealthPolicy;

  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean = false;

  /**
   * The policy used for monitoring the application upgrade
   */
  rollingUpgradeMonitoringPolicy?: RollingUpgradeMonitoringPolicy;

  /**
   * Duration in seconds, to wait before a stateless instance is closed, to allow the active requests to drain gracefully. This would be effective when the instance is closing during the application/cluster upgrade, only for those instances which have a non-zero delay duration configured in the service description.
   */
  instanceCloseDelayDuration?: int64;

  /**
   * The mode used to monitor health during a rolling upgrade. The values are Monitored, and UnmonitoredAuto.
   */
  upgradeMode?: RollingUpgradeMode;

  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer). Unit is in seconds.
   */
  upgradeReplicaSetCheckTimeout?: int64;

  /**
   * Determines whether the application should be recreated on update. If value=true, the rest of the upgrade policy parameters are not allowed.
   */
  recreateApplication?: boolean;
}

/**
 * Represents the health policy used to evaluate the health of services belonging to a service type.
 *
 */
model ServiceTypeHealthPolicy {
  /**
   * The maximum allowed percentage of unhealthy services.
   *
   * The percentage represents the maximum tolerated percentage of services that can be unhealthy before the application is considered in error.
   * If the percentage is respected but there is at least one unhealthy service, the health is evaluated as Warning.
   * This is calculated by dividing the number of unhealthy services of the specific service type over the total number of services of the specific service type.
   * The computation rounds up to tolerate one failure on small numbers of services.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyServices: int32;

  /**
   * The maximum allowed percentage of unhealthy partitions per service.
   *
   * The percentage represents the maximum tolerated percentage of partitions that can be unhealthy before the service is considered in error.
   * If the percentage is respected but there is at least one unhealthy partition, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy partitions over the total number of partitions in the service.
   * The computation rounds up to tolerate one failure on small numbers of partitions.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService: int32;

  /**
   * The maximum allowed percentage of unhealthy replicas per partition.
   *
   * The percentage represents the maximum tolerated percentage of replicas that can be unhealthy before the partition is considered in error.
   * If the percentage is respected but there is at least one unhealthy replica, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy replicas over the total number of replicas in the partition.
   * The computation rounds up to tolerate one failure on small numbers of replicas.
   *
   */
  @maxValue(100)
  @minValue(0)
  maxPercentUnhealthyReplicasPerPartition: int32;
}

/**
 * Defines a health policy used to evaluate the health of an application or one of its children entities.
 *
 */
model ApplicationHealthPolicy {
  /**
   * Indicates whether warnings are treated with the same severity as errors.
   */
  considerWarningAsError: boolean;

  /**
   * The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
   * The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
   * This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
   * The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
   *
   */
  maxPercentUnhealthyDeployedApplications: int32;

  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: ServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to ServiceTypeHealthPolicy dictionary"
  serviceTypeHealthPolicyMap?: Record<ServiceTypeHealthPolicy>;
}

/**
 * User assigned identity for the application.
 */
model ApplicationUserAssignedIdentity {
  /**
   * The friendly name of user assigned identity.
   */
  name: string;

  /**
   * The principal id of user assigned identity.
   */
  principalId: string;
}

/**
 * Properties for application update request.
 */
@added(Versions.v2025_10_01_preview)
model ApplicationUpdateParametersProperties {
  /**
   * List of application parameters with overridden values from their default values specified in the application manifest.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Patch operation expects same format as create or update, used to pass string to string dictionary"
  parameters?: Record<string>;
}

/**
 * Application update request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Not adding identity property as this API is for updating tags only"
model ApplicationUpdateParameters {
  /**
   * Application update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;

  /**
   * Application update parameters properties.
   */
  @added(Versions.v2025_10_01_preview)
  properties?: ApplicationUpdateParametersProperties;
}

/**
 * The policy used for monitoring the application upgrade
 */
model RollingUpgradeMonitoringPolicy {
  /**
   * The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations. Invalid indicates the failure action is invalid. Rollback specifies that the upgrade will start rolling back automatically. Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode.
   */
  failureAction: FailureAction;

  /**
   * The amount of time to wait after completing an upgrade domain before applying health policies. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  healthCheckWaitDuration: duration;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  healthCheckStableDuration: duration;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  healthCheckRetryTimeout: duration;

  /**
   * The amount of time the overall upgrade has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  upgradeTimeout: duration;

  /**
   * The amount of time each upgrade domain has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  upgradeDomainTimeout: duration;
}

/**
 * The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations. Invalid indicates the failure action is invalid. Rollback specifies that the upgrade will start rolling back automatically. Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode.
 */
union FailureAction {
  string,

  /**
   * Indicates that a rollback of the upgrade will be performed by Service Fabric if the upgrade fails.
   */
  Rollback: "Rollback",

  /**
   * Indicates that a manual repair will need to be performed by the administrator if the upgrade fails. Service Fabric will not proceed to the next upgrade domain automatically.
   */
  Manual: "Manual",
}

/**
 * The mode used to monitor health during a rolling upgrade. The values are Monitored, and UnmonitoredAuto.
 */
union RollingUpgradeMode {
  string,

  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding.
   */
  Monitored: "Monitored",

  /**
   * The upgrade will proceed automatically without performing any health monitoring.
   */
  UnmonitoredAuto: "UnmonitoredAuto",
}

/**
 * Describes the parameters for updating a rolling upgrade of application or cluster.
 */
model RuntimeRollingUpgradeUpdateMonitoringPolicy {
  /**
   * The mode used to monitor health during a rolling upgrade.
   */
  rollingUpgradeMode: RuntimeRollingUpgradeMode;

  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean;

  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer).
   */
  replicaSetCheckTimeoutInMilliseconds?: int64;

  /**
   * The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations. Invalid indicates the failure action is invalid. Rollback specifies that the upgrade will start rolling back automatically. Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode
   */
  failureAction?: RuntimeFailureAction;

  /**
   * The amount of time to wait after completing an upgrade domain before applying health policies. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckWaitDurationInMilliseconds?: string;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckStableDurationInMilliseconds?: string;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckRetryTimeoutInMilliseconds?: string;

  /**
   * The amount of time the overall upgrade has to complete before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  upgradeTimeoutInMilliseconds?: string;

  /**
   * The amount of time each upgrade domain has to complete before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  upgradeDomainTimeoutInMilliseconds?: string;

  /**
   * Duration in seconds, to wait before a stateless instance is closed, to allow the active requests to drain gracefully. This would be effective when the instance is closing during the application/cluster upgrade, only for those instances which have a non-zero delay duration configured in the service description.
   */
  instanceCloseDelayDurationInSeconds?: int64;
}

/**
 * Parameters for Resume Upgrade action. The upgrade domain name must be specified.
 */
model RuntimeResumeApplicationUpgradeParameters {
  /**
   * The upgrade domain name. Expected to be the next upgrade domain if the application is upgrading.
   */
  upgradeDomainName?: string;
}

/**
 * Cluster level definition for the kind of upgrade.
 */
union RuntimeUpgradeKind {
  string,

  /**
   * The upgrade progresses one upgrade domain at a time.
   */
  Rolling: "Rolling",
}

/**
 * Cluster level definition that represents the health policy used to evaluate the health of services belonging to a service type.
 */
model RuntimeServiceTypeHealthPolicy {
  /**
   * The maximum allowed percentage of unhealthy services.
   *
   * The percentage represents the maximum tolerated percentage of services that can be unhealthy before the application is considered in error.
   * If the percentage is respected but there is at least one unhealthy service, the health is evaluated as Warning.
   * This is calculated by dividing the number of unhealthy services of the specific service type over the total number of services of the specific service type.
   * The computation rounds up to tolerate one failure on small numbers of services.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyServices: int32;

  /**
   * The maximum allowed percentage of unhealthy partitions per service.
   *
   * The percentage represents the maximum tolerated percentage of partitions that can be unhealthy before the service is considered in error.
   * If the percentage is respected but there is at least one unhealthy partition, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy partitions over the total number of partitions in the service.
   * The computation rounds up to tolerate one failure on small numbers of partitions.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService: int32;

  /**
   * The maximum allowed percentage of unhealthy replicas per partition.
   *
   * The percentage represents the maximum tolerated percentage of replicas that can be unhealthy before the partition is considered in error.
   * If the percentage is respected but there is at least one unhealthy replica, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy replicas over the total number of replicas in the partition.
   * The computation rounds up to tolerate one failure on small numbers of replicas.
   *
   */
  @maxValue(100)
  @minValue(0)
  maxPercentUnhealthyReplicasPerPartition: int32;
}

/**
 * Cluster level definition for a health policy used to evaluate the health of an application or one of its children entities.
 *
 */
model RuntimeApplicationHealthPolicy {
  /**
   * Indicates whether warnings are treated with the same severity as errors.
   */
  considerWarningAsError: boolean;

  /**
   * The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
   * The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
   * This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
   * The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
   *
   */
  maxPercentUnhealthyDeployedApplications: int32;

  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: RuntimeServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string as service name to ServiceTypeHealthPolicy dictionary"
  serviceTypeHealthPolicyMap?: Record<RuntimeServiceTypeHealthPolicy>;
}

/**
 * Cluster level definition for the compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations.
 */
union RuntimeFailureAction {
  string,

  /**
   * Indicates that a rollback of the upgrade will be performed by Service Fabric if the upgrade fails.
   */
  Rollback: "Rollback",

  /**
   * Indicates that a manual repair will need to be performed by the administrator if the upgrade fails. Service Fabric will not proceed to the next upgrade domain automatically.
   */
  Manual: "Manual",
}

/**
 * Cluster level definition for the mode used to monitor health during a rolling upgrade.
 */
union RuntimeRollingUpgradeMode {
  string,

  /**
   * The upgrade will proceed automatically without performing any health monitoring.
   */
  UnmonitoredAuto: "UnmonitoredAuto",

  /**
   * The upgrade will stop after completing each upgrade domain, giving the opportunity to manually monitor health before proceeding.
   */
  UnmonitoredManual: "UnmonitoredManual",

  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding.
   */
  Monitored: "Monitored",
}

/**
 * Parameters for the Update Upgrade action.
 */
model RuntimeUpdateApplicationUpgradeParameters {
  /**
   * The name of the application, including the 'fabric:' URI scheme.
   */
  name: string;

  /**
   * The kind of the upgrade.
   */
  upgradeKind: RuntimeUpgradeKind;

  /**
   * Defines a health policy used to evaluate the health of an application or one of its children entities.
   */
  applicationHealthPolicy?: RuntimeApplicationHealthPolicy;

  /**
   * Describes the parameters for updating a rolling upgrade of application or cluster and a monitoring policy.
   */
  updateDescription?: RuntimeRollingUpgradeUpdateMonitoringPolicy;
}

/**
 * Enum for filtering health events.
 */
@added(Versions.v2025_10_01_preview)
union HealthFilter {
  string,

  /**
   * Default value. Matches any health state.
   */
  Default: "Default",

  /**
   * Filter that doesn't match any health state. Used to return no results on a given collection of health entities.
   */
  None: "None",

  /**
   * Filter for health state Ok.
   */
  Ok: "Ok",

  /**
   * Filter for health state Warning.
   */
  Warning: "Warning",

  /**
   * Filter for health state Error.
   */
  Error: "Error",

  /**
   * Filter that matches input with any health state.
   */
  All: "All",
}

/**
 * Parameters for fetching the health of an application.
 */
@added(Versions.v2025_10_01_preview)
model ApplicationFetchHealthRequest {
  /**
   * Allows filtering of the health events returned in the response based on health state.
   */
  eventsHealthStateFilter?: HealthFilter;

  /**
   * Allows filtering of the deployed applications health state objects returned in the result of application health query based on their health state.
   */
  deployedApplicationsHealthStateFilter?: HealthFilter;

  /**
   * Allows filtering of the services health state objects returned in the result of services health query based on their health state.
   */
  servicesHealthStateFilter?: HealthFilter;

  /**
   * Indicates whether the health statistics should be returned as part of the query result. False by default. The statistics show the number of children entities in health state Ok, Warning, and Error.
   */
  excludeHealthStatistics?: boolean = false;

  /**
   * Request timeout for the health query in seconds. The default value is 60 seconds.
   */
  timeout?: int64 = 60;
}

/**
 * Parameters for restarting a deployed code package.
 */
@added(Versions.v2025_10_01_preview)
model RestartDeployedCodePackageRequest {
  /**
   * The name of the node where the code package needs to be restarted. Use '*' to restart on all nodes where the code package is running.
   */
  nodeName: string;

  /**
   * The name of the service manifest as specified in the code package.
   */
  serviceManifestName: string;

  /**
   * The name of the code package as specified in the service manifest.
   */
  codePackageName: string;

  /**
   * The instance ID for currently running entry point. For a code package setup entry point (if specified) runs first and after it finishes main entry point is started. Each time entry point executable is run, its instance ID will change. If 0 is passed in as the code package instance ID, the API will restart the code package with whatever instance ID it is currently running. If an instance ID other than 0 is passed in, the API will restart the code package only if the current Instance ID matches the passed in instance ID. Note, passing in the exact instance ID (not 0) in the API is safer, because if ensures at most one restart of the code package.
   */
  codePackageInstanceId: string;

  /**
   * The activation id of a deployed service package. If ServicePackageActivationMode specified at the time of creating the service is 'SharedProcess' (or if it is not specified, in which case it defaults to 'SharedProcess'), then value of ServicePackageActivationId is always an empty string.
   */
  servicePackageActivationId?: string;
}
