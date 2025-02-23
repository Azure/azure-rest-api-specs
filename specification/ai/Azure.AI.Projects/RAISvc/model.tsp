import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

enum SimulationType {
  Default,
  CustomPersona,
  HarmTurnGenerator,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Customization Parameters")
model CustomizationParameters {
  @doc("Application scenario.")
  ApplicationScenario?: string;

  @doc("List of harm categories.")
  HarmCategories: Array<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Customization Parameters")
model SimulationDTO {
  @doc("Additional headers.")
  Headers?: Record<string>;

  @doc("Parameters.")
  Params?: Record<string>;

  @doc("Template parameters.")
  TemplateParameters?: Record<string>;

  @doc("Customization parameters.")
  CustomizationParameters?: CustomizationParameters;

  @doc("Json.")
  Json?: string;

  @doc("Url.")
  Url?: string;

  @doc("Template key.")
  TemplateKey?: string;

  @doc("Type of Simulation.")
  SimulationType?: SimulationType;

  @doc("'True' if Microsoft internal tenant and 'False' otherwise.")
  IsMicrosoftTenant?: boolean;

  @doc("Azure subscription id.")
  SubscriptionId?: string;

  @doc("Resource group name.")
  ResourceGroupName?: string;

  @doc("Workspace name.")
  WorkspaceName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model SimulationResultDTO {
  @doc("Status Code.")
  StatusCode: int32;

  @doc("Content.")
  Content: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model Content {
  Messages: unknown[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model AnnotationDTO {
  AnnotationTask: string;
  ContentType: string;
  UserTextList: string[];
  Contents: Content[];
  MetricList: string[];
  PromptVersion: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model Data {
  assetId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model ModelConfig {
  AzureEndpoint: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model SampleGenerator {
  ModelName: string;
  Type: string;
  SamplingParams: unknown;
  TrajectoryTemplate: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model Grader {
  Name: string;
  Description: string;
  Config: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model GradersDTO {
  Data: Data;
  ModelConfig: ModelConfig;
  SampleGenerators: SampleGenerator[];
  Graders: Grader[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model LongRunningResponse {
  Location: string;
  OperationResult: unknown;
}

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedOrOkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<202> &
  T;
