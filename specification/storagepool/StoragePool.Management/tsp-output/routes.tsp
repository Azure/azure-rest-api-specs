import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.StoragePool;

interface DiskPoolZonesOperations {
  @doc("Lists available Disk Pool Skus in an Azure location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StoragePool/locations/{location}/diskPoolZones")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The location of the resource.")
      @path
      location: string;
    },
    DiskPoolZoneListResult
  >;
}

interface ResourceSkusOperations {
  @doc("Lists available StoragePool resources and skus in an Azure location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StoragePool/locations/{location}/skus")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The location of the resource.")
      @path
      location: string;
    },
    ResourceSkuListResult
  >;
}
