import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Workloads;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationsDefinition.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationsContent.properties);

@@clientName(SAPVirtualInstances.create::parameters.resource, "body");
@@clientName(SAPVirtualInstances.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SAPVirtualInstance.properties);

@@clientName(SAPCentralServerInstances.create::parameters.resource, "body");
@@clientName(SAPCentralServerInstances.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SAPCentralServerInstance.properties);

@@clientName(SAPDatabaseInstances.create::parameters.resource, "body");
@@clientName(SAPDatabaseInstances.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SAPDatabaseInstance.properties);

@@clientName(SAPApplicationServerInstances.create::parameters.resource, "body");
@@clientName(SAPApplicationServerInstances.update::parameters.properties,
  "body"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SAPApplicationServerInstance.properties);

@@clientName(Monitors.create::parameters.resource, "MonitorParameter");
@@clientName(Monitors.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Monitor.properties);

@@clientName(ProviderInstances.create::parameters.resource,
  "providerInstanceParameter"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProviderInstance.properties);

@@clientName(SapLandscapeMonitors.create::parameters.resource,
  "sapLandscapeMonitorParameter"
);
@@clientName(SapLandscapeMonitors.update::parameters.properties,
  "sapLandscapeMonitorParameter"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SapLandscapeMonitor.properties);
