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

@doc("Overview summary REST resource.")
@parentResource(BusinessCase)
model OverviewSummary is ProxyResource<OverviewSummaryProperties> {
  @doc("Gets the Name of the Overview Summary.")
  @key("overviewSummaryName")
  @segment("overviewSummaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a hydrated resource with no PUT call."
@doc("Overview summary properties class.")
model OverviewSummaryProperties {
  @doc("The total Azure cost..")
  @visibility(Lifecycle.Read)
  totalAzureCost?: float32;

  @doc("The total Azure IaaS cost.")
  @visibility(Lifecycle.Read)
  totalAzureIaasCost?: float32;

  @doc("The total Azure PaaS cost.")
  @visibility(Lifecycle.Read)
  totalAzurePaasCost?: float32;

  @doc("The total Avs cost.")
  @visibility(Lifecycle.Read)
  totalAzureAvsCost?: float32;

  @doc("The windows ahub saving.")
  @visibility(Lifecycle.Read)
  windowsAhubSavings?: float32;

  @doc("The linux ahub saving.")
  @visibility(Lifecycle.Read)
  linuxAhubSavings?: float32;

  @doc("The sql ahub saving.")
  @visibility(Lifecycle.Read)
  sqlAhubSavings?: float32;

  @doc("The total on premises cost.")
  @visibility(Lifecycle.Read)
  totalOnPremisesCost?: float32;

  @doc("ESU Savings 4 Years.")
  @visibility(Lifecycle.Read)
  esuSavingsFor4years?: float32;

  @doc("The management cost saving.")
  @visibility(Lifecycle.Read)
  managementCostSavings?: float32;

  @doc("The security cost saving.")
  @visibility(Lifecycle.Read)
  securityCostSavings?: float32;

  @doc("Shows the year-on-year cost overall.")
  @visibility(Lifecycle.Read)
  yearOnYearEstimates?: YearOnYearEstimates;

  @doc("Shows the discovered servers by virtualization platform.")
  @visibility(Lifecycle.Read)
  serversDiscovered?: ServersDiscovered;

  @doc("The SQL on premises utilization insights.")
  @visibility(Lifecycle.Read)
  utilizationData?: UtilizationData;

  @doc("Shows the infrastructure as a service machine OS distribution.")
  @visibility(Lifecycle.Read)
  iaasOsDistribution?: IaasOsDistribution;

  @doc("OS Support Status Distribution.")
  @visibility(Lifecycle.Read)
  osSupportStatusDistribution?: SupportStatusDistribution;

  @doc("Sql Support Status Distribution.")
  @visibility(Lifecycle.Read)
  sqlSupportStatusDistribution?: SupportStatusDistribution;

  @doc("Shows the distribution of platforms.")
  @visibility(Lifecycle.Read)
  paasDistribution?: PaasDistribution;

  @doc("The total Azure arc enabled on-premises cost assuming all on-premises infra is arc enabled.")
  @visibility(Lifecycle.Read)
  azureArcEnabledOnPremisesCost?: float32;

  @doc("The final cost including azure and azure arc enabled on-premises considering the remaining on-prem infra is arc enabled.")
  @visibility(Lifecycle.Read)
  futureCostIncludingAzureArc?: float32;

  @doc("ESU Savings in 4 Years considering the remaining on-prem infra each year is arc enabled.")
  @visibility(Lifecycle.Read)
  futureEsuSavingsFor4YearsIncludingAzureArc?: float32;

  @doc("The management cost saving considering the remaining on-prem infra is arc enabled")
  @visibility(Lifecycle.Read)
  futureManagementCostSavingsIncludingAzureArc?: float32;

  @doc("The security cost saving considering the remaining on-prem infra is arc enabled.")
  @visibility(Lifecycle.Read)
  futureSecurityCostSavingsIncludingAzureArc?: float32;

  @doc("The total cost of services offered by azure arc.")
  @visibility(Lifecycle.Read)
  azureArcServicesCost?: float32;

  @doc("The Iaas component of the future azure cost based on the final migration percentage.")
  @visibility(Lifecycle.Read)
  futureAzureIaasCost?: float32;

  @doc("The Paas component of the future azure cost based on the final migration percentage.")
  @visibility(Lifecycle.Read)
  futureAzurePaasCost?: float32;

  @doc("The future azure arc cost based on the final migration percentage.")
  @visibility(Lifecycle.Read)
  futureAzureArcEnabledOnPremisesCost?: float32;

  @doc("The total cost of services offered by azure arc based on the final migration percentage.")
  @visibility(Lifecycle.Read)
  futureAzureArcServicesCost?: float32;

  @doc("The total on-premises sustainability estimates.")
  @visibility(Lifecycle.Read)
  totalOnPremisesSustainabilityDetails: CarbonEmissionsDetails;

  @doc("The total azure sustainability estimates.")
  @visibility(Lifecycle.Read)
  totalAzureSustainabilityDetails: CarbonEmissionsDetails;
}

@doc("Shows the discovered servers by virtualization platform.")
model ServersDiscovered {
  @doc("Number of servers on VMWare.")
  @visibility(Lifecycle.Read)
  vmWare?: int32;

  @doc("Number of servers on HyperV.")
  @visibility(Lifecycle.Read)
  hyperV?: int32;

  @doc("Number of physical servers.")
  @visibility(Lifecycle.Read)
  physical?: int32;

  @doc("Number of servers whose virtualization is unknown.")
  @visibility(Lifecycle.Read)
  notApplicable?: int32;
}

@doc("Shows the infrastructure as a service machine OS distribution.")
model IaasOsDistribution {
  @doc("Number of Windows servers.")
  @visibility(Lifecycle.Read)
  windows?: int32;

  @doc("Number of Linux servers.")
  @visibility(Lifecycle.Read)
  linux?: int32;

  @doc("Number of servers neither Windows or Linux.")
  @visibility(Lifecycle.Read)
  other?: int32;
}

@doc("Shows the distribution of platforms.")
model PaasDistribution {
  @doc("Number of SQL Server machines.")
  @visibility(Lifecycle.Read)
  sqlServers?: int32;

  @doc("Number of IIS Web servers.")
  @visibility(Lifecycle.Read)
  iisWebServers?: int32;

  @doc("Distribution of webapps for each target type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  webAppDistribution?: NameValuePair<string, int32>[];
}
