import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.OperationalInsights;
@doc("Value object for saved search results.")
@parentResource(Workspace)
model SavedSearch is ProxyResource<SavedSearchProperties> {
  @doc("The id of the saved search.")
  @key("savedSearchId")
  @segment("savedSearches")
  name: string;

  @doc("The ETag of the saved search. To override an existing saved search, use \"*\" or specify the current Etag")
  etag?: string;
}

@armResourceOperations
interface SavedSearches {
  @doc("Gets the specified saved search for a given workspace.")
  get is ArmResourceRead<SavedSearch>;

  @doc("Creates or updates a saved search for a given workspace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SavedSearch>;

  @doc("Deletes the specified saved search in a given workspace.")
  delete is ArmResourceDeleteSync<SavedSearch>;

  @doc("Gets the saved searches for a given Log Analytics Workspace")
  listByWorkspace is ArmResourceListByParent<SavedSearch>;
}
