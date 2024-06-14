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
/**
 * Azure SQL Database ledger digest upload settings.
 */
@parentResource(Database)
model LedgerDigestUploads is ProxyResource<LedgerDigestUploadsProperties> {
  @path
  @key("ledgerDigestUploads")
  @segment("ledgerDigestUploads")
  name: LedgerDigestUploadsName;
}

@armResourceOperations
@projectedName("client", "LedgerDigestUploads")
interface LedgerDigestUploadsOperationGroup {
  /**
   * Gets the current ledger digest upload configuration for a database.
   */
  get is ArmResourceRead<LedgerDigestUploads>;

  /**
   * Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LedgerDigestUploads>;

  /**
   * Gets all ledger digest upload settings on a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LedgerDigestUploads_ListByDatabase")
  listByDatabase is ArmResourceListByParent<LedgerDigestUploads>;

  /**
   * Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  disable is ArmResourceActionAsync<
    LedgerDigestUploads,
    void,
    LedgerDigestUploads
  >;
}

@@projectedName(LedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  ""
);
