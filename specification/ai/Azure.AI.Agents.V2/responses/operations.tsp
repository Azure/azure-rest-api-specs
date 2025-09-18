import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/**Creates a model response. Provide [text](https://platform.openai.com/docs/guides/text) or
[image](https://platform.openai.com/docs/guides/images) inputs to generate [text](https://platform.openai.com/docs/guides/text)
or [JSON](https://platform.openai.com/docs/guides/structured-outputs) outputs. Have the model call
your own [custom code](https://platform.openai.com/docs/guides/function-calling) or use built-in
[tools](https://platform.openai.com/docs/guides/tools) like [web search](https://platform.openai.com/docs/guides/tools-web-search)
or [file search](https://platform.openai.com/docs/guides/tools-file-search) to use your own data
as input for the model's response.*/
@summary("Create a model response")
@post
@route("/responses")
@extension(
  "x-oaiMeta",
  #{
    name: "Create a model response",
    group: "responses",
    returns: "Returns a [Response](https://platform.openai.com/docs/api-reference/responses/object) object.\n",
    path: "create",
    examples: #[
      #{
        title: "Text input",
        request: #{
          curl: "curl https://api.openai.com/v1/responses \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-4.1\",\n    \"input\": \"Tell me a three sentence bedtime story about a unicorn.\"\n  }'\n",
          javascript: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nconst response = await openai.responses.create({\n    model: \"gpt-4.1\",\n    input: \"Tell me a three sentence bedtime story about a unicorn.\"\n});\n\nconsole.log(response);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.create()\nprint(response.id)",
          csharp: "using System;\nusing OpenAI.Responses;\n\nOpenAIResponseClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nOpenAIResponse response = client.CreateResponse(\"Tell me a three sentence bedtime story about a unicorn.\");\n\nConsole.WriteLine(response.GetOutputText());\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.create();\n\nconsole.log(response.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.create\n\nputs(response)",
        },
        response: "{\n  \"id\": \"resp_67ccd2bed1ec8190b14f964abc0542670bb6a6b452d3795b\",\n  \"object\": \"response\",\n  \"created_at\": 1741476542,\n  \"status\": \"completed\",\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"model\": \"gpt-4.1-2025-04-14\",\n  \"output\": [\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_67ccd2bf17f0819081ff3bb2cf6508e60bb6a6b452d3795b\",\n      \"status\": \"completed\",\n      \"role\": \"assistant\",\n      \"content\": [\n        {\n          \"type\": \"output_text\",\n          \"text\": \"In a peaceful grove beneath a silver moon, a unicorn named Lumina discovered a hidden pool that reflected the stars. As she dipped her horn into the water, the pool began to shimmer, revealing a pathway to a magical realm of endless night skies. Filled with wonder, Lumina whispered a wish for all who dream to find their own hidden magic, and as she glanced back, her hoofprints sparkled like stardust.\",\n          \"annotations\": []\n        }\n      ]\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": null,\n    \"summary\": null\n  },\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [],\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 36,\n    \"input_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"output_tokens\": 87,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 0\n    },\n    \"total_tokens\": 123\n  },\n  \"user\": null,\n  \"metadata\": {}\n}\n",
      },
      #{
        title: "Image input",
        request: #{
          curl: "curl https://api.openai.com/v1/responses \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-4.1\",\n    \"input\": [\n      {\n        \"role\": \"user\",\n        \"content\": [\n          {\"type\": \"input_text\", \"text\": \"what is in this image?\"},\n          {\n            \"type\": \"input_image\",\n            \"image_url\": \"https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg\"\n          }\n        ]\n      }\n    ]\n  }'\n",
          javascript: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nconst response = await openai.responses.create({\n    model: \"gpt-4.1\",\n    input: [\n        {\n            role: \"user\",\n            content: [\n                { type: \"input_text\", text: \"what is in this image?\" },\n                {\n                    type: \"input_image\",\n                    image_url:\n                        \"https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg\",\n                },\n            ],\n        },\n    ],\n});\n\nconsole.log(response);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.create()\nprint(response.id)",
          csharp: "using System;\nusing System.Collections.Generic;\n\nusing OpenAI.Responses;\n\nOpenAIResponseClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nList<ResponseItem> inputItems =\n[\n    ResponseItem.CreateUserMessageItem(\n        [\n            ResponseContentPart.CreateInputTextPart(\"What is in this image?\"),\n            ResponseContentPart.CreateInputImagePart(new Uri(\"https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg\"))\n        ]\n    )\n];\n\nOpenAIResponse response = client.CreateResponse(inputItems);\n\nConsole.WriteLine(response.GetOutputText());\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.create();\n\nconsole.log(response.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.create\n\nputs(response)",
        },
        response: "{\n  \"id\": \"resp_67ccd3a9da748190baa7f1570fe91ac604becb25c45c1d41\",\n  \"object\": \"response\",\n  \"created_at\": 1741476777,\n  \"status\": \"completed\",\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"model\": \"gpt-4.1-2025-04-14\",\n  \"output\": [\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_67ccd3acc8d48190a77525dc6de64b4104becb25c45c1d41\",\n      \"status\": \"completed\",\n      \"role\": \"assistant\",\n      \"content\": [\n        {\n          \"type\": \"output_text\",\n          \"text\": \"The image depicts a scenic landscape with a wooden boardwalk or pathway leading through lush, green grass under a blue sky with some clouds. The setting suggests a peaceful natural area, possibly a park or nature reserve. There are trees and shrubs in the background.\",\n          \"annotations\": []\n        }\n      ]\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": null,\n    \"summary\": null\n  },\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [],\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 328,\n    \"input_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"output_tokens\": 52,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 0\n    },\n    \"total_tokens\": 380\n  },\n  \"user\": null,\n  \"metadata\": {}\n}\n",
      },
      #{
        title: "File input",
        request: #{
          curl: "curl https://api.openai.com/v1/responses \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-4.1\",\n    \"input\": [\n      {\n        \"role\": \"user\",\n        \"content\": [\n          {\"type\": \"input_text\", \"text\": \"what is in this file?\"},\n          {\n            \"type\": \"input_file\",\n            \"file_url\": \"https://www.berkshirehathaway.com/letters/2024ltr.pdf\"\n          }\n        ]\n      }\n    ]\n  }'\n",
          javascript: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nconst response = await openai.responses.create({\n    model: \"gpt-4.1\",\n    input: [\n        {\n            role: \"user\",\n            content: [\n                { type: \"input_text\", text: \"what is in this file?\" },\n                {\n                    type: \"input_file\",\n                    file_url: \"https://www.berkshirehathaway.com/letters/2024ltr.pdf\",\n                },\n            ],\n        },\n    ],\n});\n\nconsole.log(response);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.create()\nprint(response.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.create();\n\nconsole.log(response.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.create\n\nputs(response)",
        },
        response: "{\n  \"id\": \"resp_686eef60237881a2bd1180bb8b13de430e34c516d176ff86\",\n  \"object\": \"response\",\n  \"created_at\": 1752100704,\n  \"status\": \"completed\",\n  \"background\": false,\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"max_tool_calls\": null,\n  \"model\": \"gpt-4.1-2025-04-14\",\n  \"output\": [\n    {\n      \"id\": \"msg_686eef60d3e081a29283bdcbc4322fd90e34c516d176ff86\",\n      \"type\": \"message\",\n      \"status\": \"completed\",\n      \"content\": [\n        {\n          \"type\": \"output_text\",\n          \"annotations\": [],\n          \"logprobs\": [],\n          \"text\": \"The file seems to contain excerpts from a letter to the shareholders of Berkshire Hathaway Inc., likely written by Warren Buffett. It covers several topics:\\n\\n1. **Communication Philosophy**: Buffett emphasizes the importance of transparency and candidness in reporting mistakes and successes to shareholders.\\n\\n2. **Mistakes and Learnings**: The letter acknowledges past mistakes in business assessments and management hires, highlighting the importance of correcting errors promptly.\\n\\n3. **CEO Succession**: Mention of Greg Abel stepping in as the new CEO and continuing the tradition of honest communication.\\n\\n4. **Pete Liegl Story**: A detailed account of acquiring Forest River and the relationship with its founder, highlighting trust and effective business decisions.\\n\\n5. **2024 Performance**: Overview of business performance, particularly in insurance and investment activities, with a focus on GEICO's improvement.\\n\\n6. **Tax Contributions**: Discussion of significant tax payments to the U.S. Treasury, credited to shareholders' reinvestments.\\n\\n7. **Investment Strategy**: A breakdown of Berkshire\\u2019s investments in both controlled subsidiaries and marketable equities, along with a focus on long-term holding strategies.\\n\\n8. **American Capitalism**: Reflections on America\\u2019s economic development and Berkshire\\u2019s role within it.\\n\\n9. **Property-Casualty Insurance**: Insights into the P/C insurance business model and its challenges and benefits.\\n\\n10. **Japanese Investments**: Information about Berkshire\\u2019s investments in Japanese companies and future plans.\\n\\n11. **Annual Meeting**: Details about the upcoming annual gathering in Omaha, including schedule changes and new book releases.\\n\\n12. **Personal Anecdotes**: Light-hearted stories about family and interactions, conveying Buffett's personable approach.\\n\\n13. **Financial Performance Data**: Tables comparing Berkshire\\u2019s annual performance to the S&P 500, showing impressive long-term gains.\\n\\nOverall, the letter reinforces Berkshire Hathaway's commitment to transparency, investment in both its businesses and the wider economy, and emphasizes strong leadership and prudent financial management.\"\n        }\n      ],\n      \"role\": \"assistant\"\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": null,\n    \"summary\": null\n  },\n  \"service_tier\": \"default\",\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [],\n  \"top_logprobs\": 0,\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 8438,\n    \"input_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"output_tokens\": 398,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 0\n    },\n    \"total_tokens\": 8836\n  },\n  \"user\": null,\n  \"metadata\": {}\n}\n",
      },
      #{
        title: "Web search",
        request: #{
          curl: "curl https://api.openai.com/v1/responses \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-4.1\",\n    \"tools\": [{ \"type\": \"web_search_preview\" }],\n    \"input\": \"What was a positive news story from today?\"\n  }'\n",
          javascript: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nconst response = await openai.responses.create({\n    model: \"gpt-4.1\",\n    tools: [{ type: \"web_search_preview\" }],\n    input: \"What was a positive news story from today?\",\n});\n\nconsole.log(response);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.create()\nprint(response.id)",
          csharp: "using System;\n\nusing OpenAI.Responses;\n\nOpenAIResponseClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nstring userInputText = \"What was a positive news story from today?\";\n\nResponseCreationOptions options = new()\n{\n    Tools =\n    {\n        ResponseTool.CreateWebSearchTool()\n    },\n};\n\nOpenAIResponse response = client.CreateResponse(userInputText, options);\n\nConsole.WriteLine(response.GetOutputText());\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.create();\n\nconsole.log(response.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.create\n\nputs(response)",
        },
        response: "{\n  \"id\": \"resp_67ccf18ef5fc8190b16dbee19bc54e5f087bb177ab789d5c\",\n  \"object\": \"response\",\n  \"created_at\": 1741484430,\n  \"status\": \"completed\",\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"model\": \"gpt-4.1-2025-04-14\",\n  \"output\": [\n    {\n      \"type\": \"web_search_call\",\n      \"id\": \"ws_67ccf18f64008190a39b619f4c8455ef087bb177ab789d5c\",\n      \"status\": \"completed\"\n    },\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_67ccf190ca3881909d433c50b1f6357e087bb177ab789d5c\",\n      \"status\": \"completed\",\n      \"role\": \"assistant\",\n      \"content\": [\n        {\n          \"type\": \"output_text\",\n          \"text\": \"As of today, March 9, 2025, one notable positive news story...\",\n          \"annotations\": [\n            {\n              \"type\": \"url_citation\",\n              \"start_index\": 442,\n              \"end_index\": 557,\n              \"url\": \"https://.../?utm_source=chatgpt.com\",\n              \"title\": \"...\"\n            },\n            {\n              \"type\": \"url_citation\",\n              \"start_index\": 962,\n              \"end_index\": 1077,\n              \"url\": \"https://.../?utm_source=chatgpt.com\",\n              \"title\": \"...\"\n            },\n            {\n              \"type\": \"url_citation\",\n              \"start_index\": 1336,\n              \"end_index\": 1451,\n              \"url\": \"https://.../?utm_source=chatgpt.com\",\n              \"title\": \"...\"\n            }\n          ]\n        }\n      ]\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": null,\n    \"summary\": null\n  },\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [\n    {\n      \"type\": \"web_search_preview\",\n      \"domains\": [],\n      \"search_context_size\": \"medium\",\n      \"user_location\": {\n        \"type\": \"approximate\",\n        \"city\": null,\n        \"country\": \"US\",\n        \"region\": null,\n        \"timezone\": null\n      }\n    }\n  ],\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 328,\n    \"input_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"output_tokens\": 356,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 0\n    },\n    \"total_tokens\": 684\n  },\n  \"user\": null,\n  \"metadata\": {}\n}\n",
      },
      #{
        title: "File search",
        request: #{
          curl: "curl https://api.openai.com/v1/responses \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-4.1\",\n    \"tools\": [{\n      \"type\": \"file_search\",\n      \"vector_store_ids\": [\"vs_1234567890\"],\n      \"max_num_results\": 20\n    }],\n    \"input\": \"What are the attributes of an ancient brown dragon?\"\n  }'\n",
          javascript: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nconst response = await openai.responses.create({\n    model: \"gpt-4.1\",\n    tools: [{\n      type: \"file_search\",\n      vector_store_ids: [\"vs_1234567890\"],\n      max_num_results: 20\n    }],\n    input: \"What are the attributes of an ancient brown dragon?\",\n});\n\nconsole.log(response);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.create()\nprint(response.id)",
          csharp: "using System;\n\nusing OpenAI.Responses;\n\nOpenAIResponseClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nstring userInputText = \"What are the attributes of an ancient brown dragon?\";\n\nResponseCreationOptions options = new()\n{\n    Tools =\n    {\n        ResponseTool.CreateFileSearchTool(\n            vectorStoreIds: [\"vs_1234567890\"],\n            maxResultCount: 20\n        )\n    },\n};\n\nOpenAIResponse response = client.CreateResponse(userInputText, options);\n\nConsole.WriteLine(response.GetOutputText());\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.create();\n\nconsole.log(response.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.create\n\nputs(response)",
        },
        response: "{\n  \"id\": \"resp_67ccf4c55fc48190b71bd0463ad3306d09504fb6872380d7\",\n  \"object\": \"response\",\n  \"created_at\": 1741485253,\n  \"status\": \"completed\",\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"model\": \"gpt-4.1-2025-04-14\",\n  \"output\": [\n    {\n      \"type\": \"file_search_call\",\n      \"id\": \"fs_67ccf4c63cd08190887ef6464ba5681609504fb6872380d7\",\n      \"status\": \"completed\",\n      \"queries\": [\n        \"attributes of an ancient brown dragon\"\n      ],\n      \"results\": null\n    },\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_67ccf4c93e5c81909d595b369351a9d309504fb6872380d7\",\n      \"status\": \"completed\",\n      \"role\": \"assistant\",\n      \"content\": [\n        {\n          \"type\": \"output_text\",\n          \"text\": \"The attributes of an ancient brown dragon include...\",\n          \"annotations\": [\n            {\n              \"type\": \"file_citation\",\n              \"index\": 320,\n              \"file_id\": \"file-4wDz5b167pAf72nx1h9eiN\",\n              \"filename\": \"dragons.pdf\"\n            },\n            {\n              \"type\": \"file_citation\",\n              \"index\": 576,\n              \"file_id\": \"file-4wDz5b167pAf72nx1h9eiN\",\n              \"filename\": \"dragons.pdf\"\n            },\n            {\n              \"type\": \"file_citation\",\n              \"index\": 815,\n              \"file_id\": \"file-4wDz5b167pAf72nx1h9eiN\",\n              \"filename\": \"dragons.pdf\"\n            },\n            {\n              \"type\": \"file_citation\",\n              \"index\": 815,\n              \"file_id\": \"file-4wDz5b167pAf72nx1h9eiN\",\n              \"filename\": \"dragons.pdf\"\n            },\n            {\n              \"type\": \"file_citation\",\n              \"index\": 1030,\n              \"file_id\": \"file-4wDz5b167pAf72nx1h9eiN\",\n              \"filename\": \"dragons.pdf\"\n            },\n            {\n              \"type\": \"file_citation\",\n              \"index\": 1030,\n              \"file_id\": \"file-4wDz5b167pAf72nx1h9eiN\",\n              \"filename\": \"dragons.pdf\"\n            },\n            {\n              \"type\": \"file_citation\",\n              \"index\": 1156,\n              \"file_id\": \"file-4wDz5b167pAf72nx1h9eiN\",\n              \"filename\": \"dragons.pdf\"\n            },\n            {\n              \"type\": \"file_citation\",\n              \"index\": 1225,\n              \"file_id\": \"file-4wDz5b167pAf72nx1h9eiN\",\n              \"filename\": \"dragons.pdf\"\n            }\n          ]\n        }\n      ]\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": null,\n    \"summary\": null\n  },\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [\n    {\n      \"type\": \"file_search\",\n      \"filters\": null,\n      \"max_num_results\": 20,\n      \"ranking_options\": {\n        \"ranker\": \"auto\",\n        \"score_threshold\": 0.0\n      },\n      \"vector_store_ids\": [\n        \"vs_1234567890\"\n      ]\n    }\n  ],\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 18307,\n    \"input_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"output_tokens\": 348,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 0\n    },\n    \"total_tokens\": 18655\n  },\n  \"user\": null,\n  \"metadata\": {}\n}      \n",
      },
      #{
        title: "Streaming",
        request: #{
          curl: "curl https://api.openai.com/v1/responses \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-4.1\",\n    \"instructions\": \"You are a helpful assistant.\",\n    \"input\": \"Hello!\",\n    \"stream\": true\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.create()\nprint(response.id)",
          javascript: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nconst response = await openai.responses.create({\n    model: \"gpt-4.1\",\n    instructions: \"You are a helpful assistant.\",\n    input: \"Hello!\",\n    stream: true,\n});\n\nfor await (const event of response) {\n    console.log(event);\n}\n",
          csharp: "using System;\nusing System.ClientModel;\nusing System.Threading.Tasks;\n\nusing OpenAI.Responses;\n\nOpenAIResponseClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nstring userInputText = \"Hello!\";\n\nResponseCreationOptions options = new()\n{\n    Instructions = \"You are a helpful assistant.\",\n};\n\nAsyncCollectionResult<StreamingResponseUpdate> responseUpdates = client.CreateResponseStreamingAsync(userInputText, options);\n\nawait foreach (StreamingResponseUpdate responseUpdate in responseUpdates)\n{\n    if (responseUpdate is StreamingResponseOutputTextDeltaUpdate outputTextDeltaUpdate)\n    {\n        Console.Write(outputTextDeltaUpdate.Delta);\n    }\n}\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.create();\n\nconsole.log(response.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.create\n\nputs(response)",
        },
        response: "event: response.created\ndata: {\"type\":\"response.created\",\"response\":{\"id\":\"resp_67c9fdcecf488190bdd9a0409de3a1ec07b8b0ad4e5eb654\",\"object\":\"response\",\"created_at\":1741290958,\"status\":\"in_progress\",\"error\":null,\"incomplete_details\":null,\"instructions\":\"You are a helpful assistant.\",\"max_output_tokens\":null,\"model\":\"gpt-4.1-2025-04-14\",\"output\":[],\"parallel_tool_calls\":true,\"previous_response_id\":null,\"reasoning\":{\"effort\":null,\"summary\":null},\"store\":true,\"temperature\":1.0,\"text\":{\"format\":{\"type\":\"text\"}},\"tool_choice\":\"auto\",\"tools\":[],\"top_p\":1.0,\"truncation\":\"disabled\",\"usage\":null,\"user\":null,\"metadata\":{}}}\n\nevent: response.in_progress\ndata: {\"type\":\"response.in_progress\",\"response\":{\"id\":\"resp_67c9fdcecf488190bdd9a0409de3a1ec07b8b0ad4e5eb654\",\"object\":\"response\",\"created_at\":1741290958,\"status\":\"in_progress\",\"error\":null,\"incomplete_details\":null,\"instructions\":\"You are a helpful assistant.\",\"max_output_tokens\":null,\"model\":\"gpt-4.1-2025-04-14\",\"output\":[],\"parallel_tool_calls\":true,\"previous_response_id\":null,\"reasoning\":{\"effort\":null,\"summary\":null},\"store\":true,\"temperature\":1.0,\"text\":{\"format\":{\"type\":\"text\"}},\"tool_choice\":\"auto\",\"tools\":[],\"top_p\":1.0,\"truncation\":\"disabled\",\"usage\":null,\"user\":null,\"metadata\":{}}}\n\nevent: response.output_item.added\ndata: {\"type\":\"response.output_item.added\",\"output_index\":0,\"item\":{\"id\":\"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654\",\"type\":\"message\",\"status\":\"in_progress\",\"role\":\"assistant\",\"content\":[]}}\n\nevent: response.content_part.added\ndata: {\"type\":\"response.content_part.added\",\"item_id\":\"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654\",\"output_index\":0,\"content_index\":0,\"part\":{\"type\":\"output_text\",\"text\":\"\",\"annotations\":[]}}\n\nevent: response.output_text.delta\ndata: {\"type\":\"response.output_text.delta\",\"item_id\":\"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654\",\"output_index\":0,\"content_index\":0,\"delta\":\"Hi\"}\n\n...\n\nevent: response.output_text.done\ndata: {\"type\":\"response.output_text.done\",\"item_id\":\"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654\",\"output_index\":0,\"content_index\":0,\"text\":\"Hi there! How can I assist you today?\"}\n\nevent: response.content_part.done\ndata: {\"type\":\"response.content_part.done\",\"item_id\":\"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654\",\"output_index\":0,\"content_index\":0,\"part\":{\"type\":\"output_text\",\"text\":\"Hi there! How can I assist you today?\",\"annotations\":[]}}\n\nevent: response.output_item.done\ndata: {\"type\":\"response.output_item.done\",\"output_index\":0,\"item\":{\"id\":\"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654\",\"type\":\"message\",\"status\":\"completed\",\"role\":\"assistant\",\"content\":[{\"type\":\"output_text\",\"text\":\"Hi there! How can I assist you today?\",\"annotations\":[]}]}}\n\nevent: response.completed\ndata: {\"type\":\"response.completed\",\"response\":{\"id\":\"resp_67c9fdcecf488190bdd9a0409de3a1ec07b8b0ad4e5eb654\",\"object\":\"response\",\"created_at\":1741290958,\"status\":\"completed\",\"error\":null,\"incomplete_details\":null,\"instructions\":\"You are a helpful assistant.\",\"max_output_tokens\":null,\"model\":\"gpt-4.1-2025-04-14\",\"output\":[{\"id\":\"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654\",\"type\":\"message\",\"status\":\"completed\",\"role\":\"assistant\",\"content\":[{\"type\":\"output_text\",\"text\":\"Hi there! How can I assist you today?\",\"annotations\":[]}]}],\"parallel_tool_calls\":true,\"previous_response_id\":null,\"reasoning\":{\"effort\":null,\"summary\":null},\"store\":true,\"temperature\":1.0,\"text\":{\"format\":{\"type\":\"text\"}},\"tool_choice\":\"auto\",\"tools\":[],\"top_p\":1.0,\"truncation\":\"disabled\",\"usage\":{\"input_tokens\":37,\"output_tokens\":11,\"output_tokens_details\":{\"reasoning_tokens\":0},\"total_tokens\":48},\"user\":null,\"metadata\":{}}}\n",
      },
      #{
        title: "Functions",
        request: #{
          curl: "curl https://api.openai.com/v1/responses \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-4.1\",\n    \"input\": \"What is the weather like in Boston today?\",\n    \"tools\": [\n      {\n        \"type\": \"function\",\n        \"name\": \"get_current_weather\",\n        \"description\": \"Get the current weather in a given location\",\n        \"parameters\": {\n          \"type\": \"object\",\n          \"properties\": {\n            \"location\": {\n              \"type\": \"string\",\n              \"description\": \"The city and state, e.g. San Francisco, CA\"\n            },\n            \"unit\": {\n              \"type\": \"string\",\n              \"enum\": [\"celsius\", \"fahrenheit\"]\n            }\n          },\n          \"required\": [\"location\", \"unit\"]\n        }\n      }\n    ],\n    \"tool_choice\": \"auto\"\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.create()\nprint(response.id)",
          javascript: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nconst tools = [\n    {\n        type: \"function\",\n        name: \"get_current_weather\",\n        description: \"Get the current weather in a given location\",\n        parameters: {\n            type: \"object\",\n            properties: {\n                location: {\n                    type: \"string\",\n                    description: \"The city and state, e.g. San Francisco, CA\",\n                },\n                unit: { type: \"string\", enum: [\"celsius\", \"fahrenheit\"] },\n            },\n            required: [\"location\", \"unit\"],\n        },\n    },\n];\n\nconst response = await openai.responses.create({\n    model: \"gpt-4.1\",\n    tools: tools,\n    input: \"What is the weather like in Boston today?\",\n    tool_choice: \"auto\",\n});\n\nconsole.log(response);\n",
          csharp: "using System;\nusing OpenAI.Responses;\n\nOpenAIResponseClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nResponseTool getCurrentWeatherFunctionTool = ResponseTool.CreateFunctionTool(\n    functionName: \"get_current_weather\",\n    functionDescription: \"Get the current weather in a given location\",\n    functionParameters: BinaryData.FromString(\"\"\"\n        {\n            \"type\": \"object\",\n            \"properties\": {\n                \"location\": {\n                    \"type\": \"string\",\n                    \"description\": \"The city and state, e.g. San Francisco, CA\"\n                },\n                \"unit\": {\"type\": \"string\", \"enum\": [\"celsius\", \"fahrenheit\"]}\n            },\n            \"required\": [\"location\", \"unit\"]\n        }\n        \"\"\"\n    )\n);\n\nstring userInputText = \"What is the weather like in Boston today?\";\n\nResponseCreationOptions options = new()\n{\n    Tools =\n    {\n        getCurrentWeatherFunctionTool\n    },\n    ToolChoice = ResponseToolChoice.CreateAutoChoice(),\n};\n\nOpenAIResponse response = client.CreateResponse(userInputText, options);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.create();\n\nconsole.log(response.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.create\n\nputs(response)",
        },
        response: "{\n  \"id\": \"resp_67ca09c5efe0819096d0511c92b8c890096610f474011cc0\",\n  \"object\": \"response\",\n  \"created_at\": 1741294021,\n  \"status\": \"completed\",\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"model\": \"gpt-4.1-2025-04-14\",\n  \"output\": [\n    {\n      \"type\": \"function_call\",\n      \"id\": \"fc_67ca09c6bedc8190a7abfec07b1a1332096610f474011cc0\",\n      \"call_id\": \"call_unLAR8MvFNptuiZK6K6HCy5k\",\n      \"name\": \"get_current_weather\",\n      \"arguments\": \"{\\\"location\\\":\\\"Boston, MA\\\",\\\"unit\\\":\\\"celsius\\\"}\",\n      \"status\": \"completed\"\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": null,\n    \"summary\": null\n  },\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [\n    {\n      \"type\": \"function\",\n      \"description\": \"Get the current weather in a given location\",\n      \"name\": \"get_current_weather\",\n      \"parameters\": {\n        \"type\": \"object\",\n        \"properties\": {\n          \"location\": {\n            \"type\": \"string\",\n            \"description\": \"The city and state, e.g. San Francisco, CA\"\n          },\n          \"unit\": {\n            \"type\": \"string\",\n            \"enum\": [\n              \"celsius\",\n              \"fahrenheit\"\n            ]\n          }\n        },\n        \"required\": [\n          \"location\",\n          \"unit\"\n        ]\n      },\n      \"strict\": true\n    }\n  ],\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 291,\n    \"output_tokens\": 23,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 0\n    },\n    \"total_tokens\": 314\n  },\n  \"user\": null,\n  \"metadata\": {}\n}\n",
      },
      #{
        title: "Reasoning",
        request: #{
          curl: "curl https://api.openai.com/v1/responses \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"o3-mini\",\n    \"input\": \"How much wood would a woodchuck chuck?\",\n    \"reasoning\": {\n      \"effort\": \"high\"\n    }\n  }'\n",
          javascript: "import OpenAI from \"openai\";\nconst openai = new OpenAI();\n\nconst response = await openai.responses.create({\n    model: \"o3-mini\",\n    input: \"How much wood would a woodchuck chuck?\",\n    reasoning: {\n      effort: \"high\"\n    }\n});\n\nconsole.log(response);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.create()\nprint(response.id)",
          csharp: "using System;\nusing OpenAI.Responses;\n\nOpenAIResponseClient client = new(\n    model: \"o3-mini\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nstring userInputText = \"How much wood would a woodchuck chuck?\";\n\nResponseCreationOptions options = new()\n{\n    ReasoningOptions = new()\n    {\n        ReasoningEffortLevel = ResponseReasoningEffortLevel.High,\n    },\n};\n\nOpenAIResponse response = client.CreateResponse(userInputText, options);\n\nConsole.WriteLine(response.GetOutputText());\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.create();\n\nconsole.log(response.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.create\n\nputs(response)",
        },
        response: "{\n  \"id\": \"resp_67ccd7eca01881908ff0b5146584e408072912b2993db808\",\n  \"object\": \"response\",\n  \"created_at\": 1741477868,\n  \"status\": \"completed\",\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"model\": \"o1-2024-12-17\",\n  \"output\": [\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_67ccd7f7b5848190a6f3e95d809f6b44072912b2993db808\",\n      \"status\": \"completed\",\n      \"role\": \"assistant\",\n      \"content\": [\n        {\n          \"type\": \"output_text\",\n          \"text\": \"The classic tongue twister...\",\n          \"annotations\": []\n        }\n      ]\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": \"high\",\n    \"summary\": null\n  },\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [],\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 81,\n    \"input_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"output_tokens\": 1035,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 832\n    },\n    \"total_tokens\": 1116\n  },\n  \"user\": null,\n  \"metadata\": {}\n}\n",
      }
    ],
  }
)
@tag("Responses")
op createResponse(
  @body
  body: CreateResponse,
): Response | {
  @header
  contentType: "text/event-stream";

  @body
  body: ResponseStreamEvent;
};

