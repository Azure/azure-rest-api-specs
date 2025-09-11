import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ComputeSchedule;

@@clientName(CancelOccurrenceRequest, "CancelOccurrenceContent", "csharp");
@@clientName(DelayRequest, "DelayContent", "csharp");
