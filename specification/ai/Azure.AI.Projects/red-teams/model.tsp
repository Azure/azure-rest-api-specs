import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

// orchestration APIs - todo find this: red_team_operation 
@doc("Customization Parameters")
model RedTeam {
    @doc("todo: model configuration - alignment with remotes package/remote evals.")
    target: ModelConfiguration;

    // this is a terrible parameter name
    @doc("Parameters.")
    evaluationName: string;

    @doc("Number of simulation rounds.")
    numTurns: int;

    // Todo object model for attack strategy
    @doc("Customization parameters.")
    attackStrategy: AttackStrategy;

    //todo what is this?
    @doc("data only.")
    dataOnly: boolean;

    // TODO this needs to align with EvaluationResult asset type
    @doc("Output result json.")
    outputPath: string;

    //Attack ObjectiveGenerator
    @doc("Attack ObjectiveGenerator.")
    attackObjectiveGenerator: AttackObjectiveGenerator;
}
