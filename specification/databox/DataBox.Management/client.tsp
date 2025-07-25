import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DataBox;

@@clientName(JobDetails, "CommonJobDetails", "go");
@@clientName(JobSecrets, "CommonJobSecrets", "go");
@@clientName(ScheduleAvailabilityRequest,
  "CommonScheduleAvailabilityRequest",
  "go"
);
@@clientName(Microsoft.DataBox, "DataBoxManagementClient", "javascript");
