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
/**
 * A Invitation data transfer object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Share)
@Azure.ResourceManager.Private.armResourceInternal(InvitationProperties)
@includeInapplicableMetadataInPayload(false)
model Invitation extends ProxyDto {
  /**
   * The name of the invitation.
   */
  @path
  @key("invitationName")
  @segment("invitations")
  name: string;

  /**
   * Properties on the Invitation
   */
  @extension("x-ms-client-flatten", true)
  properties?: InvitationProperties;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Invitations_ListByShare")
  listByShare is ArmResourceListByParent<
    Invitation,
    {
      ...BaseParameters<Invitation>;

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
    }
  >;
}

@@projectedName(Invitations.create::parameters.resource, "json", "invitation");
@@extension(Invitations.create::parameters.resource,
  "x-ms-client-name",
  "invitation"
);
@@doc(Invitations.create::parameters.resource, "Invitation details.");
