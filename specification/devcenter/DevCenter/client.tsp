import "./service.tsp";
import "./environments/routes.tsp";
import "./devcenter/routes.tsp";
import "./devbox/routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Versioning;
using DevCenter;
using Azure.ClientGenerator.Core;

@useDependency(APIVersions.v2023_04_01)
namespace SDKCustomizations;

@client({
    name: "DevCenterClient",
    service: DevCenter,
})
interface DevCenterClientOperations {
    @convenientAPI(false)
    ListProjects is DevCenter.DevCenterOperations.ListProjects;
    @convenientAPI(false)
    GetProject is DevCenter.DevCenterOperations.GetProject;
    @convenientAPI(false)
    ListAllDevBoxes is DevCenter.DevBoxesDevCenterOperations.ListAllDevBoxes;
    @convenientAPI(false)
    ListAllDevBoxesByUser is DevCenter.DevBoxesDevCenterOperations.ListAllDevBoxesByUser;
}

@client({
    name: "DevBoxesClient",
    service: DevCenter,
})
interface DevBoxesClientOperations {
    @convenientAPI(false)
    ListPools is DevCenter.DevBoxesOperations.ListPools;
    @convenientAPI(false)
    GetPool is DevCenter.DevBoxesOperations.GetPool;
    @convenientAPI(false)
    ListSchedules is DevCenter.DevBoxesOperations.ListSchedules;
    @convenientAPI(false)
    GetSchedule is DevCenter.DevBoxesOperations.GetSchedule;
    @convenientAPI(false)
    ListAllDevBoxes is DevCenter.DevBoxesOperations.ListAllDevBoxes;
    @convenientAPI(false)
    ListAllDevBoxesByUser is DevCenter.DevBoxesOperations.ListAllDevBoxesByUser;
    @convenientAPI(false)
    ListDevBoxes is DevCenter.DevBoxesOperations.ListDevBoxes;
    @convenientAPI(false)
    GetDevBox is DevCenter.DevBoxesOperations.GetDevBox;
    @convenientAPI(false)
    CreateDevBox is DevCenter.DevBoxesOperations.CreateDevBox;
    @convenientAPI(false)
    DeleteDevBox is DevCenter.DevBoxesOperations.DeleteDevBox;
    @convenientAPI(false)
    StartDevBox is DevCenter.DevBoxesOperations.StartDevBox;
    @convenientAPI(false)
    StopDevBox is DevCenter.DevBoxesOperations.StopDevBox;
    @convenientAPI(false)
    RestartDevBox is DevCenter.DevBoxesOperations.RestartDevBox;
    @convenientAPI(false)
    GetRemoteConnection is DevCenter.DevBoxesOperations.GetRemoteConnection;
    @convenientAPI(false)
    ListActions is DevCenter.DevBoxesOperations.ListActions;
    @convenientAPI(false)
    GetAction is DevCenter.DevBoxesOperations.GetAction;
    @convenientAPI(false)
    SkipAction is DevCenter.DevBoxesOperations.SkipAction;
    @convenientAPI(false)
    DelayAction is DevCenter.DevBoxesOperations.DelayAction;
    @convenientAPI(false)
    DelayAllActions is DevCenter.DevBoxesOperations.DelayAllActions;
}

@client({
    name: "DeploymentEnvironmentsClient",
    service: DevCenter,
})
interface EnvironmentClientOperations {
    @convenientAPI(false)
    ListAllEnvironments is DevCenter.EnvironmentsOperations.ListAllEnvironments;
    @convenientAPI(false)
    ListEnvironments is DevCenter.EnvironmentsOperations.ListEnvironments;
    @convenientAPI(false)
    GetEnvironment is DevCenter.EnvironmentsOperations.GetEnvironment;
    @convenientAPI(false)
    CreateOrUpdateEnvironment is DevCenter.EnvironmentsOperations.CreateOrUpdateEnvironment;
    @convenientAPI(false)
    DeleteEnvironment is DevCenter.EnvironmentsOperations.DeleteEnvironment;
    @convenientAPI(false)
    ListCatalogs is DevCenter.EnvironmentsOperations.ListCatalogs;
    @convenientAPI(false)
    GetCatalog is DevCenter.EnvironmentsOperations.GetCatalog;
    @convenientAPI(false)
    ListEnvironmentDefinitions is DevCenter.EnvironmentsOperations.ListEnvironmentDefinitions;
    @convenientAPI(false)
    ListEnvironmentDefinitionsByCatalog is DevCenter.EnvironmentsOperations.ListEnvironmentDefinitionsByCatalog;
    @convenientAPI(false)
    GetEnvironmentDefinition is DevCenter.EnvironmentsOperations.GetEnvironmentDefinition;
    @convenientAPI(false)
    ListEnvironmentTypes is DevCenter.EnvironmentsOperations.ListEnvironmentTypes;
}
