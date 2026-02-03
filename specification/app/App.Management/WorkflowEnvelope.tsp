import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LogicApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Schema for the workflow object.
 */
@parentResource(LogicApp)
model WorkflowEnvelope
  is Azure.ResourceManager.ProxyResource<WorkflowEnvelopeProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowEnvelope,
    KeyName = "workflowName",
    SegmentName = "workflows",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;

  /**
   * Gets the logic app hybrid workflow kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: WorkflowKind;
}

@@maxLength(WorkflowEnvelope.name, 63);
@@minLength(WorkflowEnvelope.name, 3);
@@doc(WorkflowEnvelope.name, "Workflow name.");
@@doc(WorkflowEnvelope.properties, "Additional workflow properties.");
