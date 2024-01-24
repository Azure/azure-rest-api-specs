import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Update details
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@Azure.ResourceManager.Private.armResourceInternal(UpdateProperties)
@includeInapplicableMetadataInPayload(false)
model Update extends ProxyResourceBase {
  /**
   * The name of the Update
   */
  @path
  @key("updateName")
  @segment("updates")
  name: string;

  /**
   * Update properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: UpdateProperties;
}

@armResourceOperations
interface Updates {
  /**
   * Get specified Update
   */
  get is ArmResourceRead<Update>;

  /**
   * Put specified Update
   */
  put is ArmResourceCreateOrReplaceSync<Update>;

  /**
   * Delete specified Update
   */
  delete is ArmResourceDeleteAsync<
    Update,
    BaseParameters<Update>,
    ArmAsyncOperationHeader
  >;

  /**
   * List all Updates
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Updates_List")
  list is ArmResourceListByParent<Update>;

  /**
   * Apply Update
   */
  post is ArmResourceActionAsync<
    Update,
    void,
    void,
    BaseParameters<Update>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(Updates.put::parameters.resource, "json", "updateProperties");
@@extension(Updates.put::parameters.resource,
  "x-ms-client-name",
  "updateProperties"
);
@@doc(Updates.put::parameters.resource, "Properties of the Updates object");
