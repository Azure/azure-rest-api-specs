import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ChangeSafety;

@doc("Resource to track the rollout of changes.")
model SafeRollout is ProxyResource<SafeRolloutProperties> {
  @doc("The name of the safeRollout")
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @key("safeRolloutName")
  @segment("safeRollouts")
  @path
  @minLength(3)
  @maxLength(100)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, location is needed for MSI"
  @doc("The location of the safeRollout")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: Azure.Core.azureLocation;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, MSI support for proxy resource"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The managed identity for the safe rollout to use.")
  identity: Foundations.ManagedServiceIdentity;
}

@doc("Azure resource Id of a ChangeState.")
scalar ChangeStateResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/changeStates",
    }
  ]>;

@doc("Details of the properties of the SafeRollout.")
model SafeRolloutProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the safe rollout.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The internal status of the safe rollout.")
  status: Status;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Azure resource Id of the referenced change state.")
  changeStateResourceId: ChangeStateResourceId;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The error of the safe rollout.")
  error?: Error;
}

@armResourceOperations(SafeRollout)
interface SafeRollouts {
  get is ArmResourceRead<SafeRollout>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SafeRollout>;
  update is ArmResourcePatchSync<SafeRollout, SafeRolloutProperties>;
  delete is ArmResourceDeleteSync<SafeRollout>;
  listByResourceGroup is ArmResourceListByParent<SafeRollout>;
  listBySubscription is ArmListBySubscription<SafeRollout>;
  @doc("Cancel the SafeRollout.")
  cancel is ArmResourceActionNoContentSync<SafeRollout, SafeRollout>;
}
