import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkServiceDesignGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * network service design version.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(NetworkServiceDesignGroup)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkServiceDesignVersionPropertiesFormat
)
@includeInapplicableMetadataInPayload(false)
model NetworkServiceDesignVersion extends TrackedResourceBase {
  /**
   * The name of the network service design version. The name should conform to the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.
   */
  @maxLength(64)
  @pattern("^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$")
  @path
  @key("networkServiceDesignVersionName")
  @segment("networkServiceDesignVersions")
  name: string;

  /**
   * network service design version properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkServiceDesignVersionPropertiesFormat;
}

@armResourceOperations
interface NetworkServiceDesignVersions {
  /**
   * Gets information about a network service design version.
   */
  get is ArmResourceRead<NetworkServiceDesignVersion>;

  /**
   * Creates or updates a network service design version.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkServiceDesignVersion,
    BaseParameters<NetworkServiceDesignVersion>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a network service design version resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<NetworkServiceDesignVersion, TagsObject>;

  /**
   * Deletes the specified network service design version.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkServiceDesignVersion,
    BaseParameters<NetworkServiceDesignVersion>,
    ArmLroLocationHeader
  >;

  /**
   * Gets information about a list of network service design versions under a network service design group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkServiceDesignVersions_ListByNetworkServiceDesignGroup")
  listByNetworkServiceDesignGroup is ArmResourceListByParent<NetworkServiceDesignVersion>;

  /**
   * Update network service design version state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkServiceDesignVersions_updateState")
  updateState is ArmResourceActionAsync<
    NetworkServiceDesignVersion,
    NetworkServiceDesignVersionUpdateState,
    NetworkServiceDesignVersionUpdateState,
    BaseParameters<NetworkServiceDesignVersion>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkServiceDesignVersions.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NetworkServiceDesignVersions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkServiceDesignVersions.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network service design version operation."
);
@@projectedName(NetworkServiceDesignVersions.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(NetworkServiceDesignVersions.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkServiceDesignVersions.update::parameters.properties,
  "Parameters supplied to the create or update network service design version operation."
);
@@projectedName(NetworkServiceDesignVersions.updateState::parameters.body,
  "json",
  "parameters"
);
@@extension(NetworkServiceDesignVersions.updateState::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkServiceDesignVersions.updateState::parameters.body,
  "Parameters supplied to update the state of network service design version."
);
