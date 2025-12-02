import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkManager.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Instance of Verifier Workspace.
 */
@parentResource(NetworkManager)
model VerifierWorkspace
  is Azure.ResourceManager.TrackedResource<VerifierWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = VerifierWorkspace,
    KeyName = "workspaceName",
    SegmentName = "verifierWorkspaces",
    NamePattern = "^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VerifierWorkspaces {
  /**
   * Gets Verifier Workspace.
   */
  @summary("Gets Verifier Workspace.")
  get is ArmResourceRead<VerifierWorkspace, Error = CommonErrorResponse>;

  /**
   * Creates Verifier Workspace.
   */
  @summary("Creates Verifier Workspace.")
  create is ArmResourceCreateOrReplaceSync<
    VerifierWorkspace,
    Parameters = {
      /**
       * The entity state (ETag) version of the pool to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header("If-Match")
      `If-Match`?: string;
    },
    Error = CommonErrorResponse
  >;

  /**
   * Updates Verifier Workspace.
   */
  @summary("Updates Verifier Workspace.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    VerifierWorkspace,
    PatchModel = VerifierWorkspaceUpdate,
    Parameters = {
      /**
       * The entity state (ETag) version of the pool to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header("If-Match")
      `If-Match`?: string;
    },
    Error = CommonErrorResponse,
    OptionalRequestBody = true
  >;

  /**
   * Deletes Verifier Workspace.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    VerifierWorkspace,
    Parameters = {
      /**
       * The entity state (ETag) version of the pool to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header("If-Match")
      `If-Match`?: string;
    },
    Error = CommonErrorResponse
  >;

  /**
   * Gets list of Verifier Workspaces.
   */
  @summary("Gets list of Verifier Workspaces.")
  list is ArmResourceListByParent<
    VerifierWorkspace,
    Parameters = {
      /**
       * Optional skip token.
       */
      @query("skipToken")
      skipToken?: string;

      /**
       * Optional num entries to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * Optional num entries to show.
       */
      @query("top")
      top?: int32 = 50;

      /**
       * Optional key by which to sort.
       */
      @query("sortKey")
      sortKey?: string;

      /**
       * Optional sort value for pagination.
       */
      @query("sortValue")
      sortValue?: string;
    },
    Error = CommonErrorResponse
  >;
}

@@doc(VerifierWorkspace.name, "Workspace name.");
@@doc(VerifierWorkspace.properties,
  "Properties of Verifier Workspace resource."
);
@@doc(VerifierWorkspaces.create::parameters.resource,
  "Verifier Workspace object to create/update."
);
@@doc(VerifierWorkspaces.update::parameters.properties,
  "Verifier Workspace object to create/update."
);
