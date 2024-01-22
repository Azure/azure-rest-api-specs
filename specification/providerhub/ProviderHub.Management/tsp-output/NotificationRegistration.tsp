import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;
/**
 * The notification registration definition.
 */
@parentResource(ProviderRegistration)
model NotificationRegistration
  is ProxyResource<NotificationRegistrationProperties> {
  /**
   * The notification registration.
   */
  @path
  @key("notificationRegistrationName")
  @segment("notificationRegistrations")
  name: string;
}

@armResourceOperations
interface NotificationRegistrations {
  /**
   * Gets the notification registration details.
   */
  get is ArmResourceRead<NotificationRegistration>;

  /**
   * Creates or updates a notification registration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationRegistration>;

  /**
   * Deletes a notification registration.
   */
  delete is ArmResourceDeleteSync<NotificationRegistration>;

  /**
   * Gets the list of the notification registrations for the given provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NotificationRegistrations_ListByProviderRegistration")
  listByProviderRegistration is ArmResourceListByParent<NotificationRegistration>;
}

@@projectedName(NotificationRegistrations.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(NotificationRegistrations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(NotificationRegistrations.createOrUpdate::parameters.resource,
  "The required body parameters supplied to the notification registration operation."
);
