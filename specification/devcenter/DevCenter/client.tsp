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
  listSchedules is DevCenterService.DevBoxes.listSchedules;
  getSchedule is DevCenterService.DevBoxes.getSchedule;
  listAllDevBoxes is DevCenterService.DevBoxesDevCenter.listAllDevBoxes;
  listAllDevBoxesByUser is DevCenterService.DevBoxesDevCenter.listAllDevBoxesByUser;
  listDevBoxes is DevCenterService.DevBoxes.listDevBoxes;
  getDevBox is DevCenterService.DevBoxes.getDevBox;
  @convenientAPI(false)
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
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "detailed suppress description for each operation can be found in routes.tsp"
@client({
  name: "DeploymentEnvironmentsClient",
  service: DevCenterService,
})
interface EnvironmentClientOperations {
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

@@access(DevCenterService.DevBox, Access.public);
@@usage(DevCenterService.DevBox, Usage.input | Usage.output);

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

@@projectedName(DevCenterService.OsType, "csharp", "DevBoxOSType");
@@projectedName(DevCenterService.ScheduledFrequency,
  "csharp",
  "ScheduleFrequency"
);
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
@@projectedName(DevCenterService.Schedule.type, "csharp", "scheduledType");
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
@@projectedName(DevCenterService.Project, "csharp", "DevCenterProject");

@@projectedName(DevCenterService.OsType, "java", "DevBoxOsType");
@@projectedName(DevCenterService.ScheduledFrequency,
  "java",
  "ScheduleFrequency"
);
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
@@projectedName(DevCenterService.ImageReference,
  "java",
  "DevBoxImageReference"
);
@@projectedName(DevCenterService.Schedule, "java", "DevBoxSchedule");
@@projectedName(DevCenterService.Schedule.type, "java", "scheduledType");
@@projectedName(DevCenterService.DevBox.user, "java", "userId");
@@projectedName(DevCenterService.DevBox.localAdministrator,
  "java",
  "LocalAdministratorStatus"
);
@@projectedName(DevCenterService.DevBoxAction.next, "java", "nextAction");
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
@@projectedName(DevCenterService.HardwareProfile.vCPUs, "java", "vcpus");
@@projectedName(DevCenterService.Project, "java", "DevCenterProject");

@@projectedName(DevCenterService.OsType, "python", "OSType");
@@projectedName(DevCenterService.HardwareProfile.vCPUs, "python", "vcpus");
@@projectedName(DevCenterService.HardwareProfile.memoryGB,
  "python",
  "memoryGb"
);
@@projectedName(DevCenterService.OsDisk, "python", "OSDisk");
@@projectedName(DevCenterService.OsDisk.diskSizeGB, "python", "diskSizeGb");
