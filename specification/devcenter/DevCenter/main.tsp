import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./devbox/routes.tsp";
import "./devcenter/routes.tsp";
import "./environments/routes.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;
