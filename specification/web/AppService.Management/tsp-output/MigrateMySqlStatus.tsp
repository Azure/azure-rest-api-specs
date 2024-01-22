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
@singleton("status")
model MigrateMySqlStatus is ProxyResource<MigrateMySqlStatusProperties> {
  @key("migratemysql")
  @segment("migratemysql")
  name: string;
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
