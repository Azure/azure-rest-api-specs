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
@client({
    name: "DevCenterClient",
    service: DevCenterService,
})
namespace SDKCustomizations;

interface DevCenterClientOperations {
    
    //DevCenters
    @convenientAPI(false)
    ListProjects is DevCenterService.DevCenterOperations.ListProjects;
    @convenientAPI(false)
    GetProject is DevCenterService.DevCenterOperations.GetProject;
 
    //DevBoxes 
    @convenientAPI(false)
    ListPools is DevCenterService.DevBoxesOperations.ListPools;
    @convenientAPI(false)
    GetPool is DevCenterService.DevBoxesOperations.GetPool;
    @convenientAPI(false)
    ListSchedules is DevCenterService.DevBoxesOperations.ListSchedules;
    @convenientAPI(false)
    GetSchedule is DevCenterService.DevBoxesOperations.GetSchedule;
    @convenientAPI(false)
    ListAllDevBoxes is DevCenterService.DevBoxesDevCenterOperations.ListAllDevBoxes;
    @convenientAPI(false)
    ListAllDevBoxesByUser is DevCenterService.DevBoxesDevCenterOperations.ListAllDevBoxesByUser;
    @convenientAPI(false)
    ListDevBoxes is DevCenterService.DevBoxesOperations.ListDevBoxes;
    @convenientAPI(false)
    GetDevBox is DevCenterService.DevBoxesOperations.GetDevBox;
    @convenientAPI(false)
    CreateDevBox is DevCenterService.DevBoxesOperations.CreateDevBox;
    @convenientAPI(false)
    DeleteDevBox is DevCenterService.DevBoxesOperations.DeleteDevBox;
    @convenientAPI(false)
    StartDevBox is DevCenterService.DevBoxesOperations.StartDevBox;
    @convenientAPI(false)
    StopDevBox is DevCenterService.DevBoxesOperations.StopDevBox;
    @convenientAPI(false)
    RestartDevBox is DevCenterService.DevBoxesOperations.RestartDevBox;
    @convenientAPI(false)
    GetRemoteConnection is DevCenterService.DevBoxesOperations.GetRemoteConnection;
    @convenientAPI(false)
    ListDevBoxActions is DevCenterService.DevBoxesOperations.ListDevBoxActions;
    @convenientAPI(false)
    GetDevBoxAction is DevCenterService.DevBoxesOperations.GetDevBoxAction;
    @convenientAPI(false)
    SkipDevBoxAction is DevCenterService.DevBoxesOperations.SkipAction;
    @convenientAPI(false)
    DelayDevBoxAction is DevCenterService.DevBoxesOperations.DelayAction;
    @convenientAPI(false)
    DelayAllDevBoxActions is DevCenterService.DevBoxesOperations.DelayAllActions;

    //Environments
    @convenientAPI(false)
    ListAllEnvironments is DevCenterService.EnvironmentsOperations.ListAllEnvironments;
    @convenientAPI(false)
    ListEnvironments is DevCenterService.EnvironmentsOperations.ListEnvironments;
    @convenientAPI(false)
    GetEnvironment is DevCenterService.EnvironmentsOperations.GetEnvironment;
    @convenientAPI(false)
    CreateOrUpdateEnvironment is DevCenterService.EnvironmentsOperations.CreateOrUpdateEnvironment;
    @convenientAPI(false)
    DeleteEnvironment is DevCenterService.EnvironmentsOperations.DeleteEnvironment;
    @convenientAPI(false)
    ListCatalogs is DevCenterService.EnvironmentsOperations.ListCatalogs;
    @convenientAPI(false)
    GetCatalog is DevCenterService.EnvironmentsOperations.GetCatalog;
    @convenientAPI(false)
    ListEnvironmentDefinitions is DevCenterService.EnvironmentsOperations.ListEnvironmentDefinitions;
    @convenientAPI(false)
    ListEnvironmentDefinitionsByCatalog is DevCenterService.EnvironmentsOperations.ListEnvironmentDefinitionsByCatalog;
    @convenientAPI(false)
    GetEnvironmentDefinition is DevCenterService.EnvironmentsOperations.GetEnvironmentDefinition;
    @convenientAPI(false)
    ListEnvironmentTypes is DevCenterService.EnvironmentsOperations.ListEnvironmentTypes;
}