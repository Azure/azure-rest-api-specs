import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NamespaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NotificationHubs;
/**
 * Description of a NotificationHub Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(NamespaceResource)
@includeInapplicableMetadataInPayload(false)
model NotificationHubResource extends Resource {
  /**
   * The notification hub name.
   */
  @path
  @key("notificationHubName")
  @segment("notificationHubs")
  @visibility("read")
  name: string;

  /**
   * Properties of the NotificationHub.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NotificationHubProperties;
}

@armResourceOperations
interface NotificationHubResources {
  /**
   * Lists the notification hubs associated with a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NotificationHubs_Get")
  get is ArmResourceRead<NotificationHubResource>;

  /**
   * Creates/Update a NotificationHub in a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NotificationHubs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationHubResource>;

  /**
   * Patch a NotificationHub in a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("NotificationHubs_Patch")
  patch is ArmCustomPatchSync<
    NotificationHubResource,
    NotificationHubPatchParameters
  >;

  /**
   * Deletes a notification hub associated with a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NotificationHubs_Delete")
  delete is ArmResourceDeleteSync<NotificationHubResource>;

  /**
   * Lists the notification hubs associated with a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NotificationHubs_List")
  list is ArmResourceListByParent<NotificationHubResource>;

  /**
   * test send a push notification
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NotificationHubs_DebugSend")
  debugSend is ArmResourceActionNoContentSync<
    NotificationHubResource,
    AnyObject
  >;

  /**
   * Lists the PNS Credentials associated with a notification hub .
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NotificationHubs_GetPnsCredentials")
  getPnsCredentials is ArmResourceActionSync<
    NotificationHubResource,
    void,
    PnsCredentialsResource
  >;
}

@@projectedName(NotificationHubResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NotificationHubResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NotificationHubResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the create/update a NotificationHub Resource."
);
@@projectedName(NotificationHubResources.patch::parameters.properties,
  "json",
  "parameters"
);
@@extension(NotificationHubResources.patch::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NotificationHubResources.patch::parameters.properties,
  "Parameters supplied to patch a NotificationHub Resource."
);
@@projectedName(NotificationHubResources.debugSend::parameters.body,
  "json",
  "parameters"
);
@@extension(NotificationHubResources.debugSend::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NotificationHubResources.debugSend::parameters.body,
  "Debug send parameters"
);
