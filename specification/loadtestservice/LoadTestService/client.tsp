import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Microsoft.LoadTestService;

@useDependency(APIVersions.v2022_11_01)
@useDependency(APIVersions.v2023_04_01_preview)
namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "LoadTestAdministrationClient",
  service: Microsoft.LoadTestService,
})
interface AdministrationOperations {
  createOrUpdateTest is LoadTestAdministration.createOrUpdateTest;
  createOrUpdateAppComponents is LoadTestAdministration.createOrUpdateAppComponents;
  createOrUpdateServerMetricsConfig is LoadTestAdministration.createOrUpdateServerMetricsConfig;
  getAppComponents is LoadTestAdministration.getAppComponents;
  getServerMetricsConfig is LoadTestAdministration.getServerMetricsConfig;
  getTest is LoadTestAdministration.getTest;
  getTestFile is LoadTestAdministration.getTestFile;
  listTestFiles is LoadTestAdministration.listTestFiles;
  listTests is LoadTestAdministration.listTests;
  #suppress "@azure-tools/typespec-azure-core/byos" "It is limiting for users to have storage first before creating a load test also it will be breaking change for us."
  @projectedName("python", "BeginUploadTestFile")
  uploadTestFile is LoadTestAdministration.uploadTestFile;
  deleteTestFile is LoadTestAdministration.deleteTestFile;
  deleteTest is LoadTestAdministration.deleteTest;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  name: "LoadTestRunClient",
  service: Microsoft.LoadTestService,
})
interface TestRunOperations {
  @projectedName("python", "BeginTestRun")
  createOrUpdateTestRun is LoadTestRun.createOrUpdateTestRun;
  createOrUpdateAppComponents is LoadTestRun.createOrUpdateAppComponents;
  createOrUpdateServerMetricsConfig is LoadTestRun.createOrUpdateServerMetricsConfig;
  deleteTestRun is LoadTestRun.deleteTestRun;
  getAppComponents is LoadTestRun.getAppComponents;
  getServerMetricsConfig is LoadTestRun.getServerMetricsConfig;
  getTestRun is LoadTestRun.getTestRun;
  getTestRunFile is LoadTestRun.getTestRunFile;
  listMetricDimensionValues is LoadTestRun.listMetricDimensionValues;
  @projectedName("python", "get_metric_definitions")
  @projectedName("java", "getMetricDefinitions")
  listMetricDefinitions is LoadTestRun.listMetricDefinitions;
  @projectedName("python", "get_metric_namespaces")
  @projectedName("java", "getMetricNamespaces")
  listMetricNamespaces is LoadTestRun.listMetricNamespaces;
  listMetrics is LoadTestRun.listMetrics;
  listTestRuns is LoadTestRun.listTestRuns;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id"
  stopTestRun is LoadTestRun.stop;
}
