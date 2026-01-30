import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

@@clientLocation(Alerts.get, "ReplicationAlertSettings");
@@clientLocation(Alerts.create, "ReplicationAlertSettings");
@@clientName(Alerts.create::parameters.resource, "request");
@@clientLocation(Alerts.list, "ReplicationAlertSettings");

@@clientLocation(ReplicationEligibilityResultsOperationGroup.get,
  "ReplicationEligibilityResults"
);
@@clientLocation(ReplicationEligibilityResultsOperationGroup.list,
  "ReplicationEligibilityResults"
);

@@clientLocation(Events.get, "ReplicationEvents");
@@clientLocation(Events.list, "ReplicationEvents");

@@clientLocation(Fabrics.get, "ReplicationFabrics");
@@clientLocation(Fabrics.create, "ReplicationFabrics");
@@clientName(Fabrics.create::parameters.resource, "input");
@@clientLocation(Fabrics.purge, "ReplicationFabrics");
@@clientLocation(Fabrics.list, "ReplicationFabrics");
@@clientLocation(Fabrics.checkConsistency, "ReplicationFabrics");
@@clientLocation(Fabrics.migrateToAad, "ReplicationFabrics");
@@clientLocation(Fabrics.reassociateGateway, "ReplicationFabrics");
@@clientName(Fabrics.reassociateGateway::parameters.body,
  "failoverProcessServerRequest"
);
@@clientLocation(Fabrics.delete, "ReplicationFabrics");
@@clientLocation(Fabrics.renewCertificate, "ReplicationFabrics");
@@clientName(Fabrics.renewCertificate::parameters.body, "renewCertificate");
@@clientLocation(Fabrics.removeInfra, "ReplicationFabrics");

@@clientLocation(LogicalNetworks.get, "ReplicationLogicalNetworks");
@@clientLocation(LogicalNetworks.listByReplicationFabrics,
  "ReplicationLogicalNetworks"
);

@@clientLocation(Networks.get, "ReplicationNetworks");
@@clientLocation(Networks.listByReplicationFabrics, "ReplicationNetworks");

@@clientLocation(NetworkMappings.get, "ReplicationNetworkMappings");
@@clientLocation(NetworkMappings.create, "ReplicationNetworkMappings");
@@clientName(NetworkMappings.create::parameters.resource, "input");
@@clientLocation(NetworkMappings.update, "ReplicationNetworkMappings");
@@clientName(NetworkMappings.update::parameters.properties, "input");
@@clientLocation(NetworkMappings.delete, "ReplicationNetworkMappings");
@@clientLocation(NetworkMappings.listByReplicationNetworks,
  "ReplicationNetworkMappings"
);

@@clientLocation(ProtectionContainers.get, "ReplicationProtectionContainers");
@@clientLocation(ProtectionContainers.create,
  "ReplicationProtectionContainers"
);
@@clientName(ProtectionContainers.create::parameters.resource, "creationInput");
@@clientLocation(ProtectionContainers.listByReplicationFabrics,
  "ReplicationProtectionContainers"
);
@@clientLocation(ProtectionContainers.discoverProtectableItem,
  "ReplicationProtectionContainers"
);
@@clientName(ProtectionContainers.discoverProtectableItem::parameters.body,
  "discoverProtectableItemRequest"
);
@@clientLocation(ProtectionContainers.delete,
  "ReplicationProtectionContainers"
);
@@clientLocation(ProtectionContainers.switchClusterProtection,
  "ReplicationProtectionContainers"
);
@@clientName(ProtectionContainers.switchClusterProtection::parameters.body,
  "switchInput"
);
@@clientLocation(ProtectionContainers.switchProtection,
  "ReplicationProtectionContainers"
);
@@clientName(ProtectionContainers.switchProtection::parameters.body,
  "switchInput"
);

