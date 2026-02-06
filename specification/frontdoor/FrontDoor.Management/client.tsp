import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(Microsoft.Network, "FrontDoorManagementClient", "python");
@@clientName(MinimumTLSVersion.`1.0`, "ONE0", "python");
@@clientName(MinimumTLSVersion.`1.2`, "ONE2", "python");

@@clientName(MinimumTLSVersion, "MinimumTlsVersion", "java");
@@clientName(ValidateCustomDomainInput.hostName, "hostname", "java");
@@clientName(FrontendEndpointUpdateParameters.hostName, "hostname", "java");
@@clientName(FrontendEndpointProperties.hostName, "hostname", "java");
@@clientName(LatencyMetric.endDateTimeUTC, "endDateTimeUtc", "java");
@@clientName(LatencyScorecardProperties.startDateTimeUTC,
  "startDateTimeUtc",
  "java"
);
@@clientName(LatencyScorecardProperties.endDateTimeUTC,
  "endDateTimeUtc",
  "java"
);
@@clientName(TimeseriesProperties.startDateTimeUTC, "startDateTimeUtc", "java");
@@clientName(TimeseriesProperties.endDateTimeUTC, "endDateTimeUtc", "java");
@@clientName(TimeseriesDataPoint.dateTimeUTC, "dateTimeUtc", "java");
@@clientName(GetLatencyScorecardsParameters.endDateTimeUTC,
  "endDateTimeUtc",
  "java"
);
@@clientName(GetTimeseriesParameters.startDateTimeUTC,
  "startDateTimeUtc",
  "java"
);
@@clientName(GetTimeseriesParameters.endDateTimeUTC, "endDateTimeUtc", "java");
