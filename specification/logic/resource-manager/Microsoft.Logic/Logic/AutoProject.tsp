import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./autoProjectModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Logic;

/**
 * The auto project resource. An auto project is a logical grouping that owns and manages
 * multiple ContainerApps of kind 'workflowapp' via the managedBy relationship.
 * The auto project is the single entry point for lifecycle management of its auto apps.
 */
model AutoProject is TrackedResource<AutoProjectProperties> {
  ...ResourceNameParameter<
    Resource = AutoProject,
    KeyName = "autoProjectName",
    SegmentName = "autoProjects",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9]$"
  >;

  /**
   * Managed service identity for the auto project to interact with other Azure services.
   */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface AutoProjects {
  /**
   * Gets an auto project.
   */
  get is ArmResourceRead<AutoProject>;

  /**
   * Creates or updates an auto project. When creating, the auto project provisions its
   * managed auto apps (ContainerApps with kind 'workflowapp') and sets
   * the managedBy property on each to this auto project's resource ID.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AutoProject>;

  /**
   * Updates an auto project using JSON Merge Patch.
   */
  update is ArmCustomPatchAsync<AutoProject, AutoProjectUpdate>;

  /**
   * Deletes an auto project and all of its managed auto apps.
   * This operation cascades — all ContainerApps with managedBy pointing
   * to this auto project will be deleted.
   */
  delete is ArmResourceDeleteWithoutOkAsync<AutoProject>;

  /**
   * Gets a list of auto projects by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<AutoProject>;

  /**
   * Gets a list of auto projects by subscription.
   */
  listBySubscription is ArmListBySubscription<AutoProject>;
}

@@doc(AutoProject.name, "The auto project name.");
@@doc(AutoProject.properties, "The auto project properties.");
@@doc(AutoProjects.createOrUpdate::parameters.resource,
  "The auto project definition."
);
