import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

@@clientName(Alerts.create::parameters.resource, "request");

@@clientName(ReplicationEligibilityResultsOperationGroup,
  "ReplicationEligibilityResults"
);

@@clientName(Fabrics.create::parameters.resource, "input");
@@clientName(Fabrics.reassociateGateway::parameters.body,
  "failoverProcessServerRequest"
);
@@clientName(Fabrics.renewCertificate::parameters.body, "renewCertificate");

@@clientName(NetworkMappings.create::parameters.resource, "input");
@@clientName(NetworkMappings.update::parameters.properties, "input");

@@clientName(ProtectionContainers.create::parameters.resource, "creationInput");
@@clientName(ProtectionContainers.discoverProtectableItem::parameters.body,
  "discoverProtectableItemRequest"
);
@@clientName(ProtectionContainers.switchClusterProtection::parameters.body,
  "switchInput"
);
@@clientName(ProtectionContainers.switchProtection::parameters.body,
  "switchInput"
);

@@clientName(MigrationItems.create::parameters.resource, "input");
@@clientName(MigrationItems.update::parameters.properties, "input");
@@clientName(MigrationItems.migrate::parameters.body, "migrateInput");
@@clientName(MigrationItems.pauseReplication::parameters.body,
  "pauseReplicationInput"
);
@@clientName(MigrationItems.resumeReplication::parameters.body,
  "resumeReplicationInput"
);
@@clientName(MigrationItems.resync::parameters.body, "input");
@@clientName(MigrationItems.testMigrate::parameters.body, "testMigrateInput");
@@clientName(MigrationItems.testMigrateCleanup::parameters.body,
  "testMigrateCleanupInput"
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

@@clientName(ProtectionContainerMappings.create::parameters.resource,
  "creationInput"
);
@@clientName(ProtectionContainerMappings.update::parameters.properties,
  "updateInput"
);
@@clientName(ProtectionContainerMappings.delete::parameters.body,
  "removalInput"
);

@@clientName(RecoveryServicesProviders.create::parameters.resource,
  "addProviderInput"
);

@@clientName(StorageClassificationMappings.create::parameters.resource,
  "pairingInput"
);

@@clientName(VCenters.create::parameters.resource, "addVCenterRequest");
@@clientName(VCenters.update::parameters.properties, "updateVCenterRequest");

@@clientName(Jobs.resume::parameters.body, "resumeJobParams");

@@clientName(Policies.create::parameters.resource, "input");
@@clientName(Policies.update::parameters.properties, "input");

@@clientName(ReplicationProtectionIntents.create::parameters.resource, "input");

@@clientName(RecoveryPlans.create::parameters.resource, "input");
@@clientName(RecoveryPlans.update::parameters.properties, "input");
@@clientName(RecoveryPlans.plannedFailover::parameters.body, "input");
@@clientName(RecoveryPlans.testFailover::parameters.body, "input");
@@clientName(RecoveryPlans.testFailoverCleanup::parameters.body, "input");
@@clientName(RecoveryPlans.unplannedFailover::parameters.body, "input");

@@clientName(VaultSettings.create::parameters.resource, "input");
