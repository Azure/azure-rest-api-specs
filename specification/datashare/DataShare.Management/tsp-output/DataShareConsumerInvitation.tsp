import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
@doc("A consumer Invitation data transfer object.")
@tenantResource
model DataShareConsumerInvitation
  is ProxyResource<ConsumerInvitationProperties> {
  @doc("An invitation id")
  @path
  @key("invitationId")
  @segment("consumerInvitations")
  name: string;
}

@armResourceOperations
interface DataShareConsumerInvitations {
  @doc("Get an invitation")
  get is ArmResourceRead<DataShareConsumerInvitation>;
  @doc("Lists invitations")
  listInvitations is ArmResourceListByParent<
    DataShareConsumerInvitation,
    {
      ...BaseParameters<DataShareConsumerInvitation>;

      @doc("The continuation token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
