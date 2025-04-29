import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Help;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SolutionMetadataResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SolutionPatchRequestBody.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SolutionNlpMetadataResource.properties);

@@clientName(DiagnosticResources.create::parameters.resource,
  "diagnosticResourceRequest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticResource.properties);

@@clientName(SolutionResources.create::parameters.resource,
  "solutionRequestBody"
);
@@clientName(SolutionResources.update::parameters.properties,
  "solutionPatchRequestBody"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SolutionResource.properties);

@@clientName(SimplifiedSolutionsResources.create::parameters.resource,
  "simplifiedSolutionsRequestBody"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SimplifiedSolutionsResource.properties);

@@clientName(TroubleshooterResources.create::parameters.resource,
  "createTroubleshooterRequestBody"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TroubleshooterResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SolutionResourceSelfHelp.properties);

@@clientName(DiagnosticResources.create::parameters.resource,
  "diagnosticResourceRequest"
);

@@clientName(SimplifiedSolutionsResources.create::parameters.resource,
  "simplifiedSolutionsRequestBody"
);

@@clientName(SolutionResources.create::parameters.resource,
  "solutionRequestBody"
);

@@clientName(SolutionResources.update::parameters.properties,
  "solutionPatchRequestBody"
);
@@clientName(TroubleshooterResources.create::parameters.resource,
  "createTroubleshooterRequestBody"
);
@@clientName(DiscoverySolutionNLPOperationGroup.discoverSolutions::parameters.body,
  "discoverSolutionRequest"
);
