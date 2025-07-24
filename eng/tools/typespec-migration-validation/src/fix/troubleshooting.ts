import { jsonOutput, Suggestion } from "../jsonOutput.js";
import { handleAdded, handleChanged, handleDeleted } from "./definition.js";
import { checkElementAddedOrDeleted, checkElementChanged } from "./helper.js";

export function generatePrompts(jsonObj: any): string[] {
  const suggestedFixes: Suggestion[] = [];

  const elementAddedOrDeleted = checkElementAddedOrDeleted(jsonObj);
  for (const change of elementAddedOrDeleted) {
    const addedSuggestion = handleAdded(change);
    if (addedSuggestion) {
      suggestedFixes.push(addedSuggestion);
    }
    const deletedSuggestion = handleDeleted(change);
    if (deletedSuggestion) {
      suggestedFixes.push(deletedSuggestion);
    }
  }

  const elementChanged = checkElementChanged(jsonObj);
  for (const change of elementChanged) {
    const changedSuggestion = handleChanged(change);
    if (changedSuggestion) {
      suggestedFixes.push(changedSuggestion);
    }
  }

  const suggestionsAsString = suggestedFixes.map((s) => s.suggestion);
  if (suggestedFixes.length > 0) {
    jsonOutput.suggestions.push(...suggestedFixes);
    suggestionsAsString.unshift(
      `You are an expert in TypeSpec. Follow the prompt exactly as written. Do not add any additional suggestions or modifications unless explicitly requested.`,
    );
    for (let i = 1; i < suggestionsAsString.length; i++) {
      suggestionsAsString[i] = `${i}. ${suggestionsAsString[i]}`;
    }
  }
  return suggestionsAsString;
}
