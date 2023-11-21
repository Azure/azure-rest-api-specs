import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "ConfidentialLedger",
  version: "2023-01-26-preview",
})
@server(
  "{$host}",
  "Microsoft Azure Confidential Compute Ledger Control Plane REST API version 2020-12-01-preview.",
  {
    $host: string,
  }
)
@doc("""
Microsoft Azure Confidential Compute Ledger Control Plane REST API version
2020-12-01-preview.
""")
namespace ConfidentialLedger;
