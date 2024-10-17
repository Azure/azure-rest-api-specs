import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("Defining the Activation.")
model ActivationProperties {
  @doc("Provisioning state of the activation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The inputs of the Activation. Inputs holds a key-value map of user-defined parameters for the initial stage")
  inputs?: Record<unknown>;

  @doc("The stage of the campaign from where the Activation should trigger.")
  stage?: string;

  @doc("The campaign name that the Activation should trigger.")
  campaign: string;

  @doc("The status of the Activation.")
  @visibility("read")
  status?: ActivationStatusProperties;
}

@doc("The activation entity.")
model Activation is TrackedResource<ActivationProperties> {
  @doc("The name of the activation.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("activationName")
  @segment("activations")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Activations {
  @doc("Returns the details of the activation.")
  get is Azure.ResourceManager.ArmResourceRead<Activation>;
  @doc("Creates a new or updates an existing activation.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<Activation>;
  @doc("Updates an existing activation.")
  update is ArmCustomPatchAsync<Activation>;
  @doc("Deletes a specified activation.")
  delete is ArmResourceDeleteWithoutOkAsync<Activation>;
  @doc("Returns a collection of activations within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Activation>;
  @doc("Lists activations within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Activation>;
}
