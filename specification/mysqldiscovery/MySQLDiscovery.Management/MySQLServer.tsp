import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MySQLSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MySqlDiscovery;
/**
 * The MySQLServer resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing api"
@parentResource(MySQLSite)
model MySQLServer
  is Azure.ResourceManager.ProxyResource<MySQLServerProperties, false> {
  ...ResourceNameParameter<
    Resource = MySQLServer,
    KeyName = "serverName",
    SegmentName = "MySQLServers",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing api"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing api"
@armResourceOperations
interface MySQLServers {
  /**
   * Gets the MySQLServers resource.
   */
  get is ArmResourceRead<MySQLServer>;

  /**
   * Puts the MySQLServers resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MySQLServer>;

  /**
   * Patch the MySQLServers resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<
    MySQLServer,
    PatchModel = MySQLServerResourcePatch
  >;

  /**
   * Deletes the MySQLServers resource.
   */
  delete is ArmResourceDeleteSync<MySQLServer>;

  /**
   * Lists the MySQLServers resource in MySQLSites.
   */
  listBySite is ArmResourceListByParent<
    MySQLServer,
    Response = ArmResponse<MySQLServerList>
  >;
}

@@maxLength(MySQLServer.name, 63);
@@minLength(MySQLServer.name, 3);
@@doc(MySQLServer.name, "The name of Server");
@@doc(MySQLServer.properties, "Resource properties.");
@@doc(MySQLServers.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MySQLServers.update::parameters.properties, "Clouds patch payload.");
