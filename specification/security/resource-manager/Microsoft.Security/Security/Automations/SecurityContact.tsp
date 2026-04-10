import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace AutomationsAPI;
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
@tag("Security Contacts")
interface SecurityContacts {
  /**
   * Get Default Security contact configurations for the subscription
   */
  get is ArmResourceRead<
    SecurityContact,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Create security contact configurations for the subscription
   */
  create is ArmResourceCreateOrReplaceSync<
    SecurityContact,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Delete security contact configurations for the subscription
   */
  delete is ArmResourceDeleteSync<
    SecurityContact,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * List all security contact configurations for the subscription
   */
  list is ArmResourceListByParent<
    SecurityContact,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SecurityContactList>,
    Error = CloudError
  >;
}

@@doc(SecurityContact.name, "Name of the security contact object");
@@minLength(SecurityContact.name, 7);
@@maxLength(SecurityContact.name, 7);
@@pattern(SecurityContact.name, "^(default)$");
@@doc(SecurityContact.properties, "Security contact data");
@@doc(SecurityContacts.create::parameters.resource, "Security contact object");