@@clientLocation(MigrationItems.get, "ReplicationMigrationItems");
@@clientLocation(MigrationItems.create, "ReplicationMigrationItems");
@@clientName(MigrationItems.create::parameters.resource, "input");
@@clientLocation(MigrationItems.update, "ReplicationMigrationItems");
@@clientName(MigrationItems.update::parameters.properties, "input");
@@clientLocation(MigrationItems.delete, "ReplicationMigrationItems");
@@clientLocation(MigrationItems.listByReplicationProtectionContainers,
  "ReplicationMigrationItems"
);
@@clientLocation(MigrationItems.migrate, "ReplicationMigrationItems");
@@clientName(MigrationItems.migrate::parameters.body, "migrateInput");
@@clientLocation(MigrationItems.pauseReplication, "ReplicationMigrationItems");
@@clientName(MigrationItems.pauseReplication::parameters.body,
  "pauseReplicationInput"
);
@@clientLocation(MigrationItems.resumeReplication, "ReplicationMigrationItems");
@@clientName(MigrationItems.resumeReplication::parameters.body,
  "resumeReplicationInput"
);
@@clientLocation(MigrationItems.resync, "ReplicationMigrationItems");
@@clientName(MigrationItems.resync::parameters.body, "input");
@@clientLocation(MigrationItems.testMigrate, "ReplicationMigrationItems");
@@clientName(MigrationItems.testMigrate::parameters.body, "testMigrateInput");
@@clientLocation(MigrationItems.testMigrateCleanup,
  "ReplicationMigrationItems"
);
@@clientName(MigrationItems.testMigrateCleanup::parameters.body,
  "testMigrateCleanupInput"
);

@@clientLocation(ProtectableItems.get, "ReplicationProtectableItems");
@@clientLocation(ProtectableItems.listByReplicationProtectionContainers,
  "ReplicationProtectableItems"
);

@@clientName(ReplicationProtectedItems.create::parameters.resource, "input");
@@clientName(ReplicationProtectedItems.update::parameters.properties,
  "updateProtectionInput"
);
@@clientName(ReplicationProtectedItems.addDisks::parameters.body,
  "addDisksInput"
);
@@clientName(ReplicationProtectedItems.applyRecoveryPoint::parameters.body,
  "applyRecoveryPointInput"
);
@@clientName(ReplicationProtectedItems.plannedFailover::parameters.body,
  "failoverInput"
);
@@clientName(ReplicationProtectedItems.delete::parameters.body,
  "disableProtectionInput"
);
@@clientName(ReplicationProtectedItems.removeDisks::parameters.body,
  "removeDisksInput"
);
@@clientName(ReplicationProtectedItems.reprotect::parameters.body,
  "reprotectInput"
);
@@clientName(ReplicationProtectedItems.resolveHealthErrors::parameters.body,
  "resolveHealthInput"
);
@@clientName(ReplicationProtectedItems.switchProvider::parameters.body,
  "switchProviderInput"
);
@@clientName(ReplicationProtectedItems.testFailover::parameters.body,
  "testfailoverInput"
);
@@clientName(ReplicationProtectedItems.testFailoverCleanup::parameters.body,
  "cleanupInput"
);
@@clientName(ReplicationProtectedItems.unplannedFailover::parameters.body,
  "failoverInput"
);
@@clientName(ReplicationProtectedItems.updateAppliance::parameters.body,
  "applianceUpdateInput"
);
@@clientName(ReplicationProtectedItems.updateMobilityService::parameters.body,
  "updateMobilityServiceRequest"
);
@@clientName(ReplicationProtectedItems.reinstallMobilityService::parameters.body,
  "updateMobilityServiceRequest"
);
@@clientLocation(ReplicationProtectedItems.listByReplicationProtectedItems,
  "TargetComputeSizes"
);

@@clientName(ReplicationProtectionClusters.create::parameters.resource,
  "replicationProtectionCluster"
);
@@clientName(ReplicationProtectionClusters.applyRecoveryPoint::parameters.body,
  "applyClusterRecoveryPointInput"
);
@@clientName(ReplicationProtectionClusters.testFailover::parameters.body,
  "failoverInput"
);
@@clientName(ReplicationProtectionClusters.testFailoverCleanup::parameters.body,
  "cleanupInput"
);
@@clientName(ReplicationProtectionClusters.unplannedFailover::parameters.body,
  "failoverInput"
);
@@clientLocation(ReplicationProtectionClusterOperationGroup.getOperationResults,
  ReplicationProtectionClusters
);
@@clientLocation(ReplicationProtectionClusterOperationGroup.listByReplicationProtectionContainers,
  ReplicationProtectionClusters
);

