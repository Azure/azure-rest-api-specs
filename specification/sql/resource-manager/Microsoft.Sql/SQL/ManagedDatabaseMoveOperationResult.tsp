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

alias ManagedDatabaseMoveOperationResultsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the region where the resource is located. */
    @path
    @segment("locations")
    @key
    locationName: string;
  },
  {
    /** The ID of the managed database move operation. */
    @path
    @segment("managedDatabaseMoveOperationResults")
    @key
    operationId: Azure.Core.uuid;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface ManagedDatabaseMoveOperationResults {
  /**
   * Gets a managed database move operation.
   */
  @tag("ManagedDatabaseMoveOperations")
  get is ManagedDatabaseMoveOperationResultsOps.Read<ManagedDatabaseMoveOperationResult>;

  /**
   * Lists managed database move operations.
   */
  @tag("ManagedDatabaseMoveOperations")
  listByLocation is ManagedDatabaseMoveOperationResultsOps.List<
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
    },
    Response = ManagedDatabaseMoveOperationListResult
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@format(ManagedDatabaseMoveOperationResult.name, "uuid");
@@doc(ManagedDatabaseMoveOperationResult.name, "");
@@doc(ManagedDatabaseMoveOperationResult.properties, "Resource properties.");
