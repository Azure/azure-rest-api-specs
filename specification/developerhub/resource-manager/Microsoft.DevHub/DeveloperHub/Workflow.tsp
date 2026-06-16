import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevHub;
/**
 * Resource representation of a workflow
 */
@summary("Workflow")
model Workflow is Azure.ResourceManager.TrackedResource<WorkflowProperties> {
  ...ResourceNameParameter<
    Resource = Workflow,
    KeyName = "workflowName",
    SegmentName = "workflows",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface Workflows {
  /**
   * Gets a workflow.
   */
  @summary("Gets a workflow.")
  @tag("Workflow")
  get is ArmResourceRead<Workflow>;

  /**
   * Creates or updates a workflow
   */
  @summary("Creates or updates a workflow")
  @tag("Workflow")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Workflow>;

  /**
   * Updates tags on a workflow.
   */
  @summary("Updates tags on a workflow.")
  @tag("Workflow")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<Workflow, PatchModel = TagsObject>;

  /**
   * Deletes a workflow
   */
  @summary("Deletes a workflow")
  @tag("Workflow")
  delete is ArmResourceDeleteSync<
    Workflow,
    Response = ArmResponse<DeleteWorkflowResponse> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of workflows within a resource group.
   */
  @summary("Gets a list of workflows within a resource group.")
  @tag("Workflow")
  listByResourceGroup is ArmResourceListByParent<
    Workflow,
    Parameters = {
      /**
       * The ManagedCluster resource associated with the workflows.
       */
      @query("managedClusterResource")
      managedClusterResource?: string;
    }
  >;

  /**
   * Gets a list of workflows associated with the specified subscription.
   */
  @summary("Gets a list of workflows associated with the specified subscription.")
  @tag("Workflow")
  list is ArmListBySubscription<Workflow>;
}

@@maxLength(Workflow.name, 63);
@@minLength(Workflow.name, 1);
@@doc(Workflow.name, "The name of the workflow resource.");
@@doc(Workflow.properties, "Properties of a workflow.");
@@doc(Workflows.createOrUpdate::parameters.resource, "");
@@doc(Workflows.updateTags::parameters.properties,
  "Parameters supplied to the Update Workflow Tags operation."
);
