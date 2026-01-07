import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

import "./proposal.tsp";
import "./product.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Proposal")
@service(#{ title: "Microsoft.Proposal" })
@doc("Microsoft.Proposal RP provides APIs to purchase, manage and display proposals in the Marketplace")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
@server("https://localhost", "Server endpoint")
namespace Microsoft.Proposal;

enum Versions {
  v2025_01_01_preview: "2025-01-01-preview",
}
