import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureMonitorExporter;

@@clientName(Base, "MonitorBase");
@@clientName(Domain, "EventDomain");
@@clientName(EventData, "TelemetryEventData");
@@clientName(DataPoint, "MetricDataPoint");
@@clientName(ExceptionData, "TelemetryExceptionData");
@@clientName(ExceptionDetails, "TelemetryExceptionDetails");
@@clientName(ErrorDetails, "TelemetryErrorDetails");
@@clientName(TelemetryEnvelope, "TelemetryItem");

@@clientName(TelemetryEnvelope.ver, "version");
@@clientName(TelemetryEnvelope.seq, "sequence");
@@clientName(TelemetryEnvelope.iKey, "instrumentationKey");

@@clientName(Domain.ver, "version");

@@clientName(DataPoint.ns, "namespace");
@@clientName(DataPoint.kind, "dataPointType");
