import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Genome;

// Operation names
@@clientName(getConfigurations, "getConfigurations");
@@clientName(createOrReplaceConfiguration, "createConfiguration");
@@clientName(getConfigurationByKey, "getConfigurationByKey");
@@clientName(replaceConfiguration, "updateConfiguration");
@@clientName(deleteConfiguration, "deleteConfiguration");
@@clientName(getConfigurationValue, "getConfigurationValue");

// Model renames for .NET SDK naming conventions (AZC0030, AZC0012, AZC0034)
@@clientName(ConfigurationListResponse, "ConfigurationList", "csharp");
@@clientName(ConfigurationResponse, "GenomeConfiguration", "csharp");
@@clientName(ConfigurationRequest, "ConfigurationContent", "csharp");
@@clientName(ErrorResponse, "GenomeError", "csharp");
