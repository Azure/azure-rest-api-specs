import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.MachineLearningServices;

@doc("AssetVersion Definition")
model AssetVersion {
  @doc("Fully qualified resource Id: azureml://workspace/{workspaceName}/indexes/{name}/versions/{version} of the index.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Update stage to 'Archive' to archive the asset. Default is Development, which means the asset is under development.")
  stage?: string = "Development";

  @doc("Description information of the asset.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Asset's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Asset's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;
}

@doc("DeploymentTemplate resource definition")
model DeploymentTemplate is AssetVersion {
  @doc("The type of deployment template.")
  deploymentTemplateType: string;

  @doc("The ID of the environment asset.")
  environmentId: string;

  @doc("Environment variables for the deployment.")
  environmentVariables?: Record<string>;

  @doc("List of environment variable names that can be overridden.")
  allowedEnvironmentVariableOverrides?: string[];

  @doc("Path where the model will be mounted.")
  modelMountPath?: string;

  @doc("Request settings for online deployment.")
  requestSettings?: OnlineRequestSettings;

  @doc("Liveness probe settings.")
  livenessProbe?: ProbeSettings;

  @doc("Readiness probe settings.")
  readinessProbe?: ProbeSettings;

  @doc("List of allowed instance types for the deployment.")
  allowedInstanceType: string[];

  @doc("Default instance type for the deployment.")
  defaultInstanceType: string;

  @doc("Number of instances for the deployment.")
  instanceCount: int32;

  @doc("Path for scoring requests.")
  scoringPath?: string;

  @doc("Port for scoring requests.")
  scoringPort?: int32;
}

@doc("Paged collection of DeploymentTemplate items.")
model PagedDeploymentTemplate {
  @doc("The list of Deployment Templates.")
  @Azure.ResourceManager.identifiers(#[])
  @pageItems
  value: DeploymentTemplate[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<DeploymentTemplate>;
}

@doc("Index resource Definition")
model Index is AssetVersion {
  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;
}

@doc("Paged collection of IndexVersion items.")
model PagedIndex {
  @doc("The list of Indexes.")
  @Azure.ResourceManager.identifiers(#[])
  @pageItems
  value: Index[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Index>;
}

@doc("Prompt resource definition")
@added(Versions.`2024-05-01-preview`)
model Prompt is AssetVersion {
  @doc("Default workspace blob storage Ui. Should work across storage types and auth scenarios.")
  dataUri: string;

  @doc("Relative path of the prompt data file at the dataUri location")
  templatePath: string;
}

@doc("Paged collection of PromptVersion items")
@added(Versions.`2024-05-01-preview`)
model PagedPrompt {
  @doc("The list of Prompts.")
  @Azure.ResourceManager.identifiers(#[])
  @pageItems
  value: Prompt[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Prompt>;
}

@doc("Next version definition.")
model VersionInfo {
  @doc("Next version as defined by the server. The server keeps track of all versions that are string-representations of integers. If one exists, the nextVersion will be a string representation of the highest integer value + 1. Otherwise, the nextVersion will default to '1'.")
  nextVersion?: int64;

  @doc("Current latest version of the resource.")
  latestVersion: string;
}

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedOrOkResponse<T extends TypeSpec.Reflection.Model> = ResourceCreatedResponse<T> | (TypeSpec.Http.Response<200> &
  T);
