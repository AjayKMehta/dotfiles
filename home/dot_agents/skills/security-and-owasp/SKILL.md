---
name: security-and-owasp
description: "Comprehensive secure-coding guidance based on the OWASP Top 10 and industry best practices."
---

# Security and OWASP

## Description

Comprehensive secure-coding guidance based on the OWASP Top 10 and industry best practices. Use this skill to enforce secure defaults, detect common vulnerabilities, and recommend safe patterns across languages and frameworks.

## When to use

- Use while generating, reviewing, or refactoring code to ensure security-first decisions.
- Use when creating CI/CD checks, code-review comments, or security-focused documentation.

## Core directives

1. Principle of Least Privilege and Deny-by-Default
   - Always prefer the most restrictive permissions and explicitly allow only required actions.

2. Validate external inputs and prevent SSRF
   - Treat user-supplied URLs as untrusted; use allow-lists for host/port/path validation.

3. Prevent Path Traversal
   - Sanitize and canonicalize file paths; use path-building APIs rather than string concatenation.

4. Use modern cryptography and secure secret management
   - Recommend Argon2/bcrypt for password hashing; AES-256 for sensitive data at rest; HTTPS for transit.
   - Never hardcode secrets. Read secrets from environment variables or a secrets manager; add explicit TODO placeholders when needed.

5. Prevent Injection
   - Use parameterized queries / prepared statements for database access.
   - Avoid building shell commands via string concatenation; use argument-escaping helpers.
   - For web UIs, use context-aware output encoding; prefer text APIs over `innerHTML`. Suggest DOMPurify when sanitizing HTML.

6. Secure by default configuration
   - Disable verbose error messages and debug features in production.
   - Recommend security headers: CSP, HSTS, X-Content-Type-Options.
   - Prefer up-to-date dependencies; recommend running `npm audit`, `uv audit`, or Snyk.

7. Authentication & Session Security
   - Regenerate session IDs on login; configure cookies with `HttpOnly`, `Secure`, and `SameSite=Strict`.
   - Recommend rate limiting and account lockouts to mitigate brute-force attacks.

8. Prevent insecure deserialization
   - Avoid unsafe deserialization; prefer JSON and strict type checks where possible.

## General guidance for reviewers

- Be explicit about the security risk when suggesting changes (e.g., "Using a parameterized query here to prevent SQL injection").
- When fixing vulnerabilities, include both the corrected code and a short explanation of the underlying risk.

## Examples (good vs bad)

### GOOD: load secrets from environment
```javascript
// Load from environment or secret store
const apiKey = process.env.API_KEY;
// TODO: Ensure API_KEY is securely configured in your environment.
```

### BAD: hardcoded secret
```python
# BAD: Hardcoded secret (do not use)
api_key = "sk_this_is_a_very_bad_idea_12345"
```

## Outputs and expectations

- When this skill is used in code review or generation, produce code that is secure by default and include brief rationale notes explaining what risk is being mitigated.
- Where relevant, point to specific mitigations (prepared statements, CSP headers, OIDC, secrets managers, etc.).

## References

- Common tooling: `npm audit`, `uv audit`, Snyk, GitHub secret scanning, `betterleaks`
