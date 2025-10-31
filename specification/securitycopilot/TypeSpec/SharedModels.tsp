@doc("Entity representing a Skillset.")
model SkillsetDescriptor {
    @visibility("public")
    @doc("Namespace for the skillset")
    `namespace`: string;

    @doc("The name of the Skillset")
    name: string;

    @doc("The description of the Skillset")
    description: string;

    @doc("The description of the skillset that's displayed TODO postman/dev figure out where this is displayed")
    descriptionDisplay: string;

    @doc("The Skillset name that's displayed in the portal")
    disaplyName: string;

    @doc("The icon displayed for the skillset in the console")
    icon: string;

    @doc("The category of the Skillset")
    category: SkillsetCategory;

    @doc("CatalogScope of the Skillset")
    catalogScope: SkillsetCatalogScope;

    @doc("Whether the skillset is enabled TODO how is this different than Hidden")
    enabled: boolean;

    @doc("Whether the skillset is hidden TODO how is this different than enabled")
    hidden: boolean;

    @doc("The prerequisites of a skillset TODO what does this mean")
    prerequisites: string[] | null;

    @doc("The settings of a skillset")
    settings: SkillsetSetting[];

    @doc("The settings of a skillset")
    authorization: SkillsetAuth;

    @doc("The types of authentication supported by the skillset")
    supportedAuthTypes: SkillsetAuthType[];

    @doc("A list of feature flags. At least one of the feature flags is required to enabled in the prompt context in order for the skillset to be available")
    userVisibilityFeatureFlags: string[];

    @doc("Controls the conditions under which the users can see or use this skillset")
    userVisibility: SkillVisibility;

    @doc("Visibility flags required for the planner to user the skillset TODO confirm what this does")
    plannerVisibilityFeatureFlags: string[];

    @doc("Controls the conditions under a prompt can use this skillset")
    plannerVisibility: SkillVisibility;

    @doc("The user ID of the user who created this skillset.")
    creatorUserId: string;

    @visibility("create")
    @doc("The ID of an Entra group that contains the owners for this Skillset")
    ownersGroupId: string;
}

@doc("Defines the settings of a skillset")
model SkillsetSetting {
    @doc("The name of the skillset setting")
    name: string;

    @doc("The label of the skillset setting")
    label: string;

    @doc("The description of the skillset setting used to describe the setting to the user in an info text box")
    description: string;

    @doc("The hint text used to fill in the setting box")
    hintText: string;

    @doc("The type of the skillset setting")
    settingType: SkillsetSettingType;

    @doc("Whether the skillset setting is required")
    required: boolean;

    @doc("The default value of the skillset setting")
    defaultValue: string;

    @doc("The value of the skillset setting")
    value: string;
}

@doc("Entity containing the configuration of a skillset")
model SkillsetConfiguration {
    @doc("The name of the skillset")
    skillsetName: string;

    @doc("The settings of the skillset")
    settings: Record<string>;

    @doc("The type of authentication supported by the skillset")
    authType: SkillsetAuthType;

    @doc("The authentication configurations of the skillset")
    authConfigurations: Record<SkillsetAuthConfiguration>;

    @doc("The scope of the skillset")
    scopeIdentifier: string;
}

@doc("skillsetAuth dictionary")
model SkillsetAuthentication {
    Basic?: SkillsetAuthConfiguration;
    ApiKey?: SkillsetAuthConfiguration;

    @doc("The skillset supports OAuth authorization code flow authentication TODO what does this mean")
    OAuthAuthorizationCodeFlow?: SkillsetAuthConfiguration;

    @doc("The skillset supports OAuth client credentials flow TODO what does this mean")
    OAuthClientCredentialsFlow?: SkillsetAuthConfiguration;

    @doc("The skillset supports AAD authentication")
    AAD?: SkillsetAuthConfiguration;

    @doc("The skillset supports service HTTP authentication TODO what does this mean")
    ServiceHttp?: SkillsetAuthConfiguration;

    @doc("The skillset supports AAD delegated authentication TODO what does this mean")
    AADDelegated?: SkillsetAuthConfiguration;
}

@doc("Settings for a given authentication configuration")
model SkillsetAuthConfiguration {
    @doc("The type of authentication that is being configured")
    authType: SkillsetAuthType;

    @doc("The settings for the authentication configuration TODO what does this mean")
    settings: Record<string>;

    @doc("Settings that only the skillset auth handlers can see. These settings are invisible to the user, such as OAuth Refresh Tokens TODO clarify this")
    hiddenSettings: Record<string>;
}

@doc("Entity containing the results of a requirement check for a skillset")
model SkillsetRequirementsCheckResult {
    @doc("The name of the skillset")
    skillsetName: string;

    @doc("Any error resulting from a requirements check for a skillset")
    errors: SkillsetRequirementsCheck.Error[];
}

