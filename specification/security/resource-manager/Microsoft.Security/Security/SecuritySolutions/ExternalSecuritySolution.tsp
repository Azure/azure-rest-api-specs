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
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecuritySolutionsAPI;
// FIXME: ExternalSecuritySolution has no properties property
/**
 * Represents a security solution external to Microsoft Defender for Cloud which sends information to an OMS workspace and whose data is displayed by Microsoft Defender for Cloud.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ResourceGroupLocationResource)
@discriminator("kind")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: ExternalSecuritySolutionKind;

  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@tag("ExternalSecuritySolutions")
interface ExternalSecuritySolutions {
  /**
   * Gets a specific external Security Solution.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  get is ArmResourceRead<ExternalSecuritySolution, Error = CloudError>;

  /**
   * Gets a list of external Security Solutions for the subscription and location.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByHomeRegion is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.Subscription,
    ExternalSecuritySolution,
    Response = ArmResponse<ExternalSecuritySolutionList>,
    Error = CloudError
  >;
}

@@doc(ExternalSecuritySolution.name, "Name of an external security solution.");
