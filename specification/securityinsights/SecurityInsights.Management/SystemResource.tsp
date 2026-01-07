import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BusinessApplicationAgentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Describes the system within the agent.
 */
@parentResource(BusinessApplicationAgentResource)
model SystemResource
  is Azure.ResourceManager.ProxyResource<SystemProperties, false> {
  ...ResourceNameParameter<
    Resource = SystemResource,
    KeyName = "systemResourceName",
    SegmentName = "systems",
    NamePattern = "^[a-z0-9,-]*$"
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface SystemResources {
  /**
   * Gets the system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Systems_Get")
  get is ArmResourceRead<SystemResource>;

  /**
   * Creates or updates the system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Systems_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SystemResource>;

  /**
   * Deletes the system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Systems_Delete")
  delete is ArmResourceDeleteSync<SystemResource>;

  /**
   * ListAll the systems.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Systems_List")
  list is ArmResourceListByParent<
    SystemResource,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<SystemsList>
  >;

  /**
   * List of actions for a business application system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Systems_ListActions")
  @list
  listActions is ArmResourceActionSync<
    SystemResource,
    void,
    ArmResponse<ListActionsResponse>
  >;

  /**
   * Undo action, based on the actionId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Systems_UndoAction")
  undoAction is ArmResourceActionSync<
    SystemResource,
    UndoActionPayload,
    NoContentResponse,
    OptionalRequestBody = true
  >;

  /**
   * Report the status of the action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Systems_ReportActionStatus")
  reportActionStatus is ArmResourceActionSync<
    SystemResource,
    ReportActionStatusPayload,
    NoContentResponse,
    OptionalRequestBody = true
  >;
}

@@maxLength(SystemResource.name, 63);
@@minLength(SystemResource.name, 3);
@@doc(SystemResource.name, "The name of the system.");
@@doc(SystemResource.properties, "The properties of the system.");
@@doc(SystemResources.createOrUpdate::parameters.resource,
  "The system to upsert."
);
@@doc(SystemResources.undoAction::parameters.body,
  "Undo action, based on the actionId."
);
@@doc(SystemResources.reportActionStatus::parameters.body,
  "Report a status of the action that was performed by the agent"
);
