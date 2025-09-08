import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Fabric;

/** Fabric Capacity resource */
model FabricCapacity is TrackedResource<FabricCapacityProperties, false> {
  ...ResourceNameParameter<
    Resource = FabricCapacity,
    KeyName = "capacityName",
    SegmentName = "capacities",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The standard ResourceSkuProperty does not fit our case"
  @doc("The SKU details")
  sku: RpSku;
}

@@doc(FabricCapacity.name,
  "The name of the Microsoft Fabric capacity. It must be a minimum of 3 characters, and a maximum of 63."
);
@@maxLength(FabricCapacity.name, 63);
@@minLength(FabricCapacity.name, 3);

@armResourceOperations
interface FabricCapacities {
  get is ArmResourceRead<FabricCapacity>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FabricCapacity>;
  @patch(#{ implicitOptionality: false })
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

  @doc("List eligible SKUs for a Microsoft Fabric resource")
  @get
  @action("skus")
  @list
  listSkusForCapacity is ArmResourceActionSync<
    Resource = FabricCapacity,
    Request = void,
    Response = RpSkuEnumerationForExistingResourceResult
  >;

  @doc("List eligible SKUs for Microsoft Fabric resource provider")
  @get
  @action("skus")
  @list
  listSkus is ArmProviderActionSync<
    Request = void,
    Response = RpSkuEnumerationForNewResourceResult,
    Scope = Extension.Subscription
  >;

  @added(Versions.v2025_01_15_preview)
  @doc("List the current consumption and limit in this location for the provided subscription")
  @get
  @action("usages")
  @list
  listUsages is ArmProviderActionSync<
    Request = void,
    Response = PagedQuota,
    Scope = Extension.Subscription,
    Parameters = LocationParameter
  >;
}
