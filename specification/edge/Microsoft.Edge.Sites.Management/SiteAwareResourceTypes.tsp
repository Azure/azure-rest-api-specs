import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Displays all the resource types which support Sites.")
@singleton("default")
@tenantResource
@includeInapplicableMetadataInPayload(false)
model SiteAwareResourceType is ProxyResource<SiteAwareResourceTypeProperties> {
  @doc("Name of the resource")
  @path
  @key("siteAwareResourceType")
  @segment("siteAwareResourceTypes")
  @visibility("read")
  @pattern("^default$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
@armResourceOperations
@encodedName("application/json", "SiteAwareResourceTypes")
interface SiteAwareResourceTypes {
  @doc("Get operation on SiteAwareResourceType resource")
  get is ArmResourceRead<SiteAwareResourceType>;

  @doc("List operation on SiteAwareResourceType resource")
  listByTenant is ArmResourceListByParent<SiteAwareResourceType>;
}
