import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.ChangeSafety;

@doc("Partial change definition supplied by a PATCH request. If kind is supplied, it must match the stored kind. Use PUT to change kind.")
model ChangeDefinitionPatch {
  ...OptionalProperties<ChangeDefinition>;

  @doc("Partial details for the supplied kind, or the stored kind when kind is omitted. Supplied operations and targets arrays replace the corresponding stored arrays.")
  details?: ChangeDefinitionPatchDetails;
}

@doc("Kind-specific fields that may be supplied in a change-definition PATCH. Supply only the fields belonging to the supplied or stored kind.")
model ChangeDefinitionPatchDetails {
  @doc("Replacement operation definitions for an ApiOperations change.")
  @minItems(1)
  @identifiers(#[])
  operations?: PlannedResourceOperation[];

  @doc("Replacement resource selectors for a Targets change.")
  @minItems(1)
  @identifiers(#[])
  targets?: ChangeTarget[];
}

@doc("Resource properties for PATCH requests with partial parameter and change definitions.")
model ChangeDefinitionPatchProperties<Properties extends TypeSpec.Reflection.Model> {
  ...OmitProperties<ParameterPatchProperties<Properties>, "changeDefinition">;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Planned operation references or resource-selection criteria used to identify the targeted resources.")
  changeDefinition?: ChangeDefinitionPatch;
}

@doc("Defines the Kind of the intended Change.")
union ChangeType {
  string,

  @doc("Application deployment change.")
  AppDeployment: "AppDeployment",

  @doc("Configuration change.")
  Config: "Config",

  @doc("Policy deployment change.")
  PolicyDeployment: "PolicyDeployment",

  @doc("Manual touch change.")
  ManualTouch: "ManualTouch",
}

@doc("The method and URI of a planned Azure Resource Manager operation. Request bodies are not part of the stored change definition.")
model PlannedResourceOperation {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The URI of the operation.")
  uri: url;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The HTTP method of the operation.")
  httpMethod: ArmOperation;
}

@doc("An Azure Resource Manager operation submitted to verifyChangeValidity. Its body is used for request-time validation, not stored on the ChangeRecord or returned by verification.")
model ArmResourceOperation {
  ...PlannedResourceOperation;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The target Azure Resource Manager provider and API version define this transient validation request body's properties and value types."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The request body of the operation being verified. This value is not part of the stored change definition.")
  body?: Record<unknown>;
}

@doc("Supported Azure Resource Manager operations.")
union ArmOperation {
  string,

  @doc("DELETE Azure Resource Manager operation.")
  DELETE: "DELETE",

  @doc("PUT Azure Resource Manager operation.")
  PUT: "PUT",

  @doc("PATCH Azure Resource Manager operation.")
  PATCH: "PATCH",

  @doc("POST Azure Resource Manager operation.")
  POST: "POST",
}

@doc("Supported validation outcomes.")
union ValidationOutcome {
  string,

  @doc("Represents a Succeeded outcome.")
  Succeeded: "Succeeded",

  @doc("Represents a Failed outcome.")
  Failed: "Failed",

  @doc("Represents a Deferred outcome.")
  Deferred: "Deferred",
}

@doc("Defines the type of rollout for the change.")
union RolloutType {
  string,

  @doc("Normal rollout type.")
  Normal: "Normal",

  @doc("Hotfix rollout type.")
  Hotfix: "Hotfix",

  @doc("Emergency rollout type.")
  Emergency: "Emergency",
}

@doc("Named change definition with details selected by kind.")
@discriminator("kind")
model ChangeDefinition {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Name of the change definition.")
  name: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Kind of the change definition.")
  kind: ChangeDefinitionType;
}

@doc("A change defined by explicit Azure Resource Manager operations.")
model ApiOperationsChangeDefinition extends ChangeDefinition {
  @doc("The change-definition kind.")
  kind: ChangeDefinitionType.ApiOperations;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The Azure Resource Manager operations governed by this change.")
  details: ApiOperationsChangeDetails;
}

@doc("Explicit Azure Resource Manager operations governed by a change.")
model ApiOperationsChangeDetails {
  @doc("The operation definitions. Each entry supplies its method and URI.")
  @minItems(1)
  @identifiers(#[])
  operations: PlannedResourceOperation[];
}

@doc("A change defined by resource-selection criteria.")
model TargetsChangeDefinition extends ChangeDefinition {
  @doc("The change-definition kind.")
  kind: ChangeDefinitionType.Targets;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The resource-selection criteria governed by this change.")
  details: TargetsChangeDetails;
}

@doc("Resource selectors governed by a change.")
model TargetsChangeDetails {
  @doc("The resource selectors. An operation may match any one selector.")
  @minItems(1)
  @identifiers(#[])
  targets: ChangeTarget[];
}

@doc("A resource selector. Supply resourceId or subscriptionId. When resourceId is supplied, it selects that resource or scope and its descendants; otherwise the subscription and optional resource filters apply.")
model ChangeTarget {
  @doc("Azure resource or scope identifier to match, including its descendants.")
  resourceId?: Azure.Core.armResourceIdentifier;

  @doc("Subscription identifier to match when resourceId is omitted.")
  subscriptionId?: string;

  @doc("Resource group to match within the subscription.")
  resourceGroupName?: string;

  @doc("Resource type to match, such as Microsoft.Storage/storageAccounts.")
  resourceType?: string;

  @doc("Resource name to match within the selected scope and type.")
  resourceName?: string;

  @doc("HTTP method to match. Omit this field to match any supported method.")
  httpMethod?: ArmOperation;
}

@doc("Defines the type of change definition.")
union ChangeDefinitionType {
  string,

  @doc("API operation change definition type.")
  ApiOperations: "ApiOperations",

  @doc("Target selection criteria change definition type.")
  Targets: "Targets",
}
