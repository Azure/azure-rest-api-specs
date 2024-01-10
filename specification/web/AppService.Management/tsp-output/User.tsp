import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("User credentials used for publishing activity.")
@singleton("web")
@tenantResource
model User is ProxyResource<UserProperties> {
  @key("publishingUser")
  @segment("publishingUsers")
  name: string;
}

@armResourceOperations
@projectedName("client", "")
interface Users_ {
  @doc("Description for Gets publishing user")
  getPublishingUser is ArmResourceRead<User>;

  @doc("Description for Updates publishing user")
  updatePublishingUser is ArmResourceCreateOrReplaceSync<User>;
}
