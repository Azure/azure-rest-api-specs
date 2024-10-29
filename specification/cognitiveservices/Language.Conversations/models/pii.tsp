import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Conversations;

/** Text that has been categorized into pre-defined classes or types such as: person, location, event, product, and organization. */
@added(Versions.v2024_05_01)
model Entity {
  /** Entity text as appears in the request. */
  text: string;

  /** Entity type. */
  category: string;

  /** (Optional) Entity sub type. */
  subcategory?: string;

  /** Start position for the entity text. Use of different 'stringIndexType' values can affect the offset returned. */
  offset: int32;

  /** Length for the entity text. Use of different 'stringIndexType' values can affect the length returned. */
  length: int32;

  /** Confidence score between 0 and 1 of the extracted entity. */
  confidenceScore: float64;

  /** Exact mask text to mask the PII entity */
  @added(Versions.v2024_11_15_preview)
  mask?: string;

  /** Offset of the mask text */
  @added(Versions.v2024_11_15_preview)
  maskOffset?: int32;

  /** Length of the mask text */
  @added(Versions.v2024_11_15_preview)
  maskLength?: int32;
}

/** Result from the personally identifiable information detection and redaction operation performed on a list of conversations. */
@added(Versions.v2024_05_01)
model AnalyzeConversationConversationPiiResult
  extends AnalyzeConversationJobResult {
  /** discriminator kind */
  kind: AnalyzeConversationResultsKind.ConversationalPIIResults;

  /** results */
  results: ConversationPiiResults;
}

/** The result from PII detection and redaction operation for each conversation. */
@added(Versions.v2024_05_01)
model ConversationPiiResults is PreBuiltResult {
  /** array of conversations */
  conversations: Array<ConversationalPiiResultWithResultBase>;
}

/** Conversation PII result item */
@added(Versions.v2024_05_01)
model ConversationalPiiResultWithResultBase {
  ...ConversationResultBase;
  ...ConversationPiiResult;
}

/** The result from PII detection and redaction operation for each conversation. */
@added(Versions.v2024_05_01)
model ConversationPiiResult {
  /** List of conversationItems */
  conversationItems: Array<ConversationPiiItemResult>;
}

/** The result from PII detection and redaction operation for each conversation. */
@added(Versions.v2024_05_01)
model ConversationPiiItemResult {
  /** Id of the result */
  id: string;

  /** Transcript content response that the service generates, with all necessary personally identifiable information redacted. */
  redactedContent: RedactedTranscriptContent;

  /** Array of Entities */
  entities: Array<Entity>;
}

/** Task definition for a PII redaction in conversations. */
@added(Versions.v2024_05_01)
model AnalyzeConversationPiiTask extends AnalyzeConversationLROTask {
  /** discriminator kind */
  kind: AnalyzeConversationLROTaskKind.ConversationalPIITask;

  /** parameters */
  parameters?: ConversationPiiTaskParameters;
}

/** Supported parameters for a conversational pii task. */
@added(Versions.v2024_05_01)
model ConversationPiiTaskParameters is PreBuiltTaskParameters {
  /** Array of ConversationPIICategories */
  @added(Versions.v2024_05_01)
  piiCategories?: Array<ConversationPiiCategories>;

  /** Flag to indicate if response should include audio stream offset and duration for any detected entities to be redacted. By default, audio timing of redacted entities are not included. */
  redactAudioTiming?: boolean;

  /** For transcript conversations, this parameter provides information regarding which content type (ITN, Text, Lexical, Masked ITN) should be used for entity detection. The details of the entities detected - like the offset, length and the text itself - will correspond to the text type selected here. */
  @added(Versions.v2024_05_01)
  redactionSource?: TranscriptContentType;

  /** Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction. */
  @added(Versions.v2024_05_01)
  redactionCharacter?: redactionCharacter = redactionCharacter.asterisk;

  /** List of categories that need to be excluded instead of included. */
  @added(Versions.v2024_05_01)
  excludePiiCategories?: Array<ConversationPiiCategoriesExclude>;

  /** Optional parameter determine what type of redaction to use. */
  @added(Versions.v2024_11_15_preview)
  redactionPolicy?: BaseRedactionPolicy;
}

