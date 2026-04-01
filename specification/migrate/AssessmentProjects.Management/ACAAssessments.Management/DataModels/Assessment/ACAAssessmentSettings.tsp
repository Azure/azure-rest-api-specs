import "../../Enums/Enums.tsp";
import "../../Common/StandardizedContracts/AssessmentProperties.tsp";

namespace Microsoft.Migrate;

@doc("Data model of ACA Assessment Settings.")
model ACAAssessmentSettings is AssessmentSettings {
  @doc("Gets or sets the workload profile SKU category.")
  category: ACAWorkloadProfileSku;

  @doc("Gets or sets the workload profile type.")
  workloadProfileType: ACAWorkloadProfileType;

  @doc("Gets or sets pricing tier.")
  pricingTier: PricingTier;
}
