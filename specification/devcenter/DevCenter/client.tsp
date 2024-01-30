import "./service.tsp";
import "./environments/routes.tsp";
import "./devcenter/routes.tsp";
import "./devbox/routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Versioning;
using DevCenterService;
using Azure.ClientGenerator.Core;

@useDependency(APIVersions.v2023_04_01)
namespace SdkCustomizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "DevCenterClient",
  service: DevCenterService,
})
interface DevCenterClientOperations {
  listProjects is DevCenterService.DevCenterOperations.listProjects;
  getProject is DevCenterService.DevCenterOperations.getProject;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "DevBoxesClient",
  service: DevCenterService,
})
interface DevBoxesClientOperations {
  listPools is DevCenterService.DevBoxesOperations.listPools;
  getPool is DevCenterService.DevBoxesOperations.getPool;
  listSchedules is DevCenterService.DevBoxesOperations.listSchedules;
  getSchedule is DevCenterService.DevBoxesOperations.getSchedule;
  listAllDevBoxes is DevCenterService.DevBoxesDevCenterOperations.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevBoxesDevCenterOperations.listAllDevBoxesByUser;
  listDevBoxes is DevCenterService.DevBoxesOperations.listDevBoxes;
  getDevBox is DevCenterService.DevBoxesOperations.getDevBox;
  @convenientAPI(false)
  @access(Access.public)
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
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "DeploymentEnvironmentsClient",
  service: DevCenterService,
})
interface EnvironmentClientOperations {
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
