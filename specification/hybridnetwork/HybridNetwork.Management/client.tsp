import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.HybridNetwork;

@@clientName(HelmInstallOptions.wait, "waitOption", "java");
@@clientName(HelmUpgradeOptions.wait, "waitOption", "java");
