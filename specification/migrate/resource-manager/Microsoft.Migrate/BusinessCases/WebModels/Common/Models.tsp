import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using Microsoft.Migrate;

@doc("Shows the year-on-year cost overall.")
model YearOnYearEstimates {
  @doc("Year-on-Year on-premises cost.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  onPremisesCost?: YearOnYearCost[];

  @doc("Year-on-Year Azure cost.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  azureCost?: YearOnYearCost[];

  @doc("Year-on-Year savings.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  savings?: YearOnYearCost[];

  @removed(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("Year-on-Year on-premises capex cost.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  onPremisesCapexCost?: YearOnYearCost[];

  @removed(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("Year-on-Year on-premises opex cost.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  onPremisesOpexCost?: YearOnYearCost[];

  @removed(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("Year-on-Year azure capex cost.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  azureCapexCost?: YearOnYearCost[];

  @removed(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("Year-on-Year azure opex cost.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  azureOpexCost?: YearOnYearCost[];

  @doc("Payback period.")
  @visibility(Lifecycle.Read)
  paybackPeriod?: int32;

  @doc("Year-on-Year azure arc enabled on-premises cost.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  azureArcEnabledOnPremisesCost?: YearOnYearCost[];

  @doc("Year-on-Year azure with arc enabled on-premises cost.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  futureCost?: YearOnYearCost[];

  @doc("Year-on-Year azure arc enabled on-premises esu cost of the remaining infra on-premises.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  futureAzureArcEnabledOnPremisesEsuCost?: YearOnYearCost[];

  @doc("Year-on-Year on-premises esu cost of the remaining infra on-premises.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  futureOnPremisesEsuCost?: YearOnYearCost[];

  @doc("Year-on-Year on-premises emissions estimates.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  onPremisesEmissionsEstimates?: YearOnYearEmissions[];

  @doc("Year-on-Year Azure emissions estimates.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  azureEmissionsEstimates?: YearOnYearEmissions[];
}

@doc("Year on Year cost.")
model YearOnYearCost {
  @doc("Year value.")
  year: Year;

  @doc("Cost for the specified year.")
  cost?: float32;
}

@doc("Year on Year Emissions.")
model YearOnYearEmissions {
  @doc("Year value.")
  year: Year;

  @doc("Emissions for the specified year.")
  emissions?: float32;
}

@doc("The estimated cost by offer.")
model EstimatedCostByOffer {
  @doc("The offer name.")
  @visibility(Lifecycle.Read)
  offerName?: string;

  @doc("Cost for the offer.")
  @visibility(Lifecycle.Read)
  cost?: float32;
}

@doc("The recommended VM family summary.")
model RecommendedVmFamilySummary {
  @doc("The Azure VM family.")
  @visibility(Lifecycle.Read)
  azureVmFamily?: string;

  @doc("The number of machines.")
  @visibility(Lifecycle.Read)
  numberOfMachines?: int32;
}

@doc("The cost by storage type.")
model CostByStorageType {
  @doc("The storage type.")
  @visibility(Lifecycle.Read)
  storageType?: string;

  @doc("Cost per storage type.")
  @visibility(Lifecycle.Read)
  cost?: float32;
}

@doc("The distribution by operating system.")
model DistributionByOperatingSystem {
  @doc("The Os classification type.")
  @visibility(Lifecycle.Read)
  osClassificationType?: string;

  @doc("The number of machines with the OS type classification.")
  @visibility(Lifecycle.Read)
  count?: int32;
}

@doc("The SQL on premises utilization insights.")
model UtilizationData {
  @doc("The number of active entities.")
  @visibility(Lifecycle.Read)
  numberOfActiveEntities?: int32;

  @doc("The number of inactive entities.")
  @visibility(Lifecycle.Read)
  numberOfInactiveEntities?: int32;

  @doc("The number of decommission entities.")
  @visibility(Lifecycle.Read)
  numberOfDecommisionEntities?: int32;

  @doc("The number of unknown entities.")
  @visibility(Lifecycle.Read)
  numberOfUnknownEntities?: int32;
}

@doc("The distribution by virtualization.")
model DistributionByVirtualization {
  @doc("The Virtualization type.")
  @visibility(Lifecycle.Read)
  virtualizationType?: string;

  @doc("The number of machines with the Virtualization type classification.")
  @visibility(Lifecycle.Read)
  count?: int32;
}

@doc("Download URL for assessment report.")
model ReportDownloadUrl {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("Hyperlink to download report.")
  @visibility(Lifecycle.Read)
  businessCaseReportUrl?: string;

  @doc("Expiry date of download url.")
  @visibility(Lifecycle.Read)
  expirationTime?: utcDateTime;
}

@doc("Support Status Distribution.")
model SupportStatusDistribution {
  @doc("Unknown support.")
  @visibility(Lifecycle.Read)
  unknownSupport?: int32;

  @doc("Mainstream support.")
  @visibility(Lifecycle.Read)
  mainStream?: int32;

  @doc("Extended support.")
  @visibility(Lifecycle.Read)
  extended?: int32;

  @doc("Out of support.")
  @visibility(Lifecycle.Read)
  outOfSupport?: int32;
}

@doc("Service Pack Insight.")
model ServicePackInsight {
  @doc("Unknown support.")
  @visibility(Lifecycle.Read)
  unknownServicePack?: int32;

  @doc("Patched Service Pack Insight.")
  @visibility(Lifecycle.Read)
  patched?: int32;

  @doc("Unpatched Service Pack Insight.")
  @visibility(Lifecycle.Read)
  unpatched?: int32;
}

@doc("Distribution by Type.")
model DistributionByType {
  @doc("Distribution Type.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("Distribution Count.")
  @visibility(Lifecycle.Read)
  count?: int32;
}
