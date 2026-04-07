import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.OpenEnergyPlatform;

@doc("Energy service resource.")
model EnergyService is TrackedResource<EnergyServiceProperties> {
  @doc("The resource name.")
  @path
  @key("resourceName")
  @segment("energyServices")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*$")
  name: string;
}

@armResourceOperations
interface EnergyServices {
  @doc("Returns oep resource for a given name.")
  get is ArmResourceRead<EnergyService>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Existing API uses azure-async-operation"
  @doc("Method that gets called if subscribed for ResourceCreationBegin trigger.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    EnergyService,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Updates the oep resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<EnergyService, EnergyResourceUpdate>;

  @doc("Deletes oep resource")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns 200, 202, 204"
  delete is ArmResourceDeleteWithoutOkAsync<EnergyService>;

  @doc("Returns list of oep resources.")
  listByResourceGroup is ArmResourceListByParent<EnergyService>;

  @doc("Lists a collection of oep resources under the given Azure Subscription ID.")
  listBySubscription is ArmListBySubscription<EnergyService>;

  @doc("Checks the name availability of the resource with requested resource name.")
  checkNameAvailability is checkGlobalNameAvailability;

  @doc("Method that gets called if new partition is to be added in a resource.")
  addPartition is ArmResourceActionAsync<
    EnergyService,
    DataPartitionAddOrRemoveRequest,
    DataPartitionAddOrRemoveRequest
  >;

  @doc("Method that gets called if new partition is to be removed from a resource.")
  removePartition is ArmResourceActionAsync<
    EnergyService,
    DataPartitionAddOrRemoveRequest,
    DataPartitionAddOrRemoveRequest
  >;

  @doc("Method that gets called when list of partitions is requested.")
  @action("listPartitions")
  listPartitions is ArmResourceActionSync<
    EnergyService,
    ListPartitionsRequest,
    DataPartitionsListResult
  >;
}
