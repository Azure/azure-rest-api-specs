using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@doc("The properties of the Transparency Log resource type.")
@added(Versions.Preview20240331)
model TransparencyLogProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the Transparency Log.")
  provisioningState?: ResourceProvisioningState;

  @doc("Culture that will be used in email formatting.")
  @minItems(1)
  emailCultures: Culture[];

  @doc("The format of Transparency Log email attachments.")
  emailAttachmentFormat?: FileFormat;
}

@doc("Supported cultures.")
@added(Versions.Preview20240331)
union Culture {
  string,

  @doc("Czech (Czechia)")
  cs_CZ: "cs-CZ",

  @doc("German (Germany)")
  de_DE: "de-DE",

  @doc("English (United Kingdom)")
  en_GB: "en-GB",

  @doc("English (United States)")
  en_US: "en-US",

  @doc("Spanish (Spain)")
  es_ES: "es-ES",

  @doc("French (France)")
  fr_FR: "fr-FR",

  @doc("Hungarian (Hungary)")
  hu_HU: "hu-HU",

  @doc("Indonesian (Indonesia)")
  id_ID: "id-ID",

  @doc("Italian (Italy)")
  it_IT: "it-IT",

  @doc("Japanese (Japan)")
  ja_JP: "ja-JP",

  @doc("Korean (Korea)")
  ko_KR: "ko-KR",

  @doc("Dutch (Netherlands)")
  nl_NL: "nl-NL",

  @doc("Polish (Poland)")
  pl_PL: "pl-PL",

  @doc("Portuguese (Brazil)")
  pt_BR: "pt-BR",

  @doc("Portuguese (Portugal)")
  pt_PT: "pt-PT",

  @doc("Russian (Russia)")
  ru_RU: "ru-RU",

  @doc("Swedish (Sweden)")
  sv_SE: "sv-SE",

  @doc("Turkish (Türkiye)")
  tr_TR: "tr-TR",

  @doc("Chinese (Simplified)")
  zh_CN: "zh-CN",

  @doc("Chinese (Traditional)")
  zh_TW: "zh-TW",
}

@doc("Supported file formats.")
@added(Versions.Preview20240331)
union FileFormat {
  string,

  @doc("No file requested.")
  None: "None",

  @doc("Comma separated values.")
  CSV: "CSV",
}
