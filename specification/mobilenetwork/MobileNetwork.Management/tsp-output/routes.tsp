import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.MobileNetwork;

interface PacketCoreControlPlaneVersionsOperations {
  /**
   * Gets information about the specified packet core control plane version.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MobileNetwork/packetCoreControlPlaneVersions/{versionName}")
  @get
  getBySubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the packet core control plane version.
       */
      @path
      versionName: string;

      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;
    },
    PacketCoreControlPlaneVersion
  >;

  /**
   * Lists all supported packet core control planes versions.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MobileNetwork/packetCoreControlPlaneVersions")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<PacketCoreControlPlaneVersion>
  >;
}
