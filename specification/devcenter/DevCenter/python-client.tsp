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
  listProjects is DevCenterService.DevCenterOperations.listProjects;
  getProject is DevCenterService.DevCenterOperations.getProject;

  //DevBoxes
  listPools is DevCenterService.DevBoxesOperations.listPools;
  getPool is DevCenterService.DevBoxesOperations.getPool;
  listSchedules is DevCenterService.DevBoxesOperations.listSchedulesByPool;
  getSchedule is DevCenterService.DevBoxesOperations.getScheduleByPool;
  listAllDevBoxes is DevCenterService.DevCenterOperations.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevCenterOperations.listAllDevBoxesByUser;
  listDevBoxes is DevCenterService.DevBoxesOperations.listDevBoxesByUser;
  getDevBox is DevCenterService.DevBoxesOperations.getDevBoxByUser;
  createDevBox is DevCenterService.DevBoxesOperations.createDevBox;
  deleteDevBox is DevCenterService.DevBoxesOperations.deleteDevBox;
  startDevBox is DevCenterService.DevBoxesOperations.startDevBox;
  stopDevBox is DevCenterService.DevBoxesOperations.stopDevBox;
  restartDevBox is DevCenterService.DevBoxesOperations.restartDevBox;
  getRemoteConnection is DevCenterService.DevBoxesOperations.getRemoteConnection;
  listDevBoxActions is DevCenterService.DevBoxesOperations.listActions;
  getDevBoxAction is DevCenterService.DevBoxesOperations.getAction;
  skipDevBoxAction is DevCenterService.DevBoxesOperations.skipAction;
  delayDevBoxAction is DevCenterService.DevBoxesOperations.delayAction;
  delayAllDevBoxActions is DevCenterService.DevBoxesOperations.delayActions;

  //Environments
  listAllEnvironments is DevCenterService.EnvironmentsOperations.listEnvironments;
  listEnvironments is DevCenterService.EnvironmentsOperations.listEnvironmentsByUser;
  getEnvironment is DevCenterService.EnvironmentsOperations.getEnvironmentByUser;
  createOrUpdateEnvironment is DevCenterService.EnvironmentsOperations.createOrReplaceEnvironment;
  deleteEnvironment is DevCenterService.EnvironmentsOperations.deleteEnvironment;
  listCatalogs is DevCenterService.EnvironmentsOperations.listCatalogsByProject;
  getCatalog is DevCenterService.EnvironmentsOperations.getCatalog;
  listEnvironmentDefinitions is DevCenterService.EnvironmentsOperations.listEnvironmentDefinitionsByProject;
  listEnvironmentDefinitionsByCatalog is DevCenterService.EnvironmentsOperations.listEnvironmentDefinitionsByCatalog;
  getEnvironmentDefinition is DevCenterService.EnvironmentsOperations.getEnvironmentDefinition;
  listEnvironmentTypes is DevCenterService.EnvironmentsOperations.listEnvironmentTypes;
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