/** Kinds of redaction policies supported. */
@added(Versions.v2024_11_15_preview)
union RedactionPolicyKind {
  string,

  /** Do not mask detected entities */
  noMask: "noMask",

  /** Mask detected entities with redaction character */
  characterMask: "characterMask",

  /** Mask detected entities with entity type */
  entityMask: "entityMask",
}

/** The abstract base class for RedactionPolicy. */
@added(Versions.v2024_11_15_preview)
@discriminator("policyKind")
model BaseRedactionPolicy {
  /** The entity RedactionPolicy object kind. */
  policyKind: RedactionPolicyKind = RedactionPolicyKind.characterMask;
}

/** Represents the policy of masking with a redaction character */
@added(Versions.v2024_11_15_preview)
model CharacterMaskPolicyType extends BaseRedactionPolicy {
  /** The entity RedactionPolicy object kind. */
  policyKind: RedactionPolicyKind.characterMask;

  /** Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction. */
  redactionCharacter?: redactionCharacter = redactionCharacter.asterisk;
}

/** Represents the policy of not masking found PII. */
@added(Versions.v2024_11_15_preview)
model NoMaskPolicyType extends BaseRedactionPolicy {
  /** The entity RedactionPolicy object kind. */
  policyKind: RedactionPolicyKind.noMask;
}

/** Represents the policy of masking PII with the entity type. */
@added(Versions.v2024_11_15_preview)
model EntityMaskTypePolicyType extends BaseRedactionPolicy {
  /** The entity OverlapPolicy object kind. */
  policyKind: RedactionPolicyKind.entityMask;
}

/** Describes the PII categories to return for detection. If not provided, 'default' categories will be returned which will vary with the language. */
@added(Versions.v2024_05_01)
union ConversationPiiCategories {
  string,

  /** Address category */
  Address: "Address",

  /** Credit card number category */
  CreditCardNumber: "CreditCardNumber",

  /** Email category */
  Email: "Email",

  /** Person category */
  Person: "Person",

  /** Numeric identifier category */
  NumericIdentifier: "NumericIdentifier",

  /** Phone number category */
  PhoneNumber: "PhoneNumber",

  /** US social security number category */
  USSocialSecurityNumber: "USSocialSecurityNumber",

  /** Miscellaneous category */
  Miscellaneous: "Miscellaneous",

  /** All categories */
  All: "All",

  /** Default categories */
  Default: "Default",
}

/** Describes the PII categories to exclude for detection. If not provided, 'default' categories will be returned which will vary with the language. */
@added(Versions.v2024_05_01)
union ConversationPiiCategoriesExclude {
  string,

  /** Address category */
  Address: "Address",

  /** Credit card number category */
  CreditCardNumber: "CreditCardNumber",

  /** Email category */
  Email: "Email",

  /** Person category */
  Person: "Person",

  /** Numeric identifier category */
  NumericIdentifier: "NumericIdentifier",

  /** Phone number category */
  PhoneNumber: "PhoneNumber",

  /** US social security number category */
  USSocialSecurityNumber: "USSocialSecurityNumber",
}

/** Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction. */
union redactionCharacter {
  string,

  /** Exclamation point character */
  exclamationPoint: "!",

  /** Number sign character */
  numberSign: "#",

  /** Dollar sign character */
  dollar: "$",

  /** Percent sign character */
  perCent: "%",

  /** Ampersand character */
  ampersand: "&",

  /** Asterisk character */
  asterisk: "*",

  /** Plus sign character */
  plus: "+",

  /** Minus sign character */
  minus: "-",

  /** Equals sign character */
  equals: "=",

  /** Question mark character */
  questionMark: "?",

  /** At sign character */
  atSign: "@",

  /** Caret character */
  caret: "^",

  /** Underscore character */
  underscore: "_",

  /** Tilde character */
  tilde: "~",
}
