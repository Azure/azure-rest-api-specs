import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";
import "./main.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.ChangeSafety;

@doc("Immutable, append-only audit event resource that captures fine-grained Change Safety activities.")
model ChangeActivityEvent is ExtensionResource<ChangeActivityEventProperties> {
  @doc("The name of the ChangeActivityEvent resource.")
  @key("changeActivityEventName")
  @segment("changeActivityEvents")
  @pattern("^[a-zA-Z0-9-|]{3,100}$")
  @minLength(3)
  @maxLength(100)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The event interface exposes only GET and list. Events have no create or update lifecycle, so the properties omit provisioningState."
@doc("Detailed properties of the ChangeActivityEvent resource.")
@discriminator("kind")
model ChangeActivityEventProperties {
  @doc("Correlation identifier tying related events together.")
  activityId: string;

  @doc("Logical event kind describing the action.")
  kind: ChangeActivityEventKind;

  @doc("Category of the event.")
  category: ChangeActivityEventCategory;

  @doc("High-level activity domain.")
  activityType: ActivityType;

  @doc("ID of the resource targeted by the operation associated with this activity.")
  targetResourceId?: Azure.Core.armResourceIdentifier;

  @doc("Identifier in an external system.")
  externalReferenceId?: string;

  @doc("Time the activity occurred in ISO-8601 format.")
  timestamp: utcDateTime;

  @doc("Identity type that initiated the event.")
  initiatedByType?: InitiatedByType;

  @doc("Initiator or end user identity.")
  initiatedBy?: string;

  @doc("Collection of references to external systems associated with this change.")
  @Azure.ResourceManager.identifiers(#[])
  links?: Link[];
}

@doc("Properties of an AcquirePolicyToken event using the 2026-01-01 payload schema.")
model AcquirePolicyTokenEventProperties extends ChangeActivityEventProperties {
  @doc("The event kind.")
  kind: "AcquirePolicyToken";

  @doc("The event payload schema version.")
  eventVersion: "2026-01-01";

  @doc("Details of policy-token acquisition.")
  eventData: AcquirePolicyTokenEventData;
}

@doc("Policy-token acquisition event details.")
model AcquirePolicyTokenEventData {
  @doc("Identifier of the acquired policy token.")
  tokenId?: string;

  @doc("Result of the policy-token validation.")
  validationResult?: string;

  @doc("Number of policy evaluations performed.")
  @minValue(0)
  policyEvaluationCount?: int32;
}

@doc("Properties of a PolicyEvaluation event using the 2026-01-01 payload schema.")
model PolicyEvaluationEventProperties extends ChangeActivityEventProperties {
  @doc("The event kind.")
  kind: "PolicyEvaluation";

  @doc("The event payload schema version.")
  eventVersion: "2026-01-01";

  @doc("Details of the policy evaluation.")
  eventData: PolicyEvaluationEventData;
}

@doc("Policy evaluation event details.")
model PolicyEvaluationEventData {
  @doc("Name of the evaluated policy.")
  policyName?: string;

  @doc("Result of the policy evaluation.")
  evaluationResult?: string;

  @doc("Duration of the policy evaluation in milliseconds.")
  @minValue(0)
  evaluationDurationMs?: int32;
}

@doc("Category of the ChangeActivityEvent.")
union ChangeActivityEventCategory {
  string,

  @doc("Informational event")
  Information: "Information",

  @doc("Warning event")
  Warning: "Warning",

  @doc("Error event")
  Error: "Error",
}

@doc("Kind of the ChangeActivityEvent.")
union ChangeActivityEventKind {
  string,

  @doc("Acquire Policy Token event")
  AcquirePolicyToken: "AcquirePolicyToken",

  @doc("Policy Evaluation event")
  PolicyEvaluation: "PolicyEvaluation",
}

@doc("ActivityType of the ChangeActivityEvent.")
union ActivityType {
  string,

  @doc("Policy Governance activity")
  PolicyGovernance: "PolicyGovernance",

  @doc("ARM Control Plane activity")
  ArmControlPlane: "ArmControlPlane",
}

@doc("Identity type that initiated the event.")
union InitiatedByType {
  string,

  @doc("An application initiated the event.")
  Application: "Application",

  @doc("A user initialized the event.")
  User: "User",

  @doc("A Managed identity initialized the event.")
  ManagedIdentity: "ManagedIdentity",
}

@doc("Azure resource Id of a ChangeActivityEvent.")
scalar ChangeActivityEventResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/changeActivityEvents",
    }
  ]>;

@armResourceOperations
@doc("The operations of the ChangeActivityEvent resource.")
interface ChangeActivityEvents {
  @doc("Get a ChangeActivityEvent by name under its parent resource.")
  get is ArmResourceRead<ChangeActivityEvent>;

  @doc("List ChangeActivityEvents by parent resource ID. The parent resource should be a Microsoft.ChangeSafety resource (e.g., ChangeRecords, StageProgressions).")
  listByParent is ArmResourceListByParent<ChangeActivityEvent>;
}
