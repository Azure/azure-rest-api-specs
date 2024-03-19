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
  listProjects is DevCenterService.DevCenterOperations.listProjects;
  getProject is DevCenterService.DevCenterOperations.getProject;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "detailed suppress description for each operation can be found in routes.tsp"
@client({
  name: "DevBoxesClient",
  service: DevCenterService,
})
interface DevBoxesClientOperations {
  listPools is DevCenterService.DevBoxesOperations.listPools;
  getPool is DevCenterService.DevBoxesOperations.getPool;
  listSchedules is DevCenterService.DevBoxesOperations.listSchedules;
  getSchedule is DevCenterService.DevBoxesOperations.getSchedule;
  listAllDevBoxes is DevCenterService.DevBoxesDevCenter.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevBoxesDevCenter.listAllDevBoxesByUser;
  listDevBoxes is DevCenterService.DevBoxesOperations.listDevBoxes;
  getDevBox is DevCenterService.DevBoxesOperations.getDevBox;
  @convenientAPI(false, "csharp") // https://github.com/Azure/azure-rest-api-specs/issues/28083
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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "detailed suppress description for each operation can be found in routes.tsp"
@client({
  name: "DeploymentEnvironmentsClient",
  service: DevCenterService,
})
interface EnvironmentClientOperations {
  listAllEnvironments is DevCenterService.EnvironmentsOperations.listAllEnvironments;
  listEnvironments is DevCenterService.EnvironmentsOperations.listEnvironments;
  getEnvironment is DevCenterService.EnvironmentsOperations.getEnvironment;
  @convenientAPI(false, "csharp") // same issue as described in https://github.com/Azure/azure-rest-api-specs/issues/28083
  createOrUpdateEnvironment is DevCenterService.EnvironmentsOperations.createOrUpdateEnvironment;
  deleteEnvironment is DevCenterService.EnvironmentsOperations.deleteEnvironment;
  listCatalogs is DevCenterService.EnvironmentsOperations.listCatalogs;
  getCatalog is DevCenterService.EnvironmentsOperations.getCatalog;
  listEnvironmentDefinitions is DevCenterService.EnvironmentsOperations.listEnvironmentDefinitions;
  listEnvironmentDefinitionsByCatalog is DevCenterService.EnvironmentsOperations.listEnvironmentDefinitionsByCatalog;
  getEnvironmentDefinition is DevCenterService.EnvironmentsOperations.getEnvironmentDefinition;
  listEnvironmentTypes is DevCenterService.EnvironmentsOperations.listEnvironmentTypes;
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
  "DevCenterOperationStatus"
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
  "DevCenterOperationStatus"
);
@@projectedName(DevCenterService.OperationStatus,
  "java",
  "DevCenterOperationDetails"
);
@@projectedName(DevCenterService.Project, "java", "DevCenterProject");