namespace SkillsetRequirementsCheck {
    @doc("An error resulting from a requirements check for a skillset")
    model Error {
        @doc("The name of the error")
        name: string;

        @doc("The error message")
        errorCode: SkillsetRequirementsCheck.ErrorCode;
    }
}

@doc("A skillset's auth descriptor")
model SkillsetAuthDescriptor {
    @doc("The type of authentication being described")
    authType: SkillsetAuthType;

    @doc("The settings for the authentication descriptor")
    settings: SkillsetSetting[];
}

@doc("An OAuth authorization code request")
model OAuthAuthorizationCodeRequest {
    @doc("The authorization code")
    authorizationCode: string | null;

    @doc("the state of the request")
    state: string | null;
}

@doc("Query parameters used to add or update a skillset")
model AddOrUpdateSkillsetQueryParameters {
    @doc("The scope of the skillset")
    scope: SkillsetCatalogScope;

    @doc("The format of the skillset being uploaded")
    skillsetFormat: SkillsetFormat;
}

@doc("A skillset defined in the skillset catalog")
model Skillset {
    @doc("The descriptor of the skillset")
    descriptor: SkillsetDescriptor;

    @doc("The skillgroups that make up the skillset")
    skillGroups: SkillGroup[];

    @doc("The identifier of the skillset")
    skillsetIdentifier?: string;
}

@doc("The definition of a skill group")
model SkillGroup {
    @doc("The format of the skills within the skill group")
    format: SkillFormat;

    @doc("The skills within the skill group")
    skills: SkillDescriptor[];

    @doc("The settings of the skill group")
    settings: Dictionary<string, string>;
}

@doc("SkillSummaryDescriptor")
model SkillSummaryDescriptor {
    @doc("SummaryStartMessage")
    summaryStartMessage: string;

    @doc("SummaryEndMessage")
    summaryEndMessage: string;
}

@doc("Specifies the identity type used when a skill runs.")
enum SkillAgentTokenType {
		@doc("The skill runs using the agentic user (AU) identity.")
		AgenticUser,
		@doc("The skill runs using the agentic app (AAI) identity.")
		AgenticApp,
		@doc("Short-term 1P scenario: skill runs using the agentic user on-behalf-of (OBO) identity.")
		AgenticUserOBO,
}

@doc("The desciptor of a skill")
model SkillDescriptor {
    @doc("The skillset descriptor")
    skillset: SkillsetDescriptor;

    @doc("The name of the skill")
    name: string;

    @doc("The format of the skill")
    format: string;

    @doc("The display name of the skill")
    displayName: string;

    @doc("An alternative name for the skill as some planners follow different naming convensions. This is set by the planner to map the name back to the skill")
    altName: string;

    @doc("The dependencies of the skill")
    dependencies: SkillDependencyDescriptor[];

    @doc("The description of the skill")
    description: string;

    @doc("A list of example prompts for the skill")
    examplePrompts: string[];

    @doc("Whether the skill is hidden TODO what does this mean")
    hidden: boolean;

    @doc("The inputs required for the skill")
    inputs: SkillInputDescriptor[];

    @doc("The outputs of the skill")
    outputs: SkillOutputDescriptor[];

    @doc("The prompt aligned name of the skill TODO what does this mean")
    promptAlignedName: string;

    @doc("A list of feature flags. At least one of the feature flags is required to enabled in the prompt context in order for the skillset to be available")
    userVisibilityFeatureFlags: string[];

    @doc("Controls the conditions under which the users can see or use this skillset")
    userVisibility: SkillVisibility;

    @doc("Visibility flags required for the planner to user the skillset TODO confirm what this does")
    plannerVisibilityFeatureFlags: string[];

    @doc("Controls the conditions under a prompt can use this skillset")
    plannerVisibility: SkillVisibility;

    @doc("The settings of the skill")
    settings: Record<string>;

    @doc("skillSummaryMetadata")
    skillSummaryMetadata: SkillSummaryDescriptor;

    @doc("EnableVariableSubstitutionInCompose")
    enableVariableSubstitutionInCompose: boolean;

    @doc("Description for use with LLM to decide on skill selection, etc.  Not for end-user consumption.")
    descriptionForModel: string;

    @doc("The token type used when executing the skill. Defaults to AgenticUser.")
    skillAgentTokenType: SkillAgentTokenType = SkillAgentTokenType.AgenticUser;
}

@doc("The descriptor of a skill dependency")
model SkillDependencyDescriptor {
    @doc("The skillset name")
    skillsetName: string;

    @doc("The name of the skill")
    skillName: string;
}

