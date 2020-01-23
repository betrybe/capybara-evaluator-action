#!/bin/sh -l

if [ $GITHUB_ACTIONS ]
then
  mv requirements_mapping.json /capybara_evaluator_action/
  mkdir /capybara_evaluator_action/spec/$GITHUB_REPOSITORY -p
  mv ./* /capybara_evaluator_action/spec/$GITHUB_REPOSITORY/
  cd /capybara_evaluator_action
else
  mv /capybara_evaluator_action/spec/$GITHUB_REPOSITORY/requirements_mapping.json .
fi

bundle exec rspec --format json --out evaluation.json

ruby evaluator.rb

if [ $? != 0 ]
then
  echo "Execution error"
  exit 1
fi

echo ::set-output name=result::`cat result.json | base64 -w 0`
echo ::set-output name=evaluation::`cat evaluation.json | base64 -w 0`
