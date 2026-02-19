import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ComputeSchedule;

@@clientName(CancelOccurrenceRequest, "CancelOccurrenceContent", "csharp");
@@clientName(DelayRequest, "DelayContent", "csharp");

// Resolve case-only property name collisions for C# (PascalCase causes duplicates)
@@clientName(Schedule.deadLine, "DeadLineLegacy", "csharp");
@@clientName(Schedule.timeZone, "TimeZoneLegacy", "csharp");
@@clientName(ResourceOperationDetails.timeZone, "TimeZoneLegacy", "csharp");
@@clientName(OperationErrorDetails.timeStamp, "TimeStampLegacy", "csharp");
