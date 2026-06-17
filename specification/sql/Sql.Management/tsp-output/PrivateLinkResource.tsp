import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A private link resource
 */
@parentResource(Server)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  /**
   * The name of the private link resource.
   */
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a private link resource for SQL server.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the private link resources for SQL server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByServer")
  listByServer is ArmResourceListByParent<PrivateLinkResource>;
}
