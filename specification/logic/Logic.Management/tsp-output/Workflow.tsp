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

namespace Microsoft.Logic;
/**
 * The workflow type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model Workflow extends Resource {
  /**
   * The workflow name.
   */
  @path
  @key("workflowName")
  @segment("workflows")
  @visibility("read")
  name: string;

  /**
   * Managed service identity properties.
   */
  identity?: ManagedServiceIdentity;

  /**
   * The workflow properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkflowProperties;
}

@armResourceOperations
interface Workflows {
  /**
   * Gets a workflow.
   */
  get is ArmResourceRead<Workflow>;

  /**
   * Creates or updates a workflow.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Workflow>;

  /**
   * Deletes a workflow.
   */
  delete is ArmResourceDeleteSync<Workflow>;

  /**
   * Gets a list of workflows by resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workflows_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Workflow,
    {
      ...BaseParameters<Workflow>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. Options for filters include: State, Trigger, and ReferencedResourceId.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets a list of workflows by subscription.
   */
  listBySubscription is ArmListBySubscription<Workflow>;

  /**
   * Disables a workflow.
   */
  disable is ArmResourceActionSync<Workflow, void, void>;

  /**
   * Enables a workflow.
   */
  enable is ArmResourceActionSync<Workflow, void, void>;

  /**
   * Generates the upgraded definition for a workflow.
   */
  generateUpgradedDefinition is ArmResourceActionSync<
    Workflow,
    GenerateUpgradedDefinitionParameters,
    AnyObject
  >;

  /**
   * Get the workflow callback Url.
   */
  listCallbackUrl is ArmResourceActionSync<
    Workflow,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl
  >;

  /**
   * Gets an OpenAPI definition for the workflow.
   */
  listSwagger is ArmResourceActionSync<Workflow, void, AnyObject>;

  /**
   * Moves an existing workflow.
   */
  move is ArmResourceActionAsync<Workflow, WorkflowReference, void>;

  /**
   * Regenerates the callback URL access key for request triggers.
   */
  regenerateAccessKey is ArmResourceActionSync<
    Workflow,
    RegenerateActionParameter,
    void
  >;

  /**
   * Validates the workflow.
   */
  validateByResourceGroup is ArmResourceActionSync<Workflow, Workflow, void>;
}

@@projectedName(Workflows.createOrUpdate::parameters.resource,
  "json",
  "workflow"
);
@@extension(Workflows.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "workflow"
);
@@doc(Workflows.createOrUpdate::parameters.resource, "The workflow.");
@@projectedName(Workflows.generateUpgradedDefinition::parameters.body,
  "json",
  "parameters"
);
@@extension(Workflows.generateUpgradedDefinition::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Workflows.generateUpgradedDefinition::parameters.body,
  "Parameters for generating an upgraded definition."
);
@@projectedName(Workflows.listCallbackUrl::parameters.body,
  "json",
  "listCallbackUrl"
);
@@extension(Workflows.listCallbackUrl::parameters.body,
  "x-ms-client-name",
  "listCallbackUrl"
);
@@doc(Workflows.listCallbackUrl::parameters.body,
  "Which callback url to list."
);
@@projectedName(Workflows.move::parameters.body, "json", "move");
@@extension(Workflows.move::parameters.body, "x-ms-client-name", "move");
@@doc(Workflows.move::parameters.body, "The workflow to move.");
@@projectedName(Workflows.regenerateAccessKey::parameters.body,
  "json",
  "keyType"
);
@@extension(Workflows.regenerateAccessKey::parameters.body,
  "x-ms-client-name",
  "keyType"
);
@@doc(Workflows.regenerateAccessKey::parameters.body, "The access key type.");
@@projectedName(Workflows.validateByResourceGroup::parameters.body,
  "json",
  "validate"
);
@@extension(Workflows.validateByResourceGroup::parameters.body,
  "x-ms-client-name",
  "validate"
);
@@doc(Workflows.validateByResourceGroup::parameters.body, "The workflow.");
