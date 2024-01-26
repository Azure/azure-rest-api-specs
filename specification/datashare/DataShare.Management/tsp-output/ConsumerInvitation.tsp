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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
model ConsumerInvitation extends ProxyDto {
  /**
   * An invitation id
   */
  @path
  @key("invitationId")
  @segment("consumerInvitations")
  @visibility("read")
  name: string;

  /**
   * Properties on the account
   */
  @extension("x-ms-client-flatten", true)
  properties: ConsumerInvitationProperties;
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
