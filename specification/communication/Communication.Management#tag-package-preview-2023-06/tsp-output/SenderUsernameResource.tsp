import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DomainResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Communication;
@doc("A class representing a SenderUsername resource.")
@parentResource(DomainResource)
model SenderUsernameResource is ProxyResource<SenderUsernameProperties> {
  @doc("The valid sender Username.")
  @maxLength(253)
  @minLength(1)
  @path
  @key("senderUsername")
  @segment("senderUsernames")
  name: string;
}

@armResourceOperations
interface SenderUsernameResources {
  @doc("Get a valid sender username for a domains resource.")
  get is ArmResourceRead<SenderUsernameResource>;
  @doc("Add a new SenderUsername resource under the parent Domains resource or update an existing SenderUsername resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SenderUsernameResource>;
  @doc("Operation to delete a SenderUsernames resource.")
  delete is ArmResourceDeleteSync<SenderUsernameResource>;
  @doc("List all valid sender usernames for a domains resource.")
  listByDomains is ArmResourceListByParent<SenderUsernameResource>;
}
