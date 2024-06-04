import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.DeviceRegistry;

@@clientName(Asset, "DeviceRegistryAsset", "csharp");
@@clientName(AssetEndpointProfile, "DeviceRegistryAssetEndpointProfile", "csharp");
@@clientName(ExtendedLocation, "DeviceRegistryExtendedLocation", "csharp");
@@clientName(Event, "AssetEvent", "csharp");
@@clientName(ProvisioningState, "DeviceRegistryProvisioningState", "csharp");
@@clientName(ExtendedLocation.type, "ExtendedLocationType", "csharp");