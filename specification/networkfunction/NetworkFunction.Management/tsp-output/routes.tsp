import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureTrafficCollector;

interface NetworkFunctionOperations {
  @doc("Lists all of the available NetworkFunction Rest API operations.")
  @route("/providers/Microsoft.NetworkFunction/operations")
  @get
  ListOperations is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface AzureTrafficCollectorsBySubscriptionOperations {
  @doc("Return list of Azure Traffic Collectors in a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetworkFunction/azureTrafficCollectors")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    AzureTrafficCollectorListResult
  >;
}

interface AzureTrafficCollectorsByResourceGroupOperations {
  @doc("Return list of Azure Traffic Collectors in a Resource Group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    AzureTrafficCollectorListResult
  >;
}

interface AzureTrafficCollectorsOperations {
  @doc("Gets the specified Azure Traffic Collector in a specified resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;
    },
    AzureTrafficCollector
  >;

  @doc("Creates or updates a Azure Traffic Collector resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;

      @doc("The parameters to provide for the created Azure Traffic Collector.")
      @body
      parameters: AzureTrafficCollector;
    },
    AzureTrafficCollector
  >;

  @doc("Deletes a specified Azure Traffic Collector resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;
    },
    void
  >;

  @doc("Updates the specified Azure Traffic Collector tags.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}")
  @patch
  UpdateTags is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;

      @doc("Parameters supplied to update Azure Traffic Collector tags.")
      @body
      parameters: TagsObject;
    },
    AzureTrafficCollector
  >;
}

interface CollectorPoliciesOperations {
  @doc("Return list of Collector policies in a Azure Traffic Collector")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;
    },
    CollectorPolicyListResult
  >;

  @doc("Gets the collector policy in a specified Traffic Collector")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;

      @doc("Collector Policy Name")
      @path
      collectorPolicyName: string;
    },
    CollectorPolicy
  >;

  @doc("Creates or updates a Collector Policy resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;

      @doc("Collector Policy Name")
      @path
      collectorPolicyName: string;

      @doc("The parameters to provide for the created Collector Policy.")
      @body
      parameters: CollectorPolicy;
    },
    CollectorPolicy
  >;

  @doc("Deletes a specified Collector Policy resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;

      @doc("Collector Policy Name")
      @path
      collectorPolicyName: string;
    },
    void
  >;

  @doc("Updates the specified Collector Policy tags.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}")
  @patch
  UpdateTags is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("Azure Traffic Collector name")
      @path
      azureTrafficCollectorName: string;

      @doc("Collector Policy Name")
      @path
      collectorPolicyName: string;

      @doc("Parameters supplied to update Collector Policy tags.")
      @body
      parameters: TagsObject;
    },
    CollectorPolicy
  >;
}
