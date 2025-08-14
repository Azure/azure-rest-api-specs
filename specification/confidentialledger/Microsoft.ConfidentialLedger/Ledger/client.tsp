import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

@useDependency(ConfidentialLedger.Ledger.Versions.v2024_12_09_preview)
@useDependency(ConfidentialLedger.Certificate.Versions.v2024_12_09_preview)
namespace ConfidentialLedgerClients;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  service: ConfidentialLedger.Ledger,
  name: "ConfidentialLedgerClient",
})
interface ConfidentialLedgerClient
  extends ConfidentialLedger.Ledger.Operations {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@clientNamespace("ConfidentialLedger.Certificate", "python")
@client({
  service: ConfidentialLedger.Certificate,
  name: "ConfidentialLedgerCertificateClient",
})
interface ConfidentialLedgerCertificateClient {
  getLedgerIdentity is ConfidentialLedger.Certificate.getLedgerIdentity;
}
