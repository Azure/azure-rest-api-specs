import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Graders.runGrader,
  "x-oaiMeta",
  #{
    name: "Run grader",
    beta: true,
    group: "graders",
    examples: #[
      #{
        title: "Score text alignment",
        request: #{
          curl: """
            curl -X POST https://api.openai.com/v1/fine_tuning/alpha/graders/run \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "grader": {
                  "type": "score_model",
                  "name": "Example score model grader",
                  "input": [
                    {
                      "role": "user",
                      "content": [
                        {
                          "type": "input_text",
                          "text": "Score how close the reference answer is to the model answer on a 0-1 scale. Return only the score.
            
            Reference answer: {{item.reference_answer}}
            
            Model answer: {{sample.output_text}}"
                        }
                      ]
                    }
                  ],
                  "model": "gpt-5-mini",
                  "sampling_params": {
                    "temperature": 1,
                    "top_p": 1,
                    "seed": 42
                  }
                },
                "item": {
                  "reference_answer": "fuzzy wuzzy was a bear"
                },
                "model_sample": "fuzzy wuzzy was a bear"
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            response = client.fine_tuning.alpha.graders.run(
                grader={
                    "input": "input",
                    "name": "name",
                    "operation": "eq",
                    "reference": "reference",
                    "type": "string_check",
                },
                model_sample="model_sample",
            )
            print(response.metadata)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const result = await openai.fineTuning.alpha.graders.run({
              grader: {
                type: "score_model",
                name: "Example score model grader",
                input: [
                  {
                    role: "user",
                    content: [
                      {
                        type: "input_text",
                        text: "Score how close the reference answer is to the model answer on a 0-1 scale. Return only the score.
            
            Reference answer: {{item.reference_answer}}
            
            Model answer: {{sample.output_text}}",
                      },
                    ],
                  },
                ],
                model: "gpt-5-mini",
                sampling_params: { temperature: 1, top_p: 1, seed: 42 },
              },
              item: { reference_answer: "fuzzy wuzzy was a bear" },
              model_sample: "fuzzy wuzzy was a bear",
            });
            console.log(result);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.fineTuning.alpha.graders.run({
              grader: {
                input: 'input',
                name: 'name',
                operation: 'eq',
                reference: 'reference',
                type: 'string_check',
              },
              model_sample: 'model_sample',
            });
            
            console.log(response.metadata);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.FineTuning.Alpha.Graders.Run(context.TODO(), openai.FineTuningAlphaGraderRunParams{
            		Grader: openai.FineTuningAlphaGraderRunParamsGraderUnion{
            			OfStringCheck: &openai.StringCheckGraderParam{
            				Input:     "input",
            				Name:      "name",
            				Operation: openai.StringCheckGraderOperationEq,
            				Reference: "reference",
            			},
            		},
            		ModelSample: "model_sample",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.Metadata)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.alpha.graders.GraderRunParams;
            import com.openai.models.finetuning.alpha.graders.GraderRunResponse;
            import com.openai.models.graders.gradermodels.StringCheckGrader;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    GraderRunParams params = GraderRunParams.builder()
                        .grader(StringCheckGrader.builder()
                            .input("input")
                            .name("name")
                            .operation(StringCheckGrader.Operation.EQ)
                            .reference("reference")
                            .build())
                        .modelSample("model_sample")
                        .build();
                    GraderRunResponse response = client.fineTuning().alpha().graders().run(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.fine_tuning.alpha.graders.run(
              grader: {input: "input", name: "name", operation: :eq, reference: "reference", type: :string_check},
              model_sample: "model_sample"
            )
            
            puts(response)
            """,
        },
        response: """
          {
            "reward": 1.0,
            "metadata": {
              "name": "Example score model grader",
              "type": "score_model",
              "errors": {
                "formula_parse_error": false,
                "sample_parse_error": false,
                "truncated_observation_error": false,
                "unresponsive_reward_error": false,
                "invalid_variable_error": false,
                "other_error": false,
                "python_grader_server_error": false,
                "python_grader_server_error_type": null,
                "python_grader_runtime_error": false,
                "python_grader_runtime_error_details": null,
                "model_grader_server_error": false,
                "model_grader_refusal_error": false,
                "model_grader_parse_error": false,
                "model_grader_server_error_details": null
              },
              "execution_time": 4.365238428115845,
              "scores": {},
              "token_usage": {
                "prompt_tokens": 190,
                "total_tokens": 324,
                "completion_tokens": 134,
                "cached_tokens": 0
              },
              "sampled_model_name": "gpt-4o-2024-08-06"
            },
            "sub_rewards": {},
            "model_grader_token_usage_per_model": {
              "gpt-4o-2024-08-06": {
                "prompt_tokens": 190,
                "total_tokens": 324,
                "completion_tokens": 134,
                "cached_tokens": 0
              }
            }
          }
          
          """,
      },
      #{
        title: "Score an image caption",
        request: #{
          curl: """
            curl -X POST https://api.openai.com/v1/fine_tuning/alpha/graders/run \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "grader": {
                  "type": "score_model",
                  "name": "Image caption grader",
                  "input": [
                    {
                      "role": "user",
                      "content": [
                        {
                          "type": "input_text",
                          "text": "Score how well the provided caption matches the image on a 0-1 scale. Only return the score.
            
            Caption: {{sample.output_text}}"
                        },
                        {
                          "type": "input_image",
                          "image_url": "https://example.com/dog-catching-ball.png",
                          "file_id": null,
                          "detail": "high"
                        }
                      ]
                    }
                  ],
                  "model": "gpt-5-mini",
                  "sampling_params": {
                    "temperature": 0.2
                  }
                },
                "item": {
                  "expected_caption": "A golden retriever jumps to catch a tennis ball"
                },
                "model_sample": "A dog leaps to grab a tennis ball mid-air"
              }'
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.fineTuning.alpha.graders.run({
              grader: {
                input: 'input',
                name: 'name',
                operation: 'eq',
                reference: 'reference',
                type: 'string_check',
              },
              model_sample: 'model_sample',
            });
            
            console.log(response.metadata);
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            response = client.fine_tuning.alpha.graders.run(
                grader={
                    "input": "input",
                    "name": "name",
                    "operation": "eq",
                    "reference": "reference",
                    "type": "string_check",
                },
                model_sample="model_sample",
            )
            print(response.metadata)
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.FineTuning.Alpha.Graders.Run(context.TODO(), openai.FineTuningAlphaGraderRunParams{
            		Grader: openai.FineTuningAlphaGraderRunParamsGraderUnion{
            			OfStringCheck: &openai.StringCheckGraderParam{
            				Input:     "input",
            				Name:      "name",
            				Operation: openai.StringCheckGraderOperationEq,
            				Reference: "reference",
            			},
            		},
            		ModelSample: "model_sample",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.Metadata)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.alpha.graders.GraderRunParams;
            import com.openai.models.finetuning.alpha.graders.GraderRunResponse;
            import com.openai.models.graders.gradermodels.StringCheckGrader;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    GraderRunParams params = GraderRunParams.builder()
                        .grader(StringCheckGrader.builder()
                            .input("input")
                            .name("name")
                            .operation(StringCheckGrader.Operation.EQ)
                            .reference("reference")
                            .build())
                        .modelSample("model_sample")
                        .build();
                    GraderRunResponse response = client.fineTuning().alpha().graders().run(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.fine_tuning.alpha.graders.run(
              grader: {input: "input", name: "name", operation: :eq, reference: "reference", type: :string_check},
              model_sample: "model_sample"
            )
            
            puts(response)
            """,
        },
      },
      #{
        title: "Score an audio response",
        request: #{
          curl: """
            curl -X POST https://api.openai.com/v1/fine_tuning/alpha/graders/run \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "grader": {
                  "type": "score_model",
                  "name": "Audio clarity grader",
                  "input": [
                    {
                      "role": "user",
                      "content": [
                        {
                          "type": "input_text",
                          "text": "Listen to the clip and return a confidence score from 0 to 1 that the speaker said: {{item.target_phrase}}"
                        },
                        {
                          "type": "input_audio",
                          "input_audio": {
                            "data": "{{item.audio_clip_b64}}",
                            "format": "mp3"
                          }
                        }
                      ]
                    }
                  ],
                  "model": "gpt-audio",
                  "sampling_params": {
                    "temperature": 0.2,
                    "top_p": 1,
                    "seed": 123
                  }
                },
                "item": {
                  "target_phrase": "Please deliver the package on Tuesday",
                  "audio_clip_b64": "<base64-encoded mp3>"
                },
                "model_sample": "Please deliver the package on Tuesday"
              }'
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.fineTuning.alpha.graders.run({
              grader: {
                input: 'input',
                name: 'name',
                operation: 'eq',
                reference: 'reference',
                type: 'string_check',
              },
              model_sample: 'model_sample',
            });
            
            console.log(response.metadata);
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            response = client.fine_tuning.alpha.graders.run(
                grader={
                    "input": "input",
                    "name": "name",
                    "operation": "eq",
                    "reference": "reference",
                    "type": "string_check",
                },
                model_sample="model_sample",
            )
            print(response.metadata)
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.FineTuning.Alpha.Graders.Run(context.TODO(), openai.FineTuningAlphaGraderRunParams{
            		Grader: openai.FineTuningAlphaGraderRunParamsGraderUnion{
            			OfStringCheck: &openai.StringCheckGraderParam{
            				Input:     "input",
            				Name:      "name",
            				Operation: openai.StringCheckGraderOperationEq,
            				Reference: "reference",
            			},
            		},
            		ModelSample: "model_sample",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.Metadata)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.alpha.graders.GraderRunParams;
            import com.openai.models.finetuning.alpha.graders.GraderRunResponse;
            import com.openai.models.graders.gradermodels.StringCheckGrader;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    GraderRunParams params = GraderRunParams.builder()
                        .grader(StringCheckGrader.builder()
                            .input("input")
                            .name("name")
                            .operation(StringCheckGrader.Operation.EQ)
                            .reference("reference")
                            .build())
                        .modelSample("model_sample")
                        .build();
                    GraderRunResponse response = client.fineTuning().alpha().graders().run(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.fine_tuning.alpha.graders.run(
              grader: {input: "input", name: "name", operation: :eq, reference: "reference", type: :string_check},
              model_sample: "model_sample"
            )
            
            puts(response)
            """,
        },
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Graders.validateGrader,
  "x-oaiMeta",
  #{
    name: "Validate grader",
    beta: true,
    group: "graders",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/fine_tuning/alpha/graders/validate \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
              "grader": {
                "type": "string_check",
                "name": "Example string check grader",
                "input": "{{sample.output_text}}",
                "reference": "{{item.label}}",
                "operation": "eq"
              }
            }'
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const response = await client.fineTuning.alpha.graders.validate({
            grader: {
              input: 'input',
              name: 'name',
              operation: 'eq',
              reference: 'reference',
              type: 'string_check',
            },
          });
          
          console.log(response.grader);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          response = client.fine_tuning.alpha.graders.validate(
              grader={
                  "input": "input",
                  "name": "name",
                  "operation": "eq",
                  "reference": "reference",
                  "type": "string_check",
              },
          )
          print(response.grader)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	response, err := client.FineTuning.Alpha.Graders.Validate(context.TODO(), openai.FineTuningAlphaGraderValidateParams{
          		Grader: openai.FineTuningAlphaGraderValidateParamsGraderUnion{
          			OfStringCheckGrader: &openai.StringCheckGraderParam{
          				Input:     "input",
          				Name:      "name",
          				Operation: openai.StringCheckGraderOperationEq,
          				Reference: "reference",
          			},
          		},
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", response.Grader)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.finetuning.alpha.graders.GraderValidateParams;
          import com.openai.models.finetuning.alpha.graders.GraderValidateResponse;
          import com.openai.models.graders.gradermodels.StringCheckGrader;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  GraderValidateParams params = GraderValidateParams.builder()
                      .grader(StringCheckGrader.builder()
                          .input("input")
                          .name("name")
                          .operation(StringCheckGrader.Operation.EQ)
                          .reference("reference")
                          .build())
                      .build();
                  GraderValidateResponse response = client.fineTuning().alpha().graders().validate(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          response = openai.fine_tuning.alpha.graders.validate(
            grader: {input: "input", name: "name", operation: :eq, reference: "reference", type: :string_check}
          )
          
          puts(response)
          """,
      },
      response: """
        {
          "grader": {
            "type": "string_check",
            "name": "Example string check grader",
            "input": "{{sample.output_text}}",
            "reference": "{{item.label}}",
            "operation": "eq"
          }
        }
        
        """,
    },
  }
);
