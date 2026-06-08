import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

@parentResource(Workspace)
model WorkspaceConnectionPropertiesV2BasicResource
  is Azure.ResourceManager.ProxyResource<
    WorkspaceConnectionPropertiesV2,
    false
  > {
  ...ResourceNameParameter<
    Resource = WorkspaceConnectionPropertiesV2BasicResource,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkspaceConnectionPropertiesV2BasicResources {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceConnections_Get")
  get is ArmResourceRead<WorkspaceConnectionPropertiesV2BasicResource>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WorkspaceConnections_Create")
  create is ArmResourceCreateOrReplaceSync<
    WorkspaceConnectionPropertiesV2BasicResource,
    Response = ArmResourceUpdatedResponse<WorkspaceConnectionPropertiesV2BasicResource>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceConnections_Delete")
  delete is ArmResourceDeleteSync<WorkspaceConnectionPropertiesV2BasicResource>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceConnections_List")
  list is ArmResourceListByParent<
    WorkspaceConnectionPropertiesV2BasicResource,
    Parameters = {
      /**
       * Target of the workspace connection.
       */
      @query("target")
      target?: string;

      /**
       * Category of the workspace connection.
       */
      @query("category")
      category?: string;
    },
    Response = ArmResponse<WorkspaceConnectionPropertiesV2BasicResourceArmPaginatedResult>
  >;
}

@@doc(
  WorkspaceConnectionPropertiesV2BasicResource.name,
  "Friendly name of the workspace connection"
);
@@doc(WorkspaceConnectionPropertiesV2BasicResource.properties, "");
@@doc(
  WorkspaceConnectionPropertiesV2BasicResources.create::parameters.resource,
  "The object for creating or updating a new workspace connection"
);
