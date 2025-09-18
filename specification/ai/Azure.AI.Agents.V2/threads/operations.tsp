import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
import "../runs/models.tsp";
import "../messages/models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Create a thread. */
@summary("Create thread")
@post
@route("/threads")
@extension(
  "x-oaiMeta",
  #{
    name: "Create thread",
    group: "threads",
    beta: true,
    returns: "A [thread](https://platform.openai.com/docs/api-reference/threads) object.",
    examples: #[
      #{
        title: "Empty",
        request: #{
          curl: "curl https://api.openai.com/v1/threads \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d ''\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nthread = client.beta.threads.create()\nprint(thread.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst thread = await client.beta.threads.create();\n\nconsole.log(thread.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  thread, err := client.Beta.Threads.New(context.TODO(), openai.BetaThreadNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", thread.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.Thread;\nimport com.openai.models.beta.threads.ThreadCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Thread thread = client.beta().threads().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nthread = openai.beta.threads.create\n\nputs(thread)",
        },
        response: "{\n  \"id\": \"thread_abc123\",\n  \"object\": \"thread\",\n  \"created_at\": 1699012949,\n  \"metadata\": {},\n  \"tool_resources\": {}\n}\n",
      },
      #{
        title: "Messages",
        request: #{
          curl: "curl https://api.openai.com/v1/threads \\\n-H \"Content-Type: application/json\" \\\n-H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n-H \"OpenAI-Beta: assistants=v2\" \\\n-d '{\n    \"messages\": [{\n      \"role\": \"user\",\n      \"content\": \"Hello, what is AI?\"\n    }, {\n      \"role\": \"user\",\n      \"content\": \"How does AI work? Explain it in simple terms.\"\n    }]\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nthread = client.beta.threads.create()\nprint(thread.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst thread = await client.beta.threads.create();\n\nconsole.log(thread.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  thread, err := client.Beta.Threads.New(context.TODO(), openai.BetaThreadNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", thread.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.Thread;\nimport com.openai.models.beta.threads.ThreadCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Thread thread = client.beta().threads().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nthread = openai.beta.threads.create\n\nputs(thread)",
        },
        response: "{\n  \"id\": \"thread_abc123\",\n  \"object\": \"thread\",\n  \"created_at\": 1699014083,\n  \"metadata\": {},\n  \"tool_resources\": {}\n}\n",
      }
    ],
  }
)
@tag("Assistants")
op createThread(
  @body
  body: CreateThreadRequest,
): ThreadObject;

