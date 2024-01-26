import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A restorable dropped managed database resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@includeInapplicableMetadataInPayload(false)
model RestorableDroppedManagedDatabase extends TrackedResource {
  @path
  @key("restorableDroppedDatabaseId")
  @segment("restorableDroppedDatabases")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RestorableDroppedManagedDatabaseProperties;
}

@armResourceOperations
interface RestorableDroppedManagedDatabases {
  /**
   * Gets a restorable dropped managed database.
   */
  get is ArmResourceRead<RestorableDroppedManagedDatabase>;

  /**
   * Gets a list of restorable dropped managed databases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RestorableDroppedManagedDatabases_ListByInstance")
  listByInstance is ArmResourceListByParent<RestorableDroppedManagedDatabase>;
}
