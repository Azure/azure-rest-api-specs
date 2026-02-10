import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@parentResource(ProviderRegistration)
model NotificationRegistration
  is Azure.ResourceManager.ProxyResource<NotificationRegistrationProperties> {
  ...ResourceNameParameter<
    Resource = NotificationRegistration,
    KeyName = "notificationRegistrationName",
    SegmentName = "notificationRegistrations",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    NotificationRegistration,
    Response = ArmResourceUpdatedResponse<NotificationRegistration>
  >;

  /**
   * Deletes a notification registration.
   */
  delete is ArmResourceDeleteSync<NotificationRegistration>;

  /**
   * Gets the list of the notification registrations for the given provider.
   */
  listByProviderRegistration is ArmResourceListByParent<
    NotificationRegistration,
    Response = ArmResponse<NotificationRegistrationArrayResponseWithContinuation>
  >;
}

@@doc(NotificationRegistration.name, "The notification registration.");
@@doc(NotificationRegistration.properties, "");
@@doc(NotificationRegistrations.createOrUpdate::parameters.resource,
  "The required body parameters supplied to the notification registration operation."
);
