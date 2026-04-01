import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias TestSuiteServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias TestSuiteOperations = Azure.Core.ResourceOperations<TestSuiteServiceTraits>;

alias TestSuiteFilterQueryParams = {
  @query("agentName")
  @doc("Filter by associated agent name.")
  agentName?: string;

  @query("kind")
  @doc("Filter by test suite kind (batch or continuous).")
  kind?: TestSuiteKind;
};

@added(Versions.v2025_10_15_preview)
interface TestSuites {
  @doc("Get a test suite by id.")
  get is TestSuiteOperations.ResourceRead<TestSuite>;

  @doc("List test suites with optional filters.")
  list is TestSuiteOperations.ResourceList<
    TestSuite,
    TestSuiteFilterQueryParams
  >;

  @doc("Delete a test suite.")
  delete is TestSuiteOperations.ResourceDelete<TestSuite>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update a test suite.")
  @Http.put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    TestSuite,
    {
      @doc("Test suite resource")
      @Http.bodyRoot
      testSuite: TestSuite;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<TestSuite>
  >;
}
