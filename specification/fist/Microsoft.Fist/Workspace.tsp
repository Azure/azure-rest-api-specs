import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IoTFirmwareDefense;
/**
 * Firmware analysis workspace.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(WorkspaceProperties)
model Workspace extends TrackedResourceBase {
  /**
   * The name of the firmware analysis workspace.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("workspaceName")
  @segment("workspaces")
  @visibility("read")
  name: string;

  /**
   * Workspace properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkspaceProperties;
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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Workspace, WorkspaceUpdateDefinition>;

  /**
   * The operation to delete a firmware analysis workspace.
   */
  delete is ArmResourceDeleteSync<Workspace>;

  /**
   * Lists all of the firmware analysis workspaces in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  /**
   * Lists all of the firmware analysis workspaces in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<Workspace>;

  /**
   * The operation to get a url for file upload.
   */
  generateUploadUrl is ArmResourceActionSync<
    Workspace,
    GenerateUploadUrlRequest,
    UrlToken
  >;
}

@@projectedName(Workspaces.create::parameters.resource, "json", "workspace");
@@extension(Workspaces.create::parameters.resource,
  "x-ms-client-name",
  "workspace"
);
@@doc(Workspaces.create::parameters.resource,
  "Parameters when creating a firmware analysis workspace."
);
@@projectedName(Workspaces.update::parameters.properties, "json", "workspace");
@@extension(Workspaces.update::parameters.properties,
  "x-ms-client-name",
  "workspace"
);
@@doc(Workspaces.update::parameters.properties,
  "Parameters when updating a firmware analysis workspace."
);
@@projectedName(Workspaces.generateUploadUrl::parameters.body,
  "json",
  "generateUploadUrl"
);
@@extension(Workspaces.generateUploadUrl::parameters.body,
  "x-ms-client-name",
  "generateUploadUrl"
);
@@doc(Workspaces.generateUploadUrl::parameters.body,
  "Parameters when requesting a URL to upload firmware."
);
