import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.App;

@@clientName(Microsoft.App, "ContainerAppsAPIClient", "javascript,python");
@@clientLocation(Jobs.jobExecution, Microsoft.App, "python");

@@clientLocation(getCustomDomainVerificationId, "ContainerAppsAPIClient", "go");
@@clientLocation(Jobs.jobExecution, "ContainerAppsAPIClient", "go");

@@clientName(VnetConfiguration.platformReservedDnsIP,
  "platformReservedDnsIp",
  "java"
);
@@clientName(RegistryInfo.registryUserName, "registryUsername", "java");
@@clientName(CustomHostnameAnalysisResult.hostName, "hostname", "java");
@@clientName(AzureActiveDirectoryLogin.disableWWWAuthenticate,
  "disableWwwAuthenticate",
  "java"
);
@@clientName(ContainerApps.listCustomHostNameAnalysis,
  "listCustomHostnameAnalysis",
  "java"
);

@@clientLocation(Jobs.jobExecution, Microsoft.App, "java,javascript");
@@clientName(RuntimeJavaJavaAgent, "RuntimeJavaAgent", "go,python");
@@clientName(RuntimeJavaJavaAgentLogging,
  "RuntimeJavaAgentLogging",
  "go,python"
);
@@clientName(AvailableWorkloadProfilesOperationGroup.get, "list", "javascript");
