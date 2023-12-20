import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PowerBIDedicated;
@doc("Represents an instance of a Dedicated Capacity resource.")
model DedicatedCapacity is ProxyResource<DedicatedCapacityProperties> {
  @doc("The name of the dedicated capacity. It must be a minimum of 3 characters, and a maximum of 63.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]*$")
  @path
  @key("dedicatedCapacityName")
  @segment("capacities")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface DedicatedCapacities {
  @doc("Gets details about the specified dedicated capacity.")
  getDetails is ArmResourceRead<DedicatedCapacity>;
  @doc("Provisions the specified Dedicated capacity based on the configuration specified in the request.")
  create is ArmResourceCreateOrUpdateAsync<DedicatedCapacity>;
  @doc("Updates the current state of the specified Dedicated capacity.")
  update is ArmResourcePatchAsync<
    DedicatedCapacity,
    DedicatedCapacityProperties
  >;
  @doc("Deletes the specified Dedicated capacity.")
  delete is ArmResourceDeleteAsync<DedicatedCapacity>;
  @doc("Gets all the Dedicated capacities for the given resource group.")
  listByResourceGroup is ArmResourceListByParent<DedicatedCapacity>;
  @doc("Lists all the Dedicated capacities for the given subscription.")
  list is ArmListBySubscription<DedicatedCapacity>;
  @doc("Lists eligible SKUs for PowerBI Dedicated resource provider.")
  listSkus is ArmListBySubscription<DedicatedCapacity>;
  @doc("Suspends operation of the specified dedicated capacity instance.")
  suspend is ArmResourceActionAsync<DedicatedCapacity, void, void>;
  @doc("Resumes operation of the specified Dedicated capacity instance.")
  resume is ArmResourceActionAsync<DedicatedCapacity, void, void>;
  @doc("Lists eligible SKUs for a PowerBI Dedicated resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}/skus")
  @get
  ListSkusForCapacity is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Azure Resource group of which a given PowerBIDedicated capacity is part. This name must be at least 1 character in length, and no more than 90.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the Dedicated capacity. It must be at least 3 characters in length, and no more than 63.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-z][a-z0-9]*$")
      @path
      dedicatedCapacityName: string;

      @doc("A unique identifier for a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    SkuEnumerationForExistingResourceResult
  >;
}
