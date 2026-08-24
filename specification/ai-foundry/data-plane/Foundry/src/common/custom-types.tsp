import "@azure-tools/typespec-azure-core";

using Azure.Core.Experimental;

/* Hotfix until we merge a new version of the upstream library with this already fixed. */
union RealtimeSessionCreateRequestUnion {
  OpenAI.RealtimeSessionCreateRequestGA,
  OpenAI.RealtimeTranscriptionSessionCreateRequestGA,
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeClientEventSessionUpdate.session,
  RealtimeSessionCreateRequestUnion
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeServerEventSessionCreated.session,
  RealtimeSessionCreateRequestUnion
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeServerEventSessionUpdated.session,
  RealtimeSessionCreateRequestUnion
);

namespace OpenAI {
  scalar integer extends TypeSpec.int64;
  scalar numeric extends TypeSpec.float64;
}

namespace Azure.AI.Projects {
  scalar integer extends OpenAI.integer;
  scalar numeric extends OpenAI.numeric;
}
