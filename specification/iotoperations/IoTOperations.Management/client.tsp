import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.IoTOperations, "IoTOperationsMgmt", "python");
@@clientName(Microsoft.IoTOperations, "IoTOperationsManagementClient", "java");

#suppress "@azure-tools/typespec-azure-core/casing-style"
namespace Microsoft.IoTOperations {
  @@access(Operations.list, Access.internal);

  @@clientName(CertManagerCertOptions, "CertManagerCertConfig", "csharp");
  @@clientName(DataflowOperation, "DataflowConfig", "csharp");
  @@clientName(PrincipalDefinition, "PrincipalConfig", "csharp");
}
