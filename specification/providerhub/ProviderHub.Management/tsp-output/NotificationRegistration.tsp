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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ProviderRegistration)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  NotificationRegistrationProperties
)
model NotificationRegistration extends ProxyResourceBase {
  /**
   * The notification registration.
   */
  @path
  @key("notificationRegistrationName")
  @segment("notificationRegistrations")
  @visibility("read")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties?: NotificationRegistrationProperties;
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
