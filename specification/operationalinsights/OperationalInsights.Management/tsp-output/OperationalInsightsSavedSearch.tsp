import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./OperationalInsightsWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("Value object for saved search results.")
@parentResource(OperationalInsightsWorkspace)
model OperationalInsightsSavedSearch is ProxyResource<SavedSearchProperties> {
  @doc("The id of the saved search.")
  @path
  @key("savedSearchId")
  @segment("savedSearches")
  name: string;
}

@armResourceOperations
interface OperationalInsightsSavedSearches {
  @doc("Gets the specified saved search for a given workspace.")
  get is ArmResourceRead<OperationalInsightsSavedSearch>;
  @doc("Creates or updates a saved search for a given workspace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<OperationalInsightsSavedSearch>;
  @doc("Deletes the specified saved search in a given workspace.")
  delete is ArmResourceDeleteSync<OperationalInsightsSavedSearch>;
  @doc("Gets the saved searches for a given Log Analytics Workspace")
  listByWorkspace is ArmResourceListByParent<OperationalInsightsSavedSearch>;
}
