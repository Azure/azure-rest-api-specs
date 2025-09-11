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
@@clientName(BackupResourceStorageConfigsNonCRR.bMSPrepareDataMove::parameters.body,
  "parameters"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bMSTriggerDataMove::parameters.body,
  "parameters"
);

@@clientName(ProtectionIntentResources.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(BackupResourceVaultConfigs.put::parameters.resource, "parameters");
@@clientName(BackupResourceVaultConfigs.update::parameters.properties,
  "parameters"
);

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

@@clientLocation(BackupResourceStorageConfigsNonCRR.bMSPrepareDataMove,
  Microsoft.RecoveryServices
);
@@clientLocation(BackupResourceStorageConfigsNonCRR.bMSTriggerDataMove,
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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureIaaSClassicComputeVMProtectedItem,
  AzureIaaSVMProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureIaaSComputeVMProtectedItem, AzureIaaSVMProtectedItem);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPAseDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDBInstanceProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSQLDatabaseProtectedItem,
  AzureVmWorkloadProtectedItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPHanaRecoveryPoint,
  AzureWorkloadRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPHanaPointInTimeRecoveryPoint,
  AzureWorkloadPointInTimeRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPAseRecoveryPoint,
  AzureWorkloadRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPAsePointInTimeRecoveryPoint,
  AzureWorkloadPointInTimeRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLRecoveryPoint, AzureWorkloadRecoveryPoint);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRecoveryPoint,
  AzureWorkloadRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadPointInTimeRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPHanaRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPHanaPointInTimeRestoreRequest,
  AzureWorkloadSAPHanaRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPAseRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPAsePointInTimeRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRestoreRequest,
  AzureWorkloadRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureBackupServerContainer, DpmContainer);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureIaaSClassicComputeVMContainer, IaaSVMContainer);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureIaaSComputeVMContainer, IaaSVMContainer);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureIaaSClassicComputeVMProtectableItem,
  IaaSVMProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureIaaSComputeVMProtectableItem, IaaSVMProtectableItem);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureSQLAGWorkloadContainerProtectionContainer,
  AzureWorkloadContainer
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVMAppContainerProtectionContainer,
  AzureWorkloadContainer
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPAseDatabaseProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPAseSystemProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDBInstance,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDatabaseProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaHSRProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaSystemProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSQLAvailabilityGroupProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSQLDatabaseProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSQLInstanceProtectableItem,
  AzureVmWorkloadProtectableItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadAutoProtectionIntent,
  AzureRecoveryServiceVaultProtectionIntent
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLAutoProtectionIntent,
  AzureWorkloadAutoProtectionIntent
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest,
  AzureWorkloadSAPHanaPointInTimeRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPHanaRestoreWithRehydrateRequest,
  AzureWorkloadSAPHanaRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRestoreRequest,
  AzureWorkloadSQLRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest,
  AzureWorkloadSQLPointInTimeRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLRestoreWithRehydrateRequest,
  AzureWorkloadSQLRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPAseDatabaseWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPAseSystemWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaDatabaseWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSAPHanaSystemWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSQLDatabaseWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureVmWorkloadSQLInstanceWorkloadItem,
  AzureVmWorkloadItem
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadPointInTimeRecoveryPoint,
  AzureWorkloadRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSAPAsePointInTimeRestoreRequest,
  AzureWorkloadSAPAseRestoreRequest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(AzureWorkloadSQLPointInTimeRecoveryPoint,
  AzureWorkloadSQLRecoveryPoint
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(IaasVMRestoreWithRehydrationRequest, IaasVMRestoreRequest);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@hierarchyBuilding(ValidateIaasVMRestoreOperationRequest,
  ValidateRestoreOperationRequest
);

@@clientName(Azure.ResourceManager.CommonTypes.ErrorDetail,
  "ArmErrorDetail",
  "python"
);
