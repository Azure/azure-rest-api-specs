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

@about({
  icon: {
    filePath: "./icon.svg",
  },
  displayNames: {
    singular: "Online Experiment Workspace",
    plural: "Online Experiment Workspaces - A Microsoft premium service",
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
@doc("An online experiment workspace resource.")
model OnlineExperimentWorkspace
  is TrackedResource<OnlineExperimentWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = OnlineExperimentWorkspace,
    KeyName = "workspaceName",
    NamePattern = "^[a-z0-9](?!.*---)[a-z0-9-]{1,53}[a-z0-9]",
    SegmentName = "workspaces"
  >;
  ...ManagedServiceIdentityProperty;
  ...ResourceSkuProperty;
}

@armResourceOperations
interface OnlineExperimentWorkspaces {
  /**
   * Gets an experiment workspace
   */
  get is ArmResourceRead<OnlineExperimentWorkspace>;

  /**
   * Create an experiment workspace, or update an existing workspace
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OnlineExperimentWorkspace>;

  /**
   * Patch an experiment workspace
   */
  update is ArmResourcePatchAsync<
    OnlineExperimentWorkspace,
    OnlineExperimentWorkspaceProperties
  >;

  /**
   * Deletes an experiment workspace
   */
  delete is ArmResourceDeleteWithoutOkAsync<OnlineExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<OnlineExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<OnlineExperimentWorkspace>;
}
