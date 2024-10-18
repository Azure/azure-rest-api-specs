import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./../helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.OpenAPI;

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

  ...EntityTagProperty;
}

@doc("The provisioning state of the UpdateStrategy resource.")
union FleetUpdateStrategyProvisioningState {
  string,
  ResourceProvisioningState,
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

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE AT NEXT API VERSION UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetUpdateStrategy,
    Azure.ResourceManager.Foundations.BaseParameters<FleetUpdateStrategy> &
      IfMatchParameters<FleetUpdateStrategy> &
      IfNoneMatchParameters<FleetUpdateStrategy>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated" "Existing API"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - migrate to LRO apis"
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  delete is ArmResourceDeleteAsync<
    FleetUpdateStrategy,
    Azure.ResourceManager.Foundations.BaseParameters<FleetUpdateStrategy> &
      IfMatchParameters<FleetUpdateStrategy>
  >;

  /** List FleetUpdateStrategy resources by Fleet */
  listByFleet is ArmResourceListByParent<FleetUpdateStrategy>;
}
