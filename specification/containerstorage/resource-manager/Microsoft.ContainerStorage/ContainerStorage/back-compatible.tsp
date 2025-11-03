// Contains overrides to make the Autorest Swagger2.0 back compatible
using Microsoft.ContainerStorage;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Pool.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Snapshot.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Volume.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
