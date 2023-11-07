import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Chaos;

interface OperationStatusesOperations {
  @doc("Get the status of a long running azure asynchronous operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{location}/operationsStatuses/{asyncOperationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The region name of operation.")
      @path
      location: string;

      @doc("The operation Id.")
      @path
      asyncOperationId: string;

      @doc("GUID that represents an Azure subscription ID.")
      @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
      @path
      subscriptionId: string;
    },
    OperationStatus
  >;
}
