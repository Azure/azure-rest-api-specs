import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.StoragePool;

interface DiskPoolZonesOperations {
  /**
   * Lists available Disk Pool Skus in an Azure location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StoragePool/locations/{location}/diskPoolZones")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The location of the resource.
       */
      @path
      location: string;
    },
    DiskPoolZoneListResult
  >;
}

interface ResourceSkusOperations {
  /**
   * Lists available StoragePool resources and skus in an Azure location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StoragePool/locations/{location}/skus")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The location of the resource.
       */
      @path
      location: string;
    },
    ResourceSkuListResult
  >;
}
