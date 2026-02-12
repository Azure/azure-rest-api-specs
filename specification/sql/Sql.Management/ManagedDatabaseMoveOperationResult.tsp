import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed database move operation.
 */
@parentResource(ResourceGroupLocationResource)
model ManagedDatabaseMoveOperationResult
  is Azure.ResourceManager.ProxyResource<ManagedDatabaseMoveOperationResultProperties> {
  ...ResourceNameParameter<
    Resource = ManagedDatabaseMoveOperationResult,
    KeyName = "operationId",
    SegmentName = "managedDatabaseMoveOperationResults",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedDatabaseMoveOperationResults {
  /**
   * Gets a managed database move operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseMoveOperations_Get")
  get is ArmResourceRead<ManagedDatabaseMoveOperationResult>;

  /**
   * Lists managed database move operations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseMoveOperations_ListByLocation")
  listByLocation is ArmResourceListByParent<
    ManagedDatabaseMoveOperationResult,
    Parameters = {
      /**
       * Whether or not to only get the latest operation for each database. Has higher priority than $filter.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format"
@@format(ManagedDatabaseMoveOperationResult.name, "uuid");
@@doc(ManagedDatabaseMoveOperationResult.name, "");
@@doc(ManagedDatabaseMoveOperationResult.properties, "Resource properties.");
