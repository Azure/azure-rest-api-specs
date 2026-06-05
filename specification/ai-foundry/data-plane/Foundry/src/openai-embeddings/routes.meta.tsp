import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Embeddings.createEmbedding,
  "x-oaiMeta",
  #{
    name: "Create embeddings",
    group: "embeddings",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/embeddings \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
              "input": "The food was delicious and the waiter...",
              "model": "text-embedding-ada-002",
              "encoding_format": "float"
            }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          create_embedding_response = client.embeddings.create(
              input="The quick brown fox jumped over the lazy dog",
              model="text-embedding-3-small",
          )
          print(create_embedding_response.data)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const embedding = await openai.embeddings.create({
              model: "text-embedding-ada-002",
              input: "The quick brown fox jumped over the lazy dog",
              encoding_format: "float",
            });
          
            console.log(embedding);
          }
          
          main();
          
          """,
        csharp: """
          using System;
          
          using OpenAI.Embeddings;
          
          EmbeddingClient client = new(
              model: "text-embedding-3-small",
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          OpenAIEmbedding embedding = client.GenerateEmbedding(input: "The quick brown fox jumped over the lazy dog");
          ReadOnlyMemory<float> vector = embedding.ToFloats();
          
          for (int i = 0; i < vector.Length; i++)
          {
              Console.WriteLine($"  [{i,4}] = {vector.Span[i]}");
          }
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const createEmbeddingResponse = await client.embeddings.create({
            input: 'The quick brown fox jumped over the lazy dog',
            model: 'text-embedding-3-small',
          });
          
          console.log(createEmbeddingResponse.data);
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
          	createEmbeddingResponse, err := client.Embeddings.New(context.TODO(), openai.EmbeddingNewParams{
          		Input: openai.EmbeddingNewParamsInputUnion{
          			OfString: openai.String("The quick brown fox jumped over the lazy dog"),
          		},
          		Model: openai.EmbeddingModelTextEmbedding3Small,
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", createEmbeddingResponse.Data)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.embeddings.CreateEmbeddingResponse;
          import com.openai.models.embeddings.EmbeddingCreateParams;
          import com.openai.models.embeddings.EmbeddingModel;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  EmbeddingCreateParams params = EmbeddingCreateParams.builder()
                      .input("The quick brown fox jumped over the lazy dog")
                      .model(EmbeddingModel.TEXT_EMBEDDING_3_SMALL)
                      .build();
                  CreateEmbeddingResponse createEmbeddingResponse = client.embeddings().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          create_embedding_response = openai.embeddings.create(
            input: "The quick brown fox jumped over the lazy dog",
            model: :"text-embedding-3-small"
          )
          
          puts(create_embedding_response)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "embedding",
              "embedding": [
                0.0023064255,
                -0.009327292,
                .... (1536 floats total for ada-002)
                -0.0028842222,
              ],
              "index": 0
            }
          ],
          "model": "text-embedding-ada-002",
          "usage": {
            "prompt_tokens": 8,
            "total_tokens": 8
          }
        }
        
        """,
    },
  }
);
