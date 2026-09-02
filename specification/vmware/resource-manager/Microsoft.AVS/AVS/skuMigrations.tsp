namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "SKU migration resources represent service-managed migration workflows and do not support customer-initiated deletion."
@armResourceOperations
@added(Versions.v2026_03_01)
interface SkuMigrations {
  list is ArmResourceListByParent<SkuMigration>;

  get is ArmResourceRead<SkuMigration>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<SkuMigration>;
}

@doc("A sku migration resource")
@parentResource(PrivateCloud)
model SkuMigration is ProxyResource<SkuMigrationProperties> {
  @doc("Name of the migration.")
  @pattern("^[-\\w\\._]+$")
  @key("skuMigrationName")
  @path
  @segment("skuMigrations")
  name: string;
}

@doc("The kind of sku migration.")
union SkuMigrationKind {
  string,
  Generation1ToGeneration2: "Generation1ToGeneration2",
}

@doc("provisioning state of the sku migration")
union SkuMigrationProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a sku migration.")
@discriminator("kind")
model SkuMigrationProperties {
  @doc("Sku migration kind.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  kind: SkuMigrationKind;

  @doc("UTC datetime when the migration started.")
  @visibility(Lifecycle.Read)
  startDate?: utcDateTime;

  @doc("UTC datetime when the migration completed.")
  @visibility(Lifecycle.Read)
  endDate?: utcDateTime;

  @doc("The state of the sku migration provisioning.")
  @visibility(Lifecycle.Read)
  provisioningState?: SkuMigrationProvisioningState;
}

@doc("State of the migration.")
union SkuMigrationState {
  string,

  @doc("Provisioning the destination private cloud.")
  ProvisioningDestinationPrivateCloud: "ProvisioningDestinationPrivateCloud",

  @doc("Waiting for cluster migrations to complete.")
  WaitingForClusterMigrationsToComplete: "WaitingForClusterMigrationsToComplete",

  @doc("Executing a cluster migration stage.")
  ExecutingAClusterMigrationStage: "ExecutingAClusterMigrationStage",

  @doc("Waiting for appliance migration maintenance window.")
  WaitingForApplianceMigrationMaintenanceWindow: "WaitingForApplianceMigrationMaintenanceWindow",

  @doc("Appliance migration is in progress.")
  ApplianceMigrationInProgress: "ApplianceMigrationInProgress",

  @doc("Waiting for T1 network migration maintenance window.")
  WaitingForT1NetworkMigrationMaintenanceWindow: "WaitingForT1NetworkMigrationMaintenanceWindow",

  @doc("T1 network migration is in progress.")
  T1NetworkMigrationInProgress: "T1NetworkMigrationInProgress",

  @doc("Waiting for complete compute migration.")
  WaitingForCompleteComputeMigration: "WaitingForCompleteComputeMigration",

  @doc("Complete compute migration is in progress.")
  CompleteComputeMigrationInProgress: "CompleteComputeMigrationInProgress",

  @doc("Waiting for complete network migration.")
  WaitingForCompleteNetworkMigration: "WaitingForCompleteNetworkMigration",

  @doc("Complete network migration is in progress.")
  CompleteNetworkMigrationInProgress: "CompleteNetworkMigrationInProgress",

  @doc("Waiting for network cut over from the source private cloud to the destination private cloud.")
  WaitingForNetworkCutOverFromSourcePrivateCloudToDestinationPrivateCloud: "WaitingForNetworkCutOverFromSourcePrivateCloudToDestinationPrivateCloud",

  @doc("Network cut over from the source private cloud to the destination private cloud is in progress.")
  NetworkCutOverFromSourcePrivateCloudToDestinationPrivateCloudInProgress: "NetworkCutOverFromSourcePrivateCloudToDestinationPrivateCloudInProgress",

  @doc("Network cut over from the source private cloud to the destination private cloud.")
  NetworkCutOverFromSourcePrivateCloudToDestinationPrivateCloud: "NetworkCutOverFromSourcePrivateCloudToDestinationPrivateCloud",

  @doc("Migration has completed successfully.")
  MigrationCompleted: "MigrationCompleted",

  @doc("Migration has failed.")
  MigrationFailed: "MigrationFailed",

  @doc("Awaiting user action to advance the migration.")
  AwaitingUserActionToAdvanceMigration: "AwaitingUserActionToAdvanceMigration",
}

alias MaintenanceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.AVS/privateClouds/maintenances";
  }
]>;

@doc("Mapping of a sku migration state to a maintenance resource id.")
model SkuMigrationStateMaintenanceMapping {
  @doc("The sku migration state that requires a maintenance window.")
  skuMigrationState: SkuMigrationState;

  @doc("The maintenance resource id associated with this sku migration state. When the source private cloud is deleted, the maintenance resource id will be kept for audit but the backing resource will no longer exist.")
  maintenanceId: MaintenanceId;
}

@doc("State of the per cluster migration.")
union SourceClusterToDestinationClusterMigrationState {
  string,

