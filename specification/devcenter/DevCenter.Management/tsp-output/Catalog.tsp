import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a catalog.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DevCenter)
@Azure.ResourceManager.Private.armResourceInternal(CatalogProperties)
@includeInapplicableMetadataInPayload(false)
model Catalog extends ProxyResourceBase {
  /**
   * The name of the Catalog.
   */
  @path
  @key("catalogName")
  @segment("catalogs")
  name: string;

  /**
   * Catalog properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CatalogProperties;
}

@armResourceOperations
interface Catalogs {
  /**
   * Gets a catalog
   */
  get is ArmResourceRead<Catalog>;

  /**
   * Creates or updates a catalog.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Catalog,
    BaseParameters<Catalog>,
    ArmAsyncOperationHeader
  >;

  /**
   * Partially updates a catalog.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Catalog,
    CatalogUpdate,
    BaseParameters<Catalog>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a catalog resource.
   */
  delete is ArmResourceDeleteAsync<
    Catalog,
    BaseParameters<Catalog>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists catalogs for a devcenter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Catalogs_ListByDevCenter")
  listByDevCenter is ArmResourceListByParent<
    Catalog,
    {
      ...BaseParameters<Catalog>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Syncs templates for a template source.
   */
  sync is ArmResourceActionNoResponseContentAsync<
    Catalog,
    void,
    BaseParameters<Catalog>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(Catalogs.createOrUpdate::parameters.resource, "json", "body");
@@extension(Catalogs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Catalogs.createOrUpdate::parameters.resource, "Represents a catalog.");
@@projectedName(Catalogs.update::parameters.properties, "json", "body");
@@extension(Catalogs.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Catalogs.update::parameters.properties, "Updatable catalog properties.");
