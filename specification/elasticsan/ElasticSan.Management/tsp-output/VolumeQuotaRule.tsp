import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
@doc("Quota Rule of a Volume")
@parentResource(Volume)
model VolumeQuotaRule is TrackedResource<VolumeQuotaRulesProperties> {
  @doc("The name of volume quota rule")
  @path
  @key("volumeQuotaRuleName")
  @segment("volumeQuotaRules")
  name: string;
}

@armResourceOperations
interface VolumeQuotaRules {
  @doc("Get details of the specified quota rule")
  get is ArmResourceRead<VolumeQuotaRule>;

  @doc("Create the specified quota rule within the given volume")
  create is ArmResourceCreateOrUpdateAsync<
    VolumeQuotaRule,
    BaseParameters<VolumeQuotaRule>,
    ArmLroLocationHeader
  >;

  @doc("Patch a quota rule")
  update is ArmCustomPatchAsync<
    VolumeQuotaRule,
    VolumeQuotaRulePatch,
    BaseParameters<VolumeQuotaRule>,
    ArmLroLocationHeader
  >;

  @doc("Delete quota rule")
  delete is ArmResourceDeleteAsync<
    VolumeQuotaRule,
    BaseParameters<VolumeQuotaRule>,
    ArmLroLocationHeader
  >;

  @doc("List all quota rules associated with the volume")
  listByVolume is ArmResourceListByParent<VolumeQuotaRule>;
}

@@projectedName(VolumeQuotaRules.create::parameters.resource, "json", "body");
@@extension(VolumeQuotaRules.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VolumeQuotaRules.create::parameters.resource,
  "Quota rule object supplied in the body of the operation."
);
@@projectedName(VolumeQuotaRules.update::parameters.properties, "json", "body");
@@extension(VolumeQuotaRules.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VolumeQuotaRules.update::parameters.properties,
  "Quota rule object supplied in the body of the operation."
);