/** Create a thread and run it in one request. */
@summary("Create thread and run")
@post
@route("/threads/runs")
@extension(
  "x-oaiMeta",
  #{
    name: "Create thread and run",
    group: "threads",
    beta: true,
    returns: "A [run](https://platform.openai.com/docs/api-reference/runs/object) object.",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: "curl https://api.openai.com/v1/threads/runs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n      \"assistant_id\": \"asst_abc123\",\n      \"thread\": {\n        \"messages\": [\n          {\"role\": \"user\", \"content\": \"Explain deep learning to a 5 year old.\"}\n        ]\n      }\n    }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.create_and_run(\n    assistant_id=\"assistant_id\",\n)\nprint(run.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.createAndRun({ assistant_id: 'assistant_id' });\n\nconsole.log(run.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.NewAndRun(context.TODO(), openai.BetaThreadNewAndRunParams{\n    AssistantID: \"assistant_id\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.ThreadCreateAndRunParams;\nimport com.openai.models.beta.threads.runs.Run;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ThreadCreateAndRunParams params = ThreadCreateAndRunParams.builder()\n            .assistantId(\"assistant_id\")\n            .build();\n        Run run = client.beta().threads().createAndRun(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.create_and_run(assistant_id: \"assistant_id\")\n\nputs(run)",
        },
        response: "{\n  \"id\": \"run_abc123\",\n  \"object\": \"thread.run\",\n  \"created_at\": 1699076792,\n  \"assistant_id\": \"asst_abc123\",\n  \"thread_id\": \"thread_abc123\",\n  \"status\": \"queued\",\n  \"started_at\": null,\n  \"expires_at\": 1699077392,\n  \"cancelled_at\": null,\n  \"failed_at\": null,\n  \"completed_at\": null,\n  \"required_action\": null,\n  \"last_error\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": \"You are a helpful assistant.\",\n  \"tools\": [],\n  \"tool_resources\": {},\n  \"metadata\": {},\n  \"temperature\": 1.0,\n  \"top_p\": 1.0,\n  \"max_completion_tokens\": null,\n  \"max_prompt_tokens\": null,\n  \"truncation_strategy\": {\n    \"type\": \"auto\",\n    \"last_messages\": null\n  },\n  \"incomplete_details\": null,\n  \"usage\": null,\n  \"response_format\": \"auto\",\n  \"tool_choice\": \"auto\",\n  \"parallel_tool_calls\": true\n}\n",
      },
      #{
        title: "Streaming",
        request: #{
          curl: "curl https://api.openai.com/v1/threads/runs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"assistant_id\": \"asst_123\",\n    \"thread\": {\n      \"messages\": [\n        {\"role\": \"user\", \"content\": \"Hello\"}\n      ]\n    },\n    \"stream\": true\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.create_and_run(\n    assistant_id=\"assistant_id\",\n)\nprint(run.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.createAndRun({ assistant_id: 'assistant_id' });\n\nconsole.log(run.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.NewAndRun(context.TODO(), openai.BetaThreadNewAndRunParams{\n    AssistantID: \"assistant_id\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.ThreadCreateAndRunParams;\nimport com.openai.models.beta.threads.runs.Run;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ThreadCreateAndRunParams params = ThreadCreateAndRunParams.builder()\n            .assistantId(\"assistant_id\")\n            .build();\n        Run run = client.beta().threads().createAndRun(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.create_and_run(assistant_id: \"assistant_id\")\n\nputs(run)",
        },
        response: "event: thread.created\ndata: {\"id\":\"thread_123\",\"object\":\"thread\",\"created_at\":1710348075,\"metadata\":{}}\n\nevent: thread.run.created\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710348075,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":null,\"expires_at\":1710348675,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"tool_resources\":{},\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}\n\nevent: thread.run.queued\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710348075,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":null,\"expires_at\":1710348675,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"tool_resources\":{},\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}\n\nevent: thread.run.in_progress\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710348075,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"in_progress\",\"started_at\":null,\"expires_at\":1710348675,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"tool_resources\":{},\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}\n\nevent: thread.run.step.created\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710348076,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710348675,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":null}\n\nevent: thread.run.step.in_progress\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710348076,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710348675,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":null}\n\nevent: thread.message.created\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710348076,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"in_progress\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":null,\"role\":\"assistant\",\"content\":[], \"metadata\":{}}\n\nevent: thread.message.in_progress\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710348076,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"in_progress\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":null,\"role\":\"assistant\",\"content\":[], \"metadata\":{}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\"Hello\",\"annotations\":[]}}]}}\n\n...\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\" today\"}}]}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\"?\"}}]}}\n\nevent: thread.message.completed\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710348076,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"completed\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":1710348077,\"role\":\"assistant\",\"content\":[{\"type\":\"text\",\"text\":{\"value\":\"Hello! How can I assist you today?\",\"annotations\":[]}}], \"metadata\":{}}\n\nevent: thread.run.step.completed\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710348076,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"completed\",\"cancelled_at\":null,\"completed_at\":1710348077,\"expires_at\":1710348675,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":{\"prompt_tokens\":20,\"completion_tokens\":11,\"total_tokens\":31}}\n\nevent: thread.run.completed\n{\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710348076,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"completed\",\"started_at\":1713226836,\"expires_at\":null,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":1713226837,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":{\"prompt_tokens\":345,\"completion_tokens\":11,\"total_tokens\":356},\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}\n\nevent: done\ndata: [DONE]\n",
      },
      #{
        title: "Streaming with Functions",
        request: #{
          curl: "curl https://api.openai.com/v1/threads/runs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"assistant_id\": \"asst_abc123\",\n    \"thread\": {\n      \"messages\": [\n        {\"role\": \"user\", \"content\": \"What is the weather like in San Francisco?\"}\n      ]\n    },\n    \"tools\": [\n      {\n        \"type\": \"function\",\n        \"function\": {\n          \"name\": \"get_current_weather\",\n          \"description\": \"Get the current weather in a given location\",\n          \"parameters\": {\n            \"type\": \"object\",\n            \"properties\": {\n              \"location\": {\n                \"type\": \"string\",\n                \"description\": \"The city and state, e.g. San Francisco, CA\"\n              },\n              \"unit\": {\n                \"type\": \"string\",\n                \"enum\": [\"celsius\", \"fahrenheit\"]\n              }\n            },\n            \"required\": [\"location\"]\n          }\n        }\n      }\n    ],\n    \"stream\": true\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.create_and_run(\n    assistant_id=\"assistant_id\",\n)\nprint(run.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.createAndRun({ assistant_id: 'assistant_id' });\n\nconsole.log(run.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.NewAndRun(context.TODO(), openai.BetaThreadNewAndRunParams{\n    AssistantID: \"assistant_id\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.ThreadCreateAndRunParams;\nimport com.openai.models.beta.threads.runs.Run;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ThreadCreateAndRunParams params = ThreadCreateAndRunParams.builder()\n            .assistantId(\"assistant_id\")\n            .build();\n        Run run = client.beta().threads().createAndRun(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.create_and_run(assistant_id: \"assistant_id\")\n\nputs(run)",
        },
        response: "event: thread.created\ndata: {\"id\":\"thread_123\",\"object\":\"thread\",\"created_at\":1710351818,\"metadata\":{}}\n\nevent: thread.run.created\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710351818,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":null,\"expires_at\":1710352418,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[{\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"description\":\"Get the current weather in a given location\",\"parameters\":{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"The city and state, e.g. San Francisco, CA\"},\"unit\":{\"type\":\"string\",\"enum\":[\"celsius\",\"fahrenheit\"]}},\"required\":[\"location\"]}}}],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.queued\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710351818,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":null,\"expires_at\":1710352418,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[{\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"description\":\"Get the current weather in a given location\",\"parameters\":{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"The city and state, e.g. San Francisco, CA\"},\"unit\":{\"type\":\"string\",\"enum\":[\"celsius\",\"fahrenheit\"]}},\"required\":[\"location\"]}}}],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.in_progress\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710351818,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"in_progress\",\"started_at\":1710351818,\"expires_at\":1710352418,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[{\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"description\":\"Get the current weather in a given location\",\"parameters\":{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"The city and state, e.g. San Francisco, CA\"},\"unit\":{\"type\":\"string\",\"enum\":[\"celsius\",\"fahrenheit\"]}},\"required\":[\"location\"]}}}],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.step.created\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710351819,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"tool_calls\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710352418,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"tool_calls\",\"tool_calls\":[]},\"usage\":null}\n\nevent: thread.run.step.in_progress\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710351819,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"tool_calls\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710352418,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"tool_calls\",\"tool_calls\":[]},\"usage\":null}\n\nevent: thread.run.step.delta\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step.delta\",\"delta\":{\"step_details\":{\"type\":\"tool_calls\",\"tool_calls\":[{\"index\":0,\"id\":\"call_XXNp8YGaFrjrSjgqxtC8JJ1B\",\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"arguments\":\"\",\"output\":null}}]}}}\n\nevent: thread.run.step.delta\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step.delta\",\"delta\":{\"step_details\":{\"type\":\"tool_calls\",\"tool_calls\":[{\"index\":0,\"type\":\"function\",\"function\":{\"arguments\":\"{\\\"\"}}]}}}\n\nevent: thread.run.step.delta\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step.delta\",\"delta\":{\"step_details\":{\"type\":\"tool_calls\",\"tool_calls\":[{\"index\":0,\"type\":\"function\",\"function\":{\"arguments\":\"location\"}}]}}}\n\n...\n\nevent: thread.run.step.delta\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step.delta\",\"delta\":{\"step_details\":{\"type\":\"tool_calls\",\"tool_calls\":[{\"index\":0,\"type\":\"function\",\"function\":{\"arguments\":\"ahrenheit\"}}]}}}\n\nevent: thread.run.step.delta\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step.delta\",\"delta\":{\"step_details\":{\"type\":\"tool_calls\",\"tool_calls\":[{\"index\":0,\"type\":\"function\",\"function\":{\"arguments\":\"\\\"}\"}}]}}}\n\nevent: thread.run.requires_action\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710351818,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"requires_action\",\"started_at\":1710351818,\"expires_at\":1710352418,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":{\"type\":\"submit_tool_outputs\",\"submit_tool_outputs\":{\"tool_calls\":[{\"id\":\"call_XXNp8YGaFrjrSjgqxtC8JJ1B\",\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"arguments\":\"{\\\"location\\\":\\\"San Francisco, CA\\\",\\\"unit\\\":\\\"fahrenheit\\\"}\"}}]}},\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[{\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"description\":\"Get the current weather in a given location\",\"parameters\":{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"The city and state, e.g. San Francisco, CA\"},\"unit\":{\"type\":\"string\",\"enum\":[\"celsius\",\"fahrenheit\"]}},\"required\":[\"location\"]}}}],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":{\"prompt_tokens\":345,\"completion_tokens\":11,\"total_tokens\":356},\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: done\ndata: [DONE]\n",
      }
    ],
  }
)
@tag("Assistants")
op createThreadAndRun(
  @body
  body: CreateThreadAndRunRequest,
): RunObject;

/** Delete a thread. */
@summary("Delete thread")
@delete
@route("/threads/{thread_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete thread",
    group: "threads",
    beta: true,
    returns: "Deletion status",
    examples: #{
      response: "{\n  \"id\": \"thread_abc123\",\n  \"object\": \"thread.deleted\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -X DELETE\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nthread_deleted = client.beta.threads.delete(\n    \"thread_id\",\n)\nprint(thread_deleted.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst threadDeleted = await client.beta.threads.delete('thread_id');\n\nconsole.log(threadDeleted.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  threadDeleted, err := client.Beta.Threads.Delete(context.TODO(), \"thread_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", threadDeleted.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.ThreadDeleteParams;\nimport com.openai.models.beta.threads.ThreadDeleted;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ThreadDeleted threadDeleted = client.beta().threads().delete(\"thread_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nthread_deleted = openai.beta.threads.delete(\"thread_id\")\n\nputs(thread_deleted)",
      },
    },
  }
)
@tag("Assistants")
op deleteThread(
  /** The ID of the thread to delete. */
  @path
  thread_id: string,
): DeleteThreadResponse;

/** Retrieves a thread. */
@summary("Retrieve thread")
@get
@route("/threads/{thread_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve thread",
    group: "threads",
    beta: true,
    returns: "The [thread](https://platform.openai.com/docs/api-reference/threads/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"thread_abc123\",\n  \"object\": \"thread\",\n  \"created_at\": 1699014083,\n  \"metadata\": {},\n  \"tool_resources\": {\n    \"code_interpreter\": {\n      \"file_ids\": []\n    }\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nthread = client.beta.threads.retrieve(\n    \"thread_id\",\n)\nprint(thread.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst thread = await client.beta.threads.retrieve('thread_id');\n\nconsole.log(thread.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  thread, err := client.Beta.Threads.Get(context.TODO(), \"thread_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", thread.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.Thread;\nimport com.openai.models.beta.threads.ThreadRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Thread thread = client.beta().threads().retrieve(\"thread_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nthread = openai.beta.threads.retrieve(\"thread_id\")\n\nputs(thread)",
      },
    },
  }
)
@tag("Assistants")
op getThread(
  /** The ID of the thread to retrieve. */
  @path
  thread_id: string,
): ThreadObject;

