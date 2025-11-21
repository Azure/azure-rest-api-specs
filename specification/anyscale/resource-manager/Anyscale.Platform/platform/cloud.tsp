import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.ResourceManager;

namespace Anyscale.Platform;

/** Anyscale cloud resource */
@resource("clouds")
model Cloud is TrackedResource<CloudProperties> {
  /** The name of the cloud */
  @pattern("^[a-zA-Z0-9]*$")
  @key("cloudName")
  @path
  @segment("clouds")
  name: string;
}

/** Properties of the cloud resource */
model CloudProperties {
  /** The SSO URL for the cloud */
  @visibility(Lifecycle.Read)
  ssoUrl?: string;

  /** The provisioning state of the cloud resource */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Provisioning state enum */
union ProvisioningState {
  string,
  ResourceProvisioningState,
}

/** Cloud resource operations */
@armResourceOperations
interface Clouds {
  /** Get a cloud resource */
  get is ArmResourceRead<Cloud>;

  /** Create or update a cloud resource */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cloud>;

  /** Update a cloud resource */
  update is ArmCustomPatchSync<
    Cloud,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Cloud,
      CloudProperties
    >
  >;

  /** Delete a cloud resource */
  delete is ArmResourceDeleteWithoutOkAsync<Cloud>;

  /** List cloud resources by resource group */
  listByResourceGroup is ArmResourceListByParent<Cloud>;

  /** List cloud resources by subscription */
  listBySubscription is ArmListBySubscription<Cloud>;
}
