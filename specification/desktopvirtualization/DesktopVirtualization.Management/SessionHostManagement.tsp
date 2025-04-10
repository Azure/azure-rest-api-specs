import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a SessionHostManagement definition.
 */
@singleton("default")
@parentResource(HostPool)
model SessionHostManagement
  is Azure.ResourceManager.ProxyResource<
    SessionHostManagementProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SessionHostManagement,
    KeyName = "sessionHostManagement",
    SegmentName = "sessionHostManagements",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SessionHostManagements {
  /**
   * Get a SessionHostManagement.
   */
  get is ArmResourceRead<SessionHostManagement>;

  /**
   * Create or update a SessionHostManagement.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SessionHostManagement>;

  /**
   * Update a SessionHostManagement.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SessionHostManagement,
    PatchModel = SessionHostManagementPatch
  >;

  /**
   * List SessionHostManagements by hostPool.
   */
  listByHostPool is ArmResourceListByParent<
    SessionHostManagement,
    Response = ArmResponse<SessionHostManagementList>
  >;

  /**
   * Initiates a hostpool update or schedule an update for the future.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("initiateSessionHostUpdate")
  @operationId("InitiateSessionHostUpdate_Post")
  post is ArmResourceActionSync<
    SessionHostManagement,
    {
      /**
       * Object containing the definition for properties to be used in the sessionHostUpdate validation.
       */
      @bodyRoot
      updateSessionHostsRequestBody?: UpdateSessionHostsRequestBody;
    },
    NoContentResponse
  >;

  /**
   * Control update of a hostpool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("controlSessionHostUpdate")
  @operationId("ControlSessionHostUpdate_Post")
  controlSessionHostUpdatePost is ArmResourceActionAsyncBase<
    SessionHostManagement,
    HostPoolUpdateControlParameter,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SessionHostManagement>
  >;

  /**
   * Get the session host update status for a given hostpool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("default")
  @operationId("SessionHostManagementsUpdateStatus_Get")
  sessionHostManagementsUpdateStatusGet is ArmResourceActionSync<
    SessionHostManagement,
    void,
    ArmResponse<SessionHostManagementUpdateStatus>
  >;
}

@@doc(SessionHostManagement.name, "");
@@doc(SessionHostManagement.properties,
  "Detailed properties for SessionHostManagement"
);
@@doc(SessionHostManagements.createOrUpdate::parameters.resource,
  "Object containing SessionHostManagement definitions."
);
@@doc(SessionHostManagements.update::parameters.properties,
  "Object containing SessionHostManagement definitions."
);
@@doc(SessionHostManagements.controlSessionHostUpdatePost::parameters.body,
  "Object containing control action for hostpool update."
);
