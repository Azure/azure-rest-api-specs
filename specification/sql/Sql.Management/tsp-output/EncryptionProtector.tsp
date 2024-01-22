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
 * The server encryption protector.
 */
@parentResource(Server)
model EncryptionProtector is ProxyResource<EncryptionProtectorProperties> {
  /**
   * The name of the encryption protector to be retrieved.
   */
  @path
  @key("encryptionProtectorName")
  @segment("encryptionProtector")
  name: EncryptionProtectorName;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface EncryptionProtectors {
  /**
   * Gets a server encryption protector.
   */
  get is ArmResourceRead<EncryptionProtector>;

  /**
   * Updates an existing encryption protector.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EncryptionProtector>;

  /**
   * Gets a list of server encryption protectors
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EncryptionProtectors_ListByServer")
  listByServer is ArmResourceListByParent<EncryptionProtector>;

  /**
   * Revalidates an existing encryption protector.
   */
  revalidate is ArmResourceActionAsync<EncryptionProtector, void, void>;
}

@@projectedName(EncryptionProtectors.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(EncryptionProtectors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EncryptionProtectors.createOrUpdate::parameters.resource,
  "The requested encryption protector resource state."
);
