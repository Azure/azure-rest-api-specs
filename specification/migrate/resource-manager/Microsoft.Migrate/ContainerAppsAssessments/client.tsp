import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Migrate;

@@clientName(Linkages.armId, "ARMID", "go");

@@clientName(
  Microsoft.Migrate,
  "MigrateContainerAppsAssessmentsMgmtClient",
  "python"
);

@@clientName(DownloadUrl.assessmentReportUrl, "assessmentReportUri", "csharp");
@@clientName(
  ContainerAppsAssessmentOptions,
  "ContainerAppsAssessmentConfig",
  "csharp"
);

@@clientName(
  ContainerAppsOptionsOperations,
  "ContainerAppsOptionsOperations",
  "autorest"
);
@@clientName(
  ContainerAppsAssessmentOperations,
  "ContainerAppsAssessmentOperations",
  "autorest"
);
@@clientName(
  ContainerAppsManagedEnvironmentOperations,
  "ContainerAppsManagedEnvironmentOperations",
  "autorest"
);
@@clientName(
  ContainerAppsCostDetailOperations,
  "ContainerAppsCostDetailOperations",
  "autorest"
);
@@clientName(
  ContainerAppsSummaryOperations,
  "ContainerAppsSummaryOperations",
  "autorest"
);

@@clientName(
  Microsoft.Migrate,
  "MigrateContainerAppsAssessmentsManagementClient",
  "javascript"
);
