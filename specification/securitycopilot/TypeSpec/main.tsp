import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./SkillContext/routes.tsp";
import "./SkillContext/models.tsp";
import "./ECSFlightClient/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(APIVersion)
@service({
    title: "Skillset Authoring SDK",
})
@useAuth(BearerAuth)
@server(
    "{endpoint}",
    "The Skillset Authoring API exposes endpoints allowing a skill to interact with the current session to perform actions such as accessing previous prompts/responses within the current session, reading the inputs of the skill, invoking other skills, reporting progress of execution, returning results/errors, acquiring tokens to access other resources, and retrieving skill specific settings.",
    {
        @doc("""
Supported Security Copilot API endpoints (protocol and host name, such as
https://api.medeina-dev.defender.microsoft.com).
""")
        endpoint: string,
    }
)
@doc("""
The Skillset Authoring API exposes endpoints allowing a skill to interact with the current session to perform actions such as accessing previous prompts/responses within the current session, 
reading the inputs of the skill, invoking other skills, reporting progress of execution, returning results/errors, acquiring tokens to access other resources, and retrieving skill specific settings. It also provides methods to interact with Open
AI client to create chat completion and get embeddings.
""")

namespace SkillContext;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum APIVersion {
    version: "2023-08-01-preview",
}

namespace ECSFlightClient;







