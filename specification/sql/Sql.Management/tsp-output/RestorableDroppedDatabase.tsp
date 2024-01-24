import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A restorable dropped database resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Server)
@Azure.ResourceManager.Private.armResourceInternal(
  RestorableDroppedDatabaseProperties
)
@includeInapplicableMetadataInPayload(false)
model RestorableDroppedDatabase extends ProxyResource {
  @path
  @key("restorableDroppedDatabaseId")
  @segment("restorableDroppedDatabases")
  name: string;

  /**
   * The name and tier of the SKU.
   */
  sku?: Sku;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RestorableDroppedDatabaseProperties;
}

@armResourceOperations
interface RestorableDroppedDatabases {
  /**
   * Gets a restorable dropped database.
   */
  get is ArmResourceRead<
    RestorableDroppedDatabase,
    {
      ...BaseParameters<RestorableDroppedDatabase>;

      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets a list of restorable dropped databases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RestorableDroppedDatabases_ListByServer")
  listByServer is ArmResourceListByParent<RestorableDroppedDatabase>;
}
