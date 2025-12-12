import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * A private link resource.
 */
@parentResource(Server)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "groupName",
    SegmentName = "privateLinkResources",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a private link resource for PostgreSQL server.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the private link resources for PostgreSQL server.
   */
  listByServer is ArmResourceListByParent<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinkResourceList>
  >;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource.");
@@doc(PrivateLinkResource.properties, "Resource properties.");
