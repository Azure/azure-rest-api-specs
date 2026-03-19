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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface SecuritySolutions {
  /**
   * Gets a specific Security Solution.
   */
  get is ArmResourceRead<SecuritySolution>;
}

@@doc(SecuritySolution.name, "Name of security solution.");
@@doc(SecuritySolution.properties, "");
