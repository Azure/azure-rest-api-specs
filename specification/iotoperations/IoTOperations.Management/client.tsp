import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.IoTOperations;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@@clientName(Microsoft.IoTOperations, "IoTOperationsMgmt", "python");
@@clientName(Microsoft.IoTOperations, "IoTOperationsManagementClient", "java");

// CSharp Client configuration
@@clientName(BrokerAuthenticationResource,
  "IotOperationsBrokerAuthentication",
  "csharp"
);
@@clientName(BrokerAuthenticationProperties,
  "IotOperationsBrokerAuthenticationProperties",
  "csharp"
);
@@clientName(BrokerAuthorizationResource,
  "IotOperationsBrokerAuthorization",
  "csharp"
);
@@clientName(BrokerAuthorizationProperties,
  "IotOperationsBrokerAuthorizationProperties",
  "csharp"
);
@@clientName(BrokerListenerResource, "IotOperationsBrokerListener", "csharp");
@@clientName(BrokerListenerProperties,
  "IotOperationsBrokerListenerProperties",
  "csharp"
);
@@clientName(BrokerResource, "IotOperationsBroker", "csharp");
@@clientName(BrokerProperties, "IotOperationsBrokerProperties", "csharp");
@@clientName(DataflowEndpointResource,
  "IotOperationsDataflowEndpoint",
  "csharp"
);
@@clientName(DataflowEndpointProperties,
  "IotOperationsDataflowEndpointProperties",
  "csharp"
);
@@clientName(DataflowProfileResource, "IotOperationsDataflowProfile", "csharp");
@@clientName(DataflowProfileProperties,
  "IotOperationsDataflowProfileProperties",
  "csharp"
);
@@clientName(DataflowResource, "IotOperationsDataflow", "csharp");
@@clientName(DataflowProperties, "IotOperationsDataflowProperties", "csharp");
@@clientName(InstanceResource, "IotOperationsInstance", "csharp");
@@clientName(InstanceProperties, "IotOperationsInstanceProperties", "csharp");
@@clientName(AdvancedSettings, "BrokerAdvancedSettings", "csharp");
@@clientName(AuthorizationConfig, "BrokerAuthorizationConfig", "csharp");
@@clientName(AuthorizationRule, "BrokerAuthorizationRule", "csharp");
@@clientName(BackendChain, "BrokerBackendChain", "csharp");
@@clientName(BatchingConfiguration, "IotOperationsBatchingConfig", "csharp");
@@clientName(Cardinality, "BrokerCardinality", "csharp");
@@clientName(CertManagerCertOptions, "CertManagerCertConfig", "csharp");
@@clientName(ClientConfig, "BrokerClientConfig", "csharp");
@@clientName(DataflowOperation, "DataflowOperationProperties", "csharp");
@@clientName(EndpointType, "DataflowEndpointType", "csharp");
@@clientName(ExtendedLocation, "IotOperationsExtendedLocation", "csharp");
@@clientName(ExtendedLocationType,
  "IotOperationsExtendedLocationType",
  "csharp"
);
@@clientName(FilterType, "DataflowFilterType", "csharp");
@@clientName(Frontend, "BrokerFrontend", "csharp");
@@clientName(ListenerPort, "BrokerListenerPort", "csharp");
@@clientName(Metrics, "IotOperationsMetrics", "csharp");
@@clientName(MetricProperties, "IotOperationsMetricsProperties", "csharp");
@@clientName(OperationalMode, "IotOperationsOperationalMode", "csharp");
@@clientName(OperationType, "DataflowOperationType", "csharp");
@@clientName(OperatorValues, "BrokerOperatorValues", "csharp");
@@clientName(PrincipalDefinition, "PrincipalConfig", "csharp");
@@clientName(ProfileDiagnostics, "DataflowProfileDiagnostics", "csharp");
@@clientName(ProvisioningState, "IotOperationsProvisioningState", "csharp");
@@clientName(SelfCheck, "BrokerDiagnosticSelfCheck", "csharp");
@@clientName(SelfTracing, "DiagnosticSelfTracing", "csharp");
@@clientName(ServiceType, "BlockerListenerServiceType", "csharp");
@@clientName(SourceSerializationFormat,
  "DataflowSourceSerializationFormat",
  "csharp"
);
@@clientName(TlsCertMethod, "ListenerPortTlsCertMethod", "csharp");
@@clientName(TlsProperties, "IotOperationsTlsProperties", "csharp");
@@clientName(Traces, "BrokerDiagnosticTraces", "csharp");
@@clientName(Versions.`2024-11-01`,
  "$DO_NOT_NORMALIZE$V2024-11-01",
  "javascript"
);
@@clientName(Versions.`2025-04-01`, "V20250401", "javascript");
