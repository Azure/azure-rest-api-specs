import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./discoveredResource.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@armResourceOperations
interface DiscoveredResources {
  /**
   * Get a discovered resource.
   */
  get is ArmResourceRead<DiscoveredResource>;

  /**
   * Get a list of discovered resources for a workspace.
   */
  listByWorkspace is ArmResourceListByParent<
    DiscoveredResource,
    Response = DiscoveredResourceListResult
  >;
}

@@minLength(DiscoveredResource.name, 1);
@@doc(DiscoveredResource.name, "Name of the discovered resource.");
@@doc(
  DiscoveredResource.properties,
  "The properties of the discovered resource."
);
