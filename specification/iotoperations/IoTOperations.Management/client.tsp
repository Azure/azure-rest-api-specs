import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.IoTOperations, "IoTOperationsMgmt", "python");
@@clientName(Microsoft.IoTOperations, "IoTOperationsManagementClient", "java");

#suppress "@azure-tools/typespec-azure-core/casing-style"
namespace Microsoft.IoTOperations {
  @@clientName(CertManagerCertOptions, "CertManagerCertConfig", "csharp");
  @@clientName(DataflowOperation, "DataflowAction", "csharp");
  @@clientName(PrincipalDefinition, "PrincipalConfig", "csharp");
}
