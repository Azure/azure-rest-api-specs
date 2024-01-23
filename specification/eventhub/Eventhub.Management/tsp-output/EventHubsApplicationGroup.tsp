import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * The Application Group object
 */
@parentResource(EventHubsNamespace)
model EventHubsApplicationGroup is ProxyResource<ApplicationGroupProperties> {
  /**
   * The Application Group name
   */
  @maxLength(256)
  @minLength(1)
  @path
  @key("applicationGroupName")
  @segment("applicationGroups")
  name: string;
}

@armResourceOperations
interface EventHubsApplicationGroups {
  /**
   * Gets an ApplicationGroup for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationGroup_Get")
  get is ArmResourceRead<EventHubsApplicationGroup>;

  /**
   * Creates or updates an ApplicationGroup for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationGroup_CreateOrUpdateApplicationGroup")
  createOrUpdateApplicationGroup is ArmResourceCreateOrReplaceSync<EventHubsApplicationGroup>;

  /**
   * Deletes an ApplicationGroup for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationGroup_Delete")
  delete is ArmResourceDeleteSync<EventHubsApplicationGroup>;

  /**
   * Gets a list of application groups for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationGroup_ListByNamespace")
  listByNamespace is ArmResourceListByParent<EventHubsApplicationGroup>;
}

@@projectedName(EventHubsApplicationGroups.createOrUpdateApplicationGroup::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubsApplicationGroups.createOrUpdateApplicationGroup::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsApplicationGroups.createOrUpdateApplicationGroup::parameters.resource,
  "The ApplicationGroup."
);
