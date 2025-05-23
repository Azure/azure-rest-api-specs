import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.PortalServices;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PatchablePortalExtension.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PatchableExtensionVersion.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PatchableExtensionSlot.properties);
