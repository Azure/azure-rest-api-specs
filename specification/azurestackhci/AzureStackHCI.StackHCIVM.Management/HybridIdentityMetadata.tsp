import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Defines the HybridIdentityMetadata.")
@singleton("default")
@parentResource(VirtualMachineInstance)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  HybridIdentityMetadataProperties
)
model HybridIdentityMetadata extends ProxyResourceBase {
  @doc("Name of the hybrididentitymetadata")
  @key("hybridIdentityMetadatum")
  @segment("hybridIdentityMetadata")
  @visibility("read")
  name: string;

  @doc("Resource properties.")
  @extension("x-ms-client-flatten", true)
  properties: HybridIdentityMetadataProperties;
}

@armResourceOperations
@projectedName("client", "HybridIdentityMetadata")
interface HybridIdentityMetadataOperationGroup {
  @doc("Implements HybridIdentityMetadata GET method.")
  get is ArmResourceRead<HybridIdentityMetadata>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the list of HybridIdentityMetadata of the given vm.")
  @operationId("HybridIdentityMetadata_List")
  list is ArmResourceListByParent<HybridIdentityMetadata>;
}
