import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * The managed instance encryption protector.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@Azure.ResourceManager.Private.armResourceInternal(
  ManagedInstanceEncryptionProtectorProperties
)
@includeInapplicableMetadataInPayload(false)
model ManagedInstanceEncryptionProtector extends ProxyResource {
  /**
   * The name of the encryption protector to be retrieved.
   */
  @path
  @key("encryptionProtectorName")
  @segment("encryptionProtector")
  name: EncryptionProtectorName;

  /**
   * Kind of encryption protector. This is metadata used for the Azure portal experience.
   */
  @visibility("read")
  kind?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedInstanceEncryptionProtectorProperties;
}

@armResourceOperations
interface ManagedInstanceEncryptionProtectors {
  /**
   * Gets a managed instance encryption protector.
   */
  get is ArmResourceRead<ManagedInstanceEncryptionProtector>;

  /**
   * Updates an existing encryption protector.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstanceEncryptionProtector>;

  /**
   * Gets a list of managed instance encryption protectors
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceEncryptionProtectors_ListByInstance")
  listByInstance is ArmResourceListByParent<ManagedInstanceEncryptionProtector>;

  /**
   * Revalidates an existing encryption protector.
   */
  revalidate is ArmResourceActionAsync<
    ManagedInstanceEncryptionProtector,
    void,
    void
  >;
}

@@projectedName(ManagedInstanceEncryptionProtectors.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceEncryptionProtectors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceEncryptionProtectors.createOrUpdate::parameters.resource,
  "The requested encryption protector resource state."
);
