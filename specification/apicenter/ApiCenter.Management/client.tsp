import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.ApiCenter;

// Preserve legacy Java header property names for compatibility
@@clientName(Azure.Core.EtagResponseEnvelope.etagHeader, "etag", "java");

// Rename mapping for C# client
@@clientName(Contact, "ApiContactInformation", "csharp");
@@clientName(License, "ApiLicenseInformation", "csharp");
@@clientName(Onboarding, "EnvironmentOnboardingInformation", "csharp");
@@clientName(ApiDefinitionPropertiesSpecification,
  "ApiSpecificationDetails",
  "csharp"
);
@@clientName(ExternalDocumentation, "ApiExternalDocumentation", "csharp");
@@clientName(LifecycleStage, "ApiLifecycleStage", "csharp");
@@alternateType(DeploymentProperties.environmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DeploymentProperties.definitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
