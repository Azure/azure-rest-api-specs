import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A restorable dropped database resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
model RestorableDroppedDatabase
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<RestorableDroppedDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = RestorableDroppedDatabase,
    KeyName = "restorableDroppedDatabaseId",
    SegmentName = "restorableDroppedDatabases",
    NamePattern = ""
  >;

  /**
   * The name and tier of the SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;
}

@armResourceOperations
interface RestorableDroppedDatabases {
  /**
   * Gets a restorable dropped database.
   */
  get is ArmResourceRead<
    RestorableDroppedDatabase,
    Parameters = {
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
  listByServer is ArmResourceListByParent<RestorableDroppedDatabase>;
}

@@doc(RestorableDroppedDatabase.name, "");
@@doc(RestorableDroppedDatabase.properties, "Resource properties.");
