import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Microsoft.AzureSphere;

<<<<<<< HEAD
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
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Catalog.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Certificate.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Deployment.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Device.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeviceGroup.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Image.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Product.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
