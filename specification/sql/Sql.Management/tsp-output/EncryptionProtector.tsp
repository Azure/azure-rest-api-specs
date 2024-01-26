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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Server)
@includeInapplicableMetadataInPayload(false)
model EncryptionProtector extends ProxyResource {
  /**
   * The name of the encryption protector to be retrieved.
   */
  @path
  @key("encryptionProtectorName")
  @segment("encryptionProtector")
  @visibility("read")
  name: EncryptionProtectorName;

  /**
   * Kind of encryption protector. This is metadata used for the Azure portal experience.
   */
  @visibility("read")
  kind?: string;

  /**
   * Resource location.
   */
  @visibility("read")
  location?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EncryptionProtectorProperties;
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
