import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Versioning;
using DevCenterService;
using Azure.ClientGenerator.Core;

@useDependency(APIVersions.v2024_09_01_preview)
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
  listAllDevBoxes is DevCenterService.DevBoxes.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevBoxes.listAllDevBoxesByUser;
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
@@clientName(DevCenterService.DevBoxActionDelayResult.result, "delayStatus");

@@clientName(DevCenterService.OsType, "DevBoxOSType", "csharp");
@@clientName(DevCenterService.ScheduledFrequency,
  "ScheduleFrequency",
  "csharp"
);
@@clientName(DevCenterService.ScheduledType, "ScheduleType", "csharp");
@@clientName(DevCenterService.Pool, "DevBoxPool", "csharp");
@@clientName(DevCenterService.Pool.osType, "OSType", "csharp");
@@clientName(DevCenterService.Pool.localAdministrator,
  "LocalAdministratorStatus",
  "csharp"
);
@@clientName(DevCenterService.HardwareProfile,
  "DevBoxHardwareProfile",
  "csharp"
);
@@clientName(DevCenterService.StorageProfile, "DevBoxStorageProfile", "csharp");
@@clientName(DevCenterService.StorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(DevCenterService.OsDisk, "OSDisk", "csharp");
@@clientName(DevCenterService.ImageReference, "DevBoxImageReference", "csharp");
@@clientName(DevCenterService.ImageReference.osBuildNumber,
  "OSBuildNumber",
  "csharp"
);
@@clientName(DevCenterService.Schedule, "DevBoxSchedule", "csharp");
@@clientName(DevCenterService.Schedule.type, "scheduleType", "csharp");
@@clientName(DevCenterService.Schedule.frequency,
  "scheduleFrequency",
  "csharp"
);
@@clientName(DevCenterService.DevBox.osType, "OSType", "csharp");
@@clientName(DevCenterService.DevBox.user, "userId", "csharp");
@@clientName(DevCenterService.DevBox.localAdministrator,
  "LocalAdministratorStatus",
  "csharp"
);
@@clientName(DevCenterService.RemoteConnection.webUrl, "webUri", "csharp");
@@clientName(DevCenterService.RemoteConnection.rdpConnectionUrl,
  "rdpConnectionUri",
  "csharp"
);
@@clientName(DevCenterService.DevBoxAction.next, "nextAction", "csharp");
@@clientName(DevCenterService.DevBoxActionDelayResult.name,
  "actionName",
  "csharp"
);
@@clientName(DevCenterService.ParameterType,
  "EnvironmentDefinitionParameterType",
  "csharp"
);
@@clientName(DevCenterService.Environment, "DevCenterEnvironment", "csharp");
@@clientName(DevCenterService.Environment.environmentType,
  "environmentTypeName",
  "csharp"
);
@@clientName(DevCenterService.Environment.user, "userId", "csharp");
@@clientName(DevCenterService.Catalog, "DevCenterCatalog", "csharp");
@@clientName(DevCenterService.EnvironmentDefinitionParameter.default,
  "defaultValue",
  "csharp"
);
@@clientName(DevCenterService.EnvironmentDefinitionParameter.type,
  "parameterType",
  "csharp"
);
@@clientName(DevCenterService.EnvironmentType,
  "DevCenterEnvironmentType",
  "csharp"
);
@@clientName(Azure.Core.Foundations.OperationState,
  "DevCenterOperationStatus",
  "csharp"
);
@@clientName(DevCenterService.OperationStatus,
  "DevCenterOperationDetails",
  "csharp"
);
@@clientName(DevCenterService.Project, "DevCenterProject", "csharp");

@@clientName(DevCenterService.OsType, "DevBoxOsType", "java");
@@clientName(DevCenterService.ScheduledFrequency, "ScheduleFrequency", "java");
@@clientName(DevCenterService.ScheduledType, "ScheduleType", "java");
@@clientName(DevCenterService.Pool, "DevBoxPool", "java");
@@clientName(DevCenterService.Pool.localAdministrator,
  "LocalAdministratorStatus",
  "java"
);
@@clientName(DevCenterService.HardwareProfile, "DevBoxHardwareProfile", "java");
@@clientName(DevCenterService.StorageProfile, "DevBoxStorageProfile", "java");
@@clientName(DevCenterService.OsDisk.diskSizeGB, "diskSizeInGb", "java");
@@clientName(DevCenterService.ImageReference, "DevBoxImageReference", "java");
@@clientName(DevCenterService.Schedule, "DevBoxSchedule", "java");
@@clientName(DevCenterService.Schedule.type, "scheduleType", "java");
@@clientName(DevCenterService.Schedule.frequency, "scheduleFrequency", "java");
@@clientName(DevCenterService.DevBox.user, "userId", "java");
@@clientName(DevCenterService.DevBox.localAdministrator,
  "LocalAdministratorStatus",
  "java"
);
@@clientName(DevCenterService.DevBoxAction.next, "nextAction", "java");
@@clientName(DevCenterService.DevBoxActionDelayResult.name,
  "actionName",
  "java"
);
@@clientName(DevCenterService.ParameterType,
  "EnvironmentDefinitionParameterType",
  "java"
);
@@clientName(DevCenterService.Environment, "DevCenterEnvironment", "java");
@@clientName(DevCenterService.Environment.environmentType,
  "environmentTypeName",
  "java"
);
@@clientName(DevCenterService.Environment.user, "userId", "java");
@@clientName(DevCenterService.Catalog, "DevCenterCatalog", "java");
@@clientName(DevCenterService.EnvironmentDefinitionParameter.default,
  "defaultValue",
  "java"
);
@@clientName(DevCenterService.EnvironmentDefinitionParameter.type,
  "parameterType",
  "java"
);
@@clientName(DevCenterService.EnvironmentType,
  "DevCenterEnvironmentType",
  "java"
);
@@clientName(DevCenterService.HardwareProfile.vCPUs, "vCpus", "java");
@@clientName(DevCenterService.HardwareProfile.memoryGB, "memoryInGb", "java");
@@clientName(DevCenterService.StopOnDisconnectConfiguration.gracePeriodMinutes,
  "gracePeriodInMinutes",
  "java"
);
@@clientName(Azure.Core.Foundations.OperationState,
  "DevCenterOperationStatus",
  "java"
);
@@clientName(DevCenterService.OperationStatus,
  "DevCenterOperationDetails",
  "java"
);
@@clientName(DevCenterService.Project, "DevCenterProject", "java");
