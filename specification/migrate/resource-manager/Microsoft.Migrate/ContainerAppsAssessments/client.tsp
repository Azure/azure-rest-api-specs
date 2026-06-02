import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Migrate;

@@clientName(ContainerAppsOptionsOperations,
  "ContainerAppsOptionsOperations",
  "autorest"
);
@@clientName(ContainerAppsAssessmentOperations,
  "ContainerAppsAssessmentOperations",
  "autorest"
);
@@clientName(ContainerAppsManagedEnvironmentOperations,
  "ContainerAppsManagedEnvironmentOperations",
  "autorest"
);
@@clientName(ContainerAppsCostDetailOperations,
  "ContainerAppsCostDetailOperations",
  "autorest"
);
@@clientName(ContainerAppsSummaryOperations,
  "ContainerAppsSummaryOperations",
  "autorest"
);