/** Deletes a model response with the given ID. */
@summary("Delete a model response")
@delete
@route("/responses/{response_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete a model response",
    group: "responses",
    returns: "A success message.\n",
    examples: #{
      response: "{\n  \"id\": \"resp_6786a1bec27481909a17d673315b29f6\",\n  \"object\": \"response\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/responses/resp_123 \\\n    -H \"Content-Type: application/json\" \\\n    -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst response = await client.responses.delete(\"resp_123\");\nconsole.log(response);\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nclient.responses.delete(\n    \"resp_677efb5139a88190b512bc3fef8e535d\",\n)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nawait client.responses.delete('resp_677efb5139a88190b512bc3fef8e535d');",
        go: "package main\n\nimport (\n  \"context\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  err := client.Responses.Delete(context.TODO(), \"resp_677efb5139a88190b512bc3fef8e535d\")\n  if err != nil {\n    panic(err.Error())\n  }\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.ResponseDeleteParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        client.responses().delete(\"resp_677efb5139a88190b512bc3fef8e535d\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresult = openai.responses.delete(\"resp_677efb5139a88190b512bc3fef8e535d\")\n\nputs(result)",
      },
    },
  }
)
@tag("Responses")
op deleteResponse(
  /** The ID of the response to delete. */
  @path
  response_id: string,
): OkResponse | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 404;

  code: string | null;
  message: string;
  param: string | null;
  type: string;
};

