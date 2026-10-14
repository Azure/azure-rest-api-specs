import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesRuntime;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(BgpPeer.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(LoadBalancer.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(ServiceResource.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(StorageClassResource.properties, "autorest");
