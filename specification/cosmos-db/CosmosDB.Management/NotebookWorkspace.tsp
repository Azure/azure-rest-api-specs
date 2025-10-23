import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * A notebook workspace resource
 */
@parentResource(DatabaseAccountGetResults)
model NotebookWorkspace
  is Azure.ResourceManager.ProxyResource<NotebookWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = NotebookWorkspace,
    KeyName = "notebookWorkspaceName",
    SegmentName = "notebookWorkspaces",
    NamePattern = "",
    Type = NotebookWorkspaceName
  >;
}

@armResourceOperations
interface NotebookWorkspaces {
  /**
   * Gets the notebook workspace for a Cosmos DB account.
   */
  get is ArmResourceRead<NotebookWorkspace>;

  /**
   * Creates the notebook workspace for a Cosmos DB account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<NotebookWorkspace>,
    NotebookWorkspaceCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<NotebookWorkspace> &
      ArmLroLocationHeader<FinalResult = NotebookWorkspace>,
    ErrorResponse = ErrorResponse
  >;

  /**
   * Deletes the notebook workspace for a Cosmos DB account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NotebookWorkspace>;

  /**
   * Gets the notebook workspace resources of an existing Cosmos DB account.
   */
  listByDatabaseAccount is ArmResourceListByParent<
    NotebookWorkspace,
    Response = ArmResponse<NotebookWorkspaceListResult>
  >;

  /**
   * Retrieves the connection info for the notebook workspace
   */
  listConnectionInfo is ArmResourceActionSync<
    NotebookWorkspace,
    void,
    ArmResponse<NotebookWorkspaceConnectionInfoResult>
  >;

  /**
   * Regenerates the auth token for the notebook workspace
   */
  regenerateAuthToken is ArmResourceActionAsync<
    NotebookWorkspace,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Starts the notebook workspace
   */
  start is ArmResourceActionAsync<
    NotebookWorkspace,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(NotebookWorkspace.name, "The name of the notebook workspace resource.");
@@doc(NotebookWorkspace.properties, "Resource properties.");
@@doc(NotebookWorkspaces.createOrUpdate::parameters.resource,
  "The notebook workspace to create for the current database account."
);
