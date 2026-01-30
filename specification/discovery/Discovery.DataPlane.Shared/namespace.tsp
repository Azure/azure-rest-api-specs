import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Discovery.DataPlane.Shared.Versions)
namespace Microsoft.Discovery.DataPlane.Shared;

@doc("The Microsoft.Discovery.DataPlane.Shared versions.")
enum Versions {
  @doc("The 2025-07-01-preview version.")
  `2025-07-01-preview`,

  @doc("The 2025-12-01-preview version.")
  `2025-12-01-preview`,

  @doc("The 2026-02-01-preview version.")
  `2026-02-01-preview`,
}
