import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The application resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "servicefabric is brownfield service with legacy patterns for resources"
@parentResource(Cluster)
model ApplicationResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ApplicationResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationResource,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...ManagedServiceIdentityProperty;
}

@armResourceOperations
interface ApplicationResources {
  /**
   * Get a Service Fabric application resource created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_Get")
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create or update a Service Fabric application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "servicefabric is brownfield service with existing non-standard 202 response body"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "servicefabric is brownfield service with existing non-standard response codes"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationResource,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ApplicationResource>> & {
      @bodyRoot
      _: ApplicationResource;
    }
  >;

  /**
   * Update a Service Fabric application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "servicefabric is brownfield service with existing non-standard 202 response body"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ApplicationResource,
    PatchModel = ApplicationResourceUpdate,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: ApplicationResource;
    }
  >;

  /**
   * Delete a Service Fabric application resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationResource>;

  /**
   * Gets all application resources created or in the process of being created in the Service Fabric cluster resource.
   */
  list is ArmResourceListByParent<
    ApplicationResource,
    Response = ArmResponse<ApplicationResourceList>
  >;
}

@@doc(ApplicationResource.name, "The name of the application resource.");
@@doc(ApplicationResource.properties, "The application resource properties.");
@@doc(ApplicationResources.createOrUpdate::parameters.resource,
  "The application resource."
);
@@doc(ApplicationResources.update::parameters.properties,
  "The application resource for patch operations."
);

/**
 * The application resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApplicationResourceProperties
  extends ApplicationResourceUpdateProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "servicefabric is a brownfield service with existing provisioning state property as string and not enum"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The application type name as defined in the application manifest.
   */
  typeName?: string;
}

/**
 * The application resource properties for patch operations.
 */
model ApplicationResourceUpdateProperties {
  /**
   * The version of the application type as defined in the application manifest.
   */
  typeVersion?: string;

  /**
   * List of application parameters with overridden values from their default values specified in the application manifest.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  parameters?: Record<string>;

  /**
   * Describes the policy for a monitored application upgrade.
   */
  upgradePolicy?: ApplicationUpgradePolicy;

  /**
   * The minimum number of nodes where Service Fabric will reserve capacity for this application. Note that this does not mean that the services of this application will be placed on all of those nodes. If this property is set to zero, no capacity will be reserved. The value of this property cannot be more than the value of the MaximumNodes property.
   */
  @minValue(0)
  minimumNodes?: int64;

  /**
   * The maximum number of nodes where Service Fabric will reserve capacity for this application. Note that this does not mean that the services of this application will be placed on all of those nodes. By default, the value of this property is zero and it means that the services can be placed on any node.
   */
  @minValue(0)
  maximumNodes?: int64 = 0;

  /**
   * Remove the current application capacity settings.
   */
  removeApplicationCapacity?: boolean;

  /**
   * List of application capacity metric description.
   */
  metrics?: ApplicationMetricDescription[];

  /**
   * List of user assigned identities for the application, each mapped to a friendly name.
   */
  managedIdentities?: ApplicationUserAssignedIdentity[];
}

/**
 * Describes the policy for a monitored application upgrade.
 */
model ApplicationUpgradePolicy {
  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer).
   */
  upgradeReplicaSetCheckTimeout?: string;

  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean = false;

  /**
   * The policy used for monitoring the application upgrade
   */
  rollingUpgradeMonitoringPolicy?: ArmRollingUpgradeMonitoringPolicy;

  /**
   * Defines a health policy used to evaluate the health of an application or one of its children entities.
   *
   */
  applicationHealthPolicy?: ArmApplicationHealthPolicy;

  /**
   * The mode used to monitor health during a rolling upgrade. The values are UnmonitoredAuto, UnmonitoredManual, and Monitored.
   */
  upgradeMode?: RollingUpgradeMode = RollingUpgradeMode.Monitored;

  /**
   * Determines whether the application should be recreated on update. If value=true, the rest of the upgrade policy parameters are not allowed and it will result in availability loss.
   */
  recreateApplication?: boolean;
}
/**
 * The policy used for monitoring the application upgrade
 */
