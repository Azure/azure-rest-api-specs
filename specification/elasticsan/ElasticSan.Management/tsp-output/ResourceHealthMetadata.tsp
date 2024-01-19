import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Used for getting ResourceHealthCheck settings.")
@singleton("default")
@parentResource(Site)
model ResourceHealthMetadata
  is ProxyResource<ResourceHealthMetadataProperties> {
  @key("resourceHealthMetadatum")
  @segment("resourceHealthMetadata")
  name: string;
}

@armResourceOperations
@projectedName("client", "ResourceHealthMetadata")
interface ResourceHealthMetadataOperationGroup {
  @doc("Description for Gets the category of ResourceHealthMetadata to use for the given site")
  getBySite is ArmResourceRead<ResourceHealthMetadata>;

  @doc("Description for Gets the category of ResourceHealthMetadata to use for the given site as a collection")
  listBySite is ArmResourceListByParent<ResourceHealthMetadata>;
}
