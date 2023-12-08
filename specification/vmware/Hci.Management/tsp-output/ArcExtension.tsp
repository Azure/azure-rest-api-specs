import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ArcSetting.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("Details of a particular extension in HCI Cluster.")
@parentResource(ArcSetting)
model ArcExtension is ProxyResource<ExtensionProperties> {
  @doc("The name of the machine extension.")
  @path
  @key("extensionName")
  @segment("extensions")
  name: string;
}

@armResourceOperations
interface ArcExtensions {
  @doc("Get particular Arc Extension of HCI Cluster.")
  get is ArmResourceRead<ArcExtension>;
  @doc("Create Extension for HCI cluster.")
  create is ArmResourceCreateOrUpdateAsync<ArcExtension>;
  @doc("Update Extension for HCI cluster.")
  update is ArmResourcePatchAsync<ArcExtension, ExtensionProperties>;
  @doc("Delete particular Arc Extension of HCI Cluster.")
  delete is ArmResourceDeleteAsync<ArcExtension>;
  @doc("List all Extensions under ArcSetting resource.")
  listByArcSetting is ArmResourceListByParent<ArcExtension>;
  @doc("Upgrade a particular Arc Extension of HCI Cluster.")
  upgrade is ArmResourceActionNoResponseContentAsync<
    ArcExtension,
    ExtensionUpgradeParameters
  >;
}
