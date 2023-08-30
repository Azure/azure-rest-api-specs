import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./../helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

namespace Microsoft.ContainerService;

@resource("updateStrategies")
@parentResource(Fleet)
@added(Versions.v2023_08_15_preview)
@doc("Defines a multi-stage process to perform update operations across members of a Fleet.")
model FleetUpdateStrategy is ProxyResource<FleetUpdateStrategyProperties> {
  @doc("The name of the UpdateStrategy resource.")
  @key("updateStrategyName")
  @segment("updateStrategies")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  @path
  @visibility("create", "read")
  name: string;

  ...EntityTag;
}

@doc("The provisioning state of the UpdateStrategy resource.")
enum FleetUpdateStrategyProvisioningState {
  ...ResourceProvisioningState,
}

@doc("The properties of the UpdateStrategy.")
model FleetUpdateStrategyProperties {
  @visibility("read")
  @doc("The provisioning state of the UpdateStrategy resource.")
  provisioningState?: FleetUpdateStrategyProvisioningState;

  @visibility("create", "read", "update")
  @doc("Defines the update sequence of the clusters.")
  strategy: UpdateRunStrategy;
}

@added(Versions.v2023_08_15_preview)
@armResourceOperations
interface FleetUpdateStrategies {
  get is ArmResourceRead<FleetUpdateStrategy>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetUpdateStrategy,
    BaseParameters<FleetUpdateStrategy> &
      IfMatchParameters<FleetUpdateStrategy> &
      IfNoneMatchParameters<FleetUpdateStrategy>
  >;

  delete is FleetArmResourceDeleteAsync<
    FleetUpdateStrategy,
    BaseParameters<FleetUpdateStrategy> & IfMatchParameters<FleetUpdateStrategy>
  >;

  listByParent is ArmResourceListByParent<FleetUpdateStrategy>;
}
