import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The service resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "servicefabric is brownfield service with legacy patterns for resources"
@parentResource(ApplicationResource)
model ServiceResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface ServiceResources {
  /**
   * Get a Service Fabric service resource created or in the process of being created in the Service Fabric application resource.
   */
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create or update a Service Fabric service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "servicefabric is brownfield service with existing non-standard 202 response body"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "servicefabric is brownfield service with existing non-standard response codes"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceResource,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ServiceResource>> & {
      @bodyRoot
      _: ServiceResource;
    }
  >;

  /**
   * Update a Service Fabric service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "servicefabric is brownfield service with existing non-standard 202 response body"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ServiceResource,
    PatchModel = ServiceResourceUpdate,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: ServiceResource;
    }
  >;

  /**
   * Delete a Service Fabric service resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ServiceResource>;

  /**
   * Gets all service resources created or in the process of being created in the Service Fabric application resource.
   */
  list is ArmResourceListByParent<
    ServiceResource,
    Response = ArmResponse<ServiceResourceList>
  >;
}

@@doc(ServiceResource.name,
  "The name of the service resource in the format of {applicationName}~{serviceName}."
);
@@doc(ServiceResource.properties, "The service resource properties.");
@@doc(ServiceResources.createOrUpdate::parameters.resource,
  "The service resource."
);
@@doc(ServiceResources.update::parameters.properties,
  "The service resource for patch operations."
);

/**
 * The service resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@discriminator("serviceKind")
model ServiceResourceProperties extends ServiceResourcePropertiesBase {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "servicefabric is a brownfield service with existing provisioning state property as string and not enum"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: ServiceKind;

  /**
   * The name of the service type
   */
  serviceTypeName?: string;

  /**
   * Describes how the service is partitioned.
   */
  partitionDescription?: PartitionSchemeDescription;

  /**
   * The activation Mode of the service package
   */
  servicePackageActivationMode?: ArmServicePackageActivationMode;

  /**
   * Dns name used for the service. If this is specified, then the DNS name can be used to return the IP addresses of service endpoints for application layer protocols (e.g., HTTP).
   * When updating serviceDnsName, old name may be temporarily resolvable. However, rely on new name.
   * When removing serviceDnsName, removed name may temporarily be resolvable. Do not rely on the name being unresolvable.
   *
   */
  serviceDnsName?: string;
}

/**
 * Describes how the service is partitioned.
 */
