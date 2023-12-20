import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Azure SQL Database ledger digest upload settings.")
@parentResource(SqlDatabase)
model LedgerDigestUpload is ProxyResource<LedgerDigestUploadsProperties> {
  @path
  @key("ledgerDigestUploads")
  @segment("ledgerDigestUploads")
  name: LedgerDigestUploadsName;
}

@armResourceOperations
interface LedgerDigestUploads {
  @doc("Gets the current ledger digest upload configuration for a database.")
  get is ArmResourceRead<LedgerDigestUpload>;
  @doc("Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LedgerDigestUpload>;
  @doc("Gets all ledger digest upload settings on a database.")
  listByDatabase is ArmResourceListByParent<LedgerDigestUpload>;
  @doc("Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.")
  disable is ArmResourceActionAsync<
    LedgerDigestUpload,
    void,
    LedgerDigestUpload
  >;
}
