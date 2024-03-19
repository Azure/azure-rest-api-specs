import "./main.tsp";
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
  listProjects is DevCenterService.DevCenter.listProjects;
  getProject is DevCenterService.DevCenter.getProject;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "detailed suppress description for each operation can be found in routes.tsp"
@client({
  name: "DevBoxesClient",
  service: DevCenterService,
})
interface DevBoxesClientOperations {
  listPools is DevCenterService.DevBoxes.listPools;
  getPool is DevCenterService.DevBoxes.getPool;
  listSchedules is DevCenterService.DevBoxes.listSchedulesByPool;
  getSchedule is DevCenterService.DevBoxes.getScheduleByPool;
  listAllDevBoxes is DevCenterService.DevCenter.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevCenter.listAllDevBoxesByUser;
  listDevBoxes is DevCenterService.DevBoxes.listDevBoxesByUser;
  getDevBox is DevCenterService.DevBoxes.getDevBoxByUser;
  @convenientAPI(false, "csharp") // https://github.com/Azure/azure-rest-api-specs/issues/28083
  createDevBox is DevCenterService.DevBoxes.createDevBox;
  deleteDevBox is DevCenterService.DevBoxes.deleteDevBox;
  startDevBox is DevCenterService.DevBoxes.startDevBox;
  stopDevBox is DevCenterService.DevBoxes.stopDevBox;
  restartDevBox is DevCenterService.DevBoxes.restartDevBox;
  getRemoteConnection is DevCenterService.DevBoxes.getRemoteConnection;
  listDevBoxActions is DevCenterService.DevBoxes.listActions;
  getDevBoxAction is DevCenterService.DevBoxes.getAction;
  skipAction is DevCenterService.DevBoxes.skipAction;
  delayAction is DevCenterService.DevBoxes.delayAction;
  delayAllActions is DevCenterService.DevBoxes.delayActions;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "detailed suppress description for each operation can be found in routes.tsp"
@client({
  name: "DeploymentEnvironmentsClient",
  service: DevCenterService,
})
interface EnvironmentClientOperations {
  listAllEnvironments is DevCenterService.Environments.listEnvironments;
  listEnvironments is DevCenterService.Environments.listEnvironmentsByUser;
  getEnvironment is DevCenterService.Environments.getEnvironmentByUser;
  @convenientAPI(false, "csharp") // same issue as described in https://github.com/Azure/azure-rest-api-specs/issues/28083
  createOrUpdateEnvironment is DevCenterService.Environments.createOrReplaceEnvironment;
  deleteEnvironment is DevCenterService.Environments.deleteEnvironment;
  listCatalogs is DevCenterService.Environments.listCatalogsByProject;
  getCatalog is DevCenterService.Environments.getCatalog;
  listEnvironmentDefinitions is DevCenterService.Environments.listEnvironmentDefinitionsByProject;
  listEnvironmentDefinitionsByCatalog is DevCenterService.Environments.listEnvironmentDefinitionsByCatalog;
  getEnvironmentDefinition is DevCenterService.Environments.getEnvironmentDefinition;
  listEnvironmentTypes is DevCenterService.Environments.listEnvironmentTypes;
}

@@usage(DevCenterService.DevBox, Usage.input | Usage.output);
@@usage(DevCenterService.Environment, Usage.input | Usage.output);

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
@@projectedName(DevCenterService.DevBoxActionDelayResult.result,
  "client",
  "delayStatus"
);

@@projectedName(DevCenterService.OsType, "csharp", "DevBoxOSType");
@@projectedName(DevCenterService.ScheduledFrequency,
  "csharp",
  "ScheduleFrequency"
);
@@projectedName(DevCenterService.ScheduledType, "csharp", "ScheduleType");
@@projectedName(DevCenterService.Pool, "csharp", "DevBoxPool");
@@projectedName(DevCenterService.Pool.osType, "csharp", "OSType");
@@projectedName(DevCenterService.Pool.localAdministrator,
  "csharp",
  "LocalAdministratorStatus"
);
@@projectedName(DevCenterService.HardwareProfile,
  "csharp",
  "DevBoxHardwareProfile"
);
@@projectedName(DevCenterService.StorageProfile,
  "csharp",
  "DevBoxStorageProfile"
);
@@projectedName(DevCenterService.StorageProfile.osDisk, "csharp", "OSDisk");
@@projectedName(DevCenterService.OsDisk, "csharp", "OSDisk");
@@projectedName(DevCenterService.ImageReference,
  "csharp",
  "DevBoxImageReference"
);
@@projectedName(DevCenterService.ImageReference.osBuildNumber,
  "csharp",
  "OSBuildNumber"
);
@@projectedName(DevCenterService.Schedule, "csharp", "DevBoxSchedule");
@@projectedName(DevCenterService.Schedule.type, "csharp", "scheduleType");
@@projectedName(DevCenterService.Schedule.frequency,
  "csharp",
  "scheduleFrequency"
);
@@projectedName(DevCenterService.DevBox.osType, "csharp", "OSType");
@@projectedName(DevCenterService.DevBox.user, "csharp", "userId");
@@projectedName(DevCenterService.DevBox.localAdministrator,
  "csharp",
  "LocalAdministratorStatus"
);
@@projectedName(DevCenterService.RemoteConnection.webUrl, "csharp", "webUri");
@@projectedName(DevCenterService.RemoteConnection.rdpConnectionUrl,
  "csharp",
  "rdpConnectionUri"
);
@@projectedName(DevCenterService.DevBoxAction.next, "csharp", "nextAction");
@@projectedName(DevCenterService.DevBoxActionDelayResult.name,
  "csharp",
  "actionName"
);
@@projectedName(DevCenterService.ParameterType,
  "csharp",
  "EnvironmentDefinitionParameterType"
);
@@projectedName(DevCenterService.Environment, "csharp", "DevCenterEnvironment");
@@projectedName(DevCenterService.Environment.environmentType,
  "csharp",
  "environmentTypeName"
);
@@projectedName(DevCenterService.Environment.user, "csharp", "userId");
@@projectedName(DevCenterService.Catalog, "csharp", "DevCenterCatalog");
@@projectedName(DevCenterService.EnvironmentDefinitionParameter.default,
  "csharp",
  "defaultValue"
);
@@projectedName(DevCenterService.EnvironmentDefinitionParameter.type,
  "csharp",
  "parameterType"
);
@@projectedName(DevCenterService.EnvironmentType,
  "csharp",
  "DevCenterEnvironmentType"
);
@@projectedName(DevCenterService.OperationStatusValue,
  "csharp",
  "DevCentertatus"
);
@@projectedName(DevCenterService.OperationStatus,
  "csharp",
  "DevCenterOperationDetails"
);
@@projectedName(DevCenterService.Project, "csharp", "DevCenterProject");

@@projectedName(DevCenterService.OsType, "java", "DevBoxOsType");
@@projectedName(DevCenterService.ScheduledFrequency,
  "java",
  "ScheduleFrequency"
);
@@projectedName(DevCenterService.ScheduledType, "java", "ScheduleType");
@@projectedName(DevCenterService.Pool, "java", "DevBoxPool");
@@projectedName(DevCenterService.Pool.localAdministrator,
  "java",
  "LocalAdministratorStatus"
);
@@projectedName(DevCenterService.HardwareProfile,
  "java",
  "DevBoxHardwareProfile"
);
@@projectedName(DevCenterService.StorageProfile,
  "java",
  "DevBoxStorageProfile"
);
@@projectedName(DevCenterService.OsDisk.diskSizeGB, "java", "diskSizeGb");
@@projectedName(DevCenterService.ImageReference,
  "java",
  "DevBoxImageReference"
);
@@projectedName(DevCenterService.Schedule, "java", "DevBoxSchedule");
@@projectedName(DevCenterService.Schedule.type, "java", "scheduleType");
@@projectedName(DevCenterService.Schedule.frequency,
  "java",
  "scheduleFrequency"
);
@@projectedName(DevCenterService.DevBox.user, "java", "userId");
@@projectedName(DevCenterService.DevBox.localAdministrator,
  "java",
  "LocalAdministratorStatus"
);
@@projectedName(DevCenterService.DevBoxAction.next, "java", "nextAction");
@@projectedName(DevCenterService.DevBoxActionDelayResult.name,
  "java",
  "actionName"
);
@@projectedName(DevCenterService.ParameterType,
  "java",
  "EnvironmentDefinitionParameterType"
);
@@projectedName(DevCenterService.Environment, "java", "DevCenterEnvironment");
@@projectedName(DevCenterService.Environment.environmentType,
  "java",
  "environmentTypeName"
);
@@projectedName(DevCenterService.Environment.user, "java", "userId");
@@projectedName(DevCenterService.Catalog, "java", "DevCenterCatalog");
@@projectedName(DevCenterService.EnvironmentDefinitionParameter.default,
  "java",
  "defaultValue"
);
@@projectedName(DevCenterService.EnvironmentDefinitionParameter.type,
  "java",
  "parameterType"
);
@@projectedName(DevCenterService.EnvironmentType,
  "java",
  "DevCenterEnvironmentType"
);
@@projectedName(DevCenterService.HardwareProfile.vCPUs, "java", "vCpus");
@@projectedName(DevCenterService.HardwareProfile.memoryGB, "java", "memoryGb");
@@projectedName(DevCenterService.OperationStatusValue,
  "java",
  "DevCentertatus"
);
@@projectedName(DevCenterService.OperationStatus,
  "java",
  "DevCenterOperationDetails"
);
@@projectedName(DevCenterService.Project, "java", "DevCenterProject");
