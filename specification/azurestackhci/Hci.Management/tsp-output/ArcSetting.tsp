import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HciCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("ArcSetting details.")
@parentResource(HciCluster)
model ArcSetting is ProxyResource<ArcSettingProperties> {
  @doc("The name of the proxy resource holding details of HCI ArcSetting information.")
  @path
  @key("arcSettingName")
  @segment("arcSettings")
  name: string;
}

@armResourceOperations
interface ArcSettings {
  @doc("Get ArcSetting resource details of HCI Cluster.")
  get is ArmResourceRead<ArcSetting>;
  @doc("Create ArcSetting for HCI cluster.")
  create is ArmResourceCreateOrReplaceSync<ArcSetting>;
  @doc("Update ArcSettings for HCI cluster.")
  update is ArmResourcePatchSync<ArcSetting, ArcSettingProperties>;
  @doc("Delete ArcSetting resource details of HCI Cluster.")
  delete is ArmResourceDeleteAsync<ArcSetting>;
  @doc("Get ArcSetting resources of HCI Cluster.")
  listByCluster is ArmResourceListByParent<ArcSetting>;
  @doc("Generate password for arc settings.")
  generatePassword is ArmResourceActionSync<
    ArcSetting,
    void,
    PasswordCredential
  >;
  @doc("Create Aad identity for arc settings.")
  createIdentity is ArmResourceActionAsync<
    ArcSetting,
    void,
    ArcIdentityResponse
  >;
}
