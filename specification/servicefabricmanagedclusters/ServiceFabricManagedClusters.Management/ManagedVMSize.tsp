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
@parentResource(SubscriptionLocationResource)
model ManagedVMSize is Azure.ResourceManager.ProxyResource<VMSize> {
  ...ResourceNameParameter<
    Resource = ManagedVMSize,
    KeyName = "vmSize",
    SegmentName = "managedUnsupportedVMSizes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedVMSizes {
  /**
   * Get unsupported vm size for Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("managedUnsupportedVMSizes_Get")
  get is ArmResourceRead<
    ManagedVMSize,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get the lists of unsupported vm sizes for Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("managedUnsupportedVMSizes_List")
  list is ArmResourceListByParent<
    ManagedVMSize,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<ManagedVMSizesResult>
  >;
}

@@doc(ManagedVMSize.name, "VM Size name.");
@@doc(ManagedVMSize.properties, "VM Size properties.");
