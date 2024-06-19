import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("Site properties.")
model SitePropertiesFormat {
  @doc("The provisioning state of the site resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("An array of IDs of the network functions deployed in the site. Deleting the site will delete any network functions that are deployed in the site.")
  @visibility("read")
  networkFunctions?: SubResource[];
}

@doc("The packet core to delete under a site.")
model SiteDeletePacketCore {
  @doc("Reference to an packet core control plane resource.")
  packetCore?: PacketCoreControlPlaneResourceId;
}
