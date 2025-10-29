namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface HcxEnterpriseSites {
  list is ArmResourceListByParent<
    HcxEnterpriseSite,
    Response = ArmResponse<ResourceList<HcxEnterpriseSite>>
  >;

  get is ArmResourceRead<HcxEnterpriseSite>;

  createOrUpdate is ArmResourceCreateOrReplaceSync<HcxEnterpriseSite>;

  delete is ArmResourceDeleteSync<HcxEnterpriseSite>;
}

@@clientName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
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

@doc("An HCX Enterprise Site resource")
@parentResource(PrivateCloud)
model HcxEnterpriseSite is ProxyResource<HcxEnterpriseSiteProperties> {
  @doc("Name of the HCX Enterprise Site")
  @pattern("^[-\\w\\._]+$")
  @key("hcxEnterpriseSiteName")
  @path
  @segment("hcxEnterpriseSites")
  name: string;
}

@doc("HCX Enterprise Site provisioning state")
union HcxEnterpriseSiteProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of an HCX Enterprise Site")
model HcxEnterpriseSiteProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: HcxEnterpriseSiteProvisioningState;

  @doc("The activation key")
  @visibility(Lifecycle.Read)
  activationKey?: string;

  @doc("The status of the HCX Enterprise Site")
  @visibility(Lifecycle.Read)
  status?: HcxEnterpriseSiteStatus;
}
