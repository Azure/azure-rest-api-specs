import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NotificationHubs;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ApnsCredential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(WnsCredential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(GcmCredential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MpnsCredential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AdmCredential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BaiduCredential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BrowserCredential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(XiaomiCredential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FcmV1Credential.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NotificationHubPatchParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DebugSendResponse.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PnsCredentialsResource.properties);

@@clientName(NotificationHubResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NotificationHubResources.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SharedAccessAuthorizationRuleResource.properties);

@@clientName(NamespaceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NamespaceResources.update::parameters.properties, "parameters");
@@clientName(NamespaceResources.checkNotificationHubAvailability::parameters.body,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NamespaceResource.properties);

@@clientName(PrivateEndpointConnectionResources.update::parameters.resource,
  "parameters"
);
@@clientName(NamespacesOperationGroup.checkAvailability::parameters.body,
  "parameters"
);
@@clientName(CheckAvailabilityParameters, "CheckAvailabilityContent", "csharp");
@@clientName(DebugSendResponse, "DebugSendResponseResult", "csharp");
@@clientName(Operation, "Info", "csharp");

// @@clientLocation decorators for operations with @operationId
@@clientLocation(NamespaceResources.get, Namespaces);
@@clientName(NamespaceResources.get, "Get");
@@clientLocation(NamespaceResources.createOrUpdate, Namespaces);
@@clientName(NamespaceResources.createOrUpdate, "CreateOrUpdate");
@@clientLocation(NamespaceResources.update, Namespaces);
@@clientName(NamespaceResources.update, "Update");
@@clientLocation(NamespaceResources.delete, Namespaces);
@@clientName(NamespaceResources.delete, "Delete");
@@clientLocation(NamespaceResources.list, Namespaces);
@@clientName(NamespaceResources.list, "List");
@@clientLocation(NamespaceResources.listAll, Namespaces);
@@clientName(NamespaceResources.listAll, "ListAll");
@@clientLocation(NamespaceResources.checkNotificationHubAvailability,
  "NotificationHubs"
);
@@clientName(NamespaceResources.checkNotificationHubAvailability,
  "CheckNotificationHubAvailability"
);
@@clientLocation(NamespaceResources.getPnsCredentials, Namespaces);
@@clientName(NamespaceResources.getPnsCredentials, "GetPnsCredentials");
@@clientLocation(NotificationHubResources.get, "NotificationHubs");
@@clientName(NotificationHubResources.get, "Get");
@@clientLocation(NotificationHubResources.createOrUpdate, "NotificationHubs");
@@clientName(NotificationHubResources.createOrUpdate, "CreateOrUpdate");
@@clientLocation(NotificationHubResources.update, "NotificationHubs");
@@clientName(NotificationHubResources.update, "Update");
@@clientLocation(NotificationHubResources.delete, "NotificationHubs");
@@clientName(NotificationHubResources.delete, "Delete");
@@clientLocation(NotificationHubResources.list, "NotificationHubs");
@@clientName(NotificationHubResources.list, "List");
@@clientLocation(NotificationHubResources.debugSend, "NotificationHubs");
@@clientName(NotificationHubResources.debugSend, "DebugSend");
@@clientLocation(NotificationHubResources.getPnsCredentials,
  "NotificationHubs"
);
@@clientName(NotificationHubResources.getPnsCredentials, "GetPnsCredentials");
@@clientLocation(PrivateEndpointConnectionResources.get,
  "PrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnectionResources.get, "Get");
@@clientLocation(PrivateEndpointConnectionResources.update,
  "PrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnectionResources.update, "Update");
@@clientLocation(PrivateEndpointConnectionResources.delete,
  "PrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnectionResources.delete, "Delete");
@@clientLocation(PrivateEndpointConnectionResources.list,
  "PrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnectionResources.list, "List");
@@clientLocation(PrivateLinkResources.getGroupId, "PrivateEndpointConnections");
@@clientName(PrivateLinkResources.getGroupId, "GetGroupId");
@@clientLocation(PrivateLinkResources.listGroupIds,
  "PrivateEndpointConnections"
);
@@clientName(PrivateLinkResources.listGroupIds, "ListGroupIds");
@@clientLocation(NamespacesOperationGroup.checkAvailability, Namespaces);
@@clientName(NamespacesOperationGroup.checkAvailability, "CheckAvailability");
@@clientLocation(SharedAccessAuthorizationRuleResources.getAuthorizationRule,
  "NotificationHubs"
);
@@clientName(SharedAccessAuthorizationRuleResources.getAuthorizationRule,
  "GetAuthorizationRule"
);
@@clientLocation(SharedAccessAuthorizationRuleResources.createOrUpdateAuthorizationRule,
  "NotificationHubs"
);
@@clientName(SharedAccessAuthorizationRuleResources.createOrUpdateAuthorizationRule,
  "CreateOrUpdateAuthorizationRule"
);
@@clientLocation(SharedAccessAuthorizationRuleResources.deleteAuthorizationRule,
  "NotificationHubs"
);
@@clientName(SharedAccessAuthorizationRuleResources.deleteAuthorizationRule,
  "DeleteAuthorizationRule"
);
@@clientLocation(SharedAccessAuthorizationRuleResources.listAuthorizationRules,
  "NotificationHubs"
);
@@clientName(SharedAccessAuthorizationRuleResources.listAuthorizationRules,
  "ListAuthorizationRules"
);
@@clientLocation(SharedAccessAuthorizationRuleResources.listKeys,
  "NotificationHubs"
);
@@clientName(SharedAccessAuthorizationRuleResources.listKeys, "ListKeys");
@@clientLocation(SharedAccessAuthorizationRuleResources.regenerateKeys,
  "NotificationHubs"
);
@@clientName(SharedAccessAuthorizationRuleResources.regenerateKeys,
  "RegenerateKeys"
);
