import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkServiceDesignGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * network service design version.
 */
@parentResource(NetworkServiceDesignGroup)
model NetworkServiceDesignVersion
  is Azure.ResourceManager.TrackedResource<NetworkServiceDesignVersionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkServiceDesignVersion,
    KeyName = "networkServiceDesignVersionName",
    SegmentName = "networkServiceDesignVersions",
    NamePattern = "^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$"
  >;
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
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @extension("x-ms-long-running-operation", true)
  createOrUpdate is ArmResourceCreateOrReplaceSync<NetworkServiceDesignVersion>;

  /**
   * Updates a network service design version resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NetworkServiceDesignVersion,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified network service design version.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkServiceDesignVersion,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Gets information about a list of network service design versions under a network service design group.
   */
  listByNetworkServiceDesignGroup is ArmResourceListByParent<NetworkServiceDesignVersion>;

  /**
   * Update network service design version state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkServiceDesignVersions_updateState")
  updateState is ArmResourceActionAsync<
    NetworkServiceDesignVersion,
    NetworkServiceDesignVersionUpdateState,
    ArmResponse<NetworkServiceDesignVersionUpdateState>,
    LroHeaders = ArmLroLocationHeader
  >;
}

@@maxLength(NetworkServiceDesignVersion.name, 64);
@@doc(NetworkServiceDesignVersion.name,
  "The name of the network service design version. The name should conform to the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html."
);
@@doc(NetworkServiceDesignVersion.properties,
  "network service design version properties."
);
@@doc(NetworkServiceDesignVersions.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network service design version operation."
);
@@doc(NetworkServiceDesignVersions.update::parameters.properties,
  "Parameters supplied to the create or update network service design version operation."
);
@@doc(NetworkServiceDesignVersions.updateState::parameters.body,
  "Parameters supplied to update the state of network service design version."
);
