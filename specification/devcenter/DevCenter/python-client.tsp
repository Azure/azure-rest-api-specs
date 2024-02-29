import "./environments/routes.tsp";
import "./devcenter/routes.tsp";
import "./devbox/routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Versioning;
using DevCenterService;
using Azure.ClientGenerator.Core;

@useDependency(APIVersions.v2023_04_01)
namespace PythonSdkCustomizations;

@client({
  name: "DevCenterClient",
  service: DevCenterService,
})
interface DevCenterClientOperations {
  //DevCenters
  listProjects is DevCenterService.DevCenter.listProjects;
  getProject is DevCenterService.DevCenter.getProject;

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
  skipAction is DevCenterService.DevBoxesOperations.skipAction;
  delayAction is DevCenterService.DevBoxesOperations.delayAction;
  delayAllActions is DevCenterService.DevBoxesOperations.delayAllActions;

  //Environments
  listAllEnvironments is DevCenterService.Environments.listAllEnvironments;
  listEnvironments is DevCenterService.Environments.listEnvironments;
  getEnvironment is DevCenterService.Environments.getEnvironment;
  createOrUpdateEnvironment is DevCenterService.Environments.createOrUpdateEnvironment;
  deleteEnvironment is DevCenterService.Environments.deleteEnvironment;
  listCatalogs is DevCenterService.Environments.listCatalogs;
  getCatalog is DevCenterService.Environments.getCatalog;
  listEnvironmentDefinitions is DevCenterService.Environments.listEnvironmentDefinitions;
  listEnvironmentDefinitionsByCatalog is DevCenterService.Environments.listEnvironmentDefinitionsByCatalog;
  getEnvironmentDefinition is DevCenterService.Environments.getEnvironmentDefinition;
  listEnvironmentTypes is DevCenterService.Environments.listEnvironmentTypes;
}
