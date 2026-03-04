import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.App;

@@clientName(Microsoft.App, "ContainerAppsAPIClient", "javascript,python");
@@clientLocation(Jobs.jobExecution, Microsoft.App, "python");

@@clientLocation(getCustomDomainVerificationId,"ContainerAppsAPIClient", "go");
@@clientLocation(Jobs.jobExecution,"ContainerAppsAPIClient", "go");
