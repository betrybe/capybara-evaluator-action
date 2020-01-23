#!/bin/sh -l

if [ $GITHUB_ACTIONS ]
then
  mv requirements_mapping.json /capybara_evaluator_action/
  mkdir /capybara_evaluator_action/spec/$GITHUB_REPOSITORY -p
  mv ./* /capybara_evaluator_action/spec/$GITHUB_REPOSITORY/
  cd /capybara_evaluator_action
fi

bundle exec rspec --format json --out evaluation.json

if [ $GITHUB_ACTIONS ]
then
  ruby evaluator.rb
  echo ::set-output name=result::`cat result.json | base64 -w 0`
else
  echo ::set-output name=evaluation::`cat evaluation.json | base64 -w 0`
fi
