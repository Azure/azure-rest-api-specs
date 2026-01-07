import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./app.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

@parentResource(ManagedApp)
model AppRevision is ProxyResource<AppRevisionProperties> {
  ...ResourceNameParameter<AppRevision>;
}

/** Status of the App Revision */
union AppRevisionStatus {
  /** Active, can be used in a deployment */
  Active: "active",

  /** Revoked, cannot be used in a deployment */
  Revoked: "revoked",

  string,
}

/** Properties of the App Revision */
model AppRevisionProperties {
  /** Status of the revision. Setting this to "Revoked" will prevent the revision from being used in a deployment */
  status: AppRevisionStatus;

  /** The git SHA of the container image */
  @visibility(Lifecycle.Read)
  gitSha: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
