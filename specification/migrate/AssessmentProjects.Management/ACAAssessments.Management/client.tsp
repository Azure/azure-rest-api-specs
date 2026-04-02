import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Migrate;

@@clientName(ACAOptionsOperations, "AcaOptionsOperations", "autorest");
@@clientName(ACAAssessmentOperations, "AcaAssessmentOperations", "autorest");
@@clientName(ACAManagedEnvironmentOperations,
  "AcaManagedEnvironmentOperations",
  "autorest"
);
@@clientName(ACACostDetailOperations, "AcaCostDetailOperations", "autorest");
@@clientName(ACASummaryOperations, "AcaSummaryOperations", "autorest");
