import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.MobileNetwork;

interface PacketCoreControlPlaneVersionsOperations {
  @doc("Gets information about the specified packet core control plane version.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MobileNetwork/packetCoreControlPlaneVersions/{versionName}")
  @get
  GetBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the packet core control plane version.")
      @path
      versionName: string;

      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;
    },
    PacketCoreControlPlaneVersion
  >;

  @doc("Lists all supported packet core control planes versions.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MobileNetwork/packetCoreControlPlaneVersions")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;
    },
    PacketCoreControlPlaneVersionListResult
  >;
}
