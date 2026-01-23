import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Workflow properties definition.
 */
@parentResource(Site)
model WorkflowEnvelope
  is Azure.ResourceManager.ProxyResource<WorkflowEnvelopeProperties> {
  ...ResourceNameParameter<
    Resource = WorkflowEnvelope,
    KeyName = "workflowName",
    SegmentName = "workflows",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;

  /**
   * The resource kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * The resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations
interface WorkflowEnvelopeOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Workflow name. */
        @path
        @segment("workflows")
        @key
        @pattern("^[a-z][a-z0-9]*$")
        @maxLength(63)
        @minLength(3)
        workflowName: string,
      }
    > {}

@armResourceOperations
interface WorkflowEnvelopes {
  /**
   * Get workflow information by its ID for web site, or a deployment slot.
   */
  @summary("Get workflow information by its ID for web site, or a deployment slot.")
  getInstanceWorkflowSlot is WorkflowEnvelopeOps.Read<
    WorkflowEnvelope,
    Response = ArmResponse<WorkflowEnvelope> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * List the workflows for a web site, or a deployment slot.
   */
  @summary("List the workflows for a web site, or a deployment slot.")
  listInstanceWorkflowsSlot is WorkflowEnvelopeOps.List<
    WorkflowEnvelope,
    Response = ArmResponse<WorkflowEnvelopeCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface WorkflowEnvelopeOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Workflow name. */
        @path
        @segment("workflows")
        @key
        @pattern("^[a-z][a-z0-9]*$")
        @maxLength(63)
        @minLength(3)
        workflowName: string,
      }
    > {}

@armResourceOperations
interface WorkflowEnvelopeOperationGroup {
  /**
   * Get workflow information by its ID for web site, or a deployment slot.
   */
  @summary("Get workflow information by its ID for web site, or a deployment slot.")
  getWorkflow is WorkflowEnvelopeOperationGroupOps.Read<
    WorkflowEnvelope,
    Response = ArmResponse<WorkflowEnvelope> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * List the workflows for a web site, or a deployment slot.
   */
  @summary("List the workflows for a web site, or a deployment slot.")
  listWorkflows is WorkflowEnvelopeOperationGroupOps.List<
    WorkflowEnvelope,
    Response = ArmResponse<WorkflowEnvelopeCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@maxLength(WorkflowEnvelope.name, 63);
@@minLength(WorkflowEnvelope.name, 3);
@@doc(WorkflowEnvelope.name, "Workflow name.");
@@doc(WorkflowEnvelope.properties, "Additional workflow properties.");
