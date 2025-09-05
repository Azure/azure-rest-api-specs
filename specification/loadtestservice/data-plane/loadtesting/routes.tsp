import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";
import "./models.testprofile.tsp";
import "./models.trigger.tsp";
import "./models.notificationrule.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.LoadTestService;

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Azure.Core.Foundations.ResourceBody.resource,
  "application/json",
  "body"
);
@@clientName(Azure.Core.Foundations.ResourceBody.resource, "body");

/**
 * Common path parameter for test run identifier used across TestRun APIs.
 */
model TestRunIdParam {
  /**
   * Unique name for the load test run, must contain only lower-case alphabetic,
   * numeric, underscore or hyphen characters.
   */
  @path
  @maxLength(50)
  @minLength(2)
  @pattern("^[a-z0-9_-]*$")
  testRunId: string;
}

@tag("Test")
interface LoadTestAdministration {
  @summary("Create a new test or update an existing test by providing the test Id.")
  @doc("Create a new test or update an existing test by providing the test Id.")
  createOrUpdateTest is StandardResourceOperations.ResourceCreateOrUpdate<Test>;

  @summary("Delete a test by its test Id.")
  @doc("Delete a test by its test Id.")
  deleteTest is StandardResourceOperations.ResourceDelete<Test>;

  @summary("Get load test details by test Id")
  @doc("Get load test details by test Id")
  getTest is StandardResourceOperations.ResourceRead<Test>;

  @summary("""
    Get all load tests by the fully qualified resource Id e.g
    subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName}.
    """)
  @doc("""
    Get all load tests by the fully qualified resource Id e.g
    subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName}.
    """)
  listTests is StandardResourceOperations.ResourceList<
    Test,
    ListQueryParametersTrait<ListTestQueryParams>
  >;

