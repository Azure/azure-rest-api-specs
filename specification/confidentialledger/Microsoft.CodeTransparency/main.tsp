import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@service({
  title: "Microsoft Code Transparency Service",
})
@useAuth(BearerAuth)
@server(
  "{endpoint}",
  "Code Transparency Service",
  {
    endpoint: url,
  }
)
@versioned(Microsoft.CodeTransparency.Versions)
namespace Microsoft.CodeTransparency;

@doc("The Microsoft.CodeTransparency service versions.")
enum Versions {
  #deprecated "Use next version"
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2024-01-11-preview version of the Microsoft.CodeTransparency service.")
  `2024-01-11-preview`,
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-01-31-preview version of the Microsoft.CodeTransparency service.")
  `2025-01-31-preview`,
}

// Additional supported traits by the API.
alias ServiceTraits = SupportsClientRequestId;
