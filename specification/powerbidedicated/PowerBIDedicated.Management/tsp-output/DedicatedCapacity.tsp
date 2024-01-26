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
/**
 * Represents an instance of a Dedicated Capacity resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model DedicatedCapacity extends Resource {
  /**
   * The name of the dedicated capacity. It must be a minimum of 3 characters, and a maximum of 63.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]*$")
  @path
  @key("dedicatedCapacityName")
  @segment("capacities")
  @visibility("read")
  name: string;

  /**
   * The SKU of the PowerBI Dedicated capacity resource.
   */
  sku: CapacitySku;

  /**
   * Properties of the provision operation request.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DedicatedCapacityProperties;
}

@armResourceOperations
interface DedicatedCapacities {
  /**
   * Gets details about the specified dedicated capacity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_GetDetails")
  getDetails is ArmResourceRead<DedicatedCapacity>;

  /**
   * Provisions the specified Dedicated capacity based on the configuration specified in the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_Create")
  create is ArmResourceCreateOrReplaceAsync<DedicatedCapacity>;

  /**
   * Updates the current state of the specified Dedicated capacity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Capacities_Update")
  update is ArmCustomPatchAsync<
    DedicatedCapacity,
    DedicatedCapacityUpdateParameters
  >;

  /**
   * Deletes the specified Dedicated capacity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_Delete")
  delete is ArmResourceDeleteAsync<DedicatedCapacity>;

  /**
   * Gets all the Dedicated capacities for the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DedicatedCapacity>;

  /**
   * Lists all the Dedicated capacities for the given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_List")
  list is ArmListBySubscription<DedicatedCapacity>;

  /**
   * Lists eligible SKUs for PowerBI Dedicated resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_ListSkus")
  listSkus is ArmListBySubscription<DedicatedCapacity>;

  /**
   * Suspends operation of the specified dedicated capacity instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_Suspend")
  suspend is ArmResourceActionAsync<DedicatedCapacity, void, void>;

  /**
   * Resumes operation of the specified Dedicated capacity instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_Resume")
  resume is ArmResourceActionAsync<DedicatedCapacity, void, void>;

  /**
   * Check the name availability in the target location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    CheckCapacityNameAvailabilityParameters,
    CheckCapacityNameAvailabilityResult
  >;

  /**
   * Lists eligible SKUs for a PowerBI Dedicated resource.
   */
  // FIXME: Capacities_ListSkusForCapacity could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Capacities_ListSkusForCapacity")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBIDedicated/capacities/{dedicatedCapacityName}/skus")
  @get
  listSkusForCapacity is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the Azure Resource group of which a given PowerBIDedicated capacity is part. This name must be at least 1 character in length, and no more than 90.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the Dedicated capacity. It must be at least 3 characters in length, and no more than 63.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-z][a-z0-9]*$")
      @path
      dedicatedCapacityName: string;

      /**
       * A unique identifier for a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
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
