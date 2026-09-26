import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// ── Client name ──
@@clientName(Azure.Monitor.LiveMetrics, "QuickpulseClient", "javascript");

// ── Ensure union types generate Known* enum objects and are available as both input & output ──
@@usage(Azure.Monitor.LiveMetrics.DocumentType, Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.CollectionConfigurationErrorType,
  Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.PredicateType, Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.AggregationType, Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.TelemetryType, Usage.input | Usage.output);

// ── Ensure response‑only models also generate input types ──
@@usage(Azure.Monitor.LiveMetrics.CollectionConfigurationInfo,
  Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.DerivedMetricInfo,
  Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.FilterConjunctionGroupInfo,
  Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.FilterInfo, Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.DocumentStreamInfo,
  Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.DocumentFilterConjunctionGroupInfo,
  Usage.input | Usage.output);
@@usage(Azure.Monitor.LiveMetrics.QuotaConfigurationInfo,
  Usage.input | Usage.output);

// ── camelCase client names for MonitoringDataPoint ──
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.Version,
  "version", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.InvariantVersion,
  "invariantVersion", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.Instance,
  "instance", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.RoleName,
  "roleName", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.MachineName,
  "machineName", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.StreamId,
  "streamId", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.Timestamp,
  "timestamp", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.TransmissionTime,
  "transmissionTime", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.IsWebApp,
  "isWebApp", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.PerformanceCollectionSupported,
  "performanceCollectionSupported", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.Metrics,
  "metrics", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.Documents,
  "documents", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.TopCpuProcesses,
  "topCpuProcesses", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MonitoringDataPoint.CollectionConfigurationErrors,
  "collectionConfigurationErrors", "javascript");

// ── camelCase client names for MetricPoint ──
@@clientName(Azure.Monitor.LiveMetrics.MetricPoint.Name,
  "name", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MetricPoint.Value,
  "value", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.MetricPoint.Weight,
  "weight", "javascript");

// ── camelCase client names for ProcessCpuData ──
@@clientName(Azure.Monitor.LiveMetrics.ProcessCpuData.ProcessName,
  "processName", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.ProcessCpuData.CpuPercentage,
  "cpuPercentage", "javascript");

// ── camelCase client names for CollectionConfigurationError ──
@@clientName(Azure.Monitor.LiveMetrics.CollectionConfigurationError.CollectionConfigurationErrorType,
  "collectionConfigurationErrorType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.CollectionConfigurationError.Message,
  "message", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.CollectionConfigurationError.FullException,
  "fullException", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.CollectionConfigurationError.Data,
  "data", "javascript");

// ── camelCase client names for DocumentIngress (base model) ──
@@clientName(Azure.Monitor.LiveMetrics.DocumentIngress.DocumentType,
  "documentType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DocumentIngress.DocumentStreamIds,
  "documentStreamIds", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DocumentIngress.Properties,
  "properties", "javascript");

// ── camelCase client names for shared document properties (on each subtype) ──
@@clientName(Azure.Monitor.LiveMetrics.Request.DocumentType,
  "documentType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.RemoteDependency.DocumentType,
  "documentType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.Exception.DocumentType,
  "documentType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.Event.DocumentType,
  "documentType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.Trace.DocumentType,
  "documentType", "javascript");

// ── camelCase client names for Request ──
@@clientName(Azure.Monitor.LiveMetrics.Request.Name,
  "name", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.Request.Url,
  "url", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.Request.ResponseCode,
  "responseCode", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.Request.Duration,
  "duration", "javascript");

// ── camelCase client names for RemoteDependency ──
@@clientName(Azure.Monitor.LiveMetrics.RemoteDependency.Name,
  "name", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.RemoteDependency.CommandName,
  "commandName", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.RemoteDependency.ResultCode,
  "resultCode", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.RemoteDependency.Duration,
  "duration", "javascript");

// ── camelCase client names for Exception ──
@@clientName(Azure.Monitor.LiveMetrics.Exception.ExceptionType,
  "exceptionType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.Exception.ExceptionMessage,
  "exceptionMessage", "javascript");

// ── camelCase client names for Event ──
@@clientName(Azure.Monitor.LiveMetrics.Event.Name,
  "name", "javascript");

// ── camelCase client names for Trace ──
@@clientName(Azure.Monitor.LiveMetrics.Trace.Message,
  "message", "javascript");

// ── camelCase client names for CollectionConfigurationInfo ──
@@clientName(Azure.Monitor.LiveMetrics.CollectionConfigurationInfo.ETag,
  "eTag", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.CollectionConfigurationInfo.Metrics,
  "metrics", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.CollectionConfigurationInfo.DocumentStreams,
  "documentStreams", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.CollectionConfigurationInfo.QuotaInfo,
  "quotaInfo", "javascript");

// ── camelCase client names for QuotaConfigurationInfo ──
@@clientName(Azure.Monitor.LiveMetrics.QuotaConfigurationInfo.InitialQuota,
  "initialQuota", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.QuotaConfigurationInfo.MaxQuota,
  "maxQuota", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.QuotaConfigurationInfo.QuotaAccrualRatePerSec,
  "quotaAccrualRatePerSec", "javascript");

// ── camelCase client names for DerivedMetricInfo ──
@@clientName(Azure.Monitor.LiveMetrics.DerivedMetricInfo.Id,
  "id", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DerivedMetricInfo.TelemetryType,
  "telemetryType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DerivedMetricInfo.FilterGroups,
  "filterGroups", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DerivedMetricInfo.Projection,
  "projection", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DerivedMetricInfo.Aggregation,
  "aggregation", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DerivedMetricInfo.BackEndAggregation,
  "backEndAggregation", "javascript");

// ── camelCase client names for DocumentStreamInfo ──
@@clientName(Azure.Monitor.LiveMetrics.DocumentStreamInfo.Id,
  "id", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DocumentStreamInfo.DocumentFilterGroups,
  "documentFilterGroups", "javascript");

// ── camelCase client names for DocumentFilterConjunctionGroupInfo ──
@@clientName(Azure.Monitor.LiveMetrics.DocumentFilterConjunctionGroupInfo.TelemetryType,
  "telemetryType", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.DocumentFilterConjunctionGroupInfo.Filters,
  "filters", "javascript");

// ── camelCase client names for FilterConjunctionGroupInfo ──
@@clientName(Azure.Monitor.LiveMetrics.FilterConjunctionGroupInfo.Filters,
  "filters", "javascript");

// ── camelCase client names for FilterInfo ──
@@clientName(Azure.Monitor.LiveMetrics.FilterInfo.FieldName,
  "fieldName", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.FilterInfo.Predicate,
  "predicate", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.FilterInfo.Comparand,
  "comparand", "javascript");

// ── camelCase client names for ServiceError ──
@@clientName(Azure.Monitor.LiveMetrics.ServiceError.RequestId,
  "requestId", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.ServiceError.ResponseDateTime,
  "responseDateTime", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.ServiceError.Code,
  "code", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.ServiceError.Message,
  "message", "javascript");
@@clientName(Azure.Monitor.LiveMetrics.ServiceError.Exception,
  "exception", "javascript");
