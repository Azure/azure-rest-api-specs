import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFunctionDefinitionGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
@doc("Network function definition version.")
@parentResource(NetworkFunctionDefinitionGroup)
model NetworkFunctionDefinitionVersion
  is TrackedResource<NetworkFunctionDefinitionVersionPropertiesFormat> {
  @doc("The name of the network function definition version. The name should conform to the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.")
  @maxLength(64)
  @pattern("^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$")
  @path
  @key("networkFunctionDefinitionVersionName")
  @segment("networkFunctionDefinitionVersions")
  name: string;
}

@armResourceOperations
interface NetworkFunctionDefinitionVersions {
  @doc("Gets information about a network function definition version.")
  get is ArmResourceRead<NetworkFunctionDefinitionVersion>;

  @doc("Creates or updates a network function definition version.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NetworkFunctionDefinitionVersion,
    BaseParameters<NetworkFunctionDefinitionVersion>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a network function definition version resource.")
  update is ArmCustomPatchSync<NetworkFunctionDefinitionVersion, TagsObject>;

  @doc("Deletes the specified network function definition version.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFunctionDefinitionVersion,
    BaseParameters<NetworkFunctionDefinitionVersion>,
    ArmLroLocationHeader
  >;

  @doc("Gets information about a list of network function definition versions under a network function definition group.")
  listByNetworkFunctionDefinitionGroup is ArmResourceListByParent<NetworkFunctionDefinitionVersion>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update network function definition version state.")
  @operationId("NetworkFunctionDefinitionVersions_updateState")
  updateState is ArmResourceActionAsync<
    NetworkFunctionDefinitionVersion,
    NetworkFunctionDefinitionVersionUpdateState,
    NetworkFunctionDefinitionVersionUpdateState,
    BaseParameters<NetworkFunctionDefinitionVersion>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkFunctionDefinitionVersions.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NetworkFunctionDefinitionVersions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctionDefinitionVersions.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network function definition version operation."
);
@@projectedName(NetworkFunctionDefinitionVersions.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(NetworkFunctionDefinitionVersions.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctionDefinitionVersions.update::parameters.properties,
  "Parameters supplied to the create or update network function definition version operation."
);
@@projectedName(NetworkFunctionDefinitionVersions.updateState::parameters.body,
  "json",
  "parameters"
);
@@extension(NetworkFunctionDefinitionVersions.updateState::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctionDefinitionVersions.updateState::parameters.body,
  "Parameters supplied to update the state of network function definition version."
);
