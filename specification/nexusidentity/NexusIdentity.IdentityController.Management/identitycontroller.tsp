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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @doc("List of onboarded apps for Nexus Identity")
  onboardedApps: Array<OnboardedApp>;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
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

  @doc("""
    Roles to be watched for identity sets. Role Definition Ids to be passed here 
    e.g /providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635
    """)
  roleDefinitionIds: Array<string>;
}

/** The resource provisioning state. */
@lroStatus
@doc("The current provisioning state.")
union ProvisioningState {
  @doc("Accepted Provisioning State")
  Accepted: "Accepted",

  @doc("Succeeded Provisioning State")
  Succeeded: "Succeeded",

  @doc("Updating Provisioning State")
  Updating: "Updating",

  @doc("Deleting Provisioning State")
  Deleting: "Deleting",

  @doc("Failed Provisioning State")
  Failed: "Failed",

  @doc("Canceled Provisioning State")
  Canceled: "Canceled",

  string,
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
