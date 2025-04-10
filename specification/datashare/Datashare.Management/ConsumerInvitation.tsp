import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
/**
 * A consumer Invitation data transfer object.
 */
@tenantResource
@parentResource(TenantLocationResource)
model ConsumerInvitation
  is Azure.ResourceManager.ProxyResource<ConsumerInvitationProperties, false> {
  ...ResourceNameParameter<
    Resource = ConsumerInvitation,
    KeyName = "invitationId",
    SegmentName = "consumerInvitations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ConsumerInvitations {
  /**
   * Get an invitation
   */
  get is ArmResourceRead<
    ConsumerInvitation,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(ConsumerInvitation.name, "An invitation id");
@@doc(ConsumerInvitation.properties, "Properties on the account");
