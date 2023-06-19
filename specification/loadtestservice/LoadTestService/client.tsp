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

@@projectedName(AzureLoadTesting.LoadTestAdministration.CreateOrUpdateTest,"json", "Test_CreateOrUpdate")
@@projectedName(AzureLoadTesting.LoadTestAdministration.DeleteTest,"json", "Test_Delete")
@@projectedName(AzureLoadTesting.LoadTestAdministration.GetTest,"json", "Test_Get")
@@projectedName(AzureLoadTesting.LoadTestAdministration.ListTests, "json", "Test_List")
@@projectedName(AzureLoadTesting.LoadTestAdministration.UploadTestFile, "json", "Test_UploadFile")
@@projectedName(AzureLoadTesting.LoadTestAdministration.GetTestFile, "json", "Test_GetFile")
@@projectedName(AzureLoadTesting.LoadTestAdministration.DeleteTestFile, "json", "Test_DeleteFile")
@@projectedName(AzureLoadTesting.LoadTestAdministration.ListTestFiles, "json", "Test_ListFiles")
@@projectedName(AzureLoadTesting.LoadTestAdministration.CreateOrUpdateAppComponents,"json", "Test_CreateOrUpdateAppComponents")
@@projectedName(AzureLoadTesting.LoadTestAdministration.GetAppComponents, "json", "Test_ListAppComponents")
@@projectedName(AzureLoadTesting.LoadTestAdministration.CreateOrUpdateServerMetricsConfig,"json", "Test_CreateOrUpdateServerMetricsConfig")
@@projectedName(AzureLoadTesting.LoadTestAdministration.GetServerMetricsConfig, "json", "Test_ListServerMetricsConfig")
@@projectedName(AzureLoadTesting.LoadTestRun.DeleteTestRun,"json", "TestRun_Delete")
@@projectedName(AzureLoadTesting.LoadTestRun.CreateOrUpdateTestRun,"json", "TestRun_CreateOrUpdate")
@@projectedName(AzureLoadTesting.LoadTestRun.GetTestRun,"json", "TestRun_Get")
@@projectedName(AzureLoadTesting.LoadTestRun.GetTestRunFile,"json", "TestRun_GetFile")
@@projectedName(AzureLoadTesting.LoadTestRun.ListTestRuns,"json", "TestRun_List")
@@projectedName(AzureLoadTesting.LoadTestRun.StopTestRun,"json", "TestRun_Stop")
@@projectedName(AzureLoadTesting.LoadTestRun.ListMetricNamespaces,"json", "TestRun_ListMetricNamespaces")
@@projectedName(AzureLoadTesting.LoadTestRun.ListMetricDefinitions,"json", "TestRun_ListMetricDefinitions")
@@projectedName(AzureLoadTesting.LoadTestRun.ListMetrics,"json", "TestRun_ListMetrics")
@@projectedName(AzureLoadTesting.LoadTestRun.ListMetricDimensionValues,"json", "TestRun_ListMetricDimensionValues")
@@projectedName(AzureLoadTesting.LoadTestRun.CreateOrUpdateAppComponents,"json", "TestRun_CreateOrUpdateAppComponents")
@@projectedName(AzureLoadTesting.LoadTestRun.GetAppComponents,"json", "TestRun_ListAppComponents")
@@projectedName(AzureLoadTesting.LoadTestRun.CreateOrUpdateServerMetricsConfig,"json", "TestRun_CreateOrUpdateServerMetricsConfig")
@@projectedName(AzureLoadTesting.LoadTestRun.GetServerMetricsConfig,"json", "TestRun_ListServerMetricsConfig")
