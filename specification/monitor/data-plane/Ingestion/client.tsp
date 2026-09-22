import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(LogsIngestion.Versions)
namespace ClientCustomizations;

@@clientNamespace(
  LogsIngestion,
  "com.azure.monitor.ingestion.implementation",
  "java"
);

@@clientNamespace(LogsIngestion, "Azure.Monitor.Ingestion", "csharp");

@@clientName(LogsIngestion, "Client", "go");

using LogsIngestion;

@@access(upload, Access.internal, "python");

// Go configuration: remove the optional client request ID parameter.
@@override(upload, removeParameter(upload, "clientRequestId"), "go");
