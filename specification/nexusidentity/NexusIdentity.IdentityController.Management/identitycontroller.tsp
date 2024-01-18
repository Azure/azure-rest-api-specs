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
  @key("IdentityControllerName")
  @path
  @segment("IdentityControllers")
  name: string;
}

/** IdentityController properties */
model IdentityControllerProperties {
  /** Age of IdentityController */
  onboardedApps: Array<OnboardedApp>;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model OnboardedApp {
  tenantId: string;
  appId: string;
  appName: string;
  roles: Array<string>;
}

@lroStatus
/** The resource provisioning state. */
enum ProvisioningState {
  ...ResourceProvisioningState,
  /** The resource is being provisioned. */
  Provisioning,
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
  update is ArmResourcePatchSync<IdentityController, IdentityControllerProperties>;
  delete is ArmResourceDeleteAsync<IdentityController>;
  listByResourceGroup is ArmResourceListByParent<IdentityController>;
  listBySubscription is ArmListBySubscription<IdentityController>;
}
