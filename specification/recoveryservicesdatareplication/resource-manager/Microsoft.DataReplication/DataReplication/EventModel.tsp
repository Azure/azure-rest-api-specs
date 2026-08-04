import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Event model.
 */
@parentResource(VaultModel)
model EventModel is Azure.ResourceManager.ProxyResource<EventModelProperties> {
  ...ResourceNameParameter<
    Resource = EventModel,
    KeyName = "eventName",
    SegmentName = "events",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

@armResourceOperations
interface Event {
  /**
   * Gets the details of the event.
   */
  get is ArmResourceRead<EventModel>;

  /**
   * Gets the list of events in the given vault.
   */
  list is ArmResourceListByParent<
    EventModel,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<EventModel>;

      /**
       * OData options.
       */
      @query("odataOptions")
      odataOptions?: string;

      /**
       * Continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Page size.
       */
      @query("pageSize")
      pageSize?: int32;
    }
  >;
}

@@doc(EventModel.name, "The event name.");