/** Modifies a thread. */
@summary("Modify thread")
@post
@route("/threads/{thread_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify thread",
    group: "threads",
    beta: true,
    returns: "The modified [thread](https://platform.openai.com/docs/api-reference/threads/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"thread_abc123\",\n  \"object\": \"thread\",\n  \"created_at\": 1699014083,\n  \"metadata\": {\n    \"modified\": \"true\",\n    \"user\": \"abc123\"\n  },\n  \"tool_resources\": {}\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n      \"metadata\": {\n        \"modified\": \"true\",\n        \"user\": \"abc123\"\n      }\n    }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nthread = client.beta.threads.update(\n    thread_id=\"thread_id\",\n)\nprint(thread.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst thread = await client.beta.threads.update('thread_id');\n\nconsole.log(thread.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  thread, err := client.Beta.Threads.Update(\n    context.TODO(),\n    \"thread_id\",\n    openai.BetaThreadUpdateParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", thread.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.Thread;\nimport com.openai.models.beta.threads.ThreadUpdateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Thread thread = client.beta().threads().update(\"thread_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nthread = openai.beta.threads.update(\"thread_id\")\n\nputs(thread)",
      },
    },
  }
)
@tag("Assistants")
op modifyThread(
  /** The ID of the thread to modify. Only the `metadata` can be modified. */
  @path
  thread_id: string,

  @body
  body: ModifyThreadRequest,
): ThreadObject;

/** Returns a list of messages for a given thread. */
@summary("List messages")
@get
@route("/threads/{thread_id}/messages")
@extension(
  "x-oaiMeta",
  #{
    name: "List messages",
    group: "threads",
    beta: true,
    returns: "A list of [message](https://platform.openai.com/docs/api-reference/messages) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"msg_abc123\",\n      \"object\": \"thread.message\",\n      \"created_at\": 1699016383,\n      \"assistant_id\": null,\n      \"thread_id\": \"thread_abc123\",\n      \"run_id\": null,\n      \"role\": \"user\",\n      \"content\": [\n        {\n          \"type\": \"text\",\n          \"text\": {\n            \"value\": \"How does AI work? Explain it in simple terms.\",\n            \"annotations\": []\n          }\n        }\n      ],\n      \"attachments\": [],\n      \"metadata\": {}\n    },\n    {\n      \"id\": \"msg_abc456\",\n      \"object\": \"thread.message\",\n      \"created_at\": 1699016383,\n      \"assistant_id\": null,\n      \"thread_id\": \"thread_abc123\",\n      \"run_id\": null,\n      \"role\": \"user\",\n      \"content\": [\n        {\n          \"type\": \"text\",\n          \"text\": {\n            \"value\": \"Hello, what is AI?\",\n            \"annotations\": []\n          }\n        }\n      ],\n      \"attachments\": [],\n      \"metadata\": {}\n    }\n  ],\n  \"first_id\": \"msg_abc123\",\n  \"last_id\": \"msg_abc456\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/messages \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.beta.threads.messages.list(\n    thread_id=\"thread_id\",\n)\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const message of client.beta.threads.messages.list('thread_id')) {\n  console.log(message.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Beta.Threads.Messages.List(\n    context.TODO(),\n    \"thread_id\",\n    openai.BetaThreadMessageListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.messages.MessageListPage;\nimport com.openai.models.beta.threads.messages.MessageListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        MessageListPage page = client.beta().threads().messages().list(\"thread_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.beta.threads.messages.list(\"thread_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Assistants")
op listMessages(
  /** The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) the messages belong to. */
  @path
  thread_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
  @query(#{ explode: true })
  before?: string,

  /** Filter messages by the run ID that generated them. */
  @query(#{ explode: true })
  run_id?: string,
): ListMessagesResponse;

/** Create a message. */
@summary("Create message")
@post
@route("/threads/{thread_id}/messages")
@extension(
  "x-oaiMeta",
  #{
    name: "Create message",
    group: "threads",
    beta: true,
    returns: "A [message](https://platform.openai.com/docs/api-reference/messages/object) object.",
    examples: #{
      response: "{\n  \"id\": \"msg_abc123\",\n  \"object\": \"thread.message\",\n  \"created_at\": 1713226573,\n  \"assistant_id\": null,\n  \"thread_id\": \"thread_abc123\",\n  \"run_id\": null,\n  \"role\": \"user\",\n  \"content\": [\n    {\n      \"type\": \"text\",\n      \"text\": {\n        \"value\": \"How does AI work? Explain it in simple terms.\",\n        \"annotations\": []\n      }\n    }\n  ],\n  \"attachments\": [],\n  \"metadata\": {}\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/messages \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n      \"role\": \"user\",\n      \"content\": \"How does AI work? Explain it in simple terms.\"\n    }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nmessage = client.beta.threads.messages.create(\n    thread_id=\"thread_id\",\n    content=\"string\",\n    role=\"user\",\n)\nprint(message.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst message = await client.beta.threads.messages.create('thread_id', { content: 'string', role: 'user' });\n\nconsole.log(message.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  message, err := client.Beta.Threads.Messages.New(\n    context.TODO(),\n    \"thread_id\",\n    openai.BetaThreadMessageNewParams{\n      Content: openai.BetaThreadMessageNewParamsContentUnion{\n        OfString: openai.String(\"string\"),\n      },\n      Role: openai.BetaThreadMessageNewParamsRoleUser,\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", message.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.messages.Message;\nimport com.openai.models.beta.threads.messages.MessageCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        MessageCreateParams params = MessageCreateParams.builder()\n            .threadId(\"thread_id\")\n            .content(\"string\")\n            .role(MessageCreateParams.Role.USER)\n            .build();\n        Message message = client.beta().threads().messages().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nmessage = openai.beta.threads.messages.create(\"thread_id\", content: \"string\", role: :user)\n\nputs(message)",
      },
    },
  }
)
@tag("Assistants")
op createMessage(
  /** The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) to create a message for. */
  @path
  thread_id: string,

  @body
  body: CreateMessageRequest,
): MessageObject;

/** Deletes a message. */
@summary("Delete message")
@delete
@route("/threads/{thread_id}/messages/{message_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete message",
    group: "threads",
    beta: true,
    returns: "Deletion status",
    examples: #{
      response: "{\n  \"id\": \"msg_abc123\",\n  \"object\": \"thread.message.deleted\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/threads/thread_abc123/messages/msg_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nmessage_deleted = client.beta.threads.messages.delete(\n    message_id=\"message_id\",\n    thread_id=\"thread_id\",\n)\nprint(message_deleted.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst messageDeleted = await client.beta.threads.messages.delete('message_id', { thread_id: 'thread_id' });\n\nconsole.log(messageDeleted.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  messageDeleted, err := client.Beta.Threads.Messages.Delete(\n    context.TODO(),\n    \"thread_id\",\n    \"message_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", messageDeleted.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.messages.MessageDeleteParams;\nimport com.openai.models.beta.threads.messages.MessageDeleted;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        MessageDeleteParams params = MessageDeleteParams.builder()\n            .threadId(\"thread_id\")\n            .messageId(\"message_id\")\n            .build();\n        MessageDeleted messageDeleted = client.beta().threads().messages().delete(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nmessage_deleted = openai.beta.threads.messages.delete(\"message_id\", thread_id: \"thread_id\")\n\nputs(message_deleted)",
      },
    },
  }
)
@tag("Assistants")
op deleteMessage(
  /** The ID of the thread to which this message belongs. */
  @path
  thread_id: string,

  /** The ID of the message to delete. */
  @path
  message_id: string,
): DeleteMessageResponse;

