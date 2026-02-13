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
model VMSizeResource is Azure.ResourceManager.ProxyResource<VMSize> {
  ...ResourceNameParameter<
    Resource = VMSizeResource,
    KeyName = "vmSize",
    SegmentName = "unsupportedVmSizes",
    NamePattern = ""
  >;
}

/**
 * Describes the result of the request to list VM Sizes for Service Fabric Clusters.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation. Backwards compatibility with existing API."
model VMSizesResult is Azure.Core.Page<VMSizeResource>;

/**
 * VM Sizes properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Brownfield resource that cannot be created/updated, no provisioning state"
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation. Backwards compatibility with existing API."
model VMSize {
  /**
   * VM Size name.
   */
  @visibility(Lifecycle.Read)
  size?: string;
}

alias VmSizeOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Legacy.Provider;
    ...LocationResourceParameter;
  },
  {
    /**
     * VM Size name.
     */
    @path
    @segment("unsupportedVmSizes")
    vmSize: string;
  },
  ErrorModel
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation. Backwards compatibility with existing API."
@armResourceOperations(#{ omitTags: true })
interface VMSizeResources {
  /**
   * Get unsupported vm size for Service Fabric Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @summary("Get unsupported vm size for Service Fabric Clusters.")
  @operationId("UnsupportedVmSizes_Get")
  @tag("VMSizes")
  @get
  get is VmSizeOps.Read<VMSizeResource, Response = ArmResponse<VMSizeResource>>;

  /**
   * Get the lists of unsupported vm sizes for Service Fabric Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @summary("Get the lists of unsupported vm sizes for Service Fabric Clusters.")
  @operationId("UnsupportedVmSizes_List")
  @tag("VMSizes")
  @get
  @list
  list is VmSizeOps.List<VMSizeResource, Response = ArmResponse<VMSizesResult>>;
}

@@doc(VMSizeResource.name, "VM Size name.");
@@doc(VMSizeResource.properties, "VM Size properties.");
@@visibility(VMSizeResource.properties, Lifecycle.Read);
