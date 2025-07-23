import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Defines the HybridIdentityMetadata.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("default")
@extensionResource
@parentResource(VirtualMachineInstance)
model VmInstanceHybridIdentityMetadata
  is Azure.ResourceManager.ExtensionResource<
    VmInstanceHybridIdentityMetadataProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = VmInstanceHybridIdentityMetadata,
    KeyName = "hybridIdentityMetadatum",
    SegmentName = "hybridIdentityMetadata",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VmInstanceHybridIdentityMetadataOperationGroup {
  /**
   * Implements HybridIdentityMetadata GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VmInstanceHybridIdentityMetadata_Get")
  get is ArmResourceRead<
    VmInstanceHybridIdentityMetadata,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * Returns the list of HybridIdentityMetadata of the given vm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VmInstanceHybridIdentityMetadata_List")
  list is ArmResourceListByParent<
    VmInstanceHybridIdentityMetadata,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Response = ArmResponse<VmInstanceHybridIdentityMetadataList>
  >;
}

@@doc(VmInstanceHybridIdentityMetadata.name, "");
@@doc(VmInstanceHybridIdentityMetadata.properties, "Resource properties.");
