import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualHub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The routing intent child resource of a Virtual hub.
 */
@parentResource(VirtualHub)
model RoutingIntent
  is Azure.ResourceManager.ProxyResource<RoutingIntentProperties> {
  ...ResourceNameParameter<
    Resource = RoutingIntent,
    KeyName = "routingIntentName",
    SegmentName = "routingIntent",
    NamePattern = ""
  >;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface RoutingIntents {
  /**
   * Retrieves the details of a RoutingIntent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RoutingIntent_Get")
  get is ArmResourceRead<RoutingIntent, Error = CloudError>;

  /**
   * Creates a RoutingIntent resource if it doesn't exist else updates the existing RoutingIntent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RoutingIntent_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RoutingIntent,
    Error = CloudError
  >;

  /**
   * Deletes a RoutingIntent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RoutingIntent_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    RoutingIntent,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the details of all RoutingIntent child resources of the VirtualHub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("RoutingIntent_List")
  list is ArmResourceListByParent<
    RoutingIntent,
    Response = ArmResponse<ListRoutingIntentResult>,
    Error = CloudError
  >;
}

@@doc(RoutingIntent.name, "The name of the RoutingIntent.");
@@doc(RoutingIntent.properties, "Properties of the RoutingIntent resource.");
@@doc(RoutingIntents.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update RoutingIntent."
);
