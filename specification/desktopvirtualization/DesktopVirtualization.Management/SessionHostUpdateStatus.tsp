import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SessionHostManagement.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;

/**
 * Schema for SessionHostManagementUpdateStatus properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Composition over inheritance"
@parentResource(SessionHostManagement)
@singleton("default")
model SessionHostManagementUpdateStatus
  extends Azure.ResourceManager.CommonTypes.OperationStatusResult {
  ...StatusProperty;
  ...UpdateStatusProperty;
}

@armResourceOperations
interface SessionHostManagementUpdateStatuses {
  /**
   * Get a SessionHostManagementUpdateStatus.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("SessionHostManagementsUpdateStatus_Get")
  @get
  @action("sessionHostUpdateStatuses/default")
  get is ArmResourceRead<SessionHostManagementUpdateStatus>;
}
