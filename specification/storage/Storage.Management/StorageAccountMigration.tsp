import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;
/**
 * The parameters or status associated with an ongoing or enqueued storage account migration in order to update its current SKU or region.
 */
@parentResource(StorageAccount)
model StorageAccountMigration
  is Azure.ResourceManager.ProxyResource<
    StorageAccountMigrationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = StorageAccountMigration,
    KeyName = "migrationName",
    SegmentName = "accountMigrations",
    NamePattern = "",
    Type = MigrationName
  >;
}

@armResourceOperations
interface StorageAccountMigrations {
  /**
   * Gets the status of the ongoing migration for the specified storage account.
   */
  getCustomerInitiatedMigration is ArmResourceRead<
    StorageAccountMigration,
    Error = ErrorResponse
  >;
}

@@doc(StorageAccountMigration.name,
  "The name of the Storage Account Migration. It should always be 'default'"
);
@@doc(StorageAccountMigration.properties,
  "The properties of a storage account’s ongoing or enqueued migration."
);
