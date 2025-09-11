import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using Versioning;

namespace Microsoft.Falcon;

/** Namespace resource */
model Namespace is TrackedResource<NamespaceProperties> {
  ...ResourceNameParameter<Namespace>;
}

/** Namespace properties */
model NamespaceProperties {
  /** Name of the falcon fleet namespace. IMMUTABLE */
  @minLength(1)
  @maxLength(26)
  @visibility(
    Lifecycle.Read,
    Lifecycle.Create,
    Lifecycle.Query,
    Lifecycle.Delete
  )
  falconNamespace: string;

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
  @added(Versions.v2025_03_26_preview)
  adminGroup: string;

  /** The PME group used to provide access and JIT to resources.
   *  i.e. TM-Falcon replace Falcon with your team name.
   */
  @removed(Versions.v2025_03_26_preview)
  @renamedFrom(Versions.v2025_03_26_preview, "adminGroup")
  @pattern(
    "TM-[a-zA-Z0-9-]+",
    "Must start with TM- and followed by a string consisting of letters, numbers, and dashes."
  )
  oldAdminGroup: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
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
interface Namespaces {
  get is ArmResourceRead<Namespace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Namespace>;
  update is ArmResourcePatchSync<Namespace, NamespaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Namespace>;
  listByResourceGroup is ArmResourceListByParent<Namespace>;
  listBySubscription is ArmListBySubscription<Namespace>;
}
