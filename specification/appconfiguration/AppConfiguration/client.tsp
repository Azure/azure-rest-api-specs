import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

namespace SdkCustomizations;

@@clientName(Error, "AppConfigError", "python");
@@access(putKeyValue, Access.internal, "python");
@@access(updateSnapshot, Access.internal, "python");
