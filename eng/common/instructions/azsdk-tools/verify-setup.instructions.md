---
description: 'Verify Setup'
---

## Goal
This tool verifies the developer's environment for SDK development and release tasks. It returns what requirements are missing for the specified languages and repo, or success if all requirements are satisfied.

<<<<<<< HEAD
Your goal is to identify the project repo root, and pass in the `packagePath` to the Verify Setup tool. For a language repo, pass in the language of the repo.
=======
Your goal is to identify the project repo root, and pass in the `packagePath` to the Verify Setup tool. For a language repo, pass in the language of the repo. 
>>>>>>> upstream/main

## Examples
- in `azure-sdk-for-js`, run `azsdk_verify_setup` with `(langs=javascript, packagePath=<path>/azure-sdk-for-js)`.

## Parameter Requirements
The user can specify multiple languages to check. If the user wants to check all languages, pass in ALL supported languages. Passing in no languages will only check the core requirements.

## Output
<<<<<<< HEAD
Display results in a user-friendly and concise format, highlighting any missing dependencies that need to be addressed and how to resolve them.
=======
Display clear, step-by-step instructions on how to resolve any missing requirements identified. Explain why the requirement is necessary if it has a `reason` field. Organize requirements into categorical sections. 

Based on the user's shell environment, enhance the tool instructions with shell-specific commands for resolving missing dependencies.
>>>>>>> upstream/main

When Python tool requirements fail, inform the user about the `AZSDKTOOLS_PYTHON_VENV_PATH` environment variable if they have setup issues. The verify-setup tool can only check Python requirements within the virtual environment specified by this environment variable.