@doc("The descriptor of a skill input")
model SkillInputDescriptor is SkillVariableDescriptor {
    @doc("Whether a skill input is required")
    required: boolean;

    @doc("The default value of the skill input")
    defaultValue?: string;

    @doc("The placeholder value of the skill input TODO how is this different than the default")
    placeholderValue: string;

    @doc("Enum")
    `enum`: string[] | null;
}

@doc("The descriptor of a skill variable")
model SkillVariableDescriptor {
    @doc("The name of the skill input")
    name?: string;

    @doc("The type of the skill input")
    type: SkillTypeDescriptor;

    @doc("The description of the skill")
    description?: string;
}

@doc("The descriptor of a skill output")
model SkillOutputDescriptor is SkillVariableDescriptor;

@doc("The descriptor of a skill type")
model SkillTypeDescriptor {
    @doc("The name of the skill type")
    name: string;
}

@doc("Defines the category of the data source/API that the skillset interacts with")
enum SkillsetCategory {
    @doc("Default value if a category is not specified. The skillset willnot appear in the UI")
    Hidden,

    @doc("The skillset interacts with Microsoft services only")
    Microsoft,

    @doc("The skillset interacts with 3rd party service")
    Other,

    @doc("The skillset interacts with public facing web services")
    Web,

    @doc("The skillset is used for testing and debugging purposes")
    Testing,

    @doc("THe skillset of of a plugin format, such as ChatGPT or LogicApp plugins")
    Plugin,
}

@doc("Defines the conditions under which the users can see or use a skillset")
enum SkillVisibility {
    @doc("Always visible")
    Always,

    @doc("Never visible")
    Never,

    @doc("Visible when any of an associated list of feature flags are enabled")
    IfFeatureFlagEnabled,
}

@doc("Defines the authentication types supported by a skillset")
enum SkillsetAuthType {
    @doc("The skillset supports no authentication")
    None,

    @doc("The skillset supports basic authentication TODO what does this mean")
    Basic,

    @doc("The skillset supports API key authentication TO what does this mean")
    ApiKey,

    @doc("The skillset supports OAuth authorization code flow authentication TODO what does this mean")
    OAuthAuthorizationCodeFlow,

    @doc("The skillset supports OAuth client credentials flow TODO what does this mean")
    OAuthClientCredentialsFlow,

    @doc("The skillset supports AAD authentication")
    AAD,

    @doc("The skillset supports service HTTP authentication TODO what does this mean")
    ServiceHttp,

    @doc("The skillset supports AAD delegated authentication TODO what does this mean")
    AADDelegated,
}

@doc("Defines the type of a skillset setting")
enum SkillsetSettingType {
    @doc("The skillset setting is a secret string TODO what does this mean")
    SecretString,

    @doc("The skillset setting is a string")
    String,
}

namespace SkillsetRequirementsCheck {
    @doc("The error code of an error resulting from a requirements check for a skillset")
    enum ErrorCode {
        @doc("Skillset has a missing dependency")
        MissingDependency,

        @doc("Skillset has a missing required setting")
        MissingRequiredSetting,

        @doc("Skillset has a missing authentication requirement")
        MissingAuthRequirement,
    }
}

@doc("The scope of a skillset in the skillset catalog")
enum SkillsetCatalogScope {
    @doc("No scope specified")
    None,

    @doc("The skillset is scoped to the calling user")
    User,

    @doc("The skillset is scoped to the calling user's workspace TODO what does this mean")
    Workspace,

    @doc("The skillset is scoped to the calling user's tenant")
    Tenant,

    @doc("The skillset is available globally")
    Global,
}

@doc("The format of a skillset being uploaded")
enum SkillsetFormat {
    @doc("Unknown format specified")
    Unknown,

    @doc("The skillset is in yaml format")
    SkillsetYaml,

    @doc("The skillset is in JSON format")
    SkillsetJson,

    @doc("The skillset is in a plugin manifest format as defined by ChatGPT plugins")
    PluginManifestJson,
}

@doc("Options for format of skill groups")
enum SkillFormat {
    @doc("Skill group contains GPT skills")
    GPT,

    @doc("Skill group contains .NET skills")
    DOTNET,

    @doc("Skill group contains KQL skills")
    KQL,

    @doc("Skill group contains ChatGPT plugin skills")
    ChatGptPlugin,

    @doc("Skill group contains Python skills")
    Python,

    @doc("Skill group contains LogicApp plugin skills")
    LogicApp,
}

@doc("A page of results")
model PageResponse<T> {
    @doc("Page of results")
    value?: T[];

    @doc("The link to the next page of results")
    nextLink?: string;
}

@doc("Entity representing a key value pair")
model Dictionary<T, U> {
    @doc("The key of the key value pair")
    key: T;

    @doc("The value of the key value pair")
    value: U;
}

@doc("The authorization settings for the skillset")
model SkillsetAuth {
    @doc("SkillsetAuth Type")
    type: SkillsetAuthType;
}