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

@doc("Avs summary REST resource.")
@parentResource(BusinessCase)
model AvsSummary is ProxyResource<AvsSummaryProperties> {
  @doc("Gets the Name of the Avs Summary.")
  @key("avsSummaryName")
  @segment("avsSummaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a hydrated resource with no PUT call."
@doc("Avs summary properties class.")
model AvsSummaryProperties {
  @doc("The Azure Avs summary.")
  @visibility(Lifecycle.Read)
  azureAvsSummary?: AzureAvsSummary;

  @doc("The on premises IaaS summary.")
  @visibility(Lifecycle.Read)
  onPremisesAvsSummary?: OnPremisesIaasSummary;
}

@doc("The Azure AVS summary.")
model AzureAvsSummary {
  @doc("Shows the year-on-year cost overall.")
  @visibility(Lifecycle.Read)
  yearOnYearEstimates?: YearOnYearEstimates;

  @doc("Avs virtual machine summary.")
  @visibility(Lifecycle.Read)
  avsNodeSummary?: AvsNodeSummary;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  avsCostDetails?: CostDetails;

  @doc("The AVS Azure Sustainability Details.")
  @visibility(Lifecycle.Read)
  azureAvsSustainabilityDetails?: CarbonEmissionsDetails;
}

@doc("Azure Avs Node summary.")
model AvsNodeSummary {
  @doc("Servers suitable for migration.")
  @visibility(Lifecycle.Read)
  serversSuitableForMigration?: int32;

  @doc("The total number of servers.")
  @visibility(Lifecycle.Read)
  totalNumberOfServers?: int32;

  @doc("The total number of Avs VM cores.")
  @visibility(Lifecycle.Read)
  cores?: int32;

  @doc("The total memory in GB.")
  @visibility(Lifecycle.Read)
  memoryGb?: float32;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  avsNodeCostDetails?: CostDetails;

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
  recommendedAvsNodeTypeSummary?: RecommendedAvsNodeTypeSummary[];

  @doc("Estimated External Storage")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  estimatedExternalStorage?: EstimatedExternalStorage[];

  @doc("Estimated Network")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  estimatedNetwork?: EstimatedNetwork[];

  @doc("Estimated Cost With VCF BYOL")
  @visibility(Lifecycle.Read)
  estimatedCostWithVcfByol?: float32;

  @doc("Represents errors which might have occurred while calculating AVS Node Summary")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  errors?: ErrorDetail[];
}

@doc("Error Details")
model ErrorDetail {
  @doc("Error Code")
  @visibility(Lifecycle.Read)
  code: string;

  @doc("Description of the error occurred")
  @visibility(Lifecycle.Read)
  message: string;
}

@doc("Estimated network")
model EstimatedNetwork {
  @doc("Network SKU type.")
  @visibility(Lifecycle.Read)
  skuType?: NetworkSkuType;

  @doc("Network Sku type cost.")
  @visibility(Lifecycle.Read)
  cost?: float32;
}

@doc("Estimated external storage")
model EstimatedExternalStorage {
  @doc("External storage type")
  @visibility(Lifecycle.Read)
  storageType?: ExternalStorageType;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is present in older API versions."
  @doc("Total storage allocation in GB")
  @visibility(Lifecycle.Read)
  totalStorageInGB?: float32;

  @doc("Percent storage utilization")
  @visibility(Lifecycle.Read)
  storageUtilization?: float32;

  @doc("Total storage cost")
  @visibility(Lifecycle.Read)
  totalStorageCost?: float32;
}

@doc("Azure Avs Node summary.")
model RecommendedAvsNodeTypeSummary {
  @doc("AVS node type.")
  @visibility(Lifecycle.Read)
  avsNodeType?: string;

  @doc("Number of nodes.")
  @visibility(Lifecycle.Read)
  numberOfNodes?: int32;

  @doc("Failures to tolerate and RAID level for the Node.")
  @visibility(Lifecycle.Read)
  failuresToTolerateAndRaidLevel?: FttAndRaidLevel;
}
