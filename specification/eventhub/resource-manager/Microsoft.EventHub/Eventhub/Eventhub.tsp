import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Single item in List or Get Event Hub operation
 */
@parentResource(EHNamespace)
model Eventhub is Azure.ResourceManager.ProxyResource<EventhubProperties> {
  ...ResourceNameParameter<
    Resource = Eventhub,
    KeyName = "eventHubName",
    SegmentName = "eventhubs",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Eventhubs {
  /**
   * Gets an Event Hubs description for the specified Event Hub.
   */
  get is ArmResourceRead<Eventhub, Error = ErrorResponse>;

  /**
   * Creates or updates a new Event Hub as a nested resource within a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Eventhub,
    Response = ArmResourceUpdatedResponse<Eventhub>,
    Error = ErrorResponse
  >;

  /**
   * Deletes an Event Hub from the specified Namespace and resource group.
   */
  delete is ArmResourceDeleteSync<Eventhub, Error = ErrorResponse>;

  /**
   * Gets all the Event Hubs in a Namespace.
   */
  listByNamespace is ArmResourceListByParent<
    Eventhub,
    Parameters = {
      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Response = EventHubListResult,
    Error = ErrorResponse
  >;
}

@@maxLength(Eventhub.name, 256);
@@minLength(Eventhub.name, 1);
@@doc(Eventhub.name, "The Event Hub name");
@@doc(Eventhub.properties,
  "Properties supplied to the Create Or Update Event Hub operation."
);
@@doc(Eventhubs.createOrUpdate::parameters.resource,
  "Parameters supplied to create an Event Hub resource."
);
