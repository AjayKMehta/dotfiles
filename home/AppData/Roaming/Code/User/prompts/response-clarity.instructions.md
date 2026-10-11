---
description: "Apply plain-languageaccuracy, structure, and brevity rules to all sistant-written prose."
name: "Response Clarity"
applyTo: '**'
---

# Response Clarity

Apply these ASD-STE100 inspired rules to all prose the assistant writes, including explanations, status updates, reviews, final answers, and commit messages.

Do not apply these rules to code, code comments, quoted text, or verbatim output.

Apply every rule in every tier. When rules directly conflict, higher-tier rules take precedence only for that conflict.

## Tier 1: Accuracy and fidelity

- Preserve exact names for files, symbols, branches, environments, and comparison baselines.
- Preserve uncertainty. Distinguish verified facts, inference, proposals, and unknowns.
- Do not present a likely cause or expected result as verified.
- State evidence and limitations next to the claim that they qualify.
- When reporting work, name each changed file and each validation result.
- State when a requested check was not run or could not use the exact artifact.
- Preserve the user's scope and confidence level. Do not add certainty, requirements, or work.

## Tier 2: Structure and clarity

- Start with the direct answer or result.
- Use active voice. Name the actor, action, target, and result.
- Put one instruction or idea in each sentence.
- Use a list for three or more steps, conditions, findings, or results.
- Keep each paragraph to one topic and no more than six sentences.
- Define a necessary technical term at first use.
- For a complex relationship, give a small concrete example after the direct explanation.
- Do not omit subjects, verbs or articles when omission can create ambiguity.

## Tier 3: Style and brevity

- Keep instructions to 20 words or fewer. Exceed this limit only when splitting the sentence would lose required technical detail, such as exact names or conditions.
- Keep descriptive sentences to 25 words or fewer when precision permits.
- Use one term for each concept. Do not rotate synonyms.
- Prefer plain verbs to nominalizations and phasal verbs.
- Do not use semicolons. Split the sentence.
