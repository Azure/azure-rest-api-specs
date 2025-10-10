import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/Models.tsp";
import "../Common/Enums.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Paas summary REST resource.")
@parentResource(BusinessCase)
model PaasSummary is ProxyResource<PaasSummaryProperties> {
  @doc("Gets the Name of the Paas Summary.")
  @key("paasSummaryName")
  @segment("paasSummaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a hydrated resource with no PUT call."
@doc("Paas summary properties class.")
model PaasSummaryProperties {
  @doc("Shows the PaaS Azure summary.")
  @visibility(Lifecycle.Read)
  azure?: AzurePaasSummary;

  @doc("Shows platform as a service (PaaS) summary.")
  @visibility(Lifecycle.Read)
  onPremises?: OnPremisesPaasSummary;
}

@doc("Shows the PaaS Azure summary.")
model AzurePaasSummary {
  @doc("Number of Sql instances.")
  @visibility(Lifecycle.Read)
  totalSqlEntities?: int32;

  @doc("Suitable Sql instances.")
  @visibility(Lifecycle.Read)
  suitableSqlEntities?: int32;

  @doc("Number of web applications.")
  @visibility(Lifecycle.Read)
  totalWebApps?: int32;

  @doc("Suitable web applications.")
  @visibility(Lifecycle.Read)
  suitableWebApps?: int32;

  @doc("Number of cores.")
  @visibility(Lifecycle.Read)
  cores?: int32;

  @doc("Memory Utilization.")
  @visibility(Lifecycle.Read)
  memory?: float32;

  @doc("Storage Utilization.")
  @visibility(Lifecycle.Read)
  storage?: float32;

  @doc("Shows the estimated cost by target.")
  @visibility(Lifecycle.Read)
  estimatedCostByTarget?: EstimatedCostByTarget;

  @doc("estimated SQL Server licensing cost.")
  @visibility(Lifecycle.Read)
  estimatedSqlServerLicensingCost?: float32;

  @doc("Shows the Azure SQL details.")
  @visibility(Lifecycle.Read)
  azureSqlSummary?: AzureSqlSummary;

  @doc("Shows Azure App Service summary.")
  @visibility(Lifecycle.Read)
  azureAppServiceSummary?: AzureAppServiceSummary;

  @doc("Shows Azure App Service Container summary.")
  @visibility(Lifecycle.Read)
  azureAppServiceContainerSummary?: AzureAppServiceContainerSummary;

  @doc("Shows Azure Kubernetes Service summary.")
  @visibility(Lifecycle.Read)
  azureKubernetesServiceSummary?: AzureKubernetesServiceSummary;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  totalAzurePaasCost?: CostDetails;

  @doc("The Azure PaaS Sustainability Emissions Details.")
  @visibility(Lifecycle.Read)
  azurePaasSustainabilityDetails?: CarbonEmissionsDetails;
}

@doc("Shows the estimated cost by target.")
model EstimatedCostByTarget {
  @doc("Azure SQL MI cost.")
  @visibility(Lifecycle.Read)
  azureSqlMiCost?: float32;

  @doc("Azure SQL DB cost.")
  @visibility(Lifecycle.Read)
  azureSqlDbCost?: float32;

  @doc("Azure App Service cost.")
  @visibility(Lifecycle.Read)
  appServiceCost?: float32;

  @doc("Azure App Service Containers cost.")
  @visibility(Lifecycle.Read)
  appServiceContainerCost?: float32;

  @doc("Azure Kubernetes Service cost.")
  @visibility(Lifecycle.Read)
  azureKubernetesServiceCost?: float32;
}

@doc("Shows the Azure SQL details.")
model AzureSqlSummary {
  @doc("Estimated cost by recommended offer.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  estimatedCostByOffer?: EstimatedCostByOffer[];

  @doc("Distribution by service tiers, retaining just to support older Business cases.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionByServiceTier?: SqlServiceTier[];

  @doc("Distribution by service tiers for SQL MI.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionByServiceTierForSqlMi?: SqlServiceTier[];

  @doc("Distribution by service tiers for SQL DB.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionByServiceTierForSqlDb?: SqlServiceTier[];
}

@doc("The SQL service tier.")
model SqlServiceTier {
  @doc("The service tier name.")
  @visibility(Lifecycle.Read)
  serviceTierName?: string;

  @doc("The number of sql entities with this tier.")
  @visibility(Lifecycle.Read)
  serviceTierNumber?: float32;
}

@doc("Shows Azure App Service summary.")
model AzureAppServiceSummary {
  @doc("Estimated cost by recommendation offer.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  estimatedCostByOffer?: EstimatedCostByOffer[];

  @doc("Distribution by SKU.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionBySku?: AppServiceSku[];

  @doc("Distribution by application type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionByApp?: WebAppDistribution[];
}

@doc("The app service SKU with corresponding cost.")
model AppServiceSku {
  @doc("The SKU name.")
  @visibility(Lifecycle.Read)
  skuName?: string;

  @doc("The cost details.")
  @visibility(Lifecycle.Read)
  cost?: float32;

  @doc("The number of service plans recommended.")
  @visibility(Lifecycle.Read)
  count?: int32;
}

@doc("The app type distribution.")
model WebAppDistribution {
  @doc("WebApp type.")
  @visibility(Lifecycle.Read)
  webAppType?: WebAppTypes;

  @doc("The cost details.")
  @visibility(Lifecycle.Read)
  numberOfWebApps?: float32;
}

@doc("Shows Azure App Service Container summary.")
model AzureAppServiceContainerSummary {
  @doc("Estimated cost by recommendation offer.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  estimatedCostByOffer?: EstimatedCostByOffer[];

  @doc("Distribution by SKU.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionBySku?: WebAppTargetSku[];

  @doc("Distribution by application type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionByApp?: WebAppDistribution[];
}

@doc("The Webapp target SKU with corresponding cost.")
model WebAppTargetSku {
  @doc("The SKU name.")
  @visibility(Lifecycle.Read)
  skuName?: string;

  @doc("The cost details.")
  @visibility(Lifecycle.Read)
  cost?: float32;

  @doc("The number of service plans or node pools recommended.")
  @visibility(Lifecycle.Read)
  count?: int32;
}

@doc("Shows Azure Kubernetes Service summary.")
model AzureKubernetesServiceSummary {
  @doc("Estimated cost by recommendation offer.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  estimatedCostByOffer?: EstimatedCostByOffer[];

  @doc("Distribution by SKU.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionBySku?: WebAppTargetSku[];

  @doc("Distribution by application type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionByApp?: WebAppDistribution[];
}

@doc("Shows platform as a service (PaaS) summary.")
model OnPremisesPaasSummary {
  @doc("Total servers.")
  @visibility(Lifecycle.Read)
  totalServers?: int32;

  @doc("CPU utilization percentage.")
  @visibility(Lifecycle.Read)
  cpuUtilization?: float32;

  @doc("Memory utilization percentage.")
  @visibility(Lifecycle.Read)
  memoryUtilization?: float32;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  totalOnPremisesPaasCost?: CostDetails;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  onPremisesPaasCostForDecommisioned?: CostDetails;

  @doc("The on premises paas licensing cost.")
  @visibility(Lifecycle.Read)
  onPremisesPaasLicensingCost?: OnPremisesPaasLicensingCost;

  @doc("The on premises SQL summary.")
  @visibility(Lifecycle.Read)
  onPremisesSqlSummary?: OnPremisesSqlSummary;

  @doc("The on premises web application summary.")
  @visibility(Lifecycle.Read)
  onPremisesWebAppSummary?: OnPremisesWebAppSummary;

  @doc("OS Support Status Distribution.")
  @visibility(Lifecycle.Read)
  osSupportStatusDistribution?: SupportStatusDistribution;

  @doc("Sql Support Status Distribution.")
  @visibility(Lifecycle.Read)
  sqlSupportStatusDistribution?: SupportStatusDistribution;

  @doc("OS Service Pack Insight.")
  @visibility(Lifecycle.Read)
  osServicePackInsight?: ServicePackInsight;

  @doc("Sql Service Pack Insight.")
  @visibility(Lifecycle.Read)
  sqlServicePackInsight?: ServicePackInsight;

  @doc("The on premises PaaS sustainability details.")
  @visibility(Lifecycle.Read)
  onPremisesPaasSustainabilityDetails?: CarbonEmissionsDetails;

  @doc("The on premises Paas Sustainability details for Decommissioned.")
  @visibility(Lifecycle.Read)
  onPremisesPaasDecommissionedSustainabilityDetails?: CarbonEmissionsDetails;
}

@doc("The on premises paas licensing cost.")
model OnPremisesPaasLicensingCost {
  @doc("The version.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("The total cost.")
  @visibility(Lifecycle.Read)
  totalCost?: float32;

  @doc("The decommissioned server cost.")
  @visibility(Lifecycle.Read)
  decomissionServerCost?: float32;
}

@doc("The on premises SQL summary.")
model OnPremisesSqlSummary {
  @doc("The number of SQL instances.")
  @visibility(Lifecycle.Read)
  sqlInstances?: int32;

  @doc("The number of SQL databases.")
  @visibility(Lifecycle.Read)
  sqlDatabases?: int32;

  @doc("Distribution by SQL version.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionBySqlVersion?: SqlVersionDetails[];

  @doc("The SQL on premises utilization insights.")
  @visibility(Lifecycle.Read)
  sqlOnPremisesUtilizationData?: UtilizationData;

  @doc("Distribution by Sql Edition.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  distributionBySqlEdition?: DistributionByType[];
}

@doc("The SQL version details.")
model SqlVersionDetails {
  @doc("The SQL version.")
  @visibility(Lifecycle.Read)
  sqlVersion?: string;

  @doc("Number of instances with the above SQL version.")
  @visibility(Lifecycle.Read)
  numberOfInstances?: int32;
}

@doc("The on premises web application summary.")
model OnPremisesWebAppSummary {
  @doc("The number of web servers.")
  @visibility(Lifecycle.Read)
  numberOfWebServers?: int32;

  @doc("The number of web applications.")
  @visibility(Lifecycle.Read)
  numberOfWebApplications?: int32;

  @doc("The number of web applications per web application type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  numberOfWebAppsPerType?: NameValuePair<string, int32>[];
}
