import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Advisor, "AdvisorManagementClient", "javascript");
@@clientName(Microsoft.Advisor.CpuThreshold.`5`, "Five", "javascript");
@@clientName(Microsoft.Advisor.CpuThreshold.`10`, "Ten", "javascript");
@@clientName(Microsoft.Advisor.CpuThreshold.`15`, "Fifteen", "javascript");
@@clientName(Microsoft.Advisor.CpuThreshold.`20`, "Twenty", "javascript");

// Go client customizations to resolve breaking changes
@@clientName(Microsoft.Advisor.CpuThreshold.`5`, "Five", "go");
@@clientName(Microsoft.Advisor.CpuThreshold.`10`, "Ten", "go");
@@clientName(Microsoft.Advisor.CpuThreshold.`15`, "Fifteen", "go");
@@clientName(Microsoft.Advisor.CpuThreshold.`20`, "Twenty", "go");
