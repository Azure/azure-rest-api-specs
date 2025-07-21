import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Advisor, "AdvisorManagementClient", "javascript");
@@clientName(Microsoft.Advisor.CpuThreshold.`5`, "Five", "javascript,go");
@@clientName(Microsoft.Advisor.CpuThreshold.`10`, "Ten", "javascript,go");
@@clientName(Microsoft.Advisor.CpuThreshold.`15`, "Fifteen", "javascript,go");
@@clientName(Microsoft.Advisor.CpuThreshold.`20`, "Twenty", "javascript,go");
