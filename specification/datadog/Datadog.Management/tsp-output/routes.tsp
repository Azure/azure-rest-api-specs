import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Datadog;

interface MarketplaceAgreementsOperations {
  @summary("List Datadog marketplace agreements in the subscription.")
  @doc("List Datadog marketplace agreements in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Datadog/agreements")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    DatadogAgreementResourceListResponse
  >;

  @summary("Create Datadog marketplace agreement in the subscription.")
  @doc("Create Datadog marketplace agreement in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Datadog/agreements/default")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @body
      body?: DatadogAgreementResource;
    },
    DatadogAgreementResource
  >;
}
