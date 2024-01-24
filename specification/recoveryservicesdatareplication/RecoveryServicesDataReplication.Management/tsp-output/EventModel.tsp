import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Event model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(VaultModel)
@Azure.ResourceManager.Private.armResourceInternal(EventModelProperties)
@includeInapplicableMetadataInPayload(false)
model EventModel extends ProxyResourceBase {
  /**
   * The event name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("eventName")
  @segment("events")
  name: string;

  /**
   * Event model properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: EventModelProperties;
}

@armResourceOperations
interface EventModels {
  /**
   * Gets the details of the event.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Event_Get")
  get is ArmResourceRead<EventModel>;

  /**
   * Gets the list of events in the given vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Event_List")
  list is ArmResourceListByParent<
    EventModel,
    {
      ...BaseParameters<EventModel>;

      /**
       * Filter string.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
