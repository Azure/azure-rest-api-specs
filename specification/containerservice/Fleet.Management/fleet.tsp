import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

namespace Microsoft.ContainerService;

@doc("The Fleet resource.")
@resource("fleets")
model Fleet is TrackedResource<FleetProperties> {
  @doc("The name of the Fleet resource.")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @key("fleetName")
  @path
  @segment("fleets")
  @visibility("create", "read")
  name: string;
  ...EntityTag;
}

@doc("Fleet properties.")
model FleetProperties {
  // adding a response header in the model currently impacts the model used in the List result model.
  // omitting it for now as response headers do not impact SDK generation.
  //  ...EtagResponseEnvelope;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: FleetProvisioningState;

  @doc("The FleetHubProfile configures the Fleet's hub.")
  hubProfile?: FleetHubProfile;
}

@doc("The FleetHubProfile configures the fleet hub.")
model FleetHubProfile {
  @doc("DNS prefix used to create the FQDN for the Fleet hub.")
  @visibility("read", "create")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][a-zA-Z0-9-]{0,52}[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(54)
  dnsPrefix?: string;

  @visibility("read")
  @doc("The FQDN of the Fleet hub.")
  fqdn?: string;

  @visibility("read")
  @doc("The Kubernetes version of the Fleet hub.")
  kubernetesVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@lroStatus
@doc("The provisioning state of the last accepted operation.")
enum FleetProvisioningState {
  ...ResourceProvisioningState,
  Creating,
  Updating,
  Deleting,
}

@doc("Properties of a Fleet that can be patched.")
model FleetPatch {
  @doc("Resource tags.")
  tags?: Record<string>;
  // adding a response header in the model currently impacts the model used in the List result model.
  // omitting it for now as response headers do not impact SDK generation.
  // ...EtagResponseEnvelope;
}

@doc("One credential result item.")
model FleetCredentialResult {
  @visibility("read")
  @doc("The name of the credential.")
  name?: string;

  @visibility("read")
  @doc("Base64-encoded Kubernetes configuration file.")
  value?: bytes;
}

@doc("The Credential results response.")
model FleetCredentialResults {
  @visibility("read")
  @doc("Array of base64-encoded Kubernetes configuration files.")
  @extension("x-ms-identifiers", ["name"])
  kubeconfigs?: FleetCredentialResult[];
}

@armResourceOperations
interface Fleets {
  @doc("Gets a Fleet.")
  get is ArmResourceRead<Fleet>;

  @doc("Creates or updates a Fleet.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Fleet,
    BaseParameters<Fleet> &
      IfMatchParameters<Fleet> &
      IfNoneMatchParameters<Fleet>
  >;

  update is ArmCustomPatchSync<
    Fleet,
    FleetPatch,
    BaseParameters<Fleet> & IfMatchParameters<Fleet>
  >;

  delete is ArmResourceDeleteAsync<
    Fleet,
    BaseParameters<Fleet> & IfMatchParameters<Fleet>
  >;

  @doc("Lists fleets in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<Fleet>;

  @doc("Lists fleets in the specified subscription.")
  listBySubscription is ArmListBySubscription<Fleet>;

  @doc("Lists the user credentials of a Fleet.")
  listCredentials is ArmResourceNoRequestBodyActionSync<
    Fleet,
    FleetCredentialResults
  >;
}
