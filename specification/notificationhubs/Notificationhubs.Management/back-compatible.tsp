import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NotificationHubs;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApnsCredential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WnsCredential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GcmCredential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MpnsCredential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdmCredential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BaiduCredential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BrowserCredential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(XiaomiCredential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FcmV1Credential.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NotificationHubPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DebugSendResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PnsCredentialsResource.properties);

@@clientName(NotificationHubResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NotificationHubResources.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NotificationHubResource.properties);

@@clientName(SharedAccessAuthorizationRuleResources.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientName(SharedAccessAuthorizationRuleResources.regenerateKeys::parameters.body,
  "parameters"
);
@@clientName(Namespaces.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientName(Namespaces.regenerateKeys::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SharedAccessAuthorizationRuleResource.properties);

@@clientName(NamespaceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NamespaceResources.update::parameters.properties, "parameters");
@@clientName(NamespaceResources.checkNotificationHubAvailability::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamespaceResource.properties);

@@clientName(PrivateEndpointConnectionResources.update::parameters.resource,
  "parameters"
);
@@clientName(NamespacesOperationGroup.checkAvailability::parameters.body,
  "parameters"
);
@@clientName(CheckAvailabilityParameters, "CheckAvailabilityContent", "csharp");
@@clientName(Operation, "Info", "csharp");
