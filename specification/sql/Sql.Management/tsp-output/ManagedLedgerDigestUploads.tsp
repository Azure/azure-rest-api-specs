import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Azure SQL Database ledger digest upload settings.
 */
@parentResource(ManagedDatabase)
model ManagedLedgerDigestUploads
  is ProxyResource<ManagedLedgerDigestUploadsProperties> {
  @path
  @key("ledgerDigestUploads")
  @segment("ledgerDigestUploads")
  name: ManagedLedgerDigestUploadsName;
}

@armResourceOperations
@projectedName("client", "ManagedLedgerDigestUploads")
interface ManagedLedgerDigestUploadsOperationGroup {
  /**
   * Gets the current ledger digest upload configuration for a database.
   */
  get is ArmResourceRead<ManagedLedgerDigestUploads>;

  /**
   * Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedLedgerDigestUploads>;

  /**
   * Gets all ledger digest upload settings on a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedLedgerDigestUploads_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedLedgerDigestUploads>;

  /**
   * Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.
   */
  disable is ArmResourceActionAsync<
    ManagedLedgerDigestUploads,
    void,
    ManagedLedgerDigestUploads
  >;
}

@@projectedName(ManagedLedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedLedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedLedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "The Ledger Digest Storage Endpoint."
);