@@clientLocation(ClusterRecoveryPoints.get, "ClusterRecoveryPoint");

@@clientLocation(ProtectionContainerMappings.get,
  "ReplicationProtectionContainerMappings"
);
@@clientLocation(ProtectionContainerMappings.create,
  "ReplicationProtectionContainerMappings"
);
@@clientName(ProtectionContainerMappings.create::parameters.resource,
  "creationInput"
);
@@clientLocation(ProtectionContainerMappings.update,
  "ReplicationProtectionContainerMappings"
);
@@clientName(ProtectionContainerMappings.update::parameters.properties,
  "updateInput"
);
@@clientLocation(ProtectionContainerMappings.purge,
  "ReplicationProtectionContainerMappings"
);
@@clientLocation(ProtectionContainerMappings.listByReplicationProtectionContainers,
  "ReplicationProtectionContainerMappings"
);
@@clientLocation(ProtectionContainerMappings.delete,
  "ReplicationProtectionContainerMappings"
);
@@clientName(ProtectionContainerMappings.delete::parameters.body,
  "removalInput"
);

@@clientLocation(RecoveryServicesProviders.get,
  "ReplicationRecoveryServicesProviders"
);
@@clientLocation(RecoveryServicesProviders.create,
  "ReplicationRecoveryServicesProviders"
);
@@clientName(RecoveryServicesProviders.create::parameters.resource,
  "addProviderInput"
);
@@clientLocation(RecoveryServicesProviders.purge,
  "ReplicationRecoveryServicesProviders"
);
@@clientLocation(RecoveryServicesProviders.listByReplicationFabrics,
  "ReplicationRecoveryServicesProviders"
);
@@clientLocation(RecoveryServicesProviders.refreshProvider,
  "ReplicationRecoveryServicesProviders"
);
@@clientLocation(RecoveryServicesProviders.delete,
  "ReplicationRecoveryServicesProviders"
);

@@clientLocation(StorageClassifications.get,
  "ReplicationStorageClassifications"
);
@@clientLocation(StorageClassifications.listByReplicationFabrics,
  "ReplicationStorageClassifications"
);

@@clientLocation(StorageClassificationMappings.get,
  "ReplicationStorageClassificationMappings"
);
@@clientLocation(StorageClassificationMappings.create,
  "ReplicationStorageClassificationMappings"
);
@@clientName(StorageClassificationMappings.create::parameters.resource,
  "pairingInput"
);
@@clientLocation(StorageClassificationMappings.delete,
  "ReplicationStorageClassificationMappings"
);
@@clientLocation(StorageClassificationMappings.listByReplicationStorageClassifications,
  "ReplicationStorageClassificationMappings"
);

@@clientLocation(VCenters.get, "ReplicationvCenters");
@@clientLocation(VCenters.create, "ReplicationvCenters");
@@clientName(VCenters.create::parameters.resource, "addVCenterRequest");
@@clientLocation(VCenters.update, "ReplicationvCenters");
@@clientName(VCenters.update::parameters.properties, "updateVCenterRequest");
@@clientLocation(VCenters.delete, "ReplicationvCenters");
@@clientLocation(VCenters.listByReplicationFabrics, "ReplicationvCenters");

@@clientLocation(Jobs.get, "ReplicationJobs");
@@clientLocation(Jobs.list, "ReplicationJobs");
@@clientLocation(Jobs.cancel, "ReplicationJobs");
@@clientLocation(Jobs.restart, "ReplicationJobs");
@@clientLocation(Jobs.resume, "ReplicationJobs");
@@clientName(Jobs.resume::parameters.body, "resumeJobParams");

@@clientLocation(Policies.get, "ReplicationPolicies");
@@clientLocation(Policies.create, "ReplicationPolicies");
@@clientName(Policies.create::parameters.resource, "input");
@@clientLocation(Policies.update, "ReplicationPolicies");
@@clientName(Policies.update::parameters.properties, "input");
@@clientLocation(Policies.delete, "ReplicationPolicies");
@@clientLocation(Policies.list, "ReplicationPolicies");

