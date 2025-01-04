import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-portal-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Portal;

namespace Microsoft.OnlineExperimentation;

/*
An online experiment workspace resource
*/
@about({
  icon: {
    filePath: "./icon.svg",
  },
  displayNames: {
    singular: "Online Experiment Workspace",
    plural: "Online Experiment Workspace - A Microsoft premium service",
  },
  learnMoreDocs: [
    {
      title: "Learn Online Experimentation",
      uri: "https://aka.ms/exp/public/docs",
    }
  ],
  keywords: [
    "Online Experimentation Workspace",
    "Online Experimentation",
    "OnlineExperimentation"
  ],
})
@browse({
  argQuery: {
    filePath: "./query.kql",
  },
})
@promotion({
  apiVersion: Versions.v2025_05_31_preview,
  autoUpdate: true,
})
model OnlineExperimentWorkspace
  is Azure.ResourceManager.TrackedResource<OnlineExperimentWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = OnlineExperimentWorkspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface OnlineExperimentWorkspaces {
  /**
   * Gets an experiment workspace
   */
  @Autorest.example(
    "./examples/OnlineExperimentWorkspaces_Get.json",
    "Get a single Online Experiment Workspace."
  )
  get is ArmResourceRead<OnlineExperimentWorkspace>;

  /**
   * Create an experiment workspace, or update an existing workspace
   */
  @Autorest.example(
    "./examples/OnlineExperimentWorkspaces_CreateOrUpdate.json",
    "Create or update an Online Experiment Workspace."
  )
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OnlineExperimentWorkspace>;

  /**
   * Patch an experiment workspace
   */
  @Autorest.example(
    "./examples/OnlineExperimentWorkspaces_Update.json",
    "Update an Online Experiment Workspace."
  )
  update is ArmResourcePatchAsync<
    OnlineExperimentWorkspace,
    OnlineExperimentWorkspaceProperties
  >;

  /**
   * Deletes an experiment workspace
   */
  @Autorest.example(
    "./examples/OnlineExperimentWorkspaces_Delete.json",
    "Deletes an Online Experiment Workspace."
  )
  delete is ArmResourceDeleteWithoutOkAsync<OnlineExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in a resource group.
   */
  @Autorest.example(
    "./examples/OnlineExperimentWorkspaces_ListByResourceGroup.json",
    "List Online Experiment Workspaces on a resource group."
  )
  listByResourceGroup is ArmResourceListByParent<OnlineExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in the specified subscription.
   */
  @Autorest.example(
    "./examples/OnlineExperimentWorkspaces_ListBySubscription.json",
    "List Online Experiment Workspaces on a subscription."
  )
  listBySubscription is ArmListBySubscription<OnlineExperimentWorkspace>;
}
