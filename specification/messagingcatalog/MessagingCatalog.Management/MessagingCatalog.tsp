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

namespace Microsoft.MessagingCatalog;
/**
 * A Messaging Catalog resource
 */
model MessagingCatalog
  is Azure.ResourceManager.TrackedResource<MessagingCatalogProperties> {
  /**
   * The name of the Messaging Catalog
   */
  @pattern("^[a-zA-Z0-9-]{3,60}$")
  @minLength(3)
  @maxLength(60)
  @path
  @key("catalogName")
  @segment("catalogs")
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
interface MessagingCatalogs {
  /**
   * Get a messaging catalog
   */
  get is ArmResourceRead<MessagingCatalog>;

  /**
   * Create or update a messaging catalog
   */
  create is ArmResourceCreateOrReplaceAsync<MessagingCatalog>;

  /**
   * Update a messaging catalogs
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<MessagingCatalog, MessagingCatalogUpdate>;

  /**
   * Delete a messaging catalogs
   */
  delete is ArmResourceDeleteSync<MessagingCatalog>;

  /**
   * List MessagingCatalog resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("MessagingCatalogs_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<MessagingCatalog>;

  /**
   * List MessagingCatalog resources by subscription ID
   */
  listBySubscription is ArmListBySubscription<MessagingCatalog>;

  associate is ArmResourceActionAsync<
    MessagingCatalog,
    Association,
    Association,
    BaseParameters<Association>
  >;

  listAssociations is ArmResourceActionAsync<
    MessagingCatalog,
    AssociationListRequest,
    AssociationListResponse
  >;

  removeAssociation is ArmResourceActionAsync<
    MessagingCatalog,
    AssociationRemoveRequest,
    AssociationDeleteResponse
  >;
}
