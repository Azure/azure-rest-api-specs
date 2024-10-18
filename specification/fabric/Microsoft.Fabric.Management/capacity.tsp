import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Fabric;

/** Fabric Capacity resource */
model FabricCapacity is TrackedResource<FabricCapacityProperties, false> {
  @doc("The name of the Microsoft Fabric capacity. It must be a minimum of 3 characters, and a maximum of 63.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]*$")
  @key("capacityName")
  @path
  @segment("capacities")
  @visibility("read")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The standard ResourceSkuProperty does not fit our case"
  @doc("The SKU details")
  sku: RpSku;
}

@armResourceOperations
interface FabricCapacities {
  get is ArmResourceRead<FabricCapacity>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FabricCapacity>;
  @parameterVisibility
  update is ArmCustomPatchAsync<
    FabricCapacity,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      FabricCapacity,
      FabricCapacityProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<FabricCapacity>;
  listByResourceGroup is ArmResourceListByParent<FabricCapacity>;
  listBySubscription is ArmListBySubscription<FabricCapacity>;

  @doc("Resume operation of the specified Fabric capacity instance.")
  resume is ArmResourceActionAsync<
    FabricCapacity,
    void,
    OkResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  @doc("Suspend operation of the specified Fabric capacity instance.")
  suspend is ArmResourceActionAsync<
    FabricCapacity,
    void,
    OkResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  checkNameAvailability is checkLocalNameAvailability;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  @get
  @doc("List eligible SKUs for a Microsoft Fabric resource")
  @segment("skus")
  listSkusForCapacity(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...Azure.ResourceManager.Foundations.DefaultProviderNamespace,
    ...CapacityNameParameter,
  ): RpSkuEnumerationForExistingResourceResult | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  @get
  @doc("List eligible SKUs for Microsoft Fabric resource provider")
  @segment("skus")
  listSkus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...Azure.ResourceManager.Foundations.DefaultProviderNamespace,
  ): RpSkuEnumerationForNewResourceResult | ErrorResponse;
}
