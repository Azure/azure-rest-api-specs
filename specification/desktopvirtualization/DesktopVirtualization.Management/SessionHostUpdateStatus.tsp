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
//TODO: Talk with reviewer, dont need ResourceName defined in OperationStatusResult AND ResourceNameParameter
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Composition over inheritance"
@parentResource(SessionHostManagement)
@singleton("default")
model SessionHostManagementUpdateStatus
  extends Azure.ResourceManager.CommonTypes.OperationStatusResult {
  ...ResourceNameParameter<
    Resource = SessionHostManagementUpdateStatus,
    SegmentName = "sessionHostUpdateStatuses",
    KeyName = "sessionHostUpdateStatuses",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
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
  get is ArmResourceRead<SessionHostManagementUpdateStatus>;
}
