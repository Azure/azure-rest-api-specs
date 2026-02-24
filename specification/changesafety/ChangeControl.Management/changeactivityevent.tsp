import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";
import "./main.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ChangeSafety;

@doc("Immutable, append-only audit event resource that captures fine-grained Change Safety activities.")
@added(Versions.v2026_01_01_preview)
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "ChangeActivityEvent is an immutable audit event resource that is stored in ARG, not provisioned over time."
@doc("Detailed properties of the ChangeActivityEvent resource.")
@added(Versions.v2026_01_01_preview)
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
  targetResourceId?: string;

  @doc("Identifier in an external system.")
  externalReferenceId?: string;

  @doc("Time the activity occurred in ISO-8601 format.")
  timestamp: utcDateTime;

  @doc("Identity type that initiated the event.")
  initiatedByType?: string;

  @doc("Initiator or end user identity.")
  initiatedBy?: string;

  @doc("Version of the eventData schema.")
  eventVersion: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Suppressing the warning: eventData is polymorphic payload specific to kind/eventVersion."
  @doc("Polymorphic payload specific to kind/eventVersion.")
  eventData: {};

  @doc("Collection of references to external systems associated with this change.")
  links?: Link[];
}

@doc("Category of the ChangeActivityEvent.")
@added(Versions.v2026_01_01_preview)
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
@added(Versions.v2026_01_01_preview)
union ChangeActivityEventKind {
  string,

  @doc("Acquire Policy Token event")
  AcquirePolicyToken: "AcquirePolicyToken",

  @doc("Policy Evaluation event")
  PolicyEvaluation: "PolicyEvaluation",
}

@doc("ActivityType of the ChangeActivityEvent.")
@added(Versions.v2026_01_01_preview)
union ActivityType {
  string,

  @doc("Policy Governance activity")
  PolicyGovernance: "PolicyGovernance",

  @doc("ARM Control Plane activity")
  ArmControlPlane: "ArmControlPlane",
}

@doc("Azure resource Id of a ChangeActivityEvent.")
@added(Versions.v2026_01_01_preview)
scalar ChangeActivityEventResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.AzureChangeControl/changeActivityEvents",
    }
  ]>;

@armResourceOperations
@doc("The operations of the ChangeActivityEvent resource.")
@added(Versions.v2026_01_01_preview)
interface ChangeActivityEvents {
  @doc("List ChangeActivityEvents by parent resource ID. The parent resource should be a Microsoft.ChangeSafety resource (e.g., ChangeRecords, StageProgressions).")
  listByParent is ArmResourceListByParent<ChangeActivityEvent>;
}
