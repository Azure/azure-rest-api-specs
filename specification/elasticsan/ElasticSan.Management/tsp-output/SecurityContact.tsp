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

namespace Microsoft.Security;
@doc("Contact details and configurations for notifications coming from Microsoft Defender for Cloud.")
@subscriptionResource
model SecurityContact is ProxyResource<SecurityContactProperties> {
  @doc("Name of the security contact object")
  @path
  @key("securityContactName")
  @segment("securityContacts")
  name: string;
}

@armResourceOperations
interface SecurityContacts {
  @doc("Get Default Security contact configurations for the subscription")
  get is ArmResourceRead<SecurityContact>;

  @doc("Create security contact configurations for the subscription")
  create is ArmResourceCreateOrReplaceSync<SecurityContact>;

  @doc("Delete security contact configurations for the subscription")
  delete is ArmResourceDeleteSync<SecurityContact>;

  @doc("List all security contact configurations for the subscription")
  list is ArmResourceListByParent<SecurityContact>;
}

@@projectedName(SecurityContacts.create::parameters.resource,
  "json",
  "securityContact"
);
@@extension(SecurityContacts.create::parameters.resource,
  "x-ms-client-name",
  "securityContact"
);
@@doc(SecurityContacts.create::parameters.resource, "Security contact object");
