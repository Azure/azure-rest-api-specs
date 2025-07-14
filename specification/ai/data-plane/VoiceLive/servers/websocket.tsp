import "@typespec/http";

using TypeSpec.Http;

/** The OpenAI REST API. Please see https://platform.openai.com/docs/api-reference for more details. */
@service({
  title: "OpenAI API",
  termsOfService: "https://openai.com/policies/terms-of-use",
  contact: {
    name: "OpenAI Support",
    url: "https://help.openai.com",
  },
  license: {
    name: "MIT",
    url: "https://github.com/openai/openai-openapi/blob/master/LICENSE",
  },
})
@server("wss://api.openai.com/v1", "OpenAI Endpoint")
@useAuth(BearerAuth)
namespace OpenAI;
