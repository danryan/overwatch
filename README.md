# Overwatch

Overwatch is a suite of monitoring tools designed for flexibility in all aspects, from how data is collected to the way notifications are handled.

## Tools

* [Overwatch::Collection](https://github.com/danryan/overwatch-collection) - Metric collection and storage
* [Overwatch::Events](https://github.com/danryan/overwatch-events) - Threshold checking and event processing
* [Overwatch::Client](https://github.com/danryan/overwatch-client) - Client for metric collecting and reporting
* [Overwatch::CLI](https://github.com/danryan/overwatch-cli) - Command-line interface for configuration and data retrieval
* [Overwatch::Web](https://github.com/danryan/overwatch-web) - Web interface for configuration and data retrieval

## Impetus

"Why another monitoring app?" 

Honestly, I'm not happy with any other monitoring application out there. They're either  a royal pain to configure, setup and maintain, or sorely lack features that should exist in today's server landscape. Overwatch is the scratch to an itch I've had for a while.

## The Ideal Monitoring Service

### It must be easy.

One of the bigger pain points of monitoring applications is configuration and deployment. Management systems like Puppet or Chef have made this easier, but it’s still far from a perfect solution.

Deployment should be a drop-in process. Plugins should be simple to write. The API should adhere to current best practices. The system itself should not use proprietary or esoteric pieces.

### It must be extensible.

No two infrastructures are alike, and so the service that monitors yours should provide the freedom and the flexibility to instrument it as you see fit. The resources we want to instrument are different. Sometimes it’s a server; other times it’s an application. The system should make no assumptions.

### It must be performant.

Monitoring is an incredibly critical component of a well-designed infrastructure. If a monitoring service cannot identify and alert us to problems rapidly, then it is of little use. The system must be able to keep up with any and all demand and be impeccably stable.


### It must be useful.

The system should provide three distinct capabilities: the ability to observe, the ability to trend, and the ability to report. Metrics are a crucial part of being able to intelligently respond to an event. Trends help us discover weak spots that need fixing, or help us better plan capacity.

Reports are the most critical part, as well as the part most in need of an overhaul. What happens when a service fails? Who or what gets notified? How do our other systems react? The system should not only provide the typical meatcloud notifications, but also provide ways to interact with other systems.

## Terminology

This is but a brief overview. For more details, consult the wiki.

### Resource

A resource is a server upon which the client runs. Overwatch monitors a resource by parsing its snapshots

### Snapshot

A snapshot is a hash, a point in time of the resource's history, sent to Overwatch by the client. Overwatch runs a snapshot through all of a resource's checks.

### Check

A check is collection of rules. Checks can be associated with one or more resources.

### Rule

A rule is three parts: an attribute of the resource, a condition, and an expectation. Every snapshot is checked against the rules of a check. If a rule returns false, the check fails and an event is fired.

### Event

An event is the action that occurs if a check run fails. Events can send emails, text message, a payload to another web app, log to a server, and anything else you can think of. You can write any event type you want so long as it responds to `#run`.
