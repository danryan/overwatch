# Overwatch

## Overview

Overwatch is a monitoring application designed for flexibility in all aspects, from how data is collected to the way notifications are handled.

## Terminology

This is but a brief overview. For more details, consult the wiki.

### Node

A node is a server upon which the client runs. Overwatch monitors a node by parsing its snapshots

### Snapshot

A snapshot is a hash, a point in time of the node's history, sent to Overwatch by the client. Overwatch runs a snapshot through all of a node's checks.

### Check

A check is collection of rules. Checks can be associated with one or more nodes.

### Rule

A rule is three parts: an attribute of the node, a condition, and an expectation. Every snapshot is checked against the rules of a check. If a rule returns false, the check fails and an event is fired.

### Event

An event is the action that occurs if a check run fails. Events can send emails, text message, a payload to another web app, log to a server, and anything else you can think of. You can write any event type you want so long as it responds to `#run`.

## Example Run


    # Let's fudge a snapshot payload:

    data = { 
      :redis => {
        :version => "2.2.4"
      },
      :load_average => { 
        :one_min => "1.01", 
        :five_min => "0.96", 
        :fifteen_min => "0.72"
      }
    }

    # Add a new node, host.example.com
    node = Overwatch::Node.create(:name => "host.example.com")
    
    # Send the node a snapshot
    node.snapshots << Overwatch::Snapshot.create(:raw_data => data, :node => node)

    # Add a new check to the node
    node.checks << Overwatch::Check.create
    check = node.checks.first
    
    # Set some rules on this check
    check.rules << Overwatch::Rule.create(:attr => "load_average.one_min").less_than(4)
    check.rules << Overwatch::Rule.create(:attr => "redis.version").is("2.2.4")

    # Now we need an email event in case something goes wrong
    check.events << Overwatch::Event::STDOUT.create
    
    # Let's run the checks!
    node.run_checks
    
    # Call the check run directly (node.last_update is the last snapshot to be added)
    check.run(node.last_update)
    
    # This should return true. Now let's introduce some failure
    
    check.rules << Overwatch::Rule.create(:attr => "load_average.five_min").less_than(0.50)
    
    # The check failed, so an event was fired. You should see something like this:
    # holy science!!
    # load_average.five_min is less than 0.5 failed on host.example.com!
    # What we checked: load_average.five_min is less than 0.5
    # What we saw: 0.96
    
## Installation

    git clone git://github.com/danryan/overwatch.git
    cd overwatch
    rackup
    
More to come!