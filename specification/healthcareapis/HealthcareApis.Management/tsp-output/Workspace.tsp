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

namespace Microsoft.HealthcareApis;
/**
 * Workspace resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(WorkspaceProperties)
@includeInapplicableMetadataInPayload(false)
model Workspace extends TrackedResourceBase {
  /**
   * The name of workspace resource.
   */
  @maxLength(24)
  @minLength(3)
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;

  /**
   * Workspaces resource specific properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkspaceProperties;
}

@armResourceOperations
interface Workspaces {
  /**
   * Gets the properties of the specified workspace.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * Creates or updates a workspace resource with the specified parameters.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workspace>;

  /**
   * Patch workspace details.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Workspace, WorkspacePatchResource>;

  /**
   * Deletes a specified workspace.
   */
  delete is ArmResourceDeleteAsync<Workspace>;

  /**
   * Lists all the available workspaces under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  /**
   * Lists all the available workspaces under the specified subscription.
   */
  listBySubscription is ArmListBySubscription<Workspace>;
}

@@projectedName(Workspaces.createOrUpdate::parameters.resource,
  "json",
  "workspace"
);
@@extension(Workspaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "workspace"
);
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a healthcare workspace."
);
@@projectedName(Workspaces.update::parameters.properties,
  "json",
  "workspacePatchResource"
);
@@extension(Workspaces.update::parameters.properties,
  "x-ms-client-name",
  "workspacePatchResource"
);
@@doc(Workspaces.update::parameters.properties,
  "The parameters for updating a specified workspace."
);
