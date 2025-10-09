import "../../Common/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../../Common/StandardizedContracts/CostComponent.tsp";
import "../../Common/StandardizedContracts/SavingComponent.tsp";
import "../../Common/StandardizedContracts/CommonModels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Heterogeneous assessment summary resource.")
@parentResource(HeterogeneousAssessment)
model HeterogeneousAssessmentSummary
  is ProxyResource<HeterogeneousAssessmentSummaryProperties> {
  @doc("Gets the Name of the Heterogeneous assessment Summary.")
  @key("summaryName")
  @segment("summaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Summary property doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Heterogeneous assessment summary properties class.")
model HeterogeneousAssessmentSummaryProperties {
  @doc("The assessment name")
  @visibility(Lifecycle.Read)
  assessmentName?: string;

  @doc("The summary type")
  @visibility(Lifecycle.Read)
  summaryType?: SummaryType;

  @doc("Gets the migration type summaries.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  migrationPaths?: MigrationTypeSummaries[];

  @doc("Gets the readiness summary.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  readinessSummary?: NameValuePair<CloudSuitabilityCommon, int32>[];

  @doc("Gets the confidence score.")
  @visibility(Lifecycle.Read)
  confidenceScore?: float32;

  @doc("Gets the cost components.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  costComponents?: CostComponent[];

  @doc("Gets the saving component.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  savingComponent?: SavingComponent[];
}

@doc("Assessed machine properties class.")
model MigrationTypeSummaries {
  @doc("Gets the migration type.")
  @visibility(Lifecycle.Read)
  migrationType?: MigrationType;

  @doc("Gets the Platform.")
  @visibility(Lifecycle.Read)
  platform?: MigrationPlatform;

  @doc("Gets the readiness summary.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  readinessSummary?: NameValuePair<CloudSuitabilityCommon, int32>[];
}
