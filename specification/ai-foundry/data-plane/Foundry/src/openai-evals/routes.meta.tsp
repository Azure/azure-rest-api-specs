import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Evals.listEvals,
  "x-oaiMeta",
  #{
    name: "List evals",
    group: "evals",
    path: "list",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals?limit=1 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.evals.list()
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const evals = await openai.evals.list({ limit: 1 });
          console.log(evals);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const evalListResponse of client.evals.list()) {
            console.log(evalListResponse.id);
          }
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.EvalListPage;
          import com.openai.models.evals.EvalListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  EvalListPage page = client.evals().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.evals.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "eval_67abd54d9b0081909a86353f6fb9317a",
              "object": "eval",
              "data_source_config": {
                "type": "stored_completions",
                "metadata": {
                  "usecase": "push_notifications_summarizer"
                },
                "schema": {
                  "type": "object",
                  "properties": {
                    "item": {
                      "type": "object"
                    },
                    "sample": {
                      "type": "object"
                    }
                  },
                  "required": [
                    "item",
                    "sample"
                  ]
                }
              },
              "testing_criteria": [
                {
                  "name": "Push Notification Summary Grader",
                  "id": "Push Notification Summary Grader-9b876f24-4762-4be9-aff4-db7a9b31c673",
                  "type": "label_model",
                  "model": "o3-mini",
                  "input": [
                    {
                      "type": "message",
                      "role": "developer",
                      "content": {
                        "type": "input_text",
                        "text": "
        Label the following push notification summary as either correct or incorrect.
        The push notification and the summary will be provided below.
        A good push notificiation summary is concise and snappy.
        If it is good, then label it as correct, if not, then incorrect.
        "
                      }
                    },
                    {
                      "type": "message",
                      "role": "user",
                      "content": {
                        "type": "input_text",
                        "text": "
        Push notifications: {{item.input}}
        Summary: {{sample.output_text}}
        "
                      }
                    }
                  ],
                  "passing_labels": [
                    "correct"
                  ],
                  "labels": [
                    "correct",
                    "incorrect"
                  ],
                  "sampling_params": null
                }
              ],
              "name": "Push Notification Summary Grader",
              "created_at": 1739314509,
              "metadata": {
                "description": "A stored completions eval for push notification summaries"
              }
            }
          ],
          "first_id": "eval_67abd54d9b0081909a86353f6fb9317a",
          "last_id": "eval_67aa884cf6688190b58f657d4441c8b7",
          "has_more": true
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Evals.listEvals, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Evals.createEval,
  "x-oaiMeta",
  #{
    name: "Create eval",
    group: "evals",
    path: "post",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
                  "name": "Sentiment",
                  "data_source_config": {
                    "type": "stored_completions",
                    "metadata": {
                        "usecase": "chatbot"
                    }
                  },
                  "testing_criteria": [
                    {
                      "type": "label_model",
                      "model": "o3-mini",
                      "input": [
                        {
                          "role": "developer",
                          "content": "Classify the sentiment of the following statement as one of 'positive', 'neutral', or 'negative'"
                        },
                        {
                          "role": "user",
                          "content": "Statement: {{item.input}}"
                        }
                      ],
                      "passing_labels": [
                        "positive"
                      ],
                      "labels": [
                        "positive",
                        "neutral",
                        "negative"
                      ],
                      "name": "Example label grader"
                    }
                  ]
                }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          eval = client.evals.create(
              data_source_config={
                  "item_schema": {
                      "foo": "bar"
                  },
                  "type": "custom",
              },
              testing_criteria=[{
                  "input": [{
                      "content": "content",
                      "role": "role",
                  }],
                  "labels": ["string"],
                  "model": "model",
                  "name": "name",
                  "passing_labels": ["string"],
                  "type": "label_model",
              }],
          )
          print(eval.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const evalObj = await openai.evals.create({
            name: "Sentiment",
            data_source_config: {
              type: "stored_completions",
              metadata: { usecase: "chatbot" }
            },
            testing_criteria: [
              {
                type: "label_model",
                model: "o3-mini",
                input: [
                  { role: "developer", content: "Classify the sentiment of the following statement as one of 'positive', 'neutral', or 'negative'" },
                  { role: "user", content: "Statement: {{item.input}}" }
                ],
                passing_labels: ["positive"],
                labels: ["positive", "neutral", "negative"],
                name: "Example label grader"
              }
            ]
          });
          console.log(evalObj);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const _eval = await client.evals.create({
            data_source_config: {
              item_schema: { foo: 'bar' },
              type: 'custom',
            },
            testing_criteria: [
              {
                input: [{ content: 'content', role: 'role' }],
                labels: ['string'],
                model: 'model',
                name: 'name',
                passing_labels: ['string'],
                type: 'label_model',
              },
            ],
          });
          
          console.log(_eval.id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.core.JsonValue;
          import com.openai.models.evals.EvalCreateParams;
          import com.openai.models.evals.EvalCreateResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  EvalCreateParams params = EvalCreateParams.builder()
                      .customDataSourceConfig(EvalCreateParams.DataSourceConfig.Custom.ItemSchema.builder()
                          .putAdditionalProperty("foo", JsonValue.from("bar"))
                          .build())
                      .addTestingCriterion(EvalCreateParams.TestingCriterion.LabelModel.builder()
                          .addInput(EvalCreateParams.TestingCriterion.LabelModel.Input.SimpleInputMessage.builder()
                              .content("content")
                              .role("role")
                              .build())
                          .addLabel("string")
                          .model("model")
                          .name("name")
                          .addPassingLabel("string")
                          .build())
                      .build();
                  EvalCreateResponse eval = client.evals().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          eval_ = openai.evals.create(
            data_source_config: {item_schema: {foo: "bar"}, type: :custom},
            testing_criteria: [
              {
                input: [{content: "content", role: "role"}],
                labels: ["string"],
                model: "model",
                name: "name",
                passing_labels: ["string"],
                type: :label_model
              }
            ]
          )
          
          puts(eval_)
          """,
      },
      response: """
        {
          "object": "eval",
          "id": "eval_67b7fa9a81a88190ab4aa417e397ea21",
          "data_source_config": {
            "type": "stored_completions",
            "metadata": {
              "usecase": "chatbot"
            },
            "schema": {
              "type": "object",
              "properties": {
                "item": {
                  "type": "object"
                },
                "sample": {
                  "type": "object"
                }
              },
              "required": [
                "item",
                "sample"
              ]
          },
          "testing_criteria": [
            {
              "name": "Example label grader",
              "type": "label_model",
              "model": "o3-mini",
              "input": [
                {
                  "type": "message",
                  "role": "developer",
                  "content": {
                    "type": "input_text",
                    "text": "Classify the sentiment of the following statement as one of positive, neutral, or negative"
                  }
                },
                {
                  "type": "message",
                  "role": "user",
                  "content": {
                    "type": "input_text",
                    "text": "Statement: {{item.input}}"
                  }
                }
              ],
              "passing_labels": [
                "positive"
              ],
              "labels": [
                "positive",
                "neutral",
                "negative"
              ]
            }
          ],
          "name": "Sentiment",
          "created_at": 1740110490,
          "metadata": {
            "description": "An eval for sentiment analysis"
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Evals.deleteEval,
  "x-oaiMeta",
  #{
    name: "Delete an eval",
    group: "evals",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/eval_abc123 \\
            -X DELETE \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          eval = client.evals.delete(
              "eval_id",
          )
          print(eval.eval_id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const deleted = await openai.evals.delete("eval_abc123");
          console.log(deleted);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const _eval = await client.evals.delete('eval_id');
          
          console.log(_eval.eval_id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.EvalDeleteParams;
          import com.openai.models.evals.EvalDeleteResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  EvalDeleteResponse eval = client.evals().delete("eval_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          eval_ = openai.evals.delete("eval_id")
          
          puts(eval_)
          """,
      },
      response: """
        {
          "object": "eval.deleted",
          "deleted": true,
          "eval_id": "eval_abc123"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Evals.getEval,
  "x-oaiMeta",
  #{
    name: "Get an eval",
    group: "evals",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          eval = client.evals.retrieve(
              "eval_id",
          )
          print(eval.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const evalObj = await openai.evals.retrieve("eval_67abd54d9b0081909a86353f6fb9317a");
          console.log(evalObj);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const _eval = await client.evals.retrieve('eval_id');
          
          console.log(_eval.id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.EvalRetrieveParams;
          import com.openai.models.evals.EvalRetrieveResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  EvalRetrieveResponse eval = client.evals().retrieve("eval_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          eval_ = openai.evals.retrieve("eval_id")
          
          puts(eval_)
          """,
      },
      response: """
        {
          "object": "eval",
          "id": "eval_67abd54d9b0081909a86353f6fb9317a",
          "data_source_config": {
            "type": "custom",
            "schema": {
              "type": "object",
              "properties": {
                "item": {
                  "type": "object",
                  "properties": {
                    "input": {
                      "type": "string"
                    },
                    "ground_truth": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "input",
                    "ground_truth"
                  ]
                }
              },
              "required": [
                "item"
              ]
            }
          },
          "testing_criteria": [
            {
              "name": "String check",
              "id": "String check-2eaf2d8d-d649-4335-8148-9535a7ca73c2",
              "type": "string_check",
              "input": "{{item.input}}",
              "reference": "{{item.ground_truth}}",
              "operation": "eq"
            }
          ],
          "name": "External Data Eval",
          "created_at": 1739314509,
          "metadata": {},
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Evals.updateEval,
  "x-oaiMeta",
  #{
    name: "Update an eval",
    group: "evals",
    path: "update",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{"name": "Updated Eval", "metadata": {"description": "Updated description"}}'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          eval = client.evals.update(
              eval_id="eval_id",
          )
          print(eval.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const updatedEval = await openai.evals.update(
            "eval_67abd54d9b0081909a86353f6fb9317a",
            {
              name: "Updated Eval",
              metadata: { description: "Updated description" }
            }
          );
          console.log(updatedEval);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const _eval = await client.evals.update('eval_id');
          
          console.log(_eval.id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.EvalUpdateParams;
          import com.openai.models.evals.EvalUpdateResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  EvalUpdateResponse eval = client.evals().update("eval_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          eval_ = openai.evals.update("eval_id")
          
          puts(eval_)
          """,
      },
      response: """
        {
          "object": "eval",
          "id": "eval_67abd54d9b0081909a86353f6fb9317a",
          "data_source_config": {
            "type": "custom",
            "schema": {
              "type": "object",
              "properties": {
                "item": {
                  "type": "object",
                  "properties": {
                    "input": {
                      "type": "string"
                    },
                    "ground_truth": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "input",
                    "ground_truth"
                  ]
                }
              },
              "required": [
                "item"
              ]
            }
          },
          "testing_criteria": [
            {
              "name": "String check",
              "id": "String check-2eaf2d8d-d649-4335-8148-9535a7ca73c2",
              "type": "string_check",
              "input": "{{item.input}}",
              "reference": "{{item.ground_truth}}",
              "operation": "eq"
            }
          ],
          "name": "Updated Eval",
          "created_at": 1739314509,
          "metadata": {"description": "Updated description"},
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Evals.getEvalRuns,
  "x-oaiMeta",
  #{
    name: "Get eval runs",
    group: "evals",
    path: "get-runs",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/egroup_67abd54d9b0081909a86353f6fb9317a/runs \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.evals.runs.list(
              eval_id="eval_id",
          )
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const runs = await openai.evals.runs.list("egroup_67abd54d9b0081909a86353f6fb9317a");
          console.log(runs);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const runListResponse of client.evals.runs.list('eval_id')) {
            console.log(runListResponse.id);
          }
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.runs.RunListPage;
          import com.openai.models.evals.runs.RunListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunListPage page = client.evals().runs().list("eval_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.evals.runs.list("eval_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "eval.run",
              "id": "evalrun_67e0c7d31560819090d60c0780591042",
              "eval_id": "eval_67e0c726d560819083f19a957c4c640b",
              "report_url": "https://platform.openai.com/evaluations/eval_67e0c726d560819083f19a957c4c640b",
              "status": "completed",
              "model": "o3-mini",
              "name": "bulk_with_negative_examples_o3-mini",
              "created_at": 1742784467,
              "result_counts": {
                "total": 1,
                "errored": 0,
                "failed": 0,
                "passed": 1
              },
              "per_model_usage": [
                {
                  "model_name": "o3-mini",
                  "invocation_count": 1,
                  "prompt_tokens": 563,
                  "completion_tokens": 874,
                  "total_tokens": 1437,
                  "cached_tokens": 0
                }
              ],
              "per_testing_criteria_results": [
                {
                  "testing_criteria": "Push Notification Summary Grader-1808cd0b-eeec-4e0b-a519-337e79f4f5d1",
                  "passed": 1,
                  "failed": 0
                }
              ],
              "data_source": {
                "type": "completions",
                "source": {
                  "type": "file_content",
                  "content": [
                    {
                      "item": {
                        "notifications": "
        - New message from Sarah: "Can you call me later?"
        - Your package has been delivered!
        - Flash sale: 20% off electronics for the next 2 hours!
        "
                      }
                    }
                  ]
                },
                "input_messages": {
                  "type": "template",
                  "template": [
                    {
                      "type": "message",
                      "role": "developer",
                      "content": {
                        "type": "input_text",
                        "text": "
        
        
        
        You are a helpful assistant that takes in an array of push notifications and returns a collapsed summary of them.
        The push notification will be provided as follows:
        <push_notifications>
        ...notificationlist...
        </push_notifications>
        
        You should return just the summary and nothing else.
        
        
        You should return a summary that is concise and snappy.
        
        
        Here is an example of a good summary:
        <push_notifications>
        - Traffic alert: Accident reported on Main Street.- Package out for delivery: Expected by 5 PM.- New friend suggestion: Connect with Emma.
        </push_notifications>
        <summary>
        Traffic alert, package expected by 5pm, suggestion for new friend (Emily).
        </summary>
        
        
        Here is an example of a bad summary:
        <push_notifications>
        - Traffic alert: Accident reported on Main Street.- Package out for delivery: Expected by 5 PM.- New friend suggestion: Connect with Emma.
        </push_notifications>
        <summary>
        Traffic alert reported on main street. You have a package that will arrive by 5pm, Emily is a new friend suggested for you.
        </summary>
        "
                      }
                    },
                    {
                      "type": "message",
                      "role": "user",
                      "content": {
                        "type": "input_text",
                        "text": "<push_notifications>{{item.notifications}}</push_notifications>"
                      }
                    }
                  ]
                },
                "model": "o3-mini",
                "sampling_params": null
              },
              "error": null,
              "metadata": {}
            }
          ],
          "first_id": "evalrun_67e0c7d31560819090d60c0780591042",
          "last_id": "evalrun_67e0c7d31560819090d60c0780591042",
          "has_more": true
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Evals.getEvalRuns, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Evals.createEvalRun,
  "x-oaiMeta",
  #{
    name: "Create eval run",
    group: "evals",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/eval_67e579652b548190aaa83ada4b125f47/runs \\
            -X POST \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{"name":"gpt-4o-mini","data_source":{"type":"completions","input_messages":{"type":"template","template":[{"role":"developer","content":"Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.
          
          # Steps
          
          1. Analyze the content of the news headline to understand its primary focus.
          2. Extract the subject matter, identifying any key indicators or keywords.
          3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.
          4. Ensure only one category is selected per headline.
          
          # Output Format
          
          Respond with the chosen category as a single word. For instance: "Technology", "Markets", "World", "Business", or "Sports".
          
          # Examples
          
          **Input**: "Apple Unveils New iPhone Model, Featuring Advanced AI Features"
          **Output**: "Technology"
          
          **Input**: "Global Stocks Mixed as Investors Await Central Bank Decisions"
          **Output**: "Markets"
          
          **Input**: "War in Ukraine: Latest Updates on Negotiation Status"
          **Output**: "World"
          
          **Input**: "Microsoft in Talks to Acquire Gaming Company for $2 Billion"
          **Output**: "Business"
          
          **Input**: "Manchester United Secures Win in Premier League Football Match"
          **Output**: "Sports"
          
          # Notes
          
          - If the headline appears to fit into more than one category, choose the most dominant theme.
          - Keywords or phrases such as "stocks", "company acquisition", "match", or technological brands can be good indicators for classification.
          "} , {"role":"user","content":"{{item.input}}"}]} ,"sampling_params":{"temperature":1,"max_completions_tokens":2048,"top_p":1,"seed":42},"model":"gpt-4o-mini","source":{"type":"file_content","content":[{"item":{"input":"Tech Company Launches Advanced Artificial Intelligence Platform","ground_truth":"Technology"}}]}}'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          run = client.evals.runs.create(
              eval_id="eval_id",
              data_source={
                  "source": {
                      "content": [{
                          "item": {
                              "foo": "bar"
                          }
                      }],
                      "type": "file_content",
                  },
                  "type": "jsonl",
              },
          )
          print(run.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const run = await openai.evals.runs.create(
            "eval_67e579652b548190aaa83ada4b125f47",
            {
              name: "gpt-4o-mini",
              data_source: {
                type: "completions",
                input_messages: {
                  type: "template",
                  template: [
                    {
                      role: "developer",
                      content: "Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.
          
          # Steps
          
          1. Analyze the content of the news headline to understand its primary focus.
          2. Extract the subject matter, identifying any key indicators or keywords.
          3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.
          4. Ensure only one category is selected per headline.
          
          # Output Format
          
          Respond with the chosen category as a single word. For instance: "Technology", "Markets", "World", "Business", or "Sports".
          
          # Examples
          
          **Input**: "Apple Unveils New iPhone Model, Featuring Advanced AI Features"
          **Output**: "Technology"
          
          **Input**: "Global Stocks Mixed as Investors Await Central Bank Decisions"
          **Output**: "Markets"
          
          **Input**: "War in Ukraine: Latest Updates on Negotiation Status"
          **Output**: "World"
          
          **Input**: "Microsoft in Talks to Acquire Gaming Company for $2 Billion"
          **Output**: "Business"
          
          **Input**: "Manchester United Secures Win in Premier League Football Match"
          **Output**: "Sports"
          
          # Notes
          
          - If the headline appears to fit into more than one category, choose the most dominant theme.
          - Keywords or phrases such as "stocks", "company acquisition", "match", or technological brands can be good indicators for classification.
          "
                    },
                    {
                      role: "user",
                      content: "{{item.input}}"
                    }
                  ]
                },
                sampling_params: {
                  temperature: 1,
                  max_completions_tokens: 2048,
                  top_p: 1,
                  seed: 42
                },
                model: "gpt-4o-mini",
                source: {
                  type: "file_content",
                  content: [
                    {
                      item: {
                        input: "Tech Company Launches Advanced Artificial Intelligence Platform",
                        ground_truth: "Technology"
                      }
                    }
                  ]
                }
              }
            }
          );
          console.log(run);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const run = await client.evals.runs.create('eval_id', {
            data_source: {
              source: { content: [{ item: { foo: 'bar' } }], type: 'file_content' },
              type: 'jsonl',
            },
          });
          
          console.log(run.id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.core.JsonValue;
          import com.openai.models.evals.runs.CreateEvalJsonlRunDataSource;
          import com.openai.models.evals.runs.RunCreateParams;
          import com.openai.models.evals.runs.RunCreateResponse;
          import java.util.List;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunCreateParams params = RunCreateParams.builder()
                      .evalId("eval_id")
                      .dataSource(CreateEvalJsonlRunDataSource.builder()
                          .fileContentSource(List.of(CreateEvalJsonlRunDataSource.Source.FileContent.Content.builder()
                              .item(CreateEvalJsonlRunDataSource.Source.FileContent.Content.Item.builder()
                                  .putAdditionalProperty("foo", JsonValue.from("bar"))
                                  .build())
                              .build()))
                          .build())
                      .build();
                  RunCreateResponse run = client.evals().runs().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          run = openai.evals.runs.create(
            "eval_id",
            data_source: {source: {content: [{item: {foo: "bar"}}], type: :file_content}, type: :jsonl}
          )
          
          puts(run)
          """,
      },
      response: """
        {
          "object": "eval.run",
          "id": "evalrun_67e57965b480819094274e3a32235e4c",
          "eval_id": "eval_67e579652b548190aaa83ada4b125f47",
          "report_url": "https://platform.openai.com/evaluations/eval_67e579652b548190aaa83ada4b125f47&run_id=evalrun_67e57965b480819094274e3a32235e4c",
          "status": "queued",
          "model": "gpt-4o-mini",
          "name": "gpt-4o-mini",
          "created_at": 1743092069,
          "result_counts": {
            "total": 0,
            "errored": 0,
            "failed": 0,
            "passed": 0
          },
          "per_model_usage": null,
          "per_testing_criteria_results": null,
          "data_source": {
            "type": "completions",
            "source": {
              "type": "file_content",
              "content": [
                {
                  "item": {
                    "input": "Tech Company Launches Advanced Artificial Intelligence Platform",
                    "ground_truth": "Technology"
                  }
                }
              ]
            },
            "input_messages": {
              "type": "template",
              "template": [
                {
                  "type": "message",
                  "role": "developer",
                  "content": {
                    "type": "input_text",
                    "text": "Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.
        
        # Steps
        
        1. Analyze the content of the news headline to understand its primary focus.
        2. Extract the subject matter, identifying any key indicators or keywords.
        3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.
        4. Ensure only one category is selected per headline.
        
        # Output Format
        
        Respond with the chosen category as a single word. For instance: "Technology", "Markets", "World", "Business", or "Sports".
        
        # Examples
        
        **Input**: "Apple Unveils New iPhone Model, Featuring Advanced AI Features"
        **Output**: "Technology"
        
        **Input**: "Global Stocks Mixed as Investors Await Central Bank Decisions"
        **Output**: "Markets"
        
        **Input**: "War in Ukraine: Latest Updates on Negotiation Status"
        **Output**: "World"
        
        **Input**: "Microsoft in Talks to Acquire Gaming Company for $2 Billion"
        **Output**: "Business"
        
        **Input**: "Manchester United Secures Win in Premier League Football Match"
        **Output**: "Sports"
        
        # Notes
        
        - If the headline appears to fit into more than one category, choose the most dominant theme.
        - Keywords or phrases such as "stocks", "company acquisition", "match", or technological brands can be good indicators for classification.
        "
                  }
                },
                {
                  "type": "message",
                  "role": "user",
                  "content": {
                    "type": "input_text",
                    "text": "{{item.input}}"
                  }
                }
              ]
            },
            "model": "gpt-4o-mini",
            "sampling_params": {
              "seed": 42,
              "temperature": 1.0,
              "top_p": 1.0,
              "max_completions_tokens": 2048
            }
          },
          "error": null,
          "metadata": {}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Evals.deleteEvalRun,
  "x-oaiMeta",
  #{
    name: "Delete eval run",
    group: "evals",
    path: "delete",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/eval_123abc/runs/evalrun_abc456 \\
            -X DELETE \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          run = client.evals.runs.delete(
              run_id="run_id",
              eval_id="eval_id",
          )
          print(run.run_id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const deleted = await openai.evals.runs.delete(
            "eval_123abc",
            "evalrun_abc456"
          );
          console.log(deleted);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const run = await client.evals.runs.delete('run_id', { eval_id: 'eval_id' });
          
          console.log(run.run_id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.runs.RunDeleteParams;
          import com.openai.models.evals.runs.RunDeleteResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunDeleteParams params = RunDeleteParams.builder()
                      .evalId("eval_id")
                      .runId("run_id")
                      .build();
                  RunDeleteResponse run = client.evals().runs().delete(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          run = openai.evals.runs.delete("run_id", eval_id: "eval_id")
          
          puts(run)
          """,
      },
      response: """
        {
          "object": "eval.run.deleted",
          "deleted": true,
          "run_id": "evalrun_abc456"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Evals.getEvalRun,
  "x-oaiMeta",
  #{
    name: "Get an eval run",
    group: "evals",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a/runs/evalrun_67abd54d60ec8190832b46859da808f7 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          run = client.evals.runs.retrieve(
              run_id="run_id",
              eval_id="eval_id",
          )
          print(run.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const run = await openai.evals.runs.retrieve(
            "evalrun_67abd54d60ec8190832b46859da808f7",
            { eval_id: "eval_67abd54d9b0081909a86353f6fb9317a" }
          );
          console.log(run);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const run = await client.evals.runs.retrieve('run_id', { eval_id: 'eval_id' });
          
          console.log(run.id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.runs.RunRetrieveParams;
          import com.openai.models.evals.runs.RunRetrieveResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunRetrieveParams params = RunRetrieveParams.builder()
                      .evalId("eval_id")
                      .runId("run_id")
                      .build();
                  RunRetrieveResponse run = client.evals().runs().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          run = openai.evals.runs.retrieve("run_id", eval_id: "eval_id")
          
          puts(run)
          """,
      },
      response: """
        {
          "object": "eval.run",
          "id": "evalrun_67abd54d60ec8190832b46859da808f7",
          "eval_id": "eval_67abd54d9b0081909a86353f6fb9317a",
          "report_url": "https://platform.openai.com/evaluations/eval_67abd54d9b0081909a86353f6fb9317a?run_id=evalrun_67abd54d60ec8190832b46859da808f7",
          "status": "queued",
          "model": "gpt-4o-mini",
          "name": "gpt-4o-mini",
          "created_at": 1743092069,
          "result_counts": {
            "total": 0,
            "errored": 0,
            "failed": 0,
            "passed": 0
          },
          "per_model_usage": null,
          "per_testing_criteria_results": null,
          "data_source": {
            "type": "completions",
            "source": {
              "type": "file_content",
              "content": [
                {
                  "item": {
                    "input": "Tech Company Launches Advanced Artificial Intelligence Platform",
                    "ground_truth": "Technology"
                  }
                },
                {
                  "item": {
                    "input": "Central Bank Increases Interest Rates Amid Inflation Concerns",
                    "ground_truth": "Markets"
                  }
                },
                {
                  "item": {
                    "input": "International Summit Addresses Climate Change Strategies",
                    "ground_truth": "World"
                  }
                },
                {
                  "item": {
                    "input": "Major Retailer Reports Record-Breaking Holiday Sales",
                    "ground_truth": "Business"
                  }
                },
                {
                  "item": {
                    "input": "National Team Qualifies for World Championship Finals",
                    "ground_truth": "Sports"
                  }
                },
                {
                  "item": {
                    "input": "Stock Markets Rally After Positive Economic Data Released",
                    "ground_truth": "Markets"
                  }
                },
                {
                  "item": {
                    "input": "Global Manufacturer Announces Merger with Competitor",
                    "ground_truth": "Business"
                  }
                },
                {
                  "item": {
                    "input": "Breakthrough in Renewable Energy Technology Unveiled",
                    "ground_truth": "Technology"
                  }
                },
                {
                  "item": {
                    "input": "World Leaders Sign Historic Climate Agreement",
                    "ground_truth": "World"
                  }
                },
                {
                  "item": {
                    "input": "Professional Athlete Sets New Record in Championship Event",
                    "ground_truth": "Sports"
                  }
                },
                {
                  "item": {
                    "input": "Financial Institutions Adapt to New Regulatory Requirements",
                    "ground_truth": "Business"
                  }
                },
                {
                  "item": {
                    "input": "Tech Conference Showcases Advances in Artificial Intelligence",
                    "ground_truth": "Technology"
                  }
                },
                {
                  "item": {
                    "input": "Global Markets Respond to Oil Price Fluctuations",
                    "ground_truth": "Markets"
                  }
                },
                {
                  "item": {
                    "input": "International Cooperation Strengthened Through New Treaty",
                    "ground_truth": "World"
                  }
                },
                {
                  "item": {
                    "input": "Sports League Announces Revised Schedule for Upcoming Season",
                    "ground_truth": "Sports"
                  }
                }
              ]
            },
            "input_messages": {
              "type": "template",
              "template": [
                {
                  "type": "message",
                  "role": "developer",
                  "content": {
                    "type": "input_text",
                    "text": "Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.
        
        # Steps
        
        1. Analyze the content of the news headline to understand its primary focus.
        2. Extract the subject matter, identifying any key indicators or keywords.
        3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.
        4. Ensure only one category is selected per headline.
        
        # Output Format
        
        Respond with the chosen category as a single word. For instance: "Technology", "Markets", "World", "Business", or "Sports".
        
        # Examples
        
        **Input**: "Apple Unveils New iPhone Model, Featuring Advanced AI Features"
        **Output**: "Technology"
        
        **Input**: "Global Stocks Mixed as Investors Await Central Bank Decisions"
        **Output**: "Markets"
        
        **Input**: "War in Ukraine: Latest Updates on Negotiation Status"
        **Output**: "World"
        
        **Input**: "Microsoft in Talks to Acquire Gaming Company for $2 Billion"
        **Output**: "Business"
        
        **Input**: "Manchester United Secures Win in Premier League Football Match"
        **Output**: "Sports"
        
        # Notes
        
        - If the headline appears to fit into more than one category, choose the most dominant theme.
        - Keywords or phrases such as "stocks", "company acquisition", "match", or technological brands can be good indicators for classification.
        "
                  }
                },
                {
                  "type": "message",
                  "role": "user",
                  "content": {
                    "type": "input_text",
                    "text": "{{item.input}}"
                  }
                }
              ]
            },
            "model": "gpt-4o-mini",
            "sampling_params": {
              "seed": 42,
              "temperature": 1.0,
              "top_p": 1.0,
              "max_completions_tokens": 2048
            }
          },
          "error": null,
          "metadata": {}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Evals.cancelEvalRun,
  "x-oaiMeta",
  #{
    name: "Cancel eval run",
    group: "evals",
    path: "post",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a/runs/evalrun_67abd54d60ec8190832b46859da808f7/cancel \\
            -X POST \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          response = client.evals.runs.cancel(
              run_id="run_id",
              eval_id="eval_id",
          )
          print(response.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const canceledRun = await openai.evals.runs.cancel(
            "evalrun_67abd54d60ec8190832b46859da808f7",
            { eval_id: "eval_67abd54d9b0081909a86353f6fb9317a" }
          );
          console.log(canceledRun);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const response = await client.evals.runs.cancel('run_id', { eval_id: 'eval_id' });
          
          console.log(response.id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.runs.RunCancelParams;
          import com.openai.models.evals.runs.RunCancelResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunCancelParams params = RunCancelParams.builder()
                      .evalId("eval_id")
                      .runId("run_id")
                      .build();
                  RunCancelResponse response = client.evals().runs().cancel(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          response = openai.evals.runs.cancel("run_id", eval_id: "eval_id")
          
          puts(response)
          """,
      },
      response: """
        {
          "object": "eval.run",
          "id": "evalrun_67abd54d60ec8190832b46859da808f7",
          "eval_id": "eval_67abd54d9b0081909a86353f6fb9317a",
          "report_url": "https://platform.openai.com/evaluations/eval_67abd54d9b0081909a86353f6fb9317a?run_id=evalrun_67abd54d60ec8190832b46859da808f7",
          "status": "canceled",
          "model": "gpt-4o-mini",
          "name": "gpt-4o-mini",
          "created_at": 1743092069,
          "result_counts": {
            "total": 0,
            "errored": 0,
            "failed": 0,
            "passed": 0
          },
          "per_model_usage": null,
          "per_testing_criteria_results": null,
          "data_source": {
            "type": "completions",
            "source": {
              "type": "file_content",
              "content": [
                {
                  "item": {
                    "input": "Tech Company Launches Advanced Artificial Intelligence Platform",
                    "ground_truth": "Technology"
                  }
                },
                {
                  "item": {
                    "input": "Central Bank Increases Interest Rates Amid Inflation Concerns",
                    "ground_truth": "Markets"
                  }
                },
                {
                  "item": {
                    "input": "International Summit Addresses Climate Change Strategies",
                    "ground_truth": "World"
                  }
                },
                {
                  "item": {
                    "input": "Major Retailer Reports Record-Breaking Holiday Sales",
                    "ground_truth": "Business"
                  }
                },
                {
                  "item": {
                    "input": "National Team Qualifies for World Championship Finals",
                    "ground_truth": "Sports"
                  }
                },
                {
                  "item": {
                    "input": "Stock Markets Rally After Positive Economic Data Released",
                    "ground_truth": "Markets"
                  }
                },
                {
                  "item": {
                    "input": "Global Manufacturer Announces Merger with Competitor",
                    "ground_truth": "Business"
                  }
                },
                {
                  "item": {
                    "input": "Breakthrough in Renewable Energy Technology Unveiled",
                    "ground_truth": "Technology"
                  }
                },
                {
                  "item": {
                    "input": "World Leaders Sign Historic Climate Agreement",
                    "ground_truth": "World"
                  }
                },
                {
                  "item": {
                    "input": "Professional Athlete Sets New Record in Championship Event",
                    "ground_truth": "Sports"
                  }
                },
                {
                  "item": {
                    "input": "Financial Institutions Adapt to New Regulatory Requirements",
                    "ground_truth": "Business"
                  }
                },
                {
                  "item": {
                    "input": "Tech Conference Showcases Advances in Artificial Intelligence",
                    "ground_truth": "Technology"
                  }
                },
                {
                  "item": {
                    "input": "Global Markets Respond to Oil Price Fluctuations",
                    "ground_truth": "Markets"
                  }
                },
                {
                  "item": {
                    "input": "International Cooperation Strengthened Through New Treaty",
                    "ground_truth": "World"
                  }
                },
                {
                  "item": {
                    "input": "Sports League Announces Revised Schedule for Upcoming Season",
                    "ground_truth": "Sports"
                  }
                }
              ]
            },
            "input_messages": {
              "type": "template",
              "template": [
                {
                  "type": "message",
                  "role": "developer",
                  "content": {
                    "type": "input_text",
                    "text": "Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.
        
        # Steps
        
        1. Analyze the content of the news headline to understand its primary focus.
        2. Extract the subject matter, identifying any key indicators or keywords.
        3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.
        4. Ensure only one category is selected per headline.
        
        # Output Format
        
        Respond with the chosen category as a single word. For instance: "Technology", "Markets", "World", "Business", or "Sports".
        
        # Examples
        
        **Input**: "Apple Unveils New iPhone Model, Featuring Advanced AI Features"
        **Output**: "Technology"
        
        **Input**: "Global Stocks Mixed as Investors Await Central Bank Decisions"
        **Output**: "Markets"
        
        **Input**: "War in Ukraine: Latest Updates on Negotiation Status"
        **Output**: "World"
        
        **Input**: "Microsoft in Talks to Acquire Gaming Company for $2 Billion"
        **Output**: "Business"
        
        **Input**: "Manchester United Secures Win in Premier League Football Match"
        **Output**: "Sports"
        
        # Notes
        
        - If the headline appears to fit into more than one category, choose the most dominant theme.
        - Keywords or phrases such as "stocks", "company acquisition", "match", or technological brands can be good indicators for classification.
        "
                  }
                },
                {
                  "type": "message",
                  "role": "user",
                  "content": {
                    "type": "input_text",
                    "text": "{{item.input}}"
                  }
                }
              ]
            },
            "model": "gpt-4o-mini",
            "sampling_params": {
              "seed": 42,
              "temperature": 1.0,
              "top_p": 1.0,
              "max_completions_tokens": 2048
            }
          },
          "error": null,
          "metadata": {}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Evals.getEvalRunOutputItems,
  "x-oaiMeta",
  #{
    name: "Get eval run output items",
    group: "evals",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/egroup_67abd54d9b0081909a86353f6fb9317a/runs/erun_67abd54d60ec8190832b46859da808f7/output_items \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.evals.runs.output_items.list(
              run_id="run_id",
              eval_id="eval_id",
          )
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const outputItems = await openai.evals.runs.outputItems.list(
            "egroup_67abd54d9b0081909a86353f6fb9317a",
            "erun_67abd54d60ec8190832b46859da808f7"
          );
          console.log(outputItems);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const outputItemListResponse of client.evals.runs.outputItems.list('run_id', {
            eval_id: 'eval_id',
          })) {
            console.log(outputItemListResponse.id);
          }
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.runs.outputitems.OutputItemListPage;
          import com.openai.models.evals.runs.outputitems.OutputItemListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  OutputItemListParams params = OutputItemListParams.builder()
                      .evalId("eval_id")
                      .runId("run_id")
                      .build();
                  OutputItemListPage page = client.evals().runs().outputItems().list(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.evals.runs.output_items.list("run_id", eval_id: "eval_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "eval.run.output_item",
              "id": "outputitem_67e5796c28e081909917bf79f6e6214d",
              "created_at": 1743092076,
              "run_id": "evalrun_67abd54d60ec8190832b46859da808f7",
              "eval_id": "eval_67abd54d9b0081909a86353f6fb9317a",
              "status": "pass",
              "datasource_item_id": 5,
              "datasource_item": {
                "input": "Stock Markets Rally After Positive Economic Data Released",
                "ground_truth": "Markets"
              },
              "results": [
                {
                  "name": "String check-a2486074-d803-4445-b431-ad2262e85d47",
                  "sample": null,
                  "passed": true,
                  "score": 1.0
                }
              ],
              "sample": {
                "input": [
                  {
                    "role": "developer",
                    "content": "Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.
        
        # Steps
        
        1. Analyze the content of the news headline to understand its primary focus.
        2. Extract the subject matter, identifying any key indicators or keywords.
        3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.
        4. Ensure only one category is selected per headline.
        
        # Output Format
        
        Respond with the chosen category as a single word. For instance: "Technology", "Markets", "World", "Business", or "Sports".
        
        # Examples
        
        **Input**: "Apple Unveils New iPhone Model, Featuring Advanced AI Features"
        **Output**: "Technology"
        
        **Input**: "Global Stocks Mixed as Investors Await Central Bank Decisions"
        **Output**: "Markets"
        
        **Input**: "War in Ukraine: Latest Updates on Negotiation Status"
        **Output**: "World"
        
        **Input**: "Microsoft in Talks to Acquire Gaming Company for $2 Billion"
        **Output**: "Business"
        
        **Input**: "Manchester United Secures Win in Premier League Football Match"
        **Output**: "Sports"
        
        # Notes
        
        - If the headline appears to fit into more than one category, choose the most dominant theme.
        - Keywords or phrases such as "stocks", "company acquisition", "match", or technological brands can be good indicators for classification.
        ",
                    "tool_call_id": null,
                    "tool_calls": null,
                    "function_call": null
                  },
                  {
                    "role": "user",
                    "content": "Stock Markets Rally After Positive Economic Data Released",
                    "tool_call_id": null,
                    "tool_calls": null,
                    "function_call": null
                  }
                ],
                "output": [
                  {
                    "role": "assistant",
                    "content": "Markets",
                    "tool_call_id": null,
                    "tool_calls": null,
                    "function_call": null
                  }
                ],
                "finish_reason": "stop",
                "model": "gpt-4o-mini-2024-07-18",
                "usage": {
                  "total_tokens": 325,
                  "completion_tokens": 2,
                  "prompt_tokens": 323,
                  "cached_tokens": 0
                },
                "error": null,
                "temperature": 1.0,
                "max_completion_tokens": 2048,
                "top_p": 1.0,
                "seed": 42
              }
            }
          ],
          "first_id": "outputitem_67e5796c28e081909917bf79f6e6214d",
          "last_id": "outputitem_67e5796c28e081909917bf79f6e6214d",
          "has_more": true
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Evals.getEvalRunOutputItems, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Evals.getEvalRunOutputItem,
  "x-oaiMeta",
  #{
    name: "Get an output item of an eval run",
    group: "evals",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a/runs/evalrun_67abd54d60ec8190832b46859da808f7/output_items/outputitem_67abd55eb6548190bb580745d5644a33 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          output_item = client.evals.runs.output_items.retrieve(
              output_item_id="output_item_id",
              eval_id="eval_id",
              run_id="run_id",
          )
          print(output_item.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          const outputItem = await openai.evals.runs.outputItems.retrieve(
            "outputitem_67abd55eb6548190bb580745d5644a33",
            {
              eval_id: "eval_67abd54d9b0081909a86353f6fb9317a",
              run_id: "evalrun_67abd54d60ec8190832b46859da808f7",
            }
          );
          console.log(outputItem);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const outputItem = await client.evals.runs.outputItems.retrieve('output_item_id', {
            eval_id: 'eval_id',
            run_id: 'run_id',
          });
          
          console.log(outputItem.id);
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.evals.runs.outputitems.OutputItemRetrieveParams;
          import com.openai.models.evals.runs.outputitems.OutputItemRetrieveResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  OutputItemRetrieveParams params = OutputItemRetrieveParams.builder()
                      .evalId("eval_id")
                      .runId("run_id")
                      .outputItemId("output_item_id")
                      .build();
                  OutputItemRetrieveResponse outputItem = client.evals().runs().outputItems().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          output_item = openai.evals.runs.output_items.retrieve("output_item_id", eval_id: "eval_id", run_id: "run_id")
          
          puts(output_item)
          """,
      },
      response: """
        {
          "object": "eval.run.output_item",
          "id": "outputitem_67e5796c28e081909917bf79f6e6214d",
          "created_at": 1743092076,
          "run_id": "evalrun_67abd54d60ec8190832b46859da808f7",
          "eval_id": "eval_67abd54d9b0081909a86353f6fb9317a",
          "status": "pass",
          "datasource_item_id": 5,
          "datasource_item": {
            "input": "Stock Markets Rally After Positive Economic Data Released",
            "ground_truth": "Markets"
          },
          "results": [
            {
              "name": "String check-a2486074-d803-4445-b431-ad2262e85d47",
              "sample": null,
              "passed": true,
              "score": 1.0
            }
          ],
          "sample": {
            "input": [
              {
                "role": "developer",
                "content": "Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.
        
        # Steps
        
        1. Analyze the content of the news headline to understand its primary focus.
        2. Extract the subject matter, identifying any key indicators or keywords.
        3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.
        4. Ensure only one category is selected per headline.
        
        # Output Format
        
        Respond with the chosen category as a single word. For instance: "Technology", "Markets", "World", "Business", or "Sports".
        
        # Examples
        
        **Input**: "Apple Unveils New iPhone Model, Featuring Advanced AI Features"
        **Output**: "Technology"
        
        **Input**: "Global Stocks Mixed as Investors Await Central Bank Decisions"
        **Output**: "Markets"
        
        **Input**: "War in Ukraine: Latest Updates on Negotiation Status"
        **Output**: "World"
        
        **Input**: "Microsoft in Talks to Acquire Gaming Company for $2 Billion"
        **Output**: "Business"
        
        **Input**: "Manchester United Secures Win in Premier League Football Match"
        **Output**: "Sports"
        
        # Notes
        
        - If the headline appears to fit into more than one category, choose the most dominant theme.
        - Keywords or phrases such as "stocks", "company acquisition", "match", or technological brands can be good indicators for classification.
        ",
                "tool_call_id": null,
                "tool_calls": null,
                "function_call": null
              },
              {
                "role": "user",
                "content": "Stock Markets Rally After Positive Economic Data Released",
                "tool_call_id": null,
                "tool_calls": null,
                "function_call": null
              }
            ],
            "output": [
              {
                "role": "assistant",
                "content": "Markets",
                "tool_call_id": null,
                "tool_calls": null,
                "function_call": null
              }
            ],
            "finish_reason": "stop",
            "model": "gpt-4o-mini-2024-07-18",
            "usage": {
              "total_tokens": 325,
              "completion_tokens": 2,
              "prompt_tokens": 323,
              "cached_tokens": 0
            },
            "error": null,
            "temperature": 1.0,
            "max_completion_tokens": 2048,
            "top_p": 1.0,
            "seed": 42
          }
        }
        
        """,
    },
  }
);
