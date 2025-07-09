import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using LogsIngestion;

namespace ClientCustomizations;

@@access(upload, Access.internal, "python");

@@clientName(LogsIngestion, "Client", "go");
