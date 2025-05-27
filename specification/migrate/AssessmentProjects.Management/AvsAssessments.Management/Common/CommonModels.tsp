using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention GigaBytes and hence used GB, Gb would give Gigabits"
// @added(AvsApiVersions.v2023_05_01_preview)
@doc("Details on the Estimated External Storage for AVS Assessment.")
model AvsEstimatedExternalStorage {
  @doc("Total monthly cost for type of storage.")
  monthlyPrice?: float32;

  @doc("Recommended External Storage.")
  storageType?: ExternalStorageType;

  @doc("Predicted total Storage used in GB.")
  totalStorageInGB?: float32;

  @doc("Predicted storage utilization.")
  storageUtilization?: float32;
}

@doc("Details on the Estimated Network Costs for AVS Assessment.")
// @added(AvsApiVersions.v2023_05_01_preview)
model AvsEstimatedNetwork {
  @doc("Monthly cost for network type.")
  monthlyPrice?: float32;

  @doc("Recommended Network Sku.")
  networkType?: NetworkSkuType;
}

@doc("Details on the Estimated nodes for AVS Assessment.")
model AvsEstimatedNode {
  @doc("Total monthly cost for type and number of nodes.")
  monthlyPrice?: float32;

  @doc("Recommended SKU.")
  nodeType?: AzureAvsNodeType;

  @doc("Number of nodes that will be needed.")
  nodeNumber?: int32;

  @doc("Predicted CPU utilization.")
  cpuUtilization?: float32;

  @doc("Predicted RAM utilization.")
  ramUtilization?: float32;

  @doc("Predicted storage utilization.")
  storageUtilization?: float32;

  @doc("Predicted total CPU cores across the set of nodes.")
  totalCpu?: float32;

  @doc("Predicted total RAM used in GB.")
  totalRam?: float32;

  @doc("Predicted total Storage used in GB.")
  totalStorage?: float32;

  @doc("Pricing model indicates what hour multiplier to use while estimating the Nodes cost.")
  pricingModel?: AzureReservedInstance;

  @doc("FttRaidLevel recommended for Node.")
  fttRaidLevel?: FttAndRaidLevel;
}

@doc("Error web model class.")
model Error {
  @doc("Gets the error ID.")
  @visibility(Lifecycle.Read)
  id?: int32;

  @doc("Gets the error code.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Gets the Run as account ID.")
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  @doc("Gets the Appliance name.")
  @visibility(Lifecycle.Read)
  applianceName?: string;

  @doc("Gets the error message.")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("Gets the error summary message.")
  @visibility(Lifecycle.Read)
  summaryMessage?: string;

  @doc("Gets the agent scenario where this error occurred.")
  @visibility(Lifecycle.Read)
  agentScenario?: string;

  @doc("Gets the error possible causes.")
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  @doc("Gets the recommended action for the error.")
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  @doc("Gets the error severity.")
  @visibility(Lifecycle.Read)
  severity?: string;

  @doc("Gets the error message parameters.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  messageParameters?: NameValuePair<string, string>[];

  @doc("Gets the time stamp when the error was updated.")
  @visibility(Lifecycle.Read)
  updatedTimeStamp?: utcDateTime;

  @doc("Gets the type of assessment impacted by this error.")
  @visibility(Lifecycle.Read)
  impactedAssessmentType?: string;
}
