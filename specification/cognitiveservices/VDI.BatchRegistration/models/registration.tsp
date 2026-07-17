import "@typespec/rest";

using TypeSpec.Rest;

namespace VdiBatchRegistration;

@doc("Represents the registration payload")
@resource("registrations")
model Registration {
    @key("registrationName")
    @doc("The registration name.")
    @visibility("create")
    name: string;

    @doc("The storage configuration definition")
    storage: Storage;

    @doc("The processing configuration definition")
    processing: Processing;

    @doc("The processing configuration definition")
    customProperties: {};

    @doc("The AI Task configuration definition")
    aiTaskConfigurations: Record<AiTaskConfiguration>;

    @doc("The anlytics configuration definition")
    analytics: {};

    @visibility("read")
    @doc("The status of the created registration")
    status: string;
}

@doc("The storage configuration definition")
model Storage {}

@doc("The processing configuration definition")
model Processing {}

@doc("The AI Task configuration definition")
model AiTaskConfiguration {
    @doc("Version of the AI Task configured")
    version: string;
}