model ArmRollingUpgradeMonitoringPolicy {
  /**
   * The activation Mode of the service package
   */
  failureAction?: ArmUpgradeFailureAction;

  /**
   * The amount of time to wait after completing an upgrade domain before applying health policies. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckWaitDuration?: string = "0";

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckStableDuration?: string = "PT0H2M0S";

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckRetryTimeout?: string = "PT0H10M0S";

  /**
   * The amount of time the overall upgrade has to complete before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  upgradeTimeout?: string = "P10675199DT02H48M05.4775807S";

  /**
   * The amount of time each upgrade domain has to complete before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  upgradeDomainTimeout?: string = "P10675199DT02H48M05.4775807S";
}

/**
 * Defines a health policy used to evaluate the health of an application or one of its children entities.
 *
 */
model ArmApplicationHealthPolicy {
  /**
   * Indicates whether warnings are treated with the same severity as errors.
   */
  considerWarningAsError?: boolean = false;

  /**
   * The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
   * The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
   * This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
   * The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
   *
   */
  maxPercentUnhealthyDeployedApplications?: int32 = 0;

  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: ArmServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  serviceTypeHealthPolicyMap?: Record<ArmServiceTypeHealthPolicy>;
}

/**
 * Represents the health policy used to evaluate the health of services belonging to a service type.
 *
 */
model ArmServiceTypeHealthPolicy {
  /**
   * The maximum percentage of services allowed to be unhealthy before your application is considered in error.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyServices?: int32 = 0;

  /**
   * The maximum percentage of partitions per service allowed to be unhealthy before your application is considered in error.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService?: int32 = 0;

  /**
   * The maximum percentage of replicas per partition allowed to be unhealthy before your application is considered in error.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyReplicasPerPartition?: int32 = 0;
}

/**
 * Describes capacity information for a custom resource balancing metric. This can be used to limit the total consumption of this metric by the services of this application.
 *
 */
model ApplicationMetricDescription {
  /**
   * The name of the metric.
   */
  name?: string;

  /**
   * The maximum node capacity for Service Fabric application.
   * This is the maximum Load for an instance of this application on a single node. Even if the capacity of node is greater than this value, Service Fabric will limit the total load of services within the application on each node to this value.
   * If set to zero, capacity for this metric is unlimited on each node.
   * When creating a new application with application capacity defined, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.
   * When updating existing application with application capacity, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.
   *
   */
  maximumCapacity?: int64;

  /**
   * The node reservation capacity for Service Fabric application.
   * This is the amount of load which is reserved on nodes which have instances of this application.
   * If MinimumNodes is specified, then the product of these values will be the capacity reserved in the cluster for the application.
   * If set to zero, no capacity is reserved for this metric.
   * When setting application capacity or when updating application capacity; this value must be smaller than or equal to MaximumCapacity for each metric.
   *
   */
  reservationCapacity?: int64;

  /**
   * The total metric capacity for Service Fabric application.
   * This is the total metric capacity for this application in the cluster. Service Fabric will try to limit the sum of loads of services within the application to this value.
   * When creating a new application with application capacity defined, the product of MaximumNodes and MaximumCapacity must always be smaller than or equal to this value.
   *
   */
  totalApplicationCapacity?: int64;
}

/**
 * Describes a user assigned identity for the application.
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
 * The application resource for patch operations.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "servicefabric is brownfield service with legacy patterns for resources"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "servicefabric is a brownfield service with existing APIs that do not support all properties in patch"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApplicationResourceUpdate
  extends ProxyResource<ApplicationResourceUpdateProperties> {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The application resource properties for patch operations.
   */
  properties?: ApplicationResourceUpdateProperties;
}

/**
 * The list of application resources.
 */
model ApplicationResourceList is Azure.Core.Page<ApplicationResource>;
/**
 * The mode used to monitor health during a rolling upgrade. The values are UnmonitoredAuto, UnmonitoredManual, and Monitored.
 */
union RollingUpgradeMode {
  string,

  /**
   * Indicates the upgrade mode is invalid. All Service Fabric enumerations have the invalid type. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * The upgrade will proceed automatically without performing any health monitoring. The value is 1
   */
  UnmonitoredAuto: "UnmonitoredAuto",

  /**
   * The upgrade will stop after completing each upgrade domain, giving the opportunity to manually monitor health before proceeding. The value is 2
   */
  UnmonitoredManual: "UnmonitoredManual",

  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 3
   */
  Monitored: "Monitored",
}

/**
 * The activation Mode of the service package
 */
union ArmUpgradeFailureAction {
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
