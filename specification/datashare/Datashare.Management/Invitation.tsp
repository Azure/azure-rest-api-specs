import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
/**
 * A Invitation data transfer object.
 */
@parentResource(Share)
model Invitation is Azure.ResourceManager.ProxyResource<InvitationProperties> {
  ...ResourceNameParameter<
    Resource = Invitation,
    KeyName = "invitationName",
    SegmentName = "invitations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Invitations {
  /**
   * Get an invitation in a share
   */
  get is ArmResourceRead<Invitation>;

  /**
   * Create an invitation
   */
  create is ArmResourceCreateOrReplaceSync<Invitation>;

  /**
   * Delete an invitation in a share
   */
  delete is ArmResourceDeleteSync<Invitation>;

  /**
   * List invitations in a share
   */
  listByShare is ArmResourceListByParent<
    Invitation,
    Parameters = {
      /**
       * The continuation token
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Filters the results using OData syntax.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results using OData syntax.
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<InvitationList>
  >;
}

@@doc(Invitation.name, "The name of the invitation.");
@@doc(Invitation.properties, "Properties on the Invitation");
@@doc(Invitations.create::parameters.resource, "Invitation details.");
