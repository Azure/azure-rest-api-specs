import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Implements the Event class.
 */
model Event is Azure.ResourceManager.ProxyResource<EventProperties> {
  ...ResourceNameParameter<
    Resource = Event,
    KeyName = "eventName",
    SegmentName = "replicationEvents",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Events {
  /**
   * The operation to get the details of an Azure Site recovery event.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationEvents_Get")
  get is ArmResourceRead<Event>;

  /**
   * Gets the list of Azure Site Recovery events for the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationEvents_List")
  list is ArmResourceListByParent<
    Event,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<EventCollection>
  >;
}

@@doc(Event.name, "The name of the Azure Site Recovery event.");
@@doc(Event.properties, "Event related data.");
