#!/bin/sh -l

if [ $GITHUB_ACTIONS ]
then
  git clone https://github.com/tryber/sd-03-week3-html-css-project-tests.git /project-tests
  rm -rf /project-tests/.git
  cp -r /project-tests/* .
  mv requirements_mapping.json /capybara_evaluator_action/
  mkdir /capybara_evaluator_action/spec/sd-03-week3-html-css-project -p
  mv ./* /capybara_evaluator_action/spec/sd-03-week3-html-css-project/
  cd /capybara_evaluator_action
else
  mv /capybara_evaluator_action/spec/tryber/sd-03-week3-html-css-project/requirements_mapping.json .
fi

bundle exec rspec --format json --out evaluation.json

ruby evaluator.rb

if [ $? != 0 ]
then
  echo "Execution error"
  exit 1
fi

echo ::set-output name=evaluation::`cat evaluation.json | base64 -w 0`
echo ::set-output name=result::`cat result.json | base64 -w 0`
echo ::set-output name=pr-number::$(echo "$GITHUB_REF" | awk -F / '{print $3}')
