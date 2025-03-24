import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceFabric;
/**
 * The service resource.
 */
@parentResource(ApplicationResource)
model ServiceResource
  is Azure.ResourceManager.ProxyResource<ServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Services {
  /**
   * Get a Service Fabric service resource created or in the process of being created in the Service Fabric managed application resource.
   */
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create or update a Service Fabric managed service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ServiceResource,
    Response = ArmResourceUpdatedResponse<ServiceResource> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ServiceResource>> & {
      @bodyRoot
      _: ServiceResource;
    })
  >;

  /**
   * Updates the tags of a service resource of a given managed cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ServiceResource,
    PatchModel = ServiceUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed service resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceResource,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Gets all service resources created or in the process of being created in the Service Fabric managed application resource.
   */
  listByApplications is ArmResourceListByParent<
    ServiceResource,
    Response = ArmResponse<ServiceResourceList>
  >;
}

@@doc(ServiceResource.name,
  "The name of the service resource in the format of {applicationName}~{serviceName}."
);
@@doc(ServiceResource.properties, "The service resource properties.");
@@doc(Services.createOrUpdate::parameters.resource, "The service resource.");
@@doc(Services.update::parameters.properties,
  "The service resource updated tags."
);

/**
 * The service resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Day 0 property, keeping definition as is for backwards compatibility"
@discriminator("serviceKind")
model ServiceResourceProperties extends ServiceResourcePropertiesBase {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Day 0 property, keep as string for backwards compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: ServiceKind;

  /**
   * The name of the service type
   */
  serviceTypeName: string;

  /**
   * Describes how the service is partitioned.
   */
  partitionDescription: Partition;

  /**
   * The activation Mode of the service package
   */
  servicePackageActivationMode?: ServicePackageActivationMode;

  /**
   * Dns name used for the service. If this is specified, then the DNS name can be used to return the IP addresses of service endpoints for application layer protocols (e.g., HTTP).
   * When updating serviceDnsName, old name may be temporarily resolvable. However, rely on new name.
   * When removing serviceDnsName, removed name may temporarily be resolvable. Do not rely on the name being unresolvable.
   *
   */
  serviceDnsName?: string;
}

/**
 * The common service resource properties.
 */
