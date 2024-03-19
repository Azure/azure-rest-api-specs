import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Versioning;
using DevCenterService;
using Azure.ClientGenerator.Core;

@useDependency(APIVersions.v2023_04_01)
namespace PythonSdkCustomizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "detailed suppress description for each operation can be found in routes.tsp"
@client({
  name: "DevCenterClient",
  service: DevCenterService,
})
interface DevCenterClientOperations {
  //DevCenters
  listProjects is DevCenterService.DevCenter.listProjects;
  getProject is DevCenterService.DevCenter.getProject;

  //DevBoxes
  listPools is DevCenterService.DevBoxes.listPools;
  getPool is DevCenterService.DevBoxes.getPool;
  listSchedules is DevCenterService.DevBoxes.listSchedulesByPool;
  getSchedule is DevCenterService.DevBoxes.getScheduleByPool;
  listAllDevBoxes is DevCenterService.DevCenter.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevCenter.listAllDevBoxesByUser;
  listDevBoxes is DevCenterService.DevBoxes.listDevBoxesByUser;
  getDevBox is DevCenterService.DevBoxes.getDevBoxByUser;
  createDevBox is DevCenterService.DevBoxes.createDevBox;
  deleteDevBox is DevCenterService.DevBoxes.deleteDevBox;
  startDevBox is DevCenterService.DevBoxes.startDevBox;
  stopDevBox is DevCenterService.DevBoxes.stopDevBox;
  restartDevBox is DevCenterService.DevBoxes.restartDevBox;
  getRemoteConnection is DevCenterService.DevBoxes.getRemoteConnection;
  listDevBoxActions is DevCenterService.DevBoxes.listActions;
  getDevBoxAction is DevCenterService.DevBoxes.getAction;
  skipDevBoxAction is DevCenterService.DevBoxes.skipAction;
  delayDevBoxAction is DevCenterService.DevBoxes.delayAction;
  delayAllDevBoxActions is DevCenterService.DevBoxes.delayActions;

  //Environments
  listAllEnvironments is DevCenterService.Environments.listEnvironments;
  listEnvironments is DevCenterService.Environments.listEnvironmentsByUser;
  getEnvironment is DevCenterService.Environments.getEnvironmentByUser;
  createOrUpdateEnvironment is DevCenterService.Environments.createOrReplaceEnvironment;
  deleteEnvironment is DevCenterService.Environments.deleteEnvironment;
  listCatalogs is DevCenterService.Environments.listCatalogsByProject;
  getCatalog is DevCenterService.Environments.getCatalog;
  listEnvironmentDefinitions is DevCenterService.Environments.listEnvironmentDefinitionsByProject;
  listEnvironmentDefinitionsByCatalog is DevCenterService.Environments.listEnvironmentDefinitionsByCatalog;
  getEnvironmentDefinition is DevCenterService.Environments.getEnvironmentDefinition;
  listEnvironmentTypes is DevCenterService.Environments.listEnvironmentTypes;
}

@@projectedName(DevCenterService.LocalAdminStatus,
  "client",
  "LocalAdministratorStatus"
);
@@projectedName(DevCenterService.StopOnDisconnectEnableStatus,
  "client",
  "StopOnDisconnectStatus"
);
@@projectedName(DevCenterService.EnvironmentTypeEnableStatus,
  "client",
  "EnvironmentTypeStatus"
);
@@projectedName(DevCenterService.DevBoxActionDelayResultStatus,
  "client",
  "DevBoxActionDelayStatus"
);

@@projectedName(DevCenterService.OsType, "python", "OSType");
@@projectedName(DevCenterService.HardwareProfile.vCPUs, "python", "vcpus");
@@projectedName(DevCenterService.HardwareProfile.memoryGB,
  "python",
  "memoryGb"
);
@@projectedName(DevCenterService.OsDisk, "python", "OSDisk");
@@projectedName(DevCenterService.OsDisk.diskSizeGB, "python", "diskSizeGb");
@@projectedName(DevCenterService.OperationStatus, "python", "OperationDetails");
@@projectedName(DevCenterService.OperationStatusValue,
  "python",
  "OperationStatus"
);
