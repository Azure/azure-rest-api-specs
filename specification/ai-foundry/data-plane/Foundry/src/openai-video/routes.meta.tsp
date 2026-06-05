import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.VideoGeneration.ListVideos,
  "x-oaiMeta",
  #{
    name: "List videos",
    group: "videos",
    path: "list for the organization.",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/videos \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from 'openai';
          
          const openai = new OpenAI();
          
          // Automatically fetches more pages as needed.
          for await (const video of openai.videos.list()) {
            console.log(video.id);
          }
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.videos.list()
          page = page.data[0]
          print(page.id)
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
          	page, err := client.Videos.List(context.TODO(), openai.VideoListParams{})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", page)
          }
          
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.videos.list
          
          puts(page)
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.VideoListPage;
          import com.openai.models.videos.VideoListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoListPage page = client.videos().list();
              }
          }
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const video of client.videos.list()) {
            console.log(video.id);
          }
          """,
      },
      response: """
        {
          "data": [
            {
              "id": "video_123",
              "object": "video",
              "model": "sora-2",
              "status": "completed"
            }
          ],
          "object": "list"
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.VideoGeneration.ListVideos, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.VideoGeneration.createVideo,
  "x-oaiMeta",
  #{
    name: "Create video",
    group: "videos",
    path: "create",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/videos \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -F "model=sora-2" \\
            -F "prompt=A calico cat playing a piano on stage"
          
          """,
        javascript: """
          import OpenAI from 'openai';
          
          const openai = new OpenAI();
          
          const video = await openai.videos.create({ prompt: 'A calico cat playing a piano on stage' });
          
          console.log(video.id);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          video = client.videos.create(
              prompt="x",
          )
          print(video.id)
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
          	video, err := client.Videos.New(context.TODO(), openai.VideoNewParams{
          		Prompt: "x",
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", video.ID)
          }
          
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          video = openai.videos.create(prompt: "x")
          
          puts(video)
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.Video;
          import com.openai.models.videos.VideoCreateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoCreateParams params = VideoCreateParams.builder()
                      .prompt("x")
                      .build();
                  Video video = client.videos().create(params);
              }
          }
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const video = await client.videos.create({ prompt: 'x' });
          
          console.log(video.id);
          """,
      },
      response: """
        {
          "id": "video_123",
          "object": "video",
          "model": "sora-2",
          "status": "queued",
          "progress": 0,
          "created_at": 1712697600,
          "size": "1024x1792",
          "seconds": "8",
          "quality": "standard"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.CreateVideoCharacter,
  "x-oaiMeta",
  #{
    examples: #{
      response: "",
      request: #{
        `node.js`: """
          import fs from 'fs';
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const response = await client.videos.createCharacter({
            name: 'x',
            video: fs.createReadStream('path/to/file'),
          });
          
          console.log(response.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          response = client.videos.create_character(
              name="x",
              video=b"Example data",
          )
          print(response.id)
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
          	response, err := client.Videos.NewCharacter(context.TODO(), openai.VideoNewCharacterParams{
          		Name:  "x",
          		Video: io.Reader(bytes.NewBuffer([]byte("Example data"))),
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", response.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.VideoCreateCharacterParams;
          import com.openai.models.videos.VideoCreateCharacterResponse;
          import java.io.ByteArrayInputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoCreateCharacterParams params = VideoCreateCharacterParams.builder()
                      .name("x")
                      .video(new ByteArrayInputStream("Example data".getBytes()))
                      .build();
                  VideoCreateCharacterResponse response = client.videos().createCharacter(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          response = openai.videos.create_character(name: "x", video: StringIO.new("Example data"))
          
          puts(response)
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.GetVideoCharacter,
  "x-oaiMeta",
  #{
    examples: #{
      response: "",
      request: #{
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const response = await client.videos.getCharacter('char_123');
          
          console.log(response.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          response = client.videos.get_character(
              "char_123",
          )
          print(response.id)
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
          	response, err := client.Videos.GetCharacter(context.TODO(), "char_123")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", response.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.VideoGetCharacterParams;
          import com.openai.models.videos.VideoGetCharacterResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoGetCharacterResponse response = client.videos().getCharacter("char_123");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          response = openai.videos.get_character("char_123")
          
          puts(response)
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.CreateVideoEditMultipart,
  "x-oaiMeta",
  #{
    examples: #{
      response: "",
      request: #{
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const video = await client.videos.edit({ prompt: 'x', video: fs.createReadStream('path/to/file') });
          
          console.log(video.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          video = client.videos.edit(
              prompt="x",
              video=b"Example data",
          )
          print(video.id)
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
          	video, err := client.Videos.Edit(context.TODO(), openai.VideoEditParams{
          		Prompt: "x",
          		Video: openai.VideoEditParamsVideoUnion{
          			OfFile: io.Reader(bytes.NewBuffer([]byte("Example data"))),
          		},
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", video.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.Video;
          import com.openai.models.videos.VideoEditParams;
          import java.io.ByteArrayInputStream;
          import java.io.InputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoEditParams params = VideoEditParams.builder()
                      .prompt("x")
                      .video(new ByteArrayInputStream("Example data".getBytes()))
                      .build();
                  Video video = client.videos().edit(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          video = openai.videos.edit(prompt: "x", video: StringIO.new("Example data"))
          
          puts(video)
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.CreateVideoEditJson,
  "x-oaiMeta",
  #{
    examples: #{
      response: "",
      request: #{
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const video = await client.videos.edit({ prompt: 'x', video: fs.createReadStream('path/to/file') });
          
          console.log(video.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          video = client.videos.edit(
              prompt="x",
              video=b"Example data",
          )
          print(video.id)
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
          	video, err := client.Videos.Edit(context.TODO(), openai.VideoEditParams{
          		Prompt: "x",
          		Video: openai.VideoEditParamsVideoUnion{
          			OfFile: io.Reader(bytes.NewBuffer([]byte("Example data"))),
          		},
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", video.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.Video;
          import com.openai.models.videos.VideoEditParams;
          import java.io.ByteArrayInputStream;
          import java.io.InputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoEditParams params = VideoEditParams.builder()
                      .prompt("x")
                      .video(new ByteArrayInputStream("Example data".getBytes()))
                      .build();
                  Video video = client.videos().edit(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          video = openai.videos.edit(prompt: "x", video: StringIO.new("Example data"))
          
          puts(video)
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.CreateVideoExtendMultipart,
  "x-oaiMeta",
  #{
    examples: #{
      response: "",
      request: #{
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const video = await client.videos.extend({
            prompt: 'x',
            seconds: '4',
            video: fs.createReadStream('path/to/file'),
          });
          
          console.log(video.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          video = client.videos.extend(
              prompt="x",
              seconds="4",
              video=b"Example data",
          )
          print(video.id)
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
          	video, err := client.Videos.Extend(context.TODO(), openai.VideoExtendParams{
          		Prompt:  "x",
          		Seconds: openai.VideoSeconds4,
          		Video: openai.VideoExtendParamsVideoUnion{
          			OfFile: io.Reader(bytes.NewBuffer([]byte("Example data"))),
          		},
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", video.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.Video;
          import com.openai.models.videos.VideoExtendParams;
          import com.openai.models.videos.VideoSeconds;
          import java.io.ByteArrayInputStream;
          import java.io.InputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoExtendParams params = VideoExtendParams.builder()
                      .prompt("x")
                      .seconds(VideoSeconds._4)
                      .video(new ByteArrayInputStream("Example data".getBytes()))
                      .build();
                  Video video = client.videos().extend(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          video = openai.videos.extend_(prompt: "x", seconds: :"4", video: StringIO.new("Example data"))
          
          puts(video)
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.CreateVideoExtendJson,
  "x-oaiMeta",
  #{
    examples: #{
      response: "",
      request: #{
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const video = await client.videos.extend({
            prompt: 'x',
            seconds: '4',
            video: fs.createReadStream('path/to/file'),
          });
          
          console.log(video.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          video = client.videos.extend(
              prompt="x",
              seconds="4",
              video=b"Example data",
          )
          print(video.id)
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
          	video, err := client.Videos.Extend(context.TODO(), openai.VideoExtendParams{
          		Prompt:  "x",
          		Seconds: openai.VideoSeconds4,
          		Video: openai.VideoExtendParamsVideoUnion{
          			OfFile: io.Reader(bytes.NewBuffer([]byte("Example data"))),
          		},
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", video.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.Video;
          import com.openai.models.videos.VideoExtendParams;
          import com.openai.models.videos.VideoSeconds;
          import java.io.ByteArrayInputStream;
          import java.io.InputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoExtendParams params = VideoExtendParams.builder()
                      .prompt("x")
                      .seconds(VideoSeconds._4)
                      .video(new ByteArrayInputStream("Example data".getBytes()))
                      .build();
                  Video video = client.videos().extend(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          video = openai.videos.extend_(prompt: "x", seconds: :"4", video: StringIO.new("Example data"))
          
          puts(video)
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.DeleteVideo,
  "x-oaiMeta",
  #{
    name: "Delete video",
    group: "videos",
    path: "delete",
    examples: #{
      response: "",
      request: #{
        javascript: """
          import OpenAI from 'openai';
          
          const client = new OpenAI();
          
          const video = await client.videos.delete('video_123');
          
          console.log(video.id);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          video = client.videos.delete(
              "video_123",
          )
          print(video.id)
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
          	video, err := client.Videos.Delete(context.TODO(), "video_123")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", video.ID)
          }
          
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          video = openai.videos.delete("video_123")
          
          puts(video)
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.VideoDeleteParams;
          import com.openai.models.videos.VideoDeleteResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoDeleteResponse video = client.videos().delete("video_123");
              }
          }
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const video = await client.videos.delete('video_123');
          
          console.log(video.id);
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.GetVideo,
  "x-oaiMeta",
  #{
    name: "Retrieve video",
    group: "videos",
    path: "retrieve matching the provided identifier.",
    examples: #{
      response: "",
      request: #{
        javascript: """
          import OpenAI from 'openai';
          
          const client = new OpenAI();
          
          const video = await client.videos.retrieve('video_123');
          
          console.log(video.id);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          video = client.videos.retrieve(
              "video_123",
          )
          print(video.id)
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
          	video, err := client.Videos.Get(context.TODO(), "video_123")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", video.ID)
          }
          
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          video = openai.videos.retrieve("video_123")
          
          puts(video)
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.Video;
          import com.openai.models.videos.VideoRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Video video = client.videos().retrieve("video_123");
              }
          }
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const video = await client.videos.retrieve('video_123');
          
          console.log(video.id);
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.RetrieveVideoContent,
  "x-oaiMeta",
  #{
    name: "Retrieve video content",
    group: "videos",
    path: "content",
    examples: #{
      response: "",
      request: #{
        javascript: """
          import OpenAI from 'openai';
          
          const client = new OpenAI();
          
          const response = await client.videos.downloadContent('video_123');
          
          console.log(response);
          
          const content = await response.blob();
          console.log(content);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          response = client.videos.download_content(
              video_id="video_123",
          )
          print(response)
          content = response.read()
          print(content)
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
          	response, err := client.Videos.DownloadContent(
          		context.TODO(),
          		"video_123",
          		openai.VideoDownloadContentParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", response)
          }
          
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          response = openai.videos.download_content("video_123")
          
          puts(response)
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.core.http.HttpResponse;
          import com.openai.models.videos.VideoDownloadContentParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  HttpResponse response = client.videos().downloadContent("video_123");
              }
          }
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const response = await client.videos.downloadContent('video_123');
          
          console.log(response);
          
          const content = await response.blob();
          console.log(content);
          """,
      },
    },
  }
);

@@extension(
  Azure.AI.Projects.VideoGeneration.CreateVideoRemix,
  "x-oaiMeta",
  #{
    name: "Remix video",
    group: "videos",
    path: "remix using the provided prompt.",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/videos/video_123/remix \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
              "prompt": "Extend the scene with the cat taking a bow to the cheering audience"
            }'
          
          """,
        javascript: """
          import OpenAI from 'openai';
          
          const client = new OpenAI();
          
          const video = await client.videos.remix('video_123', { prompt: 'Extend the scene with the cat taking a bow to the cheering audience' });
          
          console.log(video.id);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          video = client.videos.remix(
              video_id="video_123",
              prompt="x",
          )
          print(video.id)
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
          	video, err := client.Videos.Remix(
          		context.TODO(),
          		"video_123",
          		openai.VideoRemixParams{
          			Prompt: "x",
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", video.ID)
          }
          
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          video = openai.videos.remix("video_123", prompt: "x")
          
          puts(video)
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.videos.Video;
          import com.openai.models.videos.VideoRemixParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VideoRemixParams params = VideoRemixParams.builder()
                      .videoId("video_123")
                      .prompt("x")
                      .build();
                  Video video = client.videos().remix(params);
              }
          }
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const video = await client.videos.remix('video_123', { prompt: 'x' });
          
          console.log(video.id);
          """,
      },
      response: """
        {
          "id": "video_456",
          "object": "video",
          "model": "sora-2",
          "status": "queued",
          "progress": 0,
          "created_at": 1712698600,
          "size": "720x1280",
          "seconds": "8",
          "remixed_from_video_id": "video_123"
        }
        
        """,
    },
  }
);
