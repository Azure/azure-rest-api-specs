import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

alias WorkspaceConnectionListParameters = {
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

  /**
   * query parameter that indicates if get connection call should return both connections and datastores
   */
  @query("includeAll")
  includeAll?: boolean = false;
};

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
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

@armResourceOperations
interface WorkspaceConnectionPropertiesV2BasicResources {
  /**
   * Lists machine learning workspaces connections by name.
   */
  @summary("Lists machine learning workspaces connections by name.")
  get is ArmResourceRead<WorkspaceConnectionPropertiesV2BasicResource>;

  /**
   * Create or update machine learning workspaces connections under the specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing API returns additional response codes"
  @summary("Create or update machine learning workspaces connections under the specified workspace.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    WorkspaceConnectionPropertiesV2BasicResource,
    OptionalRequestBody = true,
    Response = ArmResponse<WorkspaceConnectionPropertiesV2BasicResource>
  >;

  /**
   * Update machine learning workspaces connections under the specified workspace.
   */
  @summary("Update machine learning workspaces connections under the specified workspace.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    WorkspaceConnectionPropertiesV2BasicResource,
    PatchModel = WorkspaceConnectionUpdateParameter,
    OptionalRequestBody = true
  >;

  /**
   * Delete machine learning workspaces connections by name.
   */
  @summary("Delete machine learning workspaces connections by name.")
  delete is ArmResourceDeleteSync<WorkspaceConnectionPropertiesV2BasicResource>;

  /**
   * Lists all the available machine learning workspaces connections under the specified workspace.
   */
  @summary("List all the available machine learning workspaces connections under the specified workspace.")
  list is ArmResourceListByParent<
    WorkspaceConnectionPropertiesV2BasicResource,
    Parameters = WorkspaceConnectionListParameters,
    Response = ArmResponse<WorkspaceConnectionPropertiesV2BasicResourceArmPaginatedResult>
  >;

  /**
   * List all the secrets of a machine learning workspaces connections.
   */
  @summary("List all the secrets of a machine learning workspaces connections.")
  @action("listsecrets")
  listSecrets is ArmResourceActionSync<
    WorkspaceConnectionPropertiesV2BasicResource,
    void,
    ArmResponse<WorkspaceConnectionPropertiesV2BasicResource>
  >;

  /**
   * Test machine learning workspaces connections under the specified workspace.
   */
  @removed(Versions.v2025_12_01)
  @summary("Test machine learning workspaces connections under the specified workspace.")
  @action("testconnection")
  testConnection is ArmResourceActionAsyncBase<
    WorkspaceConnectionPropertiesV2BasicResource,
    WorkspaceConnectionPropertiesV2BasicResource,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<WorkspaceConnectionPropertiesV2BasicResource>,
    OptionalRequestBody = true
  >;

  /**
   * Get available models under the Azure OpenAI connection.
   */
  @removed(Versions.v2025_12_01)
  @summary("Get available models under the Azure OpenAI connection.")
  @list
  @get
  @action("models")
  getModels is ArmResourceActionSync<
    WorkspaceConnectionPropertiesV2BasicResource,
    void,
    ArmResponse<EndpointModels>,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    }
  >;
}

@@doc(WorkspaceConnectionPropertiesV2BasicResource.name,
  "Friendly name of the workspace connection"
);
@@doc(WorkspaceConnectionPropertiesV2BasicResource.properties, "");
@@doc(WorkspaceConnectionPropertiesV2BasicResources.create::parameters.resource,
  "The object for creating or updating a new workspace connection"
);
@@doc(WorkspaceConnectionPropertiesV2BasicResources.update::parameters.properties,
  "Parameters for workspace connection update."
);
@@doc(WorkspaceConnectionPropertiesV2BasicResources.testConnection::parameters.body,
  "Workspace Connection object"
);
