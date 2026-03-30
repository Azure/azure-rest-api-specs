import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./sandboxgroup.models.tsp";

using Azure.ResourceManager;

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

/** A sandbox group resource. */
@doc("Sandbox group resource")
model SandboxGroup is TrackedResource<SandboxGroupProperties> {
  ...ResourceNameParameter<
    Resource = SandboxGroup,
    KeyName = "sandboxGroupName",
    SegmentName = "sandboxGroups",
    NamePattern = "^[a-z][a-z0-9]{2,62}$"
  >;
}

@armResourceOperations
interface SandboxGroups {
  /** Get the properties of a sandbox group. */
  get is ArmResourceRead<SandboxGroup>;

  /** Create or update a sandbox group. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SandboxGroup>;

  /** Update properties of a sandbox group. */
  update is ArmTagsPatchSync<SandboxGroup>;

  /** Delete a sandbox group. */
  delete is ArmResourceDeleteWithoutOkAsync<SandboxGroup>;

  /** Get the sandbox groups in a given resource group. */
  listByResourceGroup is ArmResourceListByParent<SandboxGroup>;

  /** Get the sandbox groups in a given subscription. */
  listBySubscription is ArmListBySubscription<SandboxGroup>;
}
