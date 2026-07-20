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
 * Network function definition group resource.
 */
@parentResource(Publisher)
model NetworkFunctionDefinitionGroup
  is Azure.ResourceManager.TrackedResource<NetworkFunctionDefinitionGroupPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkFunctionDefinitionGroup,
    KeyName = "networkFunctionDefinitionGroupName",
    SegmentName = "networkFunctionDefinitionGroups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface NetworkFunctionDefinitionGroups {
  /**
   * Gets information about the specified networkFunctionDefinition group.
   */
  get is ArmResourceRead<NetworkFunctionDefinitionGroup>;

  /**
   * Creates or updates a network function definition group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkFunctionDefinitionGroup,
    LroHeaders = ArmAsyncOperationHeader
  >;

  /**
   * Updates a network function definition group resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NetworkFunctionDefinitionGroup,
    PatchModel = TagsObject
  >;

  /**
   * Deletes a specified network function definition group.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFunctionDefinitionGroup,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets provisioningState to 'Deleting' until the operation is completed. Returns an operation URI that can be queried to find the current state of the operation.",
      LroHeaders = ArmLroLocationHeader
    > | ArmNoContentResponse<"Request is successful. Resource does not exist.">,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Gets information of the network function definition groups under a publisher.
   */
  listByPublisher is ArmResourceListByParent<NetworkFunctionDefinitionGroup>;
}

@@maxLength(NetworkFunctionDefinitionGroup.name, 64);
@@doc(NetworkFunctionDefinitionGroup.name,
  "The name of the network function definition group."
);
@@doc(NetworkFunctionDefinitionGroup.properties,
  "Network function definition group properties."
);
@@doc(NetworkFunctionDefinitionGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update publisher network function definition group operation."
);
@@doc(NetworkFunctionDefinitionGroups.update::parameters.properties,
  "Parameters supplied to the create or update publisher network function definition group operation."
);
