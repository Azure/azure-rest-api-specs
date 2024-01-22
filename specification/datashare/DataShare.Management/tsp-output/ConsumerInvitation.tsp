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
/**
 * A consumer Invitation data transfer object.
 */
@tenantResource
model ConsumerInvitation is ProxyResource<ConsumerInvitationProperties> {
  /**
   * An invitation id
   */
  @path
  @key("invitationId")
  @segment("consumerInvitations")
  name: string;
}

@armResourceOperations
interface ConsumerInvitations {
  /**
   * Get an invitation
   */
  get is ArmResourceRead<ConsumerInvitation>;

  /**
   * Lists invitations
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConsumerInvitations_ListInvitations")
  listInvitations is ArmResourceListByParent<
    ConsumerInvitation,
    {
      ...BaseParameters<ConsumerInvitation>;

      /**
       * The continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
