import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;

@parentResource(ResourceGroupLocationResource)
model DiscoveredSecuritySolution
  is Azure.ResourceManager.ProxyResource<
    DiscoveredSecuritySolutionProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = DiscoveredSecuritySolution,
    KeyName = "discoveredSecuritySolutionName",
    SegmentName = "discoveredSecuritySolutions",
    NamePattern = ""
  >;

  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface DiscoveredSecuritySolutions {
  /**
   * Gets a specific discovered Security Solution.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  get is ArmResourceRead<DiscoveredSecuritySolution>;

  /**
   * Gets a list of discovered Security Solutions for the subscription and location.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByHomeRegion is Extension.ListByTarget<
    Extension.Subscription,
    DiscoveredSecuritySolution,
    Response = ArmResponse<DiscoveredSecuritySolutionList>
  >;
}

@@doc(DiscoveredSecuritySolution.name,
  "Name of a discovered security solution."
);
@@doc(DiscoveredSecuritySolution.properties, "");
