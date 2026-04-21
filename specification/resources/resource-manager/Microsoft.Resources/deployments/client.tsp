import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources;

@@clientName(Microsoft.Resources, "DeploymentsMgmtClient", "python");

// Fix AZC naming violations for C#
@@clientName(DeploymentOperation, "ArmDeploymentOperation", "csharp");
@@clientName(DeploymentExtensionDefinition, "ArmDeploymentExtensionDefinition", "csharp");
@@clientName(DeploymentParameter, "DeploymentParameterValue", "csharp");
