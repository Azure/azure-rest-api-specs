import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureMonitorExporter;

@@clientName(AzureMonitorExporter, "ApplicationInsightsClient", "!autorest");
@@clientName(AzureMonitorExporter, "ApplicationInsightsRestClient", "csharp");
@@clientName(AzureMonitorExporter, "AzureMonitorClient", "python");

@@clientName(Base, "MonitorBase", "!autorest");
@@clientName(Domain, "MonitorDomain", "!autorest");
@@clientName(DomainKind, "MonitorDomainKind", "!autorest");
@@clientName(EventData, "TelemetryEventData", "!autorest");
@@clientName(DataPoint, "MetricDataPoint", "!autorest");
@@clientName(ExceptionData, "TelemetryExceptionData", "!autorest");
@@clientName(ExceptionDetails, "TelemetryExceptionDetails", "!autorest");
@@clientName(ErrorDetails, "TelemetryErrorDetails", "!autorest");
@@clientName(TelemetryEnvelope, "TelemetryItem", "!autorest");

@@clientName(TelemetryEnvelope.ver, "version", "!autorest");
@@clientName(TelemetryEnvelope.seq, "sequence", "!autorest");
@@clientName(TelemetryEnvelope.iKey, "instrumentationKey", "!autorest");

@@clientName(Domain.ver, "version", "!autorest");

@@clientName(DataPoint.ns, "namespace", "!autorest");
@@clientName(DataPoint.kind, "dataPointType", "!autorest");

// Some models not used in an operation should still be made public.

@@usage(MessageData, Usage.output | Usage.json);
@@access(MessageData, Access.public, "python,javascript,java");

@@usage(MetricsData, Usage.output | Usage.json);
@@access(MetricsData, Access.public, "python,javascript,java");

@@usage(Domain, Usage.output | Usage.json);
@@access(Domain, Access.public, "python,javascript,java");

@@usage(DomainKind, Usage.output | Usage.json);
@@access(DomainKind, Access.public, "python,javascript,java");

@@usage(RemoteDependencyData, Usage.output | Usage.json);
@@access(RemoteDependencyData, Access.public, "python,javascript,java");

@@usage(RequestData, Usage.output | Usage.json);
@@access(RequestData, Access.public, "python,javascript,java");

@@usage(EventData, Usage.output | Usage.json);
@@access(EventData, Access.public, "python,javascript,java");

@@usage(ExceptionData, Usage.output | Usage.json);
@@access(ExceptionData, Access.public, "python,javascript,java");

@@usage(PageViewData, Usage.output | Usage.json);
@@access(PageViewData, Access.public, "python,javascript,java");

@@usage(PageViewPerfData, Usage.output | Usage.json);
@@access(PageViewPerfData, Access.public, "python,javascript,java");

@@usage(AvailabilityData, Usage.output | Usage.json);
@@access(AvailabilityData, Access.public, "python,javascript,java");

@@usage(DataPoint, Usage.output | Usage.json);
@@access(DataPoint, Access.public, "python,javascript,java");

@@usage(ContextTagKeys, Usage.output | Usage.json);
@@access(ContextTagKeys, Access.public, "python,javascript,java");

@@access(AzureMonitorExporter, Access.internal, "csharp");
@@access(Base, Access.internal, "csharp");
@@access(Domain, Access.internal, "csharp");
@@access(DomainKind, Access.internal, "csharp");
@@access(EventData, Access.internal, "csharp");
@@access(DataPoint, Access.internal, "csharp");
@@access(ExceptionData, Access.internal, "csharp");
@@access(ExceptionDetails, Access.internal, "csharp");
@@access(ErrorDetails, Access.internal, "csharp");
@@access(TelemetryEnvelope, Access.internal, "csharp");
