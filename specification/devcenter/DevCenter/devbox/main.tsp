import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../service.tsp";
import "./routes.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;