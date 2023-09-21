import "@typespec/rest";
import "@typespec/http";
import "../SharedModels.tsp";
import "../SharedEnums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace SkillContext;

@doc("SkillContext object containing properties of the current session relevant to the invoked skill")
model SkillContextResponse {
  @doc("Skill descriptor containing attributes that describe a skill (i.e. Inputs required to execute the skill)")
  descriptor: SkillDescriptor;

  @doc("SkillContext Id")
  id: string;

  @doc("Array of feature flags")
  featureFlags: Array<string>;

  @doc("Skill Variable Collection")
  inputs: Record<SkillVariable>;

  @doc("Additional skill specific settings")
  properties: Record<string>;

  @doc("TODO")
  StartTime: utcDateTime;

  @doc("Tenant id of tenant in which skill invocation occured")
  TenantId: string;

  @doc("User id of user that invoked the skill")
  UserId: string;
}

@doc("Skill Variable")
model SkillVariable {
  @doc("Skill variable type")
  type: string;

  @doc("Skill variable value")
  value: string;
}

@doc("Invoke skill request including necessary inputs for invoking a skill")
model InvokeSkillRequest {
  @doc("Name of skillset in which desired skill to invoke resides")
  SkillsetName?: string;

  @doc("Name of skill to be invoked")
  SkillName: string;

  @doc("Skill inputs")
  inputs?: Record<SkillVariable>;
}

@doc("Skill variable parent entity adding additional attribute 'skillsource' to provide visibility to users as to what data/information was used in generating the output of a skill")
model OutputSkillVariable extends SkillVariable {
  @doc("Array of cited sources that were fetched by a skill and that impacted the output of the skill evaluation")
  Sources: Array<SkillSource>;
}

@doc("Source that is fetched during the evaluation of a skill. Provides visibility to users as to what data/information was used in generating the output of a skill")
model SkillSource {
  @doc("User friendly name for the information source")
  displayName: string;

  @doc("The source type (i.e. URI)")
  sourceType: SkillSourceType;

  @doc("Information source content (i.e. URL to article)")
  sourceContent: string;
}

@doc("The prompt history of the current session")
model PromptHistoryResponse {
  @doc("List of prompts that have been evaluated in the current session")
  prompts: Array<SessionPrompt>;
}

@doc("A record for a prompt and response used in tracking session prompt history")
model SessionPrompt {
  @doc("The content of the prompt")
  prompt: string;

  @doc("Prompt response returned by the prompt evaluation")
  response: string;
}

@doc("The progress message to log during a skill invocation")
model LogProgressRequest {
  @doc("Log level")
  level?: ProgressLogLevel;

  @doc("Log message")
  message: string;
}
