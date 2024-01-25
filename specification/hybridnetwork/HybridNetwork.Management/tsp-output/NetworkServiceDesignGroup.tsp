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
 * network service design group resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Publisher)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkServiceDesignGroupPropertiesFormat
)
model NetworkServiceDesignGroup extends TrackedResourceBase {
  /**
   * The name of the network service design group.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("networkServiceDesignGroupName")
  @segment("networkServiceDesignGroups")
  @visibility("read")
  name: string;

  /**
   * network service design group properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkServiceDesignGroupPropertiesFormat;
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
    BaseParameters<NetworkServiceDesignGroup>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a network service design groups resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<NetworkServiceDesignGroup, TagsObject>;

  /**
   * Deletes a specified network service design group.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkServiceDesignGroup,
    BaseParameters<NetworkServiceDesignGroup>,
    ArmLroLocationHeader
  >;

  /**
   * Gets information of the network service design groups under a publisher.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkServiceDesignGroups_ListByPublisher")
  listByPublisher is ArmResourceListByParent<NetworkServiceDesignGroup>;
}

@@projectedName(NetworkServiceDesignGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NetworkServiceDesignGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkServiceDesignGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update publisher network service design group operation."
);
@@projectedName(NetworkServiceDesignGroups.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(NetworkServiceDesignGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkServiceDesignGroups.update::parameters.properties,
  "Parameters supplied to the create or update publisher network service design group operation."
);
