import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SpendPlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * Spend plan term resource definition. A term represents a past configuration of a spend plan that was superseded by a scheduled change.
 */
@added(Versions.v2026_07_01_preview)
@parentResource(SpendPlan)
model SpendPlanTerm
  is Azure.ResourceManager.ProxyResource<SpendPlanTermProperties> {
  ...ResourceNameParameter<
    Resource = SpendPlanTerm,
    KeyName = "termName",
    SegmentName = "terms",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
@added(Versions.v2026_07_01_preview)
interface SpendPlanTerms {
  /**
   * Get a specific term of a spend plan.
   */
  get is ArmResourceRead<SpendPlanTerm>;

  /**
   * List all terms of a spend plan.
   */
  listByParent is ArmResourceListByParent<
    SpendPlanTerm,
    Response = ArmResponse<SpendPlanTermList>
  >;
}

@@doc(SpendPlanTerm.name, "Name of the spend plan term");
@@doc(SpendPlanTerm.properties, "Spend plan term properties");
