import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using DeviceUpdateClient;

namespace Customization;

@@clientName(LogCollection.operationId, "logCollectionId");

@@clientName(
  LogCollectionOperationDetailedStatus.operationId,
  "logCollectionId"
);

// The C# namespace is `Azure.IoT.DeviceUpdate`; a sub-client literally named
// `DeviceUpdate` collides with the namespace's last segment, so the C# emitter
// disambiguates by renaming the namespace to `Azure.IoT._DeviceUpdate`. Use
// `DeviceUpdates` for C# only to avoid the collision; all other languages keep
// the original `DeviceUpdate` name (no collision there, and it preserves the
// already-shipped public client/operation-group name).
@@clientLocation(DeviceUpdateOperationGroup.listUpdates, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.listUpdates, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.importUpdate, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.importUpdate, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.getUpdate, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.getUpdate, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.deleteUpdate, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.deleteUpdate, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.listProviders, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.listProviders, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.listNames, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.listNames, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.listVersions, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.listVersions, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.listFiles, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.listFiles, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.getFile, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.getFile, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.listOperationStatuses, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.listOperationStatuses, "DeviceUpdate", "!csharp,!java");
@@clientLocation(DeviceUpdateOperationGroup.getOperationStatus, "DeviceUpdates", "csharp");
@@clientLocation(DeviceUpdateOperationGroup.getOperationStatus, "DeviceUpdate", "!csharp,!java");

@@clientLocation(DeviceManagementOperationGroup.listDeviceClasses, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.getDeviceClass, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.updateDeviceClass, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.deleteDeviceClass, "DeviceManagement", "!java");
@@clientLocation(
  DeviceManagementOperationGroup.listInstallableUpdatesForDeviceClass,
  "DeviceManagement",
  "!java"
);
@@clientLocation(DeviceManagementOperationGroup.listDevices, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.importDevices, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.getDevice, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.getDeviceModule, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.getUpdateCompliance, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.listGroups, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.getGroup, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.deleteGroup, "DeviceManagement", "!java");
@@clientLocation(
  DeviceManagementOperationGroup.getUpdateComplianceForGroup,
  "DeviceManagement",
  "!java"
);
@@clientLocation(DeviceManagementOperationGroup.listBestUpdatesForGroup, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.listDeploymentsForGroup, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.getDeployment, "DeviceManagement", "!java");
@@clientLocation(
  DeviceManagementOperationGroup.createOrUpdateDeployment,
  "DeviceManagement",
  "!java"
);
@@clientLocation(DeploymentManagementOperationGroup.deleteDeployment, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.getDeploymentStatus, "DeviceManagement", "!java");
@@clientLocation(
  DeviceManagementOperationGroup.listDeviceClassSubgroupsForGroup,
  "DeviceManagement",
  "!java"
);
@@clientLocation(DeviceManagementOperationGroup.getDeviceClassSubgroup, "DeviceManagement", "!java");
@@clientLocation(
  DeviceManagementOperationGroup.deleteDeviceClassSubgroup,
  "DeviceManagement",
  "!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClassSubgroupUpdateCompliance,
  "DeviceManagement",
  "!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getBestUpdatesForDeviceClassSubgroup,
  "DeviceManagement",
  "!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeploymentsForDeviceClassSubgroup,
  "DeviceManagement",
  "!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeploymentForDeviceClassSubgroup,
  "DeviceManagement",
  "!java"
);
@@clientLocation(
  DeploymentManagementOperationGroup.deleteDeploymentForDeviceClassSubgroup,
  "DeviceManagement",
  "!java"
);
@@clientLocation(DeviceManagementOperationGroup.stopDeployment, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.retryDeployment, "DeviceManagement", "!java");
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClassSubgroupDeploymentStatus,
  "DeviceManagement",
  "!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeviceStatesForDeviceClassSubgroupDeployment,
  "DeviceManagement",
  "!java"
);
@@clientLocation(DeviceManagementOperationGroup.getOperationStatus, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.listOperationStatuses, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.startLogCollection, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.getLogCollection, "DeviceManagement", "!java");
@@clientLocation(DeviceManagementOperationGroup.listLogCollections, "DeviceManagement", "!java");
@@clientLocation(
  DeviceManagementOperationGroup.getLogCollectionDetailedStatus,
  "DeviceManagement",
  "!java"
);
@@clientLocation(DeviceManagementOperationGroup.listHealthOfDevices, "DeviceManagement", "!java");

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
  },
  "!java,!csharp"
);