/** Retrieve a message. */
@summary("Retrieve message")
@get
@route("/threads/{thread_id}/messages/{message_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve message",
    group: "threads",
    beta: true,
    returns: "The [message](https://platform.openai.com/docs/api-reference/messages/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"msg_abc123\",\n  \"object\": \"thread.message\",\n  \"created_at\": 1699017614,\n  \"assistant_id\": null,\n  \"thread_id\": \"thread_abc123\",\n  \"run_id\": null,\n  \"role\": \"user\",\n  \"content\": [\n    {\n      \"type\": \"text\",\n      \"text\": {\n        \"value\": \"How does AI work? Explain it in simple terms.\",\n        \"annotations\": []\n      }\n    }\n  ],\n  \"attachments\": [],\n  \"metadata\": {}\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/messages/msg_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nmessage = client.beta.threads.messages.retrieve(\n    message_id=\"message_id\",\n    thread_id=\"thread_id\",\n)\nprint(message.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst message = await client.beta.threads.messages.retrieve('message_id', { thread_id: 'thread_id' });\n\nconsole.log(message.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  message, err := client.Beta.Threads.Messages.Get(\n    context.TODO(),\n    \"thread_id\",\n    \"message_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", message.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.messages.Message;\nimport com.openai.models.beta.threads.messages.MessageRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        MessageRetrieveParams params = MessageRetrieveParams.builder()\n            .threadId(\"thread_id\")\n            .messageId(\"message_id\")\n            .build();\n        Message message = client.beta().threads().messages().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nmessage = openai.beta.threads.messages.retrieve(\"message_id\", thread_id: \"thread_id\")\n\nputs(message)",
      },
    },
  }
)
@tag("Assistants")
op getMessage(
  /** The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) to which this message belongs. */
  @path
  thread_id: string,

  /** The ID of the message to retrieve. */
  @path
  message_id: string,
): MessageObject;

/** Modifies a message. */
@summary("Modify message")
@post
@route("/threads/{thread_id}/messages/{message_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify message",
    group: "threads",
    beta: true,
    returns: "The modified [message](https://platform.openai.com/docs/api-reference/messages/object) object.",
    examples: #{
      response: "{\n  \"id\": \"msg_abc123\",\n  \"object\": \"thread.message\",\n  \"created_at\": 1699017614,\n  \"assistant_id\": null,\n  \"thread_id\": \"thread_abc123\",\n  \"run_id\": null,\n  \"role\": \"user\",\n  \"content\": [\n    {\n      \"type\": \"text\",\n      \"text\": {\n        \"value\": \"How does AI work? Explain it in simple terms.\",\n        \"annotations\": []\n      }\n    }\n  ],\n  \"file_ids\": [],\n  \"metadata\": {\n    \"modified\": \"true\",\n    \"user\": \"abc123\"\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/messages/msg_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n      \"metadata\": {\n        \"modified\": \"true\",\n        \"user\": \"abc123\"\n      }\n    }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nmessage = client.beta.threads.messages.update(\n    message_id=\"message_id\",\n    thread_id=\"thread_id\",\n)\nprint(message.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst message = await client.beta.threads.messages.update('message_id', { thread_id: 'thread_id' });\n\nconsole.log(message.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  message, err := client.Beta.Threads.Messages.Update(\n    context.TODO(),\n    \"thread_id\",\n    \"message_id\",\n    openai.BetaThreadMessageUpdateParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", message.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.messages.Message;\nimport com.openai.models.beta.threads.messages.MessageUpdateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        MessageUpdateParams params = MessageUpdateParams.builder()\n            .threadId(\"thread_id\")\n            .messageId(\"message_id\")\n            .build();\n        Message message = client.beta().threads().messages().update(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nmessage = openai.beta.threads.messages.update(\"message_id\", thread_id: \"thread_id\")\n\nputs(message)",
      },
    },
  }
)
@tag("Assistants")
op modifyMessage(
  /** The ID of the thread to which this message belongs. */
  @path
  thread_id: string,

  /** The ID of the message to modify. */
  @path
  message_id: string,

  @body
  body: ModifyMessageRequest,
): MessageObject;

/** Returns a list of runs belonging to a thread. */
@summary("List runs")
@get
@route("/threads/{thread_id}/runs")
@extension(
  "x-oaiMeta",
  #{
    name: "List runs",
    group: "threads",
    beta: true,
    returns: "A list of [run](https://platform.openai.com/docs/api-reference/runs/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"run_abc123\",\n      \"object\": \"thread.run\",\n      \"created_at\": 1699075072,\n      \"assistant_id\": \"asst_abc123\",\n      \"thread_id\": \"thread_abc123\",\n      \"status\": \"completed\",\n      \"started_at\": 1699075072,\n      \"expires_at\": null,\n      \"cancelled_at\": null,\n      \"failed_at\": null,\n      \"completed_at\": 1699075073,\n      \"last_error\": null,\n      \"model\": \"gpt-4o\",\n      \"instructions\": null,\n      \"incomplete_details\": null,\n      \"tools\": [\n        {\n          \"type\": \"code_interpreter\"\n        }\n      ],\n      \"tool_resources\": {\n        \"code_interpreter\": {\n          \"file_ids\": [\n            \"file-abc123\",\n            \"file-abc456\"\n          ]\n        }\n      },\n      \"metadata\": {},\n      \"usage\": {\n        \"prompt_tokens\": 123,\n        \"completion_tokens\": 456,\n        \"total_tokens\": 579\n      },\n      \"temperature\": 1.0,\n      \"top_p\": 1.0,\n      \"max_prompt_tokens\": 1000,\n      \"max_completion_tokens\": 1000,\n      \"truncation_strategy\": {\n        \"type\": \"auto\",\n        \"last_messages\": null\n      },\n      \"response_format\": \"auto\",\n      \"tool_choice\": \"auto\",\n      \"parallel_tool_calls\": true\n    },\n    {\n      \"id\": \"run_abc456\",\n      \"object\": \"thread.run\",\n      \"created_at\": 1699063290,\n      \"assistant_id\": \"asst_abc123\",\n      \"thread_id\": \"thread_abc123\",\n      \"status\": \"completed\",\n      \"started_at\": 1699063290,\n      \"expires_at\": null,\n      \"cancelled_at\": null,\n      \"failed_at\": null,\n      \"completed_at\": 1699063291,\n      \"last_error\": null,\n      \"model\": \"gpt-4o\",\n      \"instructions\": null,\n      \"incomplete_details\": null,\n      \"tools\": [\n        {\n          \"type\": \"code_interpreter\"\n        }\n      ],\n      \"tool_resources\": {\n        \"code_interpreter\": {\n          \"file_ids\": [\n            \"file-abc123\",\n            \"file-abc456\"\n          ]\n        }\n      },\n      \"metadata\": {},\n      \"usage\": {\n        \"prompt_tokens\": 123,\n        \"completion_tokens\": 456,\n        \"total_tokens\": 579\n      },\n      \"temperature\": 1.0,\n      \"top_p\": 1.0,\n      \"max_prompt_tokens\": 1000,\n      \"max_completion_tokens\": 1000,\n      \"truncation_strategy\": {\n        \"type\": \"auto\",\n        \"last_messages\": null\n      },\n      \"response_format\": \"auto\",\n      \"tool_choice\": \"auto\",\n      \"parallel_tool_calls\": true\n    }\n  ],\n  \"first_id\": \"run_abc123\",\n  \"last_id\": \"run_abc456\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/runs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.beta.threads.runs.list(\n    thread_id=\"thread_id\",\n)\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const run of client.beta.threads.runs.list('thread_id')) {\n  console.log(run.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Beta.Threads.Runs.List(\n    context.TODO(),\n    \"thread_id\",\n    openai.BetaThreadRunListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.RunListPage;\nimport com.openai.models.beta.threads.runs.RunListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunListPage page = client.beta().threads().runs().list(\"thread_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.beta.threads.runs.list(\"thread_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Assistants")
