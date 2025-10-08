import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@added(Versions.v2025_10_01_preview)
@doc("The healthcare interop DDMS connector resource to capture the configuration pertaining to an existing DDMS instance.")
@resource("ddmsConnectors")
model DdmsConnector is TrackedResource<DdmsConnectorProperties> {
  @doc("The name of the DDMS connector resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ddmsConnectorName")
  @segment("ddmsConnectors")
  @path
  name: string;
}

@added(Versions.v2025_10_01_preview)
@doc("The properties to configure the DdmsConnector resource.")
model DdmsConnectorProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this ddmsConnector resource to.")
  hubResourceId: HubResourceId;

  @doc("The diagnostic service endpoint URL.")
  baseUrl: url;

  @doc("Data category associated to the diagnostic service deployed via the Dragon Admin Center.")
  dacCategoryName: string;

  @doc("Corresponds to the environmentId selected while opting for a diagnostic service via the Dragon Admin Center.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  dacEnvironmentId: string;
}

@added(Versions.v2025_10_01_preview)
@armResourceOperations
interface DdmsConnectors {
  get is ArmResourceRead<DdmsConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DdmsConnector>;
  update is ArmResourcePatchAsync<DdmsConnector, DdmsConnectorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DdmsConnector>;
  listByResourceGroup is ArmResourceListByParent<DdmsConnector>;
  listBySubscription is ArmListBySubscription<DdmsConnector>;
}
