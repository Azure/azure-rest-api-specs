namespace AzureOpenAI;

/**
 * A labeled content filter result item that indicates whether the content was filtered and what the qualitative
 * severity level of the content was, as evaluated against content filter configuration for the category.
 */
model AzureContentFilterSeverityResult {
  /** Whether the content severity resulted in a content filtering action. */
  filtered: boolean;

  /** The labeled severity of the content. */
  severity: "safe" | "low" | "medium" | "high";
}

/**
 * A labeled content filter result item that indicates whether the content was detected and whether the content was
 * filtered.
 */
model AzureContentFilterDetectionResult {
  /** Whether the content detection resulted in a content filtering action. */
  filtered: boolean;

  /** Whether the labeled content category was detected in the content. */
  detected: boolean;
}

/**
 * A content filter result item that associates an existing custom blocklist ID with a value indicating whether or not
 * the corresponding blocklist resulted in content being filtered.
 */
model AzureContentFilterBlocklistIdResult {
  /** The ID of the custom blocklist associated with the filtered status. */
  id: string;

  /** Whether the associated blocklist resulted in the content being filtered. */
  filtered: boolean;
}

/**
 * A content filter result item that associates an existing custom topic ID with a value indicating whether or not
 * the corresponding topic resulted in content being detected.
 */
model AzureContentFilterCustomTopicIdResult {
  /** The ID of the custom topic associated with the detected status. */
  id: string;

  /** Whether the associated custom topic resulted in the content being detected. */
  detected: boolean;
}

/**
 * A representation of a span of completion text as used by Azure OpenAI content filter results.
 */
model AzureContentFilterCompletionTextSpan {
  /**
   * Offset of the UTF32 code point which begins the span.
   */
  completion_start_offset: int32;

  /**
   * Offset of the first UTF32 code point which is excluded from the span. This field is always equal to completion_start_offset for empty spans. This field is always larger than completion_start_offset for non-empty spans.
   */
  completion_end_offset: int32;
}

model AzureContentFilterCompletionTextSpanDetectionResult {
  ...AzureContentFilterDetectionResult;

  /**
   * Detailed information about the detected completion text spans.
   */
  details: AzureContentFilterCompletionTextSpan[];
}

alias AzureContentFilterCategoriesBase = {
  ...SexualSeverityCategory;
  ...HateSeverityCategory;
  ...ViolenceSeverityCategory;
  ...SelfHarmSeverityCategory;
  ...ProfanityCategory;
  ...CustomBlocklistsResult;
  ...CustomTopicsResult;

  /**
   * If present, details about an error that prevented content filtering from completing its evaluation.
   */
  error?: {
    /**
     * A distinct, machine-readable code associated with the error.
     */
    code: int32;

    /**
     * A human-readable message associated with the error.
     */
    message: string;
  };
};

/**
 * A collection of true/false filtering results for configured custom blocklists.
 */
model AzureContentFilterBlocklistResult {
  /** A value indicating whether any of the detailed blocklists resulted in a filtering action. */
  filtered: boolean;

  /** The pairs of individual blocklist IDs and whether they resulted in a filtering action. */
  details?: {
    /** A value indicating whether the blocklist produced a filtering action. */
    filtered: boolean;

    /** The ID of the custom blocklist evaluated. */
    id: string;
  }[];
}

/**
 * A collection of true/false filtering results for configured custom topics.
 */
model AzureContentFilterCustomTopicResult {
  /** A value indicating whether any of the detailed topics resulted in a filtering action. */
  filtered: boolean;

  /** The pairs of individual topic IDs and whether they are detected. */
  details?: {
    /** A value indicating whether the topic is detected. */
    detected: boolean;

    /** The ID of the custom topic evaluated. */
    id: string;
  }[];
}

/**
 * A content filter result associated with a single input prompt item into a generative AI system.
 */
