import "./common";
import "./models";
import "./completions";
import "./containers";
import "./chat";
import "./evals";
import "./graders";
import "./fine-tuning";
import "./images";
import "./moderations";
import "./files";
import "./uploads";
import "./embeddings";
import "./audio";
import "./runs";
import "./assistants";
import "./threads";
import "./messages";
import "./vector-stores";
import "./streaming";
import "./batch";
import "./administration";
import "./realtime";
import "./specialized-types";
import "./responses";
import "./webhooks";
import "./conversations";
import "@typespec/openapi";
import "@typespec/http";
using TypeSpec.OpenAPI;
using TypeSpec.Http;
@tagMetadata(
  "Audit Logs",
  #{
    description: "List user actions and configuration changes within this organization.",
  }
)
@tagMetadata(
  "Moderations",
  #{
    description: "Given text and/or image inputs, classifies if those inputs are potentially harmful.",
  }
)
@tagMetadata(
  "Models",
  #{ description: "List and describe the various models available in the API." }
)
@tagMetadata(
  "Images",
  #{
    description: "Given a prompt and/or an input image, the model will generate a new image.",
  }
)
@tagMetadata(
  "Uploads",
  #{ description: "Use Uploads to upload large files in multiple parts." }
)
@tagMetadata(
  "Files",
  #{
    description: "Files are used to upload documents that can be used with features like Assistants and Fine-tuning.",
  }
)
@tagMetadata(
  "Batch",
  #{
    description: "Create large batches of API requests to run asynchronously.",
  }
)
@tagMetadata(
  "Graders",
  #{ description: "Manage and run graders in the OpenAI platform." }
)
@tagMetadata(
  "Fine-tuning",
  #{
    description: "Manage fine-tuning jobs to tailor a model to your specific training data.",
  }
)
@tagMetadata(
  "Evals",
  #{ description: "Manage and run evals in the OpenAI platform." }
)
@tagMetadata(
  "Embeddings",
  #{
    description: "Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.",
  }
)
@tagMetadata(
  "Completions",
  #{
    description: "Given a prompt, the model will return one or more predicted completions, and can also return the probabilities of alternative tokens at each position.",
  }
)
@tagMetadata(
  "Conversations",
  #{ description: "Manage conversations and conversation items." }
)
@tagMetadata(
  "Chat",
  #{
    description: "Given a list of messages comprising a conversation, the model will return a response.",
  }
)
@tagMetadata(
  "Audio",
  #{ description: "Turn audio into text or text into audio." }
)
@tagMetadata(
  "Assistants",
  #{ description: "Build Assistants that can call models and use tools." }
)
@server("https://api.openai.com/v1")
@info(#{
  version: "2.3.0",
  contact: #{ name: "OpenAI Support", url: "https://help.openai.com/" },
  license: #{
    name: "MIT",
    url: "https://github.com/openai/openai-openapi/blob/master/LICENSE",
  },
  termsOfService: "https://openai.com/policies/terms-of-use",
})
@service(#{ title: "OpenAI API" })
namespace OpenAI;
