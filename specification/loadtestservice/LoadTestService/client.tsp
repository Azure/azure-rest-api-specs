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
    CreateOrUpdateTest is LoadTestAdministration.CreateOrUpdateTest;
    CreateOrUpdateAppComponents is LoadTestAdministration.CreateOrUpdateAppComponents;
    CreateOrUpdateServerMetricsConfig is LoadTestAdministration.CreateOrUpdateServerMetricsConfig;
    GetAppComponents is LoadTestAdministration.GetAppComponents;
    GetServerMetricsConfig is LoadTestAdministration.GetServerMetricsConfig;
    GetTest is LoadTestAdministration.GetTest;
    GetTestFile is LoadTestAdministration.GetTestFile;
    ListTestFiles is LoadTestAdministration.ListTestFiles;
    ListTests is LoadTestAdministration.ListTests;
    UploadTestFile is LoadTestAdministration.UploadTestFile;
    DeleteTestFile is LoadTestAdministration.DeleteTestFile;
    DeleteTest is LoadTestAdministration.DeleteTest;
};

@client({
    name: "LoadTestRunClient",
    service: AzureLoadTesting,
})
interface TestRunOperations {
    TestRun is LoadTestRun.CreateOrUpdateTestRun;
    CreateOrUpdateAppComponents is LoadTestRun.CreateOrUpdateAppComponents;
    CreateOrUpdateServerMetricsConfig is LoadTestRun.CreateOrUpdateServerMetricsConfig;
    DeleteTestRun is LoadTestRun.DeleteTestRun;
    GetAppComponents is LoadTestRun.GetAppComponents;
    GetServerMetricsConfig is LoadTestRun.GetServerMetricsConfig;
    GetTestRun is LoadTestRun.GetTestRun;
    GetTestRunFile is LoadTestRun.GetTestRunFile;
    ListMetricDimensionValues is LoadTestRun.ListMetricDimensionValues;
    ListMetricDefinitions is LoadTestRun.ListMetricDefinitions;
    ListMetricNamespaces is LoadTestRun.ListMetricNamespaces;
    ListMetrics is LoadTestRun.ListMetrics;
    ListTestRuns is LoadTestRun.ListTestRuns;
    StopTestRun is LoadTestRun.StopTestRun;
};
