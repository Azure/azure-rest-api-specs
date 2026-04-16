import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.ApiCenter;

// Preserve legacy Java header property names for compatibility
@@clientName(Azure.Core.EtagResponseEnvelope.etagHeader, "etag", "java");

// Rename mapping for C# client
@@clientName(ApiSources, "ApiCenterApiSource", "csharp");
@@clientName(ApiSourceLinkState, "ApiCenterApiSourceLinkState", "csharp");
@@clientName(AzureApiManagementSource,
  "ApiCenterApiManagementSource",
  "csharp"
);
@@clientName(ImportSpecificationOptions,
  "ApiCenterImportSpecificationModel",
  "csharp"
);
@@clientName(Contact, "ApiContactInformation", "csharp");
@@clientName(DeletedService, "ApiCenterDeletedService", "csharp");
@@clientName(DeletedServiceProperties,
  "ApiCenterDeletedServiceProperties",
  "csharp"
);
@@clientName(License, "ApiLicenseInformation", "csharp");
@@clientName(Onboarding, "EnvironmentOnboardingInformation", "csharp");
@@clientName(ApiDefinitionPropertiesSpecification,
  "ApiSpecificationDetails",
  "csharp"
);
@@clientName(ExternalDocumentation, "ApiExternalDocumentation", "csharp");
@@clientName(LifecycleStage, "ApiLifecycleStage", "csharp");
@@clientName(ApiVersions.head, "HeadApiVersion", "csharp");
@@clientName(Deployments.head, "HeadDeployment", "csharp");
@@clientName(MetadataSchemas.head, "HeadMetadataSchema", "csharp");
@@clientName(Workspaces.head, "HeadWorkspace", "csharp");
@@clientName(Apis.head, "HeadApi", "csharp");
@@clientName(ApiSources.head, "HeadApiSource", "csharp");
@@clientName(Environments.head, "HeadEnvironment", "csharp");
@@clientName(ApiSpecImportRequest, "ApiSpecImportContent", "csharp");
@@clientName(MetadataSchemaExportRequest,
  "MetadataSchemaExportContent",
  "csharp"
);
@@clientName(Api, "ApiCenterApi", "csharp");
@@clientName(ApiDefinition, "ApiCenterApiDefinition", "csharp");
@@clientName(ApiVersion, "ApiCenterApiVersion", "csharp");
@@clientName(Deployment, "ApiCenterDeployment", "csharp");
@@clientName(Environment, "ApiCenterEnvironment", "csharp");
@@clientName(MetadataSchema, "ApiCenterMetadataSchema", "csharp");
@@clientName(Service, "ApiCenterService", "csharp");
@@clientName(Workspace, "ApiCenterWorkspace", "csharp");
@@clientName(ApiProperties, "ApiCenterApiProperties", "csharp");
@@clientName(ApiDefinitionProperties,
  "ApiCenterApiDefinitionProperties",
  "csharp"
);
@@clientName(ApiVersionProperties, "ApiCenterApiVersionProperties", "csharp");
@@clientName(DeploymentProperties, "ApiCenterDeploymentProperties", "csharp");
@@clientName(DeploymentState, "ApiCenterDeploymentState", "csharp");
@@clientName(EnvironmentKind, "ApiCenterEnvironmentKind", "csharp");
@@clientName(EnvironmentProperties, "ApiCenterEnvironmentProperties", "csharp");
@@clientName(EnvironmentServer, "ApiCenterEnvironmentServer", "csharp");
@@clientName(MetadataAssignment, "ApiCenterMetadataAssignment", "csharp");
@@clientName(MetadataSchemaProperties,
  "ApiCenterMetadataSchemaProperties",
  "csharp"
);
@@clientName(ProvisioningState, "ApiCenterProvisioningState", "csharp");
@@clientName(WorkspaceProperties, "ApiCenterWorkspaceProperties", "csharp");
@@clientName(ServiceProperties, "ApiCenterServiceProperties", "csharp");
@@clientName(ServiceProperties.restore, "IsRestore", "csharp");
@@clientName(DeploymentServer, "ApiCenterDeploymentServer", "csharp");
@@clientName(LinkState, "ApiCenterLinkState", "csharp");
@@clientName(EnvironmentServer.type, "EnvironmentServerType", "csharp");
@@clientName(EnvironmentServerType.`Azure API Management`,
  "AzureApiManagement",
  "csharp"
);
@@clientName(EnvironmentServerType.`Apigee API Management`,
  "ApigeeApiManagement",
  "csharp"
);
@@clientName(EnvironmentServerType.`AWS API Gateway`,
  "AwsApiGateway",
  "csharp"
);
@@clientName(EnvironmentServerType.`Kong API Gateway`,
  "KongApiGateway",
  "csharp"
);
@@clientName(EnvironmentServerType.`MuleSoft API Management`,
  "MuleSoftApiManagement",
  "csharp"
);
@@clientName(ApiDefinitions.importSpecification,
  "ImportSpecification",
  "csharp"
);
@@alternateType(ApiProperties.customProperties, unknown, "csharp");
@@alternateType(DeploymentProperties.customProperties, unknown, "csharp");
@@alternateType(EnvironmentProperties.customProperties, unknown, "csharp");
@@alternateType(DeploymentProperties.environmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DeploymentProperties.definitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
