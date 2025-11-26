import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
// FIXME: EdgeDevice has no properties property
/**
 * Edge device resource.
 */
model EdgeDevice is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDevice,
    KeyName = "edgeDeviceName",
    SegmentName = "edgeDevices"
  >;

  /**
   * Device kind to support polymorphic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: DeviceKind = DeviceKind.HCI;
}

@armResourceOperations
interface EdgeDevices {
  /**
   * Get a EdgeDevice
   */
  get is ArmResourceRead<EdgeDevice>;

  /**
   * Create a EdgeDevice
   */
  CreateOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeDevice>;

  /**
   * Delete a EdgeDevice
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeDevice>;

  /**
   * List EdgeDevice resources by parent
   */
  List is ArmResourceListByParent<
    EdgeDevice,
    Response = ArmResponse<ResourceListResult<EdgeDevice>>
  >;
  /**
   * A long-running resource action.
   */
  validate is ArmResourceActionAsync<
    EdgeDevice,
    ValidateRequest,
    ValidateResponse
  >;
}

@@doc(EdgeDevice.name, "Name of Device");
