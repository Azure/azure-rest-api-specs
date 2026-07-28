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

// Hoist `instanceId` from per-operation parameter to client-constructor
// parameter, matching the original swagger's
// `x-ms-parameter-location: "client"` on `InstanceIdParameter`.
/** Client-level options for `DeviceUpdateClient`. */
model DeviceUpdateClientOptions {
  /** The Device Update for IoT Hub account instance identifier. */
  instanceId: string;
}

@clientInitialization(
  {
    parameters: DeviceUpdateClientOptions,
  },
  "!java,!csharp"
)
@client(
  {
    name: "DeviceUpdateClient",
    service: DeviceUpdateClient,
  },
  "!java,!csharp"
)
namespace ClientDeviceUpdateService {
  @operationGroup("!java,!csharp")
  interface DeviceUpdate {
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

  @operationGroup("!java,!csharp")
  interface DeviceManagement {
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
}

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
