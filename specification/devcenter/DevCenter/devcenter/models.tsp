import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;

@doc("Results of the project list operation.")
model ProjectListResult is Azure.Core.Page<Project>;
