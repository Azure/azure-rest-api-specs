import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Informatica.DataManagement, "InformaticaDataMgmt", "python");

namespace Informatica.DataManagement {
    @@access(Operations.list, Access.internal);

    @@clientName(ApplicationConfigs.type, "ApplicationConfigsType", "csharp");
    @@clientName(ApplicationType.CDI, "Cdi", "csharp");
    @@clientName(ApplicationType.CDIE, "Cdie", "csharp");
    @@clientName(InfaRuntimeResourceFetchMetaData.type, "RuntimeType", "csharp");
    @@clientName(InformaticaProperties.singleSignOnUrl, "SingleSignOnUri", "csharp");
    @@clientName(PlatformType.AZURE, "Azure", "csharp");
    @@clientName(RuntimeType.SERVERLESS, "Serverless", "csharp");
    @@clientName(ServerlessMetadataResponse.type, "RuntimeType", "csharp");

    @@usage(ServerlessRuntimeNetworkProfileUpdate, Usage.output);
}

