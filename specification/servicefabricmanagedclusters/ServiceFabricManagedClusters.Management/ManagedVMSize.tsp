import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * Describes a VM Sizes.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation"
model ManagedVMSize {
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Necessary to avoid standard routing"
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation"
interface ManagedUnsupportedVMSizes {
  /**
   * Get unsupported vm size for Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Necessary to avoid standard routing"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedUnsupportedVMSizes/{vmSize}")
  @tag("ManagedVMSizes")
  @operationId("managedUnsupportedVMSizes_Get")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location for the cluster code versions. This is different from cluster location.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    location: string,

    /**
     * VM Size name.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    vmSize: string,
  ): ArmResponse<ManagedVMSize> | ErrorResponse;

  /**
   * Get the lists of unsupported vm sizes for Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Necessary to avoid standard routing"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedUnsupportedVMSizes")
  @operationId("managedUnsupportedVMSizes_List")
  @tag("ManagedVMSizes")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location for the cluster code versions. This is different from cluster location.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    location: string,
  ): ArmResponse<ManagedVMSizesResult> | ErrorResponse;
}

/**
 * Describes the result of the request to list Managed VM Sizes for Service Fabric Managed Clusters.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well known abbreviation"
model ManagedVMSizesResult is Azure.Core.Page<ManagedVMSize>;

@@doc(ManagedVMSize.name, "VM Size name.");
@@doc(ManagedVMSize.properties, "VM Size properties.");

/**
 * VM Sizes properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource, no provisioning"
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well known abbreviation"
model VMSize {
  /**
   * VM Size name.
   */
  @visibility(Lifecycle.Read)
  size?: string;
}
