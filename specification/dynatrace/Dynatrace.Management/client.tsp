import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Dynatrace.Observability;

@@clientName(EnvironmentInfo.landingURL, "landingUrl", "java");
