import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Versioning;

@versioned(Versions)
namespace Microsoft.IoTFirmwareDefense;

/**
 * Firmware analysis workspace.
 */
model Workspace is TrackedResource<WorkspaceProperties> {
  /**
   * The name of the firmware analysis workspace.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("workspaceName")
  @segment("workspaces")
  @visibility(Lifecycle.Read)
  name: string;

  ...ResourceSkuProperty;
}

@armResourceOperations
interface Workspaces {
  /**
   * Get firmware analysis workspace.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * The operation to create or update a firmware analysis workspace.
   */
  create is ArmResourceCreateOrReplaceSync<Workspace>;

  /**
   * The operation to update a firmware analysis workspaces.
   */
  update is ArmCustomPatchSync<
    Workspace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Workspace,
      WorkspaceProperties
    >
  >;

  /**
   * The operation to delete a firmware analysis workspace.
   */
  @sharedRoute
  @added(Versions.v2025_08_02)
  @doc("The operation to delete a firmware analysis workspace.")
  delete is ArmResourceDeleteWithoutOkAsync<Workspace>;

  @removed(Versions.v2025_08_02)
  @renamedFrom(Versions.v2025_08_02, "delete")
  @sharedRoute
  @doc("The operation to delete a firmware analysis workspace.")
  deleteSync is ArmResourceDeleteSync<Workspace>;

  /**
   * Lists all of the firmware analysis workspaces in the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  /**
   * Lists all of the firmware analysis workspaces in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<Workspace>;

  /**
   * Generate a URL for uploading a firmware image.
   */
  generateUploadUrl is ArmResourceActionSync<
    Workspace,
    GenerateUploadUrlRequest,
    UrlToken
  >;
}

@@doc(Workspaces.create::parameters.resource,
  "Parameters when creating a firmware analysis workspace."
);
@@doc(Workspaces.update::parameters.properties,
  "Parameters when updating a firmware analysis workspace."
);
@@doc(Workspaces.generateUploadUrl::parameters.body,
  "Parameters when requesting a URL to upload firmware."
);
