import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFunctionDefinitionGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Network function definition version.
 */
@parentResource(NetworkFunctionDefinitionGroup)
model NetworkFunctionDefinitionVersion
  is Azure.ResourceManager.TrackedResource<NetworkFunctionDefinitionVersionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkFunctionDefinitionVersion,
    KeyName = "networkFunctionDefinitionVersionName",
    SegmentName = "networkFunctionDefinitionVersions",
    NamePattern = "^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$"
  >;
}

@armResourceOperations
interface NetworkFunctionDefinitionVersions {
  /**
   * Gets information about a network function definition version.
   */
  get is ArmResourceRead<NetworkFunctionDefinitionVersion>;

  /**
   * Creates or updates a network function definition version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  #suppress "@azure-tools/typespec-azure-resource-manager/retry-after"
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @extension("x-ms-long-running-operation", true)
  createOrUpdate is ArmResourceCreateOrReplaceSync<NetworkFunctionDefinitionVersion>;

  /**
   * Updates a network function definition version resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NetworkFunctionDefinitionVersion,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified network function definition version.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFunctionDefinitionVersion,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Gets information about a list of network function definition versions under a network function definition group.
   */
  listByNetworkFunctionDefinitionGroup is ArmResourceListByParent<NetworkFunctionDefinitionVersion>;

  /**
   * Update network function definition version state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkFunctionDefinitionVersions_updateState")
  updateState is ArmResourceActionAsync<
    NetworkFunctionDefinitionVersion,
    NetworkFunctionDefinitionVersionUpdateState,
    ArmResponse<NetworkFunctionDefinitionVersionUpdateState>,
    LroHeaders = ArmLroLocationHeader
  >;
}

@@maxLength(NetworkFunctionDefinitionVersion.name, 64);
@@doc(NetworkFunctionDefinitionVersion.name,
  "The name of the network function definition version. The name should conform to the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html."
);
@@doc(NetworkFunctionDefinitionVersion.properties,
  "Network function definition version properties."
);
@@doc(NetworkFunctionDefinitionVersions.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network function definition version operation."
);
@@doc(NetworkFunctionDefinitionVersions.update::parameters.properties,
  "Parameters supplied to the create or update network function definition version operation."
);
@@doc(NetworkFunctionDefinitionVersions.updateState::parameters.body,
  "Parameters supplied to update the state of network function definition version."
);