model AzureContentFilterResultForPrompt {
  /**
   * The index of the input prompt associated with the accompanying content filter result categories.
   */
  prompt_index?: int32;

  /**
   * The content filter category details for the result.
   */
  content_filter_results?: {
    ...AzureContentFilterCategoriesBase;
    ...JailbreakResult;

    /**
     * A detection result that describes attacks on systems powered by Generative AI models that can happen every time
     * an application processes information that wasn’t directly authored by either the developer of the application or
     * the user.
     */
    indirect_attack: AzureContentFilterDetectionResult;
  };
}

/**
 * A content filter result for a single response item produced by a generative AI system.
 */
model AzureContentFilterResultForChoice {
  ...AzureContentFilterCategoriesBase;

  /**
   * A detection result that describes a match against text protected under copyright or other status.
   */
  protected_material_text?: AzureContentFilterDetectionResult;

  /**
   * A detection result that describes a match against licensed code or other protected source material.
   */
  protected_material_code?: {
    ...AzureContentFilterDetectionResult;

    /**
     * If available, the citation details describing the associated license and its location.
     */
    citation?: {
      /**
       * The name or identifier of the license associated with the detection.
       */
      license?: string;

      /**
       * The URL associated with the license.
       */
      URL?: url;
    };
  };

  ungrounded_material?: AzureContentFilterCompletionTextSpanDetectionResult;
}

/**
 * A content filter result for an image generation operation's output response content.
 */
model AzureContentFilterImageResponseResults {
  ...SexualSeverityCategory;
  ...ViolenceSeverityCategory;
  ...HateSeverityCategory;
  ...SelfHarmSeverityCategory;
}

/**
 * A content filter result for an image generation operation's input request content.
 */
model AzureContentFilterImagePromptResults
  extends AzureContentFilterImageResponseResults {
  ...ProfanityCategory;
  ...CustomBlocklistsResult;
  ...CustomTopicsResult;
  ...JailbreakResult;
}

alias SexualSeverityCategory = {
  /**
   * A content filter category for language related to anatomical organs and genitals, romantic relationships, acts
   * portrayed in erotic or affectionate terms, pregnancy, physical sexual acts, including those portrayed as an
   * assault or a forced sexual violent act against one's will, prostitution, pornography, and abuse.
   */
  sexual?: AzureContentFilterSeverityResult;
};

alias ViolenceSeverityCategory = {
  /**
   * A content filter category for language related to physical actions intended to hurt, injure, damage, or kill
   * someone or something; describes weapons, guns and related entities, such as manufactures, associations,
   * legislation, and so on.
   */
  violence?: AzureContentFilterSeverityResult;
};

alias HateSeverityCategory = {
  /**
   * A content filter category that can refer to any content that attacks or uses pejorative or discriminatory
   * language with reference to a person or identity group based on certain differentiating attributes of these groups
   * including but not limited to race, ethnicity, nationality, gender identity and expression, sexual orientation,
   * religion, immigration status, ability status, personal appearance, and body size.
   */
  hate?: AzureContentFilterSeverityResult;
};

alias SelfHarmSeverityCategory = {
  /**
   * A content filter category that describes language related to physical actions intended to purposely hurt, injure,
   * damage one's body or kill oneself.
   */
  self_harm?: AzureContentFilterSeverityResult;
};

alias ProfanityCategory = {
  /**
   * A detection result that identifies whether crude, vulgar, or otherwise objection language is present in the
   * content.
   */
  profanity?: AzureContentFilterDetectionResult;
};

alias JailbreakResult = {
  /**
   * A detection result that describes user prompt injection attacks, where malicious users deliberately exploit
   * system vulnerabilities to elicit unauthorized behavior from the LLM. This could lead to inappropriate content
   * generation or violations of system-imposed restrictions.
   */
  jailbreak: AzureContentFilterDetectionResult;
};

alias CustomBlocklistsResult = {
  /**
   * A collection of binary filtering outcomes for configured custom blocklists.
   */
  custom_blocklists?: AzureContentFilterBlocklistResult;
};

alias CustomTopicsResult = {
  /**
   * A collection of binary filtering outcomes for configured custom topics.
   */
  custom_topics?: AzureContentFilterCustomTopicResult;
};
