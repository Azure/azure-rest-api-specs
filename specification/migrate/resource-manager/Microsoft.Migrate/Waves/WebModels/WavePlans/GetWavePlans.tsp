import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./WavePlanCommon.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Request body for the getWavePlans listing action.")
@added(ApiVersions.v2026_06_01_preview)
model GetWavePlansRequest {
  @doc("The assessment ARM ID to scope the listing to.")
  assessmentArmId: string;

  @doc("The optional migration path filter. When omitted, plans across all migration paths are returned.")
  migrationPath?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Response payload for the getWavePlans listing action.")
@added(ApiVersions.v2026_06_01_preview)
model GetWavePlansResponse {
  @doc("The wave plan list items. Always present; empty when no plans match the filter.")
  @identifiers(#["wavePlanName"])
  value: WavePlanListItem[];
}
