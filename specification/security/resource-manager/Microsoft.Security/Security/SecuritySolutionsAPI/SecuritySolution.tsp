import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecuritySolutionsAPI;

@parentResource(ArmLocationResource)
model SecuritySolution
  is Azure.ResourceManager.ProxyResource<SecuritySolutionProperties> {
  ...ResourceNameParameter<
    Resource = SecuritySolution,
    KeyName = "securitySolutionName",
    SegmentName = "securitySolutions",
    NamePattern = ""
  >;

  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@tag("SecuritySolutions")
interface SecuritySolutions {
  /**
   * Gets a specific Security Solution.
   */
  get is ArmResourceRead<SecuritySolution, Error = CloudError>;
}

@@doc(SecuritySolution.name, "Name of security solution.");
@@doc(SecuritySolution.properties, "");
