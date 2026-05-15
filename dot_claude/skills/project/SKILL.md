---
name: project
description: Manage project tracking documentation
argument-hint: [project-name]
allowed-tools:
  - Read
  - Write
---

# Project Skill

This skill is used to manage project related documentation when working on a new project.

## Project Document Storage

Project documentation is stored in `~/Notes/Projects`. Create the directory if it does not exist.

## Creating a new project

Projects are stored in a directory under the parent project document directory. The naming scheme for the directory should normalize the project name using kebab case.

Each project should have a top level README.md file that has the name of the project and a description of the project that's automatically updated when work is done within the scope of the project.

Each project should have a PLAN.md file that contains the general plan for the project.

Each project should have a TASKLIST.md file that contains tasks that need to be completed to finish the project. This should be treated as a checklist where tasks are checked when they are completed.