  @summary("Clone a load test.")
  @doc("""
    Clone the given test with optional overrides applied to the clone test.
    """)
  @pollingOperation(Operations.getStatus)
  @finalOperation(LoadTestAdministration.getTest)
  @added(APIVersions.v2025_03_01_preview)
  @action("clone")
  cloneTest is StandardResourceOperations.LongRunningResourceAction<
    Test,
    CloneTestRequest,
    never
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Our operation is not following the standard put behavior https://github.com/Azure/typespec-azure/issues/3743"
  #suppress "@azure-tools/typespec-azure-core/byos" "It is limiting for users to have storage first before creating a load test also it will be breaking change for us."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @summary("""
    Upload input file for a given test Id. File size can't be more than 50 MB.
    Existing file with same name for the given test will be overwritten. File
    should be provided in the request body as application/octet-stream.
    """)
  @doc("""
    Upload input file for a given test Id. File size can't be more than 50 MB.
    Existing file with same name for the given test will be overwritten. File
    should be provided in the request body as application/octet-stream.
    """)
  @route("/tests/{testId}/files/{fileName}")
  @put
  uploadTestFile is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/octet-stream";

      @doc("""
        Unique name for the load test, must contain only lower-case alphabetic,
        numeric, underscore or hyphen characters.
        """)
      @path
      @maxLength(50)
      @minLength(2)
      @pattern("^[a-z0-9_-]*$")
      testId: string;

      @doc("Unique name for test file with file extension like : App.jmx")
      @path
      fileName: string;

      @doc("File type")
      @query
      fileType?: FileType;

      @doc("The file content as application/octet-stream.")
      @bodyRoot
      body: bytes;
    },
    ResourceCreatedResponse<TestFileInfo>
  >;

  @summary("Get all the files that are associated with a test.")
  @doc("Get all the files that are associated with a test.")
  getTestFile is StandardResourceOperations.ResourceRead<TestFileInfo>;

  @summary("Delete file by the file name for a test")
  @doc("Delete file by the file name for a test")
  deleteTestFile is StandardResourceOperations.ResourceDelete<TestFileInfo>;

  @summary("Get all test files.")
  @doc("Get all test files.")
  listTestFiles is StandardResourceOperations.ResourceList<TestFileInfo>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Add an app component to a test.")
  @doc("Add an app component to a test by providing the resource Id, name and type.")
  @route("/tests/{testId}/app-components")
  @patch(#{ implicitOptionality: true })
  createOrUpdateAppComponents is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/merge-patch+json";

      @doc("""
        Unique name for the load test, must contain only lower-case alphabetic,
        numeric, underscore or hyphen characters.
        """)
      @path
      @maxLength(50)
      @minLength(2)
      @pattern("^[a-z0-9_-]*$")
      testId: string;

      @doc("App Component model.")
      @bodyRoot
      body: TestAppComponents;
    },
    ResourceCreatedOrOkResponse<TestAppComponents>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get associated app component (collection of azure resources) for the given test.")
  @doc("Get associated app component (collection of azure resources) for the given test.")
  @route("/tests/{testId}/app-components")
  @get
  getAppComponents is Azure.Core.Foundations.Operation<
    {
      @doc("""
        Unique name for the load test, must contain only lower-case alphabetic,
        numeric, underscore or hyphen characters.
        """)
      @path
      @maxLength(50)
      @minLength(2)
      @pattern("^[a-z0-9_-]*$")
      testId: string;
    },
    TestAppComponents
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Configure server metrics for a test")
  @doc("Configure server metrics for a test")
  @route("/tests/{testId}/server-metrics-config")
  @patch(#{ implicitOptionality: true })
  createOrUpdateServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/merge-patch+json";

      @doc("""
        Unique name for the load test, must contain only lower-case alphabetic,
        numeric, underscore or hyphen characters.
        """)
      @path
      @maxLength(50)
      @minLength(2)
      @pattern("^[a-z0-9_-]*$")
      testId: string;

      @doc("Server metric configuration model.")
      @bodyRoot
      body: TestServerMetricsConfiguration;
    },
    ResourceCreatedOrOkResponse<TestServerMetricsConfiguration>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("List server metrics configuration for the given test.")
  @doc("List server metrics configuration for the given test.")
  @route("/tests/{testId}/server-metrics-config")
  @get
  getServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      @doc("""
        Unique name for the load test, must contain only lower-case alphabetic,
        numeric, underscore or hyphen characters.
        """)
      @path
      @maxLength(50)
      @minLength(2)
      @pattern("^[a-z0-9_-]*$")
      testId: string;
    },
    TestServerMetricsConfiguration
  >;
}

@tag("TestRun")
interface LoadTestRun {
  @summary("Get test run details by test run Id.")
  @doc("Get test run details by test run Id.")
  getTestRun is StandardResourceOperations.ResourceRead<TestRun>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create and start a new test run with the given test run Id.")
  @doc("Create and start a new test run with the given test run Id.")
  createOrUpdateTestRun is StandardResourceOperations.ResourceCreateOrUpdate<
    TestRun,
    QueryParametersTrait<OldTestRunIdQueryParam>
  >;

  @summary("Delete an existing load test run.")
  @doc("Delete an existing load test run by providing the testRunId.")
  deleteTestRun is StandardResourceOperations.ResourceDelete<TestRun>;

  @summary("Get all test runs for the given filters.")
  @doc("Get all test runs for the given filters.")
  listTestRuns is StandardResourceOperations.ResourceList<
    TestRun,
    ListQueryParametersTrait<ListTestRunQueryParams>
  >;

  @summary("Get test run file by file name.")
  @doc("Get test run file by file name.")
  getTestRunFile is StandardResourceOperations.ResourceRead<TestRunFileInfo>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  @summary("Stop test run by test run Id.")
  @doc("Stop test run by test run Id.")
  @operationId("LoadTestRun_StopTestRun")
  stop is StandardResourceOperations.ResourceAction<TestRun, {}, TestRun, {}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get the latest insights for the test run.")
  @doc("Get the latest insights for the test run.")
  @added(APIVersions.v2025_03_01_preview)
  @route("/test-runs/{testRunId}/insights/latest")
  @get
  getLatestInsights is Azure.Core.Foundations.Operation<
    {
      ...TestRunIdParam;
    },
    TestRunInsights
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Generate insights for the test run.")
  @doc("Generate insights for the test run.")
  @pollingOperation(LoadTestRun.getLatestInsights)
  @added(APIVersions.v2025_03_01_preview)
  @route("/test-runs/{testRunId}/insights:generate")
  @post
  generateInsights is Azure.Core.Foundations.Operation<
    {
      ...TestRunIdParam;
    },
    {
      @statusCode statusCode: 202;
      @header("Operation-Location") operationLocation: url;
      @bodyRoot @added(APIVersions.v2025_03_01_preview) body: OperationStatus;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @summary("List the metric namespaces for a load test run.")
  @doc("List the metric namespaces for a load test run.")
  @route("/test-runs/{testRunId}/metric-namespaces")
  @get
  listMetricNamespaces is Azure.Core.Foundations.Operation<
    {
      ...TestRunIdParam;
    },
    MetricNamespaceCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @summary("List the metric definitions for a load test run.")
  @doc("List the metric definitions for a load test run.")
  @route("/test-runs/{testRunId}/metric-definitions")
  @get
  listMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      ...TestRunIdParam;

      @doc("Metric namespace to query metric definitions for.")
      @query
      metricNamespace: string;
    },
    MetricDefinitionCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("List the metric values for a load test run.")
  @doc("List the metric values for a load test run.")
  @route("/test-runs/{testRunId}/metrics")
  @post
  @list
  listMetrics is Azure.Core.Foundations.Operation<
    {
      ...TestRunIdParam;

      @doc("The aggregation")
      @query
      aggregation?: string;

      ...MetricDimensionsRequest;

      @doc("Metric dimension filter ")
      @bodyRoot
      body?: MetricRequestPayload;
    },
    Metrics
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @summary("List the dimension values for the given metric dimension name.")
  @doc("List the dimension values for the given metric dimension name.")
  @route("/test-runs/{testRunId}/metric-dimensions/{name}/values")
  @list
  listMetricDimensionValues is Azure.Core.Foundations.Operation<
    {
      ...TestRunIdParam;

      @doc("Dimension name")
      @path
      name: string;

      ...MetricDimensionsRequest;
    },
    DimensionValueList
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Add an app component to a test run.")
  @doc("Add an app component to a test run by providing the resource Id, name and type.")
  @route("/test-runs/{testRunId}/app-components")
  @patch(#{ implicitOptionality: true })
  createOrUpdateAppComponents is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/merge-patch+json";

      ...TestRunIdParam;

      @doc("App Component model.")
      @bodyRoot
      body: TestRunAppComponents;
    },
    ResourceCreatedOrOkResponse<TestRunAppComponents>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("""
    Get associated app component (collection of azure resources) for the given test
    run.
    """)
  @doc("""
    Get associated app component (collection of azure resources) for the given test
    run.
    """)
  @route("/test-runs/{testRunId}/app-components")
  @get
  getAppComponents is Azure.Core.Foundations.Operation<
    {
      ...TestRunIdParam;
    },
    TestRunAppComponents
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Configure server metrics for a test run")
  @doc("Configure server metrics for a test run")
  @route("/test-runs/{testRunId}/server-metrics-config")
  @patch(#{ implicitOptionality: true })
  createOrUpdateServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/merge-patch+json";

      ...TestRunIdParam;

      @doc("Server metric configuration model.")
      @bodyRoot
      body: TestRunServerMetricsConfiguration;
    },
    ResourceCreatedOrOkResponse<TestRunServerMetricsConfiguration>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get associated server metrics configuration for the given test run.")
  @doc("Get associated server metrics configuration for the given test run.")
  @route("/test-runs/{testRunId}/server-metrics-config")
  @get
  getServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      ...TestRunIdParam;
    },
    TestRunServerMetricsConfiguration
  >;
}

@tag("Operations")
interface Operations {
  @added(APIVersions.v2025_03_01_preview)
  @summary("Get the status of a long running operation.")
  @doc("Get the status of a long running operation.")
  getStatus is StandardResourceOperations.ResourceRead<OperationStatus>;
}

// NOTE(mitsha): In clients.tsp, when we use `op is <Op>` syntax, it removes all the decorators defined on the interface
// including the @added decorator and causes tsp compile client.tsp to fail. To handle this, @added is added at each operation level instead.
// Do the same whenever routes are added in a new API Version
@tag("TestProfile")
interface TestProfileAdministration {
  @summary("Create a new test profile or update an existing test profile.")
  @doc("Create a new test profile or update an existing test profile by providing the test profile Id.")
  @added(APIVersions.v2024_05_01_preview)
  createOrUpdateTestProfile is StandardResourceOperations.ResourceCreateOrUpdate<TestProfile>;

  @summary("Delete a test profile.")
  @doc("Delete a test profile by its test profile Id.")
  @added(APIVersions.v2024_05_01_preview)
  deleteTestProfile is StandardResourceOperations.ResourceDelete<TestProfile>;

  @summary("Get load test profile details.")
  @doc("Get load test profile details by test profile Id.")
  @added(APIVersions.v2024_05_01_preview)
  getTestProfile is StandardResourceOperations.ResourceRead<TestProfile>;

  @summary("List test profiles.")
  @doc("""
    Get all test profiles for the given filters.
    """)
  @added(APIVersions.v2024_05_01_preview)
  listTestProfiles is StandardResourceOperations.ResourceList<
    TestProfile,
    ListQueryParametersTrait<ListTestProfileQueryParams>
  >;
}

@tag("TestProfileRun")
interface TestProfileRunAdministration {
  @summary("Get test profile run details.")
  @doc("Get test profile run details by test profile run Id.")
  @added(APIVersions.v2024_05_01_preview)
  getTestProfileRun is StandardResourceOperations.ResourceRead<TestProfileRun>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create and start a new test profile run.")
  @doc("Create and start a new test profile run with the given test profile run Id.")
  @added(APIVersions.v2024_05_01_preview)
  createOrUpdateTestProfileRun is StandardResourceOperations.ResourceCreateOrUpdate<TestProfileRun>;

  @summary("Delete an existing load test profile run.")
  @doc("Delete an existing load test profile run by providing the test profile run Id.")
  @added(APIVersions.v2024_05_01_preview)
  deleteTestProfileRun is StandardResourceOperations.ResourceDelete<TestProfileRun>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  @summary("Stop test profile run.")
  @doc("Stop test profile run for the given test profile run Id.")
  @operationId("TestProfileRunAdministration_StopTestProfileRun")
  @added(APIVersions.v2024_05_01_preview)
  stop is StandardResourceOperations.ResourceAction<
    TestProfileRun,
    {},
    TestProfileRun,
    {}
  >;

  @summary("List test profile runs.")
  @doc("Get all test profile runs for the given filters.")
  @added(APIVersions.v2024_05_01_preview)
  listTestProfileRuns is StandardResourceOperations.ResourceList<
    TestProfileRun,
    ListQueryParametersTrait<ListTestProfileRunQueryParams>
  >;
}

@tag("Trigger")
@added(APIVersions.v2024_07_01_preview)
interface TriggerAdministration {
  getTrigger is StandardResourceOperations.ResourceRead<Trigger>;

  createOrUpdateTrigger is StandardResourceOperations.ResourceCreateOrUpdate<Trigger>;

  deleteTrigger is StandardResourceOperations.ResourceDelete<Trigger>;

  listTrigger is StandardResourceOperations.ResourceList<
    Trigger,
    ListQueryParametersTrait<ListTriggerQueryParams>
  >;
}

@tag("NotificationRule")
interface NotificationRuleAdministration {
  @added(APIVersions.v2024_12_01_preview)
  getNotificationRule is StandardResourceOperations.ResourceRead<NotificationRule>;

  @added(APIVersions.v2024_12_01_preview)
  createOrUpdateNotificationRule is StandardResourceOperations.ResourceCreateOrUpdate<NotificationRule>;

  @added(APIVersions.v2024_12_01_preview)
  deleteNotificationRule is StandardResourceOperations.ResourceDelete<NotificationRule>;

  @added(APIVersions.v2024_12_01_preview)
  listNotificationRule is StandardResourceOperations.ResourceList<
    NotificationRule,
    ListQueryParametersTrait<ListNotificationRuleQueryParams>
  >;
}
