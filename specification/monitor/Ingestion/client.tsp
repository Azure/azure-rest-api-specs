import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using LogsIngestionClient;

namespace ClientCustomizations;

@@access(upload, Access.internal, "python");
