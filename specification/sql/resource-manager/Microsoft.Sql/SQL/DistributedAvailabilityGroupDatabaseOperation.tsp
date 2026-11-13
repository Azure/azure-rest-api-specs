import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./DistributedAvailabilityGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Sql;

/**
 * An operation on a database in a distributed availability group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits generated specifications by feature."
@added(Versions.v2026_11_01_preview)
@parentResource(DistributedAvailabilityGroup)
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.DistributedAvailabilityGroupDatabaseOperationFeatures.DistributedAvailabilityGroupsDatabaseOperations
)
model DistributedAvailabilityGroupDatabaseOperation
  is Azure.ResourceManager.ProxyResource<DistributedAvailabilityGroupDatabaseOperationProperties> {
  ...ResourceNameParameter<
    Resource = DistributedAvailabilityGroupDatabaseOperation,
    KeyName = "operationId",
    SegmentName = "databaseOperations",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits generated specifications by feature."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.DistributedAvailabilityGroupDatabaseOperationFeatures.DistributedAvailabilityGroupsDatabaseOperations
)
interface DistributedAvailabilityGroupsDatabaseOperations {
  /**
   * Gets a database operation of the distributed availability group.
   */
  get is ArmResourceRead<DistributedAvailabilityGroupDatabaseOperation>;

  /**
   * Gets a list of database operations for the distributed availability group.
   */
  listByDistributedAvailabilityGroup is ArmResourceListByParent<
    DistributedAvailabilityGroupDatabaseOperation,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = DistributedAvailabilityGroupDatabaseOperationListResult
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format" "The service identifies database operations by GUID; preserves the service contract."
@@format(DistributedAvailabilityGroupDatabaseOperation.name, "uuid");
@@doc(
  DistributedAvailabilityGroupDatabaseOperation.name,
  "The database operation identifier."
);
@@doc(
  DistributedAvailabilityGroupDatabaseOperation.properties,
  "Resource properties."
);
