import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureMonitorExporter;

@@clientName(AzureMonitorExporter, "ApplicationInsightsClient");
@@clientName(AzureMonitorExporter, "ApplicationInsightsRestClient", "csharp");
@@clientName(AzureMonitorExporter, "AzureMonitorClient", "python");

@@clientName(Base, "MonitorBase");
@@clientName(Domain, "MonitorDomain");
@@clientName(DomainKind, "MonitorDomainKind");
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
