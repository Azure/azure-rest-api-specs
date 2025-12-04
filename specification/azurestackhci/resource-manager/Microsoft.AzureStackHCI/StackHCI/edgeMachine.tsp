import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

/**
 * Edge Machine resource
 */
@added(Versions.v2025_12_01_preview)
model EdgeMachine
  is Azure.ResourceManager.TrackedResource<EdgeMachineProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachine,
    KeyName = "edgeMachineName",
    SegmentName = "edgeMachines",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
  ...ManagedServiceIdentityProperty;
}

@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface EdgeMachines {
  /** Get an edge machine. */
  get is ArmResourceRead<EdgeMachine>;

  /** Create or update an edge machine. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachine>;

  /** Update an edge machine. */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<EdgeMachine, EdgeMachinePatch>;

  /** Delete an edge machine. */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachine>;

  /** List all edge machines in a resource group. */
  listByResourceGroup is ArmResourceListByParent<EdgeMachine>;

  /** List all edge machines in a subscription. */
  listBySubscription is ArmListBySubscription<EdgeMachine>;
}

/** Name of Device */
@@doc(EdgeMachine.name, "Name of Device");
