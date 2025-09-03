import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Microsoft.LoadTestService;

@useDependency(APIVersions.v2025_03_01_preview)
namespace Customizations;

// Client customizations should be kept in this file only and not in other files
// Model related customizations here (Ref: https://azure.github.io/typespec-azure/docs/howtos/DataPlane%20Generation%20-%20DPG/04renaming):
@@clientName(MetricDimensionsRequest.metricname, "metric_name", "python");
@@clientName(MetricDimensionsRequest.timespan, "time_interval", "python");

// Suggestion to rename TimeGrain to more user-friendly names
@@clientName(TimeGrain.PT5S, "FiveSeconds", "csharp,java");
@@clientName(TimeGrain.PT10S, "TenSeconds", "csharp,java");
@@clientName(TimeGrain.PT1M, "OneMinute", "csharp,java");
@@clientName(TimeGrain.PT5M, "FiveMinutes", "csharp,java");
@@clientName(TimeGrain.PT1H, "OneHour", "csharp,java");

// Suggestion to avoid `Type` as a property name since it can get confused with the `Type` keyword
@@clientName(Secret.type, "SecretKind", "csharp");
@@clientName(CertificateMetadata.type, "CertificateKind", "csharp");

// Suggestion to rename properties to not have abbreviations
@@clientName(LoadTestConfiguration.optionalLoadTestConfig,
  "optionalLoadTestConfiguration",
  "csharp,java"
);
@@clientName(LoadTestConfiguration.regionalLoadTestConfig,
  "regionalLoadTestConfiguration",
  "csharp,java"
);
@@clientName(TestInputArtifacts.userPropFileInfo,
  "userPropertyFileInfo",
  "csharp,java"
);
@@clientName(TestRunInputArtifacts.userPropFileInfo,
  "userPropertyFileInfo",
  "csharp,java"
);

// Suggestion to rename certain models to not have very generic names
@@clientName(Test, "LoadTest", "csharp,java");
@@clientName(TestRun, "LoadTestRun", "csharp,java");
@@clientName(TestKind, "LoadTestKind", "csharp,java");
@@clientName(Secret, "TestSecret", "csharp,java");
@@clientName(CertificateMetadata, "TestCertificate", "csharp,java");
@@clientName(ManagedIdentityType,
  "LoadTestingManagedIdentityType",
  "csharp,java"
);
@@clientName(FileType, "LoadTestingFileType", "csharp,java");
@@clientName(AppComponent, "LoadTestingAppComponent", "csharp,java");
@@clientName(MetricRequestPayload, "MetricsFilters", "csharp,java");
@@clientName(Aggregation, "AggregationType", "csharp,java");
@@clientName(MetricNamespaceCollection, "MetricNamespaces", "csharp,java");
@@clientName(MetricDefinitionCollection, "MetricDefinitions", "csharp,java");

// Suggestion to fix casing for acronyms
@@clientName(LoadTestConfiguration.splitAllCSVs,
  "splitAllCsvs",
  "csharp,java,python"
); // NOTE: Python is needed since the emitter bugs out for "CSVs" to cs_vs
@@clientName(Test.publicIPDisabled, "publicIpDisabled", "csharp,java");
@@clientName(TestRun.publicIPDisabled, "publicIpDisabled", "csharp,java");
@@clientName(PFMetrics, "PfMetrics", "csharp,java");