@discriminator("partitionScheme")
model PartitionSchemeDescription {
  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: PartitionScheme;
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
  @identifiers(#[])
  correlationScheme?: ServiceCorrelationDescription[];

  /**
   * The service load metrics is given as an array of ServiceLoadMetricDescription objects.
   */
  serviceLoadMetrics?: ServiceLoadMetricDescription[];

  /**
   * A list that describes the correlation of the service with other services.
   */
  @identifiers(#[])
  servicePlacementPolicies?: ServicePlacementPolicyDescription[];

  /**
   * Specifies the move cost for the service.
   */
  defaultMoveCost?: MoveCost;
}

/**
 * Creates a particular correlation between services.
 */
model ServiceCorrelationDescription {
  /**
   * The ServiceCorrelationScheme which describes the relationship between this service and the service specified via ServiceName.
   */
  scheme: ServiceCorrelationScheme;

  /**
   * The name of the service that the correlation relationship is established with.
   */
  serviceName: string;
}

/**
 * Specifies a metric to load balance a service during runtime.
 */
model ServiceLoadMetricDescription {
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
 * Describes the policy to be used for placement of a Service Fabric service.
 */
@discriminator("type")
model ServicePlacementPolicyDescription {
  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: ServicePlacementPolicyType;
}

/**
 * The service resource for patch operations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "servicefabric is brownfield service with legacy patterns for resources"
model ServiceResourceUpdate
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ServiceResourceUpdateProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;
  ...EntityTagProperty;
}

/**
 * The service resource properties for patch operations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "servicefabric is a brownfield service with existing api patterns where provisioning state is not included in patch envelope"
@discriminator("serviceKind")
model ServiceResourceUpdateProperties extends ServiceResourcePropertiesBase {
  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: ServiceKind;
}

/**
 * The list of service resources.
 */
model ServiceResourceList is Azure.Core.Page<ServiceResource>;

/**
 * Describes the named partition scheme of the service.
 */
model NamedPartitionSchemeDescription extends PartitionSchemeDescription {
  /**
   * The number of partitions.
   */
  count: int32;

  /**
   * Array of size specified by the ‘count’ parameter, for the names of the partitions.
   */
  names: string[];

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "Named";
}

/**
 * Describes the partition scheme of a singleton-partitioned, or non-partitioned service.
 */
model SingletonPartitionSchemeDescription extends PartitionSchemeDescription {
  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "Singleton";
}

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
   * The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  replicaRestartWaitDuration?: utcDateTime;

  /**
   * The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  quorumLossWaitDuration?: utcDateTime;

  /**
   * The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  standByReplicaKeepDuration?: utcDateTime;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateful";
}

/**
 * The properties of a stateful service resource for patch operations.
 */
model StatefulServiceUpdateProperties extends ServiceResourceUpdateProperties {
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
   * The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  replicaRestartWaitDuration?: utcDateTime;

  /**
   * The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  quorumLossWaitDuration?: utcDateTime;

  /**
   * The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  standByReplicaKeepDuration?: utcDateTime;

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
  instanceCount?: int32;

  /**
   * Delay duration for RequestDrain feature to ensures that the endpoint advertised by the stateless instance is removed before the delay starts prior to closing the instance. This delay enables existing requests to drain gracefully before the instance actually goes down (https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-application-upgrade-advanced#avoid-connection-drops-during-stateless-service-planned-downtime-preview). It is represented in ISO 8601 format (hh:mm:ss.s).
   */
  instanceCloseDelayDuration?: string;

  /**
   * MinInstanceCount is the minimum number of instances that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstanceCount computation -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstanceCount?: int32;

  /**
   * MinInstancePercentage is the minimum percentage of InstanceCount that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstancePercentage computation, -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstancePercentage?: bytes;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateless";
}

/**
 * The properties of a stateless service resource for patch operations.
 */
model StatelessServiceUpdateProperties extends ServiceResourceUpdateProperties {
  /**
   * The instance count.
   */
  @minValue(-1)
  instanceCount?: int32;

  /**
   * Delay duration for RequestDrain feature to ensures that the endpoint advertised by the stateless instance is removed before the delay starts prior to closing the instance. This delay enables existing requests to drain gracefully before the instance actually goes down (https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-application-upgrade-advanced#avoid-connection-drops-during-stateless-service-planned-downtime-preview). It is represented in ISO 8601 format (hh:mm:ss.s).
   */
  instanceCloseDelayDuration?: string;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateless";
}

/**
 * Describes a partitioning scheme where an integer range is allocated evenly across a number of partitions.
 */
model UniformInt64RangePartitionSchemeDescription
  extends PartitionSchemeDescription {
  /**
   * The number of partitions.
   */
  count: int32;

  /**
   * String indicating the lower bound of the partition key range that
   * should be split between the partition ‘count’
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "key is not a secret, is public range for partitioning purposes"
  lowKey: string;

  /**
   * String indicating the upper bound of the partition key range that
   * should be split between the partition ‘count’
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "key is not a secret, is public range for partitioning purposes"
  highKey: string;

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "UniformInt64Range";
}
/**
 * The kind of service (Stateless or Stateful).
 */
union ServiceKind {
  string,

  /**
   * Indicates the service kind is invalid. All Service Fabric enumerations have the invalid type. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * Does not use Service Fabric to make its state highly available or reliable. The value is 1.
   */
  Stateless: "Stateless",

  /**
   * Uses Service Fabric to make its state or part of its state highly available and reliable. The value is 2.
   */
  Stateful: "Stateful",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union PartitionScheme {
  string,

  /**
   * Indicates the partition kind is invalid. All Service Fabric enumerations have the invalid type. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * Indicates that the partition is based on string names, and is a SingletonPartitionSchemeDescription object, The value is 1.
   */
  Singleton: "Singleton",

  /**
   * Indicates that the partition is based on Int64 key ranges, and is a UniformInt64RangePartitionSchemeDescription object. The value is 2.
   */
  UniformInt64Range: "UniformInt64Range",

  /**
   * Indicates that the partition is based on string names, and is a NamedPartitionSchemeDescription object. The value is 3
   */
  Named: "Named",
}

/**
 * The activation Mode of the service package
 */
union ArmServicePackageActivationMode {
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
   * An invalid correlation scheme. Cannot be used. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * Indicates that this service has an affinity relationship with another service. Provided for backwards compatibility, consider preferring the Aligned or NonAlignedAffinity options. The value is 1.
   */
  Affinity: "Affinity",

  /**
   * Aligned affinity ensures that the primaries of the partitions of the affinitized services are collocated on the same nodes. This is the default and is the same as selecting the Affinity scheme. The value is 2.
   */
  AlignedAffinity: "AlignedAffinity",

  /**
   * Non-Aligned affinity guarantees that all replicas of each service will be placed on the same nodes. Unlike Aligned Affinity, this does not guarantee that replicas of particular role will be collocated. The value is 3.
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
 * The type of placement policy for a service fabric service. Following are the possible values.
 */
union ServicePlacementPolicyType {
  string,

  /**
   * Indicates the type of the placement policy is invalid. All Service Fabric enumerations have the invalid type. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementInvalidDomainPolicyDescription, which indicates that a particular fault or upgrade domain cannot be used for placement of this service. The value is 1.
   */
  InvalidDomain: "InvalidDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription indicating that the replicas of the service must be placed in a specific domain. The value is 2.
   */
  RequiredDomain: "RequiredDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementPreferPrimaryDomainPolicyDescription, which indicates that if possible the Primary replica for the partitions of the service should be located in a particular domain as an optimization. The value is 3.
   */
  PreferredPrimaryDomain: "PreferredPrimaryDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription, indicating that the system will disallow placement of any two replicas from the same partition in the same domain at any time. The value is 4.
   */
  RequiredDomainDistribution: "RequiredDomainDistribution",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementNonPartiallyPlaceServicePolicyDescription, which indicates that if possible all replicas of a particular partition of the service should be placed atomically. The value is 5.
   */
  NonPartiallyPlaceService: "NonPartiallyPlaceService",
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
