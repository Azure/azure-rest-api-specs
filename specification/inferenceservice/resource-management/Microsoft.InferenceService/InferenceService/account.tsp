import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.InferenceService;

model Account is TrackedResource<AccountProperties> {
  ...ResourceNameParameter<Account>;
}

/** Account details properties */
model AccountProperties {
  /** Display name of the inference account */
  displayName: string;

  /** Region where the inference account is located */
  region: string;

  /** The rest endpoint for the inference account */
  endpoint?: string;

  /** Provisioning state of the inference account */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state. */
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is provisioned */
  Provisioned: "Provisioned",

  /** The resource provisioning failed */
  Failed: "Failed",

  /** The resource is being deleted */
  Deleting: "Deleting",

  string,
}

@armResourceOperations
interface AccountManagement {
  get is ArmResourceRead<Account>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Account>;
  update is ArmCustomPatchSync<
    Account,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Account,
      AccountProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Account>;
  listByResourceGroup is ArmResourceListByParent<Account>;
}
