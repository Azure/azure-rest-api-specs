import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
import "@azure-tools/typespec-autorest";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Autorest;
using OpenAPI;

namespace Microsoft.LoadTestService;

@tag("Test")
interface LoadTestAdministration {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create a new test or update an existing test by providing the test Id.")
  @doc("Create a new test or update an existing test by providing the test Id.")
  @route("/tests/{testId}")
  @patch
  createOrUpdateTest is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/merge-patch+json";

      @doc("""
Unique Id for the load test, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testId: string;

      @doc("Load test model")
      @body
      body: Test;
    },
    ResourceCreatedOrOkResponse<Test>
  >;

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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/byos" //It is limiting for users to have storage first before creating a load test also it will be breaking change for us.
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
      testId: string;

      @doc("Unique name for test file with file extension like : App.jmx")
      @path
      fileName: string;

      @doc("File type")
      @query
      fileType?: FileType;

      @doc("The file content as application/octet-stream.")
      @body
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
  @patch
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
      testId: string;

      @doc("App Component model.")
      @body
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
      testId: string;
    },
    TestAppComponents
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Configure server metrics for a test")
  @doc("Configure server metrics for a test")
  @route("/tests/{testId}/server-metrics-config")
  @patch
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
      testId: string;

      @doc("Server metric configuration model.")
      @body
      body: TestServerMetricConfig;
    },
    ResourceCreatedOrOkResponse<TestServerMetricConfig>
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
      testId: string;
    },
    TestServerMetricConfig
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
  @route("/test-runs/{testRunId}")
  @patch
  createOrUpdateTestRun is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/merge-patch+json";

      @doc("""
Unique Id for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;

      @doc("""
Existing test run identifier that should be rerun, if this is provided, the
test will run with the JMX file, configuration and app components from the
existing test run. You can override the configuration values for new test run
in the request body.
""")
      @query
      oldTestRunId?: string;

      @doc("Load test run model")
      @body
      body: TestRun;
    },
    ResourceCreatedOrOkResponse<TestRun>
  >;

  @summary("Delete an existing load test run.")
  @doc("Delete an existing load test run by providing the testId.")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id"
  @summary("Stop test run by test run Id.")
  @doc("Stop test run by test run Id.")
  @example("./examples/StopTestRun.json", "Stop test run by name.")
  @operationId("LoadTestRun_StopTestRun")
  stop is StandardResourceOperations.ResourceAction<TestRun, {}, TestRun, {}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("List the metric namespaces for a load test run.")
  @doc("List the metric namespaces for a load test run.")
  @route("/test-runs/{testRunId}/metric-namespaces")
  @get
  listMetricNamespaces is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;
    },
    MetricNamespaceCollection
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("List the metric definitions for a load test run.")
  @doc("List the metric definitions for a load test run.")
  @route("/test-runs/{testRunId}/metric-definitions")
  @get
  listMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;

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
  listMetrics is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;

      @doc("The aggregation")
      @query
      aggregation?: string;

      ...MetricDimensionsRequest;

      @doc("Metric dimension filter ")
      @body
      body?: MetricRequestPayload;
    },
    Metrics
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("List the dimension values for the given metric dimension name.")
  @doc("List the dimension values for the given metric dimension name.")
  @route("/test-runs/{testRunId}/metric-dimensions/{name}/values")
  listMetricDimensionValues is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;

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
  @patch
  createOrUpdateAppComponents is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/merge-patch+json";

      @doc("""
Unique Id for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;

      @doc("App Component model.")
      @body
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
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;
    },
    TestRunAppComponents
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Configure server metrics for a test run")
  @doc("Configure server metrics for a test run")
  @route("/test-runs/{testRunId}/server-metrics-config")
  @patch
  createOrUpdateServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("Content type.")
      contentType: "application/merge-patch+json";

      @doc("""
Unique Id for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;

      @doc("Server metric configuration model.")
      @body
      body: TestRunServerMetricConfig;
    },
    ResourceCreatedOrOkResponse<TestRunServerMetricConfig>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get associated server metrics configuration for the given test run.")
  @doc("Get associated server metrics configuration for the given test run.")
  @route("/test-runs/{testRunId}/server-metrics-config")
  @get
  getServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;
    },
    TestRunServerMetricConfig
  >;
}
