import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using DeviceUpdateClient;

@@clientName(LogCollection.operationId, "logCollectionId");

@@clientName(
  LogCollectionOperationDetailedStatus.operationId,
  "logCollectionId"
);

@@clientLocation(DeviceUpdateOperationGroup.listUpdates, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.importUpdate, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.getUpdate, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.deleteUpdate, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.listProviders, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.listNames, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.listVersions, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.listFiles, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.getFile, "DeviceUpdate");
@@clientLocation(
  DeviceUpdateOperationGroup.listOperationStatuses,
  "DeviceUpdate"
);
@@clientLocation(DeviceUpdateOperationGroup.getOperationStatus, "DeviceUpdate");

@@clientLocation(
  DeviceManagementOperationGroup.listDeviceClasses,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClass,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.updateDeviceClass,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.deleteDeviceClass,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listInstallableUpdatesForDeviceClass,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDevices,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.importDevices,
  "DeviceManagement"
);
@@clientLocation(DeviceManagementOperationGroup.getDevice, "DeviceManagement");
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceModule,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getUpdateCompliance,
  "DeviceManagement"
);
@@clientLocation(DeviceManagementOperationGroup.listGroups, "DeviceManagement");
@@clientLocation(DeviceManagementOperationGroup.getGroup, "DeviceManagement");
@@clientLocation(
  DeviceManagementOperationGroup.deleteGroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getUpdateComplianceForGroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listBestUpdatesForGroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeploymentsForGroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeployment,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.createOrUpdateDeployment,
  "DeviceManagement"
);
@@clientLocation(
  DeploymentManagementOperationGroup.deleteDeployment,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeploymentStatus,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeviceClassSubgroupsForGroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClassSubgroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.deleteDeviceClassSubgroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClassSubgroupUpdateCompliance,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getBestUpdatesForDeviceClassSubgroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeploymentsForDeviceClassSubgroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeploymentForDeviceClassSubgroup,
  "DeviceManagement"
);
@@clientLocation(
  DeploymentManagementOperationGroup.deleteDeploymentForDeviceClassSubgroup,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.stopDeployment,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.retryDeployment,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClassSubgroupDeploymentStatus,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeviceStatesForDeviceClassSubgroupDeployment,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getOperationStatus,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listOperationStatuses,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.startLogCollection,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getLogCollection,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listLogCollections,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.getLogCollectionDetailedStatus,
  "DeviceManagement"
);
@@clientLocation(
  DeviceManagementOperationGroup.listHealthOfDevices,
  "DeviceManagement"
);

// Hoist `instanceId` from per-operation parameter to client-constructor
// parameter, matching the original swagger's
// `x-ms-parameter-location: "client"` on `InstanceIdParameter`.
/** Client-level options for `DeviceUpdateClient`. */
model DeviceUpdateClientOptions {
  /** The Device Update for IoT Hub account instance identifier. */
  instanceId: string;
}

@@clientInitialization(
  DeviceUpdateClient,
  {
    parameters: DeviceUpdateClientOptions,
  }
);
