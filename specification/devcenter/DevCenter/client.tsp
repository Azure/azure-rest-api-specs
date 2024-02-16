import "./service.tsp";
import "./Environments/routes.tsp";
import "./DevCenter/routes.tsp";
import "./DevBox/routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Versioning;
using DevCenterService;
using Azure.ClientGenerator.Core;

@useDependency(APIVersions.v2023_04_01)
namespace SdkCustomizations;

@client({
  name: "DevCenterClient",
  service: DevCenterService,
})
interface DevCenterClientOperations {
  listProjects is DevCenterService.DevCenterOperations.listProjects;
  getProject is DevCenterService.DevCenterOperations.getProject;
}

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

@@access(DevCenterService.DevBox, Access.public);
@@usage(DevCenterService.DevBox, Usage.input | Usage.output);

@@clientName(DevCenterService.LocalAdminStatus, "LocalAdministratorStatus");
@@clientName(DevCenterService.StopOnDisconnectEnableStatus, "StopOnDisconnectStatus");
@@clientName(DevCenterService.EnvironmentTypeEnableStatus, "EnvironmentTypeStatus");

@@clientName(DevCenterService.OsType, "DevBoxOSType", "csharp");
@@clientName(DevCenterService.ScheduledFrequency, "ScheduleFrequency", "csharp");
@@clientName(DevCenterService.DevBoxActionDelayResultStatus, "DevBoxActionDelayStatus", "csharp");
@@clientName(DevCenterService.Pool, "DevBoxPool", "csharp");
@@clientName(DevCenterService.Pool.osType, "OSType", "csharp");
@@clientName(DevCenterService.Pool.localAdministrator, "LocalAdministratorStatus", "csharp");
@@clientName(DevCenterService.HardwareProfile, "DevBoxHardwareProfile", "csharp");
@@clientName(DevCenterService.HardwareProfile.vCPUs, "vcpus", "csharp");
@@clientName(DevCenterService.StorageProfile, "DevBoxStorageProfile", "csharp");
@@clientName(DevCenterService.StorageProfile.osDisk , "OSDisk", "csharp");
@@clientName(DevCenterService.OsDisk, "OSDisk", "csharp");
@@clientName(DevCenterService.ImageReference, "DevBoxImageReference", "csharp");
@@clientName(DevCenterService.ImageReference.osBuildNumber , "OSBuildNumber", "csharp");
@@clientName(DevCenterService.Schedule, "DevBoxSchedule", "csharp");
@@clientName(DevCenterService.Schedule.type, "scheduledType", "csharp");
@@clientName(DevCenterService.DevBox.osType , "OSType", "csharp");
@@clientName(DevCenterService.DevBox.user , "userId", "csharp");
@@clientName(DevCenterService.DevBox.localAdministrator , "LocalAdministratorStatus", "csharp");
@@clientName(DevCenterService.RemoteConnection.webUrl , "webUri", "csharp");
@@clientName(DevCenterService.RemoteConnection.rdpConnectionUrl , "rdpConnectionUri", "csharp");
@@clientName(DevCenterService.DevBoxAction.next, "nextAction", "csharp");
@@clientName(DevCenterService.DevBoxActionDelayResult.action, "nextAction", "csharp");
@@clientName(DevCenterService.ParameterType, "EnvironmentDefinitionParameterType", "csharp");
@@clientName(DevCenterService.Environment, "DevCenterEnvironment", "csharp");
@@clientName(DevCenterService.Environment.environmentType, "environmentTypeName","csharp");
@@clientName(DevCenterService.Environment.user, "userId","csharp");
@@clientName(DevCenterService.Catalog, "DevCenterCatalog", "csharp");
@@clientName(DevCenterService.EnvironmentDefinitionParameter.default, "defaultValue", "csharp");
@@clientName(DevCenterService.EnvironmentDefinitionParameter.type, "parameterType", "csharp");
@@clientName(DevCenterService.EnvironmentType, "DevCenterEnvironmentType", "csharp");

@@clientName(DevCenterService.OsType, "DevBoxOsType" ,"java");
@@clientName(DevCenterService.ScheduledFrequency, "ScheduleFrequency", "java");
@@clientName(DevCenterService.DevBoxActionDelayResultStatus, "DevBoxActionDelayStatus", "java");
@@clientName(DevCenterService.Pool, "DevBoxPool", "java");
@@clientName(DevCenterService.Pool.localAdministrator, "LocalAdministratorStatus", "java");
@@clientName(DevCenterService.HardwareProfile, "DevBoxHardwareProfile", "java");
@@clientName(DevCenterService.StorageProfile, "DevBoxStorageProfile", "java");
@@clientName(DevCenterService.ImageReference, "DevBoxImageReference", "java");
@@clientName(DevCenterService.Schedule, "DevBoxSchedule", "java");
@@clientName(DevCenterService.Schedule.type, "scheduledType", "java");
@@clientName(DevCenterService.DevBox.user , "userId", "java");
@@clientName(DevCenterService.DevBox.localAdministrator , "LocalAdministratorStatus", "java");
@@clientName(DevCenterService.DevBoxAction.next, "nextAction", "java");
@@clientName(DevCenterService.ParameterType, "EnvironmentDefinitionParameterType", "java");
@@clientName(DevCenterService.Environment, "DevCenterEnvironment", "java");
@@clientName(DevCenterService.Environment.environmentType, "environmentTypeName", "java");
@@clientName(DevCenterService.Environment.user, "userId", "java");
@@clientName(DevCenterService.Catalog, "DevCenterCatalog", "java");
@@clientName(DevCenterService.EnvironmentDefinitionParameter.default, "defaultValue", "java");
@@clientName(DevCenterService.EnvironmentDefinitionParameter.type, "parameterType", "java");
@@clientName(DevCenterService.EnvironmentType, "DevCenterEnvironmentType", "java");

@@clientName(DevCenterService.OsType, "OSType", "python");
@@clientName(DevCenterService.HardwareProfile.vCPUs, "vcpus", "python");
@@clientName(DevCenterService.HardwareProfile.memoryGB, "memoryGb", "python");
@@clientName(DevCenterService.OsDisk, "OSDisk", "python");
@@clientName(DevCenterService.OsDisk.diskSizeGB ,"diskSizeGb", "python");