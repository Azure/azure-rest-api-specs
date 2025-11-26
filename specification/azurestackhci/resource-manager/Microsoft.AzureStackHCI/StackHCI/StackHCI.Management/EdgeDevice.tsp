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
@extensionResource
model EdgeDevice is Azure.ResourceManager.ExtensionResource<{}> {
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
  get is Extension.Read<Extension.ScopeParameter, EdgeDevice>;

  /**
   * Create a EdgeDevice
   */
  createOrUpdate is Extension.CreateOrReplaceAsync<
    Extension.ScopeParameter,
    EdgeDevice
  >;

  /**
   * Delete a EdgeDevice
   */
  delete is Extension.DeleteWithoutOkAsync<
    Extension.ScopeParameter,
    EdgeDevice
  >;

  /**
   * List EdgeDevice resources by parent
   */
  list is Extension.ListByTarget<Extension.ScopeParameter, EdgeDevice>;

  /**
   * A long-running resource action.
   */
  validate is Extension.ActionAsync<
    Extension.ScopeParameter,
    EdgeDevice,
    ValidateRequest,
    ArmResponse<ValidateResponse>
  >;
}

@@doc(EdgeDevice.name, "Name of Device");