@@clientName(ReplicationProtectionIntents.create::parameters.resource, "input");

@@clientLocation(RecoveryPlans.get, "ReplicationRecoveryPlans");
@@clientLocation(RecoveryPlans.create, "ReplicationRecoveryPlans");
@@clientName(RecoveryPlans.create::parameters.resource, "input");
@@clientLocation(RecoveryPlans.update, "ReplicationRecoveryPlans");
@@clientName(RecoveryPlans.update::parameters.properties, "input");
@@clientLocation(RecoveryPlans.delete, "ReplicationRecoveryPlans");
@@clientLocation(RecoveryPlans.list, "ReplicationRecoveryPlans");
@@clientLocation(RecoveryPlans.failoverCancel, "ReplicationRecoveryPlans");
@@clientLocation(RecoveryPlans.failoverCommit, "ReplicationRecoveryPlans");
@@clientLocation(RecoveryPlans.plannedFailover, "ReplicationRecoveryPlans");
@@clientName(RecoveryPlans.plannedFailover::parameters.body, "input");
@@clientLocation(RecoveryPlans.reprotect, "ReplicationRecoveryPlans");
@@clientLocation(RecoveryPlans.testFailover, "ReplicationRecoveryPlans");
@@clientName(RecoveryPlans.testFailover::parameters.body, "input");
@@clientLocation(RecoveryPlans.testFailoverCleanup, "ReplicationRecoveryPlans");
@@clientName(RecoveryPlans.testFailoverCleanup::parameters.body, "input");
@@clientLocation(RecoveryPlans.unplannedFailover, "ReplicationRecoveryPlans");
@@clientName(RecoveryPlans.unplannedFailover::parameters.body, "input");

@@clientLocation(VaultSettings.get, "ReplicationVaultSetting");
@@clientLocation(VaultSettings.create, "ReplicationVaultSetting");
@@clientName(VaultSettings.create::parameters.resource, "input");
@@clientLocation(VaultSettings.list, "ReplicationVaultSetting");

@@clientLocation(OperationsOperationGroup.list, "Operations");

@@clientLocation(ReplicationAppliancesOperationGroup.list,
  "ReplicationAppliances"
);

@@clientLocation(ReplicationNetworksOperationGroup.list, "ReplicationNetworks");

@@clientLocation(ReplicationNetworkMappingsOperationGroup.list,
  "ReplicationNetworkMappings"
);

@@clientLocation(ReplicationProtectionContainersOperationGroup.list,
  "ReplicationProtectionContainers"
);

@@clientLocation(ReplicationMigrationItemsOperationGroup.list,
  "ReplicationMigrationItems"
);

@@clientLocation(ReplicationProtectedItemsOperationGroup.list,
  ReplicationProtectedItems
);

@@clientLocation(ReplicationProtectionClustersOperationGroup.list,
  ReplicationProtectionClusters
);

@@clientLocation(ReplicationProtectionContainerMappingsOperationGroup.list,
  "ReplicationProtectionContainerMappings"
);

@@clientLocation(ReplicationRecoveryServicesProvidersOperationGroup.list,
  "ReplicationRecoveryServicesProviders"
);

@@clientLocation(ReplicationStorageClassificationsOperationGroup.list,
  "ReplicationStorageClassifications"
);

@@clientLocation(ReplicationStorageClassificationMappingsOperationGroup.list,
  "ReplicationStorageClassificationMappings"
);

@@clientLocation(ReplicationvCentersOperationGroup.list, "ReplicationvCenters");

@@clientLocation(ReplicationJobsOperationGroup.export, "ReplicationJobs");

@@clientLocation(SupportedOperatingSystemsOperationGroup.get,
  "SupportedOperatingSystems"
);

@@clientLocation(ReplicationVaultHealthOperationGroup.get,
  "ReplicationVaultHealth"
);
@@clientLocation(ReplicationVaultHealthOperationGroup.refresh,
  "ReplicationVaultHealth"
);
@@clientName(ReplicationJobsOperationGroup.export::parameters.body,
  "jobQueryParameter"
);
