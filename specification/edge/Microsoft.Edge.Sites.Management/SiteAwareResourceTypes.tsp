import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Displays all the resource types which support Sites.")
@singleton("default")
@tenantResource
@includeInapplicableMetadataInPayload(false)
model SiteAwareResourceTypes
  is ProxyResource<SiteAwareResourceTypesProperties> {
  // TODO - There shouldn't be name field in here, it should contain
  @doc("Name of the resource")
  @path
  @key("siteAwareResourceType")
  @segment("siteAwareResourceTypes")
  @visibility("read")
  name: string;
}

@armResourceOperations
@projectedName("client", "SiteAwareResourceTypes")
interface SiteAwareResourceTypesOperationGroup {
  @doc("Get operation on SiteAwareResourceTypes resource")
  get is ArmResourceRead<SiteAwareResourceTypes>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List operation on SiteAwareResourceTypes resource")
  @operationId("SiteAwareResourceTypes_List")
  list is ArmResourceListByParent<SiteAwareResourceTypes>;
}
