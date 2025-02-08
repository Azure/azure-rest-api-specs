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
@parentResource(SessionHostManagement)
@singleton("default")
model SessionHostManagementUpdateStatusModel
  is Azure.ResourceManager.ProxyResource<SessionHostManagementUpdateStatus> {
  ...ResourceNameParameter<
    Resource = SessionHostManagementUpdateStatusModel,
    KeyName = "SessionHostUpdateStatuses",
    SegmentName = "sessionHostUpdateStatuses",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
  ...ManagedServiceIdentityProperty;
  ...etagProperty;
  ...ResourceKindProperty;
  ...ManagedByProperty;
  ...ResourcePlanProperty;
  ...ResourceSkuProperty;
}

@armResourceOperations
interface SessionHostManagementUpdateStatuses {
  /**
   * Get a SessionHostManagementUpdateStatus.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("SessionHostManagementUpdateStatus_Get")
  get is ArmResourceRead<SessionHostManagementUpdateStatusModel>;
}

@@maxLength(SessionHostManagementUpdateStatusModel.name, 24);
@@minLength(SessionHostManagementUpdateStatusModel.name, 3);
@@doc(SessionHostManagementUpdateStatusModel.name,
  "The name of the SessionHostManagementUpdateStatus"
);
@@doc(SessionHostManagementUpdateStatusModel.properties,
  "Detailed properties for SessionHostManagementUpdateStatus"
);