// Java lib GAed with 2 clients
@clientInitialization(
  {
    parameters: DeviceUpdateClientOptions,
  },
  "java,csharp"
)
@client(
  {
    name: "DeviceUpdateClient",
    service: DeviceUpdateClient,
  },
  "java,csharp"
)
interface ClientDeviceUpdateClient {
  listUpdates is DeviceUpdateOperationGroup.listUpdates;
  importUpdate is DeviceUpdateOperationGroup.importUpdate;
  getUpdate is DeviceUpdateOperationGroup.getUpdate;
  deleteUpdate is DeviceUpdateOperationGroup.deleteUpdate;
  listProviders is DeviceUpdateOperationGroup.listProviders;
  listNames is DeviceUpdateOperationGroup.listNames;
  listVersions is DeviceUpdateOperationGroup.listVersions;
  listFiles is DeviceUpdateOperationGroup.listFiles;
  getFile is DeviceUpdateOperationGroup.getFile;
  listOperationStatuses is DeviceUpdateOperationGroup.listOperationStatuses;
  getOperationStatus is DeviceUpdateOperationGroup.getOperationStatus;
}

@clientInitialization(
  {
    parameters: DeviceUpdateClientOptions,
  },
  "java,csharp"
)
@client(
  {
    name: "DeviceManagementClient",
    service: DeviceUpdateClient,
  },
  "java,csharp"
)
interface DeviceManagementClient {
  listDeviceClasses is DeviceManagementOperationGroup.listDeviceClasses;
  getDeviceClass is DeviceManagementOperationGroup.getDeviceClass;
  updateDeviceClass is DeviceManagementOperationGroup.updateDeviceClass;
  deleteDeviceClass is DeviceManagementOperationGroup.deleteDeviceClass;
  listInstallableUpdatesForDeviceClass is DeviceManagementOperationGroup.listInstallableUpdatesForDeviceClass;
  listDevices is DeviceManagementOperationGroup.listDevices;
  importDevices is DeviceManagementOperationGroup.importDevices;
  getDevice is DeviceManagementOperationGroup.getDevice;
  getDeviceModule is DeviceManagementOperationGroup.getDeviceModule;
  getUpdateCompliance is DeviceManagementOperationGroup.getUpdateCompliance;
  listGroups is DeviceManagementOperationGroup.listGroups;
  getGroup is DeviceManagementOperationGroup.getGroup;
  deleteGroup is DeviceManagementOperationGroup.deleteGroup;
  getUpdateComplianceForGroup is DeviceManagementOperationGroup.getUpdateComplianceForGroup;
  listBestUpdatesForGroup is DeviceManagementOperationGroup.listBestUpdatesForGroup;
  listDeploymentsForGroup is DeviceManagementOperationGroup.listDeploymentsForGroup;
  getDeployment is DeviceManagementOperationGroup.getDeployment;
  createOrUpdateDeployment is DeviceManagementOperationGroup.createOrUpdateDeployment;
  deleteDeployment is DeploymentManagementOperationGroup.deleteDeployment;
  getDeploymentStatus is DeviceManagementOperationGroup.getDeploymentStatus;
  listDeviceClassSubgroupsForGroup is DeviceManagementOperationGroup.listDeviceClassSubgroupsForGroup;
  getDeviceClassSubgroup is DeviceManagementOperationGroup.getDeviceClassSubgroup;
  deleteDeviceClassSubgroup is DeviceManagementOperationGroup.deleteDeviceClassSubgroup;
  getDeviceClassSubgroupUpdateCompliance is DeviceManagementOperationGroup.getDeviceClassSubgroupUpdateCompliance;
  getBestUpdatesForDeviceClassSubgroup is DeviceManagementOperationGroup.getBestUpdatesForDeviceClassSubgroup;
  listDeploymentsForDeviceClassSubgroup is DeviceManagementOperationGroup.listDeploymentsForDeviceClassSubgroup;
  getDeploymentForDeviceClassSubgroup is DeviceManagementOperationGroup.getDeploymentForDeviceClassSubgroup;
  deleteDeploymentForDeviceClassSubgroup is DeploymentManagementOperationGroup.deleteDeploymentForDeviceClassSubgroup;
  stopDeployment is DeviceManagementOperationGroup.stopDeployment;
  retryDeployment is DeviceManagementOperationGroup.retryDeployment;
  getDeviceClassSubgroupDeploymentStatus is DeviceManagementOperationGroup.getDeviceClassSubgroupDeploymentStatus;
  listDeviceStatesForDeviceClassSubgroupDeployment is DeviceManagementOperationGroup.listDeviceStatesForDeviceClassSubgroupDeployment;
  getOperationStatus is DeviceManagementOperationGroup.getOperationStatus;
  listOperationStatuses is DeviceManagementOperationGroup.listOperationStatuses;
  startLogCollection is DeviceManagementOperationGroup.startLogCollection;
  getLogCollection is DeviceManagementOperationGroup.getLogCollection;
  listLogCollections is DeviceManagementOperationGroup.listLogCollections;
  getLogCollectionDetailedStatus is DeviceManagementOperationGroup.getLogCollectionDetailedStatus;
  listHealthOfDevices is DeviceManagementOperationGroup.listHealthOfDevices;
}
