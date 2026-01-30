import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.RecoveryServices;

@@clientName(BackupResourceStorageConfigsNonCRR.update::parameters.resource,
  "parameters"
);
@@clientName(BackupResourceStorageConfigsNonCRR.patch::parameters.properties,
  "parameters"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove::parameters.body,
  "parameters"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove::parameters.body,
  "parameters"
);

@@clientName(ProtectionIntentResources.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(BackupResourceVaultConfigs.put::parameters.resource, "parameters");
@@clientName(BackupResourceVaultConfigs.update::parameters.properties,
  "parameters"
);

@@clientName(RecoveryPoints.update::parameters.properties, "parameters");

@@clientName(BackupResourceEncryptionConfigs.update::parameters.resource,
  "parameters"
);

@@clientName(PrivateEndpointConnectionResources.put::parameters.resource,
  "parameters"
);

@@clientName(ProtectedItems.createOrUpdate::parameters.resource, "parameters");
@@clientName(Backups.trigger::parameters.body, "parameters");
@@clientName(RecoveryPointsRecommendedForMove.list::parameters.body,
  "parameters"
);

@@clientName(RecoveryPoints.moveRecoveryPoint::parameters.body, "parameters");
@@clientName(Restores.trigger::parameters.body, "parameters");
@@clientName(ItemLevelRecoveryConnections.provision::parameters.body,
  "parameters"
);

@@clientName(ProtectionPolicies.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(ProtectionContainers.register::parameters.resource, "parameters");

@@clientName(ResourceGuardProxy.put::parameters.resource, "parameters");
@@clientName(ResourceGuardProxy.unlockDelete::parameters.body, "parameters");

@@clientName(BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove,
  "BMSPrepareDataMove"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove,
  "BMSTriggerDataMove"
);

@@clientLocation(BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove,
  Microsoft.RecoveryServices
);
@@clientLocation(BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove,
  Microsoft.RecoveryServices
);
@@clientLocation(BackupResourceConfigOperationStatuses.getOperationStatus,
  Microsoft.RecoveryServices
);

@@clientLocation(PrivateEndpointConnectionResources.get,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnectionResources.put,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnectionResources.delete,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointOperationStatuses.getOperationStatus,
  "PrivateEndpoint"
);

@@clientLocation(ProtectionIntentResources.get, "ProtectionIntent");
@@clientLocation(ProtectionIntentResources.createOrUpdate, "ProtectionIntent");
@@clientLocation(ProtectionIntentResources.delete, "ProtectionIntent");

@@clientLocation(RecoveryPoints.moveRecoveryPoint, Microsoft.RecoveryServices);

@@clientLocation(ProtectionContainersOperationGroup.refresh,
  ProtectionContainers
);

@@clientLocation(ProtectionIntentOperationGroup.validate, "ProtectionIntent");

@@clientLocation(OperationOperationGroup.validate, "Operation");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureIaaSClassicComputeVMProtectedItem,
  AzureIaaSVMProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureIaaSComputeVMProtectedItem, AzureIaaSVMProtectedItem);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPAseDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDBInstanceProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSQLDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSQLInstanceProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPHanaRecoveryPoint,
  AzureWorkloadRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPHanaPointInTimeRecoveryPoint,
  AzureWorkloadPointInTimeRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPAseRecoveryPoint,
  AzureWorkloadRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPAsePointInTimeRecoveryPoint,
  AzureWorkloadPointInTimeRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLRecoveryPoint, AzureWorkloadRecoveryPoint);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRecoveryPoint,
  AzureWorkloadRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadPointInTimeRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPHanaRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPHanaPointInTimeRestoreRequest,
  AzureWorkloadSAPHanaRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPAseRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPAsePointInTimeRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureBackupServerContainer, DpmContainer);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureIaaSClassicComputeVMContainer, IaaSVMContainer);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureIaaSComputeVMContainer, IaaSVMContainer);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureIaaSClassicComputeVMProtectableItem,
  IaaSVMProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureIaaSComputeVMProtectableItem, IaaSVMProtectableItem);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureSQLAGWorkloadContainerProtectionContainer,
  AzureWorkloadContainer
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVMAppContainerProtectionContainer,
  AzureWorkloadContainer
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPAseDatabaseProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPAseSystemProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDBInstance,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDatabaseProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaHSRProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaScaleoutProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaSystemProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSQLAvailabilityGroupProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSQLDatabaseProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSQLInstanceProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadAutoProtectionIntent,
  AzureRecoveryServiceVaultProtectionIntent
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLAutoProtectionIntent,
  AzureWorkloadAutoProtectionIntent
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest,
  AzureWorkloadSAPHanaPointInTimeRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPHanaRestoreWithRehydrateRequest,
  AzureWorkloadSAPHanaRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRestoreRequest,
  AzureWorkloadSQLRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest,
  AzureWorkloadSQLPointInTimeRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLRestoreWithRehydrateRequest,
  AzureWorkloadSQLRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPAseDatabaseWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPAseSystemWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDatabaseWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaSystemWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSQLDatabaseWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureVmWorkloadSQLInstanceWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadPointInTimeRecoveryPoint,
  AzureWorkloadRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSAPAsePointInTimeRestoreRequest,
  AzureWorkloadSAPAseRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRecoveryPoint,
  AzureWorkloadSQLRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(IaasVMRestoreWithRehydrationRequest, IaasVMRestoreRequest);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@hierarchyBuilding(ValidateIaasVMRestoreOperationRequest,
  ValidateRestoreOperationRequest
);

@@clientName(Azure.ResourceManager.CommonTypes.ErrorDetail,
  "ArmErrorDetail",
  "python,javascript"
);