// Suggestion to rename properties in TestRunStatistics for better explanation
@@clientName(TestRunStatistics.errorPct, "errorPercentage", "csharp,java");
@@clientName(TestRunStatistics.meanResTime, "meanResponseTime", "csharp,java");
@@clientName(TestRunStatistics.medianResTime,
  "medianResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.maxResTime, "maxResponseTime", "csharp,java");
@@clientName(TestRunStatistics.minResTime, "minResponseTime", "csharp,java");
@@clientName(TestRunStatistics.pct75ResTime,
  "percentile75ResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.pct1ResTime,
  "percentile90ResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.pct2ResTime,
  "percentile95ResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.pct96ResTime,
  "percentile96ResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.pct97ResTime,
  "percentile97ResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.pct98ResTime,
  "percentile98ResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.pct3ResTime,
  "percentile99ResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.pct999ResTime,
  "percentile999ResponseTime",
  "csharp,java"
);
@@clientName(TestRunStatistics.pct9999ResTime,
  "percentile9999ResponseTime",
  "csharp,java"
);

// Suggestion to rename properties to better names
@@clientName(ArtifactsContainerInfo.expireDateTime, "expiresOn", "csharp,java");
@@clientName(FileInfo.expireDateTime, "expiresOn", "csharp,java");

// Suggestion to rename `Url` to `Uri` for csharp
@@clientName(FileInfo.url, "uri", "csharp");
@@clientName(ArtifactsContainerInfo.url, "uri", "csharp");
@@clientName(TestRun.portalUrl, "portalUri", "csharp");
@@clientName(OptionalLoadTestConfiguration.endpointUrl,
  "endpointUri",
  "csharp"
);

// Renames for properties that had unit of duration in name but will get converted to duration type
@@clientName(AutoStopCriteria.errorRateTimeWindowInSeconds,
  "errorRateTimeWindow",
  "csharp,java"
);

// Suggestion to change type to Uri for csharp
@@alternateType(TestRun.portalUrl, url, "csharp");
@@alternateType(OptionalLoadTestConfiguration.endpointUrl, url, "csharp");

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
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
  @clientName("BeginUploadTestFile", "python")
  @access(Access.internal, "python,csharp,java") // NOTE: These are overridden to LRO methods so original methods are made internal
  uploadTestFile is LoadTestAdministration.uploadTestFile;
  deleteTestFile is LoadTestAdministration.deleteTestFile;
  deleteTest is LoadTestAdministration.deleteTest;

  createOrUpdateTestProfile is TestProfileAdministration.createOrUpdateTestProfile;
  deleteTestProfile is TestProfileAdministration.deleteTestProfile;
  getTestProfile is TestProfileAdministration.getTestProfile;
  listTestProfiles is TestProfileAdministration.listTestProfiles;

  createOrUpdateTrigger is TriggerAdministration.createOrUpdateTrigger;
  deleteTrigger is TriggerAdministration.deleteTrigger;
  getTrigger is TriggerAdministration.getTrigger;
  listTriggers is TriggerAdministration.listTrigger;

  createOrUpdateNotificationRule is NotificationRuleAdministration.createOrUpdateNotificationRule;
  deleteNotificationRule is NotificationRuleAdministration.deleteNotificationRule;
  getNotificationRule is NotificationRuleAdministration.getNotificationRule;
  listNotificationRules is NotificationRuleAdministration.listNotificationRule;

  @action("clone")
  cloneTest is LoadTestAdministration.cloneTest;

  getOperationStatus is Operations.getStatus;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@client({
  name: "LoadTestRunClient",
  service: Microsoft.LoadTestService,
})
interface TestRunOperations {
  // NOTE(mitsha): Access for begin_test_run and begin_test_profile_run is made internal in Python
  // so that the non LRO overloads can be hidden in the generated SDK
  @clientName("begin_test_run", "python")
  @access(Access.internal, "python,csharp,java") // NOTE: These are overridden to LRO methods so original methods are made internal
  createOrUpdateTestRun is LoadTestRun.createOrUpdateTestRun;
  createOrUpdateAppComponents is LoadTestRun.createOrUpdateAppComponents;
  createOrUpdateServerMetricsConfig is LoadTestRun.createOrUpdateServerMetricsConfig;
  deleteTestRun is LoadTestRun.deleteTestRun;
  getAppComponents is LoadTestRun.getAppComponents;
  getServerMetricsConfig is LoadTestRun.getServerMetricsConfig;
  getTestRun is LoadTestRun.getTestRun;
  getTestRunFile is LoadTestRun.getTestRunFile;
  listMetricDimensionValues is LoadTestRun.listMetricDimensionValues;
  @clientName("get_metric_definitions", "python")
  @clientName("getMetricDefinitions", "java")
  listMetricDefinitions is LoadTestRun.listMetricDefinitions;
  @clientName("get_metric_namespaces", "python")
  @clientName("getMetricNamespaces", "java")
  listMetricNamespaces is LoadTestRun.listMetricNamespaces;
  listMetrics is LoadTestRun.listMetrics;
  listTestRuns is LoadTestRun.listTestRuns;
  @clientName("stopTestRun", "javascript,python,java,csharp,go")
  stop is LoadTestRun.stop;

  @clientName("begin_test_profile_run", "python")
  @access(Access.internal, "python,csharp,java") // NOTE: These are overridden to LRO methods so original methods are made internal
  createOrUpdateTestProfileRun is TestProfileRunAdministration.createOrUpdateTestProfileRun;
  deleteTestProfileRun is TestProfileRunAdministration.deleteTestProfileRun;
  getTestProfileRun is TestProfileRunAdministration.getTestProfileRun;
  listTestProfileRuns is TestProfileRunAdministration.listTestProfileRuns;
  @clientName("stopTestProfileRun", "javascript,python,java,csharp,go")
  @action("stop")
  stopTestProfileRun is TestProfileRunAdministration.stop;

  getLatestTestRunInsights is LoadTestRun.getLatestInsights;
  generateTestRunInsights is LoadTestRun.generateInsights;
}
