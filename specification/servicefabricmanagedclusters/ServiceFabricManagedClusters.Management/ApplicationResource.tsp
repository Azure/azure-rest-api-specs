import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
   * Updates the tags of an application resource of a given managed cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ApplicationResource,
    PatchModel = ApplicationUpdateParameters
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

/**
 * The application resource properties.
 */
model ApplicationResourceProperties {
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

  /**
   * List of user assigned identities for the application, each mapped to a friendly name.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  managedIdentities?: ApplicationUserAssignedIdentity[];
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
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer).
   */
  upgradeReplicaSetCheckTimeout?: int64;

  /**
   * Determines whether the application should be recreated on update. If value=true, the rest of the upgrade policy parameters are not allowed.
   */
  recreateApplication?: boolean;
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
 * Application update request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Not adding identity property as this API is for updating tags only"
model ApplicationUpdateParameters {
  /**
   * Application update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  healthCheckWaitDuration: string;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  healthCheckStableDuration: string;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  healthCheckRetryTimeout: string;

  /**
   * The amount of time the overall upgrade has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  upgradeTimeout: string;

  /**
   * The amount of time each upgrade domain has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  upgradeDomainTimeout: string;
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
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 0.
   */
  Monitored: "Monitored",

  /**
   * The upgrade will proceed automatically without performing any health monitoring. The value is 1.
   */
  UnmonitoredAuto: "UnmonitoredAuto",
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
