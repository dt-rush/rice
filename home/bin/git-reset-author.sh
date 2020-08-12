#!/bin/sh

# Credits: http://stackoverflow.com/a/750191

git filter-branch -f --env-filter "
    GIT_AUTHOR_NAME='dt-rush'
    GIT_AUTHOR_EMAIL='nick.eightfold.hunter@gmail.com'
    GIT_COMMITTER_NAME='dt-rush'
    GIT_COMMITTER_EMAIL='nick.eightfold.hunter@gmail.com'
  " HEAD
