import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Discovery.Shared/shared.tsp";
import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Discovery")
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Models tracked resource")
model Model is TrackedResource<ModelProperties> {
  ...ResourceNameParameter<Model>;
}

@doc("Model properties")
model ModelProperties {
  ...DiscoveryResourceProperties;

  @doc("The ARM resource ID of the workspace.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workspaceId: Microsoft.Discovery.Shared.WorkspaceId;

  /** The endpoint URI for the deployed model */
  @visibility(Lifecycle.Read)
  onlineEndpoint?: Azure.Core.armResourceIdentifier<[
    {
      type: "/Microsoft.MachineLearningServices/workspaces/onlineEndpoints";
    }
  ]>;

  ...WithDefinitionContent;
}

@armResourceOperations
interface Models extends DiscoveryResource<Model, ModelProperties> {}
