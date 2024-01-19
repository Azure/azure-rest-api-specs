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
@doc("Description of a NotificationHub Resource.")
@parentResource(NamespaceResource)
model NotificationHubResource is TrackedResource<NotificationHubProperties> {
  @doc("The notification hub name.")
  @path
  @key("notificationHubName")
  @segment("notificationHubs")
  name: string;
}

@armResourceOperations
interface NotificationHubResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the notification hubs associated with a namespace.")
  @operationId("NotificationHubs_Get")
  get is ArmResourceRead<NotificationHubResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates/Update a NotificationHub in a namespace.")
  @operationId("NotificationHubs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationHubResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patch a NotificationHub in a namespace.")
  @operationId("NotificationHubs_Patch")
  patch is ArmCustomPatchSync<
    NotificationHubResource,
    NotificationHubPatchParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a notification hub associated with a namespace.")
  @operationId("NotificationHubs_Delete")
  delete is ArmResourceDeleteSync<NotificationHubResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the notification hubs associated with a namespace.")
  @operationId("NotificationHubs_List")
  list is ArmResourceListByParent<NotificationHubResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("test send a push notification")
  @operationId("NotificationHubs_DebugSend")
  debugSend is ArmResourceActionNoContentSync<
    NotificationHubResource,
    AnyObject
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the PNS Credentials associated with a notification hub .")
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
