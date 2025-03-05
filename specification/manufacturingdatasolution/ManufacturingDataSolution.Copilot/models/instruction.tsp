import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace MdsSolution.CopilotService.Instructions.Models;

@doc("Instruction Info Response Model")
model InstructionInfoResponse {
  @doc("List of Instruction Info objects")
  instructionInfoList: InstructionInfo[];
}

@doc("Base Instruction Model")
model BaseInstructionModel {
  @doc("The unique identifier of the instruction.")
  instructionId: string;

  @doc("The version of the instruction.")
  instructionVersion: string;

  @doc("The status of the instruction.")
  stauses: InstructionStatusEnum;

  @doc("The domain of the instruction.")
  domain: InstrustionDomainEnum;

  @doc("The sub-domain of the instruction.")
  subDomain: InstructionSubDomainEnum;

  @doc("The category of the instruction.")
  category: InstructionCategoryEnum;

  @doc("The language of the instruction.")
  language: InstructionLanguageEnum;

  @doc("The retrieval properties of the instruction.")
  retrieval: RetrievalProperties;

  @doc("The content properties of the instruction.")
  content: ContentProperties;

  @doc("The relationships of the instruction.")
  relationships: Relationships;
}

@doc("Instruction Request Model")
@parentResource(BaseInstructionModel)
model InstructionRequestModel {
  @doc("The comment for the instruction.")
  comment: string;
}

@doc("Instruction Info Model")
model InstructionInfo {
  @doc("The instruction identifier.")
  instructionId: string;

  @doc("The instruction version.")
  version: string;

  @doc("The instruction status.")
  status: InstructionStatusEnum;
}

@doc("Instruction Patch Request")
model InstructionPatchRequest {
  @doc("The instruction status.")
  status: InstructionStatusEnum;
}

@doc("Instruction Request Model List")
model InstructionRequestModelList {
  @doc("The list of instruction request models.")
  instructionRequestModels: InstructionRequestModel[];
}

@doc("This is the response model for Instruction")
@parentResource(BaseInstructionModel)
model InstructionResponseModel {
  @doc("The administrative information of the instruction.")
  administrative: string;
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
  semanticContent: string;
}

@resource("instruction")
@doc("This is the request model for Instruction")
model Instruction {
  @key("id")
  @visibility(Lifecyle.Read)
  @doc("Id for the instruction")
  id: string;

  @doc("intruction Id for the instruction")
  @visibility("update")
  instructionId: string;

  @doc("Version for the instruction")
  @visibility("update")
  instructionVersion: string;

  @doc("Status for the instruction")
  @visibility(Lifecyle.Read)
  status: InstructionStatusEnum;

  @doc("Domain for the instruction")
  @visibility(Lifecyle.Read)
  domain: InstrustionDomainEnum;

  @doc("Sub-domain for the instruction")
  @visibility(Lifecyle.Read)
  subDomain: InstructionSubDomainEnum;

  @doc("Category for the instruction")
  @visibility(Lifecyle.Read)
  category: InstructionCategoryEnum;

  @doc("The language of the instruction.")
  language: InstructionLanguageEnum;

  @doc("The retrieval properties of the instruction.")
  retrieval: RetrievalProperties;

  @doc("The relationships of the instruction.")
  relationships: Relationships;

  @doc("The comment for the instruction.")
  comment: string;
}

@doc("This is the patch request to update the status of instruction")
model UpdateStatusRequest {
  @doc("status of the instruction")
  status: InstructionStatusEnum;
}
