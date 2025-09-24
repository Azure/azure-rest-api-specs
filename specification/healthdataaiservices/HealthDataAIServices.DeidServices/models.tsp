import "@typespec/versioning";

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI Casing style to match OpenAI"
namespace HealthDataAIServices.DeidServices;

@doc("Enum of supported Operation Types.")
union DeidentificationOperationType {
  @doc("Redact Operation will remove all entities of PHI and replace them with a placeholder value.")
  Redact: "Redact",

  @doc("Surrogation Operation will replace all entities of PHI with a surrogate value.")
  Surrogate: "Surrogate",

  @doc("Tag Operation will detect all entities of PHI, their type, and return their locations in the document.")
  Tag: "Tag",

  @doc("SurrogateOnly Operation will replace only specified entities of PHI with surrogate values.")
  @added(Versions.v2025_07_15_preview)
  SurrogateOnly: "SurrogateOnly",

  string,
}

@doc("Customizations options to override default service behaviors.")
model SharedCustomizationOptions {
  @maxLength(16)
  @minLength(1)
  @doc("""
    Format of the redacted output. Only valid when Operation is Redact. 
    Please refer to https://learn.microsoft.com/azure/healthcare-apis/deidentification/redaction-format for more details.
    """)
  redactionFormat?: string;

  @doc("Locale in which the output surrogates are written.")
  surrogateLocale?: string = "en-US";

  @doc("Locale of the input text. Used for better PHI detection. Defaults to 'en-US'.")
  @added(Versions.v2025_07_15_preview)
  inputLocale?: string = "en-US";
}
