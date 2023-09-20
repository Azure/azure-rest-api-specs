import "./main.tsp";
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
interface EnvironmentClientOperations extends DevCenter.EnvironmentsOperations{
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
