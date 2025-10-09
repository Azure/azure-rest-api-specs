import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager.Private;

namespace Microsoft.PowerBIDedicated;
/**
 * Represents an instance of a Dedicated Capacity resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(DedicatedCapacityProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model DedicatedCapacity
  extends Azure.ResourceManager.Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = DedicatedCapacity,
    KeyName = "dedicatedCapacityName",
    SegmentName = "capacities",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;

  /**
   * The SKU of the PowerBI Dedicated capacity resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: CapacitySku;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties: DedicatedCapacityProperties;
}

@armResourceOperations
interface Capacities {
  /**
   * Gets details about the specified dedicated capacity.
   */
  getDetails is ArmResourceRead<DedicatedCapacity, Error = ErrorResponse>;

  /**
   * Provisions the specified Dedicated capacity based on the configuration specified in the request.
   */
  create is ArmResourceCreateOrReplaceAsync<
    DedicatedCapacity,
    LroHeaders = ArmLroLocationHeader<FinalResult = DedicatedCapacity> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Updates the current state of the specified Dedicated capacity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DedicatedCapacity,
    PatchModel = DedicatedCapacityUpdateParameters,
    Response = ArmResponse<DedicatedCapacity> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = DedicatedCapacity> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: DedicatedCapacity;
    }),
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified Dedicated capacity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DedicatedCapacity,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Gets all the Dedicated capacities for the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DedicatedCapacity,
    Response = ArmResponse<DedicatedCapacities>,
    Error = ErrorResponse
  >;

  /**
   * Lists all the Dedicated capacities for the given subscription.
   */
  list is ArmListBySubscription<
    DedicatedCapacity,
    Response = ArmResponse<DedicatedCapacities>,
    Error = ErrorResponse
  >;

  /**
   * Suspends operation of the specified dedicated capacity instance.
   */
  suspend is ArmResourceActionAsync<
    DedicatedCapacity,
    void,
    OkResponse,
    Error = ErrorResponse
  >;

  /**
   * Resumes operation of the specified Dedicated capacity instance.
   */
  resume is ArmResourceActionAsync<
    DedicatedCapacity,
    void,
    OkResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists eligible SKUs for a PowerBI Dedicated resource.
   */
  @get
  @action("skus")
  listSkusForCapacity is ArmResourceActionSync<
    DedicatedCapacity,
    void,
    ArmResponse<SkuEnumerationForExistingResourceResult>,
    Error = ErrorResponse
  >;
}

@@maxLength(DedicatedCapacity.name, 63);
@@minLength(DedicatedCapacity.name, 3);
@@doc(DedicatedCapacity.name,
  "The name of the dedicated capacity. It must be a minimum of 3 characters, and a maximum of 63."
);
@@doc(DedicatedCapacity.properties,
  "Properties of the provision operation request."
);
@@doc(Capacities.create::parameters.resource,
  "Contains the information used to provision the Dedicated capacity."
);
@@doc(Capacities.update::parameters.properties,
  "Request object that contains the updated information for the capacity."
);
