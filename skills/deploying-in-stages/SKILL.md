---
name: deploying-in-stages
description: Use when a merged change or new release must reach a deployed environment, including bumping a version pin, image tag, or config bundle in a deployment repository
---

# Deploying in Stages

1. Update the open deployment PR that already moves this component's version, even if it pins an old version; never leave two open PRs moving one pin.
   If you cannot push to it, open a replacement and close the old one with a link.
2. Pin only an artifact whose build finished.
3. Deploy staging; check readiness, new log errors, and the feature itself.
4. If your human partner's request names production, deploy it after staging passes; otherwise ask once, with the staging evidence.
5. Restart production only when no users, jobs, or requests are in flight, or after saying what will be cut.
6. Verify the deployed version, health, and logs over a window; report per environment.

## Red Flags

| Thought | Reality |
|---|---|
| "It's someone else's PR, so I'll leave it and open my own" | Two open PRs moving one pin conflict. Update it with a comment, or replace it and close it with a link. |
| "I'll open a second PR for the production values" | Production goes into the same PR after the go-ahead. |
