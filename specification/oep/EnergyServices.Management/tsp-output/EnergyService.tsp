import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.OpenEnergyPlatform;

model EnergyService is TrackedResource<EnergyServiceProperties> {
  @doc("The resource name.")
  @path
  @key("resourceName")
  @segment("energyServices")
  name: string;
}

@armResourceOperations
interface EnergyServices {
  @doc("Returns oep resource for a given name.")
  get is ArmResourceRead<EnergyService>;
  @doc("Method that gets called if subscribed for ResourceCreationBegin trigger.")
  create is ArmResourceCreateOrUpdateAsync<EnergyService>;

  update is ArmTagsPatchSync<EnergyService>;
  @doc("Deletes oep resource")
  delete is ArmResourceDeleteAsync<EnergyService>;
  @doc("Returns list of oep resources..")
  listByResourceGroup is ArmResourceListByParent<EnergyService>;
  @doc("Lists a collection of oep resources under the given Azure Subscription ID.")
  listBySubscription is ArmListBySubscription<EnergyService>;
  @doc("Method that gets called if new partition is to be added in a resource.")
  addPartition is ArmResourceActionNoResponseContentAsync<
    EnergyService,
    DataPartitionAddOrRemoveRequest
  >;
  @doc("Method that gets called if new partition is to be removed from a resource.")
  removePartition is ArmResourceActionNoResponseContentAsync<
    EnergyService,
    DataPartitionAddOrRemoveRequest
  >;
  @doc("Method that gets called when list of partitions is requested.")
  listPartitions is ArmResourceActionSync<
    EnergyService,
    {},
    DataPartitionsListResult
  >;
}
