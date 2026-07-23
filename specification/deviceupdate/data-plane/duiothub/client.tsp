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

// Java and C# retain their already-shipped two-client API surface through the
// explicit clients below. Other languages retain their operation-group names.
@@clientLocation(
  DeviceUpdateOperationGroup.listUpdates,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.importUpdate,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.getUpdate,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.deleteUpdate,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.listProviders,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.listNames,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.listVersions,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.listFiles,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.getFile,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.listOperationStatuses,
  "DeviceUpdate",
  "!csharp,!java"
);
@@clientLocation(
  DeviceUpdateOperationGroup.getOperationStatus,
  "DeviceUpdate",
  "!csharp,!java"
);

@@clientLocation(
  DeviceManagementOperationGroup.listDeviceClasses,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClass,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.updateDeviceClass,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.deleteDeviceClass,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listInstallableUpdatesForDeviceClass,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDevices,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.importDevices,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDevice,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceModule,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getUpdateCompliance,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listGroups,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getGroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.deleteGroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getUpdateComplianceForGroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listBestUpdatesForGroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeploymentsForGroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeployment,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.createOrUpdateDeployment,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeploymentManagementOperationGroup.deleteDeployment,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeploymentStatus,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeviceClassSubgroupsForGroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClassSubgroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.deleteDeviceClassSubgroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClassSubgroupUpdateCompliance,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getBestUpdatesForDeviceClassSubgroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeploymentsForDeviceClassSubgroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeploymentForDeviceClassSubgroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeploymentManagementOperationGroup.deleteDeploymentForDeviceClassSubgroup,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.stopDeployment,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.retryDeployment,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getDeviceClassSubgroupDeploymentStatus,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listDeviceStatesForDeviceClassSubgroupDeployment,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getOperationStatus,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listOperationStatuses,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.startLogCollection,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getLogCollection,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listLogCollections,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.getLogCollectionDetailedStatus,
  "DeviceManagement",
  "!csharp,!java"
);
@@clientLocation(
  DeviceManagementOperationGroup.listHealthOfDevices,
  "DeviceManagement",
  "!csharp,!java"
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
  },
  "!java,!csharp"
);

// Java and C# GAed/shipped with 2 clients
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
