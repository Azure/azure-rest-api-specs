import "../Common/Models.tsp";

using TypeSpec.Versioning;
using Microsoft.Migrate;

@doc("Compare summary class.")
model CompareSummary {
  @doc("The azure PaaS cost.")
  @visibility(Lifecycle.Read)
  azurePaasCostDetails?: CostDetails;

  @doc("The azure IaaS cost.")
  @visibility(Lifecycle.Read)
  azureIaasCostDetails?: CostDetails;

  @doc("The AVS cost.")
  @visibility(Lifecycle.Read)
  azureAvsCostDetails?: CostDetails;

  @doc("The on premises PaaS cost.")
  @visibility(Lifecycle.Read)
  onPremisesPaasCostDetails?: CostDetails;

  @doc("The on premises IaaS cost.")
  @visibility(Lifecycle.Read)
  onPremisesIaasCostDetails?: CostDetails;

  @doc("The on premises AVS cost.")
  @visibility(Lifecycle.Read)
  onPremisesAvsCostDetails?: CostDetails;

  @doc("The on premises PaaS decommissioned cost.")
  @visibility(Lifecycle.Read)
  onPremisesPaasDecommissionedCostDetails?: CostDetails;

  @doc("The on premises IaaS decommissioned cost.")
  @visibility(Lifecycle.Read)
  onPremisesIaasDecommissionedCostDetails?: CostDetails;

  @doc("The on premises AVS decommissioned cost.")
  @visibility(Lifecycle.Read)
  onPremisesAvsDecommissionedCostDetails?: CostDetails;

  @doc("Future state cost which includes Azure cost and Arc enabled on-premises cost based on the final migration percentage.")
  @visibility(Lifecycle.Read)
  futureCostDetails?: CostDetails;

  @doc("The Azure arc enabled on-premises cost.")
  @visibility(Lifecycle.Read)
  azureArcEnabledOnPremisesCostDetails?: CostDetails;

  @doc("The final azure arc enabled on-premises cost based on the final migration percentage.")
  @visibility(Lifecycle.Read)
  futureAzureArcEnabledOnPremisesCostDetails?: CostDetails;

  @doc("The Azure PaaS Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  azurePaasCarbonEmissionsDetails?: CarbonEmissionsDetails;

  @doc("The Azure IaaS Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  azureIaasCarbonEmissionsDetails?: CarbonEmissionsDetails;

  @doc("The Azure AvS Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  azureAvsCarbonEmissionsDetails?: CarbonEmissionsDetails;

  @doc("The on premises PaaS Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  onPremisesPaasCarbonEmissionsDetails?: CarbonEmissionsDetails;

  @doc("The on premises IaaS Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  onPremisesIaasCarbonEmissionsDetails?: CarbonEmissionsDetails;

  @doc("The on premises Avs Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  onPremisesAvsCarbonEmissionsDetails?: CarbonEmissionsDetails;

  @doc("The on premises PaaS decommissioned Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  onPremisesPaasDecommissionedCarbonEmissionsDetails?: CarbonEmissionsDetails;

  @doc("The on premises IaaS decommissioned Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  onPremisesIaasDecommissionedCarbonEmissionsDetails?: CarbonEmissionsDetails;

  @doc("The on premises Avs decommissioned Carbon Emissions details.")
  @visibility(Lifecycle.Read)
  onPremisesAvsDecommissionedCarbonEmissionsDetails?: CarbonEmissionsDetails;
}
