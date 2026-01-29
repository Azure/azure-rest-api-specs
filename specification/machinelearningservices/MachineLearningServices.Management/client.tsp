import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MachineLearningServices;

@@apiVersion(ProxyApiVersion.`proxy-api-version`,
  false,
  "python,javascript,go"
);

// Java casing fixes for SAS-related types and operations
@@clientName(GetBlobReferenceSASRequestDto,
  "GetBlobReferenceSasRequestDto",
  "java"
);
@@clientName(GetBlobReferenceSASResponseDto,
  "GetBlobReferenceSasResponseDto",
  "java"
);
@@clientName(SASCredential, "SasCredential", "java");
@@clientName(SASCredentialDto, "SasCredentialDto", "java");
@@clientName(SASAuthTypeWorkspaceConnectionProperties,
  "SasAuthTypeWorkspaceConnectionProperties",
  "java"
);
@@clientName(Registries.getBlobReferenceSAS, "getBlobReferenceSas", "java");
@@clientName(NotebookAccessTokenResult.hostName, "hostname", "java");
@@clientName(UserAccountCredentials.adminUserName, "adminUsername", "java");
@@clientName(ComputeInstanceSshSettings.adminUserName, "adminUsername", "java");

// Java casing fixes for FQDN-related types
@@clientName(ExternalFQDNResponse, "ExternalFqdnResponse", "java");
@@clientName(FqdnEndpointsPropertyBag, "FqdnEndpointsPropertyBag", "java");
@@clientName(FqdnEndpoints, "FqdnEndpoints", "java");
@@clientName(FqdnEndpoint, "FqdnEndpoint", "java");
@@clientName(FqdnEndpointDetail, "FqdnEndpointDetail", "java");

// Java casing fixes for AAD-related types
@@clientName(AADAuthTypeWorkspaceConnectionProperties,
  "AadAuthTypeWorkspaceConnectionProperties",
  "java"
);

// Java casing fixes for CMK-related members
@@clientName(WorkspaceProperties.enableServiceSideCMKEncryption,
  "enableServiceSideCmkEncryption",
  "java"
);

// Java casing fixes for AKS-related types
@@clientName(AksNetworkingConfiguration, "AKSNetworkingConfiguration", "java");
@@clientName(AksComputeSecrets, "AKSComputeSecrets", "java");
@@clientName(AksComputeSecretsProperties,
  "AKSComputeSecretsProperties",
  "java"
);

@@clientName(PublicNetworkAccessType, "PublicNetworkAccess", "java");
@@clientName(EndpointServiceConnectionStatus,
  "PrivateEndpointServiceConnectionStatus",
  "java"
);
@@clientName(ListWorkspaceKeysResult.userStorageArmId,
  "userStorageResourceId",
  "java"
);
@@clientName(ServerlessComputeSettings.serverlessComputeNoPublicIP,
  "serverlessComputeNoPublicIp",
  "java"
);
@@alternateType(PipelineJob.settings, unknown, "java");
@@alternateType(SweepJob.searchSpace, unknown, "java");
@@alternateType(EndpointScheduleAction.endpointInvocationDefinition,
  unknown,
  "java"
);

@@clientName(Microsoft.MachineLearningServices,
  "MachineLearningServicesMgmtClient",
  "python"
);
@@clientName(ComputeInstanceAuthorizationType,
  "ComputeInstancePropertiesComputeInstanceAuthorizationType",
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(DatastoresCreateOrUpdateParameters.skipValidation,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(DatastoresListParameters.count, 30, "python");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(DatastoresListParameters.orderByAsc,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(EndpointResourceListParameters.includeOnlineEndpoints,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(EndpointResourceListParameters.includeServerlessEndpoints,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(EndpointResourceListParameters.includeConnections,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(FeaturesListParameters.pageSize, 1000, "python");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(FeaturesetContainersListParameters.pageSize,
  20,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(FeaturesetVersionsListParameters.pageSize,
  20,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(FeaturestoreEntityContainersListParameters.pageSize,
  20,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(FeaturestoreEntityVersionsListParameters.pageSize,
  20,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(WorkspaceConnectionListParameters.includeAll,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(WorkspacesDeleteParameters.forceToPurge,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(SchedulesListParameters.listViewType,
  "EnabledOnly",
  "python"
);

@@clientName(Microsoft.MachineLearningServices,
  "AzureMachineLearningServicesManagementClient",
  "javascript"
);
