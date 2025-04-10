import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StoragePool;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskPoolCreate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskPoolUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IscsiTargetCreate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IscsiTargetUpdate.properties);

@@clientName(DiskPools.createOrUpdate::parameters.resource,
  "diskPoolCreatePayload"
);
@@clientName(DiskPools.update::parameters.properties, "diskPoolUpdatePayload");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskPools.sku);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskPool.properties);

@@clientName(IscsiTargets.createOrUpdate::parameters.resource,
  "iscsiTargetCreatePayload"
);
@@clientName(IscsiTargets.update::parameters.properties,
  "iscsiTargetUpdatePayload"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IscsiTarget.properties);
