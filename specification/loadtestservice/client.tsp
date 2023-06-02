import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using AzureLoadTesting;

@useDependency(APIVersions.v2022_11_01)
namespace Customizations;

@client({
    name: "LoadTestAdministrationClient",
    service: AzureLoadTesting,
})
interface AdministrationOperations {
    CreateOrUpdateTest is LoadTestAdministrationOperations.CreateOrUpdateTest;
    CreateOrUpdateAppComponents is LoadTestAdministrationOperations.CreateOrUpdateAppComponents;
    CreateOrUpdateServerMetricsConfig is LoadTestAdministrationOperations.CreateOrUpdateServerMetricsConfig;
    GetAppComponents is LoadTestAdministrationOperations.GetAppComponents;
    GetServerMetricsConfig is LoadTestAdministrationOperations.GetServerMetricsConfig;
    GetTest is LoadTestAdministrationOperations.GetTest;
    GetTestFile is LoadTestAdministrationOperations.GetTestFile;
    ListTestFiles is LoadTestAdministrationOperations.ListTestFiles;
    ListTests is LoadTestAdministrationOperations.ListTests;
    UploadTestFile is LoadTestAdministrationOperations.UploadTestFile;
    DeleteTestFile is LoadTestAdministrationOperations.DeleteTestFile;
    DeleteTest is LoadTestAdministrationOperations.DeleteTest;
};

@client({
    name: "LoadTestRunClient",
    service: AzureLoadTesting,
})
interface TestRunOperations {
    TestRun is LoadTestRunOperations.CreateOrUpdateTestRun;
    CreateOrUpdateAppComponents is LoadTestRunOperations.CreateOrUpdateAppComponents;
    CreateOrUpdateServerMetricsConfig is LoadTestRunOperations.CreateOrUpdateServerMetricsConfig;
    DeleteTestRun is LoadTestRunOperations.DeleteTestRun;
    GetAppComponents is LoadTestRunOperations.GetAppComponents;
    GetServerMetricsConfig is LoadTestRunOperations.GetServerMetricsConfig;
    GetTestRun is LoadTestRunOperations.GetTestRun;
    GetTestRunFile is LoadTestRunOperations.GetTestRunFile;
    ListMetricDefinitions is LoadTestRunOperations.ListMetricDefinitions;
    ListMetricNamespaces is LoadTestRunOperations.ListMetricNamespaces;
    ListMetrics is LoadTestRunOperations.ListMetrics;
    ListTestRuns is LoadTestRunOperations.ListTestRuns;
    StopTestRun is LoadTestRunOperations.StopTestRun;
};
