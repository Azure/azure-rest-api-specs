import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Batch;

interface LocationOperations {
  @doc("Gets the Batch service quotas for the specified subscription at the given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/quotas")
  @get
  GetQuotas is Azure.Core.Foundations.Operation<
    {
      @doc("The region for which to retrieve Batch service quotas.")
      @path
      locationName: string;

      @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)")
      @path
      subscriptionId: string;
    },
    BatchLocationQuota
  >;

  @doc("Gets the list of Batch supported Virtual Machine VM sizes available at the given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/virtualMachineSkus")
  @get
  ListSupportedVirtualMachineSkus is Azure.Core.Foundations.Operation<
    {
      @doc("The region for which to retrieve Batch service supported SKUs.")
      @path
      locationName: string;

      @doc("The maximum number of items to return in the response.")
      @query("maxresults")
      maxresults?: int32;

      @doc("OData filter expression. Valid properties for filtering are \"familyName\".")
      @query("$filter")
      $filter?: string;

      @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)")
      @path
      subscriptionId: string;
    },
    SupportedSkusResult
  >;

  @doc("Gets the list of Batch supported Cloud Service VM sizes available at the given location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/cloudServiceSkus")
  @get
  ListSupportedCloudServiceSkus is Azure.Core.Foundations.Operation<
    {
      @doc("The region for which to retrieve Batch service supported SKUs.")
      @path
      locationName: string;

      @doc("The maximum number of items to return in the response.")
      @query("maxresults")
      maxresults?: int32;

      @doc("OData filter expression. Valid properties for filtering are \"familyName\".")
      @query("$filter")
      $filter?: string;

      @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)")
      @path
      subscriptionId: string;
    },
    SupportedSkusResult
  >;

  @doc("Checks whether the Batch account name is available in the specified region.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Batch/locations/{locationName}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The desired region for the name check.")
      @path
      locationName: string;

      @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)")
      @path
      subscriptionId: string;

      @doc("Properties needed to check the availability of a name.")
      @body
      parameters: CheckNameAvailabilityParameters;
    },
    CheckNameAvailabilityResult
  >;
}
