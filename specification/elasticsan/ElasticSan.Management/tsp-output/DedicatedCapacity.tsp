import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PowerBIDedicated;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets details about the specified dedicated capacity.")
  @operationId("Capacities_GetDetails")
  getDetails is ArmResourceRead<DedicatedCapacity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Provisions the specified Dedicated capacity based on the configuration specified in the request.")
  @operationId("Capacities_Create")
  create is ArmResourceCreateOrUpdateAsync<DedicatedCapacity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the current state of the specified Dedicated capacity.")
  @operationId("Capacities_Update")
  update is ArmCustomPatchAsync<
    DedicatedCapacity,
    DedicatedCapacityUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the specified Dedicated capacity.")
  @operationId("Capacities_Delete")
  delete is ArmResourceDeleteAsync<DedicatedCapacity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the Dedicated capacities for the given resource group.")
  @operationId("Capacities_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DedicatedCapacity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the Dedicated capacities for the given subscription.")
  @operationId("Capacities_List")
  list is ArmListBySubscription<DedicatedCapacity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists eligible SKUs for PowerBI Dedicated resource provider.")
  @operationId("Capacities_ListSkus")
  listSkus is ArmListBySubscription<DedicatedCapacity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Suspends operation of the specified dedicated capacity instance.")
  @operationId("Capacities_Suspend")
  suspend is ArmResourceActionAsync<DedicatedCapacity, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Resumes operation of the specified Dedicated capacity instance.")
  @operationId("Capacities_Resume")
  resume is ArmResourceActionAsync<DedicatedCapacity, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check the name availability in the target location.")
  @operationId("Capacities_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    CheckCapacityNameAvailabilityParameters,
    CheckCapacityNameAvailabilityResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_ListSkusForCapacity")
  @doc("Lists eligible SKUs for a PowerBI Dedicated resource.")
  // FIXME: Capacities_ListSkusForCapacity could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}/skus")
  @get
  listSkusForCapacity is Azure.Core.Foundations.Operation<
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

@@projectedName(DedicatedCapacities.create::parameters.resource,
  "json",
  "capacityParameters"
);
@@extension(DedicatedCapacities.create::parameters.resource,
  "x-ms-client-name",
  "capacityParameters"
);
@@doc(DedicatedCapacities.create::parameters.resource,
  "Contains the information used to provision the Dedicated capacity."
);
@@projectedName(DedicatedCapacities.update::parameters.properties,
  "json",
  "capacityUpdateParameters"
);
@@extension(DedicatedCapacities.update::parameters.properties,
  "x-ms-client-name",
  "capacityUpdateParameters"
);
@@doc(DedicatedCapacities.update::parameters.properties,
  "Request object that contains the updated information for the capacity."
);
