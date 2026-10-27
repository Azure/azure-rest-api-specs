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

@doc("Partial change definition supplied by a PATCH request.")
model ChangeDefinitionPatch {
  ...OptionalProperties<ChangeDefinition>;
}

@doc("Resource properties for PATCH requests with partial parameter and change definitions.")
model ChangeDefinitionPatchProperties<Properties extends TypeSpec.Reflection.Model> {
  ...OmitProperties<ParameterPatchProperties<Properties>, "changeDefinition">;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Change request body and/or resource selection criteria used to identify the targeted resources.")
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

@doc("Artifact content model for Inline ArmOperations.")
model ArmResourceOperation {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The uri of the operation.")
  uri: url;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The http method of the operation.")
  httpMethod: ArmOperation;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The target ARM resource provider and API version define the request body's properties and value types."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The resource operation request body.")
  body?: Record<unknown>;
}

@doc("Supported ARM Operations.")
union ArmOperation {
  string,

  @doc("DELETE ARM Operation.")
  DELETE: "DELETE",

  @doc("PUT ARM Operation.")
  PUT: "PUT",

  @doc("PATCH ARM Operation.")
  PATCH: "PATCH",

  @doc("POST ARM Operation.")
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

@doc("Model that defines the change definition with name, type, and details.")
model ChangeDefinition {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Name of the change definition.")
  name: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Kind of the change definition.")
  kind: ChangeDefinitionType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The extensible change-definition kind determines customer-supplied payload fields. Preserve their arbitrary JSON keys and values without empty-model SDK serialization."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Free form object containing additional details for the change definition.")
  details: Record<unknown>;
}

@doc("Defines the type of change definition.")
union ChangeDefinitionType {
  string,

  @doc("API operation change definition type.")
  ApiOperations: "ApiOperations",

  @doc("Target selection criteria change definition type.")
  Targets: "Targets",
}
