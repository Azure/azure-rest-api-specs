import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * network service design group resource.
 */
@parentResource(Publisher)
model NetworkServiceDesignGroup
  is Azure.ResourceManager.TrackedResource<NetworkServiceDesignGroupPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkServiceDesignGroup,
    KeyName = "networkServiceDesignGroupName",
    SegmentName = "networkServiceDesignGroups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface NetworkServiceDesignGroups {
  /**
   * Gets information about the specified networkServiceDesign group.
   */
  get is ArmResourceRead<NetworkServiceDesignGroup>;

  /**
   * Creates or updates a network service design group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkServiceDesignGroup,
    LroHeaders = ArmAsyncOperationHeader
  >;

  /**
   * Updates a network service design groups resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NetworkServiceDesignGroup,
    PatchModel = TagsObject
  >;

  /**
   * Deletes a specified network service design group.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkServiceDesignGroup,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets provisioningState to 'Deleting' until the operation is completed. Returns an operation URI that can be queried to find the current state of the operation.",
      LroHeaders = ArmLroLocationHeader
    > | ArmNoContentResponse<"Request is successful. Resource does not exist.">,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Gets information of the network service design groups under a publisher.
   */
  listByPublisher is ArmResourceListByParent<NetworkServiceDesignGroup>;
}

@@maxLength(NetworkServiceDesignGroup.name, 64);
@@doc(NetworkServiceDesignGroup.name,
  "The name of the network service design group."
);
@@doc(NetworkServiceDesignGroup.properties,
  "network service design group properties."
);
@@doc(NetworkServiceDesignGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update publisher network service design group operation."
);
@@doc(NetworkServiceDesignGroups.update::parameters.properties,
  "Parameters supplied to the create or update publisher network service design group operation."
);
