import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace AzureLoadTesting;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@tag("Test")
interface LoadTestAdministration {
  @summary("Create a new test or update an existing test.")
  @doc("Create a new test or update an existing test.")
  @route("/tests/{testId}")
  @patch
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
    ResourceCreatedOrOkResponse<Test>, {}, ErrorResponseBody
  >;

  @summary("Delete a test by its name.")
  @doc("Delete a test by its name.")
  @route("/tests/{testId}")
  @delete
  deleteTest is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testId: string;
    },
    void, {}, ErrorResponseBody
  >;

  @summary("Get load test details by test name")
  @doc("Get load test details by test name")
  @route("/tests/{testId}")
  @get
  getTest is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testId: string;
    },
    Test, {}, ErrorResponseBody
  >;

  @summary("""
Get all load tests by the fully qualified resource Id e.g
subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName}.
""")
  @doc("""
Get all load tests by the fully qualified resource Id e.g
subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName}.
""")
  @route("/tests")
  @get
  listTests is Azure.Core.Foundations.Operation<
    {
      @doc("""
Sort on the supported fields in (field asc/desc) format. eg:
lastModifiedDateTime asc. Supported fields - lastModifiedDateTime
""")
      @query
      orderby?: string;

      @doc("""
Prefix based, case sensitive search on searchable fields - displayName,
createdBy. For example, to search for a test, with display name is Login Test,
the search parameter can be Login.
""")
      @query
      search?: string;

      @doc("""
Start DateTime(ISO 8601 literal format) of the last updated time range to
filter tests.
""")
      @query
      lastModifiedStartTime?: utcDateTime;

      @doc("""
End DateTime(ISO 8601 literal format) of the last updated time range to filter
tests.
""")
      @query
      lastModifiedEndTime?: utcDateTime;

      @doc("Number of results in response.")
      @query
      maxpagesize?: int32;
    },
    TestsList, {}, ErrorResponseBody
  >;

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
    ResourceCreatedResponse<FileInfo>, {}, ErrorResponseBody
  >;

  @summary("Get test file by the file name.")
  @doc("Get test file by the file name.")
  @route("/tests/{testId}/files/{fileName}")
  @get
  getTestFile is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testId: string;

      @doc("File name with file extension like app.jmx")
      @path
      fileName: string;
    },
    FileInfo, {}, ErrorResponseBody
  >;

  @summary("Delete file by the file name for a test")
  @doc("Delete file by the file name for a test")
  @route("/tests/{testId}/files/{fileName}")
  @delete
  deleteTestFile is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testId: string;

      @doc("File name with file extension like app.jmx")
      @path
      fileName: string;
    },
    void, {}, ErrorResponseBody
  >;

  @summary("Get all test files.")
  @doc("Get all test files.")
  @route("/tests/{testId}/files")
  @get
  listTestFiles is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testId: string;
    },
    FileInfoList, {}, ErrorResponseBody
  >;

  @summary("Associate an app component (collection of azure resources) to a test")
  @doc("Associate an app component (collection of azure resources) to a test")
  @route("/tests/{testId}/app-components")
  @patch
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
    ResourceCreatedOrOkResponse<TestAppComponents>, {}, ErrorResponseBody
  >;

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
    TestAppComponents, {}, ErrorResponseBody
  >;

  @summary("Configure server metrics for a test")
  @doc("Configure server metrics for a test")
  @route("/tests/{testId}/server-metrics-config")
  @patch
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
    ResourceCreatedOrOkResponse<TestServerMetricConfig>, {}, ErrorResponseBody
  >;

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
    TestServerMetricConfig, {}, ErrorResponseBody
  >;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@tag("TestRun")
