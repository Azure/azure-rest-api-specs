import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppVolume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetApp;
@doc("Quota Rule of a Volume")
@parentResource(NetAppVolume)
model NetAppVolumeQuotaRule is TrackedResource<VolumeQuotaRulesProperties> {
  @doc("The name of volume quota rule")
  @path
  @key("volumeQuotaRuleName")
  @segment("volumeQuotaRules")
  name: string;
}

@armResourceOperations
interface NetAppVolumeQuotaRules {
  @doc("Get details of the specified quota rule")
  get is ArmResourceRead<NetAppVolumeQuotaRule>;
  @doc("Create the specified quota rule within the given volume")
  create is ArmResourceCreateOrUpdateAsync<NetAppVolumeQuotaRule>;
  @doc("Patch a quota rule")
  update is ArmResourcePatchAsync<
    NetAppVolumeQuotaRule,
    VolumeQuotaRulesProperties
  >;
  @doc("Delete quota rule")
  delete is ArmResourceDeleteAsync<NetAppVolumeQuotaRule>;
  @doc("List all quota rules associated with the volume")
  listByVolume is ArmResourceListByParent<NetAppVolumeQuotaRule>;
}
