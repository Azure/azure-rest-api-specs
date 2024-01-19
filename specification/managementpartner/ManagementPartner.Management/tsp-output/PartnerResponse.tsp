import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagementPartner;
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
interface PartnerResponses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the management partner using the partnerId, objectId and tenantId.")
  @operationId("Partner_Get")
  get is ArmResourceRead<PartnerResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a management partner for the objectId and tenantId.")
  @operationId("Partner_Create")
  create is ArmResourceCreateOrReplaceSync<PartnerResponse>;

  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the management partner for the objectId and tenantId.")
  @operationId("Partner_Update")
  update is ArmCustomPatchSync<PartnerResponse, {}>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the management partner for the objectId and tenantId.")
  @operationId("Partner_Delete")
  delete is ArmResourceDeleteSync<PartnerResponse>;
}
