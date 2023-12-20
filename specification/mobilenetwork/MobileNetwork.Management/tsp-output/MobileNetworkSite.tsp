import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("Site resource. Must be created in the same location as its parent mobile network.")
@parentResource(MobileNetwork)
model MobileNetworkSite is TrackedResource<SitePropertiesFormat> {
  @doc("The name of the mobile network site.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("siteName")
  @segment("sites")
  name: string;
}

@armResourceOperations
interface MobileNetworkSites {
  @doc("Gets information about the specified mobile network site.")
  get is ArmResourceRead<MobileNetworkSite>;
  @doc("Creates or updates a mobile network site. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MobileNetworkSite>;
  @doc("Updates site tags.")
  updateTags is ArmTagsPatchSync<MobileNetworkSite>;
  @doc("Deletes the specified mobile network site. This will also delete any network functions that are a part of this site.")
  delete is ArmResourceDeleteAsync<MobileNetworkSite>;
  @doc("Lists all sites in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<MobileNetworkSite>;
  @doc("Deletes a packet core under the specified mobile network site.")
  deletePacketCore is ArmResourceActionAsync<
    MobileNetworkSite,
    SiteDeletePacketCore,
    void
  >;
}
