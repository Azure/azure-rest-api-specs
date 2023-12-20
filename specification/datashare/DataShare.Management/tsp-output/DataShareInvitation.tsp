import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataShare.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
@doc("A Invitation data transfer object.")
@parentResource(DataShare)
model DataShareInvitation is ProxyResource<InvitationProperties> {
  @doc("The name of the invitation.")
  @path
  @key("invitationName")
  @segment("invitations")
  name: string;
}

@armResourceOperations
interface DataShareInvitations {
  @doc("Get an invitation in a share")
  get is ArmResourceRead<DataShareInvitation>;
  @doc("Create an invitation ")
  create is ArmResourceCreateOrReplaceSync<DataShareInvitation>;
  @doc("Delete an invitation in a share")
  delete is ArmResourceDeleteSync<DataShareInvitation>;
  @doc("List invitations in a share")
  listByShare is ArmResourceListByParent<
    DataShareInvitation,
    {
      ...BaseParameters<DataShareInvitation>;

      @doc("The continuation token")
      @query("$skipToken")
      $skipToken?: string;

      @doc("Filters the results using OData syntax.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results using OData syntax.")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}
