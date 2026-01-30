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
@parentResource(Vault)
model Event is Azure.ResourceManager.ProxyResource<EventProperties> {
  ...ResourceNameParameter<
    Resource = Event,
    KeyName = "eventName",
    SegmentName = "replicationEvents",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface Events {
  /**
   * The operation to get the details of an Azure Site recovery event.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get the details of an Azure Site recovery event.")
  get is ArmResourceRead<Event, Error = never>;

  /**
   * Gets the list of Azure Site Recovery events for the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of Azure Site Recovery events.")
  list is ArmResourceListByParent<
    Event,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<EventCollection>,
    Error = never
  >;
}

@@doc(Event.name, "The name of the Azure Site Recovery event.");
@@doc(Event.properties, "Event related data.");
