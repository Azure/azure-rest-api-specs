import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.NexusIdentity;

/** IdentityController resource */
model IdentityController is TrackedResource<IdentityControllerProperties> {
  /** Name of IdentityController */
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key
  @path
  @segment("identityControllers")
  name: string;
}

/** IdentityController properties */
model IdentityControllerProperties {
  @doc("List of onboarded apps for Nexus Identity")
  onboardedApps: Array<OnboardedApp>;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Onboarded app properties for Nexus Identity")
model OnboardedApp {
  @doc("Tenant Id in which roles are to be watched")
  tenantId: string;

  @doc("App Id which will create identity sets")
  appId: string;

  @doc("App Name which will create identity sets")
  appName: string;

  @doc("Roles to be watched for identity sets")
  roles: Array<string>;
}

/** The resource provisioning state. */
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  /** The resource is being updated. */
  Updating,

  /** The resource is being deleted. */
  Deleting,

  /** The resource provisioning request has been accepted. */
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface IdentityControllers {
  get is ArmResourceRead<IdentityController>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IdentityController>;
  update is ArmResourcePatchSync<
    IdentityController,
    IdentityControllerProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IdentityController>;
  listByResourceGroup is ArmResourceListByParent<IdentityController>;
  listBySubscription is ArmListBySubscription<IdentityController>;
}