/** Retrieves a model response with the given ID. */
@summary("Get a model response")
@get
@route("/responses/{response_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Get a model response",
    group: "responses",
    returns: "The [Response](https://platform.openai.com/docs/api-reference/responses/object) object matching the\nspecified ID.\n",
    examples: #{
      response: "{\n  \"id\": \"resp_67cb71b351908190a308f3859487620d06981a8637e6bc44\",\n  \"object\": \"response\",\n  \"created_at\": 1741386163,\n  \"status\": \"completed\",\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"model\": \"gpt-4o-2024-08-06\",\n  \"output\": [\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_67cb71b3c2b0819084d481baaaf148f206981a8637e6bc44\",\n      \"status\": \"completed\",\n      \"role\": \"assistant\",\n      \"content\": [\n        {\n          \"type\": \"output_text\",\n          \"text\": \"Silent circuits hum,  \\nThoughts emerge in data streams—  \\nDigital dawn breaks.\",\n          \"annotations\": []\n        }\n      ]\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": null,\n    \"summary\": null\n  },\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [],\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 32,\n    \"input_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"output_tokens\": 18,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 0\n    },\n    \"total_tokens\": 50\n  },\n  \"user\": null,\n  \"metadata\": {}\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/responses/resp_123 \\\n    -H \"Content-Type: application/json\" \\\n    -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst response = await client.responses.retrieve(\"resp_123\");\nconsole.log(response);\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.retrieve(\n    response_id=\"resp_677efb5139a88190b512bc3fef8e535d\",\n)\nprint(response.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.retrieve('resp_677efb5139a88190b512bc3fef8e535d');\n\nconsole.log(response.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.Get(\n    context.TODO(),\n    \"resp_677efb5139a88190b512bc3fef8e535d\",\n    responses.ResponseGetParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().retrieve(\"resp_677efb5139a88190b512bc3fef8e535d\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.retrieve(\"resp_677efb5139a88190b512bc3fef8e535d\")\n\nputs(response)",
      },
    },
  }
)
@tag("Responses")
op getResponse(
  /** The ID of the response to retrieve. */
  @path
  response_id: string,

  /**Additional fields to include in the response. See the `include`
parameter for Response creation above for more information.*/
  @query(#{ explode: true })
  include?: Includable[],

  /**If set to true, the model response data will be streamed to the client
as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
See the [Streaming section below](https://platform.openai.com/docs/api-reference/responses-streaming)
for more information.*/
  @query(#{ explode: true })
  stream?: boolean,

  /** The sequence number of the event after which to start streaming. */
  @query(#{ explode: true })
  starting_after?: integer,

  /**When true, stream obfuscation will be enabled. Stream obfuscation adds
random characters to an `obfuscation` field on streaming delta events
to normalize payload sizes as a mitigation to certain side-channel
attacks. These obfuscation fields are included by default, but add a
small amount of overhead to the data stream. You can set
`include_obfuscation` to false to optimize for bandwidth if you trust
the network links between your application and the OpenAI API.*/
  @query(#{ explode: true })
  include_obfuscation?: boolean,
): Response;

/**Cancels a model response with the given ID. Only responses created with
the `background` parameter set to `true` can be cancelled.
[Learn more](https://platform.openai.com/docs/guides/background).*/
@summary("Cancel a response")
@post
@route("/responses/{response_id}/cancel")
@extension(
  "x-oaiMeta",
  #{
    name: "Cancel a response",
    group: "responses",
    returns: "A [Response](https://platform.openai.com/docs/api-reference/responses/object) object.\n",
    examples: #{
      response: "{\n  \"id\": \"resp_67cb71b351908190a308f3859487620d06981a8637e6bc44\",\n  \"object\": \"response\",\n  \"created_at\": 1741386163,\n  \"status\": \"completed\",\n  \"error\": null,\n  \"incomplete_details\": null,\n  \"instructions\": null,\n  \"max_output_tokens\": null,\n  \"model\": \"gpt-4o-2024-08-06\",\n  \"output\": [\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_67cb71b3c2b0819084d481baaaf148f206981a8637e6bc44\",\n      \"status\": \"completed\",\n      \"role\": \"assistant\",\n      \"content\": [\n        {\n          \"type\": \"output_text\",\n          \"text\": \"Silent circuits hum,  \\nThoughts emerge in data streams—  \\nDigital dawn breaks.\",\n          \"annotations\": []\n        }\n      ]\n    }\n  ],\n  \"parallel_tool_calls\": true,\n  \"previous_response_id\": null,\n  \"reasoning\": {\n    \"effort\": null,\n    \"summary\": null\n  },\n  \"store\": true,\n  \"temperature\": 1.0,\n  \"text\": {\n    \"format\": {\n      \"type\": \"text\"\n    }\n  },\n  \"tool_choice\": \"auto\",\n  \"tools\": [],\n  \"top_p\": 1.0,\n  \"truncation\": \"disabled\",\n  \"usage\": {\n    \"input_tokens\": 32,\n    \"input_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"output_tokens\": 18,\n    \"output_tokens_details\": {\n      \"reasoning_tokens\": 0\n    },\n    \"total_tokens\": 50\n  },\n  \"user\": null,\n  \"metadata\": {}\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/responses/resp_123/cancel \\\n    -H \"Content-Type: application/json\" \\\n    -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst response = await client.responses.cancel(\"resp_123\");\nconsole.log(response);  \n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.responses.cancel(\n    \"resp_677efb5139a88190b512bc3fef8e535d\",\n)\nprint(response.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.responses.cancel('resp_677efb5139a88190b512bc3fef8e535d');\n\nconsole.log(response.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Responses.Cancel(context.TODO(), \"resp_677efb5139a88190b512bc3fef8e535d\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.Response;\nimport com.openai.models.responses.ResponseCancelParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Response response = client.responses().cancel(\"resp_677efb5139a88190b512bc3fef8e535d\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.responses.cancel(\"resp_677efb5139a88190b512bc3fef8e535d\")\n\nputs(response)",
      },
    },
  }
)
@tag("Responses")
op cancelResponse(
  /** The ID of the response to cancel. */
  @path
  response_id: string,
): Response | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 404;

  code: string | null;
  message: string;
  param: string | null;
  type: string;
};

