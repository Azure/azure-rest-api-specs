import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespace.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Discovery.Shared.Versions)
namespace Microsoft.Discovery.Shared;

@doc("The Microsoft.Discovery.Shared versions.")
enum Versions {
  @doc("The 2025-07-01-preview version of the Microsoft.Discovery.Shared.")
  `2025-07-01-preview`,

  @doc("The 2025-12-01-preview version of the Microsoft.Discovery.Shared.")
  `2025-12-01-preview`,
}
