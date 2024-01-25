import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LiveEvent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * The Live Output.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(LiveEvent)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(LiveOutputProperties)
model LiveOutput extends ProxyResourceBase {
  /**
   * The name of the live output.
   */
  @maxLength(256)
  @minLength(1)
  @pattern("^([a-zA-Z0-9])+(-*[a-zA-Z0-9])*$")
  @path
  @key("liveOutputName")
  @segment("liveOutputs")
  @visibility("read")
  name: string;

  /**
   * Live output properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LiveOutputProperties;
}

@armResourceOperations
interface LiveOutputs {
  /**
   * Gets a live output.
   */
  get is ArmResourceRead<LiveOutput>;

  /**
   * Creates a new live output.
   */
  create is ArmResourceCreateOrReplaceAsync<LiveOutput>;

  /**
   * Deletes a live output. Deleting a live output does not delete the asset the live output is writing to.
   */
  delete is ArmResourceDeleteAsync<LiveOutput>;

  /**
   * Lists the live outputs of a live event.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LiveOutputs_List")
  list is ArmResourceListByParent<LiveOutput>;
}

@@projectedName(LiveOutputs.create::parameters.resource, "json", "parameters");
@@extension(LiveOutputs.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LiveOutputs.create::parameters.resource,
  "Live Output properties needed for creation."
);
