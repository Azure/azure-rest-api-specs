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
