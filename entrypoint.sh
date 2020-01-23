#!/bin/sh -l

time=$(date)

if [ $GITHUB_ACTIONS ]; then
  mv requirements_mapping.json /capybara_evaluator_action/
  mkdir /capybara_evaluator_action/spec/$GITHUB_REPOSITORY -p
  mv ./* /capybara_evaluator_action/spec/$GITHUB_REPOSITORY/
  cd /capybara_evaluator_action
fi

bundle exec rspec --format json --out evaluation.json

if [ $GITHUB_ACTIONS ]; then ruby evaluator.rb; fi

echo ::set-output name=time::$time
echo ::set-output name=evaluation-in-base64::`cat evaluation.json | base64`
