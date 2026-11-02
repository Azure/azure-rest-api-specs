import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
// FIXME: SqlPoolSchema has no properties property
/**
 * A Sql pool schema resource.
 */
@parentResource(SqlPool)
model SqlPoolSchema is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = SqlPoolSchema,
    KeyName = "schemaName",
    SegmentName = "schemas",
    NamePattern = ""
  >;
}

alias SqlPoolSchemaOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolParentParameters,
  {
    /** The name of the schema. */
    @segment("schemas")
    @key
    @path
    schemaName: string;
  }
>;

@armResourceOperations
interface SqlPoolSchemas {
  /**
   * Get Sql Pool schema
   */
  get is SqlPoolSchemaOps.Read<SqlPoolSchema>;

  /**
   * Gets schemas of a given SQL pool.
   */
  list is SqlPoolSchemaOps.List<
    SqlPoolSchema,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(SqlPoolSchema.name, "The name of the schema.");
