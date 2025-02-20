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
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well-known abbreviation"
@armResourceOperations
interface ManagedVMSizes {
  /**
   * Get unsupported vm size for Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @operationId("managedUnsupportedVMSizes_Get")
  get is ArmResourceRead<ManagedVMSize>;

  /**
   * Get the lists of unsupported vm sizes for Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @operationId("managedUnsupportedVMSizes_List")
  list is ArmResourceListByParent<
    ManagedVMSize,
    Response = ArmResponse<ManagedVMSizesResult>
  >;
}

@@doc(ManagedVMSize.name, "VM Size name.");
@@doc(ManagedVMSize.properties, "VM Size properties.");
