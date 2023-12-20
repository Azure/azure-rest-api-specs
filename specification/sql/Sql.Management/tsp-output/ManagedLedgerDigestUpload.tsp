import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Azure SQL Database ledger digest upload settings.")
@parentResource(ManagedDatabase)
model ManagedLedgerDigestUpload
  is ProxyResource<ManagedLedgerDigestUploadsProperties> {
  @path
  @key("ledgerDigestUploads")
  @segment("ledgerDigestUploads")
  name: ManagedLedgerDigestUploadsName;
}

@armResourceOperations
interface ManagedLedgerDigestUploads {
  @doc("Gets the current ledger digest upload configuration for a database.")
  get is ArmResourceRead<ManagedLedgerDigestUpload>;
  @doc("Enables upload ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedLedgerDigestUpload>;
  @doc("Gets all ledger digest upload settings on a database.")
  listByDatabase is ArmResourceListByParent<ManagedLedgerDigestUpload>;
  @doc("Disables uploading ledger digests to an Azure Storage account or an Azure Confidential Ledger instance.")
  disable is ArmResourceActionAsync<
    ManagedLedgerDigestUpload,
    void,
    ManagedLedgerDigestUpload
  >;
}
