import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/Models.tsp";
import "../Common/Enums.tsp";
import "../../../Common/ArmModels/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Iaas summary REST resource.")
@parentResource(BusinessCase)
model IaasSummary is ProxyResource<IaasSummaryProperties> {
  @doc("Gets the Name of the Iaas Summary.")
  @key("iaasSummaryName")
  @segment("iaasSummaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a hydrated resource with no PUT call."
@doc("Iaas summary properties class.")
model IaasSummaryProperties {
  @doc("The Azure IaaS summary.")
  @visibility(Lifecycle.Read)
  azureIaasSummary?: AzureIaasSummary;

  @doc("The on premises IaaS summary.")
  @visibility(Lifecycle.Read)
  onPremisesIaasSummary?: OnPremisesIaasSummary;
}

@doc("The Azure IaaS summary.")
model AzureIaasSummary {
  @doc("Shows the year-on-year cost overall.")
  @visibility(Lifecycle.Read)
  yearOnYearEstimates?: YearOnYearEstimates;

  @doc("Azure Iaas virtual machine summary.")
  @visibility(Lifecycle.Read)
  azureIaasVmSummary?: AzureIaasVmSummary;

  @doc("Azure Iaas sql server summary.")
  @visibility(Lifecycle.Read)
  azureIaasSqlSummary?: AzureIaasSqlSummary;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  azureIaasCostDetails?: CostDetails;

  @doc("The azure Iaas sustainability details.")
  @visibility(Lifecycle.Read)
  azureIaasSustainabilityDetails?: CarbonEmissionsDetails;
}

@doc("Azure Iaas virtual machine summary.")
model AzureIaasVmSummary {
  @doc("Servers suitable for migration.")
  @visibility(Lifecycle.Read)
  serversSuitableForMigration?: int32;

  @doc("The total number of servers.")
  @visibility(Lifecycle.Read)
  totalNumberOfServers?: int32;

  @doc("The total number of IaaS VM cores.")
  @visibility(Lifecycle.Read)
  cores?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention GigaBytes and hence used GB, Gb would give Gigabits"
  @doc("The total memory in GB.")
  @visibility(Lifecycle.Read)
  memoryGB?: float32;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  azureVmCostDetails?: CostDetails;

  @doc("Estimated cost.")
  @visibility(Lifecycle.Read)
  estimatedCost?: float32;

  @doc("OS licensing cost.")
  @visibility(Lifecycle.Read)
  osLicensingCost?: float32;

  @doc("Estimated cost by offer.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  estimatedCostByRecommendedOffer?: EstimatedCostByOffer[];

  @doc("The recommended VM family summary.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  recommendedVmFamilySummary?: RecommendedVmFamilySummary[];

  @doc("The cost by storage type.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  costByStorageType?: CostByStorageType[];
}

@doc("Azure Iaas sql server summary.")
model AzureIaasSqlSummary {
  @doc("Total SQL entities.")
  @visibility(Lifecycle.Read)
  totalSqlEntities?: int32;

  @doc("Suitable SQL entities.")
  @visibility(Lifecycle.Read)
  suitableSqlEntities?: int32;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  azureSqlCostDetails?: CostDetails;

  @doc("Estimated cost.")
  @visibility(Lifecycle.Read)
  estimatedCost?: float32;

  @doc("OS licensing cost.")
  @visibility(Lifecycle.Read)
  osLicensingCost?: float32;

  @doc("Estimated cost by offer.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  estimatedCostByRecommendedOffer?: EstimatedCostByOffer[];

  @doc("The recommended VM family summary.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  recommendedVmFamilySummary?: RecommendedVmFamilySummary[];

  @doc("The cost by storage type.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  costByStorageType?: CostByStorageType[];
}

@doc("The on premises IAAS summary.")
model OnPremisesIaasSummary {
  @doc("The number of servers.")
  @visibility(Lifecycle.Read)
  servers?: int32;

  @doc("The number of cores.")
  @visibility(Lifecycle.Read)
  cores?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention GigaBytes and hence used GB, Gb would give Gigabits"
  @doc("Total memory in GB.")
  @visibility(Lifecycle.Read)
  memoryGB?: float32;

  @doc("The CPU utilization.")
  @visibility(Lifecycle.Read)
  cpuUtilization?: float32;

  @doc("The memory utilization.")
  @visibility(Lifecycle.Read)
  memoryUtilization?: float32;

  @doc("The storage utilization.")
  @visibility(Lifecycle.Read)
  storageUtilization?: float32;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  onPremisesIaasCostDetails?: CostDetails;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  onPremisesIaasCostForDecommissioned?: CostDetails;

  @doc("The OS licensing details.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  osLicensingDetails?: IaasOsLicensingDetails[];

  @doc("The distribution by operating system.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  distributionByOperatingSystem?: DistributionByOperatingSystem[];

  @doc("The SQL on premises utilization insights.")
  @visibility(Lifecycle.Read)
  onPremisesUtilizationData?: UtilizationData;

  @doc("The distribution by virtualization.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  distributionByVirtualization?: DistributionByVirtualization[];

  @doc("Iaas OS Support Status Distribution.")
  @visibility(Lifecycle.Read)
  iaasOsSupportStatusDistribution?: SupportStatusDistribution;

  @doc("Iaas Sql Support Status Distribution.")
  @visibility(Lifecycle.Read)
  iaasSqlSupportStatusDistribution?: SupportStatusDistribution;

  @doc("OS Service Pack Insight.")
  @visibility(Lifecycle.Read)
  osServicePackInsight?: ServicePackInsight;

  @doc("Sql Service Pack Insight.")
  @visibility(Lifecycle.Read)
  sqlServicePackInsight?: ServicePackInsight;

  @doc("Distribution by Operating System Version.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  distributionByOperatingSystemVersion?: DistributionByType[];

  @doc("Distribution by Sql Version.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  distributionBySqlVersion?: DistributionByType[];

  @doc("Distribution by Sql Edition.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  distributionBySqlEdition?: DistributionByType[];

  @doc("The on premises Iaas Sustainability details.")
  @visibility(Lifecycle.Read)
  onPremisesIaasSustainabilityDetails?: CarbonEmissionsDetails;

  @doc("The on premises Iaas Sustainability details for Decommissioned.")
  @visibility(Lifecycle.Read)
  onPremisesIaasDecommissionedSustainabilityDetails?: CarbonEmissionsDetails;
}

@doc("The Iaas OS licensing details.")
model IaasOsLicensingDetails {
  @doc("The OS type.")
  @visibility(Lifecycle.Read)
  osType?: string;

  @doc("The total cost.")
  @visibility(Lifecycle.Read)
  totalCost?: float32;

  @doc("The decommission cost.")
  @visibility(Lifecycle.Read)
  decomissionCost?: float32;
}