op listRuns(
  /** The ID of the thread the run belongs to. */
  @path
  thread_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
  @query(#{ explode: true })
  before?: string,
): ListRunsResponse;

/** Create a run. */
@summary("Create run")
@post
@route("/threads/{thread_id}/runs")
@extension(
  "x-oaiMeta",
  #{
    name: "Create run",
    group: "threads",
    beta: true,
    returns: "A [run](https://platform.openai.com/docs/api-reference/runs/object) object.",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: "curl https://api.openai.com/v1/threads/thread_abc123/runs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"assistant_id\": \"asst_abc123\"\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.runs.create(\n    thread_id=\"thread_id\",\n    assistant_id=\"assistant_id\",\n)\nprint(run.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.runs.create('thread_id', { assistant_id: 'assistant_id' });\n\nconsole.log(run.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.Runs.New(\n    context.TODO(),\n    \"thread_id\",\n    openai.BetaThreadRunNewParams{\n      AssistantID: \"assistant_id\",\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.Run;\nimport com.openai.models.beta.threads.runs.RunCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunCreateParams params = RunCreateParams.builder()\n            .threadId(\"thread_id\")\n            .assistantId(\"assistant_id\")\n            .build();\n        Run run = client.beta().threads().runs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.runs.create(\"thread_id\", assistant_id: \"assistant_id\")\n\nputs(run)",
        },
        response: "{\n  \"id\": \"run_abc123\",\n  \"object\": \"thread.run\",\n  \"created_at\": 1699063290,\n  \"assistant_id\": \"asst_abc123\",\n  \"thread_id\": \"thread_abc123\",\n  \"status\": \"queued\",\n  \"started_at\": 1699063290,\n  \"expires_at\": null,\n  \"cancelled_at\": null,\n  \"failed_at\": null,\n  \"completed_at\": 1699063291,\n  \"last_error\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": null,\n  \"incomplete_details\": null,\n  \"tools\": [\n    {\n      \"type\": \"code_interpreter\"\n    }\n  ],\n  \"metadata\": {},\n  \"usage\": null,\n  \"temperature\": 1.0,\n  \"top_p\": 1.0,\n  \"max_prompt_tokens\": 1000,\n  \"max_completion_tokens\": 1000,\n  \"truncation_strategy\": {\n    \"type\": \"auto\",\n    \"last_messages\": null\n  },\n  \"response_format\": \"auto\",\n  \"tool_choice\": \"auto\",\n  \"parallel_tool_calls\": true\n}\n",
      },
      #{
        title: "Streaming",
        request: #{
          curl: "curl https://api.openai.com/v1/threads/thread_123/runs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"assistant_id\": \"asst_123\",\n    \"stream\": true\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.runs.create(\n    thread_id=\"thread_id\",\n    assistant_id=\"assistant_id\",\n)\nprint(run.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.runs.create('thread_id', { assistant_id: 'assistant_id' });\n\nconsole.log(run.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.Runs.New(\n    context.TODO(),\n    \"thread_id\",\n    openai.BetaThreadRunNewParams{\n      AssistantID: \"assistant_id\",\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.Run;\nimport com.openai.models.beta.threads.runs.RunCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunCreateParams params = RunCreateParams.builder()\n            .threadId(\"thread_id\")\n            .assistantId(\"assistant_id\")\n            .build();\n        Run run = client.beta().threads().runs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.runs.create(\"thread_id\", assistant_id: \"assistant_id\")\n\nputs(run)",
        },
        response: "event: thread.run.created\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710330640,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":null,\"expires_at\":1710331240,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.queued\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710330640,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":null,\"expires_at\":1710331240,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.in_progress\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710330640,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"in_progress\",\"started_at\":1710330641,\"expires_at\":1710331240,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.step.created\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710330641,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710331240,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":null}\n\nevent: thread.run.step.in_progress\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710330641,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710331240,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":null}\n\nevent: thread.message.created\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710330641,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"in_progress\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":null,\"role\":\"assistant\",\"content\":[],\"metadata\":{}}\n\nevent: thread.message.in_progress\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710330641,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"in_progress\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":null,\"role\":\"assistant\",\"content\":[],\"metadata\":{}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\"Hello\",\"annotations\":[]}}]}}\n\n...\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\" today\"}}]}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\"?\"}}]}}\n\nevent: thread.message.completed\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710330641,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"completed\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":1710330642,\"role\":\"assistant\",\"content\":[{\"type\":\"text\",\"text\":{\"value\":\"Hello! How can I assist you today?\",\"annotations\":[]}}],\"metadata\":{}}\n\nevent: thread.run.step.completed\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710330641,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"completed\",\"cancelled_at\":null,\"completed_at\":1710330642,\"expires_at\":1710331240,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":{\"prompt_tokens\":20,\"completion_tokens\":11,\"total_tokens\":31}}\n\nevent: thread.run.completed\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710330640,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"completed\",\"started_at\":1710330641,\"expires_at\":null,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":1710330642,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":{\"prompt_tokens\":20,\"completion_tokens\":11,\"total_tokens\":31},\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: done\ndata: [DONE]\n",
      },
      #{
        title: "Streaming with Functions",
        request: #{
          curl: "curl https://api.openai.com/v1/threads/thread_abc123/runs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"assistant_id\": \"asst_abc123\",\n    \"tools\": [\n      {\n        \"type\": \"function\",\n        \"function\": {\n          \"name\": \"get_current_weather\",\n          \"description\": \"Get the current weather in a given location\",\n          \"parameters\": {\n            \"type\": \"object\",\n            \"properties\": {\n              \"location\": {\n                \"type\": \"string\",\n                \"description\": \"The city and state, e.g. San Francisco, CA\"\n              },\n              \"unit\": {\n                \"type\": \"string\",\n                \"enum\": [\"celsius\", \"fahrenheit\"]\n              }\n            },\n            \"required\": [\"location\"]\n          }\n        }\n      }\n    ],\n    \"stream\": true\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.runs.create(\n    thread_id=\"thread_id\",\n    assistant_id=\"assistant_id\",\n)\nprint(run.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.runs.create('thread_id', { assistant_id: 'assistant_id' });\n\nconsole.log(run.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.Runs.New(\n    context.TODO(),\n    \"thread_id\",\n    openai.BetaThreadRunNewParams{\n      AssistantID: \"assistant_id\",\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.Run;\nimport com.openai.models.beta.threads.runs.RunCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunCreateParams params = RunCreateParams.builder()\n            .threadId(\"thread_id\")\n            .assistantId(\"assistant_id\")\n            .build();\n        Run run = client.beta().threads().runs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.runs.create(\"thread_id\", assistant_id: \"assistant_id\")\n\nputs(run)",
        },
        response: "event: thread.run.created\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710348075,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":null,\"expires_at\":1710348675,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.queued\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710348075,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":null,\"expires_at\":1710348675,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.in_progress\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710348075,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"in_progress\",\"started_at\":1710348075,\"expires_at\":1710348675,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.step.created\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710348076,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710348675,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":null}\n\nevent: thread.run.step.in_progress\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710348076,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710348675,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":null}\n\nevent: thread.message.created\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710348076,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"in_progress\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":null,\"role\":\"assistant\",\"content\":[],\"metadata\":{}}\n\nevent: thread.message.in_progress\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710348076,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"in_progress\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":null,\"role\":\"assistant\",\"content\":[],\"metadata\":{}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\"Hello\",\"annotations\":[]}}]}}\n\n...\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\" today\"}}]}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\"?\"}}]}}\n\nevent: thread.message.completed\ndata: {\"id\":\"msg_001\",\"object\":\"thread.message\",\"created_at\":1710348076,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"completed\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":1710348077,\"role\":\"assistant\",\"content\":[{\"type\":\"text\",\"text\":{\"value\":\"Hello! How can I assist you today?\",\"annotations\":[]}}],\"metadata\":{}}\n\nevent: thread.run.step.completed\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710348076,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"completed\",\"cancelled_at\":null,\"completed_at\":1710348077,\"expires_at\":1710348675,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_001\"}},\"usage\":{\"prompt_tokens\":20,\"completion_tokens\":11,\"total_tokens\":31}}\n\nevent: thread.run.completed\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710348075,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"completed\",\"started_at\":1710348075,\"expires_at\":null,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":1710348077,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":{\"prompt_tokens\":20,\"completion_tokens\":11,\"total_tokens\":31},\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: done\ndata: [DONE]\n",
      }
    ],
  }
)
@tag("Assistants")
op createRun(
  /** The ID of the thread to run. */
  @path
  thread_id: string,

  /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.

See the [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
  @query(#{ explode: true })
  `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[],

  @body
  body: CreateRunRequest,
): RunObject;

/** Retrieves a run. */
@summary("Retrieve run")
@get
@route("/threads/{thread_id}/runs/{run_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve run",
    group: "threads",
    beta: true,
    returns: "The [run](https://platform.openai.com/docs/api-reference/runs/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"run_abc123\",\n  \"object\": \"thread.run\",\n  \"created_at\": 1699075072,\n  \"assistant_id\": \"asst_abc123\",\n  \"thread_id\": \"thread_abc123\",\n  \"status\": \"completed\",\n  \"started_at\": 1699075072,\n  \"expires_at\": null,\n  \"cancelled_at\": null,\n  \"failed_at\": null,\n  \"completed_at\": 1699075073,\n  \"last_error\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": null,\n  \"incomplete_details\": null,\n  \"tools\": [\n    {\n      \"type\": \"code_interpreter\"\n    }\n  ],\n  \"metadata\": {},\n  \"usage\": {\n    \"prompt_tokens\": 123,\n    \"completion_tokens\": 456,\n    \"total_tokens\": 579\n  },\n  \"temperature\": 1.0,\n  \"top_p\": 1.0,\n  \"max_prompt_tokens\": 1000,\n  \"max_completion_tokens\": 1000,\n  \"truncation_strategy\": {\n    \"type\": \"auto\",\n    \"last_messages\": null\n  },\n  \"response_format\": \"auto\",\n  \"tool_choice\": \"auto\",\n  \"parallel_tool_calls\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.runs.retrieve(\n    run_id=\"run_id\",\n    thread_id=\"thread_id\",\n)\nprint(run.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.runs.retrieve('run_id', { thread_id: 'thread_id' });\n\nconsole.log(run.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.Runs.Get(\n    context.TODO(),\n    \"thread_id\",\n    \"run_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.Run;\nimport com.openai.models.beta.threads.runs.RunRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunRetrieveParams params = RunRetrieveParams.builder()\n            .threadId(\"thread_id\")\n            .runId(\"run_id\")\n            .build();\n        Run run = client.beta().threads().runs().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.runs.retrieve(\"run_id\", thread_id: \"thread_id\")\n\nputs(run)",
      },
    },
  }
)
@tag("Assistants")
op getRun(
  /** The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) that was run. */
  @path
  thread_id: string,

  /** The ID of the run to retrieve. */
  @path
  run_id: string,
): RunObject;

/** Modifies a run. */
@summary("Modify run")
@post
@route("/threads/{thread_id}/runs/{run_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify run",
    group: "threads",
    beta: true,
    returns: "The modified [run](https://platform.openai.com/docs/api-reference/runs/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"run_abc123\",\n  \"object\": \"thread.run\",\n  \"created_at\": 1699075072,\n  \"assistant_id\": \"asst_abc123\",\n  \"thread_id\": \"thread_abc123\",\n  \"status\": \"completed\",\n  \"started_at\": 1699075072,\n  \"expires_at\": null,\n  \"cancelled_at\": null,\n  \"failed_at\": null,\n  \"completed_at\": 1699075073,\n  \"last_error\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": null,\n  \"incomplete_details\": null,\n  \"tools\": [\n    {\n      \"type\": \"code_interpreter\"\n    }\n  ],\n  \"tool_resources\": {\n    \"code_interpreter\": {\n      \"file_ids\": [\n        \"file-abc123\",\n        \"file-abc456\"\n      ]\n    }\n  },\n  \"metadata\": {\n    \"user_id\": \"user_abc123\"\n  },\n  \"usage\": {\n    \"prompt_tokens\": 123,\n    \"completion_tokens\": 456,\n    \"total_tokens\": 579\n  },\n  \"temperature\": 1.0,\n  \"top_p\": 1.0,\n  \"max_prompt_tokens\": 1000,\n  \"max_completion_tokens\": 1000,\n  \"truncation_strategy\": {\n    \"type\": \"auto\",\n    \"last_messages\": null\n  },\n  \"response_format\": \"auto\",\n  \"tool_choice\": \"auto\",\n  \"parallel_tool_calls\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"metadata\": {\n      \"user_id\": \"user_abc123\"\n    }\n  }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.runs.update(\n    run_id=\"run_id\",\n    thread_id=\"thread_id\",\n)\nprint(run.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.runs.update('run_id', { thread_id: 'thread_id' });\n\nconsole.log(run.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.Runs.Update(\n    context.TODO(),\n    \"thread_id\",\n    \"run_id\",\n    openai.BetaThreadRunUpdateParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.Run;\nimport com.openai.models.beta.threads.runs.RunUpdateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunUpdateParams params = RunUpdateParams.builder()\n            .threadId(\"thread_id\")\n            .runId(\"run_id\")\n            .build();\n        Run run = client.beta().threads().runs().update(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.runs.update(\"run_id\", thread_id: \"thread_id\")\n\nputs(run)",
      },
    },
  }
)
@tag("Assistants")
op modifyRun(
  /** The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) that was run. */
  @path
  thread_id: string,

  /** The ID of the run to modify. */
  @path
  run_id: string,

  @body
  body: ModifyRunRequest,
): RunObject;

/** Cancels a run that is `in_progress`. */
@summary("Cancel a run")
@post
@route("/threads/{thread_id}/runs/{run_id}/cancel")
@extension(
  "x-oaiMeta",
  #{
    name: "Cancel a run",
    group: "threads",
    beta: true,
    returns: "The modified [run](https://platform.openai.com/docs/api-reference/runs/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"run_abc123\",\n  \"object\": \"thread.run\",\n  \"created_at\": 1699076126,\n  \"assistant_id\": \"asst_abc123\",\n  \"thread_id\": \"thread_abc123\",\n  \"status\": \"cancelling\",\n  \"started_at\": 1699076126,\n  \"expires_at\": 1699076726,\n  \"cancelled_at\": null,\n  \"failed_at\": null,\n  \"completed_at\": null,\n  \"last_error\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": \"You summarize books.\",\n  \"tools\": [\n    {\n      \"type\": \"file_search\"\n    }\n  ],\n  \"tool_resources\": {\n    \"file_search\": {\n      \"vector_store_ids\": [\"vs_123\"]\n    }\n  },\n  \"metadata\": {},\n  \"usage\": null,\n  \"temperature\": 1.0,\n  \"top_p\": 1.0,\n  \"response_format\": \"auto\",\n  \"tool_choice\": \"auto\",\n  \"parallel_tool_calls\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123/cancel \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -X POST\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.runs.cancel(\n    run_id=\"run_id\",\n    thread_id=\"thread_id\",\n)\nprint(run.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.runs.cancel('run_id', { thread_id: 'thread_id' });\n\nconsole.log(run.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.Runs.Cancel(\n    context.TODO(),\n    \"thread_id\",\n    \"run_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.Run;\nimport com.openai.models.beta.threads.runs.RunCancelParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunCancelParams params = RunCancelParams.builder()\n            .threadId(\"thread_id\")\n            .runId(\"run_id\")\n            .build();\n        Run run = client.beta().threads().runs().cancel(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.runs.cancel(\"run_id\", thread_id: \"thread_id\")\n\nputs(run)",
      },
    },
  }
)
@tag("Assistants")
op cancelRun(
  /** The ID of the thread to which this run belongs. */
  @path
  thread_id: string,

  /** The ID of the run to cancel. */
  @path
  run_id: string,
): RunObject;

/** Returns a list of run steps belonging to a run. */
@summary("List run steps")
@get
@route("/threads/{thread_id}/runs/{run_id}/steps")
@extension(
  "x-oaiMeta",
  #{
    name: "List run steps",
    group: "threads",
    beta: true,
    returns: "A list of [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"step_abc123\",\n      \"object\": \"thread.run.step\",\n      \"created_at\": 1699063291,\n      \"run_id\": \"run_abc123\",\n      \"assistant_id\": \"asst_abc123\",\n      \"thread_id\": \"thread_abc123\",\n      \"type\": \"message_creation\",\n      \"status\": \"completed\",\n      \"cancelled_at\": null,\n      \"completed_at\": 1699063291,\n      \"expired_at\": null,\n      \"failed_at\": null,\n      \"last_error\": null,\n      \"step_details\": {\n        \"type\": \"message_creation\",\n        \"message_creation\": {\n          \"message_id\": \"msg_abc123\"\n        }\n      },\n      \"usage\": {\n        \"prompt_tokens\": 123,\n        \"completion_tokens\": 456,\n        \"total_tokens\": 579\n      }\n    }\n  ],\n  \"first_id\": \"step_abc123\",\n  \"last_id\": \"step_abc456\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123/steps \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.beta.threads.runs.steps.list(\n    run_id=\"run_id\",\n    thread_id=\"thread_id\",\n)\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const runStep of client.beta.threads.runs.steps.list('run_id', { thread_id: 'thread_id' })) {\n  console.log(runStep.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Beta.Threads.Runs.Steps.List(\n    context.TODO(),\n    \"thread_id\",\n    \"run_id\",\n    openai.BetaThreadRunStepListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.steps.StepListPage;\nimport com.openai.models.beta.threads.runs.steps.StepListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        StepListParams params = StepListParams.builder()\n            .threadId(\"thread_id\")\n            .runId(\"run_id\")\n            .build();\n        StepListPage page = client.beta().threads().runs().steps().list(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.beta.threads.runs.steps.list(\"run_id\", thread_id: \"thread_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Assistants")
op listRunSteps(
  /** The ID of the thread the run and run steps belong to. */
  @path
  thread_id: string,

  /** The ID of the run the run steps belong to. */
  @path
  run_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
  @query(#{ explode: true })
  before?: string,

  /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.

See the [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
  @query(#{ explode: true })
  `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[],
): ListRunStepsResponse;

/** Retrieves a run step. */
@summary("Retrieve run step")
@get
@route("/threads/{thread_id}/runs/{run_id}/steps/{step_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve run step",
    group: "threads",
    beta: true,
    returns: "The [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"step_abc123\",\n  \"object\": \"thread.run.step\",\n  \"created_at\": 1699063291,\n  \"run_id\": \"run_abc123\",\n  \"assistant_id\": \"asst_abc123\",\n  \"thread_id\": \"thread_abc123\",\n  \"type\": \"message_creation\",\n  \"status\": \"completed\",\n  \"cancelled_at\": null,\n  \"completed_at\": 1699063291,\n  \"expired_at\": null,\n  \"failed_at\": null,\n  \"last_error\": null,\n  \"step_details\": {\n    \"type\": \"message_creation\",\n    \"message_creation\": {\n      \"message_id\": \"msg_abc123\"\n    }\n  },\n  \"usage\": {\n    \"prompt_tokens\": 123,\n    \"completion_tokens\": 456,\n    \"total_tokens\": 579\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123/steps/step_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun_step = client.beta.threads.runs.steps.retrieve(\n    step_id=\"step_id\",\n    thread_id=\"thread_id\",\n    run_id=\"run_id\",\n)\nprint(run_step.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst runStep = await client.beta.threads.runs.steps.retrieve('step_id', {\n  thread_id: 'thread_id',\n  run_id: 'run_id',\n});\n\nconsole.log(runStep.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  runStep, err := client.Beta.Threads.Runs.Steps.Get(\n    context.TODO(),\n    \"thread_id\",\n    \"run_id\",\n    \"step_id\",\n    openai.BetaThreadRunStepGetParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", runStep.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.steps.RunStep;\nimport com.openai.models.beta.threads.runs.steps.StepRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        StepRetrieveParams params = StepRetrieveParams.builder()\n            .threadId(\"thread_id\")\n            .runId(\"run_id\")\n            .stepId(\"step_id\")\n            .build();\n        RunStep runStep = client.beta().threads().runs().steps().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun_step = openai.beta.threads.runs.steps.retrieve(\"step_id\", thread_id: \"thread_id\", run_id: \"run_id\")\n\nputs(run_step)",
      },
    },
  }
)
@tag("Assistants")
op getRunStep(
  /** The ID of the thread to which the run and run step belongs. */
  @path
  thread_id: string,

  /** The ID of the run to which the run step belongs. */
  @path
  run_id: string,

  /** The ID of the run step to retrieve. */
  @path
  step_id: string,

  /**A list of additional fields to include in the response. Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.

See the [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
  @query(#{ explode: true })
  `include[]`?: "step_details.tool_calls[*].file_search.results[*].content"[],
): RunStepObject;

/** When a run has the `status: "requires_action"` and `required_action.type` is `submit_tool_outputs`, this endpoint can be used to submit the outputs from the tool calls once they're all completed. All outputs must be submitted in a single request. */
@summary("Submit tool outputs to run")
@post
@route("/threads/{thread_id}/runs/{run_id}/submit_tool_outputs")
@extension(
  "x-oaiMeta",
  #{
    name: "Submit tool outputs to run",
    group: "threads",
    beta: true,
    returns: "The modified [run](https://platform.openai.com/docs/api-reference/runs/object) object matching the specified ID.",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: "curl https://api.openai.com/v1/threads/thread_123/runs/run_123/submit_tool_outputs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"tool_outputs\": [\n      {\n        \"tool_call_id\": \"call_001\",\n        \"output\": \"70 degrees and sunny.\"\n      }\n    ]\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.runs.submit_tool_outputs(\n    run_id=\"run_id\",\n    thread_id=\"thread_id\",\n    tool_outputs=[{}],\n)\nprint(run.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.runs.submitToolOutputs('run_id', {\n  thread_id: 'thread_id',\n  tool_outputs: [{}],\n});\n\nconsole.log(run.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.Runs.SubmitToolOutputs(\n    context.TODO(),\n    \"thread_id\",\n    \"run_id\",\n    openai.BetaThreadRunSubmitToolOutputsParams{\n      ToolOutputs: []openai.BetaThreadRunSubmitToolOutputsParamsToolOutput{openai.BetaThreadRunSubmitToolOutputsParamsToolOutput{\n\n      }},\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.Run;\nimport com.openai.models.beta.threads.runs.RunSubmitToolOutputsParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunSubmitToolOutputsParams params = RunSubmitToolOutputsParams.builder()\n            .threadId(\"thread_id\")\n            .runId(\"run_id\")\n            .addToolOutput(RunSubmitToolOutputsParams.ToolOutput.builder().build())\n            .build();\n        Run run = client.beta().threads().runs().submitToolOutputs(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.runs.submit_tool_outputs(\"run_id\", thread_id: \"thread_id\", tool_outputs: [{}])\n\nputs(run)",
        },
        response: "{\n  \"id\": \"run_123\",\n  \"object\": \"thread.run\",\n  \"created_at\": 1699075592,\n  \"assistant_id\": \"asst_123\",\n  \"thread_id\": \"thread_123\",\n  \"status\": \"queued\",\n  \"started_at\": 1699075592,\n  \"expires_at\": 1699076192,\n  \"cancelled_at\": null,\n  \"failed_at\": null,\n  \"completed_at\": null,\n  \"last_error\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": null,\n  \"tools\": [\n    {\n      \"type\": \"function\",\n      \"function\": {\n        \"name\": \"get_current_weather\",\n        \"description\": \"Get the current weather in a given location\",\n        \"parameters\": {\n          \"type\": \"object\",\n          \"properties\": {\n            \"location\": {\n              \"type\": \"string\",\n              \"description\": \"The city and state, e.g. San Francisco, CA\"\n            },\n            \"unit\": {\n              \"type\": \"string\",\n              \"enum\": [\"celsius\", \"fahrenheit\"]\n            }\n          },\n          \"required\": [\"location\"]\n        }\n      }\n    }\n  ],\n  \"metadata\": {},\n  \"usage\": null,\n  \"temperature\": 1.0,\n  \"top_p\": 1.0,\n  \"max_prompt_tokens\": 1000,\n  \"max_completion_tokens\": 1000,\n  \"truncation_strategy\": {\n    \"type\": \"auto\",\n    \"last_messages\": null\n  },\n  \"response_format\": \"auto\",\n  \"tool_choice\": \"auto\",\n  \"parallel_tool_calls\": true\n}\n",
      },
      #{
        title: "Streaming",
        request: #{
          curl: "curl https://api.openai.com/v1/threads/thread_123/runs/run_123/submit_tool_outputs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"tool_outputs\": [\n      {\n        \"tool_call_id\": \"call_001\",\n        \"output\": \"70 degrees and sunny.\"\n      }\n    ],\n    \"stream\": true\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.beta.threads.runs.submit_tool_outputs(\n    run_id=\"run_id\",\n    thread_id=\"thread_id\",\n    tool_outputs=[{}],\n)\nprint(run.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.beta.threads.runs.submitToolOutputs('run_id', {\n  thread_id: 'thread_id',\n  tool_outputs: [{}],\n});\n\nconsole.log(run.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  run, err := client.Beta.Threads.Runs.SubmitToolOutputs(\n    context.TODO(),\n    \"thread_id\",\n    \"run_id\",\n    openai.BetaThreadRunSubmitToolOutputsParams{\n      ToolOutputs: []openai.BetaThreadRunSubmitToolOutputsParamsToolOutput{openai.BetaThreadRunSubmitToolOutputsParamsToolOutput{\n\n      }},\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", run.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.threads.runs.Run;\nimport com.openai.models.beta.threads.runs.RunSubmitToolOutputsParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunSubmitToolOutputsParams params = RunSubmitToolOutputsParams.builder()\n            .threadId(\"thread_id\")\n            .runId(\"run_id\")\n            .addToolOutput(RunSubmitToolOutputsParams.ToolOutput.builder().build())\n            .build();\n        Run run = client.beta().threads().runs().submitToolOutputs(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.beta.threads.runs.submit_tool_outputs(\"run_id\", thread_id: \"thread_id\", tool_outputs: [{}])\n\nputs(run)",
        },
        response: "event: thread.run.step.completed\ndata: {\"id\":\"step_001\",\"object\":\"thread.run.step\",\"created_at\":1710352449,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"tool_calls\",\"status\":\"completed\",\"cancelled_at\":null,\"completed_at\":1710352475,\"expires_at\":1710353047,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"tool_calls\",\"tool_calls\":[{\"id\":\"call_iWr0kQ2EaYMaxNdl0v3KYkx7\",\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"arguments\":\"{\\\"location\\\":\\\"San Francisco, CA\\\",\\\"unit\\\":\\\"fahrenheit\\\"}\",\"output\":\"70 degrees and sunny.\"}}]},\"usage\":{\"prompt_tokens\":291,\"completion_tokens\":24,\"total_tokens\":315}}\n\nevent: thread.run.queued\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710352447,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"queued\",\"started_at\":1710352448,\"expires_at\":1710353047,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[{\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"description\":\"Get the current weather in a given location\",\"parameters\":{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"The city and state, e.g. San Francisco, CA\"},\"unit\":{\"type\":\"string\",\"enum\":[\"celsius\",\"fahrenheit\"]}},\"required\":[\"location\"]}}}],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.in_progress\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710352447,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"in_progress\",\"started_at\":1710352475,\"expires_at\":1710353047,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":null,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[{\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"description\":\"Get the current weather in a given location\",\"parameters\":{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"The city and state, e.g. San Francisco, CA\"},\"unit\":{\"type\":\"string\",\"enum\":[\"celsius\",\"fahrenheit\"]}},\"required\":[\"location\"]}}}],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":null,\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: thread.run.step.created\ndata: {\"id\":\"step_002\",\"object\":\"thread.run.step\",\"created_at\":1710352476,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710353047,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_002\"}},\"usage\":null}\n\nevent: thread.run.step.in_progress\ndata: {\"id\":\"step_002\",\"object\":\"thread.run.step\",\"created_at\":1710352476,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"in_progress\",\"cancelled_at\":null,\"completed_at\":null,\"expires_at\":1710353047,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_002\"}},\"usage\":null}\n\nevent: thread.message.created\ndata: {\"id\":\"msg_002\",\"object\":\"thread.message\",\"created_at\":1710352476,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"in_progress\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":null,\"role\":\"assistant\",\"content\":[],\"metadata\":{}}\n\nevent: thread.message.in_progress\ndata: {\"id\":\"msg_002\",\"object\":\"thread.message\",\"created_at\":1710352476,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"in_progress\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":null,\"role\":\"assistant\",\"content\":[],\"metadata\":{}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_002\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\"The\",\"annotations\":[]}}]}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_002\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\" current\"}}]}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_002\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\" weather\"}}]}}\n\n...\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_002\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\" sunny\"}}]}}\n\nevent: thread.message.delta\ndata: {\"id\":\"msg_002\",\"object\":\"thread.message.delta\",\"delta\":{\"content\":[{\"index\":0,\"type\":\"text\",\"text\":{\"value\":\".\"}}]}}\n\nevent: thread.message.completed\ndata: {\"id\":\"msg_002\",\"object\":\"thread.message\",\"created_at\":1710352476,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"run_id\":\"run_123\",\"status\":\"completed\",\"incomplete_details\":null,\"incomplete_at\":null,\"completed_at\":1710352477,\"role\":\"assistant\",\"content\":[{\"type\":\"text\",\"text\":{\"value\":\"The current weather in San Francisco, CA is 70 degrees Fahrenheit and sunny.\",\"annotations\":[]}}],\"metadata\":{}}\n\nevent: thread.run.step.completed\ndata: {\"id\":\"step_002\",\"object\":\"thread.run.step\",\"created_at\":1710352476,\"run_id\":\"run_123\",\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"type\":\"message_creation\",\"status\":\"completed\",\"cancelled_at\":null,\"completed_at\":1710352477,\"expires_at\":1710353047,\"failed_at\":null,\"last_error\":null,\"step_details\":{\"type\":\"message_creation\",\"message_creation\":{\"message_id\":\"msg_002\"}},\"usage\":{\"prompt_tokens\":329,\"completion_tokens\":18,\"total_tokens\":347}}\n\nevent: thread.run.completed\ndata: {\"id\":\"run_123\",\"object\":\"thread.run\",\"created_at\":1710352447,\"assistant_id\":\"asst_123\",\"thread_id\":\"thread_123\",\"status\":\"completed\",\"started_at\":1710352475,\"expires_at\":null,\"cancelled_at\":null,\"failed_at\":null,\"completed_at\":1710352477,\"required_action\":null,\"last_error\":null,\"model\":\"gpt-4o\",\"instructions\":null,\"tools\":[{\"type\":\"function\",\"function\":{\"name\":\"get_current_weather\",\"description\":\"Get the current weather in a given location\",\"parameters\":{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"The city and state, e.g. San Francisco, CA\"},\"unit\":{\"type\":\"string\",\"enum\":[\"celsius\",\"fahrenheit\"]}},\"required\":[\"location\"]}}}],\"metadata\":{},\"temperature\":1.0,\"top_p\":1.0,\"max_completion_tokens\":null,\"max_prompt_tokens\":null,\"truncation_strategy\":{\"type\":\"auto\",\"last_messages\":null},\"incomplete_details\":null,\"usage\":{\"prompt_tokens\":20,\"completion_tokens\":11,\"total_tokens\":31},\"response_format\":\"auto\",\"tool_choice\":\"auto\",\"parallel_tool_calls\":true}}\n\nevent: done\ndata: [DONE]\n",
      }
    ],
  }
)
@tag("Assistants")
op submitToolOuputsToRun(
  /** The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) to which this run belongs. */
  @path
  thread_id: string,

  /** The ID of the run that requires the tool output submission. */
  @path
  run_id: string,

  @body
  body: SubmitToolOutputsRunRequest,
): RunObject;
