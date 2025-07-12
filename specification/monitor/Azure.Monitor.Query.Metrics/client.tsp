import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace ClientCustomizations;

@@clientName(MonitorQueryMetrics, "Client", "go");

@@clientName(MonitorQueryMetrics.batch, "queryResources");
