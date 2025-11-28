import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.Instructions.Models;

@resource("instructions")
@doc("This is the request model for Instruction")
model Instruction {
  @key("id")
  @visibility(Lifecycle.Read)
  @doc("Id for the instruction")
  id: string;

  @doc("intruction Id for the instruction")
  @visibility(Lifecycle.Update)
  instructionId: string;

  @doc("Version for the instruction")
  @visibility(Lifecycle.Update)
  instructionVersion: string;

  @doc("Status for the instruction")
  @visibility(Lifecycle.Read)
  status: InstructionStatusEnum;

  @doc("Domain for the instruction")
  @visibility(Lifecycle.Read)
  domain: InstrustionDomainEnum;

  @doc("Sub-domain for the instruction")
  @visibility(Lifecycle.Read)
  subDomain: InstructionSubDomainEnum;

  @doc("Category for the instruction")
  @visibility(Lifecycle.Read)
  category: InstructionCategoryEnum;

  @doc("The language of the instruction.")
  language: InstructionLanguageEnum;

  @doc("The retrieval properties of the instruction.")
  retrieval: RetrievalProperties;

  @doc("The content properties of the instruction.")
  content: ContentProperties;

  @doc("The relationships of the instruction.")
  relationships: Relationships;

  @doc("audit record for the instruction")
  administrativeDetails: AdministrativeDetails;
}

@doc("Instruction Patch Request")
model InstructionPatchRequest {
  @doc("The instruction status.")
  status: InstructionStatusEnum;
}

@doc("Instruction Status Enums")
union InstructionStatusEnum {
  @doc("Instruction is active")
  Active: "Active",

  @doc("Instruction is inactive")
  Inactive: "Inactive",

  @doc("Extensible status type")
  string,
}

@doc("Instruction Sub Domain Enums")
union InstrustionDomainEnum {
  @doc("Manufacturing Operations Management")
  MOM: "MOM",

  @doc("Supply Chain Management")
  SCM: "SCM",

  @doc("Digital Engineering")
  DE: "DE",

  @doc("Extensible domain type")
  string,
}

@doc("Instruction Sub Domain Enums")
union InstructionSubDomainEnum {
  @doc("Production sub-domain")
  Production: "Production",

  @doc("Quality sub-domain")
  Quality: "Quality",

  @doc("Maintenance sub-domain")
  Maintenance: "Maintenance",

  @doc("Inventory sub-domain")
  Inventory: "Inventory",

  @doc("Downtime sub-domain")
  Downtime: "Downtime",

  @doc("Scrap sub-domain")
  Scrap: "Scrap",

  @doc("Mixed sub-domain")
  Mixed: "Mixed",

  @doc("Extensible sub-domain type")
  string,
}

@doc("Instruction Category Enums")
union InstructionCategoryEnum {
  @doc("Transactional instruction category")
  Transactional: "Transactional",

  @doc("Analytical instruction category")
  Analytical: "Analytical",

  @doc("Trend instruction category")
  Trend: "Trend",

  @doc("KPI instruction category")
  KPI: "KPI",

  @doc("Extensible category type")
  string,
}

@doc("Instruction Language Enums")
union InstructionLanguageEnum {
  @doc("English")
  EN: "EN",

  @doc("Extensible language type")
  string,
}

@doc("Instruction Source Enums")
union InstructionSourceEnum {
  @doc("Internal Instruction")
  outOfTheBox: "outOfTheBox",

  @doc("Custom Instruction")
  custom: "custom",

  @doc("Extensible status type")
  string,
}

@doc("Relationships")
model Relationships {
  @doc("List of dependent instructions")
  dependencies: string[];

  @doc("List of InstructionIds to be excluded")
  exclusions: string[];
}

@doc("The retrieval properties of the instruction.")
model RetrievalProperties {
  @doc("The sub-topics related to the instruction.")
  subTopics: string[];

  @doc("The keywords associated with the instruction.")
  keywords: string[];

  @doc("The sample questions for the instruction.")
  sampleQuestions: string[];
}

@doc("The content properties of the instruction.")
model ContentProperties {
  @doc("The semantic content of the instruction.")
  semanticContent: SemanticContent;
}

@doc("The semantic content of the instruction.")
model SemanticContent {
  @doc("The content of the instruction.")
  context: string;

  @doc("The source of the instruction.")
  steps: string;
}

@doc("The administrative details of the instruction.")
model AdministrativeDetails {
  @doc("The source of the instruction.")
  source: string;

  @doc("The comment for the instruction.")
  createdBy: string;

  @doc("The comment for the instruction.")
  lastModifiedBy: string;

  @doc("Creation date of the instruction.")
  createdAt: utcDateTime;

  @doc("any closing comments")
  comment: string;
}

@doc("This is the patch request to update the status of instruction")
model UpdateStatusRequest {
  @doc("status of the instruction")
  status: InstructionStatusEnum;
}
