import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * Value object for saved search results.
 */
@parentResource(Workspace)
model SavedSearch
  is Azure.ResourceManager.ProxyResource<SavedSearchProperties, false> {
  ...ResourceNameParameter<
    Resource = SavedSearch,
    KeyName = "savedSearchId",
    SegmentName = "savedSearches",
    NamePattern = ""
  >;

  /**
   * The ETag of the saved search. To override an existing saved search, use "*" or specify the current Etag
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SavedSearch,
    Response = ArmResourceUpdatedResponse<SavedSearch>
  >;

  /**
   * Deletes the specified saved search in a given workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteSync<SavedSearch, Response = ArmDeletedResponse>;

  /**
   * Gets the saved searches for a given Log Analytics Workspace
   */
  listByWorkspace is ArmResourceListByParent<
    SavedSearch,
    Response = ArmResponse<SavedSearchesListResult>
  >;
}

@@doc(SavedSearch.name, "The id of the saved search.");
@@doc(SavedSearch.properties, "The properties of the saved search.");
@@doc(SavedSearches.createOrUpdate::parameters.resource,
  "The parameters required to save a search."
);
