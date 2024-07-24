import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./UseCase.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Helm Use Case Properties")
model HelmUseCaseProperties {
  @doc("Helm Chart URI of helm use case")
  helmChartUri: string;

  @doc("Configuration schema of helm use case")
  configurationSchema: string;

  @doc("Configuration template of helm use case")
  configurationTemplate: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Helm Use Case Resource")
@parentResource(UseCase)
model HelmUseCase is ProxyResource<HelmUseCaseProperties> {
  ...ResourceNameParameter<HelmUseCase>;
}

@armResourceOperations
interface HelmUseCases {
  @doc("Get a Helm Use Case Resource")
  get is ArmResourceRead<HelmUseCase>;

  @doc("Create or update a Helm Use Case Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HelmUseCase>;

  @doc("update a Helm Use Case Resource")
  update is ArmResourcePatchSync<HelmUseCase, HelmUseCaseProperties>;

  @doc("Delete a Helm Use Case Resource")
  delete is ArmResourceDeleteSync<HelmUseCase>;

  @doc("List Helm Use Case Resources")
  listByParent is ArmResourceListByParent<HelmUseCase>;
}
