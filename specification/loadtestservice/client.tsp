import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureLoadTesting;

namespace Customizations;

@client({
    name: "LoadTestAdministrationClient",
    service: AzureLoadTesting,
})
interface LoadTestAdministrationOperations {
    DeleteTest is LoadTestAdministrationOperations.DeleteTest;
};

@client({
    name: "LoadTestRunClient",
    service: AzureLoadTesting,
})
interface LoadTestRunOperations {
    CreateOrUpdateTestRun is LoadTestRunOperations.CreateOrUpdateTestRun;
};