import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
@doc("A Invitation data transfer object.")
@parentResource(Share)
model Invitation is ProxyResource<InvitationProperties> {
  @doc("The name of the invitation.")
  @path
  @key("invitationName")
  @segment("invitations")
  name: string;
}

@armResourceOperations
interface Invitations {
  @doc("Get an invitation in a share")
  get is ArmResourceRead<Invitation>;

  @doc("Create an invitation ")
  create is ArmResourceCreateOrReplaceSync<Invitation>;

  @doc("Delete an invitation in a share")
  delete is ArmResourceDeleteSync<Invitation>;

  @doc("List invitations in a share")
  listByShare is ArmResourceListByParent<
    Invitation,
    {
      ...BaseParameters<Invitation>;

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

@@projectedName(Invitations.create::parameters.resource, "json", "invitation");
@@extension(Invitations.create::parameters.resource,
  "x-ms-client-name",
  "invitation"
);
@@doc(Invitations.create::parameters.resource, "Invitation details.");
