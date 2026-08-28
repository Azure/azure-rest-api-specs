import { $extension } from "@typespec/openapi";

function foundryRequiredPreviews(context, target, ...previews) {
  return $extension(context, target, "x-ms-foundry-meta", {
    required_previews: previews,
  });
}

export const $decorators = {
  "Azure.AI.Projects": {
    foundryRequiredPreviews,
  },
};
