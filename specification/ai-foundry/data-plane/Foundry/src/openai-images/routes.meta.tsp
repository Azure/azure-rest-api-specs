import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Images.createImageEditMultipart,
  "x-oaiMeta",
  #{
    name: "Create image edit",
    group: "images",
    examples: #[
      #{
        title: "Edit image",
        request: #{
          curl: """
            curl -s -D >(grep -i x-request-id >&2) \\
              -o >(jq -r '.data[0].b64_json' | base64 --decode > gift-basket.png) \\
              -X POST "https://api.openai.com/v1/images/edits" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -F "model=gpt-image-1.5" \\
              -F "image[]=@body-lotion.png" \\
              -F "image[]=@bath-bomb.png" \\
              -F "image[]=@incense-kit.png" \\
              -F "image[]=@soap.png" \\
              -F 'prompt=Create a lovely gift basket with these four items in it'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for image in client.images.edit(
                image=b"Example data",
                prompt="A cute baby sea otter wearing a beret",
            ):
              print(image)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI, { toFile } from "openai";
            
            const client = new OpenAI();
            
            const imageFiles = [
                "bath-bomb.png",
                "body-lotion.png",
                "incense-kit.png",
                "soap.png",
            ];
            
            const images = await Promise.all(
                imageFiles.map(async (file) =>
                    await toFile(fs.createReadStream(file), null, {
                        type: "image/png",
                    })
                ),
            );
            
            const rsp = await client.images.edit({
                model: "gpt-image-1.5",
                image: images,
                prompt: "Create a lovely gift basket with these four items in it",
            });
            
            // Save the image to a file
            const image_base64 = rsp.data[0].b64_json;
            const image_bytes = Buffer.from(image_base64, "base64");
            fs.writeFileSync("basket.png", image_bytes);
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const imagesResponse = await client.images.edit({
              image: fs.createReadStream('path/to/file'),
              prompt: 'A cute baby sea otter wearing a beret',
            });
            
            console.log(imagesResponse);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	imagesResponse, err := client.Images.Edit(context.TODO(), openai.ImageEditParams{
            		Image: openai.ImageEditParamsImageUnion{
            			OfFile: io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		},
            		Prompt: "A cute baby sea otter wearing a beret",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", imagesResponse)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.images.ImageEditParams;
            import com.openai.models.images.ImagesResponse;
            import java.io.ByteArrayInputStream;
            import java.io.InputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ImageEditParams params = ImageEditParams.builder()
                        .image(new ByteArrayInputStream("Example data".getBytes()))
                        .prompt("A cute baby sea otter wearing a beret")
                        .build();
                    ImagesResponse imagesResponse = client.images().edit(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            images_response = openai.images.edit(image: StringIO.new("Example data"), prompt: "A cute baby sea otter wearing a beret")
            
            puts(images_response)
            """,
        },
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl -s -N -X POST "https://api.openai.com/v1/images/edits" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -F "model=gpt-image-1.5" \\
              -F "image[]=@body-lotion.png" \\
              -F "image[]=@bath-bomb.png" \\
              -F "image[]=@incense-kit.png" \\
              -F "image[]=@soap.png" \\
              -F 'prompt=Create a lovely gift basket with these four items in it' \\
              -F "stream=true"
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for image in client.images.edit(
                image=b"Example data",
                prompt="A cute baby sea otter wearing a beret",
            ):
              print(image)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI, { toFile } from "openai";
            
            const client = new OpenAI();
            
            const imageFiles = [
                "bath-bomb.png",
                "body-lotion.png",
                "incense-kit.png",
                "soap.png",
            ];
            
            const images = await Promise.all(
                imageFiles.map(async (file) =>
                    await toFile(fs.createReadStream(file), null, {
                        type: "image/png",
                    })
                ),
            );
            
            const stream = await client.images.edit({
                model: "gpt-image-1.5",
                image: images,
                prompt: "Create a lovely gift basket with these four items in it",
                stream: true,
            });
            
            for await (const event of stream) {
                console.log(event);
            }
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const imagesResponse = await client.images.edit({
              image: fs.createReadStream('path/to/file'),
              prompt: 'A cute baby sea otter wearing a beret',
            });
            
            console.log(imagesResponse);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	imagesResponse, err := client.Images.Edit(context.TODO(), openai.ImageEditParams{
            		Image: openai.ImageEditParamsImageUnion{
            			OfFile: io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		},
            		Prompt: "A cute baby sea otter wearing a beret",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", imagesResponse)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.images.ImageEditParams;
            import com.openai.models.images.ImagesResponse;
            import java.io.ByteArrayInputStream;
            import java.io.InputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ImageEditParams params = ImageEditParams.builder()
                        .image(new ByteArrayInputStream("Example data".getBytes()))
                        .prompt("A cute baby sea otter wearing a beret")
                        .build();
                    ImagesResponse imagesResponse = client.images().edit(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            images_response = openai.images.edit(image: StringIO.new("Example data"), prompt: "A cute baby sea otter wearing a beret")
            
            puts(images_response)
            """,
        },
        response: """
          event: image_edit.partial_image
          data: {"type":"image_edit.partial_image","b64_json":"...","partial_image_index":0}
          
          event: image_edit.completed
          data: {"type":"image_edit.completed","b64_json":"...","usage":{"total_tokens":100,"input_tokens":50,"output_tokens":50,"input_tokens_details":{"text_tokens":10,"image_tokens":40}}}
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Images.createImageEditJson,
  "x-oaiMeta",
  #{
    name: "Create image edit",
    group: "images",
    examples: #[
      #{
        title: "Edit image",
        request: #{
          curl: """
            curl -s -D >(grep -i x-request-id >&2) \\
              -o >(jq -r '.data[0].b64_json' | base64 --decode > gift-basket.png) \\
              -X POST "https://api.openai.com/v1/images/edits" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -F "model=gpt-image-1.5" \\
              -F "image[]=@body-lotion.png" \\
              -F "image[]=@bath-bomb.png" \\
              -F "image[]=@incense-kit.png" \\
              -F "image[]=@soap.png" \\
              -F 'prompt=Create a lovely gift basket with these four items in it'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for image in client.images.edit(
                image=b"Example data",
                prompt="A cute baby sea otter wearing a beret",
            ):
              print(image)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI, { toFile } from "openai";
            
            const client = new OpenAI();
            
            const imageFiles = [
                "bath-bomb.png",
                "body-lotion.png",
                "incense-kit.png",
                "soap.png",
            ];
            
            const images = await Promise.all(
                imageFiles.map(async (file) =>
                    await toFile(fs.createReadStream(file), null, {
                        type: "image/png",
                    })
                ),
            );
            
            const rsp = await client.images.edit({
                model: "gpt-image-1.5",
                image: images,
                prompt: "Create a lovely gift basket with these four items in it",
            });
            
            // Save the image to a file
            const image_base64 = rsp.data[0].b64_json;
            const image_bytes = Buffer.from(image_base64, "base64");
            fs.writeFileSync("basket.png", image_bytes);
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const imagesResponse = await client.images.edit({
              image: fs.createReadStream('path/to/file'),
              prompt: 'A cute baby sea otter wearing a beret',
            });
            
            console.log(imagesResponse);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	imagesResponse, err := client.Images.Edit(context.TODO(), openai.ImageEditParams{
            		Image: openai.ImageEditParamsImageUnion{
            			OfFile: io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		},
            		Prompt: "A cute baby sea otter wearing a beret",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", imagesResponse)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.images.ImageEditParams;
            import com.openai.models.images.ImagesResponse;
            import java.io.ByteArrayInputStream;
            import java.io.InputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ImageEditParams params = ImageEditParams.builder()
                        .image(new ByteArrayInputStream("Example data".getBytes()))
                        .prompt("A cute baby sea otter wearing a beret")
                        .build();
                    ImagesResponse imagesResponse = client.images().edit(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            images_response = openai.images.edit(image: StringIO.new("Example data"), prompt: "A cute baby sea otter wearing a beret")
            
            puts(images_response)
            """,
        },
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl -s -N -X POST "https://api.openai.com/v1/images/edits" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -F "model=gpt-image-1.5" \\
              -F "image[]=@body-lotion.png" \\
              -F "image[]=@bath-bomb.png" \\
              -F "image[]=@incense-kit.png" \\
              -F "image[]=@soap.png" \\
              -F 'prompt=Create a lovely gift basket with these four items in it' \\
              -F "stream=true"
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for image in client.images.edit(
                image=b"Example data",
                prompt="A cute baby sea otter wearing a beret",
            ):
              print(image)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI, { toFile } from "openai";
            
            const client = new OpenAI();
            
            const imageFiles = [
                "bath-bomb.png",
                "body-lotion.png",
                "incense-kit.png",
                "soap.png",
            ];
            
            const images = await Promise.all(
                imageFiles.map(async (file) =>
                    await toFile(fs.createReadStream(file), null, {
                        type: "image/png",
                    })
                ),
            );
            
            const stream = await client.images.edit({
                model: "gpt-image-1.5",
                image: images,
                prompt: "Create a lovely gift basket with these four items in it",
                stream: true,
            });
            
            for await (const event of stream) {
                console.log(event);
            }
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const imagesResponse = await client.images.edit({
              image: fs.createReadStream('path/to/file'),
              prompt: 'A cute baby sea otter wearing a beret',
            });
            
            console.log(imagesResponse);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	imagesResponse, err := client.Images.Edit(context.TODO(), openai.ImageEditParams{
            		Image: openai.ImageEditParamsImageUnion{
            			OfFile: io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		},
            		Prompt: "A cute baby sea otter wearing a beret",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", imagesResponse)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.images.ImageEditParams;
            import com.openai.models.images.ImagesResponse;
            import java.io.ByteArrayInputStream;
            import java.io.InputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ImageEditParams params = ImageEditParams.builder()
                        .image(new ByteArrayInputStream("Example data".getBytes()))
                        .prompt("A cute baby sea otter wearing a beret")
                        .build();
                    ImagesResponse imagesResponse = client.images().edit(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            images_response = openai.images.edit(image: StringIO.new("Example data"), prompt: "A cute baby sea otter wearing a beret")
            
            puts(images_response)
            """,
        },
        response: """
          event: image_edit.partial_image
          data: {"type":"image_edit.partial_image","b64_json":"...","partial_image_index":0}
          
          event: image_edit.completed
          data: {"type":"image_edit.completed","b64_json":"...","usage":{"total_tokens":100,"input_tokens":50,"output_tokens":50,"input_tokens_details":{"text_tokens":10,"image_tokens":40}}}
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Images.createImage,
  "x-oaiMeta",
  #{
    name: "Create image",
    group: "images",
    examples: #[
      #{
        title: "Generate image",
        request: #{
          curl: """
            curl https://api.openai.com/v1/images/generations \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-image-1.5",
                "prompt": "A cute baby sea otter",
                "n": 1,
                "size": "1024x1024"
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for image in client.images.generate(
                prompt="A cute baby sea otter",
            ):
              print(image)
            """,
          javascript: """
            import OpenAI from "openai";
            import { writeFile } from "fs/promises";
            
            const client = new OpenAI();
            
            const img = await client.images.generate({
              model: "gpt-image-1.5",
              prompt: "A cute baby sea otter",
              n: 1,
              size: "1024x1024"
            });
            
            const imageBuffer = Buffer.from(img.data[0].b64_json, "base64");
            await writeFile("output.png", imageBuffer);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const imagesResponse = await client.images.generate({ prompt: 'A cute baby sea otter' });
            
            console.log(imagesResponse);
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
            	imagesResponse, err := client.Images.Generate(context.TODO(), openai.ImageGenerateParams{
            		Prompt: "A cute baby sea otter",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", imagesResponse)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.images.ImageGenerateParams;
            import com.openai.models.images.ImagesResponse;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ImageGenerateParams params = ImageGenerateParams.builder()
                        .prompt("A cute baby sea otter")
                        .build();
                    ImagesResponse imagesResponse = client.images().generate(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            images_response = openai.images.generate(prompt: "A cute baby sea otter")
            
            puts(images_response)
            """,
        },
        response: """
          {
            "created": 1713833628,
            "data": [
              {
                "b64_json": "..."
              }
            ],
            "usage": {
              "total_tokens": 100,
              "input_tokens": 50,
              "output_tokens": 50,
              "input_tokens_details": {
                "text_tokens": 10,
                "image_tokens": 40
              }
            }
          }
          
          """,
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/images/generations \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-image-1.5",
                "prompt": "A cute baby sea otter",
                "n": 1,
                "size": "1024x1024",
                "stream": true
              }' \\
              --no-buffer
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for image in client.images.generate(
                prompt="A cute baby sea otter",
            ):
              print(image)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const client = new OpenAI();
            
            const stream = await client.images.generate({
              model: "gpt-image-1.5",
              prompt: "A cute baby sea otter",
              n: 1,
              size: "1024x1024",
              stream: true,
            });
            
            for await (const event of stream) {
              console.log(event);
            }
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const imagesResponse = await client.images.generate({ prompt: 'A cute baby sea otter' });
            
            console.log(imagesResponse);
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
            	imagesResponse, err := client.Images.Generate(context.TODO(), openai.ImageGenerateParams{
            		Prompt: "A cute baby sea otter",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", imagesResponse)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.images.ImageGenerateParams;
            import com.openai.models.images.ImagesResponse;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ImageGenerateParams params = ImageGenerateParams.builder()
                        .prompt("A cute baby sea otter")
                        .build();
                    ImagesResponse imagesResponse = client.images().generate(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            images_response = openai.images.generate(prompt: "A cute baby sea otter")
            
            puts(images_response)
            """,
        },
        response: """
          event: image_generation.partial_image
          data: {"type":"image_generation.partial_image","b64_json":"...","partial_image_index":0}
          
          event: image_generation.completed
          data: {"type":"image_generation.completed","b64_json":"...","usage":{"total_tokens":100,"input_tokens":50,"output_tokens":50,"input_tokens_details":{"text_tokens":10,"image_tokens":40}}}
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Images.createImageVariation,
  "x-oaiMeta",
  #{
    name: "Create image variation",
    group: "images",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/images/variations \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -F image="@otter.png" \\
            -F n=2 \\
            -F size="1024x1024"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          images_response = client.images.create_variation(
              image=b"Example data",
          )
          print(images_response.created)
          """,
        javascript: """
          import fs from "fs";
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const image = await openai.images.createVariation({
              image: fs.createReadStream("otter.png"),
            });
          
            console.log(image.data);
          }
          main();
          """,
        csharp: """
          using System;
          
          using OpenAI.Images;
          
          ImageClient client = new(
              model: "dall-e-2",
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          GeneratedImage image = client.GenerateImageVariation(imageFilePath: "otter.png");
          
          Console.WriteLine(image.ImageUri);
          
          """,
        `node.js`: """
          import fs from 'fs';
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const imagesResponse = await client.images.createVariation({
            image: fs.createReadStream('otter.png'),
          });
          
          console.log(imagesResponse.created);
          """,
        go: """
          package main
          
          import (
          	"bytes"
          	"context"
          	"fmt"
          	"io"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	imagesResponse, err := client.Images.NewVariation(context.TODO(), openai.ImageNewVariationParams{
          		Image: io.Reader(bytes.NewBuffer([]byte("Example data"))),
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", imagesResponse.Created)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.images.ImageCreateVariationParams;
          import com.openai.models.images.ImagesResponse;
          import java.io.ByteArrayInputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ImageCreateVariationParams params = ImageCreateVariationParams.builder()
                      .image(new ByteArrayInputStream("Example data".getBytes()))
                      .build();
                  ImagesResponse imagesResponse = client.images().createVariation(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          images_response = openai.images.create_variation(image: StringIO.new("Example data"))
          
          puts(images_response)
          """,
      },
      response: """
        {
          "created": 1589478378,
          "data": [
            {
              "url": "https://..."
            },
            {
              "url": "https://..."
            }
          ]
        }
        
        """,
    },
  }
);
