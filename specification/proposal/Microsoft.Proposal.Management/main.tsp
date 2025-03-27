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
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
@server("https://localhost", "Server endpoint")
namespace Microsoft.Proposal;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2025-01-01-preview`,
}
