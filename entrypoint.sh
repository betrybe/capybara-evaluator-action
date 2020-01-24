#!/bin/sh -l

if [ $GITHUB_ACTIONS ]
then
  git clone https://github.com/$GITHUB_REPOSITORY-tests.git tests-repo
  mv tests-repo/requirements_mapping.json /capybara_evaluator_action/
  mkdir /capybara_evaluator_action/spec/project-repo -p
  mv ./* /capybara_evaluator_action/spec/project-repo/
  cd /capybara_evaluator_action
else
  mv /capybara_evaluator_action/spec/$GITHUB_REPOSITORY/$GITHUB_REPOSITORY-tests/requirements_mapping.json .
fi

GITHUB_REPOSITORY=project-repo bundle exec rspec --format json --out evaluation.json

ruby evaluator.rb

if [ $? != 0 ]
then
  echo "Execution error"
  exit 1
fi

echo ::set-output name=evaluation::`cat evaluation.json | base64 -w 0`
echo ::set-output name=result::`cat result.json | base64 -w 0`
echo ::set-output name=pr-number::$(echo "$GITHUB_REF" | awk -F / '{print $3}')
