import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("User credentials used for publishing activity.")
@singleton("web")
@tenantResource
model User is ProxyResource<UserProperties> {
  @key("web")
  @segment("publishingUsers")
  name: string;
}

@armResourceOperations
interface PublishingUsers {
  @doc("Description for Gets publishing user")
  getPublishingUser is ArmResourceRead<User>;
  @doc("Description for Updates publishing user")
  updatePublishingUser is ArmResourceCreateOrReplaceSync<User>;
}
