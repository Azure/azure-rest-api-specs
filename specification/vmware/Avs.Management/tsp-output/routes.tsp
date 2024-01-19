import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AVS;

interface LocationsOperations {
  @doc("Return trial status for subscription by region")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AVS/locations/{location}/checkTrialAvailability")
  @post
  checkTrialAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Azure region")
      @path
      location: string;

      @doc("The sku to check for trial availability")
      @body
      sku?: Sku;
    },
    Trial
  >;

  @doc("Return quota for subscription by region")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AVS/locations/{location}/checkQuotaAvailability")
  @post
  checkQuotaAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Azure region")
      @path
      location: string;
    },
    Quota
  >;
}
