import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * Value object for saved search results.
 */
@parentResource(Workspace)
model SavedSearch is ProxyResource<SavedSearchProperties> {
  /**
   * The id of the saved search.
   */
  @path
  @key("savedSearchId")
  @segment("savedSearches")
  name: string;

  /**
   * The ETag of the saved search. To override an existing saved search, use "*" or specify the current Etag
   */
  etag?: string;
}

@armResourceOperations
interface SavedSearches {
  /**
   * Gets the specified saved search for a given workspace.
   */
  get is ArmResourceRead<SavedSearch>;

  /**
   * Creates or updates a saved search for a given workspace.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SavedSearch>;

  /**
   * Deletes the specified saved search in a given workspace.
   */
  delete is ArmResourceDeleteSync<SavedSearch>;

  /**
   * Gets the saved searches for a given Log Analytics Workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavedSearches_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<SavedSearch>;
}

@@projectedName(SavedSearches.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SavedSearches.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SavedSearches.createOrUpdate::parameters.resource,
  "The parameters required to save a search."
);