model ServiceResourcePropertiesBase {
  /**
   * The placement constraints as a string. Placement constraints are boolean expressions on node properties and allow for restricting a service to particular nodes based on the service requirements. For example, to place a service on nodes where NodeType is blue specify the following: "NodeColor == blue)".
   */
  placementConstraints?: string;

  /**
   * A list that describes the correlation of the service with other services.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  correlationScheme?: ServiceCorrelation[];

  /**
   * The service load metrics is given as an array of ServiceLoadMetric objects.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  serviceLoadMetrics?: ServiceLoadMetric[];

  /**
   * A list that describes the correlation of the service with other services.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  servicePlacementPolicies?: ServicePlacementPolicy[];

  /**
   * Specifies the move cost for the service.
   */
  defaultMoveCost?: MoveCost;

  /**
   * Scaling policies for this service.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  scalingPolicies?: ScalingPolicy[];
}

/**
 * The list of service resources.
 */
model ServiceResourceList is Azure.Core.Page<ServiceResource>;
/**
 * The properties of a stateful service resource.
 */
model StatefulServiceProperties extends ServiceResourceProperties {
  /**
   * A flag indicating whether this is a persistent service which stores states on the local disk. If it is then the value of this property is true, if not it is false.
   */
  hasPersistedState?: boolean;

  /**
   * The target replica set size as a number.
   */
  @minValue(1)
  targetReplicaSetSize?: int32;

  /**
   * The minimum replica set size as a number.
   */
  @minValue(1)
  minReplicaSetSize?: int32;

  /**
   * The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format "hh:mm:ss".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  replicaRestartWaitDuration?: string;

  /**
   * The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format "hh:mm:ss".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  quorumLossWaitDuration?: string;

  /**
   * The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format "hh:mm:ss".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  standByReplicaKeepDuration?: string;

  /**
   * The duration for which replicas can stay InBuild before reporting that build is stuck, represented in ISO 8601 format "hh:mm:ss".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  servicePlacementTimeLimit?: string;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateful";
}

/**
 * The properties of a stateless service resource.
 */
model StatelessServiceProperties extends ServiceResourceProperties {
  /**
   * The instance count.
   */
  @minValue(-1)
  instanceCount: int32;

  /**
   * MinInstanceCount is the minimum number of instances that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstanceCount computation -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstanceCount?: int32;

  /**
   * MinInstancePercentage is the minimum percentage of InstanceCount that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstancePercentage computation, -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstancePercentage?: int32;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateless";
}

/**
 * Describes how the service is partitioned.
 */
@discriminator("partitionScheme")
model Partition {
  partitionScheme: PartitionScheme;
}

/**
 * Describes a partitioning scheme where an integer range is allocated evenly across a number of partitions.
 */
model UniformInt64RangePartitionScheme extends Partition {
  /**
   * The number of partitions.
   */
  count: int32;

  /**
   * The lower bound of the partition key range that
   * should be split between the partition ‘Count’
   *
   */
  lowKey: int64;

  /**
   * The upper bound of the partition key range that
   * should be split between the partition ‘Count’
   *
   */
  highKey: int64;

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "UniformInt64Range";
}

/**
 * Describes the partition scheme of a singleton-partitioned, or non-partitioned service.
 */
model SingletonPartitionScheme extends Partition {
  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "Singleton";
}

/**
 * Describes the named partition scheme of the service.
 */
model NamedPartitionScheme extends Partition {
  /**
   * Array for the names of the partitions.
   */
  names: string[];

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "Named";
}

/**
 * Creates a particular correlation between services.
 */
model ServiceCorrelation {
  /**
   * The ServiceCorrelationScheme which describes the relationship between this service and the service specified via ServiceName.
   */
  scheme: ServiceCorrelationScheme;

  /**
   * The Arm Resource ID of the service that the correlation relationship is established with.
   */
  serviceName: string;
}

/**
 * Specifies a metric to load balance a service during runtime.
 */
model ServiceLoadMetric {
  /**
   * The name of the metric. If the service chooses to report load during runtime, the load metric name should match the name that is specified in Name exactly. Note that metric names are case sensitive.
   */
  name: string;

  /**
   * The service load metric relative weight, compared to other metrics configured for this service, as a number.
   */
  weight?: ServiceLoadMetricWeight;

  /**
   * Used only for Stateful services. The default amount of load, as a number, that this service creates for this metric when it is a Primary replica.
   */
  primaryDefaultLoad?: int32;

  /**
   * Used only for Stateful services. The default amount of load, as a number, that this service creates for this metric when it is a Secondary replica.
   */
  secondaryDefaultLoad?: int32;

  /**
   * Used only for Stateless services. The default amount of load, as a number, that this service creates for this metric.
   */
  defaultLoad?: int32;
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
 * The type of placement policy for a service fabric service. Following are the possible values.
 */
union ServicePlacementPolicyType {
  string,

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementInvalidDomainPolicyDescription, which indicates that a particular fault or upgrade domain cannot be used for placement of this service. The value is 0.
   */
  InvalidDomain: "InvalidDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription indicating that the replicas of the service must be placed in a specific domain. The value is 1.
   */
  RequiredDomain: "RequiredDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementPreferPrimaryDomainPolicyDescription, which indicates that if possible the Primary replica for the partitions of the service should be located in a particular domain as an optimization. The value is 2.
   */
  PreferredPrimaryDomain: "PreferredPrimaryDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription, indicating that the system will disallow placement of any two replicas from the same partition in the same domain at any time. The value is 3.
   */
  RequiredDomainDistribution: "RequiredDomainDistribution",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementNonPartiallyPlaceServicePolicyDescription, which indicates that if possible all replicas of a particular partition of the service should be placed atomically. The value is 4.
   */
  NonPartiallyPlaceService: "NonPartiallyPlaceService",
}

/**
 * Describes the policy to be used for placement of a Service Fabric service.
 */
@discriminator("type")
model ServicePlacementPolicy {
  type: ServicePlacementPolicyType;
}

/**
 * Describes the policy to be used for placement of a Service Fabric service where a particular fault or upgrade domain should not be used for placement of the instances or replicas of that service.
 */
model ServicePlacementInvalidDomainPolicy extends ServicePlacementPolicy {
  /**
   * The name of the domain that should not be used for placement.
   */
  domainName: string;

  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "InvalidDomain";
}

/**
 * Describes the policy to be used for placement of a Service Fabric service where the instances or replicas of that service must be placed in a particular domain.
 */
model ServicePlacementRequiredDomainPolicy extends ServicePlacementPolicy {
  /**
   * The name of the domain that should used for placement as per this policy.
   */
  domainName: string;

  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "RequiredDomain";
}

/**
 * Describes the policy to be used for placement of a Service Fabric service where the service's
 * Primary replicas should optimally be placed in a particular domain.
 *
 * This placement policy is usually used with fault domains in scenarios where the Service Fabric
 * cluster is geographically distributed in order to indicate that a service's primary replica should
 * be located in a particular fault domain, which in geo-distributed scenarios usually aligns with regional
 * or datacenter boundaries. Note that since this is an optimization it is possible that the Primary replica
 * may not end up located in this domain due to failures, capacity limits, or other constraints.
 *
 */
model ServicePlacementPreferPrimaryDomainPolicy extends ServicePlacementPolicy {
  /**
   * The name of the domain that should used for placement as per this policy.
   */
  domainName: string;

  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "PreferredPrimaryDomain";
}

/**
 * Describes the policy to be used for placement of a Service Fabric service where two replicas
 * from the same partition should never be placed in the same fault or upgrade domain.
 *
 * While this is not common it can expose the service to an increased risk of concurrent failures
 * due to unplanned outages or other cases of subsequent/concurrent failures. As an example, consider
 * a case where replicas are deployed across different data center, with one replica per location.
 * In the event that one of the datacenters goes offline, normally the replica that was placed in that
 * datacenter will be packed into one of the remaining datacenters. If this is not desirable then this
 * policy should be set.
 *
 */
model ServicePlacementRequireDomainDistributionPolicy
  extends ServicePlacementPolicy {
  /**
   * The name of the domain that should used for placement as per this policy.
   */
  domainName: string;

  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "RequiredDomainDistribution";
}

/**
 * The type of placement policy for a service fabric service. Following are the possible values.
 */
model ServicePlacementNonPartiallyPlaceServicePolicy
  extends ServicePlacementPolicy {
  type: "NonPartiallyPlaceService";
}

/**
 * Specifies a metric to load balance a service during runtime.
 */
model ScalingPolicy {
  /**
   * Specifies the mechanism associated with this scaling policy
   */
  scalingMechanism: ScalingMechanism;

  /**
   * Specifies the trigger associated with this scaling policy.
   */
  scalingTrigger: ScalingTrigger;
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union ServiceScalingMechanismKind {
  string,

  /**
   * Represents a scaling mechanism for adding or removing instances of stateless service partition. The value is 0.
   */
  ScalePartitionInstanceCount: "ScalePartitionInstanceCount",

  /**
   * Represents a scaling mechanism for adding or removing named partitions of a stateless service. The value is 1.
   */
  AddRemoveIncrementalNamedPartition: "AddRemoveIncrementalNamedPartition",
}

/**
 * Describes the mechanism for performing a scaling operation.
 */
@discriminator("kind")
model ScalingMechanism {
  kind: ServiceScalingMechanismKind;
}

/**
 * Represents a scaling mechanism for adding or removing named partitions of a stateless service. Partition names are in the format '0','1'...'N-1'.
 */
model AddRemoveIncrementalNamedPartitionScalingMechanism
  extends ScalingMechanism {
  /**
   * Minimum number of named partitions of the service.
   */
  minPartitionCount: int32;

  /**
   * Maximum number of named partitions of the service.
   */
  maxPartitionCount: int32;

  /**
   * The number of instances to add or remove during a scaling operation.
   */
  scaleIncrement: int32;

  /**
   * Specifies the mechanism associated with this scaling policy.
   */
  kind: "AddRemoveIncrementalNamedPartition";
}

/**
 * Represents a scaling mechanism for adding or removing instances of stateless service partition.
 */
model PartitionInstanceCountScaleMechanism extends ScalingMechanism {
  /**
   * Minimum number of instances of the partition.
   */
  minInstanceCount: int32;

  /**
   * Maximum number of instances of the partition.
   */
  maxInstanceCount: int32;

  /**
   * The number of instances to add or remove during a scaling operation.
   */
  scaleIncrement: int32;

  /**
   * Specifies the mechanism associated with this scaling policy.
   */
  kind: "ScalePartitionInstanceCount";
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union ServiceScalingTriggerKind {
  string,

  /**
   * Represents a scaling trigger related to an average load of a metric/resource of a partition. The value is 0.
   */
  AveragePartitionLoadTrigger: "AveragePartitionLoadTrigger",

  /**
   * Represents a scaling policy related to an average load of a metric/resource of a service. The value is 1.
   */
  AverageServiceLoadTrigger: "AverageServiceLoadTrigger",
}

/**
 * Describes the trigger for performing a scaling operation.
 */
@discriminator("kind")
model ScalingTrigger {
  kind: ServiceScalingTriggerKind;
}

/**
 * Represents a scaling trigger related to an average load of a metric/resource of a partition.
 */
model AveragePartitionLoadScalingTrigger extends ScalingTrigger {
  /**
   * The name of the metric for which usage should be tracked.
   */
  metricName: string;

  /**
   * The lower limit of the load below which a scale in operation should be performed.
   */
  lowerLoadThreshold: float64;

  /**
   * The upper limit of the load beyond which a scale out operation should be performed.
   */
  upperLoadThreshold: float64;

  /**
   * The period in seconds on which a decision is made whether to scale or not. This property should come in ISO 8601 format "hh:mm:ss".
   */
  scaleInterval: string;

  /**
   * Specifies the trigger associated with this scaling policy.
   */
  kind: "AveragePartitionLoadTrigger";
}

/**
 * Represents a scaling policy related to an average load of a metric/resource of a service.
 */
model AverageServiceLoadScalingTrigger extends ScalingTrigger {
  /**
   * The name of the metric for which usage should be tracked.
   */
  metricName: string;

  /**
   * The lower limit of the load below which a scale in operation should be performed.
   */
  lowerLoadThreshold: float64;

  /**
   * The upper limit of the load beyond which a scale out operation should be performed.
   */
  upperLoadThreshold: float64;

  /**
   * The period in seconds on which a decision is made whether to scale or not. This property should come in ISO 8601 format "hh:mm:ss".
   */
  scaleInterval: string;

  /**
   * Flag determines whether only the load of primary replica should be considered for scaling. If set to true, then trigger will only consider the load of primary replicas of stateful service. If set to false, trigger will consider load of all replicas. This parameter cannot be set to true for stateless service.
   */
  useOnlyPrimaryLoad: boolean;

  /**
   * Specifies the trigger associated with this scaling policy.
   */
  kind: "AverageServiceLoadTrigger";
}

/**
 * Service update request
 */
model ServiceUpdateParameters {
  /**
   * Service update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}

/**
 * The kind of service (Stateless or Stateful).
 */
union ServiceKind {
  string,

  /**
   * Does not use Service Fabric to make its state highly available or reliable. The value is 0.
   */
  Stateless: "Stateless",

  /**
   * Uses Service Fabric to make its state or part of its state highly available and reliable. The value is 1.
   */
  Stateful: "Stateful",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union PartitionScheme {
  string,

  /**
   * Indicates that the partition is based on string names, and is a SingletonPartitionScheme object, The value is 0.
   */
  Singleton: "Singleton",

  /**
   * Indicates that the partition is based on Int64 key ranges, and is a UniformInt64RangePartitionScheme object. The value is 1.
   */
  UniformInt64Range: "UniformInt64Range",

  /**
   * Indicates that the partition is based on string names, and is a NamedPartitionScheme object. The value is 2.
   */
  Named: "Named",
}

/**
 * The activation Mode of the service package
 */
union ServicePackageActivationMode {
  string,

  /**
   * Indicates the application package activation mode will use shared process.
   */
  SharedProcess: "SharedProcess",

  /**
   * Indicates the application package activation mode will use exclusive process.
   */
  ExclusiveProcess: "ExclusiveProcess",
}

/**
 * The service correlation scheme.
 */
union ServiceCorrelationScheme {
  string,

  /**
   * Aligned affinity ensures that the primaries of the partitions of the affinitized services are collocated on the same nodes. This is the default and is the same as selecting the Affinity scheme. The value is 0.
   */
  AlignedAffinity: "AlignedAffinity",

  /**
   * Non-Aligned affinity guarantees that all replicas of each service will be placed on the same nodes. Unlike Aligned Affinity, this does not guarantee that replicas of particular role will be collocated. The value is 1.
   */
  NonAlignedAffinity: "NonAlignedAffinity",
}

/**
 * Determines the metric weight relative to the other metrics that are configured for this service. During runtime, if two metrics end up in conflict, the Cluster Resource Manager prefers the metric with the higher weight.
 */
union ServiceLoadMetricWeight {
  string,

  /**
   * Disables resource balancing for this metric. This value is zero.
   */
  Zero: "Zero",

  /**
   * Specifies the metric weight of the service load as Low. The value is 1.
   */
  Low: "Low",

  /**
   * Specifies the metric weight of the service load as Medium. The value is 2.
   */
  Medium: "Medium",

  /**
   * Specifies the metric weight of the service load as High. The value is 3.
   */
  High: "High",
}

/**
 * Specifies the move cost for the service.
 */
union MoveCost {
  string,

  /**
   * Zero move cost. This value is zero.
   */
  Zero: "Zero",

  /**
   * Specifies the move cost of the service as Low. The value is 1.
   */
  Low: "Low",

  /**
   * Specifies the move cost of the service as Medium. The value is 2.
   */
  Medium: "Medium",

  /**
   * Specifies the move cost of the service as High. The value is 3.
   */
  High: "High",
}
