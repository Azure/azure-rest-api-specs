import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MixedReality;

@@clientName(SpatialAnchorsAccounts.create::parameters.resource,
  "spatialAnchorsAccount"
);
@@clientName(SpatialAnchorsAccounts.update::parameters.properties,
  "spatialAnchorsAccount"
);
@@clientName(SpatialAnchorsAccounts.regenerateKeys::parameters.body,
  "regenerate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SpatialAnchorsAccount.properties);

@@clientName(RemoteRenderingAccounts.create::parameters.resource,
  "remoteRenderingAccount"
);
@@clientName(RemoteRenderingAccounts.update::parameters.properties,
  "remoteRenderingAccount"
);
@@clientName(RemoteRenderingAccounts.regenerateKeys::parameters.body,
  "regenerate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RemoteRenderingAccount.properties);

@@clientName(ObjectAnchorsAccounts.create::parameters.resource,
  "objectAnchorsAccount"
);
@@clientName(ObjectAnchorsAccounts.update::parameters.properties,
  "objectAnchorsAccount"
);
@@clientName(ObjectAnchorsAccounts.regenerateKeys::parameters.body,
  "regenerate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ObjectAnchorsAccount.properties);
