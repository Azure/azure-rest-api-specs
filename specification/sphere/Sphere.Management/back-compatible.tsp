import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Microsoft.AzureSphere;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Catalog.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Certificate.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Deployment.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Device.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeviceGroup.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Image.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Product.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
