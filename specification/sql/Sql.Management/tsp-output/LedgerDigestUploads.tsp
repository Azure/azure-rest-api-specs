import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Azure SQL Database ledger digest upload settings.")
@parentResource(Database)
model LedgerDigestUploads is ProxyResource<LedgerDigestUploadsProperties> {
  @path
  @key("ledgerDigestUploads")
  @segment("ledgerDigestUploads")
  name: LedgerDigestUploadsName;
}

@armResourceOperations
interface LedgerDigestUploads {
  @doc("Gets the current ledger digest upload configuration for a database.")
  get is ArmResourceRead<LedgerDigestUploads>;
  @doc("Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LedgerDigestUploads>;
  @doc("Gets all ledger digest upload settings on a database.")
  listByDatabase is ArmResourceListByParent<LedgerDigestUploads>;
  @doc("Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.")
  disable is ArmResourceActionAsync<
    LedgerDigestUploads,
    void,
    LedgerDigestUploads
  >;
}
