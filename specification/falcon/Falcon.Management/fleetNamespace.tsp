import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using Versioning;

namespace Microsoft.Falcon;

/** Fleet Namespace resource */
@added(Versions.v2025_05_14_preview)
model FleetNamespace is ProxyResource<FleetNamespaceProperties> {
  ...ResourceNameParameter<FleetNamespace>;
}

/** Fleet Namespace properties */
@added(Versions.v2025_05_14_preview)
model FleetNamespaceProperties {
  /** Name of the falcon fleet namespace. IMMUTABLE */
  @minLength(1)
  @maxLength(26)
  @visibility(
    Lifecycle.Read,
    Lifecycle.Create,
    Lifecycle.Query,
    Lifecycle.Delete
  )
  fleetNamespace: string;

  /** This is an existing namespace that manages this one and has all the same permissions for this namespace
   *  as the current namespace itself. IMMUTABLE
   */
  @maxLength(26)
  @visibility(
    Lifecycle.Read,
    Lifecycle.Create,
    Lifecycle.Query,
    Lifecycle.Delete
  )
  managingNamespace?: string;

  /** Description of the purpose of the name space */
  description: string;

  /** An email enable SG */
  @pattern(
    "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
    "Must be a valid email. Will be checked for existence."
  )
  ownerContacts: string;

  /** Teams IcM id so incidents can be properly routed. */
  icmPublicId: string;

  /** The PME group used to provide access and JIT to resources.
   *  i.e. TM-Falcon.
   */
  adminGroup: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: FleetNamespaceProvisioningState;
}

/** The resource provisioning state. */
@lroStatus
@added(Versions.v2025_05_14_preview)
union FleetNamespaceProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

@armResourceOperations
@added(Versions.v2025_05_14_preview)
interface FleetNamespaces {
  get is ArmResourceRead<FleetNamespace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FleetNamespace>;
  update is ArmResourcePatchSync<FleetNamespace, FleetNamespaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<FleetNamespace>;
  listByResourceGroup is ArmResourceListByParent<FleetNamespace>;
  listBySubscription is ArmListBySubscription<FleetNamespace>;
}
