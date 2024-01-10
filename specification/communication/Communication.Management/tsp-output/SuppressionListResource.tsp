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
@doc("A class representing a SuppressionList resource.")
@parentResource(DomainResource)
model SuppressionListResource is ProxyResource<SuppressionListProperties> {
  @doc("The name of the suppression list.")
  @maxLength(253)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @key("suppressionListName")
  @segment("suppressionLists")
  name: string;
}

@armResourceOperations
@projectedName("client", "SuppressionLists")
interface SuppressionListResources_SuppressionLists {
  @doc("Get a SuppressionList resource.")
  get is ArmResourceRead<SuppressionListResource>;

  @doc("Add a new SuppressionList resource under the parent Domains resource or update an existing SuppressionList resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListResource>;

  @doc("Delete a SuppressionList.")
  delete is ArmResourceDeleteSync<SuppressionListResource>;

  @doc("List all suppression lists for a domains resource.")
  listByDomain is ArmResourceListByParent<SuppressionListResource>;
}
