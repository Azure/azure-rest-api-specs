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
// FIXME: ExternalSecuritySolution has no properties property
/**
 * Represents a security solution external to Microsoft Defender for Cloud which sends information to an OMS workspace and whose data is displayed by Microsoft Defender for Cloud.
 */
@parentResource(ResourceGroupLocationResource)
model ExternalSecuritySolution is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = ExternalSecuritySolution,
    KeyName = "externalSecuritySolutionsName",
    SegmentName = "ExternalSecuritySolutions",
    NamePattern = ""
  >;

  /**
   * The kind of the external solution
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: ExternalSecuritySolutionKind;

  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ExternalSecuritySolutions {
  /**
   * Gets a specific external Security Solution.
   */
  get is ArmResourceRead<ExternalSecuritySolution>;

  /**
   * Gets a list of external Security Solutions for the subscription and location.
   */
  listByHomeRegion is ArmResourceListAtScope<
    ExternalSecuritySolution,
    // BaseParameters = Azure.ResourceManager.Foundations.LocationBaseParameters,
    Response = ArmResponse<ExternalSecuritySolutionList>
  >;
}

@@doc(ExternalSecuritySolution.name, "Name of an external security solution.");
