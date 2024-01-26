import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * The top level Linked service resource container.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workspace)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(LinkedServiceProperties)
model LinkedService extends ProxyResourceBase {
  /**
   * Name of the linked service.
   */
  @path
  @key("linkedServiceName")
  @segment("linkedServices")
  @visibility("read")
  name: string;

  /**
   * The properties of the linked service.
   */
  @extension("x-ms-client-flatten", true)
  properties: LinkedServiceProperties;
}

@armResourceOperations
interface LinkedServices {
  /**
   * Gets a linked service instance.
   */
  get is ArmResourceRead<LinkedService>;

  /**
   * Create or update a linked service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LinkedService>;

  /**
   * Deletes a linked service instance.
   */
  delete is ArmResourceDeleteAsync<LinkedService>;

  /**
   * Gets the linked services instances in a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LinkedServices_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<LinkedService>;
}

@@projectedName(LinkedServices.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LinkedServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkedServices.createOrUpdate::parameters.resource,
  "The parameters required to create or update a linked service."
);
