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

namespace Microsoft.DBforMySQL;
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
    NamePattern = "^[a-z0-9][-a-z0-9]*(?<!-)$"
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a private link resource for MySQL server.
   */
  get is ArmResourceRead<
    PrivateLinkResource,
    Response = ArmResponse<Azure.ResourceManager.CommonTypes.PrivateLinkResource>
  >;

  /**
   * Lists the private link resources for MySQL server.
   */
  #suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByServer is ArmResourceListByParent<
    PrivateLinkResource,
    Response = ArmResponse<Azure.ResourceManager.CommonTypes.PrivateLinkResourceListResultV5>
  >;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource.");
@@doc(PrivateLinkResource.properties, "Resource properties.");
