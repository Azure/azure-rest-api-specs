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
    name: "EnvironmentsClient",
    service: DevCenter,
})
interface EnvironmentClientOperations {//extends DevCenter.EnvironmentsOperations{
    ListEnvironments is DevCenter.EnvironmentsOperations.ListEnvironments;
    ListEnvironmentsByUser is DevCenter.EnvironmentsOperations.ListEnvironmentsByUser;
    GetEnvironmentByUser is DevCenter.EnvironmentsOperations.GetEnvironmentByUser;
    CreateOrReplaceEnvironment is DevCenter.EnvironmentsOperations.CreateOrReplaceEnvironment;
    DeleteEnvironment is DevCenter.EnvironmentsOperations.DeleteEnvironment;
    ListCatalogsByProject is DevCenter.EnvironmentsOperations.ListCatalogsByProject;
    GetCatalog is DevCenter.EnvironmentsOperations.GetCatalog;
    ListEnvironmentDefinitionsByProject is DevCenter.EnvironmentsOperations.ListEnvironmentDefinitionsByProject;
    ListEnvironmentDefinitionsByCatalog is DevCenter.EnvironmentsOperations.ListEnvironmentDefinitionsByCatalog;
    GetEnvironmentDefinition is DevCenter.EnvironmentsOperations.GetEnvironmentDefinition;
    ListEnvironmentTypes is DevCenter.EnvironmentsOperations.ListEnvironmentTypes;
}

@client({
    name: "DevCenterClient",
    service: DevCenter,
})
interface DevCenterClientOperations extends DevCenter.DevCenterOperations{
    ListAllDevBoxes is DevCenter.DevBoxesDevCenterOperations.ListAllDevBoxes;
    ListAllDevBoxesByUser is DevCenter.DevBoxesDevCenterOperations.ListAllDevBoxesByUser;
}

@client({
    name: "DevBoxesClient",
    service: DevCenter,
})
interface DevBoxesClientOperations extends DevCenter.DevBoxesOperations{
}
