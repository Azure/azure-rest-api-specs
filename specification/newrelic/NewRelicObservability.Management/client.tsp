import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(NewRelic.Observability,
  "NewRelicObservabilityMgmtClient",
  "python"
);

@@clientName(NewRelic.NewRelicAccountProperties,
  "AccountPropertiesForNewRelic",
  "go"
);
