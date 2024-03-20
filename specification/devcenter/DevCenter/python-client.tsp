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
  listSchedules is DevCenterService.DevBoxesOperations.listSchedules;
  getSchedule is DevCenterService.DevBoxesOperations.getSchedule;
  listAllDevBoxes is DevCenterService.DevBoxesDevCenter.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevBoxesDevCenter.listAllDevBoxesByUser;
  listDevBoxes is DevCenterService.DevBoxesOperations.listDevBoxes;
  getDevBox is DevCenterService.DevBoxesOperations.getDevBox;
  createDevBox is DevCenterService.DevBoxesOperations.createDevBox;
  deleteDevBox is DevCenterService.DevBoxesOperations.deleteDevBox;
  startDevBox is DevCenterService.DevBoxesOperations.startDevBox;
  stopDevBox is DevCenterService.DevBoxesOperations.stopDevBox;
  restartDevBox is DevCenterService.DevBoxesOperations.restartDevBox;
  getRemoteConnection is DevCenterService.DevBoxesOperations.getRemoteConnection;
  listDevBoxActions is DevCenterService.DevBoxesOperations.listDevBoxActions;
  getDevBoxAction is DevCenterService.DevBoxesOperations.getDevBoxAction;
  skipDevBoxAction is DevCenterService.DevBoxesOperations.skipAction;
  delayDevBoxAction is DevCenterService.DevBoxesOperations.delayAction;
  delayAllDevBoxActions is DevCenterService.DevBoxesOperations.delayAllActions;

  //Environments
  listAllEnvironments is DevCenterService.EnvironmentsOperations.listAllEnvironments;
  listEnvironments is DevCenterService.EnvironmentsOperations.listEnvironments;
  getEnvironment is DevCenterService.EnvironmentsOperations.getEnvironment;
  createOrUpdateEnvironment is DevCenterService.EnvironmentsOperations.createOrUpdateEnvironment;
  deleteEnvironment is DevCenterService.EnvironmentsOperations.deleteEnvironment;
  listCatalogs is DevCenterService.EnvironmentsOperations.listCatalogs;
  getCatalog is DevCenterService.EnvironmentsOperations.getCatalog;
  listEnvironmentDefinitions is DevCenterService.EnvironmentsOperations.listEnvironmentDefinitions;
  listEnvironmentDefinitionsByCatalog is DevCenterService.EnvironmentsOperations.listEnvironmentDefinitionsByCatalog;
  getEnvironmentDefinition is DevCenterService.EnvironmentsOperations.getEnvironmentDefinition;
  listEnvironmentTypes is DevCenterService.EnvironmentsOperations.listEnvironmentTypes;
}

@@clientName(DevCenterService.LocalAdminStatus, "LocalAdministratorStatus");
@@clientName(DevCenterService.StopOnDisconnectEnableStatus,
  "StopOnDisconnectStatus"
);
@@clientName(DevCenterService.EnvironmentTypeEnableStatus,
  "EnvironmentTypeStatus"
);
@@clientName(DevCenterService.DevBoxActionDelayResultStatus,
  "DevBoxActionDelayStatus"
);

@@clientName(DevCenterService.OsType, "OSType", "python");
@@clientName(DevCenterService.HardwareProfile.vCPUs, "vcpus", "python");
@@clientName(DevCenterService.HardwareProfile.memoryGB, "memoryGb", "python");
@@clientName(DevCenterService.OsDisk, "OSDisk", "python");
@@clientName(DevCenterService.OsDisk.diskSizeGB, "diskSizeGb", "python");
@@clientName(DevCenterService.OperationStatus, "OperationDetails", "python");
@@clientName(DevCenterService.OperationStatusValue,
  "OperationStatus",
  "python"
);
