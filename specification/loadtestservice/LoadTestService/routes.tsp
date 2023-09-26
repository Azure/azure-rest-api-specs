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
  @summary("Create a new test or update an existing test.")
  @doc("Create a new test or update an existing test.")
  @route("/tests/{testId}")
  @patch
  @example("./examples/CreateOrUpdateTest.json", "CreateOrUpdateTest")
  createOrUpdateTest is Azure.Core.Foundations.Operation<
    {
      @header 
      @doc("Content type.")
      contentType: "application/merge-patch+json",

      @doc("""
Unique name for the load test, must contain only lower-case alphabetic,
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

  @summary("Delete a test by its name.")
  @doc("Delete a test by its name.")
  @example("./examples/DeleteTest.json", "DeleteTest")
  deleteTest is StandardResourceOperations.ResourceDelete<Test>;

  @summary("Get load test details by test name")
  @doc("Get load test details by test name")
  @example("./examples/GetTest.json", "GetTest")
  getTest is StandardResourceOperations.ResourceRead<Test>;

  @summary("""
Get all load tests by the fully qualified resource Id e.g
subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName}.
""")
  @doc("""
Get all load tests by the fully qualified resource Id e.g
subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName}.
""")
  @example("./examples/ListTests.json", "ListTests")
  listTests is StandardResourceOperations.ResourceList<Test>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/byos"  //It is limiting for users to have storage first before creating a load test also it will be breaking change for us.
  @summary("""
Upload input file for a given test name. File size can't be more than 50 MB.
Existing file with same name for the given test will be overwritten. File
should be provided in the request body as application/octet-stream.
""")
  @doc("""
Upload input file for a given test name. File size can't be more than 50 MB.
Existing file with same name for the given test will be overwritten. File
should be provided in the request body as application/octet-stream.
""")
  @route("/tests/{testId}/files/{fileName}")
  @example("./examples/UploadTestFile.json", "UploadTestFile")
  @put
  uploadTestFile is Azure.Core.Foundations.Operation<
    {
      @header 
      @doc("Content type.")
      contentType: "application/octet-stream",
      
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

  @summary("Get test file by the file name.")
  @doc("Get test file by the file name.")
  @example("./examples/GetTestFile.json", "GetTestFile")
  getTestFile is StandardResourceOperations.ResourceRead<TestFileInfo>;

  @summary("Delete file by the file name for a test")
  @doc("Delete file by the file name for a test")
  @example("./examples/DeleteTestFile.json", "DeleteTestFile")
  deleteTestFile is StandardResourceOperations.ResourceDelete<TestFileInfo>;

  @summary("Get all test files.")
  @doc("Get all test files.")
  @example("./examples/ListTestFiles.json", "ListTestFiles")
  listTestFiles is StandardResourceOperations.ResourceList<TestFileInfo>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Associate an app component (collection of azure resources) to a test")
  @doc("Associate an app component (collection of azure resources) to a test")
  @route("/tests/{testId}/app-components")
  @patch
  @example("./examples/CreateOrUpdateTestAppComponents.json", "CreateOrUpdateTestAppComponents")
  createOrUpdateAppComponents is Azure.Core.Foundations.Operation<
    {
      @header 
      @doc("Content type.")
      contentType: "application/merge-patch+json",

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
  @example("./examples/ListTestAppComponents.json", "ListTestAppComponents")
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
  @example("./examples/CreateOrUpdateTestServerMetricsConfig.json", "CreateOrUpdateTestServerMetricsConfig")
  createOrUpdateServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      @header 
      @doc("Content type.")
      contentType: "application/merge-patch+json",
      
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
  @example("./examples/ListTestServerMetricsConfig.json", "ListTestServerMetricsConfig")
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
  @summary("Get test run details by name.")
  @doc("Get test run details by name.")
  @example("./examples/GetTestRun.json", "GetTestRun")
  getTestRun is StandardResourceOperations.ResourceRead<TestRun>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create and start a new test run with the given name.")
  @doc("Create and start a new test run with the given name.")
  @route("/test-runs/{testRunId}")
  @patch
  @example("./examples/CreateOrUpdateTestRun.json", "CreateOrUpdateTestRun")
  createOrUpdateTestRun is Azure.Core.Foundations.Operation<
    {
      @header 
      @doc("Content type.")
      contentType: "application/merge-patch+json",

      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
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

  @summary("Delete a test run by its name.")
  @doc("Delete a test run by its name.")
  @example("./examples/DeleteTestRun.json", "DeleteTestRun")
  deleteTestRun is StandardResourceOperations.ResourceDelete<TestRun>;

  @summary("Get test run file by file name.")
  @doc("Get test run file by file name.")
  @example("./examples/GetTestRunFile.json", "GetTestRunFile")
  listTestRuns is StandardResourceOperations.ResourceList<TestRun>;

  @summary("Get test run file by file name.")
  @doc("Get test run file by file name.")
  @example("./examples/GetTestRunFile.json", "GetTestRunFile")
  getTestRunFile is StandardResourceOperations.ResourceRead<TestRunFileInfo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id"
  @summary("Stop test run by name.")
  @doc("Stop test run by name.")
  @example("./examples/StopTestRun.json", "StopTestRun")
  @operationId("StopTestRun")
  stop is StandardResourceOperations.ResourceAction<TestRun, {}, TestRun, {}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("List the metric namespaces for a load test run.")
  @doc("List the metric namespaces for a load test run.")
  @route("/test-runs/{testRunId}/metric-namespaces")
  @get
  @example("./examples/ListTestRunMetricsNamespaces.json", "ListTestRunMetricsNamespaces")
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
  @example("./examples/ListTestRunMetricsDefinitions.json", "ListTestRunMetricsDefinitions")
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
  @example("./examples/ListTestRunMetrics.json", "ListTestRunMetrics")
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

      @doc("The interval (i.e. timegrain) of the query.")
      @query
      interval?: Interval = Interval.PT1M;

      @doc("Metric name")
      @query
      metricName: string;

      @doc("Metric namespace to query metric definitions for.")
      @query
      metricNamespace: string;

      @doc("""
The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
""")
      @query
      @projectedName("python", "time_interval")
      timespan: string;

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
  @example("./examples/ListMetricDimensionValues.json", "ListMetricDimensionValues")
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

    ...MetricDimensions;
  },
  DimensionValueList
>;


  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Associate an app component (collection of azure resources) to a test run")
  @doc("Associate an app component (collection of azure resources) to a test run")
  @route("/test-runs/{testRunId}/app-components")
  @patch
  @example("./examples/CreateOrUpdateTestRunAppComponents.json", "CreateOrUpdateTestRunAppComponents")
  createOrUpdateAppComponents is Azure.Core.Foundations.Operation<
    {
      @header 
      @doc("Content type.")
      contentType: "application/merge-patch+json",
      
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
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
  @example("./examples/ListTestRunAppComponents.json", "ListTestRunAppComponents")
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
  @example("./examples/CreateOrUpdateTestRunServerMetricsConfig.json", "CreateOrUpdateTestRunServerMetricsConfig")
  createOrUpdateServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      @header 
      @doc("Content type.")
      contentType: "application/merge-patch+json",
      
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
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
  @summary("List server metrics configuration for the given test run.")
  @doc("List server metrics configuration for the given test run.")
  @route("/test-runs/{testRunId}/server-metrics-config")
  @get
  @example("./examples/ListTestRunServerMetricsConfig.json", "ListTestRunServerMetricsConfig")
  getServerMetricsConfig is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;
  }, TestRunServerMetricConfig>;

};
