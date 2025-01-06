import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.IoTOperations, "IoTOperationsMgmt", "python");
@@clientName(Microsoft.IoTOperations, "IoTOperationsManagementClient", "java");

namespace Microsoft.IoTOperations {
    @@access(Operations.list, Access.internal);

    @@clientName(CertManagerCertOptions, "CertManagerCertConfig", "csharp");
    // @@usage(ServerlessRuntimeNetworkProfileUpdate, Usage.output);
}
