import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@tag("DiscoveredSecuritySolutions")
interface DiscoveredSecuritySolutions {
  /**
   * Gets a specific discovered Security Solution.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  get is ArmResourceRead<DiscoveredSecuritySolution, Error = CloudError>;

  /**
   * Gets a list of discovered Security Solutions for the subscription and location.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByHomeRegion is Extension.ListByTarget<
    Extension.Subscription,
    DiscoveredSecuritySolution,
    Response = ArmResponse<DiscoveredSecuritySolutionList>,
    Error = CloudError
  >;
}

@@doc(DiscoveredSecuritySolution.name,
  "Name of a discovered security solution."
);
@@doc(DiscoveredSecuritySolution.properties, "");
