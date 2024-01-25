import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * MySQL migration status.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("status")
@includeInapplicableMetadataInPayload(false)
model MigrateMySqlStatus extends ProxyOnlyResource {
  @key("migratemysql")
  @segment("migratemysql")
  @visibility("read")
  name: string;

  /**
   * MigrateMySqlStatus resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: MigrateMySqlStatusProperties;
}

@armResourceOperations
interface MigrateMySqlStatuses {
  /**
   * Description for Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetMigrateMySqlStatusSlot")
  getMigrateMySqlStatusSlot is ArmResourceRead<MigrateMySqlStatus>;
}
