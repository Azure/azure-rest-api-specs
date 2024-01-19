import "./service.tsp";
import "./environments/routes.tsp";
import "./devcenter/routes.tsp";
import "./devbox/routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Versioning;
using DevCenterService;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@useDependency(APIVersions.v2023_04_01)
@client({
    name: "DevCenterClient",
    service: DevCenterService,
})
namespace SDKCustomizations;

interface DevCenterClientOperations {
    
    //DevCenters
    ListProjects is DevCenterService.DevCenterOperations.ListProjects;
    GetProject is DevCenterService.DevCenterOperations.GetProject;
 
    //DevBoxes 
    ListPools is DevCenterService.DevBoxesOperations.ListPools;
    GetPool is DevCenterService.DevBoxesOperations.GetPool;
    ListSchedules is DevCenterService.DevBoxesOperations.ListSchedules;
    GetSchedule is DevCenterService.DevBoxesOperations.GetSchedule;
    ListAllDevBoxes is DevCenterService.DevBoxesDevCenterOperations.ListAllDevBoxes;
    ListAllDevBoxesByUser is DevCenterService.DevBoxesDevCenterOperations.ListAllDevBoxesByUser;
    ListDevBoxes is DevCenterService.DevBoxesOperations.ListDevBoxes;
    GetDevBox is DevCenterService.DevBoxesOperations.GetDevBox;
    CreateDevBox is DevCenterService.DevBoxesOperations.CreateDevBox;
    DeleteDevBox is DevCenterService.DevBoxesOperations.DeleteDevBox;
    StartDevBox is DevCenterService.DevBoxesOperations.StartDevBox;
    StopDevBox is DevCenterService.DevBoxesOperations.StopDevBox;
    RestartDevBox is DevCenterService.DevBoxesOperations.RestartDevBox;
    GetRemoteConnection is DevCenterService.DevBoxesOperations.GetRemoteConnection;
    ListDevBoxActions is DevCenterService.DevBoxesOperations.ListDevBoxActions;
    GetDevBoxAction is DevCenterService.DevBoxesOperations.GetDevBoxAction;
    SkipDevBoxAction is DevCenterService.DevBoxesOperations.SkipAction;
    DelayDevBoxAction is DevCenterService.DevBoxesOperations.DelayAction;
    DelayAllDevBoxActions is DevCenterService.DevBoxesOperations.DelayAllActions;

    //Environments
    ListAllEnvironments is DevCenterService.EnvironmentsOperations.ListAllEnvironments;
    ListEnvironments is DevCenterService.EnvironmentsOperations.ListEnvironments;
    GetEnvironment is DevCenterService.EnvironmentsOperations.GetEnvironment;
    CreateOrUpdateEnvironment is DevCenterService.EnvironmentsOperations.CreateOrUpdateEnvironment;
    DeleteEnvironment is DevCenterService.EnvironmentsOperations.DeleteEnvironment;
    ListCatalogs is DevCenterService.EnvironmentsOperations.ListCatalogs;
    GetCatalog is DevCenterService.EnvironmentsOperations.GetCatalog;
    ListEnvironmentDefinitions is DevCenterService.EnvironmentsOperations.ListEnvironmentDefinitions;
    ListEnvironmentDefinitionsByCatalog is DevCenterService.EnvironmentsOperations.ListEnvironmentDefinitionsByCatalog;
    GetEnvironmentDefinition is DevCenterService.EnvironmentsOperations.GetEnvironmentDefinition;
    ListEnvironmentTypes is DevCenterService.EnvironmentsOperations.ListEnvironmentTypes;
}