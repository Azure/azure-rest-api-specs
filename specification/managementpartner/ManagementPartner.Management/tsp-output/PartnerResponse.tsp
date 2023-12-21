import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagementPartner;
@doc("this is the management partner operations response")
@tenantResource
model PartnerResponse is ProxyResource<PartnerProperties> {
  @doc("Id of the Partner")
  @path
  @key("partnerId")
  @segment("partners")
  name: string;

  @doc("Type of the partner")
  etag?: int32;
}

@armResourceOperations
interface Partner {
  @doc("Get the management partner using the partnerId, objectId and tenantId.")
  get is ArmResourceRead<PartnerResponse>;
  @doc("Create a management partner for the objectId and tenantId.")
  create is ArmResourceCreateOrReplaceSync<PartnerResponse>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Update the management partner for the objectId and tenantId.")
  update is ArmCustomPatchSync<PartnerResponse, {}>;
  @doc("Delete the management partner for the objectId and tenantId.")
  delete is ArmResourceDeleteSync<PartnerResponse>;
}
