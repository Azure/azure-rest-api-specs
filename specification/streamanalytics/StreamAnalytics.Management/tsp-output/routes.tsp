import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.StreamAnalytics;

interface SubscriptionsOperations {
  @doc("Retrieves the subscription's current quota information in a particular region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/quotas")
  @get
  ListQuotas is Azure.Core.Foundations.Operation<
    {
      @doc("The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    SubscriptionQuotasListResult
  >;

  @doc("Test the Stream Analytics query on a sample input.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/testQuery")
  @post
  TestQuery is Azure.Core.Foundations.Operation<
    {
      @doc("The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The query testing object that defines the input, output, and transformation for the query testing.")
      @body
      testQuery: TestQuery;
    },
    QueryTestingResult | void
  >;

  @doc("Compile the Stream Analytics query.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/compileQuery")
  @post
  CompileQuery is Azure.Core.Foundations.Operation<
    {
      @doc("The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The query compilation object which defines the input, output, and transformation for the query compilation.")
      @body
      compileQuery: CompileQuery;
    },
    QueryCompilationResult
  >;

  @doc("Sample the Stream Analytics input data.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/sampleInput")
  @post
  SampleInput is Azure.Core.Foundations.Operation<
    {
      @doc("The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Defines the necessary parameters for sampling the Stream Analytics input data.")
      @body
      sampleInput: SampleInput;
    },
    SampleInputResult
  >;

  @doc("Test the Stream Analytics input.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/testInput")
  @post
  TestInput is Azure.Core.Foundations.Operation<
    {
      @doc("The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Defines the necessary parameters for testing the Stream Analytics input.")
      @body
      testInput: TestInput;
    },
    TestDatasourceResult
  >;

  @doc("Test the Stream Analytics output.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/testOutput")
  @post
  TestOutput is Azure.Core.Foundations.Operation<
    {
      @doc("The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/")
      @path
      location: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Defines the necessary parameters for testing the Stream Analytics output.")
      @body
      testOutput: TestOutput;
    },
    TestDatasourceResult
  >;
}