  @doc("Waiting for next provision destination cluster maintenance window.")
  WaitingForNextProvisionDestinationClusterMaintenanceWindow: "WaitingForNextProvisionDestinationClusterMaintenanceWindow",

  @doc("Destination cluster provisioning is in progress.")
  ProvisioningDestinationCluster: "ProvisioningDestinationCluster",

  @doc("Waiting for next workload migration maintenance window.")
  WaitingForNextWorkloadMigrationMaintenanceWindow: "WaitingForNextWorkloadMigrationMaintenanceWindow",

  @doc("Workload migration in progress.")
  WorkloadMigrationInProgress: "WorkloadMigrationInProgress",

  @doc("Workload migration completed.")
  WorkloadMigrationCompleted: "WorkloadMigrationCompleted",

  @doc("Migration has failed.")
  MigrationFailed: "MigrationFailed",

  @doc("Awaiting user action to advance the migration.")
  AwaitingUserActionToAdvanceMigration: "AwaitingUserActionToAdvanceMigration",
}

@doc("Source cluster to destination cluster mapping.")
model SourceClusterToDestinationCluster {
  @doc("Source cluster id.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minValue(1)
  @maxValue(100)
  sourceClusterId: int32;

  @doc("How many hosts should be deployed in the destination cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minValue(3)
  @maxValue(16)
  destinationClusterSize: int32;

  @doc("The desired sku of the destination cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  destinationClusterSku: Foundations.Sku;

  @doc("The id of the destination cluster that replaces the source cluster.")
  @visibility(Lifecycle.Read)
  @minValue(1)
  @maxValue(100)
  destinationClusterId?: int32;

  @doc("The maintenance resource id for the provision destination cluster operation which tracks the destination cluster provisioning for this source cluster. When the source private cloud is deleted, the maintenance resource ids will be kept for audit but the backing resource will no longer exist.")
  @visibility(Lifecycle.Read)
  provisionDestinationClusterMaintenanceResourceId?: MaintenanceId;

  @doc("The maintenance resource id for the workload migration operation which tracks the migration of workloads from the source cluster to the destination cluster. When the source private cloud is deleted, the maintenance resource ids will be kept for audit but the backing resource will no longer exist.")
  @visibility(Lifecycle.Read)
  workloadMigrationMaintenanceResourceId?: MaintenanceId;

  @doc("The state of the migration for this source cluster.")
  @visibility(Lifecycle.Read)
  migrationState?: SourceClusterToDestinationClusterMigrationState;
}

@doc("The properties of a generation 1 on fleet sku migration.")
model Generation1ToGeneration2SkuMigrationProperties
  extends SkuMigrationProperties {
  @doc("Sku migration kind.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  kind: SkuMigrationKind.Generation1ToGeneration2;

  @doc("Inform user of the migration state.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  skuMigrationState?: SkuMigrationState;

  @doc("The resource id of the destination private cloud to which the source private cloud is being migrated. The destination private cloud will be provisioned in the same region and availability zone as the source private cloud.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  destinationPrivateCloudResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AVS/privateClouds";
    }
  ]>;

  @doc("The resource id of the virtual network in the destination private cloud. Must be in the same resource group as the destination private cloud.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  destinationPrivateCloudVirtualNetworkResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  @doc("""
    Array of networks noncontiguous with networkBlock. Networks must be
    unique and non-overlapping across VNet in your subscription, on-premise, and
    the source privateCloud networkBlock and source privateCloud extendedNetworks.
    Make sure the CIDR format conforms to (A.B.C.D/X).
    The source private cloud network block that contains vCenter and NSX is auto included in the destination private cloud network block and is not required to be specified.
    """)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  destinationPrivateCloudNetworkBlocks: string[];

  @doc("The list of source clusters to destination clusters. Must include all source clusters in the private cloud. The destination cluster size should be large enough to accommodate all the workloads in the source clusters and quota must be allocated. Clusters will be migrated one at a time in the order they are listed except the destination management cluster will always be provisioned during destination private cloud provisioning and will have its workloads migrated last.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @identifiers(#["sourceClusterId"])
  sourceClustersToDestinationClusterMappings: SourceClusterToDestinationCluster[];

  @doc("The cluster id of the management cluster before the migration.")
  @visibility(Lifecycle.Read)
  @minValue(1)
  @maxValue(100)
  preMigrationManagementClusterId?: int32;

  @doc("The cluster id of the management cluster after the migration.")
  @visibility(Lifecycle.Read)
  @minValue(1)
  @maxValue(100)
  postMigrationManagementClusterId?: int32;

  @doc("Array of sku migration states that require a maintenance window mapped to their maintenance ids. Per-cluster maintenance ids are in the sourceClustersToDestinationClusterMappings array entries. When the source private cloud is deleted, the maintenance resource ids will be kept for audit but the backing resource will no longer exist.")
  @visibility(Lifecycle.Read)
  @identifiers(#["skuMigrationState"])
  skuMigrationStateToMaintenanceMappings?: SkuMigrationStateMaintenanceMapping[];

  @doc("Message to inform user of any action they must take to advance the migration.")
  @visibility(Lifecycle.Read)
  userActionRequiredMessage?: string;
}