/** Returns a list of input items for a given response. */
@summary("List input items")
@get
@route("/responses/{response_id}/input_items")
@extension(
  "x-oaiMeta",
  #{
    name: "List input items",
    group: "responses",
    returns: "A list of input item objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"msg_abc123\",\n      \"type\": \"message\",\n      \"role\": \"user\",\n      \"content\": [\n        {\n          \"type\": \"input_text\",\n          \"text\": \"Tell me a three sentence bedtime story about a unicorn.\"\n        }\n      ]\n    }\n  ],\n  \"first_id\": \"msg_abc123\",\n  \"last_id\": \"msg_abc123\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/responses/resp_abc123/input_items \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst response = await client.responses.inputItems.list(\"resp_123\");\nconsole.log(response.data);\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.responses.input_items.list(\n    response_id=\"response_id\",\n)\npage = page.data[0]\nprint(page)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const responseItem of client.responses.inputItems.list('response_id')) {\n  console.log(responseItem);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Responses.InputItems.List(\n    context.TODO(),\n    \"response_id\",\n    responses.InputItemListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.responses.inputitems.InputItemListPage;\nimport com.openai.models.responses.inputitems.InputItemListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        InputItemListPage page = client.responses().inputItems().list(\"response_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.responses.input_items.list(\"response_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Responses")
op listInputItems(
  /** The ID of the response to retrieve input items for. */
  @path
  response_id: string,

  /**A limit on the number of objects to be returned. Limit can range between
1 and 100, and the default is 20.*/
  @query(#{ explode: true })
  limit?: integer = 20,

  /**The order to return the input items in. Default is `desc`.
- `asc`: Return the input items in ascending order.
- `desc`: Return the input items in descending order.*/
  @query(#{ explode: true })
  order?: "asc" | "desc",

  /** An item ID to list items after, used in pagination. */
  @query(#{ explode: true })
  after?: string,

  /**Additional fields to include in the response. See the `include`
parameter for Response creation above for more information.*/
  @query(#{ explode: true })
  include?: Includable[],
): ResponseItemList;
