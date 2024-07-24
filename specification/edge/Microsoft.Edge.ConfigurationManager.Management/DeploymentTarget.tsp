import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./CapabilityList.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Deployment Target Properties")
model DeploymentTargetProperties {
  @doc("Display Name of deployment target")
  displayName: string;

  @doc("Custom location of deployment target")
  customLocation: string;

  @doc("List of capabilities")
  @extension("x-ms-identifiers", [])
  capabilities: Capability[];

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Deployment Target Resource")
model DeploymentTarget is TrackedResource<DeploymentTargetProperties> {
  ...ResourceNameParameter<DeploymentTarget>;
}

@armResourceOperations
interface DeploymentTargets {
  @doc("Get a Deployment Target Resource")
  get is ArmResourceRead<DeploymentTarget>;

  @doc("Create or update a Deployment Target Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeploymentTarget>;

  @doc("update a Deployment Target Resource")
  update is ArmResourcePatchSync<DeploymentTarget, DeploymentTargetProperties>;

  @doc("Delete a Deployment Target Resource")
  delete is ArmResourceDeleteSync<DeploymentTarget>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<DeploymentTarget>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<DeploymentTarget>;
}
