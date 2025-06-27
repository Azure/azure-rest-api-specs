import "./main.tsp";
import "../Certificate/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using ConfidentialLedger.Ledger;

@useDependency(ConfidentialLedger.Ledger.Versions.v2024_12_09_preview)
@useDependency(ConfidentialLedger.Certificate.Versions.v2024_12_09_preview)
namespace ConfidentialLedgerClients;

@@clientName(JSRuntimeOptions.log_exception_details, "logExceptionDetails");
@@clientName(JSRuntimeOptions.max_cached_interpreters, "maxCachedInterpreters");
@@clientName(JSRuntimeOptions.max_execution_time_ms, "maxExecutionTimeMs");
@@clientName(JSRuntimeOptions.max_heap_bytes, "maxHeapBytes");
@@clientName(JSRuntimeOptions.max_stack_bytes, "maxStackBytes");
@@clientName(JSRuntimeOptions.return_exception_details,
  "returnExceptionDetails"
);

@@clientName(EndpointProperties.authn_policies, "authnPolicies");
@@clientName(EndpointProperties.forwarding_required, "forwardingRequired");
@@clientName(EndpointProperties.interpreter_reuse, "interpreterReuse");
@@clientName(EndpointProperties.js_function, "jsFunction");
@@clientName(EndpointProperties.js_module, "jsModule");
@@clientName(EndpointProperties.openapi_hidden, "openapiHidden");
@@clientName(EndpointProperties.redirection_strategy, "redirectionStrategy");

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  service: ConfidentialLedger.Ledger,
  name: "ConfidentialLedgerClient",
})
interface ConfidentialLedgerClient
  extends ConfidentialLedger.Ledger.Operations {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client({
  service: ConfidentialLedger.Certificate,
  name: "ConfidentialLedgerCertificateClient",
})
interface ConfidentialLedgerCertificateClient {
  getLedgerIdentity is ConfidentialLedger.Certificate.getLedgerIdentity;
}
