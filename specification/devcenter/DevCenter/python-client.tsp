import "./service.tsp";
import "./routes.tsp";
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
  listPools is DevCenterService.DevBoxes.listPools;
  getPool is DevCenterService.DevBoxes.getPool;
  listSchedules is DevCenterService.DevBoxes.listSchedules;
  getSchedule is DevCenterService.DevBoxes.getSchedule;
  listAllDevBoxes is DevCenterService.DevBoxesDevCenter.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevBoxesDevCenter.listAllDevBoxesByUser;
  listDevBoxes is DevCenterService.DevBoxes.listDevBoxes;
  getDevBox is DevCenterService.DevBoxes.getDevBox;
  createDevBox is DevCenterService.DevBoxes.createDevBox;
  deleteDevBox is DevCenterService.DevBoxes.deleteDevBox;
  startDevBox is DevCenterService.DevBoxes.startDevBox;
  stopDevBox is DevCenterService.DevBoxes.stopDevBox;
  restartDevBox is DevCenterService.DevBoxes.restartDevBox;
  getRemoteConnection is DevCenterService.DevBoxes.getRemoteConnection;
  listDevBoxActions is DevCenterService.DevBoxes.listDevBoxActions;
  getDevBoxAction is DevCenterService.DevBoxes.getDevBoxAction;
  skipAction is DevCenterService.DevBoxes.skipAction;
  delayAction is DevCenterService.DevBoxes.delayAction;
  delayAllActions is DevCenterService.DevBoxes.delayAllActions;

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
