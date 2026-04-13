import "../../Enums/Enums.tsp";
import "../../Common/StandardizedContracts/AssessmentProperties.tsp";

namespace Microsoft.Migrate;

@doc("Data model of Azure Container Apps Assessment Settings.")
model ContainerAppsAssessmentSettings is AssessmentSettings {
  @doc("Gets or sets the workload profile SKU.")
  sku: ContainerAppsWorkloadProfileSku;

  @doc("Gets or sets the workload profile type.")
  workloadProfileType: ContainerAppsWorkloadProfileType;
}
