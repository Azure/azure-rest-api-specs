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
model Extension is ProxyResource<ExtensionProperties> {
  @doc("The name of the machine extension.")
  @path
  @key("extensionName")
  @segment("extensions")
  name: string;
}

@armResourceOperations
interface Extensions {
  @doc("Get particular Arc Extension of HCI Cluster.")
  get is ArmResourceRead<Extension>;
  @doc("Create Extension for HCI cluster.")
  create is ArmResourceCreateOrUpdateAsync<Extension>;
  @doc("Update Extension for HCI cluster.")
  update is ArmResourcePatchAsync<Extension, ExtensionProperties>;
  @doc("Delete particular Arc Extension of HCI Cluster.")
  delete is ArmResourceDeleteAsync<Extension>;
  @doc("List all Extensions under ArcSetting resource.")
  listByArcSetting is ArmResourceListByParent<Extension>;
  @doc("Upgrade a particular Arc Extension of HCI Cluster.")
  upgrade is ArmResourceActionNoResponseContentAsync<
    Extension,
    ExtensionUpgradeParameters
  >;
}
