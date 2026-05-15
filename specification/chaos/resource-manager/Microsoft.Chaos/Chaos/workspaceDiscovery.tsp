import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./workspaceDiscovery.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface WorkspaceDiscoveries {
  /**
   * Get the latest workspace discovery result.
   */
  get is ArmResourceRead<WorkspaceDiscovery>;
}

@@doc(WorkspaceDiscovery.name, "Name of the discovery resource.");
@@doc(WorkspaceDiscovery.properties,
  "The properties of the workspace discovery."
);
