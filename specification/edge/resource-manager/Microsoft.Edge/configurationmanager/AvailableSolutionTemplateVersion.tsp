import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Available Solution template Version along with latest revision")
model AvailableSolutionTemplateVersion {
  @doc("Solution template Version")
  solutionTemplateVersion: string;

  @doc("Latest Configuration Revision")
  latestConfigRevision: string;

  @doc("Has this solution template version been configured")
  isConfigured: boolean;
}
