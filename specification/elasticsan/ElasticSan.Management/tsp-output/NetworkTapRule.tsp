import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("The NetworkTapRule resource definition.")
model NetworkTapRule is TrackedResource<NetworkTapRuleProperties> {
  @doc("Name of the Network Tap Rule.")
  @path
  @key("networkTapRuleName")
  @segment("networkTapRules")
  name: string;
}

@armResourceOperations
interface NetworkTapRules {
  @doc("Get Network Tap Rule resource details.")
  get is ArmResourceRead<NetworkTapRule>;

  @doc("Create Network Tap Rule resource.")
  create is ArmResourceCreateOrUpdateAsync<
    NetworkTapRule,
    BaseParameters<NetworkTapRule>,
    ArmAsyncOperationHeader
  >;

  @doc("Update certain properties of the Network Tap Rule resource.")
  update is ArmCustomPatchAsync<
    NetworkTapRule,
    NetworkTapRulePatch,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;

  @doc("Delete Network Tap Rule resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkTapRule,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;

  @doc("List all the Network Tap Rule resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkTapRule>;

  @doc("List all the Network Tap Rule resources in the given subscription.")
  listBySubscription is ArmListBySubscription<NetworkTapRule>;

  @doc("Implements the operation to the underlying resources.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkTapRule,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;

  @doc("Implements the operation to the underlying resources.")
  resync is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;

  @doc("Implements the operation to the underlying resources.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    ValidateConfigurationResponse,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkTapRules.create::parameters.resource, "json", "body");
@@extension(NetworkTapRules.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkTapRules.create::parameters.resource, "Request payload.");
@@projectedName(NetworkTapRules.update::parameters.properties, "json", "body");
@@extension(NetworkTapRules.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkTapRules.update::parameters.properties,
  "Network Tap Rule properties to update."
);
@@doc(NetworkTapRules.updateAdministrativeState::parameters.body,
  "Request payload."
);
