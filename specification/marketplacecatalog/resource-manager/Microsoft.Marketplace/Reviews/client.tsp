import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Marketplace;

@@alternateType(UserHasReviewProperties.updatedAt, utcDateTime, "csharp");
