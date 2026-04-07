import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.OpenEnergyPlatform;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Identity is a valid ARM envelope property for managed identity support"
@doc("Energy service resource.")
model EnergyService is TrackedResource<EnergyServiceProperties> {
  @doc("The resource name.")
  @path
  @key("resourceName")
  @segment("energyServices")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*$")
  name: string;

  @doc("The managed service identity of the resource.")
  @added(Versions.v2022_04_04_preview)
  identity?: ManagedServiceIdentity;
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
  @armResourceUpdate(EnergyService)
  @patch(#{ implicitOptionality: false })
  update(
    ...ResourceInstanceParameters<EnergyService>,
    @doc("The resource properties to update.")
    @body
    resource: EnergyResourceUpdate,
  ): ArmResponse<EnergyService> | ErrorResponse;

  #suppress "deprecated" "Existing API returns 200, 202, 204 - ArmResourceDeleteAsync is the correct pattern"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns 200, 202, 204"
  @doc("Deletes oep resource")
  delete is ArmResourceDeleteAsync<EnergyService>;

  @doc("Returns list of oep resources.")
  listByResourceGroup is ArmResourceListByParent<EnergyService>;

  @doc("Lists a collection of oep resources under the given Azure Subscription ID.")
  listBySubscription is ArmListBySubscription<EnergyService>;

  @doc("Checks the name availability of the resource with requested resource name.")
  checkNameAvailability is checkGlobalNameAvailability;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Existing API uses azure-async-operation"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-response-codes" "Existing API returns 202 only"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API returns 202 only"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing API uses Azure-AsyncOperation header"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Existing API returns body in 202 response"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "LRO metadata required for ARM tooling"
  @doc("Method that gets called if new partition is to be added in a resource.")
  @armResourceAction(EnergyService)
  @post
  @action("addPartition")
  @extension("x-ms-long-running-operation", true)
  @extension("x-ms-long-running-operation-options", #{ `final-state-via`: "azure-async-operation" })
  addPartition(
    ...ResourceInstanceParameters<EnergyService>,
    @doc("add partition action payload")
    @body
    body: DataPartitionAddOrRemoveRequest,
  ): ArmAcceptedLroResponse<"The data partitions will be created asynchronously", DataPartitionAddOrRemoveRequest> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Existing API uses azure-async-operation"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-response-codes" "Existing API returns 202 only"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API returns 202 only"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Existing API uses Azure-AsyncOperation header"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Existing API returns body in 202 response"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "LRO metadata required for ARM tooling"
  @doc("Method that gets called if new partition is to be removed from a resource.")
  @armResourceAction(EnergyService)
  @post
  @action("removePartition")
  @extension("x-ms-long-running-operation", true)
  @extension("x-ms-long-running-operation-options", #{ `final-state-via`: "azure-async-operation" })
  removePartition(
    ...ResourceInstanceParameters<EnergyService>,
    @doc("remove partition action payload")
    @body
    body: DataPartitionAddOrRemoveRequest,
  ): ArmAcceptedLroResponse<"The data partitions will be deleted asynchronously", DataPartitionAddOrRemoveRequest> | ErrorResponse;

  @doc("Method that gets called when list of partitions is requested.")
  @action("listPartitions")
  listPartitions is ArmResourceActionSync<
    EnergyService,
    ListPartitionsRequest,
    DataPartitionsListResult
  >;
}
