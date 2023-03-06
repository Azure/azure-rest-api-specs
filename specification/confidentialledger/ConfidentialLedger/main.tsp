import "@typespec/rest";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

@service({
  title: "Azure Confidential Ledger",
})
@Versioning.versioned(Versions)
@server(
  "{endpoint}/app",
  "Confidential Ledger writes and retrieves ledger entries against the Confidential Ledger service.",
  {
    @doc("""
The Confidential Ledger URL, for example
https://contoso.confidentialledger.azure.com
""")
    endpoint: string,
  }
)
@doc("""
Confidential Ledger writes and retrieves ledger entries against the
Confidential Ledger service.
""")
namespace Azure.ConfidentialLedger;

enum Versions {
  v2022_05_23: "2022-05-23",
  v2022_10_25: "2022-10-25",
  latest: "2022-10-25",
}