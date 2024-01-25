import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.StreamAnalytics;

interface SubscriptionsOperations {
  /**
   * Retrieves the subscription's current quota information in a particular region.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/quotas")
  @get
  listQuotas is Azure.Core.Foundations.Operation<
    {
      /**
       * The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/
       */
      @path
      location: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    SubscriptionQuotasListResult
  >;

  /**
   * Test the Stream Analytics query on a sample input.
   */
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [testQuery]
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/testQuery")
  @post
  testQuery is Azure.Core.Foundations.Operation<
    {
      /**
       * The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/
       */
      @path
      location: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The query testing object that defines the input, output, and transformation for the query testing.
       */
      @body
      testQuery: TestQuery;
    },
    QueryTestingResult | void
  >;

  /**
   * Compile the Stream Analytics query.
   */
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [compileQuery]
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/compileQuery")
  @post
  compileQuery is Azure.Core.Foundations.Operation<
    {
      /**
       * The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/
       */
      @path
      location: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The query compilation object which defines the input, output, and transformation for the query compilation.
       */
      @body
      compileQuery: CompileQuery;
    },
    QueryCompilationResult
  >;

  /**
   * Sample the Stream Analytics input data.
   */
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [sampleInput]
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/sampleInput")
  @post
  sampleInput is Azure.Core.Foundations.Operation<
    {
      /**
       * The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/
       */
      @path
      location: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Defines the necessary parameters for sampling the Stream Analytics input data.
       */
      @body
      sampleInput: SampleInput;
    },
    SampleInputResult
  >;

  /**
   * Test the Stream Analytics input.
   */
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [testInput]
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/testInput")
  @post
  testInput is Azure.Core.Foundations.Operation<
    {
      /**
       * The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/
       */
      @path
      location: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Defines the necessary parameters for testing the Stream Analytics input.
       */
      @body
      testInput: TestInput;
    },
    TestDatasourceResult
  >;

  /**
   * Test the Stream Analytics output.
   */
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [testOutput]
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StreamAnalytics/locations/{location}/testOutput")
  @post
  testOutput is Azure.Core.Foundations.Operation<
    {
      /**
       * The region to which the request is sent. You can find out which regions Azure Stream Analytics is supported in here: https://azure.microsoft.com/en-us/regions/
       */
      @path
      location: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Defines the necessary parameters for testing the Stream Analytics output.
       */
      @body
      testOutput: TestOutput;
    },
    TestDatasourceResult
  >;
}
