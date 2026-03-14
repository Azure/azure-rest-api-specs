import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Contact details and configurations for notifications coming from Microsoft Defender for Cloud.
 */
@subscriptionResource
model SecurityContact
  is Azure.ResourceManager.ProxyResource<SecurityContactProperties> {
  ...ResourceNameParameter<
    Resource = SecurityContact,
    KeyName = "securityContactName",
    SegmentName = "securityContacts",
    NamePattern = "",
    Type = SecurityContactName
  >;
}

@armResourceOperations
interface SecurityContacts {
  /**
   * Get Default Security contact configurations for the subscription
   */
  get is ArmResourceRead<
    SecurityContact,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Create security contact configurations for the subscription
   */
  create is ArmResourceCreateOrReplaceSync<
    SecurityContact,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Delete security contact configurations for the subscription
   */
  delete is ArmResourceDeleteSync<
    SecurityContact,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List all security contact configurations for the subscription
   */
  list is ArmResourceListByParent<
    SecurityContact,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SecurityContactList>
  >;
}

@@doc(SecurityContact.name, "Name of the security contact object");
@@doc(SecurityContact.properties, "Security contact data");
@@doc(SecurityContacts.create::parameters.resource, "Security contact object");
