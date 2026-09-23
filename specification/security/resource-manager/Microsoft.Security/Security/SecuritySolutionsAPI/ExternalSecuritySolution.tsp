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

namespace SecuritySolutionsAPI;
// FIXME: ExternalSecuritySolution has no properties property
/**
 * Represents a security solution external to Microsoft Defender for Cloud which sends information to an OMS workspace and whose data is displayed by Microsoft Defender for Cloud.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(ArmLocationResource)
@discriminator("kind")
model ExternalSecuritySolution extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = ExternalSecuritySolution,
    KeyName = "externalSecuritySolutionsName",
    SegmentName = "ExternalSecuritySolutions",
    NamePattern = ""
  >;

  /**
   * The resource-specific properties for this resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;

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
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@tag("ExternalSecuritySolutions")
interface ExternalSecuritySolutions {
  /**
   * Gets a specific external Security Solution.
   */
  get is ArmResourceRead<ExternalSecuritySolution, Error = CloudError>;

  /**
   * Gets a list of external Security Solutions for the subscription and location.
   */
  listByHomeRegion is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.Subscription,
    ExternalSecuritySolution,
    Response = ArmResponse<ExternalSecuritySolutionList>,
    Error = CloudError
  >;
}

@@doc(ExternalSecuritySolution.name, "Name of an external security solution.");
