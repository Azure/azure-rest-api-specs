import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using Microsoft.Authorization;

@@clientName(Alerts.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Alert.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AlertDefinition.properties);

@@clientName(AlertConfigurations.update::parameters.properties, "parameters");

@@clientLocation(AlertsOperationGroup.refreshAll, Alerts);

@@clientLocation(AlertOperationOperationGroup.get, "AlertOperation");

// Fix x-ms-skip-url-encoding for resource path parameters
@@path(Alert.name, #{ allowReserved: true });
@@path(AlertConfiguration.name, #{ allowReserved: true });
@@path(AlertDefinition.name, #{ allowReserved: true });
@@path(AlertIncident.name, #{ allowReserved: true });
