import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Microsoft.LoadTestService;

@useDependency(APIVersions.v2022_11_01)
@useDependency(APIVersions.v2023_04_01_preview)
namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@client({
    name: "LoadTestAdministrationClient",
    service: Microsoft.LoadTestService,
})
interface AdministrationOperations {
    CreateOrUpdateTest is LoadTestAdministration.createOrUpdateTest;
    CreateOrUpdateAppComponents is LoadTestAdministration.createOrUpdateAppComponents;
    CreateOrUpdateServerMetricsConfig is LoadTestAdministration.createOrUpdateServerMetricsConfig;
    GetAppComponents is LoadTestAdministration.getAppComponents;
    GetServerMetricsConfig is LoadTestAdministration.getServerMetricsConfig;
    GetTest is LoadTestAdministration.getTest;
    GetTestFile is LoadTestAdministration.getTestFile;
    ListTestFiles is LoadTestAdministration.listTestFiles;
    ListTests is LoadTestAdministration.listTests;
    #suppress "@azure-tools/typespec-azure-core/byos"
    @projectedName("python", "BeginUploadTestFile")
    UploadTestFile is LoadTestAdministration.uploadTestFile;
    DeleteTestFile is LoadTestAdministration.deleteTestFile;
    DeleteTest is LoadTestAdministration.deleteTest;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@client({
    name: "LoadTestRunClient",
    service: Microsoft.LoadTestService,
})
interface TestRunOperations {
    // TODO check with service team why is Python different here?
    @projectedName("python", "BeginTestRun")
    CreateOrUpdateTestRun is LoadTestRun.createOrUpdateTestRun;
    CreateOrUpdateAppComponents is LoadTestRun.createOrUpdateAppComponents;
    CreateOrUpdateServerMetricsConfig is LoadTestRun.createOrUpdateServerMetricsConfig;
    DeleteTestRun is LoadTestRun.deleteTestRun;
    GetAppComponents is LoadTestRun.getAppComponents;
    GetServerMetricsConfig is LoadTestRun.getServerMetricsConfig;
    GetTestRun is LoadTestRun.getTestRun;
    GetTestRunFile is LoadTestRun.getTestRunFile;
    ListMetricDimensionValues is LoadTestRun.listMetricDimensionValues;
    @projectedName("python", "get_metric_definitions")
    @projectedName("java", "getMetricDefinitions")
    ListMetricDefinitions is LoadTestRun.listMetricDefinitions;
    @projectedName("python", "get_metric_namespaces")
    @projectedName("java", "getMetricNamespaces")
    ListMetricNamespaces is LoadTestRun.listMetricNamespaces;
    ListMetrics is LoadTestRun.listMetrics;
    ListTestRuns is LoadTestRun.listTestRuns;
    StopTestRun is LoadTestRun.stop;
};
