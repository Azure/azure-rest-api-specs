import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Portal;

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PatchableDashboard.properties
);
