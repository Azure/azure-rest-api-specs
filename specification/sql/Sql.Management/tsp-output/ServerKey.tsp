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
 * A server key.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Server)
@Azure.ResourceManager.Private.armResourceInternal(ServerKeyProperties)
@includeInapplicableMetadataInPayload(false)
model ServerKey extends ProxyResource {
  /**
   * The name of the server key to be retrieved.
   */
  @path
  @key("keyName")
  @segment("keys")
  name: string;

  /**
   * Kind of encryption protector. This is metadata used for the Azure portal experience.
   */
  @visibility("read")
  kind?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServerKeyProperties;
}

@armResourceOperations
interface ServerKeys {
  /**
   * Gets a server key.
   */
  get is ArmResourceRead<ServerKey>;

  /**
   * Creates or updates a server key.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerKey>;

  /**
   * Deletes the server key with the given name.
   */
  delete is ArmResourceDeleteAsync<ServerKey>;

  /**
   * Gets a list of server keys.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerKeys_ListByServer")
  listByServer is ArmResourceListByParent<ServerKey>;
}

@@projectedName(ServerKeys.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerKeys.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerKeys.createOrUpdate::parameters.resource,
  "The requested server key resource state."
);
