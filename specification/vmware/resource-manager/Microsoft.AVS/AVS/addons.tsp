namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface Addons {
  list is ArmResourceListByParent<
    Addon,
    Response = ArmResponse<ResourceList<Addon>>
  >;

  get is ArmResourceRead<Addon>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Addon,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<Addon>;
}

@@clientName(Addons.createOrUpdate::parameters.resource, "addon");

@doc("Addon provisioning state")
union AddonProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

@doc("An addon resource")
@parentResource(PrivateCloud)
model Addon is ProxyResource<AddonProperties> {
  @doc("Name of the addon.")
  @pattern("^[-\\w\\._]+$")
  @key("addonName")
  @path
  @segment("addons")
  name: string;
}

@doc("Addon type")
union AddonType {
  SRM: "SRM",
  VR: "VR",
  HCX: "HCX",
  Arc: "Arc",
  string,
}

@doc("The properties of an addon")
@discriminator("addonType")
model AddonProperties {
  @doc("Addon type")
  addonType: AddonType;

  @doc("The state of the addon provisioning")
  @visibility(Lifecycle.Read)
  provisioningState?: AddonProvisioningState;
}

@doc("The properties of a Site Recovery Manager (SRM) addon")
model AddonSrmProperties extends AddonProperties {
  @doc("The Site Recovery Manager (SRM) license")
  licenseKey?: string;

  @doc("The type of private cloud addon")
  addonType: AddonType.SRM;
}

@doc("The properties of a vSphere Replication (VR) addon")
model AddonVrProperties extends AddonProperties {
  @doc("The vSphere Replication Server (VRS) count")
  vrsCount: int32;

  @doc("The type of private cloud addon")
  addonType: AddonType.VR;
}

@doc("The properties of an HCX addon")
model AddonHcxProperties extends AddonProperties {
  @doc("The HCX offer, example VMware MaaS Cloud Provider (Enterprise)")
  offer: string;

  @doc("The type of private cloud addon")
  addonType: AddonType.HCX;

  @doc("HCX management network.")
  @added(Versions.v2024_09_01)
  managementNetwork?: string;

  @doc("HCX uplink network")
  @added(Versions.v2024_09_01)
  uplinkNetwork?: string;
}

@doc("The properties of an Arc addon")
model AddonArcProperties extends AddonProperties {
  @doc("The VMware vCenter resource ID")
  vCenter?: string;

  @doc("The type of private cloud addon")
  addonType: AddonType.Arc;
}