interface LoadTestRun {
  @summary("Get test run details by name.")
  @doc("Get test run details by name.")
  @route("/test-runs/{testRunId}")
  @get
  getTestRun is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;
    },
    TestRun, {}, ErrorResponseBody
  >;

  @summary("Create and start a new test run with the given name.")
  @doc("Create and start a new test run with the given name.")
  @route("/test-runs/{testRunId}")
  @patch
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
    ResourceCreatedOrOkResponse<TestRun>, {}, ErrorResponseBody
  >;

  @summary("Delete a test run by its name.")
  @doc("Delete a test run by its name.")
  @route("/test-runs/{testRunId}")
  @delete
  deleteTestRun is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;
    },
    void, {}, ErrorResponseBody
  >;

  @summary("Get test run file by file name.")
  @doc("Get test run file by file name.")
  @route("/test-runs/{testRunId}/files/{fileName}")
  @get
  getTestRunFile is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;

      @doc("Test run file name with file extension")
      @path
      fileName: string;
    },
    FileInfo, {}, ErrorResponseBody
  >;

  @summary("Get all test runs with given filters")
  @doc("Get all test runs with given filters")
  @route("/test-runs")
  @get
  listTestRuns is Azure.Core.Foundations.Operation<
    {
      @doc("""
Sort on the supported fields in (field asc/desc) format. eg: executedDateTime
asc. Supported fields - executedDateTime
""")
      @query
      orderby?: string;

      @doc("""
Prefix based, case sensitive search on searchable fields - description,
executedUser. For example, to search for a test run, with description 500 VUs,
the search parameter can be 500.
""")
      @query
      search?: string;

      @doc("Unique name of an existing load test.")
      @query
      testId?: string;

      @doc("Start DateTime(ISO 8601 literal format) of test-run execution time filter range.")
      @query
      executionFrom?: utcDateTime;

      @doc("End DateTime(ISO 8601 literal format) of test-run execution time filter range.")
      @query
      executionTo?: utcDateTime;

      @doc("Comma separated list of test run status.")
      @query
      status?: string;

      @doc("Number of results in response.")
      @query
      maxpagesize?: int32;
    },
    TestRunsList, {}, ErrorResponseBody
  >;

  @summary("Stop test run by name.")
  @doc("Stop test run by name.")
  @route("/test-runs/{testRunId}:stop")
  @post
  stopTestRun is Azure.Core.Foundations.Operation<
    {
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;
    },
    TestRun, {}, ErrorResponseBody
  >;

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
    MetricNamespaceCollection, {}, ErrorResponseBody
  >;

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
    MetricDefinitionCollection, {}, ErrorResponseBody
  >;

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

      // TODO: check DPG sdks, this is the correct definition but might cause breaks for some languages
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
The timespan of the query. It is a string with the following format
'startDateTime_ISO/endDateTime_ISO'.
""")
      @query
      @projectedName("python", "time_interval")
      timespan: string;

      @doc("Metric dimension filter ")
      @body
      body?: MetricRequestPayload;
    },
    Metrics, {}, ErrorResponseBody
  >;

  // @summary("List the dimension values for the given metric dimension name.")
  // @doc("List the dimension values for the given metric dimension name.")
  // //@route("/test-runs/{testRunId}/metrics/dimensions/{metricDimensionName}/values")
  // listMetricDimensionValues is Azure.Core.ResourceList<
  //   DimensionValueList, QueryParametersTrait<MetricDimensions>
  // >;

  @summary("List the dimension values for the given metric dimension name.")
  @doc("List the dimension values for the given metric dimension name.")
  @route("/test-runs/{testRunId}/metrics/dimensions/{name}/values")
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
  DimensionValueList, {}, ErrorResponseBody
>;

  // @summary("List the dimension values for the given metric dimension name.")
  // @doc("List the dimension values for the given metric dimension name.")
  // @route("/test-runs/{testRunId}/metrics/dimensions/{name}/values")
  // @get
  // listMetricDimensionValues(
  //   @query apiVersion: string,

  //   @doc("""
  //   Unique name for the load test run, must contain only lower-case alphabetic,
  //   numeric, underscore or hyphen characters.
  //   """)
  //   @path
  //   testRunId: string;

  //   @doc("Dimension name")
  //   @path
  //   name: string;

  //   ...MetricDimensions;

  // ): Record<string> | ErrorResponseBody;
  
  // listMetricDimensionValue is ResourceOperations.ResourceList<
  //   DimensionValueList, QueryParametersTrait<MetricDimensions>>;

  @summary("Associate an app component (collection of azure resources) to a test run")
  @doc("Associate an app component (collection of azure resources) to a test run")
  @route("/test-runs/{testRunId}/app-components")
  @patch
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
    ResourceCreatedOrOkResponse<TestRunAppComponents>, {}, ErrorResponseBody
  >;

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
    TestRunAppComponents, {}, ErrorResponseBody
  >;

  @summary("Configure server metrics for a test run")
  @doc("Configure server metrics for a test run")
  @route("/test-runs/{testRunId}/server-metrics-config")
  @patch
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
    ResourceCreatedOrOkResponse<TestRunServerMetricConfig>, {}, ErrorResponseBody
  >;

  @summary("List server metrics configuration for the given test run.")
  @doc("List server metrics configuration for the given test run.")
  @route("/test-runs/{testRunId}/server-metrics-config")
  @get
  op getServerMetricsConfig(
      @doc("API version")
      @header
      apiVersion: string,
      @doc("""
Unique name for the load test run, must contain only lower-case alphabetic,
numeric, underscore or hyphen characters.
""")
      @path
      testRunId: string;
  ) : TestRunServerMetricConfig | ErrorResponseBody;
};
