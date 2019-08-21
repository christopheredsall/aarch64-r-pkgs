# aarch64-r-pkgs

[![Build status](https://badge.buildkite.com/89378f203c5c234f50ec8afbc6c10a7339605db0106beb6277.svg)](https://buildkite.com/christopheredsall/aarch64-r-pks)

## Goal

The [CRAN](https://cran.r-project.org) provides build status for packages on various architectures e.g. 
[tidyr](https://cran.r-project.org/web/checks/check_results_tidyr.html). However, [aarch64](https://en.wikipedia.org/wiki/ARM_architecture#ARMv8_architectures) isn't on the list.

Given we have two aarch64 systems, [Isambard](https://gw4.ac.uk/isambard/) and 
[Catalyst](https://www.hpe.com/us/en/newsroom/press-release/2018/04/academia-and-industry-collaborate-to-drive-uk-supercomputer-adoption.html), 
what proportion of R packages that our users use are installable?

## CI systems

After attempting a gitlab runner, we are using a [Buildkite](https://buildkite.com) agent.

## Buildkite Agent installation

Create a buildkite account. Obtain the agent token

Follow the [Manual Installation](https://buildkite.com/docs/agent/v3/installation), getting the latest aarch64 binary from 
their [GitHub Releases](https://github.com/buildkite/agent/releases) page.

```ShellSession
user@host:~> mkdir -p ci/buildkite
user@host:~> cd ci/buildkite
user@host:~/ci/buildkite> wget https://github.com/buildkite/agent/releases/download/v3.13.2/buildkite-agent-linux-arm64-3.13.2.tar.gz
user@host:~/ci/buildkite> tar zxf buildkite-agent-linux-arm64-*.tar.gz
user@host:~/ci/buildkite> export TOKEN="<a-big-long-hex-string-put-yours-here>"
user@host:~/ci/buildkite> sed -i -e "/^token=/ s/xxx/${TOKEN}/" buildkite-agent.cfg
```

## Running the agent

```ShellSession
user@host:~> cd ~/ci/buildkite
user@host:~/ci/buildkite> screen -S buildkite-agent
user@host:~/ci/buildkite> ./buildkite-agent start --tags queue=queuename

  _           _ _     _ _    _ _                                _
 | |         (_) |   | | |  (_) |                              | |
 | |__  _   _ _| | __| | | ___| |_ ___    __ _  __ _  ___ _ __ | |_
 | '_ \| | | | | |/ _` | |/ / | __/ _ \  / _` |/ _` |/ _ \ '_ \| __|
 | |_) | |_| | | | (_| |   <| | ||  __/ | (_| | (_| |  __/ | | | |_
 |_.__/ \__,_|_|_|\__,_|_|\_\_|\__\___|  \__,_|\__, |\___|_| |_|\__|
                                                __/ |
 http://buildkite.com/agent                    |___/

2019-08-21 17:41:38 NOTICE Starting buildkite-agent v3.13.2 with PID: 31624
2019-08-21 17:41:38 NOTICE The agent source code can be found here: https://github.com/buildkite/agent
2019-08-21 17:41:38 NOTICE For questions and support, email us at: hello@buildkite.com
2019-08-21 17:41:38 INFO   Configuration loaded path=/home/user/ci/buildkite/buildkite-agent.cfg
2019-08-21 17:41:38 INFO   Registering agent with Buildkite...
2019-08-21 17:41:38 INFO   Successfully registered agent "host-1" with tags [queue=queuename]
2019-08-21 17:41:38 INFO   Starting 1 Agent(s)
2019-08-21 17:41:38 INFO   You can press Ctrl-C to stop the agents
2019-08-21 17:41:38 INFO   host-1 Connecting to Buildkite... 
2019-08-21 17:41:39 INFO   host-1 Waiting for work... 
```
Press CTRL-A, CTRL-D to detach from the screen session
