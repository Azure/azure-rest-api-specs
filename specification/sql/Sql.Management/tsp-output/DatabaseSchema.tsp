import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
// FIXME: DatabaseSchema has no properties property
/**
 * A database schema resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Database)
@includeInapplicableMetadataInPayload(false)
model DatabaseSchema extends ProxyResource {
  /**
   * The name of the schema.
   */
  @path
  @key("schemaName")
  @segment("schemas")
  @visibility("read")
  name: string;

  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties?: {};
}

@armResourceOperations
interface DatabaseSchemas {
  /**
   * Get database schema
   */
  get is ArmResourceRead<DatabaseSchema>;

  /**
   * List database schemas
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseSchemas_ListByDatabase")
  listByDatabase is ArmResourceListByParent<
    DatabaseSchema,
    {
      ...BaseParameters<DatabaseSchema>;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
