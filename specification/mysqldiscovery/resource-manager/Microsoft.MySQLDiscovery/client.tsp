import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MySQLDiscovery;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MySQLSitesResourcePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MySQLServerResourcePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgentResourcePatch.properties);

@@clientName(MySQLSites.createOrUpdate::parameters.resource, "body");
@@clientName(MySQLSites.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MySQLSite.properties);

@@clientName(MySQLServers.createOrUpdate::parameters.resource, "body");
@@clientName(MySQLServers.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MySQLServer.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Summary.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ErrorSummary.properties);

@@clientName(Agents.createOrUpdate::parameters.resource, "body");
@@clientName(Agents.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Agent.properties);
