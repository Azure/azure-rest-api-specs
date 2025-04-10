import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterCodeVersionsResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationResourceUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceResourceUpdate.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

@@clientName(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationTypeResource.properties);

@@clientName(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationTypeVersionResource.properties);

@@clientName(ApplicationResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationResources.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationResource.properties);

@@clientName(ServiceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ServiceResources.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceResource.properties);
