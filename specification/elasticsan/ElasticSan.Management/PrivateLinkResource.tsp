import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("A private link resource")
@parentResource(ElasticSan)
@armResourceInternal(PrivateLinkResourceProperties)
@includeInapplicableMetadataInPayload(false)
model PrivateLinkResource  extends ProxyResourceBase {
  @doc("The name of the PrivateLinkResource.")
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;

  @doc("Resource properties.")
  @extension("x-ms-client-flatten", true)
  properties?: PrivateLinkResourceProperties;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets the private link resources that need to be created for a elastic San.")
  listByElasticSan is ArmResourceListByParent<PrivateLinkResource>;
}
