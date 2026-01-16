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
@subscriptionResource
model VMSizeResource is Azure.ResourceManager.ProxyResource<VMSize> {
  ...ResourceNameParameter<
    Resource = VMSizeResource,
    KeyName = "vmSize",
    SegmentName = "unsupportedVmSizes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VMSizeResources {
  /**
   * Get unsupported vm size for Service Fabric Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("UnsupportedVmSizes_Get")
  get is ArmResourceRead<
    VMSizeResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get the lists of unsupported vm sizes for Service Fabric Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("UnsupportedVmSizes_List")
  list is ArmResourceListByParent<
    VMSizeResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<VMSizesResult>
  >;
}

@@doc(VMSizeResource.name, "VM Size name.");
@@doc(VMSizeResource.properties, "VM Size properties.");
