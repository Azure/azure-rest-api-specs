import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
/**
 * Peering Service
 */
model PeeringService is TrackedResource<PeeringServiceProperties> {
  /**
   * The name of the peering.
   */
  @path
  @key("peeringServiceName")
  @segment("peeringServices")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface PeeringServices {
  /**
   * Gets an existing peering service with the specified name under the given subscription and resource group.
   */
  get is ArmResourceRead<PeeringService>;

  /**
   * Creates a new peering service or updates an existing peering with the specified name under the given subscription and resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringService>;

  /**
   * Updates tags for a peering service with the specified name under the given subscription and resource group.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    PeeringService,
    Paths3702DwSubscriptionsSubscriptionidResourcegroupsResourcegroupnameProvidersMicrosoftPeeringPeeringservicesPeeringservicenamePatchRequestbodyContentApplicationJsonSchema
  >;

  /**
   * Deletes an existing peering service with the specified name under the given subscription and resource group.
   */
  delete is ArmResourceDeleteSync<PeeringService>;

  /**
   * Lists all of the peering services under the given subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PeeringServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<PeeringService>;

  /**
   * Lists all of the peerings under the given subscription.
   */
  listBySubscription is ArmListBySubscription<PeeringService>;
}

@@projectedName(PeeringServices.createOrUpdate::parameters.resource,
  "json",
  "peeringService"
);
@@extension(PeeringServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "peeringService"
);
@@doc(PeeringServices.createOrUpdate::parameters.resource,
  "The properties needed to create or update a peering service."
);
@@projectedName(PeeringServices.update::parameters.properties, "json", "tags");
@@extension(PeeringServices.update::parameters.properties,
  "x-ms-client-name",
  "tags"
);
@@doc(PeeringServices.update::parameters.properties, "The resource tags.");
