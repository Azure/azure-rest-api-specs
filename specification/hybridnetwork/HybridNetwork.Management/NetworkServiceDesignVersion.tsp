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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(NetworkServiceDesignGroup)
model networkServiceDesignVersion
  is Azure.ResourceManager.TrackedResource<networkServiceDesignVersionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = networkServiceDesignVersion,
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
  get is ArmResourceRead<networkServiceDesignVersion>;

  /**
   * Creates or updates a network service design version.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    networkServiceDesignVersion,
    LroHeaders = ArmAsyncOperationHeader
  >;

  /**
   * Updates a network service design version resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    networkServiceDesignVersion,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified network service design version.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    networkServiceDesignVersion,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets provisioningState to 'Deleting' until the operation is completed. Returns an operation URI that can be queried to find the current state of the operation.",
      LroHeaders = ArmLroLocationHeader
    > | ArmNoContentResponse<"Request is successful. Resource does not exist.">,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Gets information about a list of network service design versions under a network service design group.
   */
  listByNetworkServiceDesignGroup is ArmResourceListByParent<networkServiceDesignVersion>;

  /**
   * Update network service design version state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkServiceDesignVersions_updateState")
  updateState is ArmResourceActionAsyncBase<
    networkServiceDesignVersion,
    NetworkServiceDesignVersionUpdateState,
    ArmResponse<NetworkServiceDesignVersionUpdateState> | ArmAcceptedLroResponse<
      "The request of updating network service design version state is accepted.",
      ArmLroLocationHeader<FinalResult = NetworkServiceDesignVersionUpdateState>
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<networkServiceDesignVersion>
  >;
}

@@maxLength(networkServiceDesignVersion.name, 64);
@@doc(networkServiceDesignVersion.name,
  "The name of the network service design version. The name should conform to the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html."
);
@@doc(networkServiceDesignVersion.properties,
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
