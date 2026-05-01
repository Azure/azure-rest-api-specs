import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./automationProjectModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Logic;

/**
 * The automation project resource. An automation project is a logical grouping that owns and manages
 * multiple ContainerApps of kind 'workflowapp' via the managedBy relationship.
 * The automation project is the single entry point for lifecycle management of its auto apps.
 */
model AutomationProject is TrackedResource<AutomationProjectProperties> {
  ...ResourceNameParameter<
    Resource = AutomationProject,
    KeyName = "automationProjectName",
    SegmentName = "automationProjects",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{0,30}[a-zA-Z0-9]$"
  >;

  /**
   * Managed service identity for the automation project to interact with other Azure services.
   */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface AutomationProjects {
  /**
   * Gets an automation project.
   */
  get is ArmResourceRead<AutomationProject>;

  /**
   * Creates or updates an automation project. When creating, the automation project provisions its
   * managed auto apps (ContainerApps with kind 'workflowapp') and sets
   * the managedBy property on each to this automation project's resource ID.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AutomationProject>;

  /**
   * Updates an automation project using JSON Merge Patch.
   */
  update is ArmCustomPatchAsync<AutomationProject, AutomationProjectUpdate>;

  /**
   * Deletes an automation project and all of its managed auto apps.
   * This operation cascades — all ContainerApps with managedBy pointing
   * to this automation project will be deleted.
   */
  delete is ArmResourceDeleteWithoutOkAsync<AutomationProject>;

  /**
   * Gets a list of automation projects by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<AutomationProject>;

  /**
   * Gets a list of automation projects by subscription.
   */
  listBySubscription is ArmListBySubscription<AutomationProject>;
}

@@doc(AutomationProject.name, "The automation project name.");
@@minLength(AutomationProject.name, 2);
@@maxLength(AutomationProject.name, 32);
@@doc(AutomationProject.properties, "The automation project properties.");
@@doc(AutomationProjects.createOrUpdate::parameters.resource,
  "The automation project definition."
);
