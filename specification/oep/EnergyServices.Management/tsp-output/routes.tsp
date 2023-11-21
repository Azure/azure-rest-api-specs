import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace OpenEnergyPlatformManagementServiceAPIs;

interface LocationsOperations {
  @doc("Checks the name availability of the resource with requested resource name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.OpenEnergyPlatform/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("NameAvailabilityRequest object.")
      @body
      body: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}

interface EnergyServicesOperations {
  @doc("Returns list of oep resources..")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OpenEnergyPlatform/energyServices")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    EnergyServiceList
  >;

  @doc("Lists a collection of oep resources under the given Azure Subscription ID.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.OpenEnergyPlatform/energyServices")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    EnergyServiceList
  >;

  @doc("Returns oep resource for a given name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OpenEnergyPlatform/energyServices/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The resource name.")
      @path
      resourceName: string;
    },
    EnergyService
  >;

  @doc("Method that gets called if subscribed for ResourceCreationBegin trigger.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OpenEnergyPlatform/energyServices/{resourceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The resource name.")
      @path
      resourceName: string;

      @doc("Request body.")
      @body
      body: EnergyService;
    },
    EnergyService
  >;

  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OpenEnergyPlatform/energyServices/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The resource name.")
      @path
      resourceName: string;

      @body body: EnergyResourceUpdate;
    },
    EnergyService
  >;

  @doc("Deletes oep resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OpenEnergyPlatform/energyServices/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The resource name.")
      @path
      resourceName: string;
    },
    void
  >;

  @doc("Method that gets called if new partition is to be added in a resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OpenEnergyPlatform/energyServices/{resourceName}/addPartition")
  @post
  AddPartition is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The resource name.")
      @path
      resourceName: string;

      @doc("add partition action payload")
      @body
      body: DataPartitionAddOrRemoveRequest;
    },
    DataPartitionAddOrRemoveRequest
  >;

  @doc("Method that gets called if new partition is to be removed from a resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OpenEnergyPlatform/energyServices/{resourceName}/removePartition")
  @post
  RemovePartition is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The resource name.")
      @path
      resourceName: string;

      @doc("remove partition action payload")
      @body
      body: DataPartitionAddOrRemoveRequest;
    },
    DataPartitionAddOrRemoveRequest
  >;

  @doc("Method that gets called when list of partitions is requested.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OpenEnergyPlatform/energyServices/{resourceName}/listPartitions")
  @post
  ListPartitions is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The resource name.")
      @path
      resourceName: string;
    },
    DataPartitionsListResult
  >;
}

interface OperationsOperations {
  @doc("""
Lists the available operations of Microsoft.OpenEnergyPlatform resource
provider.
""")
  @route("/providers/Microsoft.OpenEnergyPlatform/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
