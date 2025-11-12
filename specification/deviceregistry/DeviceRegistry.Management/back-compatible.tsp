import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

using Microsoft.DeviceRegistry;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AssetEndpointProfile.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Asset.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(BillingContainer.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Credential.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiscoveredAssetEndpointProfile.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiscoveredAsset.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NamespaceAsset.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NamespaceDevice.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NamespaceDiscoveredAsset.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NamespaceDiscoveredDevice.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Namespace.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Policy.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Schema.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SchemaRegistry.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SchemaVersion.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
