import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientNamespace(Informatica.DataManagement,
  "com.azure.resourcemanager.informaticadatamanagement",
  "java"
);

@@clientName(Informatica.DataManagement, "InformaticaDataMgmt", "python");
@@clientName(Informatica.DataManagement,
  "InformaticaDataManagementClient",
  "java"
);

namespace Informatica.DataManagement {
  @@access(Operations.list, Access.internal);

  @@clientName(InformaticaOrganizationResource,
    "InformaticaOrganization",
    "csharp"
  );
  @@clientName(OrganizationProperties,
    "InformaticaOrganizationProperties",
    "csharp"
  );
  @@clientName(InformaticaServerlessRuntimeResource,
    "InformaticaServerlessRuntime",
    "csharp"
  );
  @@clientName(ApplicationConfigs, "InformaticaApplicationConfigs", "csharp");
  @@clientName(ApplicationType, "InformaticaApplicationType", "csharp");
  @@clientName(ApplicationTypeMetadata,
    "InformaticaApplicationTypeMetadata",
    "csharp"
  );
  @@clientName(CdiConfigProps, "CdiConfigProperties", "csharp");
  @@clientName(CheckDependenciesResponse, "CheckDependenciesResult", "csharp");
  @@clientName(CompanyDetails, "InformaticaCompanyDetails", "csharp");
  @@clientName(CompanyDetailsUpdate,
    "InformaticaCompanyDetailsUpdate",
    "csharp"
  );
  @@clientName(InfaRuntimeResourceFetchMetaData,
    "InformaticaRuntimeResourceFetchMetadata",
    "csharp"
  );
  @@clientName(InfaServerlessFetchConfigProperties,
    "InformaticaServerlessFetchConfigProperties",
    "csharp"
  );
  @@clientName(MarketplaceDetails, "InformaticaMarketplaceDetails", "csharp");
  @@clientName(MarketplaceDetailsUpdate,
    "InformaticaMarketplaceDetailsUpdate",
    "csharp"
  );
  @@clientName(NetworkInterfaceConfiguration,
    "InformaticaNetworkInterfaceConfiguration",
    "csharp"
  );
  @@clientName(NetworkInterfaceConfigurationUpdate,
    "InformaticaNetworkInterfaceConfigurationUpdate",
    "csharp"
  );
  @@clientName(OfferDetails, "InformaticaOfferDetails", "csharp");
  @@clientName(OfferDetailsUpdate, "InformaticaOfferDetailsUpdate", "csharp");
  @@clientName(OrganizationPropertiesCustomUpdate,
    "InformaticaOrganizationPropertiesUpdate",
    "csharp"
  );
  @@clientName(PlatformType, "InformaticaPlatformType", "csharp");
  @@clientName(ProvisioningState, "InformaticaProvisioningState", "csharp");
  @@clientName(RegionsMetadata, "InformaticaRegionsMetadata", "csharp");
  @@clientName(RuntimeType, "InformaticaRuntimeType", "csharp");
  @@clientName(ServerlessRuntimePropertiesCustomUpdate,
    "ServerlessRuntimePropertiesUpdate",
    "csharp"
  );
  @@clientName(UserDetails, "InformaticaUserDetails", "csharp");
  @@clientName(UserDetailsUpdate, "InformaticaUserDetailsUpdate", "csharp");

  @@clientName(ApplicationConfigs.type, "ApplicationConfigsType", "csharp");
  @@clientName(ApplicationType.CDI, "Cdi", "csharp");
  @@clientName(ApplicationType.CDIE, "Cdie", "csharp");
  @@clientName(InfaRuntimeResourceFetchMetaData.type, "RuntimeType", "csharp");
  @@clientName(InformaticaProperties.singleSignOnUrl,
    "SingleSignOnUri",
    "csharp"
  );
  @@clientName(PlatformType.AZURE, "Azure", "csharp");
  @@clientName(RuntimeType.SERVERLESS, "Serverless", "csharp");
  @@clientName(ServerlessMetadataResponse.type, "RuntimeType", "csharp");

  @@clientName(ServerlessRuntimes.serverlessResourceById,
    "GetServerlessResourceById",
    "csharp"
  );

  @@usage(ServerlessRuntimeNetworkProfileUpdate, Usage.output);
}
