import "../../Enums/Enums.tsp";
import "../../../Common/StandardizedContracts/AssessmentProperties.tsp";

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Data model of AKS Assessment Settings.")
model AKSAssessmentSettings is AssessmentSettings {
  @doc("Gets or sets azure VM category.")
  category: AzureVmCategory;

  @doc("Gets or sets consolidation type.")
  consolidation: ConsolidationType;

  @doc("Gets or sets pricing tier.")
  pricingTier: PricingTier;
}
