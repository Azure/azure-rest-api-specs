import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Monitor;

// Rename the PipelineGroups operation group to avoid conflict with the
// namespace segment "PipelineGroups" in Azure.ResourceManager.Monitor.PipelineGroups.
// Without this, the generator prefixes the namespace segment with "_".
@@clientName(PipelineGroups, "PipelineGroupOperations", "csharp");

// ── Contextual naming: prefix models with PipelineGroup ──
@@clientName(Pipeline, "PipelineGroupPipeline", "csharp");
@@clientName(Service, "PipelineGroupService", "csharp");
@@clientName(Receiver, "PipelineGroupReceiver", "csharp");
@@clientName(Processor, "PipelineGroupProcessor", "csharp");
@@clientName(Exporter, "PipelineGroupExporter", "csharp");
@@clientName(BatchProcessor, "PipelineGroupBatchProcessor", "csharp");
@@clientName(SyslogReceiver, "PipelineGroupSyslogReceiver", "csharp");
@@clientName(OtlpReceiver, "PipelineGroupOtlpReceiver", "csharp");
@@clientName(TransformLanguageProcessor,
  "PipelineGroupTransformLanguageProcessor",
  "csharp"
);
@@clientName(TlsConfiguration, "PipelineGroupTlsConfiguration", "csharp");
@@clientName(CertificateWithKey, "PipelineGroupCertificateWithKey", "csharp");
@@clientName(CertificateSource, "PipelineGroupCertificateSource", "csharp");
@@clientName(PrivateKeySource, "PipelineGroupPrivateKeySource", "csharp");
@@clientName(ExecutionPlacement, "PipelineGroupExecutionPlacement", "csharp");
@@clientName(PlacementConstraint, "PipelineGroupPlacementConstraint", "csharp");
@@clientName(SchemaMap, "PipelineGroupSchemaMap", "csharp");
@@clientName(RecordMap, "PipelineGroupRecordMap", "csharp");
@@clientName(ResourceMap, "PipelineGroupResourceMap", "csharp");
@@clientName(ScopeMap, "PipelineGroupScopeMap", "csharp");
@@clientName(ExporterPersistenceConfiguration,
  "PipelineGroupExporterPersistenceConfiguration",
  "csharp"
);

// ── Contextual naming: prefix enums/unions with PipelineGroup ──
@@clientName(ProvisioningState,
  "MonitorPipelineGroupProvisioningState",
  "csharp"
);
@@clientName(AllowedFormats, "PipelineGroupAllowedFormat", "csharp");
@@clientName(ReceiverType, "PipelineGroupReceiverType", "csharp");
@@clientName(ProcessorType, "PipelineGroupProcessorType", "csharp");
@@clientName(ExporterType, "PipelineGroupExporterType", "csharp");
@@clientName(PipelineType, "PipelineGroupPipelineType", "csharp");
@@clientName(CapabilityOperator, "PipelineGroupCapabilityOperator", "csharp");
@@clientName(CertificateSourceType,
  "PipelineGroupCertificateSourceType",
  "csharp"
);
@@clientName(PrivateKeySourceType,
  "PipelineGroupPrivateKeySourceType",
  "csharp"
);
@@clientName(TlsMode, "PipelineGroupTlsMode", "csharp");
@@clientName(TransportProtocol, "PipelineGroupTransportProtocol", "csharp");

// ── Acronym casing: OTLP → Otlp (PascalCase for 3+ letter acronyms) ──
@@clientName(ReceiverType.OTLP, "Otlp", "csharp");

// ── Property renames ──
// Receiver.tlsConfiguration is a string ref that collides with the TlsConfiguration type
@@clientName(Receiver.tlsConfiguration, "TlsConfigurationName", "csharp");
// Integer properties must include units in the name
@@clientName(BatchProcessor.timeout, "TimeoutInMilliseconds", "csharp");
@@clientName(ExporterPersistenceConfiguration.maxStorageUsage,
  "MaxStorageUsageInGigabytes",
  "csharp"
);
@@clientName(ExporterPersistenceConfiguration.retentionPeriod,
  "RetentionPeriodInMinutes",
  "csharp"
);
// Rename dataCollectionRule to DataCollectionRuleId for clarity
@@clientName(AzureMonitorWorkspaceLogsApiConfig.dataCollectionRule,
  "DataCollectionRuleId",
  "csharp"
);
