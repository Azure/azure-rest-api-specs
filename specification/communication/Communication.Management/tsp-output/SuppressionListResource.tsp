import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./CommunicationDomainResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Communication;
@doc("A class representing a SuppressionList resource.")
@parentResource(CommunicationDomainResource)
model SuppressionListResource is ProxyResource<SuppressionListProperties> {
  @doc("The name of the suppression list.")
  @maxLength(253)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @path
  @key("suppressionListName")
  @segment("suppressionLists")
  name: string;
}

@armResourceOperations
interface SuppressionListResources {
  @doc("Get a SuppressionList resource.")
  get is ArmResourceRead<SuppressionListResource>;
  @doc("Add a new SuppressionList resource under the parent Domains resource or update an existing SuppressionList resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListResource>;
  @doc("Delete a SuppressionList.")
  delete is ArmResourceDeleteSync<SuppressionListResource>;
  @doc("List all suppression lists for a domains resource.")
  listByDomain is ArmResourceListByParent<SuppressionListResource>;
}
