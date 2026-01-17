import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * Describes a VM Sizes.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation. Backwards compatibility with existing API."
@subscriptionResource
model VMSizeResource {
  /**
   * Describes a VM Sizes.
   */
  @visibility(Lifecycle.Read)
  properties?: VMSize;

  /**
   * VM Size id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Vm Size name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * VM Size type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Describes the result of the request to list VM Sizes for Service Fabric Clusters.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation. Backwards compatibility with existing API."
model VMSizesResult is Azure.Core.Page<VMSizeResource>;

/**
 * VM Sizes properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation. Backwards compatibility with existing API."
model VMSize {
  /**
   * VM Size name.
   */
  @visibility(Lifecycle.Read)
  size?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation. Backwards compatibility with existing API."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Necessary to avoid standard routing"
interface VMSizeResources {
  /**
   * Get unsupported vm size for Service Fabric Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/unsupportedVmSizes/{vmSize}")
  @operationId("UnsupportedVmSizes_Get")
  @tag("VMSizes")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * VM Size name.
     */
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    vmSize: string,
  ): ArmResponse<VMSizeResource> | ErrorResponse;

  /**
   * Get the lists of unsupported vm sizes for Service Fabric Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/unsupportedVmSizes")
  @operationId("UnsupportedVmSizes_List")
  @tag("VMSizes")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location for the unsupported VM size(s). This is different from cluster location.
     */
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    location: string,
  ): ArmResponse<VMSizesResult> | ErrorResponse;
}

@@doc(VMSizeResource.name, "VM Size name.");
@@doc(VMSizeResource.properties, "VM Size properties.");
