import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed database restore details.
 */
@parentResource(ManagedDatabase)
model ManagedDatabaseRestoreDetailsResult
  is Azure.ResourceManager.ProxyResource<ManagedDatabaseRestoreDetailsProperties> {
  ...ResourceNameParameter<
    Resource = ManagedDatabaseRestoreDetailsResult,
    KeyName = "restoreDetailsName",
    SegmentName = "restoreDetails",
    NamePattern = "",
    Type = RestoreDetailsName
  >;
}

@armResourceOperations
interface ManagedDatabaseRestoreDetailsResults {
  /**
   * Gets managed database restore details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseRestoreDetails_Get")
  get is ArmResourceRead<ManagedDatabaseRestoreDetailsResult>;
}

@@doc(ManagedDatabaseRestoreDetailsResult.name,
  "The name of the restore details to retrieve."
);
@@doc(ManagedDatabaseRestoreDetailsResult.properties, "Resource properties.");
