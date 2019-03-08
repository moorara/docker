workflow "Build and Push" {
  on = "push"
  resolves = [ "Build tools", "Build golang", "Build node" ]
}

action "Build tools" {
  uses = "moorara/actions/docker@master"
  runs = "make"
  args = "build-tools"
}

action "Build golang" {
  needs = [ "Build tools" ]
  uses = "moorara/actions/docker@master"
  runs = "make"
  args = "build-golang"
}

action "Build node" {
  needs = [ "Build tools" ]
  uses = "moorara/actions/docker@master"
  runs = "make"
  args = "build-node"
}
