import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

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
}
