import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureMonitorExporter;

@@clientName(AzureMonitorExporter, "ApplicationInsightsClient", "javascript");

@@clientName(Base, "MonitorBase");
@@clientName(Domain, "MonitorDomain");
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
@@access(MessageData, Access.public);

@@usage(MetricsData, Usage.output | Usage.json);
@@access(MetricsData, Access.public);

@@usage(Domain, Usage.output | Usage.json);
@@access(Domain, Access.public);

@@usage(RemoteDependencyData, Usage.output | Usage.json);
@@access(RemoteDependencyData, Access.public);

@@usage(RequestData, Usage.output | Usage.json);
@@access(RequestData, Access.public);

@@usage(EventData, Usage.output | Usage.json);
@@access(EventData, Access.public);

@@usage(ExceptionData, Usage.output | Usage.json);
@@access(ExceptionData, Access.public);

@@usage(PageViewData, Usage.output | Usage.json);
@@access(PageViewData, Access.public);

@@usage(PageViewPerfData, Usage.output | Usage.json);
@@access(PageViewPerfData, Access.public);

@@usage(DataPoint, Usage.output | Usage.json);
@@access(DataPoint, Access.public);

@@usage(ContextTagKeys, Usage.output | Usage.json);
@@access(ContextTagKeys, Access.public);
