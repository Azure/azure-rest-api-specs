import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesRuntime;

@@Legacy.flattenProperty(BgpPeer.properties, "autorest");
@@Legacy.flattenProperty(LoadBalancer.properties, "autorest");
@@Legacy.flattenProperty(ServiceResource.properties, "autorest");
@@Legacy.flattenProperty(StorageClassResource.properties, "autorest");
