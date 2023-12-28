import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetApp;
@doc("Quota Rule of a Volume")
@parentResource(Volume)
model VolumeQuotaRule is TrackedResource<VolumeQuotaRulesProperties> {
  @doc("The name of volume quota rule")
  @key("volumeQuotaRuleName")
  @segment("volumeQuotaRules")
  name: string;
}

@armResourceOperations
interface VolumeQuotaRules {
  @doc("Get details of the specified quota rule")
  get is ArmResourceRead<VolumeQuotaRule>;
  @doc("Create the specified quota rule within the given volume")
  create is ArmResourceCreateOrUpdateAsync<VolumeQuotaRule>;
  @doc("Patch a quota rule")
  update is ArmCustomPatchAsync<VolumeQuotaRule, VolumeQuotaRulePatch>;
  @doc("Delete quota rule")
  delete is ArmResourceDeleteAsync<VolumeQuotaRule>;
  @doc("List all quota rules associated with the volume")
  listByVolume is ArmResourceListByParent<VolumeQuotaRule>;
}
