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
    ListSchedulesByPool is DevCenter.DevBoxesOperations.ListSchedulesByPool;
    @convenientAPI(false)
    GetScheduleByPool is DevCenter.DevBoxesOperations.GetScheduleByPool;
    @convenientAPI(false)
    ListDevBoxesByUser is DevCenter.DevBoxesOperations.ListDevBoxesByUser;
    @convenientAPI(false)
    GetDevBoxByUser is DevCenter.DevBoxesOperations.GetDevBoxByUser;
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
    DelayActions is DevCenter.DevBoxesOperations.DelayActions;
}

@client({
    name: "DeploymentEnvironmentsClient",
    service: DevCenter,
})
interface EnvironmentClientOperations {
    @convenientAPI(false)
    ListEnvironments is DevCenter.EnvironmentsOperations.ListEnvironments;
    @convenientAPI(false)
    ListEnvironmentsByUser is DevCenter.EnvironmentsOperations.ListEnvironmentsByUser;
    @convenientAPI(false)
    GetEnvironmentByUser is DevCenter.EnvironmentsOperations.GetEnvironmentByUser;
    @convenientAPI(false)
    CreateOrReplaceEnvironment is DevCenter.EnvironmentsOperations.CreateOrReplaceEnvironment;
    @convenientAPI(false)
    DeleteEnvironment is DevCenter.EnvironmentsOperations.DeleteEnvironment;
    @convenientAPI(false)
    ListCatalogsByProject is DevCenter.EnvironmentsOperations.ListCatalogsByProject;
    @convenientAPI(false)
    GetCatalog is DevCenter.EnvironmentsOperations.GetCatalog;
    @convenientAPI(false)
    ListEnvironmentDefinitionsByProject is DevCenter.EnvironmentsOperations.ListEnvironmentDefinitionsByProject;
    @convenientAPI(false)
    ListEnvironmentDefinitionsByCatalog is DevCenter.EnvironmentsOperations.ListEnvironmentDefinitionsByCatalog;
    @convenientAPI(false)
    GetEnvironmentDefinition is DevCenter.EnvironmentsOperations.GetEnvironmentDefinition;
    @convenientAPI(false)
    ListEnvironmentTypes is DevCenter.EnvironmentsOperations.ListEnvironmentTypes;
}
