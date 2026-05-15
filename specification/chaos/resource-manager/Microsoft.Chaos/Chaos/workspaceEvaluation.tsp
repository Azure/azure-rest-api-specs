import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./workspaceEvaluation.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface WorkspaceEvaluations {
  /**
   * Get the latest workspace evaluation result.
   */
  get is ArmResourceRead<WorkspaceEvaluation>;
}
