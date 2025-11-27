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
  @path
  @key("edgeDeviceName")
  @segment("edgeDevices")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string = "default";

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
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDevice
  >;

  /**
   * Create a EdgeDevice
   */
  createOrUpdate is Azure.ResourceManager.Extension.CreateOrReplaceAsync<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDevice
  >;
  /**
   * Delete a EdgeDevice
   */
  delete is Azure.ResourceManager.Extension.DeleteWithoutOkAsync<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDevice
  >;
  /**
   * List EdgeDevice resources by parent
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDevice
  >;

  /**
   * A long-running resource action.
   */
  validate is Azure.ResourceManager.Extension.ActionAsync<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDevice,
    ValidateRequest,
    ArmResponse<ValidateResponse>
  >;
}
@@doc(EdgeDevice.name, "Name of Device");
