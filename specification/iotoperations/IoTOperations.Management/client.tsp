import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.IoTOperations;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@@clientName(Microsoft.IoTOperations, "IoTOperationsMgmt", "python");
@@clientName(Microsoft.IoTOperations, "IoTOperationsManagementClient", "java");

// CSharp Client configuration
@@clientName(CertManagerCertOptions, "CertManagerCertConfig", "csharp");
@@clientName(DataflowOperation, "DataflowAction", "csharp");
@@clientName(PrincipalDefinition, "PrincipalConfig", "csharp");
