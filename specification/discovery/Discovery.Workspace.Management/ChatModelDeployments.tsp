import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./workspace.tsp";
import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Microsoft.Discovery.Shared;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Represents a deployment that ties a specific model family to a user defined deployment name used when invoking the chat model.")
@added(Microsoft.Discovery.Versions.v2026_02_01_preview)
@parentResource(Workspace)
model ChatModelDeployment is TrackedResource<ChatModelDeploymentProperties> {
  ...ResourceNameParameter<ChatModelDeployment>;
}

@doc("Defines a deployment binding a specific model family to a user-defined deployment name for chat inference.")
@added(Microsoft.Discovery.Versions.v2026_02_01_preview)
model ChatModelDeploymentProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Model format as published by the provider. Verify supported formats per region using the Model Catalog API.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  modelFormat: string;

  @doc("Canonical provider model name available in the selected region. Verify supported values per region using the Model Catalog API.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  modelName: string;

  @doc("Provider-published version of the selected model.")
  @added(Versions.v2026_06_01)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  modelVersion?: string;

  @doc("SKU tier used by this chat model deployment.")
  @added(Versions.v2026_06_01)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  skuName?: string;

  @doc("Provisioned SKU capacity units for this chat model deployment.")
  @added(Versions.v2026_06_01)
  @minValue(1)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  capacity?: int32;
}

@armResourceOperations
@added(Microsoft.Discovery.Versions.v2026_02_01_preview)
interface ChatModelDeployments {
  get is ArmResourceRead<ChatModelDeployment>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ChatModelDeployment>;
  update is ArmResourcePatchAsync<
    ChatModelDeployment,
    ChatModelDeploymentProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ChatModelDeployment>;
  listByWorkspace is ArmResourceListByParent<ChatModelDeployment>;
}
