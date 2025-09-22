import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Workspace details.
 */
@parentResource(ApiManagementServiceResource)
model WorkspaceContract
  is Azure.ResourceManager.ProxyResource<WorkspaceContractProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceContract,
    KeyName = "workspaceId",
    SegmentName = "workspaces",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface WorkspaceContracts {
  /**
   * Gets the details of the workspace specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspace_Get")
  get is ArmResourceRead<WorkspaceContract>;

  /**
   * Gets the entity state (Etag) version of the workspace specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspace_GetEntityTag")
  getEntityTag is ArmResourceCheckExistence<WorkspaceContract>;

  /**
   * Creates a new workspace or updates an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspace_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    WorkspaceContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates the details of the workspace specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspace_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    WorkspaceContract,
    PatchModel = WorkspaceContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes the specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspace_Delete")
  delete is ArmResourceDeleteSync<
    WorkspaceContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists all workspaces of the API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspace_ListByService")
  listByService is ArmResourceListByParent<
    WorkspaceContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br></br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<WorkspaceCollection>
  >;
}

@@maxLength(WorkspaceContract.name, 80);
@@minLength(WorkspaceContract.name, 1);
@@doc(WorkspaceContract.name,
  "Workspace identifier. Must be unique in the current API Management service instance."
);
@@doc(WorkspaceContract.properties, "Workspace entity contract properties.");
@@doc(WorkspaceContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(WorkspaceContracts.update::parameters.properties,
  "Workspace Update parameters."
);
