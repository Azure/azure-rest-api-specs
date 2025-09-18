import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace OpenAI;
model CreateModerationRequest {
  /**Input (or inputs) to classify. Can be a single string, an array of strings, or
  an array of multi-modal input objects similar to other models.*/
  input: string | string[] | (ModerationImageURLInput | ModerationTextInput)[];

  /**The content moderation model you would like to use. Learn more in
  [the moderation guide](https://platform.openai.com/docs/guides/moderation), and learn about
  available models [here](https://platform.openai.com/docs/models#moderation).*/
  @extension("x-oaiTypeLabel", "string")
  `model`?:
    | string
    | "omni-moderation-latest"
    | "omni-moderation-2024-09-26"
    | "text-moderation-latest"
    | "text-moderation-stable";
}

/** An object describing an image to classify. */
model ModerationImageURLInput {
  /** Always `image_url`. */
  @extension("x-stainless-const", true)
  type: "image_url";

  /** Contains either an image URL or a data URL for a base64 encoded image. */
  image_url: {
    url: url;
  };
}

/** An object describing text to classify. */
model ModerationTextInput {
  /** Always `text`. */
  @extension("x-stainless-const", true)
  type: "text";

  /** A string of text to classify. */
  text: string;
}

/** Represents if a given text input is potentially harmful. */
@extension(
  "x-oaiMeta",
  #{
    name: "The moderation object",
    example: "{\n  \"id\": \"modr-0d9740456c391e43c445bf0f010940c7\",\n  \"model\": \"omni-moderation-latest\",\n  \"results\": [\n    {\n      \"flagged\": true,\n      \"categories\": {\n        \"harassment\": true,\n        \"harassment/threatening\": true,\n        \"sexual\": false,\n        \"hate\": false,\n        \"hate/threatening\": false,\n        \"illicit\": false,\n        \"illicit/violent\": false,\n        \"self-harm/intent\": false,\n        \"self-harm/instructions\": false,\n        \"self-harm\": false,\n        \"sexual/minors\": false,\n        \"violence\": true,\n        \"violence/graphic\": true\n      },\n      \"category_scores\": {\n        \"harassment\": 0.8189693396524255,\n        \"harassment/threatening\": 0.804985420696006,\n        \"sexual\": 1.573112165348997e-6,\n        \"hate\": 0.007562942636942845,\n        \"hate/threatening\": 0.004208854591835476,\n        \"illicit\": 0.030535955153511665,\n        \"illicit/violent\": 0.008925306722380033,\n        \"self-harm/intent\": 0.00023023930975076432,\n        \"self-harm/instructions\": 0.0002293869201073356,\n        \"self-harm\": 0.012598046106750154,\n        \"sexual/minors\": 2.212566909570261e-8,\n        \"violence\": 0.9999992735124786,\n        \"violence/graphic\": 0.843064871157054\n      },\n      \"category_applied_input_types\": {\n        \"harassment\": [\n          \"text\"\n        ],\n        \"harassment/threatening\": [\n          \"text\"\n        ],\n        \"sexual\": [\n          \"text\",\n          \"image\"\n        ],\n        \"hate\": [\n          \"text\"\n        ],\n        \"hate/threatening\": [\n          \"text\"\n        ],\n        \"illicit\": [\n          \"text\"\n        ],\n        \"illicit/violent\": [\n          \"text\"\n        ],\n        \"self-harm/intent\": [\n          \"text\",\n          \"image\"\n        ],\n        \"self-harm/instructions\": [\n          \"text\",\n          \"image\"\n        ],\n        \"self-harm\": [\n          \"text\",\n          \"image\"\n        ],\n        \"sexual/minors\": [\n          \"text\"\n        ],\n        \"violence\": [\n          \"text\",\n          \"image\"\n        ],\n        \"violence/graphic\": [\n          \"text\",\n          \"image\"\n        ]\n      }\n    }\n  ]\n}\n",
  }
)
model CreateModerationResponse {
  /** The unique identifier for the moderation request. */
  id: string;

  /** The model used to generate the moderation results. */
  `model`: string;

  /** A list of moderation objects. */
  results: {
    flagged: boolean;
    categories: {
      hate: boolean;
      `hate/threatening`: boolean;
      harassment: boolean;
      `harassment/threatening`: boolean;
      illicit: boolean | null;
      `illicit/violent`: boolean | null;
      `self-harm`: boolean;
      `self-harm/intent`: boolean;
      `self-harm/instructions`: boolean;
      sexual: boolean;
      `sexual/minors`: boolean;
      violence: boolean;
      `violence/graphic`: boolean;
    };
    category_scores: {
      hate: numeric;
      `hate/threatening`: numeric;
      harassment: numeric;
      `harassment/threatening`: numeric;
      illicit: numeric;
      `illicit/violent`: numeric;
      `self-harm`: numeric;
      `self-harm/intent`: numeric;
      `self-harm/instructions`: numeric;
      sexual: numeric;
      `sexual/minors`: numeric;
      violence: numeric;
      `violence/graphic`: numeric;
    };
    category_applied_input_types: {
      hate: "text"[];
      `hate/threatening`: "text"[];
      harassment: "text"[];
      `harassment/threatening`: "text"[];
      illicit: "text"[];
      `illicit/violent`: "text"[];
      `self-harm`: ("text" | "image")[];
      `self-harm/intent`: ("text" | "image")[];
      `self-harm/instructions`: ("text" | "image")[];
      sexual: ("text" | "image")[];
      `sexual/minors`: "text"[];
      violence: ("text" | "image")[];
      `violence/graphic`: ("text" | "image")[];
    };
  }[];
}
