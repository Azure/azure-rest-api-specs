namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface HcxEnterpriseSites {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("HcxEnterpriseSites_List")
  list is ArmResourceListByParent<
    HcxEnterpriseSite,
    Response = ArmResponse<ResourceList<HcxEnterpriseSite>>
  >;

  get is ArmResourceRead<HcxEnterpriseSite>;

  createOrUpdate is ArmResourceCreateOrReplaceSync<HcxEnterpriseSite>;

  delete is ArmResourceDeleteSync<HcxEnterpriseSite>;
}

@@encodedName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "application/json",
  "hcxEnterpriseSite"
);
@@clientName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "hcxEnterpriseSite"
);
@@OpenAPI.extension(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "hcxEnterpriseSite"
);

@doc("HCX Enterprise Site status")
union HcxEnterpriseSiteStatus {
  string,

  @doc("is available")
  Available: "Available",

  @doc("is consumed")
  Consumed: "Consumed",

  @doc("is deactivated")
  Deactivated: "Deactivated",

  @doc("is deleted")
  Deleted: "Deleted",
}
