import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
/**
 * The link resource format.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Hub)
@includeInapplicableMetadataInPayload(false)
model LinkResourceFormat extends ProxyResource {
  /**
   * The name of the link.
   */
  @path
  @key("linkName")
  @segment("links")
  @visibility("read")
  name: string;

  /**
   * The definition of Link.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LinkDefinition;
}

@armResourceOperations
interface LinkResourceFormats {
  /**
   * Gets a link in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Links_Get")
  get is ArmResourceRead<LinkResourceFormat>;

  /**
   * Creates a link or updates an existing link in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Links_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LinkResourceFormat>;

  /**
   * Deletes a link in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Links_Delete")
  delete is ArmResourceDeleteSync<LinkResourceFormat>;

  /**
   * Gets all the links in the specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Links_ListByHub")
  listByHub is ArmResourceListByParent<LinkResourceFormat>;
}

@@projectedName(LinkResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LinkResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Link operation."
);
