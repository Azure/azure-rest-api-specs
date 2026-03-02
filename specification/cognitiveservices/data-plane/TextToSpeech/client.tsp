import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using CustomVoiceApi;

@@clientName(InnerError.innererror, "innerErrorInfo", "csharp");
