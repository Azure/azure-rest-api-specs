import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Network function definition group resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Publisher)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkFunctionDefinitionGroupPropertiesFormat
)
model NetworkFunctionDefinitionGroup extends TrackedResourceBase {
  /**
   * The name of the network function definition group.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("networkFunctionDefinitionGroupName")
  @segment("networkFunctionDefinitionGroups")
  @visibility("read")
  name: string;

  /**
   * Network function definition group properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkFunctionDefinitionGroupPropertiesFormat;
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
    BaseParameters<NetworkFunctionDefinitionGroup>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a network function definition group resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<NetworkFunctionDefinitionGroup, TagsObject>;

  /**
   * Deletes a specified network function definition group.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFunctionDefinitionGroup,
    BaseParameters<NetworkFunctionDefinitionGroup>,
    ArmLroLocationHeader
  >;

  /**
   * Gets information of the network function definition groups under a publisher.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFunctionDefinitionGroups_ListByPublisher")
  listByPublisher is ArmResourceListByParent<NetworkFunctionDefinitionGroup>;
}

@@projectedName(NetworkFunctionDefinitionGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NetworkFunctionDefinitionGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctionDefinitionGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update publisher network function definition group operation."
);
@@projectedName(NetworkFunctionDefinitionGroups.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(NetworkFunctionDefinitionGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctionDefinitionGroups.update::parameters.properties,
  "Parameters supplied to the create or update publisher network function definition group operation."
);
