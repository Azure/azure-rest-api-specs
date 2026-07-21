import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./WavePlanCommon.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Request body for the importWavePlan action.")
@added(ApiVersions.v2026_06_01_preview)
model ImportWavePlanRequest {
  @doc("The assessment ARM ID to scope the import to.")
  assessmentArmId: string;

  @doc("The migration path identifying the existing wave plan being amended.")
  migrationPath: string;

  @doc("An optional caller-supplied SAS version ID. Must match the value passed to fetchSASUri when the CSV was staged.")
  sasVersionId?: string;
}

@doc("Response payload for the importWavePlan action.")
@added(ApiVersions.v2026_06_01_preview)
model ImportWavePlanResponse {
  ...WavePlanListItem;
}
