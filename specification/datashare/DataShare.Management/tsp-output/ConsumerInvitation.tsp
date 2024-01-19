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

namespace Microsoft.DataShare;
@doc("A consumer Invitation data transfer object.")
@tenantResource
model ConsumerInvitation is ProxyResource<ConsumerInvitationProperties> {
  @doc("An invitation id")
  @path
  @key("invitationId")
  @segment("consumerInvitations")
  name: string;
}

@armResourceOperations
interface ConsumerInvitations {
  @doc("Get an invitation")
  get is ArmResourceRead<ConsumerInvitation>;

  @doc("Lists invitations")
  listInvitations is ArmResourceListByParent<
    ConsumerInvitation,
    {
      ...BaseParameters<ConsumerInvitation>;

      @doc("The continuation token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
