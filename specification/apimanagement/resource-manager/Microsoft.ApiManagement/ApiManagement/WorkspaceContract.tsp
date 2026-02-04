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
  get is ArmResourceRead<
    WorkspaceContract,
    Response = ArmResponse<WorkspaceContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the workspace specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    WorkspaceContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new workspace or updates an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    WorkspaceContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<WorkspaceContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<WorkspaceContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the workspace specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    WorkspaceContract,
    PatchModel = WorkspaceContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<WorkspaceContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified workspace.
   */
  delete is ArmResourceDeleteSync<
    WorkspaceContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists all workspaces of the API Management service instance.
   */
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
      @minValue(0)
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
